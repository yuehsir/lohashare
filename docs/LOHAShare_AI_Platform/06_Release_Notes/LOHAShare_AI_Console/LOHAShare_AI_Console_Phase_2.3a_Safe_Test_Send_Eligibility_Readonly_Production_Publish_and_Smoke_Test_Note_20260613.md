# LOHAShare AI Console Phase 2.3a — Safe Test Send Eligibility Read-only Production Publish and Smoke Test Note

Release: Phase 2.3a Safe Test Send Eligibility Read-only  
Status: Production Stable · Smoke Test Accepted · GitHub Archived  
Date: 2026-06-13

---

## 一、Release Summary

Phase 2.3a 在單一網站通知設定頁新增 read-only 區塊：

```text
安全測試寄送資格檢查（Safe Test Send Eligibility）
```

位置：

```text
/admin/sites/{site_id}/notifications
```

目的：在未來真正做 Safe Test Send 前，先以 read-only 方式判斷此 site 是否具備安全測試寄送資格。

本階段不做真實 test send，不新增 `sendSafeTestNotification`，不新增真實寄送按鈕，不新增 disabled send card，不修改既有「測試寄送」按鈕行為，不發送 email，不寫 queue，不寫 logs，不寫 activity_logs，不產生 unsubscribe token。

---

## 二、Background and Rationale

Phase 2.3 Planning Report 確認既有 `sendTestNotification` 仍具備高風險特徵：可能寄給 customer recipients、寫 queue/logs、產生 unsubscribe token，且沒有 rate limit、confirmation dialog 或 approved internal recipients 機制。

因此 Phase 2.3 不直接 Build 真實寄送，而先拆出 Phase 2.3a：Safe Test Send Eligibility Read-only Build。

本階段只建立資格檢查層，讓後續 Phase 2.3b / 2.3c 可逐步接上 disabled UI、confirmation dialog、internal-only write action 與 audit / rate limit guardrails。

---

## 三、Implemented Scope

### 新增檔案

```text
src/lib/notification-safe-test-send.functions.ts
```

新增 server function：

```text
getSafeTestSendEligibility
```

### 修改檔案

```text
src/routes/_authenticated/admin/sites.$id.notifications.tsx
```

### routeTree.gen.ts

Publish Completion Report 回報本次未新增 route；若有 `src/routeTree.gen.ts` regenerate，僅為 TanStack Router plugin 例行重生，無 runtime 行為影響。

---

## 四、Server Function Design

`getSafeTestSendEligibility` 採用：

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
sendSafeTestNotification
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
activity_logs write
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
activity_logs
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
email_unsubscribe_tokens
```

---

## 六、Approved Internal Recipients Strategy

Phase 2.3a 不新增 schema。

Approved internal recipients 來源策略：

```text
第一來源：notification_settings.lohashare_recipients
補底來源：current_admin_self，即 context.claims.email
若 context.claims.email 為空，approvedSource 回 none
```

確認：

```text
customer email_recipients 完全不納入 approved recipients
notification_settings.email_recipients 完全排除於 approved 計算外
不猜測、不捏造 admin email
不回傳完整 approved recipient email
不回傳 approved recipient domain
不回傳 approved recipient list
只回傳 approvedRecipientCount
只回傳 approvedSuppressedCount
只回傳 approvedSource enum
```

Allowed `approvedSource` enum：

```text
lohashare_recipients
current_admin_self
none
```

---

## 七、Rate Limit Strategy

Rate limit 採 read-only 查詢 `activity_logs`：

```text
action = notification.test_send.queued
actor_user_id = current user id
site_id = input siteId
created_at > now() - interval 10 minutes
```

回傳：

```text
rateLimit.allowed
cooldownRemainingSeconds
windowMinutes
```

確認：

```text
不寫 activity_logs
不新增 rate limit table
不新增 schema
```

---

## 八、Eligibility Output

回傳欄位包含：

```text
canSend
readinessStatus
dryRunStatus
approvedRecipientCount
approvedSuppressedCount
approvedSource
rateLimit.allowed
cooldownRemainingSeconds
windowMinutes
providerPathLabel
emailInfraReady
emailRouterEnabled
fallbackEnabled
blockers
warnings
```

Blockers 支援：

```text
notification_disabled
email_infra_not_ready
no_approved_internal_recipients
all_approved_recipients_suppressed
rate_limited
missing_from_domain
missing_subject_template
```

Warnings 支援：

```text
email_router_disabled_legacy_path
fallback_disabled
using_current_admin_self_as_fallback_recipient
lohashare_recipients_partially_suppressed
safe_test_send_not_yet_enabled
```

---

## 九、UI Added

新增 Card：

```text
安全測試寄送資格檢查（Safe Test Send Eligibility）
```

位置：

```text
接在「測試通知 Dry-run 預覽（Dry-run Preview）」下方
```

顯示內容：

```text
Eligibility 狀態
Readiness status
Dry-run status
Approved internal recipients count
Approved source
Approved suppressed count 或 blocker/warning
Rate limit 狀態
Cooldown remaining seconds
windowMinutes
Provider path
Email Provider 狀態
Email Router 狀態
Fallback 狀態
Blockers
Warnings
```

Read-only 操作：

```text
重新檢查資格
```

安全提示：

```text
此區塊只檢查是否具備安全測試寄送資格，不會寄出 email、不會寫入 queue 或 logs。
```

治理提示：

```text
Safe Test Send 尚未啟用或仍在規劃中。
```

---

## 十、No Send Button / No Write Actions

Phase 2.3a 未新增：

```text
安全測試寄送
發送測試通知
立即測試
寄出測試信
重送
刪除
修改設定
設定儲存
disabled send card
```

既有「測試寄送」按鈕：

```text
未修改行為
未刪除
未停用
未在本階段改造
```

---

## 十一、PII / Secret Safety

確認 UI 與 server function 不顯示或回傳：

```text
完整 recipient email
recipient domain
approved recipient list
customer recipient list
真實 lead email
真實 lead phone
真實 lead message
unsubscribe URL
provider message id
API key
SMTP URL
Bearer token
JWT
password
secret
raw error_message
raw provider response
endpoint URL
```

確認：

```text
approved recipients 只顯示 count
customer recipients 不納入 eligibility recipient
suppressed recipients 只顯示 count 或 blocker，不列 email
provider path 只顯示名稱層級
錯誤只顯示安全 warning / blocker
```

---

## 十二、Build Report Summary

Build 完成後回報：

```text
1. 新增 src/lib/notification-safe-test-send.functions.ts
2. 修改 src/routes/_authenticated/admin/sites.$id.notifications.tsx
3. route tree 由 plugin 自動 regenerate，無新增 route
4. 新增 getSafeTestSendEligibility
5. admin-only
6. 只 SELECT
7. 未新增 sendSafeTestNotification
8. 未呼叫 sendTestNotification
9. 未呼叫 dispatchLeadNotification
10. 讀取 sites / notification_settings / suppressed_emails / activity_logs
11. 讀取 Email Provider / Router / Fallback flags
12. 未讀 leads / forms / notification_logs / email_send_log / transactional_emails queue / email_unsubscribe_tokens
13. 未發送 email
14. 未寫 queue / logs
15. 未寫 activity_logs
16. 未產生 unsubscribe token
17. 未回傳完整 recipient email
18. 未回傳 recipient domain
19. 只回傳 approved recipient count
20. customer recipients 不納入 approved recipients
21. 回傳 approvedSource enum
22. 回傳 rateLimit 狀態
23. 回傳 cooldownRemainingSeconds
24. 回傳 providerPathLabel
25. 新增 Safe Test Send Eligibility Card
26. UI 顯示 canSend / blockers / warnings
27. UI 說明本區塊不會寄出 email、不會寫 queue/logs
28. 只有重新檢查資格 read-only 操作
29. 未新增新的真實測試寄送按鈕
30. 未新增 disabled send card
31. 未改既有測試寄送按鈕行為
32. 未改 Email Router / Edge Function / queue
33. 未改 migration / RLS / schema / secrets
34. 仍未 Publish
35. 未動 forbidden scope
```

備註：approved 內部收件人補底來源為 `context.claims.email`；若該欄位為空，`approvedSource` 回 `none` 並觸發 `no_approved_internal_recipients` blocker；不會猜測或捏造。

---

## 十三、Preview Validation

Preview Validation 使用者回報：

```text
自動化瀏覽器沒有 admin authenticated session，停在「載入中…」/login gate，符合預期，未要求帳密。
使用者本人在 Preview admin session 的 session replay 顯示 Safe Test Send Eligibility 區塊已渲染並含 Warning + Email Router 未啟用提示。
```

Preview Validation 結果：

```text
1. /admin/sites/{site_id}/notifications 可進入：可，使用者已成功進入；自動化被 auth gate 擋下，符合預期
2. 看到「安全測試寄送資格檢查（Safe Test Send Eligibility）」：是
3. 區塊位於 Dry-run Preview 下方：是
4. 未破壞既有通知設定頁：是
5. 顯示 Eligibility 整體狀態 badge：是
6. 顯示 Readiness status：是
7. 顯示 Dry-run status：是
8. 顯示 approvedRecipientCount，count-only：是
9. 顯示 approvedSource enum：是
10. 未顯示完整 approved email：是
11. 未顯示 domain：是
12. 未顯示 list：是
13. customer email_recipients 嚴格排除：是，程式僅讀 lohashare_recipients 或 admin self
14. 顯示 rate limit 狀態：是
15. 顯示 cooldownRemainingSeconds，目前為 0 / allowed：是
16. 僅 SELECT activity_logs，未寫入：是
17. 顯示 providerPathLabel：是
18. provider path 只顯示名稱層級：是，legacy / resend / zoho_smtp
19. 未顯示 secret / endpoint / raw response：是
20. 顯示 Email Provider 狀態：是
21. 顯示 Email Router 狀態：是，目前 disabled，顯示 warning
22. 顯示 Fallback 狀態：是
23. 顯示 Blockers / Warnings：是
24. 區塊註明不寄 email、不寫 queue/logs：是
25. safe_test_send_not_yet_enabled warning 已列出：是
26. 只有「重新檢查資格」read-only 操作：是
27. 未新增真實寄送按鈕：是
28. 未新增 disabled send card：是
29. 未改既有測試寄送按鈕：是
30. 未點擊既有測試寄送按鈕：是
31. 未發送 email：是
32. 未寫 queue / logs：是
33. 未寫 activity_logs：是
34. 未產生 unsubscribe token：是
35. 未顯示 API key / SMTP URL / token / secret：是
36. 未顯示 raw provider response / raw error_message：是
37. 無白屏 / runtime error：是
38. 仍未 Publish：是
39. 未動 forbidden scope：是
40. 適合進入 Publish Pre-confirmation：是
```

Preview Validation 結論：通過。

---

## 十四、Publish Pre-confirmation

Publish Pre-confirmation 已通過。

確認事項：

```text
1. Preview Validation 已通過
2. 新增 src/lib/notification-safe-test-send.functions.ts
3. 修改 src/routes/_authenticated/admin/sites.$id.notifications.tsx
4. 未新增 route
5. 新增 getSafeTestSendEligibility
6. admin-only
7. 只 SELECT
8. 未新增 sendSafeTestNotification
9. 未呼叫 sendTestNotification
10. 未呼叫 dispatchLeadNotification
11. 讀取 sites / notification_settings / suppressed_emails / activity_logs
12. 讀取 Email Provider / Router / Fallback 狀態
13. 未讀 leads / forms / notification_logs / email_send_log / transactional_emails queue / email_unsubscribe_tokens
14. 未發送 email
15. 未寫 queue / logs
16. 未寫 activity_logs
17. 未產生 unsubscribe token
18. 未回傳完整 recipient email
19. 未回傳 recipient domain
20. 只回傳 approvedRecipientCount + approvedSuppressedCount
21. customer email_recipients 嚴格排除於 approved 計算外
22. 回傳 approvedSource enum
23. 回傳 rateLimit { allowed, cooldownRemainingSeconds, windowMinutes }
24. 回傳 providerPathLabel，名稱層級，無 secret
25. UI 新增 Safe Test Send Eligibility Card
26. 位於 Dry-run Preview 下方
27. 顯示 canSend / blockers / warnings
28. UI 已說明不寄 email、不寫 queue/logs
29. UI 列出 safe_test_send_not_yet_enabled warning
30. 只有重新檢查資格 read-only 操作
31. 未新增真實寄送按鈕
32. 未新增 disabled send card
33. 未改既有測試寄送按鈕行為
34. 未改 sendTestNotification / dispatchLeadNotification
35. 未改 Email Router / Edge Function / queue
36. 未改 migration / RLS / schema / secrets
37. metadata check：內部 admin 頁面，未動 root head / SEO metadata
38. security scan findings = 0
39. typecheck / build：harness 自動執行；本次新增/修改檔案 type-safe
40. runtime risk 低
41. 等待明確 Publish 指令
```

---

## 十五、Production Publish

Phase 2.3a 已 Publish。

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
新增：src/lib/notification-safe-test-send.functions.ts
修改：src/routes/_authenticated/admin/sites.$id.notifications.tsx
```

Publish Completion Report 確認：

```text
未新增 route
只新增 read-only 安全測試寄送資格檢查
getSafeTestSendEligibility 維持 admin-only
只 SELECT
未新增 sendSafeTestNotification
未呼叫 sendTestNotification
未呼叫 dispatchLeadNotification
讀取 sites / notification_settings / suppressed_emails / activity_logs / Email Provider / Router / Fallback 狀態
未讀 leads / forms / notification_logs / email_send_log / transactional_emails / email_unsubscribe_tokens
未發送 email
未寫 queue / logs
未寫 activity_logs
未產生 unsubscribe token
未回傳完整 recipient email
未回傳 recipient domain
只回傳 approvedRecipientCount
customer recipients 不納入 approved
回傳 approvedSource
回傳 rateLimit 狀態
回傳 cooldownRemainingSeconds
回傳 providerPathLabel，名稱層級
UI 新增 Safe Test Send Eligibility Card
位於 Dry-run Preview 下方
顯示 canSend / blockers / warnings
UI 說明不寄 email、不寫 queue/logs
UI 提醒 Safe Test Send 尚未啟用，safe_test_send_not_yet_enabled warning
只有重新檢查資格 read-only 操作
未新增真實測試寄送按鈕
未新增 disabled send card
未改既有測試寄送按鈕行為
未改 sendTestNotification / dispatchLeadNotification
未改 Email Router / Edge Function / queue
未改 migration / RLS / schema / secrets
build / deployment error：無
runtime error：無
```

---

## 十六、Production Smoke Test

使用者回報：

```text
42 項通過
```

代表 Production Smoke Test 已確認：

```text
1. Production URL 可進入
2. /admin/sites/{site_id}/notifications 可成功載入或已由登入 admin session 確認
3. 看到「安全測試寄送資格檢查（Safe Test Send Eligibility）」
4. 區塊位於 Dry-run Preview 下方或附近
5. 未破壞原本通知設定頁
6. 顯示 Eligibility 狀態
7. 顯示 Readiness status
8. 顯示 Dry-run status
9. 顯示 approved internal recipients count
10. 顯示 approved source
11. 顯示 approved suppressed count 或相關 blocker/warning
12. 未顯示完整 approved recipient email
13. 未顯示 approved recipient domain
14. 未顯示 approved recipient list
15. customer recipients 未納入 approved recipients
16. 顯示 rate limit 狀態
17. 顯示 cooldown remaining seconds
18. 顯示 windowMinutes
19. 未寫 activity_logs
20. 顯示 provider path
21. provider path 只顯示名稱層級
22. provider path 未顯示 secret / endpoint / raw response
23. 顯示 Email Provider 狀態
24. 顯示 Email Router 狀態
25. 顯示 Fallback 狀態
26. 顯示 Blockers / Warnings
27. 有說明此區塊不會寄出 email、不會寫 queue/logs
28. 有提醒 Safe Test Send 尚未啟用或仍在規劃中
29. 只有重新檢查資格或等效 read-only 操作
30. 未新增新的真實測試寄送按鈕
31. 未新增 disabled send card
32. 未改既有測試寄送按鈕行為
33. 未點擊既有測試寄送按鈕
34. 未發送 email
35. 未寫 queue / logs
36. 未寫 activity_logs
37. 未產生 unsubscribe token
38. 未顯示 API key / SMTP URL / token / secret
39. 未顯示 raw provider response / raw error_message
40. 無白屏 / runtime error
41. 未動 forbidden scope
42. 可進入 GitHub Archive Note
```

Production Smoke Test 結論：通過。

---

## 十七、Forbidden Scope Confirmation

Phase 2.3a 未修改：

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
email_unsubscribe_tokens
public submit endpoint
unsubscribe
Auth
CSV
new route
new package
```

Phase 2.3a 未觸發：

```text
email sending
transactional_emails queue write
notification_logs write
email_send_log write
activity_logs write
unsubscribe token creation
settings mutation
provider adapter call
Email Router send path
```

---

## 十八、Known Notes

1. Phase 2.3a 只做 read-only eligibility，不做真實 Safe Test Send。
2. `safe_test_send_not_yet_enabled` warning 是預期狀態，用於提醒 Safe Test Send 仍未啟用。
3. Customer `email_recipients` 嚴格排除於 approved recipients 計算外。
4. Approved recipients 僅以 count/source enum 顯示，不顯示 email、domain 或 list。
5. 若 production 自動化沒有 admin session，可由使用者本人登入 admin 後目視確認；本次使用者已回報 42 項通過。

---

## 十九、Recommended Next Step

建議下一步：

```text
Phase 2.3b — Safe Test Send UI Disabled / Confirmation Design
```

Phase 2.3b 建議仍不做真實寄送，只新增 UI-only disabled Safe Test Send card 與 confirmation dialog 文案設計，用於確認最終互動流程與風險提示。

Phase 2.3c 才考慮：

```text
sendSafeTestNotification Internal-only Write Build
```

---

## 二十、Final Status

```text
Phase 2.3a：Production Stable / Archived
```

Final status：

```text
Production Stable
Read-only Safe Test Send Eligibility Added
No Safe Test Send Function Added
No Email Sent
No Queue / Logs Written
No Activity Logs Written
No Unsubscribe Token Created
Smoke Test Accepted
GitHub Archived
```
