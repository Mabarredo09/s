<?php
require_once 'db_connect.php';

// Function to calculate monthly payment (fixed payment formula)
function calculateMonthlyPayment($loanAmount, $interestRate, $termMonths)
{
    $monthlyInterestRate = $interestRate / 100 / 12;
    return $loanAmount * ($monthlyInterestRate / (1 - pow(1 + $monthlyInterestRate, -$termMonths)));
}

function calculateCustomPayment($currentBalance, $customAmount, $interestRate, $remainingMonths)
{
    $monthlyInterestRate = $interestRate / 100 / 12;

    // Calculate regular monthly payment for reference
    $regularMonthlyPayment = calculateMonthlyPayment($currentBalance, $interestRate, $remainingMonths);
    $minInterestAmount = $currentBalance * $monthlyInterestRate;

    // Validate payment amount
    if ($customAmount < $minInterestAmount) {
        throw new Exception("Payment must cover at least the interest amount: " . number_format($minInterestAmount, 2));
    }

    // Calculate maximum allowed payment
    $maxPayment = $currentBalance + $minInterestAmount;
    if ($customAmount > $maxPayment) {
        throw new Exception("Payment cannot exceed balance plus interest: " . number_format($maxPayment, 2));
    }

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

try {
    $conn->begin_transaction();

    // Update the loan query to properly handle multiple loans
    $stmt = $conn->prepare("
        SELECT l.id, l.loan_amount, l.borrower_id, l.interest_rate, l.term_months,
               l.loan_date, l.reference_no, lb.loan_balance, lb.id as balance_id,
               lb.month_term_duration, lb.status
        FROM loan l
        JOIN loan_balance lb ON l.reference_no = lb.loan_reference_no
        LEFT JOIN loan_schedules ls ON l.id = ls.loan_id AND ls.status = 'pending'
        WHERE lb.status = '1'
        AND lb.loan_balance > 0
        AND lb.month_term_duration > 0
        AND ls.id IS NULL
        GROUP BY l.id
        ORDER BY l.loan_date DESC
    ");

    $stmt->execute();
    $result = $stmt->get_result();

    if ($loan = $result->fetch_assoc()) {
        // Validate loan status before generating payment
        $checkActiveLoans = $conn->prepare("
            SELECT COUNT(*) as active_loans
            FROM loan_balance
            WHERE borrower_id = ?
            AND status = '1'
            AND loan_reference_no != ?
        ");

        $checkActiveLoans->bind_param("is", $loan['borrower_id'], $loan['reference_no']);
        $checkActiveLoans->execute();
        $activeLoansResult = $checkActiveLoans->get_result()->fetch_assoc();

        $loanId = $loan['id'];
        $loanAmount = $loan['loan_amount'];
        $borrowerId = $loan['borrower_id'];
        $interestRate = $loan['interest_rate'];
        $currentTermMonths = $loan['month_term_duration'];
        $termMonths = $loan['term_months'];
        $loanDate = $loan['loan_date'];
        $currentBalance = $loan['loan_balance'];
        $balanceId = $loan['balance_id'];

        // Add validation before generating new payment
        if ($currentBalance <= 0) {
            echo json_encode([
                'status' => 'error',
                'message' => 'No active loan balance found'
            ]);
            exit;
        }

        if ($currentTermMonths <= 0) {
            echo json_encode([
                'status' => 'error',
                'message' => 'Loan term has been completed'
            ]);
            exit;
        }

        // Check if custom amount is provided
        $customAmount = $_POST['custom_amount'] ?? null;

        // Update the payment generation section:
        if ($customAmount) {
            try {
                $paymentBreakdown = calculateCustomPayment(
                    $currentBalance,
                    $customAmount,
                    $interestRate,
                    $currentTermMonths
                );

                $principalAmount = $paymentBreakdown['principal_amount'];
                $interestAmount = $paymentBreakdown['interest_amount'];
                $totalAmount = $paymentBreakdown['total_amount'];
                $newTermMonths = $currentTermMonths - $paymentBreakdown['term_reduction'];

                // Ensure term doesn't go negative
                $newTermMonths = max(0, $newTermMonths);

            } catch (Exception $e) {
                throw new Exception("Invalid custom payment: " . $e->getMessage());
            }
        } else {
            // Regular monthly payment calculation
            $monthlyPayment = calculateMonthlyPayment($currentBalance, $interestRate, $currentTermMonths);
            $monthlyInterestRate = $interestRate / 100 / 12;
            $interestAmount = $currentBalance * $monthlyInterestRate;
            $principalAmount = $monthlyPayment - $interestAmount;
            $totalAmount = $monthlyPayment;
            $newTermMonths = $currentTermMonths - 1;
        }

        // Get the latest schedule date
        $stmtLastSchedule = $conn->prepare("
            SELECT due_date
            FROM loan_schedules
            WHERE loan_id = ?
            ORDER BY due_date DESC
            LIMIT 1
        ");

        $stmtLastSchedule->bind_param("i", $loanId);
        $stmtLastSchedule->execute();
        $lastScheduleResult = $stmtLastSchedule->get_result();

        // Calculate next payment date
        if ($lastScheduleResult->num_rows > 0) {
            $lastSchedule = $lastScheduleResult->fetch_assoc();
            $nextDate = date('Y-m-d', strtotime('+1 month', strtotime($lastSchedule['due_date'])));
        } else {
            $nextDate = date('Y-m-d', strtotime('+1 month', strtotime($loanDate)));
        }

        // Insert new schedule
        $stmt2 = $conn->prepare("
            INSERT INTO loan_schedules
            (loan_id, due_date, principal_amount, interest_amount, total_amount, status)
            VALUES (?, ?, ?, ?, ?, 'pending')
        ");

        $stmt2->bind_param(
            "isddd",
            $loanId,
            $nextDate,
            $principalAmount,
            $interestAmount,
            $totalAmount
        );
        $stmt2->execute();

        // Generate payment reference
        $paymentRefNo = "PMT-" . strtoupper(substr(uniqid(), -6));

        // Insert payment record
        $stmt3 = $conn->prepare("
            INSERT INTO payment (
                payment_date, principal_amount, interest_amount, payment_amount, reference_no, borrower_id,
                remarks, status
            ) VALUES (?, ?, ?, ?, ?, ?, ?, 'pending')
        ");

        $remarks = "Monthly payment for schedule #" . $stmt2->insert_id;
        $stmt3->bind_param(
            "sddssis",
            $nextDate,
            $principalAmount,
            $interestAmount,
            $totalAmount,
            $paymentRefNo,
            $borrowerId,
            $remarks
        );
        $stmt3->execute();

        $conn->commit();
        echo json_encode([
            'status' => 'success',
            'message' => 'Schedule and payment generated successfully',
            'data' => [
                'schedule_id' => $stmt2->insert_id,
                'payment_ref' => $paymentRefNo,
                'due_date' => $nextDate,
                'amount' => $totalAmount,
                'remaining_months' => $newTermMonths,
                'interest_amount' => $interestAmount,
            ]
        ]);
    } else {
        echo json_encode([
            'status' => 'info',
            'message' => 'No loans require schedule generation'
        ]);
    }

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