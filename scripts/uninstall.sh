#!/bin/bash
# Remove the SecondBrain auto-sync agent (macOS)

PLIST_LABEL="com.secondbrain.sync"
PLIST_PATH="$HOME/Library/LaunchAgents/${PLIST_LABEL}.plist"

launchctl unload "$PLIST_PATH" 2>/dev/null
rm -f "$PLIST_PATH"

echo "Auto-sync removed."
echo "To also delete the vault: rm -rf ~/SecondBrain"
