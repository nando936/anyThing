
# Interaction Instructions

## Purpose
This document outlines the guidelines for interacting with ChatGPT and the procedure for logging those interactions. It provides clear instructions on how session details should be documented, using GitPython for logging and version control. The purpose is to ensure that ChatGPT follows these instructions for consistent communication, proper logging, and organization of interaction details throughout the development process. ChatGPT should refer to this document for guidance on how to manage and record interactions.

Additionally, whenever I paste or upload the `Instructions.md` document into ChatGPT, ChatGPT should **only follow the instructions** provided in the document. ChatGPT should not provide any summaries or overviews of the document. The focus should be on adhering to the instructions and commands outlined in the document.

When this document is pasted, uploaded, or shared in any way, ChatGPT should immediately:
- Follow the instructions provided in the document.
- Greet me with a list of commands that can be used from the document.

## How to Use

### Working on Scripts
- When working on a script, always provide the complete, updated script after incorporating any changes, rather than showing only the parts that need to be updated. This ensures clarity and ease of implementation.

### Commands for Interactions
- **To create a session log update**: Use `*sd` to request ChatGPT to provide complete session details for the day.
- **To update the log with the latest details since the last update**: Use `*sdu` to request ChatGPT to provide only the most recent updates.
- **To save your work during a session**: Use `*us` to request ChatGPT to save updates for long sessions periodically.
- **To get the updated script**: Use `*sc` to request ChatGPT to provide the complete, updated script for the task currently being worked on, not the readme or any other unrelated script. This ensures the latest script is always accessible and ready for implementation.

#### Prefix for Commands
To avoid confusion, prefix all commands with `*` (e.g., `*sd`, `*sdu`, `*us`, `*sc`) to clearly indicate that these are commands for ChatGPT. If an unrecognized command is issued, ChatGPT will ask for clarification to determine if it should be added as a new feature or command.


### Details for Interaction Logs
Interaction logs should include:
- Timestamps in CST (Central Time) for each entry.
- Clear descriptions of actions taken during the session.
- Notes on any issues encountered and their resolutions.
- Links to relevant resources or files if applicable.

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
  - You can view the current interactions in the `interaction_log.txt` file:
    https://github.com/nando936/anyThing/blob/main/interaction_logs/interaction_log.txt
- Records all actions, successes, and errors, including GitPython exceptions, in the `error_log.txt` file.
  - You can view the latest error messages in the `error_log.txt` file:
    https://github.com/nando936/anyThing/blob/main/interaction_logs/error_log.txt
- Commits the updated log to Git.
- Pushes the changes to the remote repository on GitHub.

## Notes
- Ensure the `interaction_logs` folder is included in your repository.
- You can modify the `session_log.bat` script to suit your workflow, such as changing the text editor or log format.

### Updating any document or script on Request
When ChatGPT updates any document or script upon request, it will always provide the **full, updated version** of the document or script in a **code block** format. This ensures that you have the latest version of the document to copy and use directly.

#### Example:
When you request an update to a document or script, ChatGPT will provide it like this:

```markdown
## Updated then name of the document or script

[full content of the updated README.md here]

This helps to ensure that the latest version is available and easily accessible for use or further editing.
