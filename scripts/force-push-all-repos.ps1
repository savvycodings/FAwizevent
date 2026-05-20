# Force-push WizEvent code to all three GitHub repos.
# Requires GitHub auth as a user with write access to savvycodings/* repos.
#
# Usage (from repo root):
#   powershell -ExecutionPolicy Bypass -File .\scripts\force-push-all-repos.ps1

$ErrorActionPreference = "Stop"
$Root = Split-Path $PSScriptRoot -Parent

Write-Host "FAwizevent root: $Root"

# 1) Monorepo (app + server + root files)
Set-Location $Root
if (-not (git status --porcelain)) {
    Write-Host "FAwizevent: working tree clean."
} else {
    Write-Host "FAwizevent: uncommitted changes — commit first, then re-run."
    exit 1
}
git remote set-url origin https://github.com/savvycodings/FAwizevent.git
git push --force origin main
Write-Host "OK: FAwizevent"

# 2) Backend-only repo
$BeTemp = Join-Path $env:TEMP "bewizevent-push-$(Get-Random)"
New-Item -ItemType Directory -Path $BeTemp | Out-Null
try {
    cmd /c "robocopy `"$(Join-Path $Root 'server')`" `"$BeTemp`" /E /XD node_modules .git /NFL /NDL /NJH /NJS"
    Set-Location $BeTemp
    git init -b main | Out-Null
    git add -A
    git commit -m "Replace backend with WizEvent API (force sync from FAwizevent/server)."
    git remote add origin https://github.com/savvycodings/BEwizevent.git
    git push --force origin main
    Write-Host "OK: BEwizevent"
} finally {
    Set-Location $Root
    Remove-Item -Recurse -Force $BeTemp -ErrorAction SilentlyContinue
}

# 3) Frontend-only repo
$FeTemp = Join-Path $env:TEMP "fewizevent-push-$(Get-Random)"
New-Item -ItemType Directory -Path $FeTemp | Out-Null
try {
    cmd /c "robocopy `"$(Join-Path $Root 'app')`" `"$FeTemp`" /E /XD node_modules .git /NFL /NDL /NJH /NJS"
    Set-Location $FeTemp
    git init -b main | Out-Null
    git add -A
    git commit -m "Replace frontend with WizEvent mobile app (force sync from FAwizevent/app)."
    git remote add origin https://github.com/savvycodings/FEwizevent.git
    git push --force origin main
    Write-Host "OK: FEwizevent"
} finally {
    Set-Location $Root
    Remove-Item -Recurse -Force $FeTemp -ErrorAction SilentlyContinue
}

Write-Host "All three repos force-pushed."
