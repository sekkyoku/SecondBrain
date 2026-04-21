---
description: Set up or repair the SecondBrain auto-sync service on this machine — generates SSH keys, registers with GitHub, installs the background sync, and verifies the connection.
---

# /setup-machine — SecondBrain Machine Setup

You are setting up (or repairing) the SecondBrain auto-sync service on this machine. Walk the user through each step conversationally. Do all technical work yourself — the user should never need to open a terminal.

Detect the OS at the start (`uname -s` on macOS/Linux, check `$env:OS` or `$PSVersionTable` on Windows) and use the correct paths and commands throughout.

---

## Step 1 — Check for an existing SSH key

Check whether `~/.ssh/id_ed25519` already exists.

- **If it exists:** Print the public key (`cat ~/.ssh/id_ed25519.pub`), tell the user it already exists and they may already have it registered on GitHub. Ask: *"Is this key already added to your GitHub account? (yes / no)"*
  - If yes → skip to Step 3.
  - If no → continue to Step 2 (key exists, just needs to be registered).
- **If it does not exist:** Generate one silently:
  ```bash
  ssh-keygen -t ed25519 -C "secondbrain-sync" -f ~/.ssh/id_ed25519 -N ""
  ```
  Then proceed to Step 2.

---

## Step 2 — Register the SSH key on GitHub

1. Add GitHub's host fingerprint so the connection is trusted without prompts:
   ```bash
   ssh-keyscan github.com >> ~/.ssh/known_hosts
   ```
2. Print the public key in a clearly visible code block:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
3. Tell the user exactly what to do:

   > **Action required:** Copy the key above. Then open **github.com/settings/keys** in your browser, click **New SSH key**, paste it in, give it any title (e.g. "My MacBook"), and click **Add SSH key**. Come back here and type **done** when finished.

4. Wait for the user to type **done** before continuing.

---

## Step 3 — Verify the GitHub connection

Run:
```bash
ssh -T git@github.com
```

- If the response includes `Hi sekkyoku!` or `Hi <username>!` → connection confirmed, continue.
- If it says `Permission denied (publickey)` → the key was not added correctly. Show the public key again and repeat the GitHub instruction from Step 2.
- If it says `Host key verification failed` → re-run `ssh-keyscan github.com >> ~/.ssh/known_hosts` and try again.

---

## Step 4 — Install the auto-sync service

Run the appropriate setup script for this OS. The script is already in the repo at `scripts/`.

**macOS / Linux:**
```bash
bash scripts/setup.sh
```

**Windows (PowerShell):**
```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup.ps1
```

The script installs a background service (launchd on macOS, Task Scheduler on Windows) that pulls, commits, and pushes every 5 minutes.

---

## Step 5 — Verify the sync service is running

Wait 10 seconds, then check the log:

```bash
tail -5 scripts/sync.log
```

A healthy log shows timestamped `ok` lines. If the log is empty or shows errors, run the script once manually:

**macOS:**
```bash
bash scripts/sync.sh
```

**Windows:**
```powershell
powershell -ExecutionPolicy Bypass -File scripts\sync.ps1
```

Then check the log again.

---

## Step 6 — Confirm and summarise

Tell the user:

> **Setup complete.** This machine is now connected to the SecondBrain. The sync service will pull your teammates' changes and push your edits automatically every 5 minutes — no git commands needed.
>
> To check sync health at any time, ask: *"Show me the last 10 lines of the sync log."*
> To run a vault health check, type `/lint`.
