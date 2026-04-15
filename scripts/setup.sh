#!/bin/bash
set -e

# ============================================================
# SecondBrain — One-Time Setup (macOS)
#
# What this does:
#   1. Clones the vault to ~/SecondBrain
#   2. Installs a background job that auto-pulls every 5 min
#
# Usage:
#   curl -fsSL <raw-github-url>/scripts/setup.sh | bash
#   — or —
#   bash setup.sh
# ============================================================

REPO_URL="${REPO_URL:-https://github.com/sekkyoku/SecondBrain.git}"
INSTALL_DIR="${INSTALL_DIR:-$HOME/SecondBrain}"
SYNC_INTERVAL=300
PLIST_LABEL="com.secondbrain.sync"
PLIST_PATH="$HOME/Library/LaunchAgents/${PLIST_LABEL}.plist"

echo ""
echo "=== SecondBrain Setup ==="
echo ""

# --- Preflight ---
if ! command -v git &>/dev/null; then
    echo "Error: git is not installed."
    echo "  Install it: https://git-scm.com or run: xcode-select --install"
    exit 1
fi

# --- Clone or update ---
if [ -d "$INSTALL_DIR/.git" ]; then
    echo "Repo exists at $INSTALL_DIR — pulling latest…"
    git -C "$INSTALL_DIR" pull --ff-only || true
else
    echo "Cloning vault to $INSTALL_DIR…"
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# --- Make sync script executable ---
chmod +x "$INSTALL_DIR/scripts/sync.sh"

# --- Install Launch Agent ---
launchctl unload "$PLIST_PATH" 2>/dev/null || true

mkdir -p "$HOME/Library/LaunchAgents"

cat > "$PLIST_PATH" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${PLIST_LABEL}</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>${INSTALL_DIR}/scripts/sync.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>${SYNC_INTERVAL}</integer>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>${INSTALL_DIR}/scripts/sync.log</string>
    <key>StandardErrorPath</key>
    <string>${INSTALL_DIR}/scripts/sync.log</string>
</dict>
</plist>
EOF

launchctl load "$PLIST_PATH"

echo ""
echo "=== Done ==="
echo ""
echo "  Vault location:  $INSTALL_DIR"
echo "  Auto-sync:       every 5 minutes"
echo "  Sync log:        $INSTALL_DIR/scripts/sync.log"
echo ""
echo "  Next step: Open Claude Code Desktop → open folder → $INSTALL_DIR"
echo ""
