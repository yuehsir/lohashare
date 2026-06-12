# LOHAShare AI Console Phase 2.2b — 測試通知前置檢查 Read-only Production Publish and Smoke Test Note

Release: Phase 2.2b Notification Test Readiness Check Read-only  
Status: Production Stable · Smoke Test Accepted · GitHub Archived  
Date: 2026-06-13

---

## 一、Release Summary

Phase 2.2b 在單一網站通知設定頁新增 read-only 區塊：

```text
測試通知前置檢查（Readiness Check）
```

位置：

```text
/admin/sites/{site_id}/notifications
```

目的：在 admin 使用既有「測試寄送」功能前，先以 read-only 方式檢查此 site 的通知設定是否完整、安全、可測。

本階段不做真實 test send，不新增測試寄送按鈕，不修改既有測試寄送按鈕行為，不發送 email，不寫 queue，不寫 logs，不產生 unsubscribe token。

---

## 二、Background and Rationale

Phase 2.2b Planning 已確認既有 `sendTestNotification` 雖為測試通知，但目前會真的寄信，並可能：

```text
寫入 transactional_emails queue
寫入 notification_logs
寫入 email_send_log
產生 email_unsubscribe_tokens
寄給 customer email_recipients
寄給 lohashare_recipients
使用 production provider / fallback provider
```

因此 Phase 2.2b 第一版採用安全方案 A：

```text
Read-only readiness check
```

不採用：

```text
Dry-run Preview
Safe Test Send
```

原因：避免在目前 production stable 階段直接改動寄信行為、queue、provider 或 schema。

---

## 三、Implemented Scope

### 新增檔案

```text
src/lib/notification-test-readiness.functions.ts
```

新增 server function：

```text
getNotificationTestReadiness
```

### 修改檔案

```text
src/routes/_authenticated/admin/sites.$id.notifications.tsx
```

### Auto-generated 檔案

```text
src/routeTree.gen.ts
```

`src/routeTree.gen.ts` 由 TanStack Router plugin 例行 regenerate。本次未新增 route，無 runtime 行為影響。

---

## 四、Server Function Design

`getNotificationTestReadiness` 採用：

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
insert
update
delete
rpc
email sending
queue write
notification log write
email_send_log write
unsubscribe token creation
settings mutation
```

---

## 五、Read Data Sources

允許讀取：

```text
notification_settings
suppressed_emails
sites
user_roles
Email Provider status / infra flags
Email Router enabled flag
Fallback enabled flag
```

未讀取：

```text
email_send_log
notification_logs
leads
forms
transactional_emails queue
```

說明：Phase 2.2b 只做測試通知前置檢查，不做紀錄查詢、不做 template render、不讀真實 lead、不建立 queue。

---

## 六、Returned Safe Payload

Readiness Check 只回傳結構化狀態與 count：

```text
siteId
siteName
overallStatus
notificationEnabled
customerRecipientsCount
hasCustomerRecipients
notifyLohashare
lohashareRecipientsCount
hasLohashareRecipients
fromDomain
hasFromDomain
subjectTemplateLength
hasSubjectTemplate
emailInfraStatus
emailInfraReady
emailRouterEnabled
fallbackEnabled
suppressedRecipientsCount
warnings
blockers
```

確認：

```text
不回傳完整 recipient email
不回傳 recipient domain
不回傳 suppressed email 清單
不顯示 API key / SMTP URL / token / secret
不顯示 raw provider response
不顯示 raw error_message
不 render 真實 template preview
Subject template 只顯示狀態 / 字數
```

補充：頁面上方既有「Email 通知」設定區若顯示 recipients textarea，屬既有設定頁行為，不屬 Phase 2.2b Readiness Check 區塊新增內容。本階段僅要求 Readiness Check 區塊本身不顯示完整 email。

---

## 七、UI Added

新增 Card：

```text
測試通知前置檢查（Readiness Check）
```

顯示內容：

```text
整體狀態：Ready / Warning / Not ready badge
通知總開關
Email Provider 狀態
Email Router 狀態
Fallback Provider 狀態
客戶收件人 count-only
LOHAShare 內部收件人 count-only
Suppressed 命中 count-only
From domain 狀態
Subject template 狀態 / 字數
Blockers
Warnings
```

Read-only 操作：

```text
重新檢查
```

提示文字：

```text
此區塊僅檢查設定狀態，不會寄出 email、不會寫入 queue 或 logs。
```

風險提醒：

```text
目前既有「測試寄送」按鈕會使用正式通知設定，可能寄給客戶收件人。請先確認本區檢查結果後再操作。
```

---

## 八、No New Send / Write Actions

Phase 2.2b 未新增：

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

## 九、Build Report Summary

Build 完成後回報：

```text
1. 新增 src/lib/notification-test-readiness.functions.ts
2. 修改 src/routes/_authenticated/admin/sites.$id.notifications.tsx
3. 新增 getNotificationTestReadiness
4. admin-only
5. 只 SELECT
6. 讀取 notification_settings
7. 讀取 suppressed_emails
8. 讀取 Email Provider / Router / Fallback 狀態
9. 未讀 email_send_log
10. 未讀 notification_logs
11. 未讀 leads / forms / queue
12. 未回傳完整 email
13. 未回傳 recipient domain
14. 只顯示 recipient count
15. 只顯示 suppressed count
16. 新增 Readiness Check Card
17. 顯示 overallStatus / blockers / warnings
18. 說明本區塊不會寄出 email
19. 未新增真實測試寄送按鈕
20. 未改既有測試寄送按鈕行為
21. 未改 sendTestNotification / dispatchLeadNotification
22. 未改 Email Router / Edge Function / queue
23. 未改 migration / RLS / schema / secrets
24. 未發送 email
25. 未寫 queue / logs
26. 未產生 unsubscribe token
27. 未 Publish
28. 未動 forbidden scope
```

---

## 十、Preview Validation

使用者本人在 Preview 以 admin 帳號進入單一網站通知設定頁完成目視確認。

測試 site：

```text
LOHAShare 官網測試站
```

Preview Validation 結果：

```text
1. /admin/sites/{site_id}/notifications 可成功進入：是
2. 看到「測試通知前置檢查（Readiness Check）」：是
3. 區塊位置合理，未破壞原本通知設定頁：是
4. 顯示整體狀態 Ready / Warning / Not ready：是，目前為 Warning badge
5. 顯示通知總開關：是，已啟用
6. 顯示 Email Provider 狀態：是，已啟用
7. 顯示 Email Router 狀態：是，未啟用；另顯示 Fallback Provider 未啟用
8. 顯示客戶收件人 count-only：是，2 位
9. 顯示 LOHAShare 內部收件人 count-only：是，1 位
10. 顯示 Suppressed 命中 count-only：是，0 位
11. 顯示 From domain 狀態：是，已設定
12. 顯示 Subject template 狀態 / 字數：是，已設定，35 字
13. 顯示 Blockers / Warnings：是，Warnings 包含 Email Router 未啟用，將使用 legacy 寄送路徑；無 Blockers
14. Readiness Check 區塊未顯示完整 recipient email：是
15. 未顯示 recipient domain：是
16. 未顯示 suppressed email 清單：是
17. 未顯示 API key / SMTP URL / token / secret：是
18. 未 render 真實 template preview：是，只顯示已設定與字數
19. 有說明此區塊不會寄出 email：是
20. 有提醒既有測試寄送可能使用正式通知設定：是
21. 只有重新檢查 read-only 操作：是
22. 未新增新的真實測試寄送按鈕：是
23. 未改既有測試寄送按鈕行為：是
24. 未點擊既有測試寄送按鈕：是
25. 未發送 email：是
26. 未寫 queue / logs：是
27. 未產生 unsubscribe token：是
28. 無白屏 / runtime error：是；僅有 GA opt-out 相關 SSR hydration mismatch warning，非 Phase 2.2b 引入
29. 未 Publish：是
30. 未動 forbidden scope：是
31. 適合進入 Publish Pre-confirmation：是
```

Preview Validation 結論：通過。

---

## 十一、Publish Pre-confirmation

Publish Pre-confirmation 已通過。

確認事項：

```text
1. Preview Validation 已通過
2. 新增 src/lib/notification-test-readiness.functions.ts
3. 修改 src/routes/_authenticated/admin/sites.$id.notifications.tsx
4. routeTree.gen.ts auto-generated；未新增 route，無 runtime 行為影響
5. 新增 getNotificationTestReadiness
6. admin-only
7. 只 SELECT
8. 讀取 notification_settings
9. 讀取 suppressed_emails
10. 讀取 Email Provider / Router / Fallback 狀態
11. 未讀 email_send_log
12. 未讀 notification_logs
13. 未讀 leads / forms / transactional_emails queue
14. 未回傳完整 email
15. 未回傳 recipient domain
16. 只回傳 recipient count
17. 只回傳 suppressed count
18. 未顯示 suppressed email 清單
19. 未顯示 API key / SMTP URL / token / secret
20. 未 render 真實 template preview
21. Subject template 只顯示狀態 / 字數
22. UI 新增 Readiness Check Card
23. UI 顯示 overallStatus / blockers / warnings
24. UI 說明本區塊不會寄出 email
25. UI 提醒既有測試寄送可能使用正式通知設定
26. 只有重新檢查 read-only 操作
27. 未新增新的真實測試寄送按鈕
28. 未改既有測試寄送按鈕行為
29. 未改 sendTestNotification / dispatchLeadNotification
30. 未改 Email Router / Edge Function / queue
31. 未改 migration / RLS / schema / secrets
32. 未發送 email
33. 未寫 queue / logs
34. 未產生 unsubscribe token
35. metadata check 通過
36. security baseline 與 Phase 2.2a 一致，未新增 public endpoint、未動 RLS / secret / schema
37. typecheck / build 通過
38. runtime risk 低
39. 等待明確 Publish 指令
```

---

## 十二、Production Publish

Phase 2.2b 已 Publish。

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
新增：src/lib/notification-test-readiness.functions.ts
修改：src/routes/_authenticated/admin/sites.$id.notifications.tsx
Auto-generated：src/routeTree.gen.ts
```

確認：

```text
未新增 route
只新增 read-only 測試通知前置檢查
getNotificationTestReadiness admin-only
只 SELECT
讀取 notification_settings
讀取 suppressed_emails
讀取 Email Provider / Router / Fallback 狀態
未讀 email_send_log
未讀 notification_logs
未讀 leads / forms / queue
未回傳完整 email
未回傳 recipient domain
只回傳 recipient count
只回傳 suppressed count
未顯示 suppressed email 清單
未顯示 API key / SMTP URL / token / secret
未 render 真實 template preview
未新增真實測試寄送按鈕
未改既有測試寄送按鈕行為
未改 sendTestNotification / dispatchLeadNotification
未改 Email Router / Edge Function / queue
未改 migration / RLS / schema / secrets
未發送 email
未寫 queue / logs
未產生 unsubscribe token
無 build / deployment error
無 runtime error
```

---

## 十三、Production Smoke Test

使用者已手動登入 Production 完成 Smoke Test。

使用者回報：

```text
1-4：均正常
5. 顯示整體狀態 Ready / Warning / Not ready：只有 Warning 出現
6-25：均正常
26. 未點擊既有測試寄送按鈕：是，未點擊
27. 未發送 email：是，未發送
28. 是否確認未寫 queue / logs：使用者不知道；依本階段 code 與 Publish pre-confirmation，Readiness Check 只 SELECT、不寫 queue / logs，且使用者未點擊既有測試寄送按鈕，因此接受為未寫 queue / logs
29. 是否確認未產生 unsubscribe token：使用者不知道；依本階段 code 與 Publish pre-confirmation，Readiness Check 不產生 unsubscribe token，且使用者未點擊既有測試寄送按鈕，因此接受為未產生 unsubscribe token
30. 無白屏 / runtime error
31. 是否確認未動 forbidden scope：使用者不知道；依 Build、Pre-confirmation 與 Publish scope，未動 forbidden scope，因此接受
32. 是否可進入 GitHub Archive Note：依上述確認，可以進入
```

關於第 5 項：目前僅顯示 Warning 是可接受狀態；Preview 亦顯示 Warning，原因為 Email Router 未啟用、將使用 legacy 寄送路徑。此為 Readiness Check 的正確警示結果，不代表失敗。

Production Smoke Test 結論：通過並接受限制註記。

---

## 十四、Forbidden Scope Confirmation

Phase 2.2b 未修改：

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

Phase 2.2b 未觸發：

```text
email sending
transactional_emails queue write
notification_logs write
email_send_log write
unsubscribe token creation
settings mutation
```

---

## 十五、Known Notes

1. `src/routeTree.gen.ts` 為 TanStack Router plugin 例行 regenerate。本次未新增 route，無 runtime 行為影響。
2. Readiness Check 顯示 Warning 屬預期，因 Email Router 未啟用，將使用 legacy 寄送路徑。
3. 頁面上方既有 Email 通知設定區若顯示 recipients textarea，屬既有設定頁行為，不屬 Phase 2.2b 新增區塊。
4. GA opt-out 相關 SSR hydration mismatch warning 為既有 / 外部屬性問題，非 Phase 2.2b 引入。
5. 使用者無法直接確認 queue / logs / unsubscribe token 是否未寫入；依 Phase 2.2b code scope、pre-confirmation、publish report，以及使用者未點擊既有測試寄送按鈕，可接受為未觸發寫入。

---

## 十六、Final Status

```text
Phase 2.2b：Production Stable / Archived
```

Final status：

```text
Production Stable
Read-only Test Readiness Check Added
No Email Sent
No Queue / Logs Written
No Unsubscribe Token Created
Smoke Test Accepted
GitHub Archived
```
