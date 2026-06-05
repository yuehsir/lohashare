# LOHAShare Email Fallback Provider Test Console 對話治理同步與歸檔候選清單 v0.1

版本：v0.1  
日期：2026-06-05  
對話名稱：LOHAShare Email Fallback Provider Test Console  
產品化名稱：LOHAShare Email Fallback Provider Test Console  
狀態：Archive Candidate / 尚未寫入 GitHub  
GitHub repo tree 驗證狀態：尚未實際讀取 GitHub repo tree  
本文件性質：治理同步結果 + 歸檔候選清單 + 拆分建議  

---

## 0. 重要聲明

本文件僅為本對話的**歸檔素材**與**候選整理文件**，目前：

- 尚未寫入 GitHub。
- 尚未 commit。
- 尚未建立 Pull Request。
- 尚未完成 GitHub repo tree 實際結構校驗。
- 尚未宣稱任何 GitHub Actions、Archive Bot、Lovable 或 Supabase 自動化已完成歸檔。

本文件依據本對話內容、使用者提供的官方治理基準摘要，以及已確認的 LOHAShare AI Platform 文件治理規則整理。若後續 GitHub connector 或 repo tree 校驗結果與本文件候選路徑不同，應以官方 `docs/LOHAShare_AI_Platform/00_Index/Current/` 與 `01_Architecture_Governance/<Topic>/Current/` 的最新實際內容為準。

---

## 1. 治理基準同步結果

| 項目 | 判斷 |
|---|---|
| 是否已接收官方治理基準摘要 | 是 |
| 是否理解 GitHub 工作基準 | `docs/LOHAShare_AI_Platform/` |
| 是否理解 `00_Index/Current/` 是最新索引入口 | 是 |
| 是否理解 `01_Architecture_Governance/<Topic>/Current/` 是治理規則入口 | 是 |
| 是否理解 `00_Main_PRD/Current/` 是主 PRD 與層級命名入口 | 是 |
| 是否理解 `05_Developer_Prompts/<Category>/Current/` 是 Developer Prompt 正本入口 | 是 |
| 是否理解 Developer Prompt 正本不得放入 `02_Modules` | 是 |
| 是否已實際讀取 GitHub repo tree | 否 |
| 目前狀態 | 已理解治理基準；尚未完成 GitHub 實際結構校驗 |

---

## 2. 對話層級分類

| 層級 | 對應 |
|---|---|
| Level 0 | LOHAShare AI Platform |
| Level 1 | LOHAShare AI 商務網站營運控制台 |
| Level 2 | LOHAShare AI Lead & Notification Console MVP |
| Level 3 | Email Notification |
| Level 4 | Fallback POC / Provider Notes / Developer Prompt / Test Log / Debug Log / Support Log / Decision Record / Release Note |

本對話不應被視為主 PRD，也不應被視為單獨 Level 3 模組。`LOHAShare Email Fallback Provider Test Console` 是 Email Notification 模組下的 Fallback POC / provider diagnostics 實作線與測試工具名稱。

---

## 3. 本對話目標與完成度

### 3.1 原始目標

本對話起因於 Nexus Lead Ops / Lovable / Supabase 專案等待 Lovable Support / Mailgun 排查 Email delivery 問題；原始目標是建立一個獨立工具，驗證可替代 Lovable Mailgun 的 provider。

### 3.2 已完成成果

- Replit `LOHAShare Email Fallback Provider Test Console` 已建立並完成 Provider POC。
- Resend 初始測試成功。
- Resend 自有寄件網域 `send.lohashare.com` 測試成功。
- Resend 已通過 Gmail / Zoho / Yahoo / Outlook 四類主要收件端初測。
- Zoho SMTP + `tech@lohashare.com` 測試成功。
- 已確認 Resend 可列為 Primary Email Provider 候選。
- 已確認 Zoho SMTP 可列為 Secondary / Backup Provider 候選。
- Replit 測試工具已定位為獨立診斷工具，不作為 production router。
- Lovable 主專案中已完成 Resend Adapter、Email Router skeleton、admin-only Resend adapter verification、admin-only router smoke test。
- 已確認 Lovable Preview / Production 共用後端、queue、cron 與 secrets；因此不得直接啟用 `EMAIL_PROVIDER_ROUTER_ENABLED=true` 作為 staging 測試。
- 已建立 unsubscribe route 並完成 safety patch：GET 只顯示確認頁，POST 才執行退訂。

### 3.3 原始初衷完成度

| 面向 | 完成度 | 說明 |
|---|---:|---|
| Provider 可行性驗證 | 完成 | Resend / Zoho SMTP 均已通過測試 |
| Replit 測試工具 | 完成 | 保留為診斷工具 |
| Lovable 正式替換架構 | 部分完成 | 已完成 Resend-only isolated smoke test，但尚未 production cutover |
| Zoho SMTP fallback 正式接線 | 未完成 | 尚未建立 Edge Function / fallback wiring |
| 正式 production cutover | 未完成 | `EMAIL_PROVIDER_ROUTER_ENABLED=false` |

結論：本對話的原始 POC 初衷已完成；後續正式產品導入應回到 Nexus Lead Ops / Lovable / Supabase 主專案處理。

---

## 4. 已確認決策

1. 不再等待 Lovable / Mailgun 作為唯一解法。
2. 不把 Replit Email Test Console 接入 production。
3. Resend + `send.lohashare.com` 作為 Primary Provider 候選。
4. Zoho SMTP + `tech@lohashare.com` 作為 Secondary / Backup Provider 候選。
5. Lovable 內建 Emails / Mailgun 不再作為未來正式主線，但 legacy path 仍保留作 rollback。
6. `auth_emails` Phase 1 不切換，仍走 legacy Lovable Emails。
7. `transactional_emails` 未正式啟用前仍走 legacy Lovable Emails。
8. `EMAIL_PROVIDER_ROUTER_ENABLED=false` 必須維持，直到正式 cutover。
9. `EMAIL_ROUTER_TEST_ENABLED=false` 在測試後必須關閉。
10. `EMAIL_FALLBACK_ENABLED=false` 或 unset，直到 Zoho fallback 被正式批准。
11. 因 Preview 與 Production 共用 Supabase / queue / cron / secrets，不得用開啟 global flag 的方式做 staging smoke test。
12. `app.lohashare.com` 長期適合作為正式 App / unsubscribe / notification preference domain，但是否現在建立應回主專案規劃。

---

## 5. 已確認操作與測試紀錄摘要

### 5.1 Replit Provider Test Console

| 測試項目 | 結果 |
|---|---|
| Resend onboarding 測試 | 成功 |
| Resend `send.lohashare.com` → Gmail | 成功 |
| Resend `send.lohashare.com` → Zoho | 成功 |
| Resend `send.lohashare.com` → Yahoo | 成功 |
| Resend `send.lohashare.com` → Outlook | 成功 |
| Zoho SMTP `tech@lohashare.com` | 成功 |
| Test History / Manual Result / CSV export | 成功 |

### 5.2 Lovable / Nexus Lead Ops 主專案前置驗證

| 步驟 | 狀態 |
|---|---|
| Email Provider Router Analyze Plan | 完成 |
| Router skeleton dark mode | 完成 |
| Resend Adapter | 完成 |
| Admin-only Resend adapter live verification | 成功 |
| Admin-only router dispatcher isolated smoke test | 成功 |
| Unsubscribe route | 已建立 |
| Unsubscribe route safety patch | 完成 |
| Zoho SMTP Edge Function | 尚未建立 |
| Production cutover | 尚未執行 |

---

## 6. 已產出 Developer Prompt 候選清單

以下為本對話已產出或實質形成的 Developer Prompt 候選，建議另行拆分成 Developer Prompt Index / Prompt Pack：

1. Replit Email Fallback Provider Test Console 初始開發 Prompt v0.1
2. Replit Test History 狀態邏輯 bugfix Prompt
3. Replit Provider Status / admin token 診斷 Prompt
4. Zoho SMTP Replit Secrets / restart Prompt
5. Lovable Analyze Nexus Lead Ops Email Architecture Prompt
6. Lovable Email Provider Router Final Build Plan 回覆 Prompt
7. Step 0 / Step 1 controlled build Prompt
8. Step 1 verification Prompt
9. Step 2A Resend Adapter Prompt
10. Step 2A admin-only verification function Prompt
11. Admin-only verification UI Prompt
12. Step 2B Resend Router Wiring Prompt
13. Step 2B Safety Patch / `EMAIL_FALLBACK_ENABLED` Prompt
14. Environment isolation assessment Prompt
15. Option A admin-only router smoke test Prompt
16. Unsubscribe route inspection Prompt
17. Unsubscribe route build Prompt
18. Unsubscribe route safety patch Prompt
19. Lovable safe pause checkpoint Prompt
20. Replit diagnostic tool pause checkpoint Prompt
21. 主專案銜接提示詞

---

## 7. 已產出文件或草案候選

| 類型 | 候選文件 |
|---|---|
| Decision Record | Email Fallback POC Decision Record |
| Provider Notes | Resend / Zoho SMTP Provider Notes |
| Test Log | Provider Test Log Summary |
| Support Log | Lovable Mailgun Delivery Investigation Support Log |
| Debug Log | Lovable / Mailgun accepted but not received debug notes |
| Community Note | Lovable Community Experience Note |
| Developer Prompt | Email Notification Fallback POC Developer Prompt Index |
| Release Note | Email Fallback Provider POC milestone release note |
| SOP / QA | Provider testing and router verification SOP |
| Governance Sync | 本文件 |

---

## 8. 候選 GitHub 路徑

> 注意：以下僅為候選路徑，尚未經 GitHub repo tree 實際校驗。

### 8.1 Governance Sync / Archive Candidate

```text
docs/LOHAShare_AI_Platform/02_Modules/Email_Notification/Fallback_POC/
```

候選檔名：

```text
LOHAShare_Email_Fallback_Provider_Test_Console_Governance_Sync_Archive_Candidates_v0.1_20260605.md
```

### 8.2 Developer Prompt 正本

```text
docs/LOHAShare_AI_Platform/05_Developer_Prompts/Email_Notification/Fallback_POC/Current/
```

### 8.3 Provider Test Log / Provider Notes

```text
docs/LOHAShare_AI_Platform/02_Modules/Email_Notification/Fallback_POC/Test_Logs/
docs/LOHAShare_AI_Platform/02_Modules/Email_Notification/Fallback_POC/Provider_Notes/
```

若正式資料夾未存在，需提出治理更新提案。

### 8.4 Support / Debug

```text
docs/LOHAShare_AI_Platform/04_Support_Knowledge_Base/Email_Delivery_Support_Log/
docs/LOHAShare_AI_Platform/04_Support_Knowledge_Base/Provider_Debug_History/
```

### 8.5 Release Note

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/
```

---

## 9. 路徑衝突與治理注意事項

1. `LOHAShare Email Fallback Provider Test Console` 不應作為正式 Level 3 module folder。
2. 若曾出現 `02_Modules/email-notification/email-fallback-provider-test-console/`，應視為舊路徑或不一致路徑候選，不應直接作為正式路徑。
3. Developer Prompt 正本不得放在 `02_Modules`。
4. 若 `Email_Notification/Fallback_POC` 在 GitHub 中尚不存在，不得自行宣稱已建立正式模組資料夾。
5. 若正式文件結構使用 Current / Archive 分層，需依 GitHub repo tree 校驗後再決定最終路徑。
6. 本對話涉及 Lovable 實際改檔與 Supabase migration，但本文件不宣稱已完成 GitHub 歸檔或 commit。

---

## 10. 建議拆分文件

建議後續拆分成以下文件：

| 順序 | 文件 | 建議狀態 | 是否建議產生 |
|---:|---|---|---|
| 1 | Email Fallback POC Decision Record | Draft | 是 |
| 2 | Provider Test Log Summary | Draft | 是 |
| 3 | Resend / Zoho SMTP Provider Notes | Draft | 是 |
| 4 | Developer Prompt Index / Prompt Pack | Draft | 是 |
| 5 | Lovable / Mailgun Debug & Support Log | Draft | 是 |
| 6 | Email Router Phased Build Log | Draft | 是 |
| 7 | Release Note: Provider Feasibility Completed | Optional | 是，若需 milestone |
| 8 | SOP: Provider Verification and Safe Router Testing | Optional | 是，若需複用流程 |
| 9 | Governance Update Proposal | Conditional | 若 GitHub tree 校驗後缺正式路徑才產生 |

---

## 11. 建議 GitHub Archive JSON 摘要

對應 JSON 檔案：

```text
LOHAShare_Email_Fallback_Provider_Test_Console_GitHub_Archive_Candidates_v0.1_20260605.json
```

JSON 用途：提供 Archive Bot / GitHub automation / 人工 commit 前的素材，包含候選路徑、文件類型、版本、狀態、路徑衝突與拆分建議。

---

## 12. 建議 commit message

```text
docs(email-notification): add email fallback provider POC governance sync archive candidates
```

若後續拆分成多份文件，可改用：

```text
docs(email-notification): archive fallback provider POC decisions prompts and test logs
```

---

## 13. 下一步建議

建議下一步先不要回到開發任務，而是先做拆分：

```text
請直接執行下一步，根據《LOHAShare Email Fallback Provider Test Console 對話治理同步與歸檔候選清單 v0.1》，拆分產生 Decision Record、Provider Notes、Developer Prompt Index、Test Log、Support Log 與 Release Note 的 Markdown 草稿，並產生對應 GitHub Archive JSON；不得宣稱已寫入 GitHub、不得宣稱已 commit、不得建立 PR。
```

若要先做 GitHub 實際路徑校驗，則使用：

```text
請先執行 GitHub repo tree 驗證或依目前可用文件完成路徑候選校驗；不得宣稱已寫入 GitHub。
```

---

## 14. 本文件狀態

- 已產生 Markdown 歸檔素材：是。
- 已產生 GitHub Archive JSON 素材：是。
- 已寫入 GitHub：否。
- 已 commit：否。
- 已建立 PR：否。
- GitHub repo tree 實際校驗：尚未完成。
