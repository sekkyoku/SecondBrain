# SecondBrain

This is a structured knowledge vault. It replaces RAG — Claude Code reads the Markdown directly.

## For users
- **Setup** (first time, per machine): see [docs/SETUP.md](docs/SETUP.md). Works on macOS and Windows, installs a background sync service — no git CLI ever.
- **Ask questions**: open `~/SecondBrain` in Claude Code Desktop and chat.
- **Audit vault health**: type `/lint` in Claude Code Desktop.

## For Claude
- All knowledge files live in `vault/`. Start navigation at `vault/_MOC.md`.
- Full answering conventions are in `vault/CLAUDE.md`.
- Linting spec: `vault/_system/LINTING.md`. Lint slash-command: `.claude/commands/lint.md`.
- The `scripts/` folder handles bidirectional auto-sync (launchd on macOS, Task Scheduler on Windows). Do not manually run git — the background service commits and pushes vault edits within 5 minutes.
