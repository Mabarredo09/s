<?php
require_once 'db_connect.php';

header('Content-Type: application/json');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        // Start transaction
        $conn->begin_transaction();

        // Get form data
        $customerType = $_POST['customerType'];
        $loanAmount = str_replace(',', '', $_POST['loanAmount']); // Remove commas
        $interestRate = $_POST['interestRate'];
        $loanDate = $_POST['loanDate'];
        $term = $_POST['term'];
        $borrowerId = $_POST['borrowerId'];
        $remarks = trim($_POST['remarks']);
        $transactionDate = date("Y-m-d H:i:s");

        // Handle promissory note upload
        if (!isset($_FILES["promissoryNote"])) {
            throw new Exception("Promissory note file is required");
        }

        $uploadDir = "../../images/uploads/promissory_notes/";
        if (!file_exists($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }

        // Generate unique filename
        $timestamp = time();
        $fileName = $timestamp . "_" . uniqid() . "." . pathinfo($_FILES["promissoryNote"]["name"], PATHINFO_EXTENSION);
        $filePath = $uploadDir . $fileName;

        // Upload file
        if (!move_uploaded_file($_FILES["promissoryNote"]["tmp_name"], $filePath)) {
            throw new Exception("Failed to upload promissory note");
        }

        // Insert promissory file record first
        $stmtFile = $conn->prepare("INSERT INTO promissory_files (promissory_file_path) VALUES (?)");
        $stmtFile->bind_param("s", $fileName);

        if (!$stmtFile->execute()) {
            throw new Exception("Failed to save promissory file record: " . $stmtFile->error);
        }

        // Get the promissory file ID
        $promissoryId = $conn->insert_id;

        if (!$promissoryId) {
            throw new Exception("Failed to get promissory file ID");
        }

        // Generate reference number
        $referenceNo = "LN-" . strtoupper(substr(uniqid(), -6));

        // Calculate repayment date
        $repaymentDate = date('Y-m-d', strtotime("+$term months", strtotime($loanDate)));

        // Insert loan record
        $stmt = $conn->prepare("INSERT INTO loan (reference_no, borrower_id, customer_type, loan_amount, interest_rate, loan_date, term_months, repayment_date, promissory_id, remarks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

        $stmt->bind_param(
            "sisdssssis",
            $referenceNo,
            $borrowerId,
            $customerType,
            $loanAmount,
            $interestRate,
            $loanDate,
            $term,
            $repaymentDate,
            $promissoryId,
            $remarks
        );

        if (!$stmt->execute()) {
            throw new Exception("Failed to save loan record: " . $stmt->error);
        }

        // Replace the loan balance check section with this:
        $checkBalanceStmt = $conn->prepare("
SELECT id, loan_balance
FROM loan_balance
WHERE loan_reference_no = ?
OR (borrower_id = ? AND status = 1)
");
        $checkBalanceStmt->bind_param("si", $referenceNo, $borrowerId);
        $checkBalanceStmt->execute();
        $balanceResult = $checkBalanceStmt->get_result();

        // Always insert new loan balance record
        $insertBalanceStmt = $conn->prepare("
INSERT INTO loan_balance (
    loan_reference_no,
    borrower_id,
    loan_balance,
    month_term_duration,
    status
) VALUES (?, ?, ?, ?, 1)
");
        $insertBalanceStmt->bind_param(
            "sidi",
            $referenceNo,
            $borrowerId,
            $loanAmount,
            $term
        );

        if (!$insertBalanceStmt->execute()) {
            throw new Exception("Failed to save loan balance: " . $insertBalanceStmt->error);
        }
        $insertBalanceStmt->close();


        $stmtTrans = $conn->prepare("INSERT INTO transactions (reference_no, transaction_type,  amount, borrower_id) VALUES (?, 'loan', ?, ?)");
        $stmtTrans->bind_param("ssi", $referenceNo, $loanAmount, $borrowerId);

        if (!$stmtTrans->execute()) {
            throw new Exception("Failed to save transaction record: " . $stmtTrans->error);
        }

        // Commit transaction
        $conn->commit();

        echo json_encode([
            "status" => "success",
            "message" => "Loan added successfully",
            "reference_no" => $referenceNo,
            "promissory_id" => $promissoryId
        ]);

    } catch (Exception $e) {
        // Rollback transaction on error
        $conn->rollback();

        // Delete uploaded file if exists
        if (isset($filePath) && file_exists($filePath)) {
            unlink($filePath);
        }

        echo json_encode([
            "status" => "error",
            "message" => $e->getMessage()
        ]);
    }

    // Close statements
    if (isset($stmtFile)) {
        $stmtFile->close();
    }
    if (isset($stmt)) {
        $stmt->close();
    }
    if (isset($stmtTrans)) {
        $stmtTrans->close();
    }
    $conn->close();
}
