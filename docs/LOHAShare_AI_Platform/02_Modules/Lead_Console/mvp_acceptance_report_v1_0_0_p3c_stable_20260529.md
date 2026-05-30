# MVP 驗收報告

> 文件編號：LOHAShare-LNC-MVP-ACR-v1.0.0-P3c-Stable-20260529  
> 版本識別：v1.0.0-P3c-Stable-20260529  
> 基準版本：Phase 3c Stable — Lead & Notification Console MVP  
> 文件日期：2026-05-29  
> 用途：儲存、更新、交接與下一階段規劃

---


## 一、專案目標

本 MVP 的目標，是在 Oasis / Duda 網站系統之外，建立一套 LOHAShare 自有的雲端營運控制台，讓網站交付後仍可持續提供月費型服務。

本階段不以取代 Duda / Oasis CMS 為目標，而是建立一套可外掛、可嵌入、可延伸的 AI 商務營運基礎系統。

核心目標包括：

1. 管理客戶、網站、方案與授權網域。
2. 建立可嵌入外部網站的 iframe 表單。
3. 讓訪客填寫表單後，自動建立 Lead。
4. 提供 Lead 管理、狀態追蹤、備註、活動紀錄與 CSV 匯出。
5. 建立 Notification Dispatch 流程，目前採 skipped 模式，待 Email 基礎建設完成後可切換正式寄送。
6. 建立未來 FAQ / AEO / AI 模組的可延伸基礎。

## 二、已完成階段總覽

| 階段 | 名稱 | 驗收狀態 |
|---|---|---|
| Phase 1 | 登入、角色、後台空殼 | 已完成 |
| Phase 2 | 客戶、網站、方案、授權網域 | 已完成 |
| Phase 2.5a | Activity Logs、二次確認、操作安全 | 已完成 |
| Phase 3a | Forms CRUD、Leads 基礎列表 | 已完成 |
| Phase 3b | iframe 表單送出、leads 寫入、usage_logs、monthly_usage | 已完成 |
| Phase 3c | Notification Settings、Lead Drawer、Notes、Activity、CSV | 已完成 |
| Phase 3d | Email Delivery Activation | 尚未開始 |
| Phase 4 | FAQ / AEO Console | 尚未開始 |

## 三、Phase 3c Stable 已驗收功能

### 1. Embed 表單成功畫面

- 表單可透過 published URL 開啟。
- 表單送出成功後顯示 success message。
- 成功畫面新增「再填一筆」按鈕。
- 「再填一筆」會清空表單、honeypot 欄位，並重新設定 loaded_at。
- 若 document.referrer 存在，顯示「返回原頁」按鈕。
- 成功畫面維持 RWD 與 iframe 友善樣式。

### 2. Lead 建立流程

- 從 published URL 送出表單可正常建立 lead。
- Lead 正確寫入 leads 資料表。
- lead.status 預設為 new。
- source_ip、user_agent、referer 等來源資訊有保留。
- usage_logs 會寫入 lead_created。
- monthly_usage.lead_count 會正確累加。
- activity_logs 會寫入 lead.create，actor_role = system。

### 3. Notification Dispatch skipped 模式

目前 Email 尚未正式啟用，因此系統採 skipped 模式。

- lead 建立後會觸發 dispatchLeadNotification。
- notification_logs 會寫入 status = skipped。
- error_message = email_infra_not_configured。
- 每個應通知 recipient 皆會建立 skipped log。
- activity_logs 會寫入 notification.dispatch。
- monthly_usage.email_sent_count 維持 0。
- Email 未啟用不會影響 lead 建立。
- Email 未啟用不會造成表單送出失敗。

### 4. Lead Drawer

- 點擊 Leads 列表任一列，可開啟右側 Lead Drawer。
- Drawer 由 URL search param ?leadId= 控制。
- 直接帶 ?leadId= 的網址可開啟指定 Lead。
- 關閉 Drawer 後，URL 會移除 leadId。
- Drawer 包含：資料、備註、活動三個 Tab。

資料 Tab 可顯示：name、email、phone、company_name、need_type、message、custom_data、form、source page、referer、IP、User-Agent、created_at。

### 5. Lead Notes

- 可在 Lead Drawer 的 Notes Tab 新增備註。
- 備註會寫入 lead_notes。
- author_user_id 正確對應目前登入者。
- 備註時間軸可顯示。
- 作者名稱顯示順序：user_profiles.display_name → email → user_id 後 8 碼。
- activity_logs 會寫入 lead.note_add。

### 6. Lead Status 管理

- 可在 Drawer 中修改 lead.status。
- 一般狀態可直接修改並顯示 toast。
- 改為 spam / invalid 時會出現確認 dialog。
- 修改成功後 Lead 列表與 Drawer 狀態同步更新。
- activity_logs 會寫入 lead.status_change。
- Operator 僅能修改 status，不能修改 Lead 原始資料。

### 7. Activity Tab

- 可顯示該 lead 的活動紀錄。
- 活動紀錄改為人類可讀摘要。
- before_data / after_data JSON 改為可展開的技術細節。
- 可看到 lead.create、notification.dispatch、lead.status_change、lead.note_add、lead.export_csv。

### 8. CSV 匯出

- 可依目前篩選條件匯出 CSV。
- CSV 使用 UTF-8 with BOM，Excel 開啟中文不亂碼。
- custom_data 攤平成 custom.{key} 多欄。
- 單次匯出上限 10,000 筆。
- 超過上限會提示縮小日期範圍或篩選條件。
- activity_logs 會寫入 lead.export_csv。

## 四、Security / RLS 驗收結果

- admin 登入正常。
- operator 僅能看到授權範圍內的 site / leads / logs。
- current_user_has_site_access 的 flawed JOIN 已修正。
- current_user_has_site_access(NULL) 會回傳 false。
- has_site_access(user_id, NULL) 會回傳 false。
- Operator 看不到 lohashare_recipients / email_recipients 實際 email，只能看到 count。
- user_profiles 不開放 authenticated INSERT / UPDATE。
- current-user wrapper functions 被列為 accepted-by-design。
- normalize_domain 被列為 deterministic safe utility。
- 不自動 Fix Supabase linter 0028 / 0029。

## 五、已知限制

- Email 尚未實際寄出。
- notify.lohashare.com 尚未完成 DNS 驗證。
- Notification Dispatch 目前為 skipped 模式。
- 尚未做 FAQ / AEO 模組。
- 尚未做 AI rewrite。
- 尚未做 LINE / Webhook / Google Sheet。
- 尚未做金流與正式 billing。
- 尚未開放 Client Portal。
- 尚未做 user profile 自助編輯。
- 尚未做完整 Dashboard Analytics。
- 尚未清除測試 fixtures。
- 尚未做 monthly_usage 自動結算排程。

## 六、MVP 驗收結論

Phase 3c Stable 已達成 MVP 基準。系統已可支援：Admin 建立客戶與網站、設定授權網域、建立表單、產生 iframe、外部訪客填表、Lead 進後台、usage_logs / monthly_usage / activity_logs 正常記錄、Notification Dispatch skipped mode 正常留紀錄、Admin / Operator 管理 Lead、備註、狀態與 CSV 匯出。

此版本可作為內部展示版本、MVP 驗收版本、Replit / Claude / Lovable 比較基準、Email Delivery Activation 的穩定基礎，以及未來 FAQ / AEO Console 的前置底層。

## 七、下一步建議

建議下一階段優先順序：Phase 3d — Email Delivery Activation、Operator 自助體驗強化、FAQ / AEO Console、AI Lead Summary / AI Reply Suggestion、Client Portal、Billing / Commercialization。

本報告建議：在進入 Phase 4 前，先完成 Email Delivery Activation，讓 skipped 模式轉為實際寄信，提升 MVP 商業可用性。

