# Nexus Lead Ops — MVP 功能盤點與操作流程說明

> 版本：Phase 3c Stable — Lead & Notification Console MVP
> 狀態：已完成驗收，尚未進入 Phase 4

---

## 1. 已完成的 Phase 1～Phase 3c 功能

### Phase 1 — 基礎平台與權限
- Supabase 整合（Lovable Cloud）
- 認證系統（Email + Password 登入）
- RBAC 雙角色：`admin`、`operator`
  - `user_roles` 表 + `app_role` enum
  - `current_user_is_admin()` / `current_user_is_operator()` SECURITY DEFINER 函式
- `user_profiles` 透過 auth trigger / service_role 寫入
- Admin layout / Operator layout 分流
- `/admin/*` 路由受 `_authenticated` layout 保護

### Phase 2 — 客戶 / 站點 / 表單管理
- `customers`（客戶）CRUD
- `sites`（站點）CRUD，綁定 `customer_id`、`primary_domain`
- `forms`（表單）CRUD，含：
  - `slug`、`public_key`、`success_message`
  - 內建欄位：name / email / phone / company / message / need_type
  - `custom_fields` JSONB 動態欄位
  - 欄位 enabled / required 設定
- `allowed_domains`（站點允許網域白名單）
- `plans` / `subscriptions`（方案與訂閱）
- `operator_site_access`（operator 可存取的 site 範圍）

### Phase 3a — Public Embed 表單渲染
- `/embed/forms/$slug` 公開路由
- 依照 form 設定動態渲染欄位
- 響應式、可嵌入 iframe

### Phase 3b — Public Submit Pipeline
- TanStack Server Function `submitLeadPublic`
- Honeypot 防機器人
- `loaded_at` 時間閾值防快速送出
- `referer` / `origin` 對應 `allowed_domains` 驗證
- 寫入 `leads`、`monthly_usage.lead_count++`
- 觸發 `dispatchLeadNotifications`（skipped 模式）
- 寫入 `activity_logs.lead.create`

### Phase 3c — Lead & Notification Console
- Lead 列表（依 site 篩選、search、status filter、pagination）
- Lead Drawer 側邊面板（資料 / Notes / Activity 三個 Tab）
- Lead Notes 新增與時間軸
- Lead Status 變更（new / contacted / qualified / closed）
- CSV 匯出（依目前篩選條件、UTF-8 BOM、`custom_data` 攤平為 `custom.{key}`）
- `?leadId=` deep link 自動開啟 Drawer
- Activity Tab 人類可讀摘要
- Notification Settings 管理介面（admin only）
- Notification Dispatch skipped 模式（email infra 尚未配置）
- Embed 表單成功畫面：「再填一筆」+「返回原頁」按鈕

---

## 2. Admin 後台可操作的功能

路徑：`/admin/*`

| 功能區 | 路徑 | 說明 |
|---|---|---|
| Dashboard | `/admin` | 總覽 |
| Customers | `/admin/customers` | 客戶 CRUD |
| Sites | `/admin/sites` | 站點 CRUD |
| Site Detail | `/admin/sites/$id` | 單一站點設定 |
| Forms | `/admin/sites/$id/forms` | 表單 CRUD、欄位設定 |
| Leads | `/admin/sites/$id/leads` | Lead 列表 + Drawer + CSV |
| Notifications | `/admin/sites/$id/notifications` | 通知設定（admin only） |
| Allowed Domains | Site Detail 子區塊 | 嵌入網域白名單 |
| Plans / Subscriptions | `/admin/plans` | 方案管理 |
| Operators | `/admin/operators` | Operator 帳號 + site access |

Operator 僅能看到 `operator_site_access` 授權的 site 範圍，看不到 `notification_settings` 內容（僅看到 recipient count）。

---

## 3. Site / Forms / Leads / Notifications 操作流程

### 建立新客戶與站點
1. `/admin/customers` → New Customer
2. `/admin/sites` → New Site，綁定該 customer、填入 `primary_domain`
3. 在 Site Detail 新增 `allowed_domains`（嵌入頁面的網域）

### 建立表單
1. `/admin/sites/$id/forms` → New Form
2. 設定 `name`、`slug`、`success_message`
3. 開啟需要的內建欄位（phone / company / message / need_type）
4. 視需要新增 `custom_fields`
5. 儲存後取得 embed slug

### 查看 Leads
1. `/admin/sites/$id/leads`
2. 可依 status / search 篩選
3. 點擊任一列開啟 Lead Drawer
4. 右上角「匯出 CSV」依目前篩選條件下載

### 設定通知（admin only）
1. `/admin/sites/$id/notifications`
2. 設定 `email_recipients`（客戶收件人）
3. `lohashare_recipients` 預設 `richard.yueh@lohashare.com`
4. `notify_lohashare` toggle
5. 目前所有通知為 **skipped 模式**（見第 6 節）

---

## 4. iframe 表單嵌入與送出流程

### 嵌入方式
```html
<iframe
  src="https://nexus-lead-ops.lovable.app/embed/forms/{slug}"
  width="100%"
  height="600"
  frameborder="0">
</iframe>
```

### 送出流程
1. 使用者填寫 → 提交
2. 前端呼叫 `submitLeadPublic` server function
3. 後端驗證：
   - honeypot 欄位為空
   - `loaded_at` 距今 > 最小閾值
   - `referer` / `origin` 在 `allowed_domains` 內（或為 published URL 本身）
4. 寫入 `leads`
5. `monthly_usage.lead_count++`
6. 寫入 `activity_logs.lead.create`
7. 觸發 `dispatchLeadNotifications` → 寫入 `notification_logs`（status=skipped）+ `activity_logs.notification.dispatch`
8. 回傳成功 → 顯示成功畫面
9. 使用者可選：
   - 「再填一筆」：清空表單、重設 `loaded_at`
   - 「返回原頁」：`window.location.href = document.referrer`（僅當 referrer 存在）

---

## 5. Lead Drawer / Notes / Status / CSV

### Lead Drawer
- 點擊列表任一 lead 開啟
- URL 同步加上 `?leadId={id}`，可分享 deep link
- 三個 Tab：
  - **資料**：name / email / phone / company / message / need_type / custom_data / form / source page / referer / IP / User-Agent
  - **Notes**：時間軸 + 新增 Note 表單
  - **Activity**：人類可讀摘要（誰、何時、做了什麼）

### Notes
- 輸入 body → 送出
- 寫入 `lead_notes`，`author_user_id = auth.uid()`
- 寫入 `activity_logs.lead.note_add`
- RLS：admin 全權；operator 僅能在自己有 site access 的 lead 下新增

### Status 變更
- Drawer 內下拉選單切換 `new` / `contacted` / `qualified` / `closed`
- 寫入 `activity_logs.lead.status_change`

### CSV 匯出
- 依目前篩選條件（site / status / search）
- UTF-8 with BOM（Excel 中文不亂碼）
- `custom_data` 攤平為 `custom.{key}` 欄位
- 寫入 `activity_logs.lead.export_csv`

---

## 6. Notification Skipped 模式

### 目前狀態
所有 lead 觸發的通知均寫入 `notification_logs`：
- `status = 'skipped'`
- `error_message = 'email_infra_not_configured'`

`monthly_usage.email_sent_count` 永遠維持 0。

### 原因
Phase 3c 範圍不包含 Email 寄送基礎建設：
- 尚未配置 Email DNS（SPF / DKIM / DMARC）
- 尚未整合寄信 provider（Resend / Postmark / SES）
- `from_domain = notify.lohashare.com` 尚未驗證

### 未來切換正式寄信的條件
1. 配置 Email DNS 並通過驗證
2. 整合寄信 provider 並設定 API key
3. 在 `dispatchLeadNotifications` 中：
   - 偵測 infra 已就緒 → 改為實際寄信
   - 成功：`status='sent'`、`provider_message_id`、`email_sent_count++`
   - 失敗：`status='failed'`、`error_message`
4. 配合 plan quota 檢查 `monthly_email_quota`

---

## 7. Security / RLS 重要設計原則

### 角色模型
- 角色存於 `user_roles`，**絕不**放在 `user_profiles`
- 用 `current_user_is_admin()` / `current_user_is_operator()` SECURITY DEFINER 函式避免 RLS recursion

### Site / Customer 範圍控制
- Operator 透過 `operator_site_access` 取得授權範圍
- `current_user_has_site_access(site_id)` / `current_user_has_customer_access(customer_id)` 為標準 wrapper
- `has_site_access` 的 JOIN 缺陷已於 Phase 3c 修正，避免跨 customer 資料外洩

### `user_profiles` 寫入
- 僅由 auth trigger / service_role / server function 寫入
- 一般 `authenticated` 沒有 INSERT / UPDATE GRANT
- 未來若開放編輯，再加 `auth.uid() = user_id` 的 UPDATE policy

### Notification Settings 隱私
- `lohashare_recipients` 與 `email_recipients` 僅 admin 可見
- Operator 看不到實際 email，僅看到 count（透過 safe view）

### Public Submit 安全
- Server function 透過 `supabaseAdmin` 寫入（service_role 繞過 RLS）
- 但前置驗證 honeypot / loaded_at / allowed_domains

### 已接受的 Linter Warnings（Accepted by design）
- Supabase linter 0028 / 0029：`current-user` wrapper functions 與 `normalize_domain` 對 `authenticated` 開放 EXECUTE
- 已 ignore 並寫入 Security Memory，理由：
  - 僅使用 `auth.uid()`，無任意 `user_id` 參數
  - `anon` / `public` 已 revoke
  - `normalize_domain` 為 deterministic safe utility，不查表
  - revoke `authenticated` 會破壞授權架構

---

## 8. 已知限制

- ❌ Email 無法實際寄出（skipped 模式）
- ❌ 無 FAQ 模組
- ❌ 無 AI rewrite 功能
- ❌ 無 LINE Notify / LINE Bot 通知
- ❌ 無 Webhook outbound
- ❌ 無 Google Sheet 同步
- ❌ 無金流 / Stripe / Paddle
- ❌ 無 user profile 自助編輯 UI
- ❌ 無 monthly_usage 重置排程（手動或未來 pg_cron）
- ❌ 無 multi-language i18n（目前繁中固定）
- ❌ Operator 無法管理 notification_settings
- ❌ Lead 無法刪除（僅 admin 可從 SQL）

---

## 9. 不可自動修改的項目（Locked）

以下項目除非使用者明確指示，AI 不得自動更動：

1. **不進 Phase 4**
2. **不新增功能**：FAQ / AI / Email DNS / LINE / Webhook / Google Sheet / 金流
3. **不清測試資料**
4. **不自動 Fix** Supabase linter 0028 / 0029（已 ignored）
5. **不修改** RLS / policy / SECURITY DEFINER function
6. **不修改** `src/integrations/supabase/client.ts` / `client.server.ts` / `types.ts` / `auth-middleware.ts` / `auth-attacher.ts` / `.env`
7. **不修改** `supabase/config.toml` 的 project-level 設定
8. **不新增 GRANT** 給 `anon` / `public`
9. **不啟用** auto-confirm email signup（除非使用者要求）
10. **不刪除** Phase 3c Stable memory

---

## 10. 下一階段 Phase 4 建議方向

> 以下為**建議**，請等候使用者確認後再行規劃。

### 候選方向 A：Email 寄送正式上線
- 配置 Email DNS（SPF / DKIM / DMARC）
- 整合 Resend 或 Postmark
- 將 `dispatchLeadNotifications` 從 skipped 改為實際寄信
- Email template 編輯器（Handlebars 風格 `{{site_name}}` / `{{form_name}}` / `{{lead.*}}`）
- 寄信失敗重試與 bounce 處理
- `monthly_email_quota` 強制檢查

### 候選方向 B：Operator 自助體驗強化
- Operator dashboard（自己的 site 一覽 + 本月 lead 數）
- Operator 可看 notification_settings 的 enabled / form_name（但不看 recipients）
- Lead 批次操作（多選 → status / export / archive）
- Lead Drawer 加入「指派負責人」

### 候選方向 C：Multi-channel 通知
- LINE Notify / LINE Bot
- Webhook outbound（給客戶自家 CRM）
- Google Sheet 自動同步

### 候選方向 D：AI 賦能
- AI 重寫 lead message 摘要
- AI 自動標 need_type
- AI suggested reply
- 需新增 `ai_rewrite_count` 配額機制（schema 已就緒）

### 候選方向 E：商業化
- 串 Stripe / Paddle
- Plan 升降級流程
- Trial → Paid 自動化
- 帳單與發票

### 候選方向 F：Public-facing 強化
- FAQ 模組（schema 已預留 `max_faqs`）
- 嵌入式 FAQ widget
- 表單 A/B 測試

**建議優先順序**：A（解鎖 MVP 真正可用） → B（提升日常操作） → E（商業化） → C / D / F

---

*文件結束 — 僅供盤點與規劃使用，未修改任何程式碼、資料庫、RLS、function、policy、memory 或 security setting。*
