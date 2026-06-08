# LOHAShare AI Console 平台 PRD v2.0 完整版

版本時間：2026-06-09 00:07（Asia/Taipei）  
版本號：v2.0 Draft  
文件狀態：Draft / Main PRD Candidate / Not Committed by ChatGPT  
候選路徑：`LOHAShare_AI_Platform/00_Main_PRD/Current/`  
Level 0：LOHAShare AI Platform  
Level 1：LOHAShare AI 商務網站營運控制台 / LOHAShare AI Console  
Level 2：LOHAShare AI Lead & Notification Console MVP  
第一 MVP 基本盤：LOHAShare AI Lead & AEO Console  
產品化別名 / 實作線：Nexus Lead Ops / Lead Console

---

## 0. 版本來源與治理聲明

本版本是累積式完整新版，不是單純變更摘要，也不是 Release Note。

本版本基於以下來源整合：

1. 舊版 LOHAShare AI 商務網站營運控制台主 PRD 線索。
2. LOHAShare AI Lead & AEO Console / Nexus Lead Ops / Lead Console 既有討論。
3. 微型創業 AI 賦能聯盟平台與 LOHAShare AI Platform 整合需求。
4. 使用者補充之 Lovable 後台截圖。
5. 使用者提供之 `LOHAShare_AI_Platform_folder_tree.txt`。
6. 使用者聲明該 folder tree 已透過 GitHub Desktop commit / sync 至雲端 GitHub。

重要限制：

- ChatGPT 尚未實際進入 GitHub repo tree 做 connector 校驗。
- 本文件僅為 Markdown 歸檔素材。
- 不得宣稱本文件已寫入 GitHub。
- 不得宣稱本文件已 commit。
- 不得宣稱已建立 PR。

---

# 一、版本定位

本版本的核心目標，是將原本分散的兩個專案：

1. 微型創業 AI 賦能聯盟平台
2. LOHAShare AI Platform

整合為同一個平台主線：

> LOHAShare AI Console

LOHAShare AI Console 是建立在 Oasis / Duda / 其他 CMS 外部的雲端加值模組平台。它不是取代 Oasis，不是重做 CMS，而是作為一個可被嵌入網站、可管理客戶、可管理名單、可管理 AI FAQ / AEO、可追蹤 Referral、可產生報表、可支援分潤與模組化收費的外部商務營運中台。

---

# 二、產品核心判斷

LOHAShare AI Console 的策略定位是：

> 在 Oasis / Duda / 其他 CMS 外部，建立一個可管理客戶、網站、名單、AI FAQ/AEO、通知、Referral、模組權限、使用量、方案收費與營運報表的外部 AI 商務營運中介層。

Oasis / Duda 負責網站前台與 CMS 編輯。  
LOHAShare AI Console 負責商務營運、加值模組、AI 知識管理、名單追蹤、權限與收費。

---

# 三、整合後產品架構

## 3.1 Level 0：LOHAShare AI Platform

平台總品牌，負責整體 AI 商務平台、文件治理、模組治理、長期 Roadmap、系統架構與商業模式整合。

## 3.2 Level 1：LOHAShare AI Console

主控制後台，負責統一管理：

- Customers
- Sites
- Plans & Quota
- Module Entitlements
- Forms
- Leads
- FAQ / AEO
- Notifications
- Embeds
- Usage
- Monthly Reports
- Partners
- Referrals
- Campaigns
- Reports
- Settings

## 3.3 Level 2：LOHAShare AI Lead & Notification Console MVP

第一階段 MVP 實作線，先建立資料貫穿基本盤。

## 3.4 Level 3：正式模組

依治理命名，正式 Level 3 模組包含：

- Lead Console
- Email Notification
- AI FAQ / AEO
- Referral
- Operator Dashboard
- Client Portal
- Billing / Commercialization

本版本建議新增或預留以下模組定位：

- Embed Manager
- Report Center / Monthly Report Draft
- Campaign / Event / Offer Manager
- Partner Console
- AI Knowledge Base
- Integration Hub

其中，新增模組是否需要正式資料夾，應後續提出治理更新提案，不應直接靜默新增。

---

# 四、兩個原專案的整合定位

## 4.1 微型創業 AI 賦能聯盟平台

整合後定位：業務成長入口、Partner / Referral / Training 入口。

主要支援：

- 夥伴招募
- 授權碼
- Referral Link
- QR Code
- 活動 / 課程 / 說明會導流
- 名單來源追蹤
- 成交狀態追蹤
- 分潤紀錄
- AI 接案與微型創業訓練

## 4.2 LOHAShare AI Platform

整合後定位：技術產品母體與主控後台。

主要支援：

- 客戶網站管理
- 表單 / 名單管理
- FAQ / AEO
- Email Notification
- 嵌入碼
- 使用量
- 月報草稿
- 模組化收費
- 顧問代維運
- 後續 SaaS 化

## 4.3 整合判斷

微型創業平台不再視為平行產品，而是 LOHAShare AI Console 的業務入口之一。  
LOHAShare AI Platform 不再只是一組模糊專案，而是 LOHAShare AI Console 的平台母體與治理架構。

---

# 五、現有 MVP 後台基準

根據使用者補充的 Lovable 後台截圖，目前 LOHAShare AI Lead & AEO Console 已存在以下左側選單：

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

## 5.1 修訂後判斷

本版本不應要求重做現有 UI。  
正確策略是：

> 保留現有 MVP 後台結構，將其升級為 LOHAShare AI Console Phase 1 基本盤，並在 Phase 2 逐步加入平台級模組。

## 5.2 目前 Dashboard 已出現的 8 張卡片

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

這些指標應正式列入 Phase 1 Dashboard 基準。

---

# 六、MVP 必須保留與強化的功能

## 6.1 Customers 客戶管理

用途：管理客戶公司、聯絡人、狀態與專案歸屬。

必要能力：

- 新增 / 編輯 / 停用客戶
- 綁定網站
- 查看方案與使用量
- 查看名單與月報

## 6.2 Sites 網站管理

用途：管理客戶網站與可嵌入模組。

必要能力：

- 網站名稱
- 網站 URL
- 平台類型：Oasis / Duda / WordPress / Lovable / Replit / Other
- allowed domain
- 啟用狀態
- 綁定方案
- 綁定嵌入碼

## 6.3 Plans & Quota 方案與額度

此功能是未來 Module Entitlements 的 MVP 前身。

必要能力：

- 每月名單額度
- FAQ / AEO 額度
- AI credits
- Email 通知額度
- 月報產生額度
- 超量警告
- 停權 / 升級欄位預留

## 6.4 Forms 表單管理

用途：管理嵌入網站的表單。

必要能力：

- 表單名稱
- 所屬網站
- 表單類型
- 啟用 / 停用
- 嵌入碼
- 提交後通知設定

## 6.5 Leads 名單管理

用途：統一名單核心。

必要能力：

- 名單列表
- 名單詳情
- 狀態管理
- 來源紀錄
- 表單來源
- 網站來源
- Referral 欄位預留
- Campaign 欄位預留
- 匯出

## 6.6 FAQ / AEO

用途：管理網站前台可嵌入的 FAQ、AEO 與 AI 內容改寫。

必要能力：

- 問題
- 回答
- 分類
- 所屬網站
- 狀態
- 嵌入顯示
- AI 改寫紀錄
- 未來 Knowledge Base 擴充

## 6.7 Notifications 通知設定

用途：管理名單送出後的通知。

必要能力：

- 收件人
- 通知主旨
- 通知樣板
- 寄送紀錄
- Provider 欄位預留
- Resend / Zoho SMTP fallback 架構預留

## 6.8 Embeds 嵌入碼

用途：管理可嵌入 Oasis / Duda / 其他 CMS 的模組代碼。

必要能力：

- 表單嵌入碼
- FAQ / AEO 嵌入碼
- allowed domain 驗證
- script / iframe 類型預留
- 嵌入狀態
- 未授權網域警告

## 6.9 Usage 使用量

用途：支援方案、超量、收費與顧問營運判斷。

必要能力：

- 依客戶查看使用量
- 依網站查看使用量
- 依模組查看使用量
- 每月統計
- 超額提示
- 報表輸出欄位預留

## 6.10 Monthly Report Draft 月報草稿

此功能應正式納入 Report Center 模組。

必要能力：

- 本月名單摘要
- 本月 FAQ / AEO 更新摘要
- 本月 Email 通知摘要
- 本月使用量摘要
- 異常警告摘要
- 給客戶看的顧問式月報草稿
- 未來 AI 自動產生報告

---

# 七、MVP 階段必須預留的未來資料模型

## 7.1 Module Entitlements

用於管理每個客戶 / 網站是否啟用某模組。

必要欄位：

```text
entitlement_id
customer_id
site_id
module_key
plan_id
enabled
usage_limit
quota_type
starts_at
ends_at
billing_status
status
```

## 7.2 Unified Lead Core

所有來源名單都應進入同一名單核心。

來源包含：

- Oasis 表單
- Duda 嵌入表單
- Referral Link
- QR Code
- 說明會報名
- 課程報名
- 顧問諮詢
- FAQ 詢問
- Zoho Forms
- Webhook

## 7.3 Source Attribution

必要欄位：

```text
referral_code
partner_id
campaign_id
landing_page_id
utm_source
utm_medium
utm_campaign
qr_code_id
form_id
embed_id
```

## 7.4 Campaign / Event / Offer

用於定義不同導流主題。

類型包含：

- seminar
- course
- consultation
- website_project
- aeo_service
- gbp_booking
- ecommerce
- partner_recruitment

## 7.5 Partner / Referral

用於支援微型創業平台與聯合營業處。

必要能力：

- partner_id
- authorization_code
- referral_url
- qr_code_id
- lead attribution
- deal_status
- commission_status

---

# 八、UI/UX 分階段策略

## 8.1 Phase 1：保留現有 MVP 選單

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
```

## 8.2 Phase 2：新增平台級擴充模組

```text
模組中心
活動 / Campaign
夥伴管理
Referral 追蹤
分潤紀錄
客戶入口
系統設定
操作紀錄
```

## 8.3 Phase 3：入口分流

未來登入後依角色分流：

- Admin Console
- Operator Console
- Client Portal
- Partner Portal

---

# 九、商業模式

## 9.1 客戶端模組加購

可銷售：

- Lead Basic
- Lead Pro
- AEO Basic
- AEO Pro
- Notification Add-on
- Report Add-on
- Referral Add-on
- AI Knowledge Add-on

## 9.2 顧問代維運

初期最適合採用：

- LOHAShare 內部人員代客戶管理
- 客戶先不登入或只看報表
- 降低 SaaS 客服成本
- 形成穩定月費服務

## 9.3 夥伴 / 聯盟分潤

支援：

- 夥伴推薦
- 名單歸屬
- 成交追蹤
- 分潤紀錄
- 說明會 / 課程導流

## 9.4 未來 SaaS 自助

後期可開放：

- 客戶自行建立表單
- 自行管理 FAQ
- 自行查看報表
- 自行購買模組
- 自行升級方案

---

# 十、Roadmap

## Phase 1：Lead & AEO Console MVP 基本盤

目標：

- Customers
- Sites
- Plans & Quota
- Forms
- Leads
- FAQ / AEO
- Notifications
- Embeds
- Usage
- Monthly Report Draft

## Phase 2：Module Entitlements 與模組中心

目標：

- Module Registry
- Module Entitlements
- 每網站模組啟用狀態
- 使用量與方案限制
- 超量提示

## Phase 3：Referral / Partner

目標：

- Partner 管理
- Referral Link
- QR Code
- Campaign attribution
- 分潤狀態

## Phase 4：Client Portal / Partner Portal

目標：

- 客戶唯讀報表
- 客戶自行管理部分資料
- 夥伴查看推薦成果
- 夥伴查看分潤狀態

## Phase 5：Integration Hub

目標：

- Zoho CRM
- Zoho Campaigns
- Zoho Desk
- GBP Booking
- Email Provider Router
- 電商 / 金流 / 電子發票整合

## Phase 6：AI Operating Layer

目標：

- AI 報表
- AI 客服
- AI 知識庫
- AI 提案
- AI 報價
- AI 文件生成
- AI 顧問助理
- AI 夥伴培訓助理

---

# 十一、成功指標

MVP 階段成功指標：

- 可管理至少 10 個客戶
- 可管理至少 30 個網站
- 每個網站可產生表單嵌入碼
- 表單送出可進入 Leads
- Email 通知可正常發送
- FAQ / AEO 可嵌入網站
- 每個網站可設定方案與額度
- 可追蹤使用量與超量警告
- 可產生月報草稿
- 可支援內部顧問代維運流程

---

# 十二、文件治理與路徑

本文件候選路徑：

```text
LOHAShare_AI_Platform/00_Main_PRD/Current/
```

相關模組候選路徑：

```text
LOHAShare_AI_Platform/02_Modules/Lead_Console/
LOHAShare_AI_Platform/02_Modules/Referral/
```

治理同步紀錄候選路徑：

```text
LOHAShare_AI_Platform/01_Architecture_Governance/01_Document_Governance/Current/
```

禁止新增：

```text
LOHAShare_AI_Platform/02_Modules/Nexus_Lead_Ops/
```

Nexus Lead Ops 僅作為產品化名稱、實作線名稱或別名，不可取代正式模組名稱 `Lead_Console`。

---

# 十三、版本差異摘要

## 是否已從舊版新增補內容

是。

本版本為：

```text
舊 v1.5 主 PRD + Lead & AEO Console MVP + Nexus Lead Ops / Lead Console + Referral + 微型創業 AI 賦能聯盟平台 + Lovable UI 截圖 + folder tree 路徑校正 → v2.0 Draft
```

## 主要新增內容

- 雙業務入口整合
- 現有 Lovable MVP UI 保留策略
- Lead & AEO Console 作為 Phase 1 基本盤
- 月報草稿正式納入 Report Center
- 方案與額度升級為 Plans / Quota / Entitlements 前身
- Referral / Partner / Campaign 預留
- Module Entitlements 資料模型
- Source Attribution 資料模型
- GitHub folder tree 候選路徑校正

---

# 十四、產品策略總結

LOHAShare AI Console 的核心價值不是單一表單工具，也不是單一 FAQ 工具。

它的真正定位是：

> 協助 LOHAShare 將網站設計服務，升級為可持續收費、可模組化加值、可嵌入 CMS、可支援夥伴分潤、可擴充 AI 商務營運能力的外部雲端控制後台。

短期：以 Lead & AEO Console 作為 MVP。  
中期：形成模組化加值服務。  
長期：成為 LOHAShare AI Platform 的核心營運中台。
