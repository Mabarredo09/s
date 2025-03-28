<?php
session_start();
require_once 'scripts/AJAX/db_connect.php';

// Get parameters from URL
$borrowerId = $_GET['borrowerId'] ?? null;
$loanId = $_GET['loanId'] ?? null;

if (!$borrowerId || !$loanId) {
    die("Missing required parameters");
}

// Fetch loan and borrower details
$sql = "SELECT l.*, b.*, a.* 
        FROM loan l 
        JOIN borrowers b ON l.borrower_id = b.id 
        LEFT JOIN addresses a ON b.address_id = a.id
        WHERE l.id = ? AND l.borrower_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ii", $loanId, $borrowerId);
$stmt->execute();
$result = $stmt->get_result();
$loan = $result->fetch_assoc();

if (!$loan) {
    die("Loan not found");
}

// Fetch loan schedules and payments
$schedulesSql = "SELECT 
    ls.*,
    p.payment_amount,
    p.principal_amount as paid_principal,
    p.interest_amount as paid_interest,
    p.payment_date,
    p.reference_no as payment_ref 
FROM loan_schedules ls 
LEFT JOIN payment p ON p.borrower_id = ? 
    AND DATE(p.payment_date) = DATE(ls.due_date) 
    AND p.payment_amount = ls.total_amount
WHERE ls.loan_id = ?
ORDER BY ls.due_date";

$stmt = $conn->prepare($schedulesSql);
$stmt->bind_param("ii", $borrowerId, $loanId);
$stmt->execute();
$schedules = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Calculate totals
$totalPayments = 0;
$totalPaidInterest = 0;
$totalPaidPrincipal = 0;
foreach ($schedules as $schedule) {
    if ($schedule['status'] === 'paid') {
        $totalPayments += floatval($schedule['payment_amount'] ?? 0);
        $totalPaidInterest += floatval($schedule['paid_interest'] ?? 0);
        $totalPaidPrincipal += floatval($schedule['paid_principal'] ?? 0);
    }
}

$outstandingBalance = $loan['loan_amount'] - $totalPayments;

// Calculate total interest
$totalInterest = 0;
foreach ($schedules as $schedule) {
    $totalInterest += floatval($schedule['interest_amount'] ?? 0);
}
$totalLoanWithInterest = $loan['loan_amount'] + $totalInterest;
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Statement of Account</title>
    <link rel="stylesheet" href="styles/soa.css">
    
</head>
<body>
    <div class="soa-container">
        <img src="images/logo.png" alt="MPR Logo" class="logo">
        <button onclick="window.print()" class="print-btn">Print SOA</button>
        <div class="soa-header">
            <h1>Statement of Account</h1>
            <div class="info-container">
                <div class="borrower-info">
                    <p>Name: <?php echo htmlspecialchars($loan['first_name'] . ' ' . $loan['surname']); ?></p>
                    <p>Address: <?php echo htmlspecialchars($loan['home_no'] . ', ' . $loan['street'] . ', ' . $loan['barangay'] . ', ' . $loan['city'] . ', ' . $loan['province'] . ', ' . $loan['region']); ?></p>
                    <p>Contact No: <?php echo htmlspecialchars($loan['contact_number']); ?></p>
                </div>
                <div class="loan-details">
                    <p>Reference No: <?php echo htmlspecialchars($loan['reference_no']); ?></p>
                    <p>Loan Date: <?php echo date('M d, Y', strtotime($loan['loan_date'])); ?></p>
                    <p>Interest Rate: <?php echo $loan['interest_rate']; ?>%</p>
                    <p>Term: <?php echo $loan['term_months']; ?> months</p>
                    <p>Total Loan Amount: ₱<?php echo number_format($totalLoanWithInterest, 2); ?></p>
                </div>
            </div>
        </div>
        
        <div class="payment-schedule">
            <h2>Payment Schedule</h2>
            <table>
                <thead>
                    <tr>
                        <th>Due Date</th>
                        <th>Payment Amount</th>
                        <th>Principal</th>
                        <th>Interest</th>
                        <th>Payment Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($schedules as $schedule): ?>
                    <tr>
                        <td><?php echo date('M d, Y', strtotime($schedule['due_date'])); ?></td>
                        <td>₱<?php echo number_format($schedule['total_amount'], 2); ?></td>
                        <td>₱<?php echo number_format($schedule['principal_amount'] ?? 0, 2); ?></td>
                        <td>₱<?php echo number_format($schedule['interest_amount'] ?? 0, 2); ?></td>
                        <td><?php echo $schedule['payment_date'] ? date('M d, Y', strtotime($schedule['payment_date'])) : '-'; ?></td>
                        <td><?php echo ucfirst($schedule['status']); ?></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <div class="summary">
            <h2>Payment Summary</h2>
            <p>Total Loan Amount: ₱<?php echo number_format($totalLoanWithInterest, 2); ?></p>
            <p>Total Payments Made: ₱<?php echo number_format($totalPayments, 2); ?></p>
            <p>Total Interest Paid: ₱<?php echo number_format($totalPaidInterest, 2); ?></p>
            <p>Outstanding Balance: ₱<?php echo number_format($totalLoanWithInterest - $totalPayments, 2); ?></p>
        </div>
    </div>
</body>
</html>