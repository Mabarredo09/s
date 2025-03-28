let profileDropdown = document.querySelector(".profile-dropdown");
let arrowDownIcon = document.querySelector(".arrow-down-icon");
let editProfileButton = document.getElementById("edit-profile-btn");
let saveProfileButton = document.getElementById("save-profile-btn");
let inputs = document.querySelectorAll(".inputs");
const zooming = new Zooming();
const notificationIcon = document.querySelector(".notification-icon");
const notificationDropdown = document.querySelector(".notification-dropdown");

let dashboardHeader = document.querySelector(".dashboard-header-right-content");

profileDropdown.addEventListener("mouseover", function () {
  console.log("hovered");
  arrowDownIcon.style.transform = "rotate(180deg)";
  arrowDownIcon.style.transition = "transform 0.5s ease";
});

profileDropdown.addEventListener("mouseout", function () {
  arrowDownIcon.style.transform = "rotate(0deg)";
  arrowDownIcon.style.transition = "transform 0.5s ease";
});

notificationIcon.addEventListener("click", function () {
  notificationDropdown.style.display =
    notificationDropdown.style.display === "block" ? "none" : "block";
});

dashboardHeader.addEventListener("click", function () {
  window.location.href = "dashboard.php";
});
// Close the dropdown if the user clicks outside of it
window.addEventListener("click", function (event) {
  if (!event.target.closest(".notification")) {
    if (notificationDropdown.style.display === "block") {
      notificationDropdown.style.display = "none";
    }
  }
});
document.addEventListener("DOMContentLoaded", function() {
    // Get all required elements
    const elements = {
        addUserForm: document.getElementById("addUserForm"),
        modal: document.getElementById("addUserModal"),
        openModalBtn: document.querySelector(".addbutton"),
        closeModalBtn: document.querySelector("#addUserModal .close"),
        searchInput: document.querySelector(".search-input"),
        searchResults: document.querySelector(".search-results-dropdown")
    };

    // Initialize modal functionality if elements exist
    if (elements.modal && elements.addUserForm) {
        if (elements.openModalBtn) {
            elements.openModalBtn.addEventListener("click", () => {
                elements.modal.style.display = "block";
            });
        }

        if (elements.closeModalBtn) {
            elements.closeModalBtn.addEventListener("click", () => {
                elements.modal.style.display = "none";
                elements.addUserForm.reset();
            });
        }

        // Form submission handler
        elements.addUserForm.addEventListener("submit", async function(e) {
            e.preventDefault();
            
            const submitBtn = this.querySelector('button[type="submit"]');
            if (submitBtn) submitBtn.disabled = true;

            try {
                const formData = new FormData(this);
                const response = await fetch("add_user.php", {
                    method: "POST",
                    body: formData
                });

                const text = await response.text();
                let data;

                try {
                    // Clean any HTML/PHP notices from the response
                    const jsonStart = text.indexOf('{');
                    const jsonEnd = text.lastIndexOf('}') + 1;
                    const jsonString = text.slice(jsonStart, jsonEnd);
                    data = JSON.parse(jsonString);
                } catch (error) {
                    console.error("Server response:", text);
                    throw new Error("Invalid server response");
                }

                if (data.status === "success") {
                    await Swal.fire({
                        title: "Success!",
                        text: data.message,
                        icon: "success"
                    });
                    
                    elements.modal.style.display = "none";
                    this.reset();
                    location.reload();
                } else {
                    throw new Error(data.message || "Unknown error occurred");
                }
            } catch (error) {
                console.error("Error:", error);
                await Swal.fire({
                    title: "Error!",
                    text: error.message || "Something went wrong while adding the user.",
                    icon: "error"
                });
            } finally {
                if (submitBtn) submitBtn.disabled = false;
            }
        });
    }

    // Initialize search functionality if elements exist
    if (elements.searchInput && elements.searchResults) {
        const searchInput = elements.searchInput;
        const searchResults = elements.searchResults;

        function performSearch() {
            const searchTerm = searchInput.value.trim();
            if (searchTerm.length < 1) {
                searchResults.style.display = "none";
                return;
            }

            fetch("scripts/AJAX/search.php", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: `search=${encodeURIComponent(searchTerm)}`
            })
            .then(response => response.json())
            .then(data => {
                searchResults.innerHTML = "";
                if (data.status === "success" && data.data.length > 0) {
                    data.data.forEach(user => {
                        const resultItem = document.createElement("div");
                        resultItem.className = "search-result-item";
                        resultItem.textContent = user.fullname;
                        resultItem.addEventListener("click", () => {
                            searchInput.value = user.fullname;
                            searchResults.style.display = "none";
                        });
                        searchResults.appendChild(resultItem);
                    });
                    searchResults.style.display = "block";
                } else {
                    searchResults.innerHTML = '<div class="search-result-item">No results found</div>';
                    searchResults.style.display = "block";
                }
            })
            .catch(error => console.error("Search error:", error));
        }

        searchInput.addEventListener("input", performSearch);
        document.addEventListener("click", (e) => {
            if (!searchResults.contains(e.target) && e.target !== searchInput) {
                searchResults.style.display = "none";
            }
        });
    }

    // Handle Delete Button
    document.querySelectorAll(".delete-button").forEach(button => {
        button.addEventListener("click", async function() {
            const userId = this.getAttribute("data-id");
            
            try {
                const result = await Swal.fire({
                    title: "Are you sure?",
                    text: "You won't be able to revert this!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#d33",
                    cancelButtonColor: "#3085d6",
                    confirmButtonText: "Yes, Remove it!"
                });

                if (result.isConfirmed) {
                    const response = await fetch("manage_user.php", {
                        method: "POST",
                        headers: { 
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: `action=delete&user_id=${userId}`
                    });

                    const data = await response.json();
                    
                    if (data.status === "success") {
                        await Swal.fire(
                            "Deleted!",
                            "User has been deleted.",
                            "success"
                        );
                        location.reload();
                    } else {
                        throw new Error(data.message || "Error deleting user");
                    }
                }
            } catch (error) {
                console.error("Error:", error);
                await Swal.fire(
                    "Error!",
                    error.message || "Failed to delete user",
                    "error"
                );
            }
        });
    });

    // Update the edit button handler
    document.querySelectorAll(".edit-button").forEach(button => {
        button.addEventListener("click", async function() {
            const row = this.closest("tr");
            const userId = this.getAttribute("data-id");
            const fullname = row.querySelector(".fullname").textContent;
            const email = row.querySelector(".email").textContent;
            const currentRole = row.querySelector(".role").textContent;

            try {
                const { value: formValues } = await Swal.fire({
                    title: 'Edit User',
                    html: `
                        <div class="edit-user-form">
                            <div class="form-group">
                                <label for="editFullname">Full Name</label>
                                <input 
                                    type="text" 
                                    id="editFullname" 
                                    class="swal2-input" 
                                    value="${fullname}" 
                                    placeholder="Enter full name"
                                    required
                                >
                            </div>
                            
                            <div class="form-group">
                                <label for="editEmail">Email</label>
                                <input 
                                    type="email" 
                                    id="editEmail" 
                                    class="swal2-input" 
                                    value="${email}" 
                                    placeholder="Enter email"
                                    required
                                >
                            </div>

                            <div class="form-group">
                                <label for="editPassword">New Password (leave blank to keep current)</label>
                                <input 
                                    type="password" 
                                    id="editPassword" 
                                    class="swal2-input" 
                                    placeholder="Enter new password"
                                >
                            </div>

                            <div class="form-group">
                                <label for="editRole">Role</label>
                                <select 
                                    id="editRole" 
                                    class="swal2-input"
                                    required
                                >
                                    <option value="user" ${currentRole === 'user' ? 'selected' : ''}>User</option>
                                    <option value="admin" ${currentRole === 'admin' ? 'selected' : ''}>Admin</option>
                                </select>
                            </div>
                        </div>
                    `,
                    focusConfirm: false,
                    showCancelButton: true,
                    confirmButtonText: 'Save Changes',
                    cancelButtonText: 'Cancel',
                    preConfirm: () => {
                        const newFullname = document.getElementById('editFullname').value.trim();
                        const newEmail = document.getElementById('editEmail').value.trim();
                        const newPassword = document.getElementById('editPassword').value.trim();
                        const newRole = document.getElementById('editRole').value;

                        if (!newFullname || !newEmail) {
                            Swal.showValidationMessage('Name and email are required');
                            return false;
                        }

                        if (!newEmail.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
                            Swal.showValidationMessage('Please enter a valid email address');
                            return false;
                        }

                        return { 
                            fullname: newFullname, 
                            email: newEmail, 
                            password: newPassword,
                            role: newRole 
                        };
                    }
                });

                if (formValues) {
                    const formData = new FormData();
                    formData.append('action', 'edit');
                    formData.append('user_id', userId);
                    formData.append('fullname', formValues.fullname);
                    formData.append('email', formValues.email);
                    formData.append('role', formValues.role);
                    if (formValues.password) {
                        formData.append('password', formValues.password);
                    }

                    const response = await fetch("manage_user.php", {
                        method: "POST",
                        body: formData
                    });

                    const data = await response.json();

                    if (data.status === "success") {
                        await Swal.fire({
                            title: "Success!",
                            text: "User details have been updated",
                            icon: "success"
                        });
                        location.reload();
                    } else {
                        throw new Error(data.message || "Failed to update user");
                    }
                }
            } catch (error) {
                console.error("Error:", error);
                await Swal.fire({
                    title: "Error!",
                    text: error.message || "Failed to update user",
                    icon: "error"
                });
            }
        });
    });

    // Add this to your existing DOMContentLoaded event listener
    document.querySelectorAll(".status-toggle-button").forEach(button => {
        button.addEventListener("click", async function() {
            const userId = this.getAttribute("data-id");
            const currentStatus = this.getAttribute("data-status");
            const newStatus = currentStatus === 'active' ? 'disabled' : 'active';
            const actionText = currentStatus === 'active' ? 'disable' : 'enable';

            try {
                const result = await Swal.fire({
                    title: `Are you sure?`,
                    text: `Do you want to ${actionText} this user?`,
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: currentStatus === 'active' ? "#d33" : "#3085d6",
                    cancelButtonColor: "#6c757d",
                    confirmButtonText: `Yes, ${actionText} user`
                });

                if (result.isConfirmed) {
                    const response = await fetch("manage_user.php", {
                        method: "POST",
                        headers: { 
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: `action=toggle_status&user_id=${userId}&status=${newStatus}`
                    });

                    const data = await response.json();
                    
                    if (data.status === "success") {
                        await Swal.fire(
                            "Updated!",
                            `User has been ${actionText}d.`,
                            "success"
                        );
                        location.reload();
                    } else {
                        throw new Error(data.message || `Error ${actionText}ing user`);
                    }
                }
            } catch (error) {
                console.error("Error:", error);
                await Swal.fire(
                    "Error!",
                    error.message || `Failed to ${actionText} user`,
                    "error"
                );
            }
        });
    });

    // Replace the existing status toggle button handler
    document.querySelectorAll('.status-toggle-button').forEach(button => {
        button.addEventListener('click', async function() {
            const userId = this.getAttribute('data-id');
            const currentStatus = this.getAttribute('data-status');
            const newStatus = currentStatus === 'active' ? 'disabled' : 'active';
            const actionText = currentStatus === 'active' ? 'disable' : 'enable';

            try {
                const result = await Swal.fire({
                    title: 'Are you sure?',
                    text: `Do you want to ${actionText} this user?`,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: currentStatus === 'active' ? '#dc3545' : '#28a745',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: `Yes, ${actionText} user`
                });

                if (result.isConfirmed) {
                    const response = await fetch('scripts/AJAX/handle_user_status.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `user_id=${userId}&status=${newStatus}`
                    });

                    const data = await response.json();

                    if (data.status === 'success') {
                        // Update UI immediately without page reload
                        const row = this.closest('tr');
                        const statusCell = row.querySelector('.status');
                        const statusBadge = statusCell.querySelector('.status-badge');
                        
                        // Update status badge
                        statusBadge.textContent = newStatus.charAt(0).toUpperCase() + newStatus.slice(1);
                        statusBadge.className = `status-badge user-${newStatus}`;
                        
                        // Update button
                        this.textContent = newStatus === 'disabled' ? 'Enable' : 'Disable';
                        this.className = `status-toggle-button user-${newStatus}`;
                        this.setAttribute('data-status', newStatus);

                        // Force logout if user is disabled
                        if (newStatus === 'disabled') {
                            // Broadcast the status change to other tabs
                            localStorage.setItem('userStatusChanged', JSON.stringify({
                                userId: userId,
                                status: newStatus,
                                timestamp: new Date().getTime()
                            }));

                            // Force logout the disabled user
                            await fetch('scripts/AJAX/force_logout.php', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: `user_id=${userId}`
                            });
                        }

                        await Swal.fire({
                            title: 'Success!',
                            text: `User has been ${actionText}d!`,
                            icon: 'success'
                        });
                    } else {
                        throw new Error(data.message || `Error ${actionText}ing user`);
                    }
                }
            } catch (error) {
                console.error('Error:', error);
                await Swal.fire({
                    title: 'Error!',
                    text: error.message,
                    icon: 'error'
                });
            }
        });
    });

    // Add event listener for storage changes to handle real-time updates
    window.addEventListener('storage', function(e) {
        if (e.key === 'userStatusChanged') {
            const data = JSON.parse(e.newValue);
            // Check if this is a recent change (within last 5 seconds)
            if (new Date().getTime() - data.timestamp < 5000) {
                // If this is the disabled user's session, redirect to logout
                if (data.status === 'disabled' && currentUserId === data.userId) {
                    window.location.href = 'logout.php';
                }
                // Otherwise, refresh the page to show updated status
                else {
                    location.reload();
                }
            }
        }
    });

    // Add event listeners for status toggle buttons
    document.querySelectorAll('.status-toggle-button').forEach(button => {
        button.addEventListener('click', async function() {
            const userId = this.getAttribute('data-id');
            const currentStatus = this.getAttribute('data-status');
            const newStatus = currentStatus === 'active' ? 'disabled' : 'active';
            const action = currentStatus === 'active' ? 'disable' : 'enable';

            try {
                const result = await Swal.fire({
                    title: 'Are you sure?',
                    text: `Do you want to ${action} this user?`,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: currentStatus === 'active' ? '#dc3545' : '#28a745',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: `Yes, ${action} user`
                });

                if (result.isConfirmed) {
                    const formData = new FormData();
                    formData.append('action', 'toggle_status');
                    formData.append('user_id', userId);
                    formData.append('status', newStatus);

                    const response = await fetch('manage_user.php', {
                        method: 'POST',
                        body: formData
                    });

                    const data = await response.json();

                    if (data.status === 'success') {
                        await Swal.fire({
                            title: 'Success!',
                            text: `User has been ${action}d!`,
                            icon: 'success'
                        });
                        location.reload();
                    } else {
                        throw new Error(data.message || 'Failed to update status');
                    }
                }
            } catch (error) {
                console.error('Error:', error);
                await Swal.fire({
                    title: 'Error!',
                    text: error.message,
                    icon: 'error'
                });
            }
        });
    });
});

// Update the handleStatusToggle function
async function handleStatusToggle(userId, currentStatus) {
    const newStatus = currentStatus === 'active' ? 'disabled' : 'active';
    const actionText = currentStatus === 'active' ? 'disable' : 'enable';

    try {
        const result = await Swal.fire({
            title: 'Are you sure?',
            text: `Do you want to ${actionText} this user?`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: currentStatus === 'active' ? '#dc3545' : '#28a745',
            cancelButtonColor: '#6c757d',
            confirmButtonText: `Yes, ${actionText} user`
        });

        if (result.isConfirmed) {
            const response = await fetch('scripts/AJAX/handle_user_status.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `user_id=${userId}&status=${newStatus}`
            });

            const data = await response.json();

            if (data.status === 'success') {
                // Force logout if user is disabled
                if (newStatus === 'disabled') {
                    await fetch('scripts/AJAX/force_logout.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `user_id=${userId}`
                    });
                }

                await Swal.fire({
                    title: 'Success!',
                    text: `User has been ${actionText}d!`,
                    icon: 'success'
                });

                // Reload the page after status change
                location.reload();
            } else {
                throw new Error(data.message || `Failed to ${actionText} user`);
            }
        }
    } catch (error) {
        console.error('Error:', error);
        await Swal.fire({
            title: 'Error!',
            text: error.message || `Failed to ${actionText} user`,
            icon: 'error'
        });
    }
}

// Add this function to check user status continuously
function checkUserStatus() {
    fetch('scripts/AJAX/check_user_status.php')
        .then(response => response.json())
        .then(data => {
            if (data.status === 'disabled') {
                window.location.href = 'login.php?error=account_disabled';
            }
        })
        .catch(error => console.error('Error checking status:', error));
}

// Add global click handler for disabled users
document.addEventListener('click', async function(e) {
    try {
        const response = await fetch('scripts/AJAX/check_user_status.php');
        const data = await response.json();
        
        if (data.status === 'disabled') {
            e.preventDefault();
            e.stopPropagation();
            window.location.href = 'login.php?error=account_disabled';
            return false;
        }
    } catch (error) {
        console.error('Error checking status:', error);
    }
}, true);

// Check status every 5 seconds
setInterval(checkUserStatus, 5000);

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

// Add this function after the existing code
function checkUserStatus() {
    fetch('scripts/AJAX/check_user_status.php')
        .then(response => response.json())
        .then(data => {
            if (data.status === 'disabled') {
                window.location.href = 'logout.php';
            }
        })
        .catch(error => console.error('Error checking status:', error));
}

// Check status every 30 seconds
setInterval(checkUserStatus, 10000);

// Add this function to check status before any action
async function checkBeforeAction(event) {
    try {
        const response = await fetch('scripts/AJAX/check_user_status.php');
        const data = await response.json();
        
        if (data.status === 'disabled') {
            event.preventDefault();
            event.stopPropagation();
            
            await Swal.fire({
                title: 'Account Disabled',
                text: 'Your account has been disabled. Please contact an administrator.',
                icon: 'error',
                confirmButtonText: 'OK'
            });
            
            window.location.href = 'index.php?error=account_disabled';
            return false;
        }
        return true;
    } catch (error) {
        console.error('Error checking status:', error);
        return true;
    }
}

// Add global click handler
document.addEventListener('click', async function(e) {
    if (e.target.tagName === 'A' || e.target.tagName === 'BUTTON' || e.target.type === 'submit') {
        const canProceed = await checkBeforeAction(e);
        if (!canProceed) {
            e.preventDefault();
            e.stopPropagation();
        }
    }
}, true);

// Update status check interval
setInterval(async () => {
    const canProceed = await checkBeforeAction({ preventDefault: () => {}, stopPropagation: () => {} });
    if (!canProceed) {
        window.location.href = 'index.php?error=account_disabled';
    }
}, 5000);