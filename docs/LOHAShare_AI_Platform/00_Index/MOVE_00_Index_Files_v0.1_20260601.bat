@echo off
chcp 65001 >nul
setlocal

echo LOHAShare AI Platform - 00_Index reorganization
echo This script should be placed and run inside:
echo docs\LOHAShare_AI_Platform\00_Index
echo.

if not exist "Current" mkdir "Current"
if not exist "99_Archive" mkdir "99_Archive"

echo Moving known current versions to Current...
if exist "LOHAShare_AI_Platform_Current_Folder_Structure_v1.3_20260530.docx" move /Y "LOHAShare_AI_Platform_Current_Folder_Structure_v1.3_20260530.docx" "Current\"
if exist "LOHAShare_AI_Platform_New_Conversation_Handoff_v1.4_20260530.docx" move /Y "LOHAShare_AI_Platform_New_Conversation_Handoff_v1.4_20260530.docx" "Current\"
if exist "LOHAShare_AI_Platform_Document_System_Index_v1.8_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_System_Index_v1.8_20260530.docx" "Current\"

echo Moving older versions to 99_Archive...
for %%F in (LOHAShare_AI_Platform_Current_Folder_Structure_v*.docx) do (
  if not "%%~nxF"=="LOHAShare_AI_Platform_Current_Folder_Structure_v1.3_20260530.docx" move /Y "%%F" "99_Archive\"
)

for %%F in (LOHAShare_AI_Platform_New_Conversation_Handoff_v*.docx) do (
  if not "%%~nxF"=="LOHAShare_AI_Platform_New_Conversation_Handoff_v1.4_20260530.docx" move /Y "%%F" "99_Archive\"
)

for %%F in (LOHAShare_AI_Platform_Document_System_Index_v*.docx) do (
  if not "%%~nxF"=="LOHAShare_AI_Platform_Document_System_Index_v1.8_20260530.docx" move /Y "%%F" "99_Archive\"
)

echo.
echo Done. Please manually review:
echo - Current folder should contain only the latest 3 index files.
echo - 99_Archive should contain older versions.
echo - If any newer version exists, move it manually into Current and move the older one to 99_Archive.
echo.
pause
