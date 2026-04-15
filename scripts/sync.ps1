# ============================================================
# SecondBrain — Bidirectional Auto-Sync (Windows)
#
# What this does (in order):
#   1. Stashes any uncommitted local changes
#   2. Pulls latest from origin (fast-forward)
#   3. Re-applies the stash
#   4. Auto-commits anything new under vault\
#   5. Pushes to origin
#
# Runs quietly via Task Scheduler every 5 minutes.
# End users never touch git.
# ============================================================

$ErrorActionPreference = "Continue"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoDir   = Split-Path -Parent $ScriptDir
$Log       = Join-Path $ScriptDir "sync.log"
$Lock      = Join-Path $ScriptDir ".sync.lock"

function Log($msg) {
    "$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))  $msg" | Out-File -FilePath $Log -Append -Encoding utf8
}

Set-Location $RepoDir

# Skip if another sync is still running (stale locks older than 10 min are ignored)
if (Test-Path $Lock) {
    $age = (Get-Date) - (Get-Item $Lock).LastWriteTime
    if ($age.TotalMinutes -lt 10) { Log "skip: previous sync still running"; exit 0 }
}
"$PID" | Out-File $Lock -Encoding ascii

try {
    # Ensure identity is set
    if (-not (git config user.email))  { git config user.email "secondbrain@localhost" | Out-Null }
    if (-not (git config user.name))   { git config user.name  "SecondBrain Sync"      | Out-Null }

    # Stash local changes so pull can fast-forward
    $stashed = $false
    $dirty = (git status --porcelain) -ne $null
    if ($dirty) {
        git stash push -u -m "auto-sync $(Get-Date -Format o)" 2>&1 | Out-File $Log -Append
        $stashed = $true
    }

    # Pull latest
    git pull --ff-only origin main 2>&1 | Out-File $Log -Append
    if ($LASTEXITCODE -ne 0) {
        Log "WARN: pull failed — leaving tree as-is for manual review"
        if ($stashed) { git stash pop 2>&1 | Out-File $Log -Append }
        exit 0
    }

    # Re-apply stashed work
    if ($stashed) {
        git stash pop 2>&1 | Out-File $Log -Append
        if ($LASTEXITCODE -ne 0) {
            Log "WARN: stash pop had conflicts — left in stash for manual review"
            exit 0
        }
    }

    # Auto-commit local edits under vault\
    git add -A vault/ 2>&1 | Out-File $Log -Append
    $staged = (git diff --cached --name-only) -ne $null
    if ($staged) {
        $host_short = $env:COMPUTERNAME
        git commit -m "auto-sync: vault update from $host_short $(Get-Date -Format o)" 2>&1 | Out-File $Log -Append
    }

    # Push
    git push origin main 2>&1 | Out-File $Log -Append
    if ($LASTEXITCODE -ne 0) { Log "WARN: push failed — will retry next interval" }

    Log "ok"
}
finally {
    Remove-Item $Lock -ErrorAction SilentlyContinue
}
