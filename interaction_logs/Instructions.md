
## Interaction Instructions

### Purpose
This document outlines the guidelines for interacting with ChatGPT and the procedure for logging those interactions. It provides clear instructions on how session details should be documented, using GitPython for logging and version control. The purpose is to ensure that ChatGPT follows these instructions for consistent communication, proper logging, and organization of interaction details throughout the development process. All behavior must adhere to these instructions. Any deviation from this process,...

Additionally, whenever I paste or upload the `Instructions.md` document into ChatGPT, ChatGPT should **only follow the instructions** provided in the document. ChatGPT should not provide any summaries or overviews of the document. The focus should be on adhering to the instructions and commands outlined in the document.

When this document is pasted, uploaded, or shared in any way, ChatGPT should immediately:
- Follow the instructions provided in the document.
- Greet me with a list of commands that can be used from the document.

## How to Use

### Working on Scripts
- When working on a script, always provide the complete, updated script after incorporating any changes, rather than showing only the parts that need to be updated. This ensures clarity and ease of implementation.

### Commands for Interactions
- **To edit an existing command**: Use `*edit` (**Edit Command**) followed by the name of the command you want to edit. If no command name is provided, ChatGPT will prompt you to specify the command. ChatGPT will then ask for the new description and functionality of the command and update the interaction instructions accordingly.
- **To create a session log update**: Use `*ss` (**Session Save**) to request ChatGPT to provide a summary of the current session in the format specified below:
  - **Timestamp**: The session log will include a timestamp based on the user's **current local time (CST)**.
  - **Session Summary**: The log will summarize the actions taken during the session.
  - **Details of Updates**: Any updates made to documents, instructions, or code will be described.
  - **Links Provided**: Any new files or download links shared with the user will be included in the log.
- **To update the log with the latest details since the last update**: Use `*us` (**Update Session Save**) to request ChatGPT to save updates for long sessions periodically. This command will **append and update only new details** to the session log if the **`*ss`** command has been issued previously. It will not overwrite any existing session log data but will ensure that the log is updated with the most recent details.
- **To get the updated script**: Use `*sc` (**Show Complete Script**) to request ChatGPT to provide the complete, updated script for the task currently being worked on, not the readme or any other unrelated script. This ensures the latest script is always accessible and ready for implementation.
- **To delete a command**: Use `*dc` (**Delete Command**) followed by the command you want to delete. ChatGPT will remove the command from the interaction instructions.
- **To list all available commands**: Use `*lc` (**List Commands**) to request ChatGPT to provide a list of all available commands described in this document.

#### Prefix for Commands
To ensure consistent behavior:
1. Any word prefixed with `*` will automatically be treated as a potential command without exceptions.
2. ChatGPT will:
   - **Check** if the command exists in the list of defined commands.
   - If the command **does not exist**, ChatGPT will:
     1. Inform you that the command is unrecognized.
     2. Prompt you to confirm if you want to add it as a new command (Yes/No).
        - If "Yes": ChatGPT will ask for a description of the command and its functionality, then add it to the interaction instructions.
        - If "No": ChatGPT will take no further action.
3. In cases of ambiguity or doubt, ChatGPT must default to treating the word as an unrecognized command and follow the outlined process.

### Details for Interaction Logs
Interaction logs should include:
- Timestamps in **CST (Central Time)** based on the **user's current local time** for each entry, dynamically fetched at the time of generating the log.
- The correct time used in the session log should always be based on the **user's local time in the Central Time Zone (CST)**.
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
```

ChatGPT will not include additional dialog or comments within the code block; any explanations or clarifications will be provided outside the block.

This helps to ensure that the latest version is available and easily accessible for use or further editing.
