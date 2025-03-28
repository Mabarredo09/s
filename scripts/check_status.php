<?php
function checkUserStatus($db, $user_id) {
    $stmt = $db->prepare("SELECT status FROM users WHERE id = ?");
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();
    
    if ($user['status'] === 'disabled') {
        session_destroy();
        header('Location: login.php?error=account_disabled');
        exit();
    }
}
?>