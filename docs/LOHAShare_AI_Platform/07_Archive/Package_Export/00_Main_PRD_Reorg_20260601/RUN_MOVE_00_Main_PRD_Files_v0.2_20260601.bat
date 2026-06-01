@echo off
chcp 65001 >nul
echo Running PowerShell reorganization script...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0MOVE_00_Main_PRD_Files_v0.2_20260601.ps1"
pause
