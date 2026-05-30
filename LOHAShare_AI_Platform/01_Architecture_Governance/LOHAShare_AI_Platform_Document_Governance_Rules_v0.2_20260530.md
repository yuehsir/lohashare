# LOHAShare AI Platform Document Governance Rules v0.2

版本：v0.2  
日期：2026-05-30  
文件名稱：LOHAShare_AI_Platform_Document_Governance_Rules_v0.2_20260530.md  
建議存放位置：`LOHAShare_AI_Platform/01_Architecture_Governance/`  
文件定位：本文件是 LOHAShare AI Platform 的文件治理與分類判斷規則，用於補強「Current Folder Structure」文件。  

---

## 1. 文件目的

本文件用來定義 LOHAShare AI Platform 在不同對話、不同 AI 工具、不同開發平台、不同自動化流程與不同文件輸出流程中，如何判斷文件應放置的位置、如何避免資料夾命名不一致、如何處理 Prompt 正本、如何管理模組文件，以及如何處理已建立但不一致的資料夾。

本文件不是單一模組規格書，也不是資料夾清單；它是「判斷規則」。

與本文件搭配使用的資料夾基準文件為：

`LOHAShare_AI_Platform_Current_Folder_Structure_v1.2_20260530.docx`

---

## 2. 最高優先原則

未來不同對話、不同 AI 工具、不同自動化流程、不同開發平台或不同文件輸出流程，若產生資料夾分類、命名、文件正本位置、Prompt 歸檔位置或版本管理衝突，應先以最新版的：

1. `LOHAShare_AI_Platform_Current_Folder_Structure`
2. `LOHAShare_AI_Platform_Document_Governance_Rules`

為準。

不得因單次對話、單一工具建議、臨時需求、AI Agent 自動產生內容或個別專案操作方便，而任意新增平行資料夾結構。

若現有治理文件無法涵蓋新情境，應先提出「治理文件更新需求」，確認後再更新治理文件，而不是直接建立新的分類。

---

## 3. 本文件與 Current Folder Structure 的分工

| 文件 | 主要用途 |
|---|---|
| Current Folder Structure | 定義目前正式採用的資料夾結構長什麼樣子 |
| Document Governance Rules | 定義未來遇到新文件、新工具、新情境、新衝突時，如何判斷文件應放哪裡 |

簡單說：

- `Current Folder Structure` 是「目前的正式資料夾基準」。
- `Document Governance Rules` 是「以後判斷與維護資料夾的規則」。

---

## 4. 標準根目錄分類

LOHAShare AI Platform 的標準根目錄如下：

```text
LOHAShare_AI_Platform/
├─ 00_Index/
├─ 00_Main_PRD/
├─ 01_Architecture_Governance/
├─ 02_Modules/
├─ 03_SOP_and_QA/
├─ 04_Support_Knowledge_Base/
├─ 05_Developer_Prompts/
├─ 06_Release_Notes/
└─ 07_Archive/
```

不得任意建立下列平行主目錄：

```text
LOHAShare_AI_System/
Nexus_Lead_Ops_Files/
Email_Fallback_Documents/
Replit_Project_Notes/
AI_Project_Files/
```

除非先更新本治理文件與 Current Folder Structure 文件。

---

## 5. 根目錄用途定義

### 5.1 `00_Index/`

用途：整體索引、文件導覽、最新版本入口、模組入口、常用文件清單。

適合放置：

- Master Document Index
- 最新版本索引
- 文件導覽表
- 模組路徑對照表

---

### 5.2 `00_Main_PRD/`

用途：平台級或產品主線 PRD 正本。

適合放置：

- LOHAShare AI Platform 主 PRD
- Nexus Lead Ops 主 PRD
- 主產品 Roadmap
- 主 PRD 版本歷史

不適合放置：

- 單一模組測試紀錄
- 單一 provider POC CSV
- Replit Prompt

---

### 5.3 `01_Architecture_Governance/`

用途：架構治理、文件治理、命名規則、版本治理、資料夾治理、權限治理。

適合放置：

- Current Folder Structure
- Document Governance Rules
- Folder Naming Rules
- Version Control Rules
- Architecture Governance
- Support KB 管理規範

本文件應放在此資料夾。

---

### 5.4 `02_Modules/`

用途：功能模組本體文件、模組規格、模組測試紀錄、模組決策紀錄、模組證據資料。

適合放置：

- 模組規格
- POC 測試 CSV
- 測試截圖
- 決策紀錄
- Provider notes
- 模組索引
- 模組技術說明

不適合放置：

- Developer Prompt 正本
- Support ticket 正本
- 緊急處理 SOP 正本

---

### 5.5 `03_SOP_and_QA/`

用途：標準作業流程、緊急處理流程、操作問答、內部 QA。

適合放置：

- Email Emergency Playbook
- 發信異常處理 SOP
- DNS 不動原則
- Provider fallback 啟動前檢查表
- 非工程人員操作指南

---

### 5.6 `04_Support_Knowledge_Base/`

用途：Support 往來、錯誤排查、已知問題、已解決案例、Debug history。

適合放置：

- Lovable Support Tickets
- Email Delivery Support Log
- Provider Debug History
- Known Issues FAQ
- Resolved Cases

不適合放置：

- 管理規範正本
- Developer Prompt 正本
- 模組 POC 測試 CSV 正本

---

### 5.7 `05_Developer_Prompts/`

用途：所有給 AI 開發工具或 AI Agent 使用的提示詞正本。

適合放置：

- Replit Prompt
- Lovable Prompt
- Claude Prompt
- Codex Prompt
- Gemini Prompt
- Supabase SQL Prompt
- Bugfix Prompt
- UI 修正 Prompt

重要規則：

Prompt 正本一律放在 `05_Developer_Prompts/`。  
不得放在 `02_Modules/` 的子資料夾內作為正本。

---

### 5.8 `06_Release_Notes/`

用途：版本發布紀錄、變更摘要、MVP 完成紀錄、bugfix release note。

適合放置：

- v0.1 MVP 完成紀錄
- v0.2 修正紀錄
- v1.0 發布紀錄
- Production candidate 判斷摘要

---

### 5.9 `07_Archive/`

用途：舊版、棄用、過期、不一致但暫不刪除的資料夾與文件。

適合放置：

- Deprecated Folder Structures
- 舊版文件
- 過期 Prompt
- 舊測試紀錄
- 不再採用的架構草案
- Package Export

---

## 6. 單一正本原則

每一份文件只能有一個正本位置。

如其他資料夾需要引用該文件，只能在 Index 或 Module Index 內放置路徑說明，不得複製同一份文件到不同分類資料夾。

### 範例

Replit Email Fallback Provider Test Console Prompt 正本應放在：

```text
LOHAShare_AI_Platform/
  05_Developer_Prompts/
    Email_Notification/
      Fallback_POC/
```

不得另外複製到：

```text
LOHAShare_AI_Platform/
  02_Modules/
    Email_Notification/
      Fallback_POC/
        Developer_Prompts/
```

---

## 7. Prompt 管理規則

### 7.1 Prompt 正本位置

所有 Prompt 正本統一放在：

```text
LOHAShare_AI_Platform/
  05_Developer_Prompts/
```

### 7.2 Prompt 分類方式

依模組與用途分類，例如：

```text
05_Developer_Prompts/
├─ DocOps_MVP/
└─ Email_Notification/
   └─ Fallback_POC/
```

如 Prompt 數量增加，可再依工具分類：

```text
05_Developer_Prompts/
└─ Email_Notification/
   └─ Fallback_POC/
      ├─ Replit/
      ├─ Lovable/
      ├─ Claude/
      ├─ Codex/
      └─ Gemini/
```

少量時不必過度拆分。

### 7.3 Prompt 命名格式

建議格式：

```text
{Tool}_{Module}_{Purpose}_Prompt_v{version}_{YYYYMMDD}.md
```

範例：

```text
Replit_Email_Fallback_Provider_Test_Console_Prompt_v0.1_20260530.md
Replit_Email_Fallback_Status_Logic_Bugfix_Prompt_v0.1_20260530.md
Lovable_Email_Notification_Queue_Debug_Prompt_v0.1_20260530.md
```

---

## 8. 模組文件管理規則

模組文件放在：

```text
LOHAShare_AI_Platform/
  02_Modules/
```

以 Email Notification / Fallback POC 為例：

```text
LOHAShare_AI_Platform/
  02_Modules/
    Email_Notification/
      Fallback_POC/
        00_Module_Index/
        01_POC_Test_Logs/
        02_Screenshots/
        03_Decision_Records/
        04_Provider_Notes/
        05_Module_Specs/
```

### 8.1 `00_Module_Index/`

用途：模組索引、模組文件入口、相關 Prompt 路徑索引。

### 8.2 `01_POC_Test_Logs/`

用途：POC 測試紀錄，如 CSV。

範例：

```text
LOHAShare_Email_Fallback_POC_Resend_TestLog_20260530_v0.1.csv
```

### 8.3 `02_Screenshots/`

用途：測試截圖、成功畫面、錯誤畫面、收件端證據截圖。

### 8.4 `03_Decision_Records/`

用途：決策紀錄，說明測試背景、測試結果、限制、下一步。

### 8.5 `04_Provider_Notes/`

用途：Provider 限制、API notes、DNS notes、pricing notes、from domain notes。

### 8.6 `05_Module_Specs/`

用途：模組規格、欄位設計、UI 設計、adapter 架構、資料表設計。

---

## 9. Email Fallback POC 專用歸檔規則

### 9.1 CSV 測試紀錄

放置位置：

```text
LOHAShare_AI_Platform/
  02_Modules/
    Email_Notification/
      Fallback_POC/
        01_POC_Test_Logs/
```

### 9.2 截圖

放置位置：

```text
LOHAShare_AI_Platform/
  02_Modules/
    Email_Notification/
      Fallback_POC/
        02_Screenshots/
```

### 9.3 決策紀錄

放置位置：

```text
LOHAShare_AI_Platform/
  02_Modules/
    Email_Notification/
      Fallback_POC/
        03_Decision_Records/
```

### 9.4 Provider Notes

放置位置：

```text
LOHAShare_AI_Platform/
  02_Modules/
    Email_Notification/
      Fallback_POC/
        04_Provider_Notes/
```

### 9.5 Module Specs

放置位置：

```text
LOHAShare_AI_Platform/
  02_Modules/
    Email_Notification/
      Fallback_POC/
        05_Module_Specs/
```

### 9.6 Developer Prompts

放置位置：

```text
LOHAShare_AI_Platform/
  05_Developer_Prompts/
    Email_Notification/
      Fallback_POC/
```

---

## 10. 命名規則

### 10.1 資料夾命名

採用：

```text
英文首字大寫 + 底線
```

正確範例：

```text
Email_Notification
Fallback_POC
Lead_Console
Provider_Debug_History
Known_Issues_FAQ
Package_Export
```

避免使用：

```text
email-notification
email-fallback-provider-test-console
lead-console
provider_notes
```

### 10.2 文件命名

建議格式：

```text
{Project_or_Module}_{Document_Type}_{Topic}_v{version}_{YYYYMMDD}.{ext}
```

範例：

```text
Email_Fallback_POC_Decision_Record_20260530_v0.1.md
LOHAShare_Email_Fallback_POC_Resend_TestLog_20260530_v0.1.csv
Replit_Email_Fallback_Status_Logic_Bugfix_Prompt_v0.1_20260530.md
```

避免：

```text
最新版.md
最終版.docx
測試紀錄.csv
新資料.docx
```

---

## 11. 文件分類判斷規則

當不知道文件該放哪裡時，請先問以下問題：

| 判斷問題 | 放置位置 |
|---|---|
| 這是整體索引或入口嗎？ | `00_Index/` |
| 這是平台或產品主 PRD 嗎？ | `00_Main_PRD/` |
| 這是治理規則、命名規則、架構規則嗎？ | `01_Architecture_Governance/` |
| 這是模組規格、測試 CSV、截圖、決策紀錄嗎？ | `02_Modules/` |
| 這是 SOP、操作流程、緊急處理指南嗎？ | `03_SOP_and_QA/` |
| 這是 Support ticket、debug log、known issue 嗎？ | `04_Support_Knowledge_Base/` |
| 這是給 Replit / Lovable / Claude / Codex / Gemini 的提示詞嗎？ | `05_Developer_Prompts/` |
| 這是版本發布摘要嗎？ | `06_Release_Notes/` |
| 這是舊版、棄用、錯誤結構或過期資料嗎？ | `07_Archive/` |

---

## 12. 治理衝突處理流程

若未來出現資料夾分類衝突、工具產生錯誤分類、AI 建議新分類、或自動化流程輸出到錯誤位置，請依以下流程處理：

1. 先查最新版 `Current Folder Structure`。
2. 再查最新版 `Document Governance Rules`。
3. 判斷文件性質。
4. 若已有正式分類，依正式分類歸檔。
5. 若沒有正式分類，不直接新增資料夾。
6. 先提出「治理文件更新需求」。
7. 確認後更新治理文件。
8. 再更新資料夾結構。
9. 舊資料夾若已建立，先搬移內容，再標記 Deprecated 或移入 Archive。
10. 不得繼續往錯誤資料夾放新文件。

---

## 13. 不一致資料夾處理規則

已建立但不一致的資料夾，不應直接刪除，應先遷移，再封存。

### 舊資料夾範例

```text
LOHAShare_AI_Platform/
  02_Modules/
    email-notification/
      email-fallback-provider-test-console/
```

### 處理方式

1. 建立正式資料夾。
2. 將內容依文件性質搬移至正式位置。
3. 確認無遺漏。
4. 將舊資料夾改名為：

```text
_email-notification_DEPRECATED_20260530
```

或移至：

```text
LOHAShare_AI_Platform/
  07_Archive/
    Deprecated_Folder_Structures/
      email-notification_DEPRECATED_20260530/
```

5. 不得再使用舊資料夾。

---

## 14. 舊資料夾遷移對照表

| 舊位置 | 新位置 |
|---|---|
| `00_Index/` | `02_Modules/Email_Notification/Fallback_POC/00_Module_Index/` |
| `01_POC_Test_Logs/` | `02_Modules/Email_Notification/Fallback_POC/01_POC_Test_Logs/` |
| `02_Screenshots/` | `02_Modules/Email_Notification/Fallback_POC/02_Screenshots/` |
| `03_Replit_Project_Notes/` | 依內容拆分至 `00_Module_Index/` 或 `05_Module_Specs/` |
| `04_Provider_Notes/` | `02_Modules/Email_Notification/Fallback_POC/04_Provider_Notes/` |
| `05_Decision_Records/` | `02_Modules/Email_Notification/Fallback_POC/03_Decision_Records/` |
| `06_Developer_Prompts/` | `05_Developer_Prompts/Email_Notification/Fallback_POC/` |
| `07_Archive/` | `07_Archive/Deprecated_Folder_Structures/` 或依內容重新歸類 |

---

## 15. 版本更新規則

### 15.1 小修正

若只是修正錯字、補充說明、修正格式，可維持同版本或以小版本更新。

### 15.2 重大修正

下列情況應更新版本：

1. 根目錄分類變更。
2. 模組分類變更。
3. Prompt 管理規則變更。
4. Archive 規則變更。
5. 文件正本位置規則變更。
6. 跨工具治理衝突處理流程變更。

### 15.3 版本記錄格式

```text
v0.1｜2026-05-30｜初版治理規則
v0.2｜2026-05-30｜新增最高優先原則、跨對話/跨工具/跨自動化流程衝突處理流程，並與 Current Folder Structure v1.2 對齊
```

---

## 16. v0.2 修訂摘要

本次 v0.2 修訂重點：

1. 新增「最高優先原則」。
2. 明確定義跨對話、跨 AI 工具、跨自動化流程分類衝突時的判斷順序。
3. 明確區分 `Current Folder Structure` 與 `Document Governance Rules` 的功能。
4. 再次確認 Prompt 正本一律放在 `05_Developer_Prompts/`。
5. 再次確認 Module 文件放在 `02_Modules/`。
6. 補強 Email Fallback POC 專用歸檔規則。
7. 補強不一致資料夾遷移規則。
8. 與 `LOHAShare_AI_Platform_Current_Folder_Structure_v1.2_20260530.docx` 對齊。

---

## 17. 執行檢查清單

每次新增或移動文件前，請確認：

```text
□ 這份文件的性質是什麼？
□ 是否已有正式根目錄分類？
□ 是否已有正式模組分類？
□ 是否會和既有資料夾重複？
□ 是否是 Prompt？若是，是否放在 05_Developer_Prompts？
□ 是否是測試紀錄？若是，是否放在 02_Modules？
□ 是否是 Support log？若是，是否放在 04_Support_Knowledge_Base？
□ 是否是 SOP？若是，是否放在 03_SOP_and_QA？
□ 是否是治理規則？若是，是否放在 01_Architecture_Governance？
□ 是否命名含日期與版本？
□ 是否避免「最新版」「最終版」等模糊命名？
□ 是否需要在 Index 或 Module Index 中新增引用路徑？
□ 是否有舊資料夾需要標記 Deprecated？
```

---

## 18. 管理原則摘要

1. 一種文件，只放一個正本位置。
2. 文件先依性質分類，再依模組分類。
3. 先以最新版 Current Folder Structure 與本 Governance Rules 為準。
4. Prompt 正本統一放在 `05_Developer_Prompts/`。
5. Module 內不放 Developer Prompt 正本。
6. 測試紀錄、截圖、決策紀錄放在 `02_Modules/`。
7. SOP 放在 `03_SOP_and_QA/`。
8. Support 與 debug log 放在 `04_Support_Knowledge_Base/`。
9. 發版紀錄放在 `06_Release_Notes/`。
10. 棄用資料夾放在 `07_Archive/`。
11. 不一致資料夾先搬移、再 Deprecated，不直接刪除。
12. 無法分類時，不直接新建資料夾，先提出治理更新需求。

---

## 19. 建議存放位置

本文件應放在：

```text
LOHAShare_AI_Platform/
  01_Architecture_Governance/
    LOHAShare_AI_Platform_Document_Governance_Rules_v0.2_20260530.md
```
