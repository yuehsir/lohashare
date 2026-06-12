# LOHAShare AI Console Phase 2.2c-a — 測試通知 Dry-run Preview Read-only Production Publish and Smoke Test Note

Release: Phase 2.2c-a Notification Dry-run Preview Read-only  
Status: Production Stable · Smoke Test Accepted · GitHub Archived  
Date: 2026-06-13

---

## 一、Release Summary

Phase 2.2c-a 在單一網站通知設定頁新增 read-only 區塊：

```text
測試通知 Dry-run 預覽（Dry-run Preview）
```

位置：

```text
/admin/sites/{site_id}/notifications
```

目的：讓 admin 在不寄信、不寫 queue、不寫 logs、不產生 unsubscribe token 的情況下，預覽如果真的測試寄送，會發生什麼。

本階段不做真實 test send，不新增測試寄送按鈕，不修改既有測試寄送按鈕行為，不發送 email，不寫 queue，不寫 logs，不產生 unsubscribe token。

---

## 二、Background and Rationale

Phase 2.2b 已完成「測試通知前置檢查（Readiness Check）」。Phase 2.2c-a 延伸此安全流程，加入 Dry-run Preview，用於在真正測試寄送前檢查：

```text
收件人數量
suppression 命中數
預期 provider path
subject preview
template plain-text snippet
warnings / blockers
```

Dry-run Preview 僅為 read-only preview，不進入寄送流程。

---

## 三、Implemented Scope

### 新增檔案

```text
src/lib/notification-dry-run-preview.functions.ts
```

新增 server function：

```text
getNotificationDryRunPreview
```

### 修改檔案

```text
src/routes/_authenticated/admin/sites.$id.notifications.tsx
```

### routeTree.gen.ts

Publish Completion Report 回報本次 git diff 未顯示 `src/routeTree.gen.ts` 或其他 auto-generated 檔案變更；未新增 route。

---

## 四、Server Function Design

`getNotificationDryRunPreview` 採用：

```text
POST
input: { siteId }
requireSupabaseAuth
handler-level admin-only re-verification via user_roles
non-admin Forbidden
read-only SELECT only
```

確認未執行：

```text
sendTestNotification
dispatchLeadNotification
provider adapter call
Email Router send path
insert
update
delete
rpc
email sending
transactional_emails queue write
notification_logs write
email_send_log write
unsubscribe token creation
notification_settings mutation
```

---

## 五、Read Data Sources

允許讀取：

```text
sites
notification_settings
suppressed_emails
user_roles
Email Provider status / infra flags
Email Router enabled flag
Fallback enabled flag
```

未讀取：

```text
leads
forms
notification_logs
email_send_log
transactional_emails queue
```

`form_name` 使用 placeholder：

```text
測試表單
```

---

## 六、Fake Data and Preview Strategy

Dry-run preview 使用 fake data，不讀真實 lead。

Subject preview：

```text
使用 fake data
使用 placeholder form name
可使用 site name，因 site name 在該頁本來就可見
有 [測試] 前綴
maskPII
truncate 120 字
```

Template snippet：

```text
使用 fake lead
react-email render
htmlToPlainText
maskPII
truncate 300 字
純文字顯示
不顯示 HTML iframe
不顯示完整 HTML
不顯示 unsubscribe URL
```

遮罩策略：

```text
email → ***@***
phone / 連續 7 位以上數字 → ***
URL → [link]
JWT / long token → [token]
```

---

## 七、Provider Path Preview

Provider path 只顯示名稱層級，例如：

```text
Legacy Lovable Emails
Email Router disabled → Legacy path
Router enabled → Primary provider
Router enabled → Primary + Fallback available
Not ready
```

允許顯示：

```text
legacy
resend
zoho_smtp
```

確認未顯示：

```text
RESEND_API_KEY
SMTP_RELAY_URL
provider raw response
endpoint URL
secret
token
```

---

## 八、UI Added

新增 Card：

```text
測試通知 Dry-run 預覽（Dry-run Preview）
```

位置：

```text
接在「測試通知前置檢查（Readiness Check）」下方
```

顯示內容：

```text
Dry-run 整體狀態 Ready / Warning / Not ready
通知總開關
Customer recipients count-only
LOHAShare recipients count-only
Suppressed recipients count-only
Provider path preview
Email Provider 狀態
Email Router 狀態
Fallback 狀態
From domain
Subject preview
Template plain-text snippet
Warnings
Blockers
```

Read-only 操作：

```text
重新產生 Dry-run
```

安全提示：

```text
此區塊只產生預覽，不會寄出 email、不會寫入 queue 或 logs，也不會產生 unsubscribe token。
```

---

## 九、No New Send / Write Actions

Phase 2.2c-a 未新增：

```text
新的測試寄送按鈕
發送測試通知
立即測試
寄出測試信
重送
刪除
修改設定
設定儲存
```

既有「測試寄送」按鈕：

```text
未修改行為
未刪除
未停用
未在本階段改造
```

---

## 十、Build Report Summary

Build 完成後回報：

```text
1. 新增 src/lib/notification-dry-run-preview.functions.ts
2. 修改 src/routes/_authenticated/admin/sites.$id.notifications.tsx
3. 新增 getNotificationDryRunPreview
4. admin-only
5. 只 SELECT
6. 未呼叫 sendTestNotification
7. 未呼叫 dispatchLeadNotification
8. 讀取 notification_settings / suppressed_emails / sites
9. 讀取 Email Provider / Router / Fallback 狀態
10. 未讀 leads / forms / notification_logs / email_send_log / transactional_emails queue
11. 未發送 email
12. 未寫 queue / logs
13. 未產生 unsubscribe token
14. 未回傳完整 recipient email
15. 未回傳 recipient domain
16. 只回傳 recipient count / suppressed count
17. 產生 subject preview，使用 fake data，遮罩並截斷
18. 產生 template plain-text snippet，使用 fake data，遮罩並截斷
19. 未顯示 HTML iframe / unsubscribe URL
20. 顯示 provider path preview，未顯示 secret / endpoint / raw response
21. 新增 Dry-run Preview Card
22. UI 顯示 blockers / warnings
23. UI 說明不會寄出 email、不會寫 queue/logs
24. 只有重新產生 Dry-run read-only 操作
25. 未新增新的真實測試寄送按鈕
26. 未改既有測試寄送按鈕行為
27. 未改 Email Router / Edge Function / queue
28. 未改 migration / RLS / schema / secrets
29. 未 Publish
30. 未動 forbidden scope
```

---

## 十一、Preview Validation

使用者本人在 Preview 以 admin 帳號進入單一網站通知設定頁完成目視確認。

Preview Validation 結果：

```text
1. /admin/sites/{site_id}/notifications 可成功進入：是
2. 看到「測試通知 Dry-run 預覽（Dry-run Preview）」：是
3. 區塊位置在 Readiness Check 下方或附近：是，緊接其下方
4. 未破壞原本通知設定頁：是
5. 顯示 Dry-run 整體狀態 Ready / Warning / Not ready：是，目前為 Warning
6. 顯示通知總開關：是，已啟用
7. Customer recipients count-only：是，2 位
8. LOHAShare recipients count-only：是，1 位
9. Suppressed recipients count-only：是，0 位
10. 顯示 provider path preview：是，Legacy Lovable Emails（Router 未啟用）
11. provider path 只顯示名稱層級：是
12. 顯示 Email Provider 狀態：是，已啟用
13. 顯示 Email Router 狀態：是，未啟用
14. 顯示 Fallback 狀態：是，未啟用
15. 顯示 From domain：是，已設定
16. 顯示 Subject preview：是，[測試] [新名單] LOHAShare 官網測試站 - 測試表單
17. Subject preview 使用 fake data：是
18. Subject preview 有 [測試] 前綴：是
19. Subject preview 未顯示真實 recipient / lead PII：是
20. 顯示 Template plain-text snippet：是
21. Template snippet 使用 fake data：是
22. Template snippet 為純文字、非 HTML iframe：是
23. Template snippet 已遮罩 email / phone / URL / token：是
24. Template snippet 未顯示 unsubscribe URL：是
25. 顯示 Warnings / Blockers：是，Warnings 包含 Email Router 未啟用，將使用 legacy 寄送路徑；無 Blockers
26. 未顯示完整 recipient email：是
27. 未顯示 recipient domain：是
28. 未顯示真實 lead email / phone / message：是
29. 未顯示 API key / SMTP URL / token / secret：是
30. 未顯示 raw provider response / raw error_message：是
31. 有說明此區塊不會寄出 email、不會寫 queue/logs：是
32. 只有重新產生 Dry-run read-only 操作：是
33. 未新增新的真實測試寄送按鈕：是
34. 未改既有測試寄送按鈕行為：是
35. 未點擊既有測試寄送按鈕：是
36. 未發送 email：是
37. 未寫 queue / logs：是
38. 未產生 unsubscribe token：是
39. 無白屏 / runtime error：是
40. 未 Publish：是
41. 未動 forbidden scope：是
42. 適合進入 Publish Pre-confirmation：是
```

補充：Template plain-text snippet 經 react-email render → htmlToPlainText → maskPII → truncate 300 字後顯示「[測試] LOHAShare 官網測試站 - 測試表單 收到新名單 …」開頭內容；末端「…」表示已達 300 字截斷上限，行為正確。

Preview Validation 結論：通過。

---

## 十二、Publish Pre-confirmation

Publish Pre-confirmation 已通過。

確認事項：

```text
1. Preview Validation 已通過
2. 新增 src/lib/notification-dry-run-preview.functions.ts
3. 修改 src/routes/_authenticated/admin/sites.$id.notifications.tsx
4. 無 routeTree.gen.ts 或其他 auto-generated 檔案變更
5. 新增 getNotificationDryRunPreview
6. admin-only
7. 只 SELECT
8. 未呼叫 sendTestNotification
9. 未呼叫 dispatchLeadNotification
10. 讀取 notification_settings / suppressed_emails / sites
11. 讀取 Email Provider / Router / Fallback 狀態
12. 未讀 leads / forms / notification_logs / email_send_log / transactional_emails queue
13. 未發送 email
14. 未寫 queue / logs
15. 未產生 unsubscribe token
16. 未回傳完整 recipient email
17. 未回傳 recipient domain
18. 只回傳 recipient count / suppressed count
19. Subject preview 使用 fake data，有 [測試] 前綴，已遮罩與截斷
20. Template snippet 使用 fake data，純文字，已遮罩與截斷，未顯示 unsubscribe URL
21. Provider path 只顯示名稱層級，未顯示 secret / endpoint / raw response
22. UI 新增 Dry-run Preview Card，位於 Readiness Check 下方
23. UI 顯示 blockers / warnings
24. UI 說明本區塊不會寄出 email、不會寫 queue/logs
25. 只有重新產生 Dry-run read-only 操作
26. 未新增新的真實測試寄送按鈕
27. 未改既有測試寄送按鈕行為
28. 未改 sendTestNotification / dispatchLeadNotification
29. 未改 Email Router / Edge Function / queue
30. 未改 migration / RLS / schema / secrets
31. metadata check 通過 / 不適用於 admin 內部頁
32. security scan findings: []
33. runtime risk 低
34. 等待明確 Publish 指令
```

---

## 十三、Production Publish

Phase 2.2c-a 已 Publish。

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
新增：src/lib/notification-dry-run-preview.functions.ts
修改：src/routes/_authenticated/admin/sites.$id.notifications.tsx
```

Publish Completion Report 確認：

```text
未新增 route
只新增 read-only 測試通知 Dry-run 預覽
getNotificationDryRunPreview admin-only
只 SELECT
未呼叫 sendTestNotification
未呼叫 dispatchLeadNotification
讀取 sites / notification_settings / suppressed_emails
讀取 Email Provider / Router / Fallback 狀態
未讀 leads / forms / notification_logs / email_send_log / transactional_emails queue
未回傳完整 recipient email
未回傳 recipient domain
只回傳 recipient count / suppressed count
subject preview 使用 fake data，已遮罩與截斷
 template snippet 使用 fake data，純文字、非 HTML iframe，已遮罩與截斷
未顯示 unsubscribe URL
provider path 只顯示名稱層級
provider path 未顯示 secret / endpoint / raw response
未新增新的真實測試寄送按鈕
未改既有測試寄送按鈕行為
未改 sendTestNotification / dispatchLeadNotification
未改 Email Router / Edge Function / queue
未改 migration / RLS / schema / secrets
未發送 email
未寫 queue / logs
未產生 unsubscribe token
build / deployment error：無，typecheck pass、build ✓
runtime error：無
```

Security note：security scan 對最新 commit 為 stale，但既有 findings: []；本次未涉及 schema / RLS / policy / secret / public endpoint，風險仍低。

---

## 十四、Production Smoke Test

Production 自動化瀏覽器無 admin session，被導向 `/login`，符合預期，未代填帳密。使用者本人已在 production admin session 手動確認。

使用者回報：

```text
3–31 項均正常。
```

補充確認：

```text
有看到「測試通知 Dry-run 預覽（Dry-run Preview）」
Subject preview 正常，無真實 recipient / lead PII
Template snippet 正常，純文字、已遮罩、已截斷
Provider path 只顯示名稱層級，無 endpoint / secret / token
未點擊既有「測試寄送」按鈕
未發送 email
未看到白屏 / runtime error
```

Production Smoke Test 結論：通過並接受登入限制註記。

---

## 十五、Forbidden Scope Confirmation

Phase 2.2c-a 未修改：

```text
sendTestNotification
dispatchLeadNotification
notifications.server.ts 的寄送行為
notifications.functions.ts 的寄送行為
Email Router
Edge Function
queue process
provider adapters
migration
RLS
schema
secrets
email_send_log
notification_logs
leads
forms
transactional_emails queue
public submit endpoint
unsubscribe
Auth
CSV
new route
new package
```

Phase 2.2c-a 未觸發：

```text
email sending
transactional_emails queue write
notification_logs write
email_send_log write
unsubscribe token creation
settings mutation
provider adapter call
Email Router send path
```

---

## 十六、Known Notes

1. Dry-run Preview 目前顯示 Warning 屬預期，因 Email Router 未啟用，將使用 legacy 寄送路徑。
2. 頁面上方既有 Email 通知設定區若顯示 recipients textarea，屬既有設定頁行為，不屬 Phase 2.2c-a 新增區塊。
3. Production 自動化無 admin session，已停在 `/login`；使用者本人已於 production admin session 完成第 3–31 項目視確認。
4. Security scan 對最新 commit 為 stale，但既有 findings: []，本次未新增 public endpoint、未動 RLS / schema / secrets。

---

## 十七、Final Status

```text
Phase 2.2c-a：Production Stable / Archived
```

Final status：

```text
Production Stable
Read-only Dry-run Preview Added
No Email Sent
No Queue / Logs Written
No Unsubscribe Token Created
Smoke Test Accepted
GitHub Archived
```
