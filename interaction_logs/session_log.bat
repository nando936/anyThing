@echo off
:: Simplified script with corrected folder handling, Notepad wait, and robust error logging

:: Get the current timestamp
for /f "tokens=2 delims==." %%A in ('wmic os get localdatetime /value ^| find "."') do set datetime=%%A

:: Define the log file paths
set log_folder=interaction_logs
set interaction_log=%log_folder%\interaction_log.txt
set error_log=%log_folder%\error_log.txt

:: Ensure the interaction_logs folder exists
if not exist %log_folder% (
    echo Creating %log_folder% folder...
    mkdir %log_folder%
)

:: Ensure the log files exist
if not exist %interaction_log% (
    echo Creating interaction log file...
    echo. > %interaction_log%
)
if not exist %error_log% (
    echo Creating error log file...
    echo. > %error_log%
)

:: Confirm initialization
if not exist %interaction_log% (
    echo Failed to create interaction_log.txt. Exiting script.
    timeout /t 5 > nul
    goto end
)
if not exist %error_log% (
    echo Failed to create error_log.txt. Exiting script.
    timeout /t 5 > nul
    goto end
)

:: Function to log errors and exit on critical ones
:log_error
echo [%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%] %1 >> %error_log%
git add %error_log%
git commit -m "Error logged: %1"
git push
if "%2"=="critical" (
    echo Critical error encountered. Exiting script.
    timeout /t 5 > nul
    goto end
)
goto :eof

:: Function to log success
:log_success
echo [%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%] Update completed successfully without errors. >> %error_log%
git add %error_log%
git commit -m "Successful update logged"
git push
goto :eof

:: Inform user about opening Notepad
echo Opening Notepad for session details...
timeout /t 2 > nul
start /wait notepad temp_session_details.txt || (
    call :log_error "Failed to open Notepad" critical
    echo Error: Failed to open Notepad. Logged and exiting.
    goto end
)

:: Check if the file contains content
for /f %%i in ('findstr /r /c:"." temp_session_details.txt') do set has_content=true

:: If no content was added, log a warning and exit
if not defined has_content (
    call :log_error "No session details provided in Notepad" critical
    echo Error: No session details were provided. Logged and exiting.
    goto end
)

:: Append the session details to interaction_log.txt
echo Appending session details to %interaction_log%...
timeout /t 2 > nul
(
    echo [%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%] Session Details: >> %interaction_log%
    type temp_session_details.txt >> %interaction_log%
    echo. >> %interaction_log%
) || (
    call :log_error "Failed to append session details" critical
    echo Error: Failed to append session details. Logged and exiting.
    goto end
)

:: Notify user about staging the changes
echo Staging the updated log file for commit...
timeout /t 2 > nul
git add %interaction_log% 2>> %error_log% || (
    call :log_error "Failed to stage the log file" critical
)

:: Notify user about committing the changes
echo Committing the changes to the local Git repository...
timeout /t 2 > nul
git commit -m "Updated interaction log for %datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%" 2>> %error_log% || (
    call :log_error "Failed to commit the log file" critical
)

:: Notify user about pushing to GitHub
echo Pushing the changes to GitHub...
timeout /t 2 > nul
git push 2>> %error_log% || (
    call :log_error "Failed to push changes to GitHub" critical
)

:: Clean up the temporary session details file
echo Cleaning up temporary files...
timeout /t 2 > nul
del temp_session_details.txt 2>> %error_log% || (
    call :log_error "Failed to delete temporary file" non-critical
    echo Warning: Failed to delete temporary file. Logged and continuing.
)

:: Log success
call :log_success
echo Session log has been successfully updated, and the update was error-free.
timeout /t 5 > nul
goto end

:end
