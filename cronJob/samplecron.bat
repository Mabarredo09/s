@echo off
echo [%date% %time%] Starting MPR Lending Payment Generator

REM Set paths
set PHP_PATH="C:\xampp\php\php.exe"
set SCRIPT_PATH="C:\xampp\htdocs\MPR-Lending-Kapital-main14-main\cronJob\sampleCronJob.php"

REM Execute PHP script
%PHP_PATH% -f %SCRIPT_PATH%

IF %ERRORLEVEL% NEQ 0 (
    echo [%date% %time%] Error running cron job
    exit /b 1
) ELSE (
    echo [%date% %time%] Cron job completed successfully
)