**LOHAShare AI Platform 模組化架構與開發治理原則**

v1.1｜營運韌性與核心流程備援更新

版本：v1.1｜狀態：架構治理更新版

| **文件日期**     | 2026-05-30                                                                       |
|------------------|----------------------------------------------------------------------------------|
| **管理原則**     | 不覆蓋舊版；以新增版本與索引連結方式管理                                         |
| **關聯主軸**     | LOHAShare AI 商務網站營運控制台 PRD / Nexus Lead Ops / Email Notification Module |
| **本版更新重點** | 新增正式營運核心流程不得單一黑盒依賴之架構原則                                   |

# 1. 本版新增核心原則

凡屬正式營運核心流程，不得只有單一平台黑盒依賴，必須至少具備人工 fallback、替代 provider、事件紀錄與恢復流程。

# 2. 核心流程分級

| **流程**           | **風險等級** | **最低備援要求**                                     |
|--------------------|--------------|------------------------------------------------------|
| 表單提交與名單存入 | Critical     | 資料必須存入資料庫；若通知失敗仍可人工查詢           |
| Email 通知         | High         | 至少一個 fallback provider 或 manual resend 機制     |
| Referral 歸因      | High         | 需保留 source_url、referral_code、utm 與人工校正能力 |
| 付款 / 訂閱狀態    | Critical     | 不得只依賴單一自動化事件；需人工覆核                 |
| 客戶預約           | High         | 需具備手動確認與通知補發流程                         |

# 3. Provider Adapter 架構方向

Email Notification Module 應逐步從單一 sendEmail 寫法，改為 Notification Provider Adapter 架構。

- Primary Provider：現有 Lovable / Mailgun pipeline。

- Fallback Provider：Resend、ZeptoMail、Postmark 或 SMTP。

- Manual Provider：人工 resend 或備援工具。

- Provider Log：每次發送需記錄 provider、response、status、error。

# 4. Lovable / Replit / Claude Code / Codex 分工更新

| **工具層**          | **主要用途**                                        | **啟用時機**                               |
|---------------------|-----------------------------------------------------|--------------------------------------------|
| Lovable / Replit    | 快速 MVP、後台、內部工具、一般 debug                | 0 到 1、驗證產品可行性                     |
| Claude Code / Codex | 深度 codebase 審查、重構、測試、複雜 bug、PR review | 核心流程中斷、跨多檔案風險、正式營運前審查 |
| n8n                 | 文件與流程自動化、Support KB、通知                  | 建立治理流程與日常自動化                   |
| GitHub Actions      | 測試、部署、文件索引與 Release 自動化               | 進入正式 repo 管理後                       |

# 5. 不立即重做原則

- 遇到外部 Support 延遲時，不應立刻全面重做。

- 應保留現有主線等待根因，同時啟動獨立 fallback POC。

- 任何替代方案必須通過測試、文件化、風險評估與人工核准。

# **v1.2 增補：主 PRD 與模組層級治理規則**

版本註記：修正 Nexus Lead Ops 不得被視為整體平台母體；補充 Level 0-4 命名層級。

本次更新目的：修正先前部分文件中把 Nexus Lead Ops 或 Lead & Notification Console 寫得過於接近「產品母體」的語境，正式確認其在主 PRD 底下的層級定位。

<img src="/mnt/data/LOHAShare_AI_Platform_P1_DOCX_to_MD_Backfill_Package_v0.1_20260604/docs/LOHAShare_AI_Platform/01_Architecture_Governance/assets/P1_DOCX_to_MD_Backfill_20260604/p1_modular_architecture/media/image1.png" style="width:6.4in;height:4.8in" />

圖：LOHAShare AI Platform 命名層級架構圖

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
