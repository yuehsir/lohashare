# LOHAShare AI Console v2.0 UI/UX Sitemap 與後台選單重構規格 v0.1

版本時間：2026-06-09 00:07（Asia/Taipei）  
版本號：v0.1  
文件狀態：Draft / UIUX Sitemap Candidate / Not Committed by ChatGPT  
候選路徑：`LOHAShare_AI_Platform/00_Main_PRD/Current/`  
關聯主文件：`LOHAShare_AI_Console_Platform_PRD_v2.0_Draft_20260609.md`

---

## 0. 文件目的

本文件用於定義 LOHAShare AI Console v2.0 的後台資訊架構、選單分層、角色入口、現有 MVP UI 保留策略，以及 Phase 2 / Phase 3 擴充時不破壞既有 Lead & AEO Console 的 UI/UX 重構方向。

本文件不是 Lovable Developer Prompt。若後續需要提供給 Lovable 的開發提示詞，應另行產生 Developer Prompt，並先確認 `05_Developer_Prompts` 正本候選路徑。

---

# 一、UI/UX 核心原則

## 1.1 不推翻現有 MVP UI

根據使用者提供的 Lovable 後台截圖，目前系統已具備清楚的 MVP 後台架構。因此 v2.0 UI/UX 的策略不是重做，而是：

> 保留現有 Lead & AEO Console 選單與 Dashboard，將其定義為 LOHAShare AI Console 的 Phase 1 基本盤，再逐步擴充平台級模組。

## 1.2 採用三層式後台架構

| 層級 | 說明 | UI/UX 策略 |
|---|---|---|
| Phase 1 MVP 層 | 現有 Lead & AEO Console | 保留並整理命名 |
| Phase 2 平台擴充層 | Module、Campaign、Partner、Referral、Report Center | 漸進新增 |
| Phase 3 角色入口層 | Admin、Operator、Client、Partner | 依角色分流 |

---

# 二、現有 MVP 左側選單基準

目前截圖顯示左側選單為：

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

## 2.1 對應模組

| 現有選單 | 對應模組 | v2.0 定位 |
|---|---|---|
| 儀表板 | Operator Dashboard / Platform Dashboard 初版 | 保留 |
| 客戶管理 | Customers | 保留 |
| 網站管理 | Sites | 保留 |
| 方案與額度 | Plans / Quota / Entitlements 前身 | 保留並擴充 |
| 表單管理 | Forms | 保留 |
| 名單管理 | Lead Console | 保留 |
| FAQ / AEO | AI FAQ / AEO | 保留 |
| 通知設定 | Email Notification | 保留 |
| 嵌入碼 | Embed Manager | 保留 |
| 使用量 | Usage Monitor | 保留 |
| 月報草稿 | Report Center / Monthly Report Draft | 正式納入模組 |
| 登出 | Auth / Session | 保留 |

---

# 三、Dashboard v2.0 指標設計

## 3.1 Phase 1 已有 Dashboard 卡片

截圖中已出現 8 張卡片：

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

## 3.2 Phase 1 儀表板規格

| 卡片 | 用途 | 資料來源 |
|---|---|---|
| 客戶總數 | 顯示非封存客戶數 | customers |
| 啟用網站數 | 顯示 active 網站數 | sites |
| 本月新增名單 | 顯示當月 leads | leads |
| 本月 Email 通知 | 顯示當月通知量 | notifications |
| 本月 FAQ 更新 | 顯示 FAQ / AEO 更新量 | knowledge / faq |
| 本月 AI 改寫 | 顯示 AI 改寫使用量 | usage_logs |
| 超量警告 | 顯示接近或超過 quota 的客戶 / 網站 | usage + plans |
| 未授權網域警告 | 顯示 embed domain 驗證異常 | allowed_domains / embed_logs |

## 3.3 Phase 2 建議新增卡片

```text
本月 Referral 名單
本月 Campaign 名單
待處理分潤
本月預估月費
即將超額網站
待產生月報
Email 發送異常
```

---

# 四、Site Workspace 網站工作區

每個網站應具備獨立工作區，以避免所有功能分散在全域列表。

## 4.1 Site Workspace 頁面結構

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

## 4.2 Site Overview 顯示內容

- 網站名稱
- 網站 URL
- 所屬客戶
- 平台類型：Oasis / Duda / WordPress / Lovable / Replit / Other
- 啟用狀態
- 當前方案
- 當月名單數
- 當月通知數
- 當月 FAQ 更新數
- 是否有超量警告
- 是否有未授權網域警告

---

# 五、Plans & Quota UI

目前「方案與額度」應被視為 Plans / Quota / Entitlements 的過渡 UI。

## 5.1 MVP 顯示欄位

```text
方案名稱
適用網站
每月名單額度
FAQ / AEO 額度
AI credits
Email 通知額度
月報草稿額度
目前使用量
超量狀態
方案狀態
```

## 5.2 Phase 2 擴充為 Module Entitlements

新增欄位：

```text
module_key
enabled
starts_at
ends_at
billing_status
usage_limit
quota_type
```

---

# 六、Module Center 模組中心

Module Center 不建議在 Phase 1 立即取代現有選單。建議 Phase 2 新增。

## 6.1 Module Center 目標

集中管理每個模組：

- 是否啟用
- 哪些網站啟用
- 對應方案
- 使用量限制
- 是否可嵌入
- 是否產生報表
- 是否涉及收費

## 6.2 初始模組清單

```text
Lead Console
Email Notification
AI FAQ / AEO
Embed Manager
Usage Monitor
Report Center
Referral
Partner Console
Campaign Manager
Billing / Commercialization
Client Portal
```

---

# 七、Referral / Partner / Campaign UI

## 7.1 Phase 2 新增選單

```text
活動 / Campaign
夥伴管理
Referral 追蹤
分潤紀錄
```

## 7.2 Campaign 頁面

欄位：

```text
活動名稱
活動類型
對應 Offer
Landing Page URL
啟用期間
取得名單數
轉換狀態
關聯 Partner
```

## 7.3 Partner 頁面

欄位：

```text
夥伴姓名
授權碼
夥伴等級
Referral Link
QR Code
推薦名單數
成交數
分潤狀態
狀態
```

## 7.4 Referral 追蹤頁面

欄位：

```text
Referral Code
Partner
Lead
Campaign
Source URL
QR Code
Attribution Status
Deal Status
Commission Status
Created At
```

---

# 八、Report Center / 月報草稿

「月報草稿」應正式升級為 Report Center 的 Phase 1 表現。

## 8.1 月報草稿內容

```text
客戶名稱
網站名稱
月份
名單總數
Email 通知總數
FAQ / AEO 更新數
AI 改寫次數
使用量摘要
超量提醒
未授權網域提醒
顧問建議
下一步建議
```

## 8.2 Phase 2 擴充

```text
AI 產生月報
PDF 匯出
寄送給客戶
客戶確認狀態
歷史月報
營運建議模板
```

---

# 九、角色入口設計

## 9.1 Admin

可管理：

- 所有客戶
- 所有網站
- 所有模組
- 所有方案
- 所有使用量
- 所有夥伴
- 所有報表

## 9.2 Operator

可管理被授權客戶與網站：

- 表單
- 名單
- FAQ / AEO
- 通知
- 嵌入碼
- 月報草稿

## 9.3 Client

後期開放：

- 查看自己的網站資料
- 查看名單摘要
- 查看月報
- 查看 FAQ / AEO
- 查看使用量

## 9.4 Partner

後期開放：

- 查看 Referral Link
- 查看 QR Code
- 查看推薦名單
- 查看成交狀態
- 查看分潤狀態

---

# 十、建議左側選單分階段版本

## 10.1 Phase 1：現有 MVP 選單

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

## 10.2 Phase 2：平台擴充選單

```text
儀表板
客戶管理
網站管理
模組中心
方案與額度
表單管理
名單管理
FAQ / AEO
通知設定
嵌入碼
使用量
月報草稿
活動 / Campaign
夥伴管理
Referral 追蹤
分潤紀錄
操作紀錄
系統設定
```

## 10.3 Phase 3：依角色入口分流

```text
Admin Console
Operator Console
Client Portal
Partner Portal
```

---

# 十一、禁止事項

後續 UI/UX 或 Lovable 開發不得：

1. 直接推翻現有後台 UI。
2. 將 Nexus Lead Ops 作為正式模組資料夾名稱。
3. 新增 `02_Modules/Nexus_Lead_Ops/`。
4. 將 Developer Prompt 正本放入 `02_Modules`。
5. 在尚未確認治理前新增 `05_Developer_Prompts/Lovable/` 或 `05_Developer_Prompts/Lead_Console/` 正式路徑。
6. 用 Release Note 取代完整 PRD 或 UI/UX 規格。

---

# 十二、下一步

建議下一步產生：

```text
LOHAShare AI Console v2.0 Lovable Developer Prompt 候選稿
```

但在產生前，應先處理 Developer Prompt 正本路徑治理更新提案。
