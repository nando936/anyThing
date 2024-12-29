# Interaction Logging Instructions

## Purpose
The `session_log.bat` script is used to log session details into the `interaction_log.txt` file.
It now uses GitPython exclusively for Git operations, providing better integration and simplified commands.
The script appends a timestamped entry, commits the changes, and pushes them to GitHub.

## How to Use

### Commands for Interactions
- **To create a session log update**: Use `sd` to request complete session details for the day.
- **To update the log with the latest details since the last update**: Use `sdu`.

Before running the script, ensure that GitPython is installed by executing:
```bash
pip install gitpython
```

Before running the script, ensure that GitPython is installed by executing:
```bash
pip install gitpython
```

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
The interaction log should include the current time in Central Time (CST). Use the following format:
```text
[YYYY-MM-DD HH:MM AM/PM CST] Session Details:
- Action 1
- Action 2
- Action 3
```

**Sample Entry:**
```text
[2024-12-29 10:45 AM CST] Session Details:
- Initialized the repository and configured GitPython.
- Created the interaction_log.txt and error_log.txt files.
- Successfully pushed updates to GitHub.
```
```text
[YYYY-MM-DD HH:MM] Session Details:
- Action 1
- Action 2
- Action 3
```

## Outputs
- Updates the `interaction_log.txt` file with the session details, capturing each session's actions and outcomes.
- You can view the current interactions in the `interaction_log.txt` file (https://github.com/nando936/anyThing/blob/main/interaction_logs/error_log.txt).
- Commits the updated log to Git.
- Pushes the changes to the remote repository on GitHub.
- Records all actions, successes, and errors, including GitPython exceptions, in the `error_log.txt` file.
- Commits the updated log to Git.
- Pushes the changes to the remote repository on GitHub. `interaction_log.txt` file with the session details.
- Commits the updated log to Git.
- Pushes the changes to the remote repository on GitHub.

## Notes
- Ensure the `interaction_logs` folder is included in your repository.
- You can modify the `session_log.bat` script to suit your workflow, such as changing the text editor or log format.

## Troubleshooting
- Ensure the script is executed from the root directory of a Git repository, as GitPython requires this to interact correctly with the repository.

- If the script fails to push to GitHub, verify your Git credentials and remote URL.
- Ensure the `interaction_logs/interaction_log.txt` file exists before running the script.
- Use `git log` to confirm the commit history after running the script.

