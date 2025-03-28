<?php
session_start();
header('Content-Type: application/json');

$db = new mysqli('localhost', 'root', '', 'mprlendingdb');

if ($db->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';

    // Check if account exists and get status
    $stmt = $db->prepare("SELECT id, fullname, email, password, role, status FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    if ($user) {
        // Check if account is disabled
        if ($user['status'] === 'disabled') {
            echo json_encode([
                'status' => 'error',
                'message' => 'Your account has been disabled. Please contact an administrator.'
            ]);
            exit;
        }

        // Verify password
        if (password_verify($password, $user['password'])) {
            // Set session variables
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['fullname'] = $user['fullname'];
            $_SESSION['email'] = $user['email'];
            $_SESSION['role'] = $user['role'];

            // Add login audit log
            $action = $user['fullname'] . " logged in";
            $category = "User Activity";
            
            $audit_sql = "INSERT INTO audit_logs (date, time, performed_by, action, category) 
                         VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)";
            $audit_stmt = $db->prepare($audit_sql);
            $audit_stmt->bind_param("sss", $user['fullname'], $action, $category);
            $audit_stmt->execute();

            echo json_encode([
                'status' => 'success',
                'redirect' => 'dashboard.php'
            ]);
        } else {
            echo json_encode([
                'status' => 'error',
                'message' => 'Invalid email or password'
            ]);
        }
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => 'Invalid email or password'
        ]);
    }
    
    $stmt->close();
} else {
    echo json_encode([
        'status' => 'error',
        'message' => 'Invalid request method'
    ]);
}

$db->close();
?>