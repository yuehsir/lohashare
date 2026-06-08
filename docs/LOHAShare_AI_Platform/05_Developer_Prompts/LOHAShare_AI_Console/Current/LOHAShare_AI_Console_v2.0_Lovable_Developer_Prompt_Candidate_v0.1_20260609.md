# LOHAShare AI Console v2.0 對 Lovable 的開發提示詞候選稿 v0.1

版本時間：2026-06-09 00:25（Asia/Taipei）  
版本號：v0.1  
文件狀態：Draft / Developer Prompt Candidate / Not Committed by ChatGPT  
建議候選路徑：`LOHAShare_AI_Platform/05_Developer_Prompts/LOHAShare_AI_Console/Current/`  
路徑狀態：候選，需治理核准新增 `05_Developer_Prompts/LOHAShare_AI_Console/`  
關聯 PRD：`LOHAShare_AI_Console_Platform_PRD_v2.0_Draft_20260609.md`  
關聯 UI/UX：`LOHAShare_AI_Console_UIUX_Sitemap_v0.1_20260609.md`  
關聯 UI Baseline：`Lead_Console_MVP_Current_UI_Baseline_v0.1_20260609.md`

---

## 0. 使用方式

請將下方「Lovable 開發提示詞正文」貼入 Lovable 專案對話中使用。

本提示詞的目的不是重做整個系統，而是要求 Lovable 依據現有 LOHAShare AI Lead & AEO Console MVP，進行 v2.0 平台化升級的安全盤點與漸進式開發。

---

# Lovable 開發提示詞正文

## 任務名稱

LOHAShare AI Console v2.0 — 以現有 Lead & AEO Console MVP 為基本盤的平台化升級

---

## 一、背景與產品定位

目前此 Lovable 專案已存在一個可運作的後台雛形，畫面品牌顯示為：

```text
LOHAShare
AI Console
```

主畫面標題為：

```text
儀表板
LOHAShare AI Lead & AEO Console 維運總覽
```

目前左側選單已包含：

```text
儀表板
客戶管理
網站管理
方案與額度
表單管理
名單管理
FAQ / AEO
通知設定
嵌入碼
使用量
月報草稿
登出
```

這個現有系統不是要被重做，而是要被定義為：

> LOHAShare AI Console 的 Phase 1 MVP 基本盤。

LOHAShare AI Console 是建立在 Oasis / Duda / 其他 CMS 外部的雲端加值模組平台，未來可以將表單、名單、FAQ/AEO、通知、使用量、月報、Referral、Partner、Campaign、Billing 等模組嵌入 Oasis / Duda / 其他 CMS 網站中，作為可另外收費的加值服務。

---

## 二、本次開發總原則

請嚴格遵守以下原則：

1. 不要重做整個 UI。
2. 不要刪除現有頁面、資料表、route、RLS policy 或既有功能。
3. 不要新增 `Nexus_Lead_Ops` 作為正式模組名稱或資料夾名稱。
4. `Nexus Lead Ops` 只能作為產品化名稱、實作線名稱或別名。
5. 正式模組名稱使用 `Lead Console`。
6. 現有左側選單要保留。
7. 本次以「現有 MVP 保留 + v2.0 平台化擴充」為主。
8. 所有 database / Supabase schema 變更必須採 additive migration，不得破壞現有資料。
9. 若需要調整 Supabase RLS，必須先說明影響範圍，不得讓既有 admin/operator/client 權限失效。
10. 若目前某些 dashboard 指標尚未串接資料，請保留現有 empty state，不要假造資料。
11. 若無法確認現有資料結構，請先完成 codebase / schema inventory，再回報差異，不要直接猜測實作。

---

## 三、請先執行 Preflight，不要直接大量改檔

請先檢查目前專案狀態，輸出一份簡短 Preflight Report，包含：

1. 目前 routes / pages 清單。
2. 目前左側選單與對應 route。
3. 目前 Supabase tables / types / RLS policy 概況。
4. 目前 dashboard 8 張卡片的資料來源是否已串接。
5. 目前「方案與額度」是否已有 plans / quota / subscription / usage 相關資料結構。
6. 目前「月報草稿」是否已有頁面與資料來源。
7. 目前「嵌入碼」是否已有 allowed domain / embed config / iframe / script 設定。
8. 目前 Email Notification 是否使用 Lovable Cloud Email、Mailgun、Resend、Zoho SMTP，或只是 UI placeholder。
9. 任何可能影響現有功能的風險。

請先提供 Preflight Report，再進行修改。

---

## 四、Phase 1 本次優先開發範圍

本次請優先完成「安全、漸進、可驗收」的 Phase 1.1 升級，不要一次做完整 Partner / Referral / Billing。

### 4.1 Dashboard 資料串接與 Empty State 強化

目前 Dashboard 已有 8 張卡片：

```text
客戶總數
啟用網站數
本月新增名單
本月 Email 通知
本月 FAQ 更新
本月 AI 改寫
超量警告
未授權網域警告
```

請確認每張卡片：

- 是否有明確資料來源。
- 若有資料表，請串接實際統計。
- 若尚無資料表，請顯示清楚 empty state：`尚未串接資料`。
- 不要使用假資料。
- 不要移除現有卡片。

建議資料來源對應：

| 卡片 | 建議資料來源 |
|---|---|
| 客戶總數 | customers，排除 archived |
| 啟用網站數 | sites，status = active |
| 本月新增名單 | leads，created_at 當月 |
| 本月 Email 通知 | notifications / email logs，created_at 當月 |
| 本月 FAQ 更新 | faq / knowledge entries，updated_at 當月 |
| 本月 AI 改寫 | usage_logs，usage_type = ai_rewrite |
| 超量警告 | usage + plans / quota |
| 未授權網域警告 | allowed_domains / embed logs |

---

### 4.2 Site Workspace 網站工作區

請為「網站管理」中的每一個網站建立或完善 Site Workspace 概念。

每個網站詳情頁應包含以下區塊或 tabs：

```text
Site Overview
Enabled Modules
Forms
Leads
FAQ / AEO
Notifications
Embeds
Usage
Monthly Report
Settings
```

如果短期無法完成所有 tabs，至少先建立 UI 架構與 route placeholder，並清楚標示哪些是已完成、哪些是待串接。

Site Overview 應顯示：

- 網站名稱
- 網站 URL
- 所屬客戶
- 平台類型：Oasis / Duda / WordPress / Lovable / Replit / Other
- 啟用狀態
- 目前方案
- 當月名單數
- 當月通知數
- 當月 FAQ 更新數
- 是否有超量警告
- 是否有未授權網域警告

---

### 4.3 方案與額度升級為 Plans / Quota / Entitlements 前身

目前左側選單已有「方案與額度」。請保留此命名，但在內部規格上將其視為：

> Plans / Quota / Module Entitlements 的 MVP 前身。

請檢查目前是否已有以下欄位或結構：

```text
plan_id
plan_name
site_id
customer_id
leads_per_month
faq_pages
ai_credits
email_notifications_per_month
monthly_report_limit
usage_count
quota_status
status
```

若尚未完整，請先提出 additive schema 建議，不要直接破壞現有 schema。

本階段不需要串接金流，但要保留未來商業化欄位。

---

### 4.4 月報草稿正式納入 Report Center

目前左側選單已有「月報草稿」，請將它正式視為：

> Report Center / Monthly Report Draft Module

本次請完成或檢查：

- 月報草稿列表頁
- 每個客戶 / 網站可對應月報草稿
- 月報草稿狀態：draft / reviewed / sent / archived
- 月報包含區塊：名單摘要、Email 通知摘要、FAQ/AEO 更新摘要、使用量摘要、異常警告、顧問建議
- 若尚未串接資料，允許先用 empty state 與資料欄位規劃，不要假造內容

---

### 4.5 嵌入碼管理強化

請檢查「嵌入碼」頁是否已支援：

```text
site_id
module_key
embed_type
iframe_url
script_url
allowed_domains
status
created_at
updated_at
```

本次請優先確保：

- 每個網站能查看可用嵌入碼。
- 表單與 FAQ/AEO 能有獨立 embed config。
- 未授權網域警告能對應 allowed_domains / embed logs。
- 不要依賴 Duda API 作為唯一方案，應保留 HTML Widget / iframe / JS embed。

---

## 五、Phase 2 只做預留，不要本次完整開發

以下功能本次只需要預留路由、資料欄位或規格，不要一次完整開發：

```text
Module Center
Campaign / Event / Offer Manager
Partner Console
Referral Tracking
Commission Settlement
Client Portal
Billing / Commercialization
Integration Hub
AI Knowledge Base
```

如果新增選單，請放在「平台擴充」區塊，並標示為 coming soon 或 placeholder，不要影響現有 MVP 主選單。

---

## 六、資料庫與安全要求

請遵守：

1. 所有 schema 變更採 additive migration。
2. 不得 drop table。
3. 不得刪除現有欄位。
4. 不得放寬既有 RLS 至不安全狀態。
5. admin/operator/client 權限必須維持。
6. 若新增 module entitlement / usage / report tables，必須設計清楚 customer_id / site_id 關聯。
7. 所有 public embed route 必須檢查 allowed domain。
8. 所有內部 admin route 必須登入後才能使用。

---

## 七、Email Notification 注意事項

請不要在本次任務中重構 Email Provider 主線。

本次只需要：

- 檢查目前通知設定頁。
- 檢查通知 log 是否存在。
- 確認 dashboard 的「本月 Email 通知」可否串接資料。
- 若 provider 未確認，請標示 provider status = unknown / pending，不要硬改 Mailgun / Resend / Zoho SMTP。

不得在未確認前修改：

```text
Mailgun 主線
Resend 主線
Zoho SMTP fallback
process-email-queue
email_send_log
dispatchLeadNotification
```

---

## 八、UI/UX 要求

請延續現有風格：

- LOHAShare 品牌感
- 左側固定 sidebar
- 橘色主色系
- 卡片式 dashboard
- 簡潔、顧問式、內部營運後台風格
- 中文介面
- 保留現有 icon 與視覺節奏

請避免：

- 大幅改版導致使用者找不到現有功能。
- 把 Phase 2 未完成模組放得太像已完成。
- 在未有資料時顯示假數據。
- 把 Nexus Lead Ops 顯示成正式治理名稱。

---

## 九、驗收標準

完成後請提供：

1. 變更摘要。
2. 新增 / 修改 routes 清單。
3. 新增 / 修改 components 清單。
4. 新增 / 修改 Supabase schema 或 migration 清單。
5. RLS 影響說明。
6. Dashboard 8 張卡片資料來源對照表。
7. Site Workspace 完成狀態。
8. Plans & Quota 完成狀態。
9. Monthly Report Draft 完成狀態。
10. Embed Manager 完成狀態。
11. 尚未完成但已預留的 Phase 2 項目。
12. 測試建議與已知風險。

---

## 十、請先回覆的內容

請不要直接大量改檔。請先回覆：

```text
Preflight Report
Implementation Plan
Risk List
Files likely to change
Database changes needed
```

在確認計畫合理後，再進入實作。

---

# 附註：產品命名規則

請遵守以下命名：

| 層級 | 名稱 |
|---|---|
| Level 0 | LOHAShare AI Platform |
| Level 1 | LOHAShare AI Console / LOHAShare AI 商務網站營運控制台 |
| Level 2 | LOHAShare AI Lead & Notification Console MVP |
| Level 3 | Lead Console、Email Notification、AI FAQ / AEO、Referral、Operator Dashboard、Client Portal、Billing / Commercialization |
| 產品化別名 | Nexus Lead Ops |

`Nexus Lead Ops` 不得取代正式模組名稱 `Lead Console`。
