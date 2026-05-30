# 下一階段 Roadmap

> 文件編號：LOHAShare-LNC-ROADMAP-v1.0.0-P3c-Stable-20260529  
> 版本識別：v1.0.0-P3c-Stable-20260529  
> 基準版本：Phase 3c Stable — Lead & Notification Console MVP  
> 文件日期：2026-05-29  
> 用途：儲存、更新、交接與下一階段規劃

---


## 一、目前狀態

目前系統已完成 Phase 3c Stable，已可支援客戶管理、網站管理、表單建立、iframe 表單嵌入、Public form submit、Lead 建立、Lead Drawer、Lead Notes、Lead Status、Activity Logs、CSV 匯出、Notification Dispatch skipped mode、Operator 權限與 Security / RLS 基礎。

目前最大限制是：Email 尚未實際寄出。因此下一步最合理的優先方向是 Phase 3d — Email Delivery Activation。

## 二、Roadmap 優先順序

1. Phase 3d — Email Delivery Activation
2. Phase 3e — Operator Dashboard / 日常操作強化
3. Phase 4 — FAQ / AEO Console
4. Phase 5 — AI Lead Intelligence
5. Phase 6 — Multi-channel Notification
6. Phase 7 — Client Portal
7. Phase 8 — Commercialization / Billing

# Phase 3d — Email Delivery Activation

## 目標

將目前 Notification Dispatch 的 skipped mode 升級為實際 Email 寄送。

目前狀態：notification_logs.status = skipped、error_message = email_infra_not_configured、email_sent_count = 0。

完成後：Email 可實際寄出；成功寄出 notification_logs.status = sent；失敗 status = failed；skipped 只用於通知 disabled、無收件人、infra 未設定、quota exceeded；sent 才累加 monthly_usage.email_sent_count。

## 主要工作

### 1. Email Provider 評估

比較 Lovable Emails、Resend、Postmark、Amazon SES。評估 DNS 設定難度、免費測試成本、Transactional email 適配性、寄達率、API 整合難度、自訂寄件網域支援、retry / suppression / bounce 支援與現有架構整合難度。

### 2. DNS 設定

正式網域：notify.lohashare.com。需規劃 SPF、DKIM、DMARC、Return-Path / Bounce domain、TXT / CNAME / MX、DNS 驗證流程，以及是否影響 lohashare.com 原有信箱。

### 3. Dispatch Logic

新邏輯：infra_ready = false → skipped；infra_ready = true → send email；success → sent；failure → failed。Email 失敗不可阻止 Lead 建立、不可讓表單送出失敗、不可造成重複 Lead。

### 4. Email Template

Lead notification email 需包含 site_name、form_name、lead.name、lead.email、lead.phone、lead.company_name、lead.need_type、lead.message、custom_data、referer、page_url、source_ip、created_at、後台查看連結，並支援繁體中文。

### 5. 測試寄送

Notification Settings 中的「測試寄送」需能實際寄出測試信，寫入 notification_logs，test flag = true，不累加正式 monthly_usage.email_sent_count。

### 6. Quota

導入 monthly_email_quota 與 email_sent_count。Phase 3d 初期建議先 warning，不 hard block；若超過 quota，Lead 仍建立，Email 可 skipped，notification_logs 寫 quota_exceeded，usage_logs 寫 email_quota_exceeded。

## 驗收標準

1. notify.lohashare.com DNS 驗證完成。
2. 測試寄送可收到 Email。
3. 表單送出後，客戶收件人可收到通知。
4. LOHAShare 收件人可收到通知。
5. notification_logs.status = sent。
6. provider_message_id 有記錄。
7. email_sent_count 正確累加。
8. failed email 不影響 lead 建立。
9. disabled / no recipient / quota exceeded 時會 skipped。
10. Email template 中文顯示正常。

# Phase 3e — Operator Dashboard / 日常操作強化

## 目標

讓 Operator 更容易處理自己的站點與 Lead。

## 功能建議

- Operator Dashboard：我的 Sites、本月 Lead 數、今日新增 Lead、未處理 Lead、已報價 / 已成交數。
- Lead 批次操作：多選 Leads、批次修改 status、批次匯出 CSV。
- Lead 負責人：指派負責人、依負責人篩選、未來可支援通知指定負責人。
- Saved Filters：儲存常用篩選條件，例如本週新名單、未聯絡、已報價。

# Phase 4 — FAQ / AEO Console

## 目標

建立與 Lead Console 平行的 FAQ / AEO 管理模組。Phase 4 不應變成完整 CMS，而應聚焦在 AEO / FAQ 內容營運。

## 建議功能

1. FAQ 管理：site-level FAQ、title / question / answer、status：draft / review / published / inactive。
2. FAQ iframe widget：/embed/faqs/{siteSlug}，可嵌入 Oasis / Duda，RWD FAQ accordion。
3. FAQ Schema：JSON-LD 產生、FAQPage schema，可複製或嵌入。
4. AI rewrite：AI 改寫短答案、長答案、FAQ schema draft，ai_rewrite_count 累加。
5. AEO 內容流程：待審核、已發布、已更新、本月更新量。

## 驗收標準

- Admin 可建立 FAQ。
- FAQ 可嵌入外部網站。
- FAQ Schema 可產生。
- AI rewrite 可記錄使用量。
- 不影響 Phase 3c Lead Console。

# Phase 5 — AI Lead Intelligence

## 目標

將 AI 能力加入 Lead 管理流程。

功能建議：AI Lead Summary、自動整理關鍵需求、AI Need Type Classification、AI Suggested Reply、AI Opportunity Score 與 AI Usage Quota。

# Phase 6 — Multi-channel Notification

## 目標

擴充 Email 以外的通知通道。

候選功能：LINE Bot 通知、LINE OA 綁定、Webhook outbound、Google Sheet sync、Slack / Discord webhook、CRM webhook。

原則：Email 先穩定後再擴充；所有 channel 都需寫 notification_logs；失敗不可影響 Lead 建立；每個 channel 需可獨立 enabled / disabled。

# Phase 7 — Client Portal

## 目標

讓客戶可登入查看自己的資料。

分級建議：報表檢視版、自主管理版、SaaS 版。

# Phase 8 — Commercialization / Billing

## 目標

將 MVP 轉為可收費 SaaS / 代維運產品。

功能建議：Plan enforcement、Billing、Invoice / Tax、Trial / Paid、Usage-based upsell。

## 三、目前最建議立即執行的下一步

建議優先執行 Phase 3d — Email Delivery Activation。原因：Lead Console 主流程已成立；Notification 目前仍是 skipped；Email 是客戶最容易理解的月費價值；Email 完成後，才能真正對既有 Oasis 客戶包裝為「名單管理 + 即時通知」服務。

## 四、Phase 3d 前置決策

開始 Phase 3d 前，需先回答：Email provider 要用哪一個、是否使用 notify.lohashare.com、DNS 由誰設定、是否會影響 lohashare.com 原本信箱、From email / Reply-To 要用哪一個、測試寄送是否計入 email usage、超過 quota 是否 hard block、是否需要 bounce / suppression 管理、是否先做 warning 再做 hard limit。

## 五、Roadmap 原則

1. 每一階段都要先 Plan，不直接 Build。
2. 每一階段都要有驗收清單。
3. 不可破壞 Phase 3c Stable。
4. 不可自動 Fix security warnings。
5. 不可改 RLS / auth / wrapper functions，除非明確要求。
6. 不可清測試資料，除非建立清理計畫。
7. 每一階段完成後都要建立 checkpoint。

