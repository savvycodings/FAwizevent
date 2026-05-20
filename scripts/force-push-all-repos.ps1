# Force-push WizEvent code to all three GitHub repos.
# Requires GitHub auth as a user with write access to savvycodings/* repos.
#
# Layout:
#   FA  FAwizevent/          -> savvycodings/FAwizevent   (root + submodule pointers)
#   FE  FAwizevent/app/      -> savvycodings/FEwizevent   (own git remote)
#   BE  FAwizevent/server/   -> savvycodings/BEwizevent   (own git remote)
#
# Usage (from FA root):
#   powershell -ExecutionPolicy Bypass -File .\scripts\force-push-all-repos.ps1

$ErrorActionPreference = "Stop"
$Root = Split-Path $PSScriptRoot -Parent

Write-Host "FAwizevent root: $Root"

# 1) FE — push from app/
Set-Location (Join-Path $Root "app")
git remote set-url origin https://github.com/savvycodings/FEwizevent.git
git push --force origin main
Write-Host "OK: FEwizevent (app/)"

# 2) BE — push from server/
Set-Location (Join-Path $Root "server")
git remote set-url origin https://github.com/savvycodings/BEwizevent.git
git push --force origin main
Write-Host "OK: BEwizevent (server/)"

# 3) FA root — push monorepo (records submodule commits)
Set-Location $Root
if (git status --porcelain) {
    Write-Host "FAwizevent: commit or stash root changes before pushing."
    exit 1
}
git remote set-url origin https://github.com/savvycodings/FAwizevent.git
git push --force origin main
Write-Host "OK: FAwizevent (root)"

Write-Host "All three repos force-pushed."
