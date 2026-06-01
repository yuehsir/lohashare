@echo off
chcp 65001 >nul
setlocal

echo LOHAShare AI Platform - 00_Main_PRD reorganization
echo This script should be placed and run inside:
echo docs\LOHAShare_AI_Platform\00_Main_PRD
echo.

if not exist "Current" mkdir "Current"
if not exist "99_Archive" mkdir "99_Archive"
if not exist "v2_Clean_Version_Workspace" mkdir "v2_Clean_Version_Workspace"
if not exist "..\01_Architecture_Governance\02_Modular_Architecture\99_Archive" mkdir "..\01_Architecture_Governance\02_Modular_Architecture\99_Archive"

echo Moving current PRD to Current...
if exist "LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.5_Naming_Hierarchy_Update_20260530.docx" move /Y "LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.5_Naming_Hierarchy_Update_20260530.docx" "Current\"

echo Moving old PRD versions to 99_Archive...
if exist "LOHAShare AI 商務網站營運控制台 PRD v1.1.docx" move /Y "LOHAShare AI 商務網站營運控制台 PRD v1.1.docx" "99_Archive\"
if exist "LOHAShare AI 商務網站營運控制台 PRD v1.2 — 需求釐清後版本.docx" move /Y "LOHAShare AI 商務網站營運控制台 PRD v1.2 — 需求釐清後版本.docx" "99_Archive\"
if exist "LOHAShare AI 商務網站營運控制台 PRD v1.3.docx" move /Y "LOHAShare AI 商務網站營運控制台 PRD v1.3.docx" "99_Archive\"
if exist "LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.3_full_v1.2_retained_20260530.docx" move /Y "LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.3_full_v1.2_retained_20260530.docx" "99_Archive\"
if exist "LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.4_Modular_Governance_Update_20260530.docx" move /Y "LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.4_Modular_Governance_Update_20260530.docx" "99_Archive\"

echo Moving non-PRD modular governance file to Architecture Governance archive...
if exist "LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.0_20260530.docx" move /Y "LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.0_20260530.docx" "..\01_Architecture_Governance\02_Modular_Architecture\99_Archive\"

echo.
echo Done. Please review:
echo - 00_Main_PRD\Current should contain only the confirmed current main PRD.
echo - 00_Main_PRD\99_Archive should contain older main PRD versions.
echo - Modular architecture governance file should be moved out of 00_Main_PRD.
echo.
pause
