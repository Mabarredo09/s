<?php
session_start();
header('Content-Type: application/json');

$db = new mysqli('localhost', 'root', '', 'mprlendingdb');

if ($db->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $db->connect_error]));
}

function addAuditLog($db, $action) {
    $performed_by = $_SESSION['fullname'] ?? 'Unknown User';
    $category = "User Management"; // Set fixed category for user management actions
    
    $sql = "INSERT INTO audit_logs (date, time, performed_by, action, category) 
            VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)";
    $stmt = $db->prepare($sql);
    $stmt->bind_param("sss", $performed_by, $action, $category);
    $stmt->execute();
    $stmt->close();
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $action = $_POST['action'] ?? '';

    try {
        if ($action === "toggle_status") {
            if (!isset($_POST['user_id']) || !isset($_POST['status'])) {
                throw new Exception("Missing required parameters");
            }

            $user_id = intval($_POST['user_id']);
            $new_status = $_POST['status'];

            // Validate status value
            if (!in_array($new_status, ['active', 'disabled'])) {
                throw new Exception("Invalid status value");
            }

            // Update user status
            $stmt = $db->prepare("UPDATE users SET status = ? WHERE id = ?");
            $stmt->bind_param("si", $new_status, $user_id);
            
            if (!$stmt->execute()) {
                throw new Exception("Failed to update user status");
            }

            // Add audit log
            $action_description = "Updated user status to: " . $new_status;
            addAuditLog($db, $action_description);

            echo json_encode([
                "status" => "success",
                "message" => "User status updated successfully"
            ]);
            exit;
        }

        $db->begin_transaction();
        
        $action = $_POST["action"] ?? '';

        if ($action === "delete") {
            // Delete User
            if (!isset($_POST["user_id"])) {
                throw new Exception("User ID is required");
            }

            $user_id = intval($_POST["user_id"]);
            
            // Get user details before deletion for audit log
            $get_user = $db->prepare("SELECT fullname, profile_picture FROM users WHERE id = ?");
            if (!$get_user) {
                throw new Exception("Database prepare error");
            }

            $get_user->bind_param("i", $user_id);
            $get_user->execute();
            $result = $get_user->get_result();
            $user = $result->fetch_assoc();
            $get_user->close();

            if (!$user) {
                throw new Exception("User not found");
            }

            // Delete the user's profile picture if it exists
            if (!empty($user['profile_picture']) && $user['profile_picture'] !== 'uploads/defaultprof.jpg') {
                if (file_exists($user['profile_picture'])) {
                    unlink($user['profile_picture']);
                }
            }

            // Delete the user
            $stmt = $db->prepare("DELETE FROM users WHERE id = ?");
            if (!$stmt) {
                throw new Exception("Database prepare error");
            }

            $stmt->bind_param("i", $user_id);

            if (!$stmt->execute()) {
                throw new Exception("Error deleting user");
            }

            // Add audit log
            $action_desc = "Deleted user: " . $user['fullname'];
            addAuditLog($db, $action_desc);
            
            $db->commit();
            
            echo json_encode([
                "status" => "success", 
                "message" => "User deleted successfully"
            ]);
            
            $stmt->close();
        } elseif ($action === "edit") {
            // Edit User
            if (!isset($_POST["user_id"], $_POST["fullname"], $_POST["email"], $_POST["role"])) {
                throw new Exception("Missing required fields");
            }

            $user_id = intval($_POST["user_id"]);
            $fullname = trim($_POST["fullname"]);
            $email = trim($_POST["email"]);
            $role = trim($_POST["role"]);
            $password = isset($_POST["password"]) ? trim($_POST["password"]) : null;

            // Validate role
            if (!in_array($role, ['user', 'admin'])) {
                throw new Exception("Invalid role specified");
            }

            // Get old user details for audit log
            $get_old = $db->prepare("SELECT fullname, email, role FROM users WHERE id = ?");
            $get_old->bind_param("i", $user_id);
            $get_old->execute();
            $old_user = $get_old->get_result()->fetch_assoc();
            $get_old->close();

            if (!$old_user) {
                throw new Exception("User not found");
            }

            // Check if email exists for another user
            $check_email = $db->prepare("SELECT id FROM users WHERE email = ? AND id != ?");
            $check_email->bind_param("si", $email, $user_id);
            $check_email->execute();
            $check_email->store_result();

            if ($check_email->num_rows > 0) {
                $check_email->close();
                throw new Exception("Email already exists");
            }
            $check_email->close();

            // Prepare base query
            $sql = "UPDATE users SET fullname = ?, email = ?, role = ?";
            $types = "sss";
            $params = [$fullname, $email, $role];

            // Add password to query if provided
            if ($password !== null && $password !== '') {
                $sql .= ", password = ?";
                $types .= "s";
                $hashed_password = password_hash($password, PASSWORD_DEFAULT);
                $params[] = $hashed_password;
            }

            $sql .= " WHERE id = ?";
            $types .= "i";
            $params[] = $user_id;

            $update = $db->prepare($sql);
            $update->bind_param($types, ...$params);

            if (!$update->execute()) {
                throw new Exception("Failed to update user");
            }

            // Add audit log for changes
            $changes = [];
            if ($old_user['fullname'] !== $fullname) {
                $changes[] = "name from '{$old_user['fullname']}' to '{$fullname}'";
            }
            if ($old_user['email'] !== $email) {
                $changes[] = "email from '{$old_user['email']}' to '{$email}'";
            }
            if ($old_user['role'] !== $role) {
                $changes[] = "role from '{$old_user['role']}' to '{$role}'";
            }
            if ($password !== null && $password !== '') {
                $changes[] = "password";
            }

            if (!empty($changes)) {
                $action_desc = "Updated user: " . implode(", ", $changes);
                addAuditLog($db, $action_desc);
            }

            $db->commit();
            
            echo json_encode([
                "status" => "success",
                "message" => "User updated successfully"
            ]);

            $update->close();
        } elseif ($action === "toggle_status") {
            if (!isset($_POST["user_id"], $_POST["status"])) {
                throw new Exception("Missing required fields");
            }

            $user_id = intval($_POST["user_id"]);
            $status = $_POST["status"];

            // Validate status
            if (!in_array($status, ['active', 'disabled'])) {
                throw new Exception("Invalid status specified");
            }

            // Update user status
            $update = $db->prepare("UPDATE users SET status = ? WHERE id = ?");
            $update->bind_param("si", $status, $user_id);

            if (!$update->execute()) {
                throw new Exception("Failed to update user status");
            }

            // Get all active sessions for this user
            $sessions_query = $db->prepare("SELECT session_id FROM user_sessions WHERE user_id = ?");
            $sessions_query->bind_param("i", $user_id);
            $sessions_query->execute();
            $sessions_result = $sessions_query->get_result();
            
            $sessions = [];
            while ($row = $sessions_result->fetch_assoc()) {
                $sessions[] = $row['session_id'];
            }

            // Add audit log
            $action_desc = "Updated user status to: " . $status;
            addAuditLog($db, $action_desc);

            echo json_encode([
                "status" => "success",
                "message" => "User status updated successfully",
                "sessions" => $sessions
            ]);

            $update->close();
        }
    } catch (Exception $e) {
        $db->rollback();
        echo json_encode([
            "status" => "error",
            "message" => $e->getMessage()
        ]);
    } finally {
        $db->close();
    }
}
?>