// Dropdown functionality for all pages
document.addEventListener('DOMContentLoaded', function() {
    const profile = document.querySelector('.profile');
    const dropdownContent = document.querySelector('.profile-dropdown-content');
    const arrowIcon = document.querySelector('.arrow-down-icon');

    // Toggle dropdown on profile click
    profile.addEventListener('click', function(e) {
        e.stopPropagation();
        const isVisible = dropdownContent.classList.contains('show');
        
        // Toggle dropdown visibility
        dropdownContent.classList.toggle('show');
        
        // Rotate arrow icon
        arrowIcon.style.transform = isVisible ? 'rotate(0deg)' : 'rotate(180deg)';
        arrowIcon.style.transition = 'transform 0.3s ease';
    });

    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
        if (!profile.contains(e.target)) {
            dropdownContent.classList.remove('show');
            arrowIcon.style.transform = 'rotate(0deg)';
        }
    });

    // Prevent dropdown links from immediately closing
    dropdownContent.addEventListener('click', function(e) {
        if (e.target.tagName === 'A') {
            e.stopPropagation();
            window.location.href = e.target.href;
        }
    });
});