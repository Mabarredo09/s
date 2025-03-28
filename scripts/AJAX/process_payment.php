<?php
require_once 'db_connect.php';

header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);
$reference_no = $data['reference_no'] ?? '';
$amount = $data['amount'] ?? 0;

function calculateCustomPayment($currentBalance, $customAmount, $interestRate, $remainingMonths)
{
    if ($remainingMonths <= 0) {
        throw new Exception("Remaining months must be greater than zero.");
    }

    $monthlyInterestRate = $interestRate / 100 / 12;

    // Calculate regular monthly payment for reference
    $regularMonthlyPayment = calculateMonthlyPayment($currentBalance, $interestRate, $remainingMonths);
    $minInterestAmount = $currentBalance * $monthlyInterestRate;

    // Validate payment amount
    if ($customAmount < $minInterestAmount) {
        throw new Exception("Payment must cover at least the interest amount: " . number_format($minInterestAmount, 2));
    }

    // Calculate maximum allowed payment
    // $maxPayment = $currentBalance + $minInterestAmount;
    // if ($customAmount > $maxPayment) {
    //     throw new Exception("Payment cannot exceed balance plus interest: " . number_format($maxPayment, 2));
    // }

    // Split payment into interest and principal
    $interestAmount = $minInterestAmount;
    $principalAmount = min($customAmount - $interestAmount, $currentBalance);
    $newBalance = $currentBalance - $principalAmount;

    // Calculate term reduction
    $termReduction = 0;
    if ($newBalance <= 0) {
        // Full payoff
        $termReduction = $remainingMonths;
    } else if ($principalAmount > ($regularMonthlyPayment - $minInterestAmount)) {
        // Extra principal payment
        $regularPrincipalPortion = $regularMonthlyPayment - $minInterestAmount;
        $extraPrincipal = $principalAmount - $regularPrincipalPortion;
        $termReduction = 1 + floor($extraPrincipal / $regularPrincipalPortion);
    } else {
        // Regular or partial payment
        $termReduction = 1;
    }

    return [
        'principal_amount' => $principalAmount,
        'interest_amount' => $interestAmount,
        'total_amount' => $customAmount,
        'term_reduction' => $termReduction,
        'remaining_balance' => $newBalance,
        'min_required' => $minInterestAmount,
        'regular_payment' => $regularMonthlyPayment
    ];
}

function calculateMonthlyPayment($loanAmount, $interestRate, $termMonths)
{
    if ($termMonths <= 0) {
        throw new Exception("Term months must be greater than zero.");
    }

    $monthlyInterestRate = $interestRate / 100 / 12;
    return $loanAmount * ($monthlyInterestRate / (1 - pow(1 + $monthlyInterestRate, -$termMonths)));
}

try {
    $conn->begin_transaction();

    // Get loan details first
    $stmt0 = $conn->prepare("
        SELECT lb.loan_balance, lb.month_term_duration, l.interest_rate, l.reference_no
        FROM loan_balance lb
        JOIN loan l ON lb.loan_reference_no = l.reference_no
        JOIN payment p ON lb.borrower_id = p.borrower_id
        WHERE p.reference_no = ?
        AND lb.status = '1'
        AND lb.loan_balance > 0
        LIMIT 1
    ");
    $stmt0->bind_param("s", $reference_no);
    $stmt0->execute();
    $loanDetails = $stmt0->get_result()->fetch_assoc();

    // Calculate payment breakdown
    $paymentBreakdown = calculateCustomPayment(
        $loanDetails['loan_balance'],
        $amount,
        $loanDetails['interest_rate'],
        $loanDetails['month_term_duration']
    );

    $principalAmount = $paymentBreakdown['principal_amount'];
    $interestAmount = $paymentBreakdown['interest_amount'];
    $totalAmount = $paymentBreakdown['total_amount'];
    $newTermMonths = $loanDetails['month_term_duration'] - $paymentBreakdown['term_reduction'];

    // Ensure term doesn't go negative unless balance is zero
    if ($loanDetails['month_term_duration'] == 1 && $paymentBreakdown['remaining_balance'] > 0) {
        $newTermMonths = 1;
    } else {
        $newTermMonths = max(0, $newTermMonths);
    }

    // Update payment status
    $stmt = $conn->prepare("UPDATE payment SET status = 'paid', paid_amount = ?, principal_amount = ?, interest_amount = ? WHERE reference_no = ?");
    $stmt->bind_param("ddds", $totalAmount, $principalAmount, $interestAmount, $reference_no);
    $stmt->execute();

    $stmt2 = $conn->prepare("
    UPDATE loan_balance lb
    JOIN payment p ON lb.borrower_id = p.borrower_id
    JOIN loan l ON lb.loan_reference_no = l.reference_no
    SET
        lb.loan_balance = CASE
            WHEN lb.loan_balance - ? <= 0 THEN 0
            ELSE lb.loan_balance - ?
        END
    WHERE p.reference_no = ?
    AND l.reference_no = ?
    AND lb.status = '1'
");
    $stmt2->bind_param("ddss", $principalAmount, $principalAmount, $reference_no, $loanDetails['reference_no']);
    $stmt2->execute();

    // Then, update the status and month_term_duration based on the updated loan balance
    $stmt4 = $conn->prepare("
    UPDATE loan_balance lb
    JOIN payment p ON lb.borrower_id = p.borrower_id
    JOIN loan l ON lb.loan_reference_no = l.reference_no
    SET
        lb.status = CASE
            WHEN lb.loan_balance <= 0 THEN 0
            ELSE 1
        END,
        lb.month_term_duration = CASE
            WHEN lb.loan_balance <= 0 THEN 0
            ELSE ?
        END
    WHERE p.reference_no = ?
    AND l.reference_no = ?
    AND lb.status = '1'
");
    $stmt4->bind_param("dss", $newTermMonths, $reference_no, $loanDetails['reference_no']);
    $stmt4->execute();

    // Update loan schedule status
    $stmt3 = $conn->prepare("
        UPDATE loan_schedules ls
        JOIN payment p ON p.reference_no = ?
        JOIN loan l ON ls.loan_id = l.id
        JOIN loan_balance lb ON l.reference_no = lb.loan_reference_no
            AND lb.borrower_id = p.borrower_id
        SET ls.status = 'paid'
        WHERE ls.due_date = p.payment_date
        AND ls.status = 'pending'
        LIMIT 1
    ");
    $stmt3->bind_param("s", $reference_no);
    $stmt3->execute();

    $conn->commit();

    echo json_encode([
        'status' => 'success',
        'message' => 'Payment processed successfully'
    ]);

} catch (Exception $e) {
    $conn->rollback();
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
} finally {
    if (isset($stmt)) {
        $stmt->close();
    }
    if (isset($stmt2)) {
        $stmt2->close();
    }
    if (isset($stmt3)) {
        $stmt3->close();
    }
    $conn->close();
}