# LOHAShare AI Platform DocOps Automation MVP 第一條流程設計 v0.1

日期：2026-06-04  
狀態：Draft for Review  
性質：自動化流程設計，不是正式上線流程

## 一、文件目的

本文件定義 LOHAShare AI Platform DocOps Automation MVP 的第一條自動化流程：新增文件稽核流程 v0.1。

本流程的目的不是直接改寫文件，也不是自動覆蓋正式母本，而是先讓新增文件能被自動盤點、識別、分類、產生建議路徑與稽核報告。

## 二、目前前置作業狀態

| 項目 | 狀態 | 意義 |
|---|---|---|
| README Backfill | Completed | 所有資料夾已有 README，空白 README 已歸零。 |
| P0 Markdown Backfill | Completed | 主 PRD、整編計畫、內容品質規則已有 MD 工作版。 |
| P1 Markdown Backfill | Completed | 模組架構、自動化策略、Support KB、工具升級治理文件已有 MD 工作版。 |
| P2 Markdown Backfill | Completed | DocOps MVP Prompt 已有 MD 工作版，可作為自動化提示詞母本。 |
| Docs Inventory Audit | Available | 可產生 folder tree、file inventory、README audit、DOCX/MD pairing audit。 |

## 三、第一條流程名稱與定位

| 欄位 | 內容 |
|---|---|
| 流程名稱 | 新增文件稽核流程 v0.1 |
| 英文名稱 | New Document Intake Audit Workflow v0.1 |
| 流程性質 | Read-only audit first；不直接修改 repo，不覆蓋正式文件。 |
| 主要目標 | 新增文件後，自動判斷文件類型、建議放置位置、檢查 README、檢查 MD/DOCX 配對、產生稽核報告。 |
| 第一版不做 | 不自動搬移、不自動刪除、不自動升版、不自動覆蓋 Current、不自動生成 Stable 文件。 |

## 四、流程輸入與輸出

| 類型 | 內容 | 說明 |
|---|---|---|
| 輸入 | 新增或修改的文件路徑 | 來自 GitHub push、人工上傳或工作區新增檔案。 |
| 輸入 | 檔案副檔名與命名 | 例如 .docx、.md、.csv、.png、.yml。 |
| 輸入 | 目前資料夾 README | 用來判斷該資料夾用途與是否允許放置該文件。 |
| 輸入 | 治理規則 MD | P0 / P1 / P2 已補齊的 Markdown 工作版。 |
| 輸出 | Document Intake Audit Report | 新增文件的分類、路徑建議、風險與待人工確認事項。 |
| 輸出 | Suggested Placement CSV | 建議放置位置與理由。 |
| 輸出 | Action Required List | 需要人工處理的項目，不直接自動修改。 |

## 五、文件分類判斷規則

第一版採規則式分類，不依賴複雜 AI。先用檔名、所在路徑、副檔名與 README 語意進行初步判斷，未來才導入 AI 輔助判斷。

| 文件類型 | 判斷線索 | 建議位置 |
|---|---|---|
| 主 PRD | PRD、Operation Console、主產品、v1.x / v2.x | 00_Main_PRD/Current 或 99_Archive |
| 架構治理 | Governance、Architecture、Folder、Format、Quality、Automation | 01_Architecture_Governance/<Topic>/Current 或 99_Archive |
| 模組規格 | Module Spec、Lead Console、Referral、Email Notification | 02_Modules/<Module>/ |
| Support / Incident | Support Ticket、Incident、Known Issue、Resolved Case | 04_Support_Knowledge_Base/ |
| Developer Prompt | Prompt、Lovable、Replit、Claude、Codex、n8n | 05_Developer_Prompts/<Category>/Current 或 99_Archive |
| Release Note | Release Note、Completion Record、Phase Completion | 06_Release_Notes/ |
| 輸出包 / 工具 | Package、Export、Move Map、Backfill Package、.bat、.ps1 | 07_Archive/Package_Export/ |

## 六、自動化流程步驟

| 步驟 | 名稱 | 說明 | 第一版工具 |
|---|---|---|---|
| 1 | Detect changed files | 偵測新增或修改的 docs/LOHAShare_AI_Platform 檔案。 | GitHub Actions |
| 2 | Classify file type | 依副檔名、檔名、路徑判斷文件類型。 | Python script |
| 3 | Check placement | 比對文件類型與目前所在資料夾是否合理。 | Python script + README |
| 4 | Check README | 若新增資料夾缺 README 或 README 空白，列入 action required。 | Docs Inventory Audit |
| 5 | Check DOCX/MD pairing | 若 Current DOCX 無 MD，判斷是否需補 MD。 | Pairing audit |
| 6 | Generate audit report | 產生 Markdown / CSV artifact。 | GitHub Actions artifact |
| 7 | Human review | 人工確認建議，不自動搬移或覆蓋。 | 使用者 / 顧問 |

## 七、第一版安全邊界

- v0.1 只做 read-only audit，不自動寫入 repo。
- 不自動刪除任何文件。
- 不自動搬移 Current 文件。
- 不自動將 Draft Generated 升為 Stable。
- 不自動把 DOCX 轉 MD，僅提出是否需要補 MD 的判斷。
- 若判斷結果涉及主 PRD、治理母本或 Current 文件，必須人工確認。
- 任何自動化修改 repo 的流程，必須另行建立 Decision Record 後才能進入 v0.2。

## 八、GitHub Actions / n8n / scripts 分工

| 層級 | 工具 | 職責 |
|---|---|---|
| 版本與檢查層 | GitHub Actions | 執行 inventory、placement audit、README audit、pairing audit、上傳 artifact。 |
| 工具執行層 | Python / Replit scripts | 產生 CSV、Markdown report、檔案分類結果、補齊包草稿。 |
| 流程編排層 | n8n | 未來負責監聽 GitHub、通知使用者、將 artifact 送到 Dropbox 或 Email。 |
| AI 判斷層 | ChatGPT / Claude / Codex | 協助判斷分類、補正、文件品質，但不直接定稿 Stable。 |
| 查詢層 | NotebookLM | 最後用於查詢與脈絡追溯，不作為第一工作基準。 |

## 九、v0.1 建議產出物

| 產出物 | 檔名建議 | 用途 |
|---|---|---|
| Workflow | docs-intake-audit.yml | GitHub Actions 手動或 push 觸發。 |
| Script | scripts/docops/intake_audit.py | 執行分類、路徑判斷、README 與 pairing audit。 |
| CSV | LOHAShare_AI_Platform_new_document_intake_audit.csv | 列出新增文件與建議處理方式。 |
| Markdown Report | LOHAShare_AI_Platform_new_document_intake_audit_report.md | 人類可讀的稽核報告。 |
| Artifact | LOHAShare_AI_Platform_docops_intake_audit | 供下載、保存、後續討論。 |

## 十、v0.1 驗收標準

- 能在 GitHub Actions 手動執行。
- 能產生 artifact，不修改 repo。
- 能列出 docs/LOHAShare_AI_Platform 下新增或修改的文件。
- 能初步判斷文件類型與建議放置位置。
- 能標示缺 README、空白 README、Current DOCX without MD。
- 能輸出 CSV 與 Markdown 報告。
- 不會刪除、搬移、覆蓋任何文件。

## 十一、後續路線

| 階段 | 目標 | 是否自動寫入 |
|---|---|---|
| v0.1 | Read-only audit，產生建議報告 | 否 |
| v0.2 | 產生 README / MD 補齊包草稿 | 否，僅產 artifact |
| v0.3 | 建立 PR 草稿或 branch，不直接推 master | 有限度 |
| v0.4 | n8n 接 GitHub artifact 與通知 | 否 |
| v1.0 | DocOps Console MVP：可視化審核、套用、封存 | 人工確認後才可寫入 |
