<?php
require 'db_connect.php';
session_start();

header('Content-Type: application/json');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        // Start transaction
        $conn->begin_transaction();

        // Get and sanitize form data
        $groceryDate = mysqli_real_escape_string($conn, $_POST['groceryDate']);
        $groceryAmount = str_replace(',', '', $_POST['groceryAmount']); // Remove commas
        $groceryAmount = floatval($groceryAmount); // Convert to float
        $borrowerId = intval($_POST['borrowerId']);
        
        // Validate amount
        if ($groceryAmount <= 0) {
            throw new Exception("Grocery amount must be greater than 0");
        }
        
        // Generate reference number
        $referenceNo = "GR-" . strtoupper(substr(uniqid(), -6));
        
        // Get borrower's name for audit log
        $nameStmt = $conn->prepare("
            SELECT CONCAT(first_name, ' ', COALESCE(middle_name, ''), ' ', surname) as full_name 
            FROM borrowers 
            WHERE id = ?
        ");
        $nameStmt->bind_param("i", $borrowerId);
        $nameStmt->execute();
        $borrowerResult = $nameStmt->get_result();
        $borrowerData = $borrowerResult->fetch_assoc();
        $borrowerName = $borrowerData['full_name'];

        // Insert grocery record
        $stmt = $conn->prepare("
            INSERT INTO grocery (
                reference_no, 
                borrower_id, 
                grocery_amount, 
                grocery_date, 
                remarks
            ) VALUES (?, ?, ?, ?, ?)
        ");
        
        $remarks = "Grocery added successfully";
        
        $stmt->bind_param("sidss", 
            $referenceNo,
            $borrowerId,
            $groceryAmount,
            $groceryDate,
            $remarks
        );

        if (!$stmt->execute()) {
            throw new Exception("Failed to save grocery record: " . $stmt->error);
        }

        // Insert into transactions table
        $stmtTrans = $conn->prepare("
            INSERT INTO transactions (
                reference_no, 
                transaction_type, 
                transaction_date, 
                amount, 
                borrower_id,
                balance
            ) VALUES (?, 'grocery', ?, ?, ?, ?)
        ");
        
        $stmtTrans->bind_param("ssdid", 
            $referenceNo,
            $groceryDate,
            $groceryAmount,
            $borrowerId,
            $groceryAmount  // Initial balance equals the grocery amount
        );

        if (!$stmtTrans->execute()) {
            throw new Exception("Failed to save transaction record: " . $stmtTrans->error);
        }

        // Add audit log
        if (isset($_SESSION['fullname'])) {
            $performed_by = $_SESSION['fullname'];
            $formatted_amount = number_format($groceryAmount, 2);
            $action = sprintf(
                "%s added new grocery item (Ref: %s) worth ₱%s for borrower: %s",
                $performed_by,
                $referenceNo,
                $formatted_amount,
                $borrowerName
            );
            $category = "Grocery Management";
            
            $audit_stmt = $conn->prepare("
                INSERT INTO audit_logs (
                    date, 
                    time, 
                    performed_by, 
                    action, 
                    category
                ) VALUES (CURRENT_DATE(), CURRENT_TIME(), ?, ?, ?)
            ");
            $audit_stmt->bind_param("sss", $performed_by, $action, $category);
            
            if (!$audit_stmt->execute()) {
                throw new Exception("Failed to create audit log: " . $audit_stmt->error);
            }
        }

        // Commit transaction
        $conn->commit();

        // Send success response
        echo json_encode([
            "status" => "success",
            "message" => "Grocery has been successfully added",
            "reference_no" => $referenceNo,
            "amount" => $groceryAmount
        ]);

    } catch (Exception $e) {
        // Rollback transaction on error
        $conn->rollback();
        
        // Send error response
        echo json_encode([
            "status" => "error",
            "message" => $e->getMessage()
        ]);
    } finally {
        // Close all statements
        if (isset($stmt)) $stmt->close();
        if (isset($stmtTrans)) $stmtTrans->close();
        if (isset($nameStmt)) $nameStmt->close();
        if (isset($audit_stmt)) $audit_stmt->close();
        $conn->close();
    }
}
?>