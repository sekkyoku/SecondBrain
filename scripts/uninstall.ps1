# Remove the SecondBrain auto-sync task (Windows)

Unregister-ScheduledTask -TaskName "SecondBrainSync" -Confirm:$false -ErrorAction SilentlyContinue

Write-Host "Auto-sync removed."
Write-Host "To also delete the vault: Remove-Item -Recurse $env:USERPROFILE\SecondBrain"
