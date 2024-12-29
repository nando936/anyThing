# Interaction Logging Instructions

## Purpose
The `session_log.bat` script is used to log session details into the `interaction_log.txt` file.
It appends a timestamped entry, commits the changes, and pushes them to GitHub.

## How to Use
1. Navigate to the `interaction_logs` folder.
2. Run the script:
   ```bash
   ./session_log.bat
   ```
3. When Notepad opens:
   - Paste or type the session details.
   - Save and close Notepad.

The script will automatically:
- Append the session details to `interaction_log.txt`.
- Commit the changes to the local Git repository.
- Push the updated log file to GitHub.

## Example Session Log Format
```text
[YYYY-MM-DD HH:MM] Session Details:
- Action 1
- Action 2
- Action 3
```

## Outputs
- Updates the `interaction_log.txt` file with the session details.
- Commits the updated log to Git.
- Pushes the changes to the remote repository on GitHub.

## Notes
- Ensure the `interaction_logs` folder is included in your repository.
- You can modify the `session_log.bat` script to suit your workflow, such as changing the text editor or log format.

## Troubleshooting
- If the script fails to push to GitHub, verify your Git credentials and remote URL.
- Ensure the `interaction_logs/interaction_log.txt` file exists before running the script.
- Use `git log` to confirm the commit history after running the script.

