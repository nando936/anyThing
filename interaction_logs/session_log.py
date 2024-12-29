import os
from git import Repo
from datetime import datetime

# Define paths
base_dir = os.getcwd()  # Base directory of the script
log_folder = os.path.join(base_dir, "interaction_logs")  # Single-level log folder
interaction_log = os.path.join(log_folder, "interaction_log.txt")
error_log = os.path.join(log_folder, "error_log.txt")
temp_log = os.path.join(base_dir, "temp_session_details.txt")

# Ensure the interaction_logs folder exists
if not os.path.exists(log_folder):
    os.makedirs(log_folder)
    with open(error_log, "a") as f:
        f.write(f"[{datetime.now()}] Created log folder: {log_folder}\n")
else:
    with open(error_log, "a") as f:
        f.write(f"[{datetime.now()}] Log folder already exists: {log_folder}\n")

# Ensure log files exist
for log_file in [interaction_log, error_log]:
    if not os.path.exists(log_file):
        open(log_file, "a").close()
        with open(error_log, "a") as f:
            f.write(f"[{datetime.now()}] Created log file: {log_file}\n")
    else:
        with open(error_log, "a") as f:
            f.write(f"[{datetime.now()}] Log file already exists: {log_file}\n")

# Open Notepad for session details
with open(error_log, "a") as f:
    f.write(f"[{datetime.now()}] Opening Notepad for session details: {temp_log}\n")

os.system(f"notepad.exe {temp_log}")

# Check if TempLog contains content
if not os.path.exists(temp_log) or os.stat(temp_log).st_size == 0:
    with open(error_log, "a") as f:
        f.write(f"[{datetime.now()}] No session details provided in Notepad: {temp_log}\n")
    exit(1)
else:
    with open(error_log, "a") as f:
        f.write(f"[{datetime.now()}] Session details found in temp file: {temp_log}\n")

# Append session details to InteractionLog
with open(interaction_log, "a") as int_log, open(temp_log, "r") as temp:
    int_log.write(f"[{datetime.now()}] Session Details:\n")
    int_log.write(temp.read() + "\n")
with open(error_log, "a") as f:
    f.write(f"[{datetime.now()}] Appended session details to interaction log: {interaction_log}\n")

# Git operations using GitPython
try:
    # Initialize repository
    repo = Repo(base_dir)  # Ensure base_dir is the Git repository root

    # Stage the interaction log
    repo.git.add(interaction_log)

    # Commit changes
    repo.index.commit(f"Updated interaction log for {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

    # Push changes
    origin = repo.remote(name="origin")
    origin.push()

    with open(error_log, "a") as f:
        f.write(f"[{datetime.now()}] Git operations completed successfully using GitPython.\n")
except Exception as e:
    with open(error_log, "a") as f:
        f.write(f"[{datetime.now()}] GitPython operation failed: {e}\n")
    exit(1)

# Clean up temp file
try:
    os.remove(temp_log)
    with open(error_log, "a") as f:
        f.write(f"[{datetime.now()}] Cleaned up temporary file: {temp_log}\n")
except OSError as e:
    with open(error_log, "a") as f:
        f.write(f"[{datetime.now()}] Failed to delete temporary file: {temp_log} - {e}\n")

# Log success
with open(error_log, "a") as f:
    f.write(f"[{datetime.now()}] Session log successfully updated without errors.\n")
