let profileDropdown = document.querySelector(".profile-dropdown");
let arrowDownIcon = document.querySelector(".arrow-down-icon");
let editProfileButton = document.getElementById("edit-profile-btn");
let saveProfileButton = document.getElementById("save-profile-btn");
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
$(document).ready(function() {
    // Update the filter dropdown HTML with correct category values
    $('#filter-audit-logs-btn').after(`
        <div class="category-filter-dropdown" style="display: none; position: absolute; background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.2); border-radius: 4px; padding: 8px; z-index: 1000;">
            <select id="categoryFilter" style="width: 200px; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                <option value="">All Categories</option>
                <option value="User Management">User Management</option>
                <option value="User Authentication">User Authentication</option>
                <option value="Borrower Management Logs">Borrower Management Logs</option>
                <option value="Loan Management Logs">Loan Management Logs</option>
            </select>
        </div>
    `);

    // Initialize DataTable with server-side processing
    const auditTable = $('#auditLogsTable').DataTable({
        ajax: {
            url: 'audit_logs.php',
            data: function(d) {
                d.category = $('#categoryFilter').val();
            },
            dataSrc: 'data'
        },
        columns: [
            { 
                data: 'date',
                render: function(data) {
                    return moment(data).format('MMMM DD, YYYY');
                }
            },
            { 
                data: 'time',
                render: function(data) {
                    return moment(data, 'HH:mm:ss').format('hh:mm:ss A');
                }
            },
            { data: 'performed_by' },
            { data: 'action' },
            { data: 'category' }
        ],
        order: [[0, 'desc'], [1, 'desc']],
        responsive: true,
        pageLength: 10,
        dom: '<"top"<"search-container"f><"button-container">>rt<"bottom"lip>',
        language: {
            search: "_INPUT_",
            searchPlaceholder: "Search audit logs..."
        },
        initComplete: function() {
            // Move the buttons to the custom button container
            $('.button-container').append($('#filter-audit-logs-btn'));
            $('.button-container').append($('#export-audit-logs-btn'));
            $('.button-container').append($('#print-audit-logs-btn'));
            
            // Add custom class to search input
            $('.dataTables_filter input')
                .addClass('audit-search-input')
                .attr('style', 'width: 400px !important; height: 40px !important');
        }
    });

    // Add custom filtering function
    $.fn.dataTable.ext.search.push(
        function(settings, data, dataIndex) {
            const selectedCategory = $('#categoryFilter').val();
            const rowCategory = data[4]; // Category is the 5th column (index 4)
            
            if (!selectedCategory || selectedCategory === '') {
                return true;
            }
            
            return rowCategory === selectedCategory;
        }
    );

    // Toggle filter dropdown
    $('#filter-audit-logs-btn').on('click', function(e) {
        e.stopPropagation();
        $('.category-filter-dropdown').toggle();
    });

    // Update the category filter change handler
    $('#categoryFilter').on('change', function() {
        const selectedCategory = $(this).val();
        
        // Reload table with selected category
        auditTable.ajax.reload();
        
        // Update filter button text
        $('#filter-audit-logs-btn').html(`
            <i class="fas fa-filter"></i> ${selectedCategory || 'Filter'}
        `);
    });

    // Close dropdown when clicking outside
    $(document).on('click', function(e) {
        if (!$(e.target).closest('.category-filter-dropdown, #filter-audit-logs-btn').length) {
            $('.category-filter-dropdown').hide();
        }
    });

    // Add some CSS for the dropdown
    $('<style>')
        .text(`
            .category-filter-dropdown {
                margin-top: 40px;
                right: 160px;
            }
            #categoryFilter:focus {
                outline: none;
                border-color: #4CAF50;
            }
        `)
        .appendTo('head');

    // Filter button functionality
    $('#filter-audit-logs-btn').on('click', function() {
        // Implement filter logic here
    });

    // Export button functionality
    $('#export-audit-logs-btn').on('click', function() {
        // Create a CSV export
        let csvContent = "data:text/csv;charset=utf-8,";
        
        // Add headers
        const headers = ['Date', 'Time', 'Performed By', 'Action', 'Category'];
        csvContent += headers.join(",") + "\n";
        
        // Add data
        auditTable.data().each(function(row) {
            const rowData = [
                moment(row.date).format('YYYY-MM-DD'),
                row.time,
                row.performed_by,
                row.action,
                row.category
            ];
            csvContent += rowData.join(",") + "\n";
        });
        
        // Create download link
        const encodedUri = encodeURI(csvContent);
        const link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", `Audit_${moment().format('MMDDYY')}.csv`);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    });

    // Update the print button functionality with improved print styles
    $('#print-audit-logs-btn').on('click', function() {
        const currentFilter = $('#categoryFilter').val();
        const filterText = currentFilter ? `Category: ${currentFilter}` : 'All Categories';
        
        const printStyles = `
            <style type="text/css" media="print">
                @page {
                    size: A4 landscape;
                    margin: 1cm;
                }
                
                body * {
                    visibility: hidden;
                }
                
                .print-container, .print-container * {
                    visibility: visible;
                }
                
                .print-container {
                    position: absolute;
                    left: 0;
                    top: 0;
                    width: 100%;
                    padding: 20px;
                }
                
                .print-header {
                    display: block !important;
                    margin-bottom: 30px;
                }
                
                #auditLogsTable {
                    width: 100% !important;
                    margin: 0 !important;
                    border-collapse: collapse !important;
                    font-size: 11pt !important;
                }
                
                #auditLogsTable th {
                    background-color: #0B192C !important;
                    color: white !important;
                    padding: 10px !important;
                    font-weight: bold !important;
                    text-align: left !important;
                    border: 1px solid #ddd !important;
                    -webkit-print-color-adjust: exact !important;
                    print-color-adjust: exact !important;
                }
                
                #auditLogsTable td {
                    padding: 8px !important;
                    border: 1px solid #ddd !important;
                    text-align: left !important;
                    vertical-align: top !important;
                    word-wrap: break-word !important;
                    max-width: none !important;
                }
                
                .dataTables_info, 
                .dataTables_paginate,
                .dataTables_length,
                .dataTables_filter {
                    display: none !important;
                }
            </style>
        `;
        
        // Create print container with table clone
        const tableClone = $('#auditLogsTable').clone();
        const printContent = `
            <div class="print-container">
                <div class="print-header">
                    <h1 style="text-align: center; margin-bottom: 10px; color: #0B192C;">Audit Logs Report</h1>
                    <p style="text-align: center; margin-bottom: 20px; color: #666;">
                        ${filterText} - Generated on ${moment().format('MMMM DD, YYYY')}
                    </p>
                </div>
                ${tableClone.prop('outerHTML')}
            </div>
        `;
        
        // Add print elements
        $('head').append(printStyles);
        $('body').append(printContent);
        
        // Print the document
        window.print();
        
        // Clean up after printing
        setTimeout(() => {
            $('head style[media="print"]').remove();
            $('.print-container').remove();
        }, 100);
    });

    // Refresh table every 30 seconds
    setInterval(function() {
        auditTable.ajax.reload(null, false);
    }, 30000);
});
// Add this at the beginning of your file
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