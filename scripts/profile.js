let profileDropdown = document.querySelector('.profile-dropdown');
let arrowDownIcon = document.querySelector('.arrow-down-icon'); 
let editProfileButton = document.getElementById('edit-profile-btn');
let saveProfileButton = document.getElementById('save-profile-btn');
let inputs = document.querySelectorAll('.inputs');
const zooming = new Zooming();
const notificationIcon = document.querySelector('.notification-icon');
const notificationDropdown = document.querySelector('.notification-dropdown');
let dashboardHeader = document.querySelector(".dashboard-header-right-content");

let profilePicturePreview = document.getElementById('profile-picture-preview');
let profilePictureUpload = document.getElementById('profile-picture-upload');
let uploadConfirmBtn = document.getElementById('upload-profile-btn');
let uploadCancelBtn = document.getElementById('cancel-upload-profile-btn');

// Handle profile dropdown interaction
profileDropdown.addEventListener('mouseover', function(){
    arrowDownIcon.style.transform = 'rotate(180deg)';
    arrowDownIcon.style.transition = 'transform 0.5s ease';
});

profileDropdown.addEventListener('mouseout', function(){
    arrowDownIcon.style.transform = 'rotate(0deg)';
    arrowDownIcon.style.transition = 'transform 0.5s ease';
});

// Toggle notification dropdown
notificationIcon.addEventListener('click', function() {
    notificationDropdown.style.display = notificationDropdown.style.display === 'block' ? 'none' : 'block';
});

// Close the notification dropdown when clicking outside
window.addEventListener('click', function(event) {
    if (!event.target.closest('.notification')) {
        if (notificationDropdown.style.display === 'block') {
            notificationDropdown.style.display = 'none';
        }
    }
});

// Zooming for profile picture
zooming.listen('#profile-picture-preview');

// Handle profile picture upload and preview
profilePictureUpload.addEventListener('change', function() {
    const file = profilePictureUpload.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            profilePicturePreview.src = e.target.result;
            
            // Enable the confirm button and show cancel button
            uploadConfirmBtn.disabled = false;
            uploadConfirmBtn.style.backgroundColor = '#1E3E62';
            uploadConfirmBtn.style.cursor = 'pointer';
            uploadCancelBtn.style.display = 'block';
        };
        reader.readAsDataURL(file);
        zooming.listen('#profile-picture-preview');
    }
});

// Cancel the profile picture upload
uploadCancelBtn.addEventListener('click', function(e) {
    e.preventDefault();
    profilePictureUpload.value = ''; // Clear the file input
    profilePicturePreview.src = originalProfilePicture; // Reset to original picture
    uploadConfirmBtn.disabled = true;
    uploadConfirmBtn.style.backgroundColor = '#c1c1c1';
    uploadConfirmBtn.style.cursor = 'not-allowed';
    uploadCancelBtn.style.display = 'none';
});

// Replace the existing upload confirmation handler
uploadConfirmBtn.addEventListener('click', function(e) {
    e.preventDefault();
    
    // Get the form and submit it
    const form = document.getElementById('profile-picture-form');
    const formData = new FormData(form);

    fetch('update_profile.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        if (data.includes('success')) {
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: 'Profile picture updated successfully!',
                confirmButtonText: 'OK'
            }).then(() => {
                window.location.reload();
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: 'Failed to update profile picture',
                confirmButtonText: 'OK'
            });
        }
    })
    .catch(error => {
        console.error('Error:', error);
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'An error occurred while updating profile picture',
            confirmButtonText: 'OK'
        });
    });
});

// Store original profile picture source
const originalProfilePicture = profilePicturePreview.src;

// Replace the existing edit profile button handler
editProfileButton.addEventListener('click', function() {
    const isEditing = editProfileButton.innerHTML === 'Edit Profile';
    
    // Toggle button states
    editProfileButton.innerHTML = isEditing ? 'Cancel' : 'Edit Profile';
    editProfileButton.style.backgroundColor = isEditing ? '#FF0000' : '#1E3E62';
    saveProfileButton.disabled = !isEditing;
    saveProfileButton.style.backgroundColor = isEditing ? '#1E3E62' : '#c1c1c1';
    saveProfileButton.style.cursor = isEditing ? 'pointer' : 'not-allowed';
    
    // Toggle input fields
    inputs.forEach(input => {
        input.disabled = !isEditing;
        if (!isEditing) {
            input.value = input.defaultValue; // Reset to original value on cancel
        }
    });
});

// Replace the existing save profile button handler
saveProfileButton.addEventListener('click', function(e) {
    e.preventDefault();
    
    // Basic validation
    const fullname = document.getElementById('Name').value.trim();
    const email = document.getElementById('Email').value.trim();
    const password = document.getElementById('Password').value;
    const confirmPassword = document.getElementById('ConfirmPassword').value;
    
    // Validate fields
    if (!fullname || !email) {
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'Name and email are required fields',
            confirmButtonText: 'OK'
        });
        return;
    }
    
    if (password !== confirmPassword) {
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'Passwords do not match',
            confirmButtonText: 'OK'
        });
        return;
    }
    
    // Get the form and submit it
    const form = document.getElementById('profile-form');
    const formData = new FormData(form);
    formData.append('update_details', '1'); // Add flag for profile update
    
    fetch('update_profile.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        if (data.includes('success')) {
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: 'Profile updated successfully!',
                confirmButtonText: 'OK'
            }).then(() => {
                window.location.reload();
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error!',
                text: 'Failed to update profile',
                confirmButtonText: 'OK'
            });
        }
    })
    .catch(error => {
        console.error('Error:', error);
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'An error occurred while updating profile',
            confirmButtonText: 'OK'
        });
    });
});

dashboardHeader.addEventListener("click", function () {
    window.location.href = "dashboard.php";
});

function fetchNotifications(showAll = false) {
    fetch('scripts/AJAX/notification.php')
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                const notificationDropdown = document.querySelector('.notification-dropdown-content');
                
                if (data.count > 0) {
                    // Update notification icon to show count
                    const notificationCount = document.createElement('span');
                    notificationCount.className = 'notification-count';
                    notificationCount.textContent = data.count;
                    document.querySelector('.notification-icon').appendChild(notificationCount);

                    // Clear existing notifications
                    notificationDropdown.innerHTML = '';

                    // Determine how many notifications to show
                    const notificationsToShow = showAll ? data.notifications : data.notifications.slice(0, 3);

                    // Add notifications
                    notificationsToShow.forEach(notification => {
                        const notifItem = document.createElement('div');
                        notifItem.className = 'notification-item';
                        
                        // Add urgency class based on days remaining
                        if (notification.days_remaining <= 7) {
                            notifItem.classList.add('urgent');
                        } else if (notification.days_remaining <= 14) {
                            notifItem.classList.add('warning');
                        }
                        
                        notifItem.innerHTML = `
                            <p>${notification.message}</p>
                            <small>${notification.type}</small>
                        `;
                        notificationDropdown.appendChild(notifItem);
                    });

                    // Add "View More" button if there are more than 3 notifications
                    if (!showAll && data.notifications.length > 3) {
                        const viewMoreBtn = document.createElement('div');
                        viewMoreBtn.className = 'view-more-btn';
                        viewMoreBtn.innerHTML = `
                            <button>
                                View More (${data.notifications.length - 3} more)
                            </button>
                        `;
                        viewMoreBtn.addEventListener('click', () => {
                            fetchNotifications(true);
                        });
                        notificationDropdown.appendChild(viewMoreBtn);
                    }

                    // Add "Show Less" button when showing all notifications
                    if (showAll && data.notifications.length > 3) {
                        const showLessBtn = document.createElement('div');
                        showLessBtn.className = 'view-more-btn';
                        showLessBtn.innerHTML = '<button>Show Less</button>';
                        showLessBtn.addEventListener('click', () => {
                            fetchNotifications(false);
                        });
                        notificationDropdown.appendChild(showLessBtn);
                    }
                } else {
                    notificationDropdown.innerHTML = '<p>No new notifications</p>';
                }
            }
        })
        .catch(error => console.error('Error:', error));
}

// Call fetchNotifications when page loads and every 5 minutes
document.addEventListener('DOMContentLoaded', function() {
    fetchNotifications();
    setInterval(fetchNotifications, 300000); // 5 minutes
});