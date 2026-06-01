@echo off
chcp 65001 >nul
setlocal
echo LOHAShare AI Platform - Architecture Governance file classification
echo This script should be placed and run inside docs\LOHAShare_AI_Platform\01_Architecture_Governance
echo.
if not exist "00_Current_Index\Current" mkdir "00_Current_Index\Current"
if not exist "00_Current_Index\99_Archive" mkdir "00_Current_Index\99_Archive"
if not exist "01_Document_Governance\Current" mkdir "01_Document_Governance\Current"
if not exist "01_Document_Governance\99_Archive" mkdir "01_Document_Governance\99_Archive"
if not exist "02_Modular_Architecture\Current" mkdir "02_Modular_Architecture\Current"
if not exist "02_Modular_Architecture\99_Archive" mkdir "02_Modular_Architecture\99_Archive"
if not exist "03_Automation_DocOps\Current" mkdir "03_Automation_DocOps\Current"
if not exist "03_Automation_DocOps\99_Archive" mkdir "03_Automation_DocOps\99_Archive"
if not exist "04_Content_Quality_and_Consolidation\Current" mkdir "04_Content_Quality_and_Consolidation\Current"
if not exist "04_Content_Quality_and_Consolidation\99_Archive" mkdir "04_Content_Quality_and_Consolidation\99_Archive"
if not exist "05_Support_KB_Governance\Current" mkdir "05_Support_KB_Governance\Current"
if not exist "05_Support_KB_Governance\99_Archive" mkdir "05_Support_KB_Governance\99_Archive"
if not exist "06_Tooling_and_Escalation\Current" mkdir "06_Tooling_and_Escalation\Current"
if not exist "06_Tooling_and_Escalation\99_Archive" mkdir "06_Tooling_and_Escalation\99_Archive"
if not exist "07_Visuals\Current" mkdir "07_Visuals\Current"
if not exist "07_Visuals\99_Archive" mkdir "07_Visuals\99_Archive"
if not exist "00_Current_Index" mkdir "00_Current_Index"

if exist "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.8_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.8_20260530.docx" "01_Document_Governance\Current\"
if exist "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.0_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.0_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.1_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.1_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.2_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.2_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.3_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.3_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.4_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.4_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.5_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.5_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.6_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.6_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.7_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Governance_and_Automation_Spec_v1.7_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Governance_Rules_v0.2_20260530.md" move /Y "LOHAShare_AI_Platform_Document_Governance_Rules_v0.2_20260530.md" "01_Document_Governance\Current\"
if exist "LOHAShare_AI_Platform_Folder_and_File_Management_Rules_v1.2_20260530.docx" move /Y "LOHAShare_AI_Platform_Folder_and_File_Management_Rules_v1.2_20260530.docx" "01_Document_Governance\Current\"
if exist "LOHAShare_AI_Platform_Folder_and_File_Management_Rules_v1.0_20260530.docx" move /Y "LOHAShare_AI_Platform_Folder_and_File_Management_Rules_v1.0_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Folder_and_File_Management_Rules_v1.1_20260530.docx" move /Y "LOHAShare_AI_Platform_Folder_and_File_Management_Rules_v1.1_20260530.docx" "01_Document_Governance\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Format_Strategy_v0.1_20260601.docx" move /Y "LOHAShare_AI_Platform_Document_Format_Strategy_v0.1_20260601.docx" "01_Document_Governance\Current\"
if exist "LOHAShare_AI_Platform_Document_Format_Strategy_v0.1_20260601.md" move /Y "LOHAShare_AI_Platform_Document_Format_Strategy_v0.1_20260601.md" "01_Document_Governance\Current\"
if exist "LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.2_Naming_Hierarchy_Update_20260530.docx" move /Y "LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.2_Naming_Hierarchy_Update_20260530.docx" "02_Modular_Architecture\Current\"
if exist "LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.0_20260530.docx" move /Y "LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.0_20260530.docx" "02_Modular_Architecture\99_Archive\"
if exist "LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.1_Operational_Resilience_Update_20260530.docx" move /Y "LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.1_Operational_Resilience_Update_20260530.docx" "02_Modular_Architecture\99_Archive\"
if exist "LOHAShare_AI_Platform_Automation_Strategy_and_DocOps_Roadmap_v1.3_20260530.docx" move /Y "LOHAShare_AI_Platform_Automation_Strategy_and_DocOps_Roadmap_v1.3_20260530.docx" "03_Automation_DocOps\Current\"
if exist "LOHAShare_AI_Platform_Automation_Strategy_and_DocOps_Roadmap_v1.0_20260530.docx" move /Y "LOHAShare_AI_Platform_Automation_Strategy_and_DocOps_Roadmap_v1.0_20260530.docx" "03_Automation_DocOps\99_Archive\"
if exist "LOHAShare_AI_Platform_Automation_Strategy_and_DocOps_Roadmap_v1.1_20260530.docx" move /Y "LOHAShare_AI_Platform_Automation_Strategy_and_DocOps_Roadmap_v1.1_20260530.docx" "03_Automation_DocOps\99_Archive\"
if exist "LOHAShare_AI_Platform_Automation_Strategy_and_DocOps_Roadmap_v1.2_20260530.docx" move /Y "LOHAShare_AI_Platform_Automation_Strategy_and_DocOps_Roadmap_v1.2_20260530.docx" "03_Automation_DocOps\99_Archive\"
if exist "LOHAShare_AI_Platform_Document_Consolidation_Plan_v0.1_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Consolidation_Plan_v0.1_20260530.docx" "04_Content_Quality_and_Consolidation\Current\"
if exist "LOHAShare_AI_Platform_Document_Content_Quality_Rules_v0.1_20260530.docx" move /Y "LOHAShare_AI_Platform_Document_Content_Quality_Rules_v0.1_20260530.docx" "04_Content_Quality_and_Consolidation\Current\"
if exist "LOHAShare_AI_Platform_Support_Knowledge_Base_Management_Spec_v1.0_20260530.docx" move /Y "LOHAShare_AI_Platform_Support_Knowledge_Base_Management_Spec_v1.0_20260530.docx" "05_Support_KB_Governance\Current\"
if exist "LOHAShare_Engineering_Escalation_and_Tooling_Decision_Guide_v0.1_20260530.docx" move /Y "LOHAShare_Engineering_Escalation_and_Tooling_Decision_Guide_v0.1_20260530.docx" "06_Tooling_and_Escalation\Current\"
if exist "lohashare_ai_命名層級架構圖.png" move /Y "lohashare_ai_命名層級架構圖.png" "07_Visuals\Current\"

echo.
echo Done. Please review moved files, then commit and push with GitHub Desktop.
pause