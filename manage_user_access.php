<?php
require_once 'scripts/check_admin.php';
checkAdminAccess();

// Start the session to access user data


// Database connection
$db = new mysqli('localhost', 'root', '', 'mprlendingdb');

// Check connection
if ($db->connect_error) {
    die("Connection failed: " . $db->connect_error);
}
require_once 'scripts/check_status.php';
checkUserStatus($db, $_SESSION['user_id']);


// Fetch the logged-in user's details
$user_id = $_SESSION['user_id']; // Ensure this session variable is set
$sql = "SELECT fullname, profile_picture FROM users WHERE id = ?";  // Fetch fullname too
$stmt = $db->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

// Set profile picture and fullname variables
$fullname = isset($user['fullname']) ? $user['fullname'] : "User"; // Default to "User" if fullname is not set
$profilePicturePath = isset($user['profile_picture']) && !empty($user['profile_picture']) ? $user['profile_picture'] : 'uploads/defaultprof.jpg';

$stmt->close();
$db->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS -->
    <link rel="stylesheet" href="styles/manage_user_access.css">
    <link rel="stylesheet" href="styles/shared.css">
  
     <!-- Google Fonts -->
     <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Source+Serif+4:ital,opsz,wght@0,8..60,200..900;1,8..60,200..900&display=swap" rel="stylesheet">
    <!-- SweetAlert2 -->
     <script src="node_modules/sweetalert2/dist/sweetalert2.all.min.js"></script>
     <!-- Zooming -->
     <script src="node_modules/zooming/build/zooming.min.js"></script>
     <script src="scripts/shared.js" defer></script>

    <title>Dashboard</title>
    <script>
        const currentUserId = <?php echo $_SESSION['user_id']; ?>;
    </script>
</head>

<body>
    
<nav>
        <div class="dashboard-container">

            <div class="dashboard-header">
                <div class="logo-container">
                    <img src="images/dashboard.png" alt="Dashboard Logo">
                </div>
                <div class="dashboard-header-right">
                <div class="dashboard-header-right-content">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor" d="M3 13h8V3H3zm0 8h8v-6H3zm10 0h8V11h-8zm0-18v6h8V3z" />
                        </svg>
                        <p>Dashboard</p>
                    </div>
                    <div class="notification">
                    <div class="notification-icon">
                        <svg  xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor"
                                d="M12 22c1.1 0 2-.9 2-2h-4a2 2 0 0 0 2 2m6-6v-5c0-3.07-1.64-5.64-4.5-6.32V4c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v.68C7.63 5.36 6 7.92 6 11v5l-2 2v1h16v-1z" />
                        </svg>
                        <p>Notification</p>
                    </div>
                    <div class="notification-dropdown">
                        <div class="notification-dropdown-content">
                            <p>No new notifications</p>
                            <a href="#">View all notifications</a>
                        </div>
                            
                    </div>
                </div>
                <div class="profile">
                    <img src="<?php echo $profilePicturePath; ?>" alt="Profile Picture">
                    <div class="profile-dropdown">
                        <p>Welcome, <?php echo $fullname; ?></p>
                        <div class="profile-dropdown-content">
                            <a href="profile.php">Profile</a>
                            <?php if(isset($_SESSION['role']) && $_SESSION['role'] === 'admin'): ?>
                                <a href="manage_user_access.php">Manage User Access</a>
                                <a href="audit_logs.php">Audit Logs</a>
                            <?php endif; ?>
                            <a href="logout.php">Logout</a>
                        </div>
                    </div>
                    <svg class="arrow-down-icon" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <path fill="currentColor" d="M7.41 8.59L12 13.17l4.59-4.58L18 10l-6 6l-6-6z" />
                        </svg>
                </div>
            </div>
    </nav>


    <div class="manage-user-access-header">
        <h1>Manage User Access</h1>
    </div>

    <div class="manage-user-access-container">

        <div class="manage-user-access-buttons">
            <!-- <div class="manage-user-access-search">
                <input type="text" placeholder="Search for user">
                <button>Search</button> -->
                
                <button class="addbutton">Add User</button>
<!--                 
                <button>Filter <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                        <path fill="currentColor" d="M10 18h4v-2h-4zM3 6v2h18V6zm3 7h12v-2H6z" />
                    </svg></button> -->
            </div>
               
        </div>
           
<!-- Add User Modal -->
<div id="addUserModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Add User</h2>
        <form id="addUserForm" enctype="multipart/form-data">
            <div class="input-row">
                <label class="fn" for="fullname">Full Name:</label>
                <input type="text" id="fullname" name="fullname" required>
                <br>
                <br>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <br>
                <br>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <br>
                <br>

                <label for="role">Role:</label>
                <select id="role" name="role" required>
                    <option value="user">User</option>
                   
                    <option value="admin">Admin</option>
                </select>
                <br>
                <br>

                <label for="profile_picture">Profile Picture:</label>
                <input type="file" id="profile_picture" name="profile_picture" accept="image/*">
                <br>
                <br>
                <button class="addbutton1" type="submit">Add User</button>
            </div>
        </form>
    </div>
</div>
<div class="manage-user-access-add">

            </div>
        </div>
        <div class="manage-user-access-table">
        
<table>
    <tr>
        <th>User ID</th>
        <th>Profile Picture</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Role</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
    <?php
    $db = new mysqli('localhost', 'root', '', 'mprlendingdb');
    // Modify the SQL query to include status
    $sql = "SELECT id, fullname, email, profile_picture, role, status FROM users WHERE id != ?";
    $stmt = $db->prepare($sql);
    $stmt->bind_param("i", $_SESSION['user_id']);
    $stmt->execute();
    $result = $stmt->get_result();

    // Inside your table generation code
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $statusClass = $row['status'] === 'disabled' ? 'user-disabled' : 'user-active';
            $statusText = $row['status'] === 'disabled' ? 'Enable' : 'Disable';
            
            echo "<tr>";
            echo "<td>{$row['id']}</td>";
            echo "<td><img src='{$row['profile_picture']}' width='60' height='60'></td>";
            echo "<td class='fullname'>{$row['fullname']}</td>";
            echo "<td class='email'>{$row['email']}</td>";
            echo "<td class='role'>{$row['role']}</td>";
            echo "<td class='status'><span class='status-badge {$statusClass}'>" . ucfirst($row['status']) . "</span></td>";
            echo "<td class='table-button-group'>
                    <button class='edit-button' data-id='{$row['id']}'>Edit</button>
                    <button class='status-toggle-button {$statusClass}' 
                            data-id='{$row['id']}' 
                            data-status='{$row['status']}'>
                        {$statusText}
                    </button>
                    <button class='delete-button' data-id='{$row['id']}'>Remove</button>
                  </td>";
            echo "</tr>";
        }
    
    } else {
        echo "<tr><td colspan='5'>No users found</td></tr>";
    }
    $stmt->close();
    $db->close();
    ?>
</table>

            </table>
        </div>
    </div>
    
    <script src="./scripts/manage_user_access.js"></script>
    <script>
        // Check user status on every page load and interaction
        async function checkUserStatus() {
            try {
                const response = await fetch('scripts/AJAX/check_user_status.php');
                const data = await response.json();
                
                if (data.status === 'disabled') {
                    await Swal.fire({
                        title: 'Account Disabled',
                        text: 'Your account has been disabled. Please contact an administrator.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    window.location.href = 'index.php?error=account_disabled';
                }
            } catch (error) {
                console.error('Error checking status:', error);
            }
        }

        // Check on page load
        document.addEventListener('DOMContentLoaded', checkUserStatus);

        // Check before any form submission
        document.addEventListener('submit', async function(e) {
            e.preventDefault();
            if (await checkUserStatus()) {
                e.target.submit();
            }
        });

        // Check on any button click or link click
        document.addEventListener('click', async function(e) {
            if (e.target.tagName === 'A' || e.target.tagName === 'BUTTON' || e.target.type === 'submit') {
                e.preventDefault();
                await checkUserStatus();
            }
        }, true);

        // Periodic check every 5 seconds
        setInterval(checkUserStatus, 5000);
    </script>
</body>

</html>