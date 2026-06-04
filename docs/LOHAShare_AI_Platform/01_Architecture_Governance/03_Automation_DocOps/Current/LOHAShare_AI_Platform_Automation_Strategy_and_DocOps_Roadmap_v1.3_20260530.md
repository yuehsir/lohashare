**LOHAShare AI Platform 自動化策略與 DocOps Roadmap**

v1.1：加入單一正本位置與 n8n / scripts 產生位置限制

版本：v1.1｜日期：2026-05-30

# 1. v1.1 更新摘要

> **•** DocOps 自動化必須遵守資料夾治理規則，不得因流程方便而產生不一致位置。
>
> **•** n8n 新增模組文件包 workflow 不得在模組內建立 Developer_Prompts 正本。
>
> **•** scripts 應依文件性質拆分：create-module-docs 產生模組文件；create-developer-prompt 產生 Prompt 文件；create-support-log 產生 Support KB 文件。
>
> **•** 所有自動化輸出需更新 Document System Index，並標記正本位置。
>
> **•** 若發現錯誤資料夾，自動化流程應建立 Deprecated 建議，不應直接刪除。

# 2. 工具分工修正版

| **工具**                 | **負責項目**                                                       | **不得做的事**                                  |
|--------------------------|--------------------------------------------------------------------|-------------------------------------------------|
| n8n                      | 流程編排：接收表單、建立資料夾、建立草稿文件、通知與更新索引草稿。 | 不得自動覆蓋 Stable 文件；不得建立重複正本。    |
| Replit scripts           | 執行工具：批次建立文件、轉檔、生成索引、建立 POC 測試工具。        | 不得未經審核改 production；不得混用資料夾規則。 |
| 05_Developer_Prompts     | 儲存給 AI / 開發工具的提示詞正本。                                 | 不是自動化執行工具；不得當作測試紀錄區。        |
| GitHub Actions           | 版本檢查、文件格式檢查、索引驗證、Release notes。                  | 不取代人工產品決策。                            |
| ChatGPT / Claude / Codex | 規格、審查、提示詞與工程建議。                                     | 不得直接決定正式文件覆蓋或刪除。                |

# 3. DocOps Workflow 輸出位置規則

| **Workflow**          | **輸入**                                      | **輸出位置**                             |
|-----------------------|-----------------------------------------------|------------------------------------------|
| 新增模組文件包        | module_name, module_code, phase, dependencies | 02_Modules/{Module}/...                  |
| 新增開發提示詞        | tool, module, purpose, version                | 05_Developer_Prompts/{Module}/{Topic}/   |
| 新增 Support Incident | platform, severity, module, status            | 04_Support_Knowledge_Base/{分類}/        |
| 新增 SOP / QA         | topic, owner, scope                           | 03_SOP_and_QA/{Topic}/                   |
| 更新索引              | 新增或更新文件 metadata                       | 00_Index/Document_System_Index           |
| 封存舊結構            | deprecated_path, migration_target             | 07_Archive/Deprecated_Folder_Structures/ |

# 4. 建議腳本拆分

> scripts/  
> ├─ create-module-docs.js \# 建立 02_Modules 模組文件包  
> ├─ create-developer-prompt.js \# 建立 05_Developer_Prompts 提示詞  
> ├─ create-support-log.js \# 建立 04_Support_Knowledge_Base 紀錄  
> ├─ create-sop-doc.js \# 建立 03_SOP_and_QA 文件  
> ├─ generate-document-index.js \# 更新 00_Index  
> └─ mark-deprecated-folder.js \# 建議舊資料夾遷移 / Deprecated

# 5. 自動化安全邊界

> **•** 自動化可建立 Draft Generated 文件，但不得自動宣告 Stable。
>
> **•** 自動化可建議遷移舊資料夾，但不得自動刪除。
>
> **•** 自動化可更新索引草稿，但重要文件正本位置變更需人工確認。
>
> **•** 自動化產出的 Prompt 必須放在 05_Developer_Prompts，不得跟模組規格混放。
>
> **•** 自動化流程若需使用 API Key，必須使用環境變數或 Secrets，不得寫入文件或前端。

# **v1.2 增補：自動化策略中的命名層級邊界**

版本註記：補充 n8n、scripts、Prompt、GitHub Actions 產生文件時需遵守主 PRD / 模組 / 衍生文件層級。

本次更新目的：修正先前部分文件中把 Nexus Lead Ops 或 Lead & Notification Console 寫得過於接近「產品母體」的語境，正式確認其在主 PRD 底下的層級定位。

## **正式命名層級**

| **層級** | **名稱**                                                                                                                 | **定位**                                         |
|----------|--------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| Level 0  | LOHAShare AI Platform                                                                                                    | 長期平台品牌與總體架構。                         |
| Level 1  | LOHAShare AI 商務網站營運控制台                                                                                          | 主 PRD / 主產品。                                |
| Level 2  | LOHAShare AI Lead & Notification Console MVP                                                                             | 第一個 MVP 實作版本，屬於主 PRD 底下的實作線。   |
| Level 3  | Lead Console、Email Notification、AI FAQ / AEO、Referral、Operator Dashboard、Client Portal、Billing / Commercialization | 功能模組或子系統。                               |
| Level 4  | Support Ticket、Fallback POC、Developer Prompt、Test Log、SOP、Release Note                                              | 模組衍生文件，用於實作、驗收、排錯、交付與維護。 |

## **本次修正後的核心規則**

• 主 PRD 不等於 Nexus Lead Ops。

• Nexus Lead Ops / Lead & Notification Console 屬於主 PRD 底下的實作線或子系統，不得取代主 PRD。

• 最早開發的是 MVP 模組，不是整個 LOHAShare AI Platform 一次完成。

• Referral、AI FAQ / AEO、Email Delivery、Fallback POC、Operator Dashboard、Client Portal、Billing / Commercialization 皆屬主 PRD 底下的模組、子系統或衍生文件。

• 未來任何新對話若將 Nexus Lead Ops 誤稱為主 PRD 或平台母體，應立即依本章修正。

## **對既有文件的影響**

• 涉及主產品定位、文件索引、跨對話交接、模組規格、Developer Prompt、POC 規格者，均需補充此命名層級。

• 涉及單次 Support / Incident / Test Log 的文件，若未錯置主 PRD 定位，可不重開主版本；但索引中需標示其 Level 4 層級。

• 文件放置位置仍依資料夾治理規則：主 PRD 放 00_Main_PRD；模組規格放 02_Modules；Prompt 放 05_Developer_Prompts；Support / Incident 放 04_Support_Knowledge_Base。

# 本次增補：Docs as Code Phase 1 成果正式記錄（v1.3）

版本：v1.3｜日期：2026-05-30｜狀態：Docs as Code Phase 1 成果記錄版

本章正式記錄 GitHub Actions 打包、治理檢查、manifest 與 manifest 檢查之第一階段成果，作為後續文件即程式自動化的治理基準。

本次更新採「全文保留＋增補修訂」原則：不以摘要取代既有內容，不刪除既有治理文字，而是在文件末段新增可追溯章節。

## 一、Phase 1 完成項目總表

| **項目**                    | **檔案位置**                                                                              | **狀態** | **成果說明**                                                                                               |
|-----------------------------|-------------------------------------------------------------------------------------------|----------|------------------------------------------------------------------------------------------------------------|
| Docs Package                | .github/workflows/docs-package.yml                                                        | 已成功   | 可手動觸發；產生 folder tree；打包 docs/LOHAShare_AI_Platform；上傳 ZIP artifact 與 folder tree artifact。 |
| Docs Governance Check       | .github/workflows/docs-governance-check.yml                                               | 已成功   | 可手動觸發並於文件路徑 push 時執行；檢查必要資料夾、禁止資料夾、命名錯誤與 Prompt 正本位置。               |
| Email Fallback POC Manifest | docs/LOHAShare_AI_Platform/02_Modules/Email_Notification/Fallback_POC/module.manifest.yml | 已建立   | 建立模組可讀 manifest，定義主 PRD 關係、安全邊界、所需文件、Prompt、測試計畫與下一步任務。                 |
| Docs Manifest Check         | .github/workflows/docs-manifest-check.yml                                                 | 已成功   | 檢查 module.manifest.yml 是否存在、欄位是否完整、定位是否正確、production 禁止事項與人工審核政策是否存在。 |

## 二、Phase 1 正式確認之自動化分工

> • GitHub Actions：負責 repo 內部文件封裝、治理檢查與 manifest 檢查。
>
> • module.manifest.yml：負責把模組規格、文件需求、Prompt、測試計畫、下一步任務轉成機器可讀結構。
>
> • n8n：保留為第二階段跨系統流程編排工具，不在本階段取代 GitHub Actions。
>
> • Replit / Claude Code / Codex：後續可依 Prompt 或 manifest 建立工具、檢查程式或協助開發，但需人工審核。

## 三、本階段新增核心規則

> • GitHub Actions 目前只負責 repo 內部自動化：打包、產生 tree、檢查治理規則、檢查 manifest。
>
> • n8n 暫不取代 GitHub Actions；n8n 未來負責跨系統通知、Dropbox 同步、Email / LINE 通知、外部任務流。
>
> • 所有自動化檢查均不得直接修改 production，也不得自動覆蓋正式 Word 文件。
>
> • module.manifest.yml 是文件指揮任務的第一個機器可讀基礎；目前只用於檢查與任務定義，不用於自動開發。
>
> • 所有自動產出或自動觸發的結果，預設狀態仍為 Draft Generated，需人工審核後才可成為 Stable。

## 四、下一步任務

| **序號** | **任務**                                                         | **建議位置**                                                    | **狀態** |
|----------|------------------------------------------------------------------|-----------------------------------------------------------------|----------|
| 下一步 1 | 建立 Replit Email Fallback Provider Test Console 開發提示詞 v0.1 | 05_Developer_Prompts/Email_Notification/Fallback_POC/           | 尚未執行 |
| 下一步 2 | 建立 Email Fallback POC 測試矩陣                                 | 02_Modules/Email_Notification/Fallback_POC/01_POC_Test_Logs/    | 待建立   |
| 下一步 3 | 建立 Decision Record                                             | 02_Modules/Email_Notification/Fallback_POC/03_Decision_Records/ | 待建立   |
| 下一步 4 | 視需要建立 docs-manifest-summary 或 GitHub Issue 產生流程        | .github/workflows/ 或 n8n                                       | 第二階段 |
