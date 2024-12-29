@echo off
:: Updated script with fixed log folder paths and comprehensive logging

:: Get the current timestamp
for /f "tokens=2 delims==." %%A in ('wmic os get localdatetime /value ^| find "."') do set datetime=%%A

:: Define the log folder and file paths
set log_folder=%CD%\interaction_logs
set interaction_log=%log_folder%\interaction_log.txt
set error_log=%log_folder%\error_log.txt
set temp_log=%CD%\temp_session_details.txt

:: Ensure the interaction_logs folder exists
if not exist "%log_folder%" (
    echo [%datetime%] Creating log folder: %log_folder% >> "%log_folder%\error_log.txt"
    mkdir "%log_folder%" || echo [%datetime%] Failed to create log folder: %log_folder% >> "%log_folder%\error_log.txt"
) else (
    echo [%datetime%] Log folder already exists: %log_folder% >> "%log_folder%\error_log.txt"
)

:: Ensure the interaction_log.txt file exists
if not exist "%interaction_log%" (
    echo [%datetime%] Creating interaction log file: %interaction_log% >> "%error_log%"
    echo. > "%interaction_log%" || echo [%datetime%] Failed to create interaction log file: %interaction_log% >> "%error_log%"
) else (
    echo [%datetime%] Interaction log file already exists: %interaction_log% >> "%error_log%"
)

:: Ensure the error_log.txt file exists
if not exist "%error_log%" (
    echo [%datetime%] Creating error log file: %error_log% >> "%error_log%"
    echo. > "%error_log%" || echo [%datetime%] Failed to create error log file: %error_log% >> "%error_log%"
) else (
    echo [%datetime%] Error log file already exists: %error_log% >> "%error_log%"
)

:: Log initialization success
echo [%datetime%] Initialization complete. Log folder: %log_folder%. Starting script... >> "%error_log%"

:: Log opening Notepad
echo [%datetime%] Opening Notepad for session details. Temp file: %temp_log% >> "%error_log%"
start /wait notepad "%temp_log%" || (
    echo [%datetime%] Failed to open Notepad: %temp_log% >> "%error_log%"
    goto critical_error
)

:: Log checking for session details
echo [%datetime%] Checking for session details in temp file: %temp_log% >> "%error_log%"
for /f %%i in ('findstr /r /c:"." "%temp_log%"') do set has_content=true
if not defined has_content (
    echo [%datetime%] No session details provided in Notepad: %temp_log% >> "%error_log%"
    goto critical_error
) else (
    echo [%datetime%] Session details found in temp file: %temp_log% >> "%error_log%"
)

:: Log appending session details
echo [%datetime%] Appending session details to interaction log: %interaction_log% >> "%error_log%"
(
    echo [%datetime%] Session Details: >> "%interaction_log%"
    type "%temp_log%" >> "%interaction_log%"
    echo. >> "%interaction_log%"
) || (
    echo [%datetime%] Failed to append session details to interaction log: %interaction_log% >> "%error_log%"
    goto critical_error
)

:: Log staging the updated log file
echo [%datetime%] Staging the updated log file: %interaction_log% >> "%error_log%"
git add "%interaction_log%" || (
    echo [%datetime%] Failed to stage interaction log: %interaction_log% >> "%error_log%"
    goto critical_error
)

:: Log committing the changes
echo [%datetime%] Committing the changes to the local Git repository... >> "%error_log%"
git commit -m "Updated interaction log for %datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%" || (
    echo [%datetime%] Failed to commit changes to the local Git repository. >> "%error_log%"
    goto critical_error
)

:: Log pushing the changes
echo [%datetime%] Pushing the changes to GitHub... >> "%error_log%"
git push || (
    echo [%datetime%] Failed to push changes to GitHub. >> "%error_log%"
    goto critical_error
)

:: Log cleaning up temporary files
echo [%datetime%] Cleaning up temporary files: %temp_log% >> "%error_log%"
del "%temp_log%" || (
    echo [%datetime%] Failed to delete temporary file: %temp_log% >> "%error_log%"
)

:: Log success
echo [%datetime%] Session log successfully updated without errors. >> "%error_log%"
timeout /t 3 > nul
goto end

:critical_error
echo [%datetime%] Critical error encountered. Exiting script. >> "%error_log%"
timeout /t 5 > nul
goto end

:end
