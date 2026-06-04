**LOHAShare Engineering Escalation & Tooling Decision Guide**

Lovable / Replit / Claude Code / Codex / n8n / GitHub Actions 的升級判斷規則

版本：v0.1｜狀態：Decision Guide Draft

| **文件日期** | 2026-05-30                                                                       |
|--------------|----------------------------------------------------------------------------------|
| **管理原則** | 不覆蓋舊版；以新增版本與索引連結方式管理                                         |
| **關聯主軸** | LOHAShare AI 商務網站營運控制台 PRD / Nexus Lead Ops / Email Notification Module |
| **建議放置** | 01_Architecture_Governance/                                                      |

# 1. 文件目的

本文件避免工具使用變成多頭馬車。每一類問題先判斷屬性，再決定使用 Lovable、Replit、Claude Code、Codex、n8n 或 GitHub Actions。

# 2. 工具分工矩陣

| **任務**                            | **第一選擇**        | **升級條件**                                   |
|-------------------------------------|---------------------|------------------------------------------------|
| 產品規劃、PRD、Prompt、商業模式     | ChatGPT             | 需要可執行程式碼時轉 Replit / Lovable          |
| MVP 後台、CRUD、頁面、Supabase 串接 | Lovable             | 涉及黑盒限制、複雜 debug 或正式 repo 時升級    |
| 小工具、scripts、文件產生器、POC    | Replit              | 需正式 code review 或多檔重構時升級            |
| 深度 codebase 修改、測試、重構      | Claude Code / Codex | 正式工程審查或核心流程風險時啟用               |
| 文件流程與業務流程自動化            | n8n                 | 需 repo 內測試 / release 時交給 GitHub Actions |
| 測試、部署、Release、文件索引自動化 | GitHub Actions      | 正式 repo 後啟用                               |

# 3. 何時升級到第三層

- 核心流程中斷且 Support 無法即時處理。

- 問題跨前端、後端、資料庫、權限或 provider。

- 修正一處可能破壞其他模組。

- 需要跑測試、檢查 diff、審查 pull request。

- 準備從 MVP 進入收費營運或正式部署。

# 4. 升級時不可做事項

- 不得讓 coding agent 直接大範圍重構 production。

- 不得未建立備份與測試就覆蓋主線。

- 不得同時引入多個工具造成責任不清。

- 不得把工具選擇寫進主 PRD，除非它改變部署策略或產品方向。

# 5. 建議流程

1.  ChatGPT 先整理問題與限制。

2.  Lovable / Replit 嘗試 MVP 或 POC。

3.  若卡在黑盒或核心流程，建立 Incident Log。

4.  啟動 Claude Code / Codex 進行工程審查。

5.  通過 POC 與人工審核後，再決定是否納入主模組規格。
