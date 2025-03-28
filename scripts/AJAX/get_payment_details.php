<?php
require_once 'db_connect.php';

header('Content-Type: application/json');

$reference_no = $_GET['reference_no'] ?? '';

try {
    $stmt = $conn->prepare("SELECT payment_amount FROM payment WHERE reference_no = ?");
    $stmt->bind_param("s", $reference_no);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $payment = $result->fetch_assoc();
        echo json_encode([
            'status' => 'success',
            'amount' => $payment['payment_amount']
        ]);
    } else {
        throw new Exception("Payment not found");
    }
} catch (Exception $e) {
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}

$stmt->close();
$conn->close();
?>