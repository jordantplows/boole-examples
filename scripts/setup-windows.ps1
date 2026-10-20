# Windows setup check for the published Boole CLI. Does not vendor the CLI.
$ErrorActionPreference = 'Stop'
Write-Host "Boole setup (Windows)"
Write-Host ("{0} {1}" -f $env:OS, $env:PROCESSOR_ARCHITECTURE)

function Show-NodeHint {
  Write-Host "Node.js 22 or newer is required (@boole/cli 0.7.0)."
  Write-Host "Install it from https://nodejs.org/"
  Write-Host "Or: winget install --id OpenJS.NodeJS.LTS"
}

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "node was not found on PATH."
  Show-NodeHint
  exit 1
}
$major = [int](node -p "process.versions.node.split('.')[0]")
Write-Host ("Node " + (node -v))
if ($major -lt 22) {
  Write-Host "This Node.js is older than 22."
  Show-NodeHint
  exit 1
}
Write-Host "Running boole doctor via npx. This contacts the npm registry."
npx --yes @boole/cli@latest doctor
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host ""
Write-Host "Commands: boole run, boole pull, boole serve, boole list, boole doctor, boole models."
Write-Host "boole serve is for local development only. It has no authentication."
Write-Host "x64 notes: https://boole.sh/guides/windows-x64/"
Write-Host "arm64 notes: https://boole.sh/guides/windows-arm64/"
