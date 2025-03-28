<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Not logged in']);
    exit;
}

$db = new mysqli('localhost', 'root', '', 'mprlendingdb');

if ($db->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed']);
    exit;
}

$stmt = $db->prepare("SELECT status FROM users WHERE id = ?");
$stmt->bind_param("i", $_SESSION['user_id']);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

if ($user && $user['status'] === 'disabled') {
    // Clear session
    session_destroy();
    
    echo json_encode([
        'status' => 'disabled',
        'message' => 'Your account has been disabled. Please contact an administrator.'
    ]);
} else {
    echo json_encode(['status' => 'active']);
}

$stmt->close();
$db->close();