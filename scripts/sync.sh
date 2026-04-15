#!/bin/bash
# ============================================================
# SecondBrain — Bidirectional Auto-Sync (macOS / Linux)
#
# What this does (in order):
#   1. Stashes any uncommitted local changes
#   2. Pulls latest from origin (fast-forward)
#   3. Re-applies the stash
#   4. Auto-commits anything new under vault/
#   5. Pushes to origin
#
# Runs quietly via launchd every 5 minutes.
# End users never touch git.
# ============================================================

set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
LOG="$SCRIPT_DIR/sync.log"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG"; }

cd "$REPO_DIR" || { log "ERR: cannot cd to $REPO_DIR"; exit 1; }

# Skip if another sync is still running
LOCK="$SCRIPT_DIR/.sync.lock"
if [ -f "$LOCK" ] && kill -0 "$(cat "$LOCK")" 2>/dev/null; then
    log "skip: previous sync still running"
    exit 0
fi
echo $$ > "$LOCK"
trap 'rm -f "$LOCK"' EXIT

# Ensure identity is set (first-run safety)
git config user.email >/dev/null 2>&1 || git config user.email "secondbrain@localhost"
git config user.name  >/dev/null 2>&1 || git config user.name  "SecondBrain Sync"

# Stash local changes so pull can fast-forward
STASHED=0
if ! git diff --quiet || ! git diff --cached --quiet; then
    git stash push -u -m "auto-sync $(date -u +%FT%TZ)" >> "$LOG" 2>&1 && STASHED=1
fi

# Pull latest
if ! git pull --ff-only origin main >> "$LOG" 2>&1; then
    log "WARN: pull failed — leaving tree as-is for manual review"
    [ "$STASHED" = "1" ] && git stash pop >> "$LOG" 2>&1 || true
    exit 0
fi

# Re-apply stashed work
if [ "$STASHED" = "1" ]; then
    if ! git stash pop >> "$LOG" 2>&1; then
        log "WARN: stash pop had conflicts — left in stash for manual review"
        exit 0
    fi
fi

# Auto-commit any local edits under vault/
git add -A vault/ >> "$LOG" 2>&1 || true
if ! git diff --cached --quiet; then
    HOSTNAME_SHORT="$(hostname -s 2>/dev/null || hostname)"
    git commit -m "auto-sync: vault update from ${HOSTNAME_SHORT} $(date -u +%FT%TZ)" >> "$LOG" 2>&1 || true
fi

# Push
if ! git push origin main >> "$LOG" 2>&1; then
    log "WARN: push failed — will retry next interval"
fi

log "ok"
