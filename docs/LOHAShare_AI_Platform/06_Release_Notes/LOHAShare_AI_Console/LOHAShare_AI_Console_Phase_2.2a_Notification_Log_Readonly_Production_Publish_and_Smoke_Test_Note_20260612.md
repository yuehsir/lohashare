# LOHAShare AI Console Phase 2.2a — 通知發送紀錄 Read-only 列表 Production Publish and Smoke Test Note

Release: Phase 2.2a Notification Log Read-only List  
Status: Production Stable · Smoke Test Passed · GitHub Archived  
Date: 2026-06-12

---

## 一、Release Summary

Phase 2.2a 在既有 `/admin/notifications`「通知設定」頁中，於以下既有區塊下方：

```text
Email Provider 狀態
通知設定總覽
```

新增第三個 admin-only read-only 區塊：

```text
通知發送紀錄（最近 100 筆）
```

用途是讓 admin 可檢視近期通知發送狀態，但不提供任何重送、測試寄送、刪除、修改設定或 queue 操作。

本階段只讀取既有 `notification_logs`，不讀 `email_send_log`，並採取嚴格 PII / secret 遮罩策略。

---

## 二、Implemented Scope

### 新增檔案

```text
src/lib/notification-log-overview.functions.ts
```

新增 server function：

```text
getNotificationLogOverview
```

### 修改檔案

```text
src/routes/_authenticated/admin/notifications.tsx
```

### Auto-generated 檔案

```text
src/routeTree.gen.ts
```

`src/routeTree.gen.ts` 由 TanStack Router Vite plugin 自動重新產生。本次未新增 route file，確認無 runtime 行為影響。

---

## 三、Server Function Design

`getNotificationLogOverview` 採用以下設計：

```text
POST
requireSupabaseAuth
handler-level admin-only re-verification
non-admin Forbidden
read-only SELECT only
limit 100
created_at desc
```

讀取資料表：

```text
notification_logs
sites
customers
forms
```

不讀取：

```text
email_send_log
```

原因：`email_send_log` 屬 Email Router 底層寄送紀錄，含較多 PII / provider payload / header 類敏感欄位；Phase 2.2a 只需呈現通知發送狀態，`notification_logs` 已足夠。

---

## 四、Returned Safe Payload

回傳給 client 的資料使用安全格式：

```ts
type NotificationLogOverviewRow = {
  id: string
  createdAt: string
  siteId: string | null
  siteName: string | null
  customerId: string | null
  customerName: string | null
  formId: string | null
  formName: string | null
  channel: string | null
  recipientKind: string | null
  status: string | null
  isTest: boolean
  hasProviderMessageId: boolean
  errorSummary: string | null
}
```

確認不 select / 不 return：

```text
recipient
idempotency_key
完整 provider_message_id
完整 error_message
```

確認轉換策略：

```text
provider_message_id → hasProviderMessageId: boolean
error_message → sanitized errorSummary
recipient → 不回傳、不顯示
idempotency_key → 不回傳、不顯示
```

---

## 五、Error Summary Sanitization

Phase 2.2a 新增 server-side `sanitizeErrorSummary()`。

遮罩策略：

```text
email → [email]
URL / http / https / smtp / smtps / ftp / ws / wss → [url]
Bearer / Authorization token → [token]
JWT → [token]
長 token-like 字串 → [token]
api_key / secret / password 等 key-like 字串 → [key]
最後截斷至 80 字
```

確認 raw `error_message` 不進 client payload。

---

## 六、UI Added

`/admin/notifications` 新增 Card：

```text
通知發送紀錄（最近 100 筆）
```

表格欄位：

```text
發送時間
網站名稱
客戶名稱
表單名稱
渠道
收件類型
狀態
測試
Provider 回應
錯誤摘要
```

顯示規則：

```text
發送時間：createdAt localized datetime
網站名稱：siteName 或 —
客戶名稱：customerName 或 —
表單名稱：formName 或 —
渠道：badge
收件類型：recipientKind badge，不顯示 recipient email
狀態：badge
測試：是 / 否 badge
Provider 回應：有 / 無 badge，不顯示 provider_message_id
錯誤摘要：errorSummary 或 —
```

---

## 七、Client-side Filters

Phase 2.2a 加入兩個低風險 client-side filter：

```text
狀態篩選：全部 / sent / failed / skipped / queued
測試通知篩選：全部 / 正式 / 測試
```

確認：

```text
filter 只在 data.rows 上 useMemo 過濾
不改 server query
不新增 URL search params
不寫入資料
```

---

## 八、Read-only Confirmation

本階段未新增任何操作功能。

確認頁面沒有：

```text
重送按鈕
測試寄送按鈕
刪除按鈕
修改設定操作
設定儲存按鈕
```

本階段未觸發：

```text
email sending
transactional_emails queue write
notification_logs write
email_send_log write
settings mutation
```

---

## 九、Build Report Summary

Build 完成後回報：

```text
1. 新增 src/lib/notification-log-overview.functions.ts
2. 修改 src/routes/_authenticated/admin/notifications.tsx
3. 新增 getNotificationLogOverview
4. 維持 admin-only
5. 只讀 notification_logs
6. 未讀 email_send_log
7. join sites / customers / forms
8. 最近 100 筆
9. created_at desc
10. 未 select / return recipient
11. 未 select / return idempotency_key
12. provider_message_id 只回 boolean
13. error_message server-side sanitize 後才回傳 errorSummary
14. 未回 raw error_message
15. UI 新增「通知發送紀錄（最近 100 筆）」
16. UI 欄位符合規劃
17. client-side filter 已加入
18. 未顯示完整 email
19. 未顯示完整 provider_message_id
20. 未顯示 secret / token / URL
21. 未改 server 寄信邏輯
22. 未改 Email Router / Edge Function
23. 未改 migration / RLS / schema / secrets
24. 未發送 email
25. 未寫 queue / logs
26. 未 Publish
27. 未動 forbidden scope
28. build harness 未見錯誤訊號
```

---

## 十、Preview Validation

Lovable 自動化 preview browser 未具 authenticated session，因此會被導向 login。使用者本人在 Preview 以 admin 登入後，完成 8 項人工目視確認。

使用者確認：

```text
1. /admin/notifications 可成功進入：是
2. 看到「通知發送紀錄（最近 100 筆）」：是
3. 表格欄位標題可讀，沒有直向破碎：是
4. 狀態篩選存在：是
5. 測試通知篩選存在：是
6. Provider 回應只顯示「有 / 無」，沒有完整 provider_message_id：是
7. 畫面沒有完整 recipient email / token / URL / secret：是
8. 沒有白屏 / runtime error：是
```

Preview Validation 結論：通過。

---

## 十一、Publish Pre-confirmation

Publish Pre-confirmation 已通過。

確認項目：

```text
1. Preview Validation 已通過
2. 新增 src/lib/notification-log-overview.functions.ts
3. 修改 src/routes/_authenticated/admin/notifications.tsx
4. routeTree.gen.ts auto-generated；未新增 route file，無 runtime 行為影響
5. 新增 getNotificationLogOverview
6. admin-only 確認
7. 只 SELECT
8. 只讀 notification_logs
9. 未讀 email_send_log
10. 最近 100 筆
11. created_at desc
12. 未 select / return recipient
13. 未 select / return idempotency_key
14. provider_message_id 只回 boolean
15. raw provider_message_id 未進 client
16. error_message 已 sanitize 為 errorSummary
17. raw error_message 未進 client
18. 畫面未顯示完整 email
19. 畫面未顯示 token / URL / secret
20. 沒有重送 / 測試寄送 / 刪除 / 修改設定操作
21. client-side filter 不改 server query
22. 未改 Email Router / Edge Function
23. 未改 migration / RLS / schema / secrets
24. 未改 Auth / Unsubscribe / public submit endpoint
25. 未新增 route / package / provider
26. 未發送 email
27. 未寫 queue / logs
28. metadata check 通過
29. security scan 對最新 commit 為 stale；本次 diff 僅 admin-only read-only SELECT + sanitize，未新增 anon endpoint、未動 RLS / secrets
30. typecheck / build 通過
31. runtime risk 低
32. 等待明確 Publish 指令
```

---

## 十二、Production Publish

Phase 2.2a 已 Publish。

Production URL：

```text
https://app.lohashare.com
```

備用 URL：

```text
https://nexus-lead-ops.lovable.app
```

實際發布檔案：

```text
新增：src/lib/notification-log-overview.functions.ts
修改：src/routes/_authenticated/admin/notifications.tsx
Auto-generated：src/routeTree.gen.ts
```

確認：

```text
未新增 route file
只新增 read-only「通知發送紀錄（最近 100 筆）」
getNotificationLogOverview 維持 admin-only
只 SELECT
只讀 notification_logs
未讀 email_send_log
未 select / return recipient
未 select / return idempotency_key
provider_message_id 只回 boolean
raw provider_message_id 未進 client
error_message 已 sanitize 為 errorSummary
raw error_message 未進 client
未顯示完整 email
未顯示 token / URL / secret
未新增重送 / 測試寄送 / 刪除 / 修改設定操作
未發送 email
未寫 queue / logs
未改 Email Router / Edge Function
未改 migration / RLS / schema / secrets
未改 Auth / Unsubscribe / public submit endpoint
無 build / deployment error
無 runtime error
```

---

## 十三、Production Smoke Test

使用者已手動登入 Production 完成 Smoke Test，25 個結果均正常。

Smoke Test 檢查範圍：

```text
1. Production URL 可進入
2. /admin/notifications 可成功載入
3. 看到「Email Provider 狀態」
4. 看到「通知設定總覽」
5. 看到「通知發送紀錄（最近 100 筆）」
6. 通知發送紀錄欄位符合規劃
7. 表格欄位標題保持可讀
8. 有合理水平捲動
9. 錯誤摘要欄位不撐爆版面
10. 狀態篩選存在
11. 測試通知篩選存在
12. client-side filter 可用
13. 未顯示完整 recipient email
14. 未顯示完整 provider_message_id
15. Provider 回應只顯示有 / 無
16. 未顯示 idempotency_key
17. errorSummary 已遮罩 / 截斷
18. 未顯示 raw error_message
19. 未顯示 API key / SMTP URL / token / secret
20. 沒有重送 / 測試寄送 / 刪除 / 修改設定操作
21. 未發送 email
22. 未寫 queue / logs
23. 無白屏 / runtime error
24. 未動 forbidden scope
25. 可進入 GitHub Archive Note
```

Production Smoke Test 結論：通過。

---

## 十四、Forbidden Scope Confirmation

Phase 2.2a 未修改：

```text
migration
RLS
schema
secrets
Email Router behavior
Edge Function
queue process
notifications.server.ts
notifications.functions.ts
notification_settings query
public submit endpoint
unsubscribe
Auth
CSV
provider adapters
failed retry / resend feature
new provider
new package
new route
```

Phase 2.2a 未觸發：

```text
email sending
transactional_emails queue write
notification_logs write
email_send_log write
settings mutation
```

---

## 十五、Known Notes

1. `src/routeTree.gen.ts` 為 TanStack Router Vite plugin auto-generated regeneration，本次未新增 route file，無 runtime 行為影響。
2. Security scan 對最新 commit 為 stale；本次 diff 僅 admin-only read-only SELECT + sanitize，未新增匿名可達端點、未動 RLS / secrets。
3. Lovable 自動化 preview browser 不具 authenticated session；Preview UI validation 由使用者本人 admin 登入後人工目視確認。
4. Production Smoke Test 由使用者本人 admin 登入後完成，25 項均正常。

---

## 十六、Final Status

```text
Phase 2.2a：Production Stable / Archived
```

Final status：

```text
Production Stable
Read-only Notification Log List Added
PII / Secret Masking Confirmed
Smoke Test Passed
GitHub Archived
```
