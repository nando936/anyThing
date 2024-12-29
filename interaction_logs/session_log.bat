@echo off
:: Script to create, save, commit, and push a session log to GitHub

:: Get the current timestamp
for /f "tokens=2 delims==." %%A in ('wmic os get localdatetime /value ^| find "."') do set datetime=%%A

:: Inform user about the process
echo Create a session log for today.
echo Enter your log details in Notepad. Save and close it when done.
pause

:: Open Notepad for user to paste session details
notepad temp_session_details.txt

:: Append formatted log entry to interaction_log.txt
echo [%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%] Session Details: >> interaction_logs\interaction_log.txt
type temp_session_details.txt >> interaction_logs\interaction_log.txt
echo. >> interaction_logs\interaction_log.txt

:: Stage the updated log file
git add interaction_logs\interaction_log.txt

:: Commit the changes with a message including today's date
git commit -m "Updated interaction log for %datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%"

:: Push the changes to GitHub
git push

:: Clean up the temporary session details file
del temp_session_details.txt

:: Notify the user
echo Session log has been successfully updated and pushed to GitHub!
pause
