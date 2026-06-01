@echo off
chcp 65001 >nul
echo Running PowerShell reorganization script...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0MOVE_05_Developer_Prompts_Files_v0.1_20260601.ps1"
pause
