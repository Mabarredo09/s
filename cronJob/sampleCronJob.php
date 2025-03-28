<?php
// Set timezone
date_default_timezone_set('Asia/Manila');

// Set the log file path with absolute path
$logFile = __DIR__ . "/logs/cronJob.txt";

// Create logs directory if it doesn't exist
$logDir = __DIR__ . "/logs";
if (!file_exists($logDir)) {
    mkdir($logDir, 0777, true);
}

// Get the current date and time
$dateTime = date("Y-m-d H:i:s");

try {
    // Your cron job logic here
    require_once '../scripts/AJAX/generate_payment.php';

    // Log success
    $logMessage = "Cron job executed successfully at: $dateTime\n";
    file_put_contents($logFile, $logMessage, FILE_APPEND);

} catch (Exception $e) {
    // Log error
    $errorMessage = "Error at $dateTime: " . $e->getMessage() . "\n";
    file_put_contents($logFile, $errorMessage, FILE_APPEND);
}
?>