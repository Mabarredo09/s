# Task configuration
$taskName = "MPR Lending Payment Generator"
$taskDescription = "Generates monthly payments for active loans"
$execPath = "C:\xampp\htdocs\MPR-Lending-Kapital-main14-main\cronJob\samplecron.bat"
$workingDir = "C:\xampp\htdocs\MPR-Lending-Kapital-main14-main\cronJob"

# Create task components
$action = New-ScheduledTaskAction `
    -Execute $execPath `
    -WorkingDirectory $workingDir

# Create monthly trigger (first day of month at midnight)
$trigger = New-ScheduledTaskTrigger `
    -Once `
    -At (Get-Date -Year (Get-Date).Year -Month (Get-Date).Month -Day 1 -Hour 0 -Minute 0 -Second 0)

# Configure settings
$settings = New-ScheduledTaskSettingsSet `
    -ExecutionTimeLimit (New-TimeSpan -Hours 1) `
    -RestartCount 3 `
    -RestartInterval (New-TimeSpan -Minutes 1)

# Create principal (run with highest privileges)
$principal = New-ScheduledTaskPrincipal `
    -UserID "SYSTEM" `
    -LogonType ServiceAccount `
    -RunLevel Highest

# Register the task
Register-ScheduledTask `
    -TaskName $taskName `
    -Description $taskDescription `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -Principal $principal