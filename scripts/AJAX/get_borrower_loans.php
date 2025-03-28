<?php
header('Content-Type: application/json');
require_once 'db_connect.php';

try {
    if (!isset($_GET['borrowerId'])) {
        throw new Exception('Borrower ID is required');
    }

    $borrowerId = filter_var($_GET['borrowerId'], FILTER_VALIDATE_INT);
    if (!$borrowerId) {
        throw new Exception('Invalid borrower ID');
    }

    $sql = "SELECT id, reference_no, loan_amount, loan_date 
            FROM loan 
            WHERE borrower_id = ? 
            ORDER BY loan_date DESC";
            
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('i', $borrowerId);
    $stmt->execute();
    $result = $stmt->get_result();
    $loans = $result->fetch_all(MYSQLI_ASSOC);

    echo json_encode($loans);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
?>