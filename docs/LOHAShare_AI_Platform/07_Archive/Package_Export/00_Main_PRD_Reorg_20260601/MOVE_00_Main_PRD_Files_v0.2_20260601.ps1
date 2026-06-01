# LOHAShare AI Platform - 00_Main_PRD reorganization fix v0.2
# Purpose:
# - Safely move files with spaces, Chinese characters, and special characters.
# - Can be run multiple times safely.
# - Run this script inside: docs\LOHAShare_AI_Platform\00_Main_PRD

$ErrorActionPreference = "Stop"

Write-Host "LOHAShare AI Platform - 00_Main_PRD reorganization fix v0.2" -ForegroundColor Cyan
Write-Host "Working directory:" (Get-Location)
Write-Host ""

# Ensure target folders exist
$folders = @(
  "Current",
  "99_Archive",
  "v2_Clean_Version_Workspace",
  "..\01_Architecture_Governance\02_Modular_Architecture\99_Archive"
)

foreach ($folder in $folders) {
  if (-not (Test-Path -LiteralPath $folder)) {
    New-Item -ItemType Directory -Path $folder | Out-Null
    Write-Host "Created folder: $folder"
  }
}

# Helper function
function Move-IfExists {
  param(
    [Parameter(Mandatory=$true)][string]$Source,
    [Parameter(Mandatory=$true)][string]$DestinationFolder
  )

  if (Test-Path -LiteralPath $Source) {
    if (-not (Test-Path -LiteralPath $DestinationFolder)) {
      New-Item -ItemType Directory -Path $DestinationFolder | Out-Null
    }

    $destinationPath = Join-Path $DestinationFolder (Split-Path $Source -Leaf)
    Move-Item -LiteralPath $Source -Destination $destinationPath -Force
    Write-Host "Moved:" $Source "->" $DestinationFolder -ForegroundColor Green
  } else {
    Write-Host "Skipped, not found:" $Source -ForegroundColor DarkGray
  }
}

Write-Host "Moving current PRD to Current..." -ForegroundColor Yellow
Move-IfExists `
  -Source "LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.5_Naming_Hierarchy_Update_20260530.docx" `
  -DestinationFolder "Current"

Write-Host ""
Write-Host "Moving old PRD versions to 99_Archive..." -ForegroundColor Yellow
Move-IfExists `
  -Source "LOHAShare AI 商務網站營運控制台 PRD v1.1.docx" `
  -DestinationFolder "99_Archive"

Move-IfExists `
  -Source "LOHAShare AI 商務網站營運控制台 PRD v1.2 — 需求釐清後版本.docx" `
  -DestinationFolder "99_Archive"

Move-IfExists `
  -Source "LOHAShare AI 商務網站營運控制台 PRD v1.3.docx" `
  -DestinationFolder "99_Archive"

Move-IfExists `
  -Source "LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.3_full_v1.2_retained_20260530.docx" `
  -DestinationFolder "99_Archive"

Move-IfExists `
  -Source "LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.4_Modular_Governance_Update_20260530.docx" `
  -DestinationFolder "99_Archive"

Write-Host ""
Write-Host "Moving non-PRD modular governance file to Architecture Governance archive..." -ForegroundColor Yellow
Move-IfExists `
  -Source "LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.0_20260530.docx" `
  -DestinationFolder "..\01_Architecture_Governance\02_Modular_Architecture\99_Archive"

Write-Host ""
Write-Host "Review result:" -ForegroundColor Cyan
Write-Host "- 00_Main_PRD\Current should contain the confirmed current main PRD."
Write-Host "- 00_Main_PRD\99_Archive should contain older main PRD versions."
Write-Host "- Modular architecture governance file should be moved out of 00_Main_PRD."
Write-Host ""
Write-Host "Done." -ForegroundColor Green
