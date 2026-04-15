# ============================================================
# SecondBrain — One-Time Setup (Windows)
#
# What this does:
#   1. Clones the vault to ~\SecondBrain
#   2. Installs a Scheduled Task that auto-pulls every 5 min
#
# Usage (run as Admin):
#   powershell -ExecutionPolicy Bypass -File setup.ps1
# ============================================================

$RepoUrl    = if ($env:REPO_URL)    { $env:REPO_URL }    else { "https://github.com/sekkyoku/SecondBrain.git" }
$InstallDir = if ($env:INSTALL_DIR) { $env:INSTALL_DIR } else { "$env:USERPROFILE\SecondBrain" }
$TaskName   = "SecondBrainSync"

Write-Host ""
Write-Host "=== SecondBrain Setup ===" -ForegroundColor Cyan
Write-Host ""

# --- Preflight ---
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Error: git is not installed. Get it from https://git-scm.com" -ForegroundColor Red
    exit 1
}

# --- Clone or update ---
if (Test-Path "$InstallDir\.git") {
    Write-Host "Repo exists at $InstallDir — pulling latest..."
    git -C $InstallDir pull --ff-only
} else {
    Write-Host "Cloning vault to $InstallDir..."
    git clone $RepoUrl $InstallDir
}

# --- Install Scheduled Task ---
Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue

$SyncScript = Join-Path $InstallDir "scripts\sync.ps1"
$Action   = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$SyncScript`""
$Trigger  = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)
$Settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -DontStopOnIdleEnd

Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Settings $Settings -Description "Auto-sync SecondBrain vault"

Write-Host ""
Write-Host "=== Done ===" -ForegroundColor Green
Write-Host ""
Write-Host "  Vault location:  $InstallDir"
Write-Host "  Auto-sync:       every 5 minutes"
Write-Host ""
Write-Host "  Next step: Open Claude Code Desktop -> open folder -> $InstallDir"
Write-Host ""
