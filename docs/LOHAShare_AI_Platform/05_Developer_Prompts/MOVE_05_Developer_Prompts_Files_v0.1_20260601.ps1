# LOHAShare AI Platform - 05_Developer_Prompts reorganization v0.1
# Run this script inside: docs\LOHAShare_AI_Platform\05_Developer_Prompts

$ErrorActionPreference = "Stop"

Write-Host "LOHAShare AI Platform - 05_Developer_Prompts reorganization v0.1" -ForegroundColor Cyan
Write-Host "Working directory:" (Get-Location)
Write-Host ""

$folders = @(
  "DocOps_MVP\Current",
  "DocOps_MVP\99_Archive",
  "Email_Notification\Fallback_POC\Current",
  "Email_Notification\Fallback_POC\99_Archive",
  "..\07_Archive\Package_Export\05_Developer_Prompts_Reorg_20260601"
)

foreach ($folder in $folders) {
  if (-not (Test-Path -LiteralPath $folder)) {
    New-Item -ItemType Directory -Path $folder | Out-Null
    Write-Host "Created folder: $folder"
  }
}

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

Write-Host "Moving DocOps MVP Prompt to Current..." -ForegroundColor Yellow
Move-IfExists `
  -Source "DocOps_MVP\LOHAShare_DocOps_MVP_n8n_Workflow_Build_Prompt_v0.1_20260530.docx" `
  -DestinationFolder "DocOps_MVP\Current"

Write-Host ""
Write-Host "Moving Email Fallback POC Prompt to Current..." -ForegroundColor Yellow
Move-IfExists `
  -Source "Email_Notification\Fallback_POC\Replit_Email_Fallback_Provider_Test_Console_Prompt_v0.1_20260530.md" `
  -DestinationFolder "Email_Notification\Fallback_POC\Current"

Write-Host ""
Write-Host "Moving helper files to 07_Archive Package_Export..." -ForegroundColor Yellow
Move-IfExists `
  -Source "05_Developer_Prompts_File_Move_Map_v0.1_20260601.csv" `
  -DestinationFolder "..\07_Archive\Package_Export\05_Developer_Prompts_Reorg_20260601"

Move-IfExists `
  -Source "05_Developer_Prompts_File_Move_Map_v0.1_20260601.md" `
  -DestinationFolder "..\07_Archive\Package_Export\05_Developer_Prompts_Reorg_20260601"

Write-Host ""
Write-Host "Review result:" -ForegroundColor Cyan
Write-Host "- DocOps_MVP\Current should contain the current DocOps MVP prompt."
Write-Host "- Email_Notification\Fallback_POC\Current should contain the current Replit Email Fallback prompt."
Write-Host "- Helper move-map files should be archived under 07_Archive\Package_Export."
Write-Host ""
Write-Host "Done." -ForegroundColor Green
