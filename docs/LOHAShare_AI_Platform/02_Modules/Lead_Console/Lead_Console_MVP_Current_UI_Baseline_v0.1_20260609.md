# Lead Console MVP Current UI Baseline v0.1

版本時間：2026-06-09 00:07（Asia/Taipei）  
版本號：v0.1  
文件狀態：Draft / Module UI Baseline Candidate / Not Committed by ChatGPT  
候選路徑：`LOHAShare_AI_Platform/02_Modules/Lead_Console/`  
正式模組名稱：Lead Console  
產品化別名 / 實作線：Nexus Lead Ops / LOHAShare AI Lead & AEO Console

---

## 0. 文件目的

本文件用於保存目前 Lovable 後台截圖所呈現的 Lead Console MVP Current UI Baseline，避免後續進行 LOHAShare AI Console v2.0 規劃時誤判為需要重做整套後台。

本文件是模組現況基準，不是主 PRD，也不是 Developer Prompt。

---

# 一、命名與治理定位

| 項目 | 判斷 |
|---|---|
| 正式 Level 3 模組名稱 | Lead Console |
| 產品化名稱 / 實作線 | Nexus Lead Ops |
| MVP 畫面名稱 | LOHAShare AI Lead & AEO Console |
| 上層平台 | LOHAShare AI Console |
| 禁止使用路徑 | `02_Modules/Nexus_Lead_Ops/` |
| 建議候選路徑 | `LOHAShare_AI_Platform/02_Modules/Lead_Console/` |

Nexus Lead Ops 可保留為產品化名稱、展示名稱、實作線名稱或外部溝通名稱，但正式文件治理應對應 `Lead_Console`。

---

# 二、目前截圖觀察到的 UI 結構

## 2.1 品牌區

左上角顯示：

```text
LOHAShare
AI Console
```

代表目前系統已經開始使用 LOHAShare AI Console 品牌，而不只是單一 Lead 工具。

## 2.2 左側選單

目前左側選單包含：

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

## 2.3 主內容標題

主內容標題：

```text
儀表板
LOHAShare AI Lead & AEO Console 維運總覽
```

這表示目前此畫面定位為維運總覽，適合內部 Admin / Operator 使用。

---

# 三、Dashboard 卡片基準

目前 Dashboard 顯示 8 張卡片：

| 卡片名稱 | 目前顯示 | 狀態說明 |
|---|---|---|
| 客戶總數 | 5 | 排除已封存 |
| 啟用網站數 | 3 | status = active |
| 本月新增名單 | — | 尚未串接資料 |
| 本月 Email 通知 | — | 尚未串接資料 |
| 本月 FAQ 更新 | — | 尚未串接資料 |
| 本月 AI 改寫 | — | 尚未串接資料 |
| 超量警告 | — | 尚未串接資料 |
| 未授權網域警告 | — | 尚未串接資料 |

## 3.1 UI 判斷

目前 Dashboard 已具備正確 MVP 架構。後續應以「串接資料、擴充指標」為主，不應重做 Layout。

## 3.2 Phase 1 應優先補齊

```text
本月新增名單資料來源
本月 Email 通知資料來源
本月 FAQ 更新資料來源
本月 AI 改寫資料來源
超量警告資料來源
未授權網域警告資料來源
```

---

# 四、現有功能與模組對照

| 現有 UI | 模組對應 | 建議狀態 |
|---|---|---|
| 儀表板 | Operator Dashboard | 保留 |
| 客戶管理 | Customers | 保留 |
| 網站管理 | Sites | 保留 |
| 方案與額度 | Plans / Quota | 保留並升級為 Entitlements 前身 |
| 表單管理 | Forms | 保留 |
| 名單管理 | Lead Console | 保留 |
| FAQ / AEO | AI FAQ / AEO | 保留 |
| 通知設定 | Email Notification | 保留 |
| 嵌入碼 | Embed Manager | 保留 |
| 使用量 | Usage Monitor | 保留 |
| 月報草稿 | Report Center | 正式納入規格 |

---

# 五、Lead Console MVP 邊界

## 5.1 屬於 Lead Console MVP 的範圍

- 客戶與網站的基本關聯
- 表單設定
- 名單收集
- 名單查看
- 名單來源
- 通知設定
- 表單嵌入碼
- 使用量摘要

## 5.2 與 Lead Console 強關聯但可分模組管理

- Email Notification
- AI FAQ / AEO
- Embed Manager
- Usage Monitor
- Report Center

## 5.3 不應直接塞入 Lead Console 的範圍

- Partner Portal
- Referral 分潤完整邏輯
- Campaign Manager 完整活動管理
- Billing 完整金流
- Client Portal 完整客戶自助

這些應作為 Phase 2 或 Phase 3 平台模組。

---

# 六、現有 UI 不應被破壞的原因

1. 已具備清楚的資訊架構。
2. 已符合內部維運人員的初期使用需求。
3. 已涵蓋客戶、網站、方案、表單、名單、FAQ、通知、嵌入、使用量、月報等核心項目。
4. 適合作為 LOHAShare AI Console Phase 1 基本盤。
5. 後續擴充可採增量方式，不需重做。

---

# 七、建議後續 Lovable 開發方向

## 7.1 不建議

```text
請重做整個後台 UI
請把 Nexus Lead Ops 改成新的主系統
請新增 Nexus_Lead_Ops 模組資料夾
請刪除現有選單重建
```

## 7.2 建議

```text
請保留現有左側選單與 Dashboard Layout
請補齊 Dashboard 8 張卡片資料來源
請強化方案與額度，作為 Module Entitlements 的前身
請將月報草稿納入 Report Center 的 MVP
請預留 Referral / Campaign / Partner 欄位與路由，但不必一次完成
```

---

# 八、資料欄位補強建議

## 8.1 Leads 應預留

```text
referral_code
partner_id
campaign_id
utm_source
utm_medium
utm_campaign
embed_id
source_url
```

## 8.2 Sites 應預留

```text
platform_type
allowed_domain
module_entitlement_status
current_plan_id
```

## 8.3 Usage 應預留

```text
module_key
usage_type
usage_count
usage_period
quota_limit
quota_status
```

## 8.4 Monthly Report 應預留

```text
report_month
lead_summary
notification_summary
faq_aeo_summary
usage_summary
warnings_summary
consultant_notes
client_visible_status
```

---

# 九、版本差異與歸檔判斷

## 9.1 是否已從舊版新增補內容

是。

本文件是依據使用者補充的 Lovable 後台截圖與 LOHAShare AI Console v2.0 平台整合需求，新增的 Lead Console MVP Current UI Baseline。

## 9.2 從哪確認文件版本的來源

來源包含：

- 本對話中使用者補充的 Lovable 後台截圖
- 本對話中已確認的 LOHAShare AI Console 整合方向
- 使用者提供的 `LOHAShare_AI_Platform_folder_tree.txt`

## 9.3 GitHub repo tree 驗證狀態

使用者聲明 folder tree 已透過 GitHub Desktop commit / sync。  
ChatGPT 尚未實際透過 GitHub connector 校驗 repo tree。

## 9.4 是否可宣稱已寫入 GitHub

否。

## 9.5 是否可宣稱已 commit

否。僅可表述使用者聲明已透過 GitHub Desktop commit / sync folder tree。

---

# 十、下一步

建議後續若要進入 Lovable 開發，先產生：

```text
Lead Console MVP Dashboard Data Wiring Prompt v0.1
```

但 Developer Prompt 正本路徑需先提出治理更新提案，避免靜默新增不一致的 Prompt 資料夾。
