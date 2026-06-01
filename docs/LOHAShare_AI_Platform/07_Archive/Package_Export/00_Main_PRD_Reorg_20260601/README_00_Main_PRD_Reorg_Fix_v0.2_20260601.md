# 00_Main_PRD Reorganization Fix v0.2

## Why this fix exists

The previous `.bat` script may fail on Windows when filenames contain:
- spaces
- Traditional Chinese characters
- special punctuation such as em dash `—`

This version uses PowerShell `Move-Item -LiteralPath`, which is safer for Unicode filenames and spaces.

## Files included

- `MOVE_00_Main_PRD_Files_v0.2_20260601.ps1`
- `RUN_MOVE_00_Main_PRD_Files_v0.2_20260601.bat`

## How to use

1. Copy both files into:
   `docs\LOHAShare_AI_Platform\00_Main_PRD\`

2. Double-click:
   `RUN_MOVE_00_Main_PRD_Files_v0.2_20260601.bat`

3. Review:
   - `Current/`
   - `99_Archive/`
   - `..\01_Architecture_Governance\02_Modular_Architecture\99_Archive\`

4. Commit / Push with GitHub Desktop.

5. Run GitHub Actions:
   - Docs Governance Check
   - Docs Package

## Important

Do not run the old `MOVE_00_Main_PRD_Files_v0.1_20260601.bat` again.
