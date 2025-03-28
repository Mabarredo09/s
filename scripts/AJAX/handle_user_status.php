<?php
session_start();
header('Content-Type: application/json');

$db = new mysqli('localhost', 'root', '', 'mprlendingdb');

if ($db->connect_error) {
    die(json_encode(['status' => 'error', 'message' => 'Connection failed']));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_id = $_POST['user_id'] ?? null;
    $status = $_POST['status'] ?? null;

    if (!$user_id || !$status) {
        echo json_encode(['status' => 'error', 'message' => 'Missing parameters']);
        exit;
    }

    try {
        $db->begin_transaction();

        // Update user status
        $stmt = $db->prepare("UPDATE users SET status = ? WHERE id = ?");
        $stmt->bind_param("si", $status, $user_id);
        $stmt->execute();

        // If disabling user, invalidate their sessions
        if ($status === 'disabled') {
            $stmt = $db->prepare("DELETE FROM user_sessions WHERE user_id = ?");
            $stmt->bind_param("i", $user_id);
            $stmt->execute();
        }

        // Log the action
        $performed_by = $_SESSION['fullname'] ?? 'System';
        $action = "Changed user status to: $status for user ID: $user_id";
        $stmt = $db->prepare("INSERT INTO audit_logs (date, time, performed_by, action, category) VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, 'User Management')");
        $stmt->bind_param("ss", $performed_by, $action);
        $stmt->execute();

        $db->commit();

        echo json_encode([
            'status' => 'success',
            'message' => 'Status updated successfully'
        ]);
    } catch (Exception $e) {
        $db->rollback();
        echo json_encode([
            'status' => 'error',
            'message' => $e->getMessage()
        ]);
    }
}

$db->close();