<?php
session_start();
header('Content-Type: application/json');

$db = new mysqli('localhost', 'root', '', 'mprlendingdb');

if ($db->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['user_id'])) {
    $user_id = intval($_POST['user_id']);
    
    // Add audit log
    $performed_by = $_SESSION['fullname'] ?? 'System';
    $action = "Force logout user ID: $user_id";
    $category = "User Management";
    
    $stmt = $db->prepare("INSERT INTO audit_logs (date, time, performed_by, action, category) VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)");
    $stmt->bind_param("sss", $performed_by, $action, $category);
    $stmt->execute();
    
    // If the logged-in user is being disabled, destroy their session
    if ($_SESSION['user_id'] == $user_id) {
        session_destroy();
    }
    
    echo json_encode(['status' => 'success', 'message' => 'User logged out successfully']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
}

$db->close();