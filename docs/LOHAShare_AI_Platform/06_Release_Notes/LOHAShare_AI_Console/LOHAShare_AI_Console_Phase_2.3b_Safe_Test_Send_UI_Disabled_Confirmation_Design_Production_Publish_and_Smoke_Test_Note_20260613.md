# LOHAShare AI Console Phase 2.3b — Safe Test Send UI Disabled / Confirmation Design Production Publish and Smoke Test Note

Release: Phase 2.3b Safe Test Send UI Disabled / Confirmation Design  
Status: Production Stable · Smoke Test Accepted · GitHub Archived  
Date: 2026-06-13

---

## 一、Release Summary

Phase 2.3b 在單一網站通知設定頁新增 UI-only disabled 區塊：

```text
安全測試寄送（尚未啟用）
Safe Test Send — Disabled Preview
```

位置：

```text
/admin/sites/{site_id}/notifications
```

目的：讓 admin 先看到未來 Safe Test Send 的最終操作流程、確認對話內容與結果區位置。

本階段仍不做真實 test send，不新增 `sendSafeTestNotification`，不新增 server write function，不寄信、不寫 queue、不寫 logs、不寫 activity_logs、不產生 unsubscribe token、不修改 notification settings。

---

## 二、Background and Rationale

Phase 2.3a 已完成 Safe Test Send Eligibility Read-only 檢查，確認未來安全測試寄送前必須先具備 approved internal recipients、rate limit、provider path、readiness/dry-run 狀態等條件。

Phase 2.3b 的目標不是啟用寄送，而是先固定未來真實寄送前的 UI 操作流程與風險提示，包括：

```text
安全測試寄送 disabled card
永遠 disabled 的安全測試寄送按鈕
確認對話內容預覽
確認寄出 disabled button
測試寄送結果 placeholder
```

核心驗收標準：

```text
看得到
按不到
寄不出
沒有副作用
```

---

## 三、Implemented Scope

### 修改檔案

```text
src/routes/_authenticated/admin/sites.$id.notifications.tsx
```

### 新增檔案

```text
無
```

### routeTree.gen.ts

Publish Pre-confirmation 與 Publish Completion Report 均確認：

```text
未新增 route
routeTree.gen.ts 未變更
無 auto-generated 檔案變更
```

---

## 四、UI-only Scope

Phase 2.3b 僅新增 UI-only disabled preview：

```text
1. Safe Test Send disabled card
2. disabled「安全測試寄送（尚未啟用）」按鈕
3.「預覽確認對話內容」Dialog
4.「確認寄出（尚未啟用）」disabled button
5.「測試寄送結果（尚未啟用）」placeholder
```

本階段沿用 Phase 2.3a 的 `getSafeTestSendEligibility` read-only result，未新增任何 server function 或 mutation。

---

## 五、Disabled Button Design

新增 disabled button：

```text
安全測試寄送（尚未啟用）
```

確認：

```text
button 永遠 disabled
button hard-coded disabled
button 無 onClick
button 未綁定 mutation
button 不呼叫任何 send function
button 不觸發 queue / logs / token
```

---

## 六、Confirmation Dialog Preview

新增 read-only dialog trigger：

```text
預覽確認對話內容
```

Dialog title：

```text
安全測試寄送確認（預覽）
```

Dialog 文案確認包含：

```text
本階段僅供 UI 預覽，不會真的寄出 email
未來按下確認後，系統將寄出一封「測試通知」email
寄送對象是 LOHAShare 內部測試收件人
不會寄給客戶正式收件人
不會寄給 notification_settings.email_recipients
不會寄給未核准收件人
不會寄給 suppressed recipients
主旨會強制加入 [測試] 前綴
內容會明確標示為測試通知
會寫入測試 logs / audit logs
會遵守 rate limit
不計入正式 monthly usage
不產生正式 unsubscribe token
```

Dialog buttons：

```text
取消
確認寄出（尚未啟用）
```

確認：

```text
確認寄出（尚未啟用）永遠 disabled
未綁定任何送出行為
未呼叫任何 send function
```

---

## 七、Result Area Placeholder

新增結果區 placeholder：

```text
測試寄送結果（尚未啟用）
```

說明文案：

```text
未來 Safe Test Send 啟用後，這裡會顯示測試寄送結果摘要，例如 queued / failed / skipped 數量與 provider path。
```

確認未顯示：

```text
queue id
message id
完整 email
provider raw response
secret
token
```

---

## 八、No Send / No Write Guarantees

Phase 2.3b 未新增、未呼叫、未觸發：

```text
sendSafeTestNotification
sendTestNotification
dispatchLeadNotification
provider adapter call
Email Router send path
email sending
transactional_emails queue write
notification_logs write
email_send_log write
activity_logs write
unsubscribe token creation
notification_settings mutation
```

未新增：

```text
server write function
route
package
migration
RLS
schema
secrets
```

---

## 九、PII / Secret Safety

確認 UI 不顯示：

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

允許顯示：

```text
approved recipient count
approved source enum
rate limit 狀態
cooldown remaining seconds
provider path label
blockers / warnings
```

---

## 十、Existing Sections Preserved

Phase 2.3b 未破壞以下既有區塊：

```text
Email 通知設定區
其他通知渠道
Readiness Check
Dry-run Preview
Safe Test Send Eligibility
通知發送紀錄
既有「測試寄送」按鈕
```

既有「測試寄送」按鈕行為未被修改，且本階段未點擊既有「測試寄送」按鈕。

---

## 十一、Build Report Summary

Build Report 確認：

```text
1. 只修改 src/routes/_authenticated/admin/sites.$id.notifications.tsx
2. 只修改 UI
3. 新增 Safe Test Send disabled card
4. Card 位於 Safe Test Send Eligibility 下方
5. 新增 disabled「安全測試寄送（尚未啟用）」按鈕
6. disabled button 永遠 disabled，無 onClick / mutation
7. 新增「預覽確認對話內容」Dialog
8. confirmation dialog 只做 UI 預覽，未綁定寄送行為
9. dialog 的「確認寄出（尚未啟用）」disabled
10. 新增 result area placeholder
11. result area 未顯示 queue id / message id / raw provider response
12. 沿用 getSafeTestSendEligibility read-only result
13. 未新增 sendSafeTestNotification
14. 未呼叫 sendTestNotification
15. 未呼叫 dispatchLeadNotification
16. 未發送 email
17. 未寫 transactional_emails queue / notification_logs / email_send_log / activity_logs
18. 未產生 unsubscribe token
19. 未修改 notification_settings
20. 未改 Email Router / Edge Function / queue
21. 未改 migration / RLS / schema / secrets
22. 未讀 leads / forms / logs / queue / unsubscribe tokens
23. 未顯示完整 email / domain / recipient list
24. 未顯示 API key / SMTP URL / token / secret
25. 未顯示 raw provider response / raw error_message
26. 未改既有「測試寄送」按鈕行為
27. 未破壞 Readiness Check / Dry-run Preview / Eligibility Card
28. 仍未 Publish
29. 未動 forbidden scope
30. typecheck 通過，exit 0，no errors
```

---

## 十二、Preview Validation

Preview Validation 使用者確認：

```text
All UI elements verified. Dialog and disabled buttons render correctly.
```

Preview Validation 結果：

```text
1. /admin/sites/{site_id}/notifications 可成功進入：是
2. 看到「安全測試寄送（尚未啟用）」Card：是
3. Card 位於 Safe Test Send Eligibility 下方：是
4. Card 未破壞既有通知設定頁：是
5. 顯示 Eligibility 狀態摘要：是
6. 顯示 Readiness status：是，Warning
7. 顯示 Dry-run status：是，Warning
8. 顯示 approved internal recipients count：是，1 位
9. 顯示 approved source：是，LOHAShare 內部收件人
10. 顯示 rate limit 狀態：是，允許，每 10 分鐘 1 次
11. 顯示 provider path：是，Legacy Lovable Emails，Router 未啟用
12. 顯示 Safe Test Send 尚未啟用：是
13. 看到 disabled「安全測試寄送（尚未啟用）」按鈕：是
14. disabled button 永遠 disabled：是，hard-coded disabled
15. disabled button 沒有 onClick / send mutation：是
16. 看到「預覽確認對話內容」：是，Dialog
17. confirmation dialog 只做 UI 預覽：是
18. dialog 說明本階段不會真的寄出 email：是
19. dialog 說明只寄給 LOHAShare 內部測試收件人：是，1 位
20. dialog 說明不會寄給 customer recipients：是
21. dialog 說明不會寄給 notification_settings.email_recipients：是
22. dialog 說明會遵守 rate limit：是
23. dialog 說明不計入正式 monthly usage：是
24. dialog 說明不產生正式 unsubscribe token：是
25.「確認寄出（尚未啟用）」disabled：是
26. dialog 未綁定寄送行為：是
27. 看到「測試寄送結果（尚未啟用）」placeholder：是
28. result area 未顯示 queue id / message id / raw provider response：是
29. 沿用 getSafeTestSendEligibility read-only result：是
30. 未新增 sendSafeTestNotification：是
31. 未呼叫 sendTestNotification：是
32. 未呼叫 dispatchLeadNotification：是
33. 未發送 email：是
34. 未寫 queue / logs：是
35. 未寫 activity_logs：是
36. 未產生 unsubscribe token：是
37. 未修改 notification_settings：是
38. 未顯示完整 email / domain / recipient list：是，僅顯示 count 與 source label
39. 未顯示 API key / SMTP URL / token / secret：是
40. 未顯示 raw provider response / raw error_message：是
41. 未改既有「測試寄送」按鈕行為：是
42. 未破壞 Readiness Check / Dry-run Preview / Eligibility Card：是
43. 白屏 / runtime error：無
44. 仍未 Publish：是
45. 未動 forbidden scope：是
46. 適合進入 Publish Pre-confirmation：是
```

Preview Validation 結論：通過。

---

## 十三、Publish Pre-confirmation

Publish Pre-confirmation 已通過。

確認事項：

```text
1. Preview Validation 已通過
2. 準備 Publish 的實際檔案清單：src/routes/_authenticated/admin/sites.$id.notifications.tsx
3. 只有 UI 變更
4. routeTree.gen.ts 無變更，git diff HEAD -- src/routeTree.gen.ts 為 0 行
5. 未新增 route
6. 未新增 server function
7. 未新增 sendSafeTestNotification
8. 未呼叫 sendTestNotification
9. 未呼叫 dispatchLeadNotification
10. 未發送 email
11. 未寫 transactional_emails queue / notification_logs / email_send_log / activity_logs
12. 未產生 unsubscribe token
13. 未修改 notification_settings
14. 未改 Email Router / Edge Function / queue
15. 未改 migration / RLS / schema / secrets
16. 沿用 getSafeTestSendEligibility read-only result
17. 新增 Safe Test Send disabled card
18. Card 位於 Safe Test Send Eligibility 下方
19. disabled「安全測試寄送（尚未啟用）」按鈕永遠 disabled，無 onClick / mutation
20. confirmation dialog / preview 只做 UI 預覽，未綁定寄送行為
21. dialog 的「確認寄出（尚未啟用）」disabled
22. result area placeholder 未顯示 queue id / message id / raw provider response
23. 未顯示完整 email / domain / recipient list
24. 未顯示 API key / SMTP URL / token / secret
25. 未顯示 raw provider response / raw error_message
26. 未改既有「測試寄送」按鈕行為
27. 未破壞 Readiness Check / Dry-run Preview / Eligibility Card
28. metadata check 通過：title、description、OG、Twitter、favicon 均已設定
29. security scan：無未解決 critical finding，所有 scanner 結果為空
30. typecheck / build 通過：tsc --noEmit 0 error
31. runtime risk 低：純 UI-only disabled preview，無寄送、無寫入、無 mutation
32. 仍未 Publish，等待明確 Publish 指令
```

---

## 十四、Production Publish

Phase 2.3b 已 Publish。

Production URL：

```text
https://app.lohashare.com
```

實際發布檔案：

```text
src/routes/_authenticated/admin/sites.$id.notifications.tsx
```

Publish Completion Report 確認：

```text
只有 UI 變更
auto-generated 變更：無
未新增 route
未新增 server function
未新增 sendSafeTestNotification
未呼叫 sendTestNotification
未呼叫 dispatchLeadNotification
未發送 email
未寫 transactional_emails queue / notification_logs / email_send_log / activity_logs
未產生 unsubscribe token
未修改 notification_settings
未改 Email Router / Edge Function / queue
未改 migration / RLS / schema / secrets
沿用 getSafeTestSendEligibility read-only
新增 Safe Test Send disabled card
Card 位於 Eligibility 下方
disabled「安全測試寄送（尚未啟用）」永遠 disabled
disabled button 無 onClick / mutation
dialog 只做 UI 預覽，未綁定寄送行為
dialog 的「確認寄出（尚未啟用）」disabled
result area 未顯示 queue id / message id / raw provider response
未顯示完整 email / domain / recipient list
未顯示 API key / SMTP URL / token / secret
未顯示 raw provider response / raw error_message
未改既有「測試寄送」按鈕行為
未破壞 Readiness Check / Dry-run Preview / Eligibility Card
build / deployment error：無
runtime error：無
```

備註：平台回報部分 security scan 結果對最新 commit 為 stale，但本次僅 UI 變更，無新增 server / DB surface。

---

## 十五、Production Smoke Test

Production 自動化瀏覽器無 admin session，被導向 `/login`，符合預期，未代填帳密。使用者本人已在 production admin session 手動確認。

使用者回報：

```text
我已在 production admin session 手動確認 Phase 2.3b Production Smoke Test：
3–29 項均正常。
```

補充確認：

```text
有看到「安全測試寄送（尚未啟用）」Card
Card 位於 Safe Test Send Eligibility 下方
disabled「安全測試寄送（尚未啟用）」按鈕無法點擊
「預覽確認對話內容」Dialog 正常
「確認寄出（尚未啟用）」按鈕 disabled
Result area placeholder 正常
未顯示完整 email / domain / recipient list
未顯示 API key / SMTP URL / token / secret
未點擊既有「測試寄送」按鈕
未發送 email
未看到白屏 / runtime error
```

Production Smoke Test 結論：通過並接受登入限制註記。

---

## 十六、Forbidden Scope Confirmation

Phase 2.3b 未修改：

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

Phase 2.3b 未觸發：

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

## 十七、Known Notes

1. Phase 2.3b 只做 UI-only disabled preview，不做真實 Safe Test Send。
2. `安全測試寄送（尚未啟用）` 與 `確認寄出（尚未啟用）` 均為 disabled，無 onClick / mutation。
3. Confirmation dialog 只做 UI 預覽，不綁定送出行為。
4. Result area 只做 placeholder，不顯示 queue id / message id / raw provider response。
5. Production 自動化無 admin session，已停在 `/login`；使用者本人已於 production admin session 完成 3–29 項目視確認。
6. 平台回報部分 security scan 對最新 commit 為 stale，但本次僅 UI 變更，無新增 server / DB surface。

---

## 十八、Recommended Next Step

建議下一步：

```text
Phase 2.3c — Safe Test Send Internal-only Write Planning
```

Phase 2.3c 若要開始接近真實寄送，建議先做 Planning 或 Pre-Build Safety Design，明確規劃：

```text
approved internal recipients enforcement
rate limit write guard
audit log write policy
is_test=true
safe_test=true
disable_fallback / provider path behavior
no formal unsubscribe token
no customer recipients
no monthly usage pollution
confirmation dialog final behavior
result summary without PII / raw provider response
```

---

## 十九、Final Status

```text
Phase 2.3b：Production Stable / Archived
```

Final status：

```text
Production Stable
UI-only Disabled Safe Test Send Card Added
Confirmation Dialog Preview Added
Result Placeholder Added
No sendSafeTestNotification Added
No Email Sent
No Queue / Logs Written
No Activity Logs Written
No Unsubscribe Token Created
Smoke Test Accepted
GitHub Archived
```
