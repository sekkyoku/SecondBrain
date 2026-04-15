---
title: "Second Brain — Claude Code Desktop Setup"
version: 2.0
audience: end-users (non-technical)
time: "~10 minutes, one time"
---

# Second Brain — Claude Code Desktop Setup

> **What you'll have when done:** A shared knowledge vault that any teammate can open in **Claude Code Desktop** on their own machine. Edits sync automatically between machines in the background — no git commands, no terminal, ever.
>
> **Who this is for:** End users who will only use the **Claude Code Desktop app** to ask the Second Brain questions (and occasionally edit notes). It replaces a RAG pipeline with a plain folder of Markdown files that Claude reads directly.

---

## How it works (30-second version)

```
┌─────────────────────────┐    auto-sync every 5 min    ┌─────────────────────────┐
│  Your Mac / PC          │ ◄─────── GitHub ─────────► │  Teammate's Mac / PC    │
│  ~/SecondBrain/vault    │     (background service)    │  ~/SecondBrain/vault    │
│       ▲                 │                             │       ▲                 │
│       │ reads & edits   │                             │       │ reads & edits   │
│  Claude Code Desktop    │                             │  Claude Code Desktop    │
└─────────────────────────┘                             └─────────────────────────┘
```

- **GitHub** is the source of truth (free private repo).
- A tiny background service on each machine runs every 5 minutes: **pulls** teammates' changes, **commits** yours, **pushes** them back. You never see git.
- **Claude Code Desktop** opens the vault folder and reads it as context. No embeddings, no vector DB.
- **Linting** is built in: type `/lint` in Claude Code Desktop to audit vault health.

---

## One-time prerequisites (per machine)

Install three things. All have GUI installers — no terminal required.

| Tool | macOS | Windows |
|------|-------|---------|
| **Git** | Pre-installed. If missing, install [Git for Mac](https://git-scm.com/download/mac). | [Git for Windows](https://git-scm.com/download/win) — accept all defaults. |
| **Claude Code Desktop** | [claude.com/download](https://claude.com/download) — sign in with a Claude **Pro/Max/Team** account. | Same link. |
| **GitHub Desktop** *(optional, for sign-in)* | [desktop.github.com](https://desktop.github.com) | [desktop.github.com](https://desktop.github.com) |

> **Why GitHub Desktop?** It handles GitHub authentication with a single click — no personal access tokens to paste. After sign-in, the background sync service uses its stored credentials automatically. If your team already has a different git credential setup, skip it.

---

## Step 1 — Sign in to GitHub (one click)

1. Open **GitHub Desktop**.
2. Click **Sign in to GitHub.com** → browser opens → approve.
3. Close GitHub Desktop. You are done with it. The credentials it stored will be used by the background sync service for the rest of this setup.

> If your team lead already sent you a personal access token instead, skip this step — the setup script will prompt you.

---

## Step 2 — Run the one-line install

This single command clones the vault to `~/SecondBrain` and installs the background auto-sync service. It will **not** ask for admin/root.

### macOS

1. Open **Terminal** (Spotlight → `Terminal`) — you only do this **once**.
2. Paste this and press Enter:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/sekkyoku/SecondBrain/main/scripts/setup.sh | bash
   ```

3. Close Terminal. You will never need to reopen it.

### Windows

1. Open **PowerShell** (Start → type `PowerShell`) — you only do this **once**.
2. Paste this and press Enter:

   ```powershell
   iwr -useb https://raw.githubusercontent.com/sekkyoku/SecondBrain/main/scripts/setup.ps1 | iex
   ```

3. Close PowerShell. You will never need to reopen it.

**What the installer did:**
- Cloned the vault to `~/SecondBrain` (macOS) or `C:\Users\<you>\SecondBrain` (Windows).
- Installed a background service: **launchd** job on macOS, **Task Scheduler** task on Windows.
- The service runs `scripts/sync.sh` (or `sync.ps1`) every 5 minutes: pull → auto-commit local edits → push. Logs to `scripts/sync.log`.

---

## Step 3 — Open the vault in Claude Code Desktop

1. Launch **Claude Code Desktop**.
2. Click **Open folder** (or `File → Open folder`).
3. Pick `~/SecondBrain` (macOS) or `C:\Users\<you>\SecondBrain` (Windows). **Open the `SecondBrain` folder, not `vault/`** — Claude Code uses the root `CLAUDE.md` to orient, then navigates into `vault/`.
4. Claude Code loads. That is it. No further config.

### First questions to try

Type any of these into Claude Code Desktop:

- `What deal types does Canela Media support?`
- `What's the total budget and projected ROAS for FY25?`
- `Who's the technical contact and what's the SLA?`
- `/lint` — run a full vault health check.

Claude reads the Markdown files directly — no indexing step, no wait time.

---

## Step 4 — Edit notes, sync is automatic

Ask Claude to update a note, or open a `.md` file in any editor (Obsidian, VS Code, Notepad). Save.

Within 5 minutes, the background service will:
1. Stash your edit, pull anything new from teammates (fast-forward only).
2. Re-apply your edit.
3. Auto-commit it with a message like `auto-sync: vault update from <machine> 2026-04-15T18:22:03Z`.
4. Push to GitHub.

Teammates receive it within 5 minutes on their next sync.

**You never run `git pull`, `git commit`, or `git push`. Ever.**

### Force a sync right now (rare)

If you need to share an edit immediately, re-run the install one-liner from Step 2 — it is idempotent and will trigger an immediate sync cycle. Or just wait 5 minutes.

---

## Step 5 — Verify it is working

After ~10 minutes, check the sync log:

- **macOS:** open `~/SecondBrain/scripts/sync.log` in any text editor.
- **Windows:** open `C:\Users\<you>\SecondBrain\scripts\sync.log`.

You should see timestamped `ok` lines every 5 minutes. Warnings (`WARN: push failed`) are retried automatically next interval.

---

## Linting the vault

To keep the brain trustworthy, run a lint check before any briefing or weekly as a habit.

In Claude Code Desktop, type:

```
/lint
```

Claude scans every note for:
- Broken `[[wiki-links]]`
- Missing or invalid frontmatter
- Stale notes (>180 days)
- Orphan notes not reachable from the master index
- Duplicate titles
- Contradictions between notes (e.g., two different frequency caps)
- Missing concepts (terms used but never defined)
- Outdated facts

The report is written to `vault/_system/lint-report.md` and a 5-line summary appears in chat. Full spec: `vault/_system/LINTING.md`.

To fix issues, just ask:

```
Read vault/_system/lint-report.md and fix the top 3 critical issues.
```

Claude edits the notes; the background service commits and pushes. No git, no terminal.

---

## Moving to a new machine

Repeat Steps 1–3. The one-line installer clones the latest state from GitHub, and you are back in the brain — no data transfer, no export/import. Because the source of truth is GitHub, you can work from any number of machines in parallel.

---

## Uninstall

If you want to remove the auto-sync service (the vault folder stays untouched unless you delete it yourself):

### macOS

```bash
bash ~/SecondBrain/scripts/uninstall.sh
```

### Windows

```powershell
powershell -ExecutionPolicy Bypass -File $env:USERPROFILE\SecondBrain\scripts\uninstall.ps1
```

To also delete the vault: `rm -rf ~/SecondBrain` (macOS) or `Remove-Item -Recurse $env:USERPROFILE\SecondBrain` (Windows).

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| **Claude Code Desktop says "no context"** | You opened the wrong folder. Close and re-open `~/SecondBrain` (the parent), not a subfolder. |
| **Sync log shows `WARN: pull failed`** | Almost always means a conflict. Open `~/SecondBrain/scripts/sync.log` for details. Ask a teammate who pushed recently to confirm their edits, then ask Claude: *"Check git status in SecondBrain and resolve any merge conflicts."* |
| **Sync log shows `WARN: push failed`** | Usually missing credentials. Re-run Step 1 (GitHub Desktop sign-in). |
| **`/lint` returns nothing** | Confirm `.claude/commands/lint.md` is present in the repo. If not, re-run Step 2. |
| **Sync service stopped running** | macOS: `launchctl list \| grep secondbrain` should return a line. If empty, re-run Step 2. Windows: Task Scheduler → Task Scheduler Library → `SecondBrainSync` should be listed and enabled. |
| **I want to sync faster than 5 minutes** | Edit the `SYNC_INTERVAL` in `scripts/setup.sh` (seconds) or the `New-TimeSpan -Minutes 5` in `scripts/setup.ps1`, then re-run the installer. |

---

## What is explicitly NOT required

- ❌ Obsidian — optional, not needed by Claude Code Desktop.
- ❌ Running git commands — the background service handles all of it.
- ❌ Embedding models, vector databases, RAG pipelines — Claude reads files directly.
- ❌ A server — GitHub hosts; your laptop runs.
- ❌ Admin privileges — the installer uses per-user scheduled services only.

---

*Built on Claude Code Desktop. Vault replaces RAG with direct-read Markdown context. Setup v2.0 — April 2026.*
