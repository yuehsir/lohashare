# LOHAShare AI Console Phase 2.1c — Email Provider 狀態 Read-only 頁 Production Publish and Smoke Test Note

Release: Phase 2.1c Email Provider Status Read-only Page  
Status: Production Stable · Minimal Production Smoke Test Passed · GitHub Archived  
Date: 2026-06-12

---

## 一、Release Summary

Phase 2.1c 將既有 `/admin/notifications` stub 頁升級為 admin-only read-only「通知設定」頁第一版，並新增「Email Provider 狀態」區塊。

本階段目的為提升 admin 對通知模組與寄信基礎設施狀態的能見度，作為後續 Phase 2.1b「通知設定總覽」與 Phase 2.2a「通知發送紀錄」的基礎。

本階段不改變任何寄信行為、不發送測試 email、不寫入 queue / logs、不修改 Email Router / Edge Function / migration / RLS / schema / secrets。

---

## 二、Scope

### 新增檔案

```text
src/lib/email-provider-status.functions.ts
```

新增 read-only server function：

```text
getEmailProviderStatus
```

用途：讀取目前 Email Provider / Email infra 的環境狀態，回傳 admin UI 可顯示的 read-only 狀態。

### 修改檔案

```text
src/routes/_authenticated/admin/notifications.tsx
src/routeTree.gen.ts
```

`src/routes/_authenticated/admin/notifications.tsx`：
- 從 stub 頁升級為「通知設定」頁。
- 新增「Email Provider 狀態」區塊。
- 顯示 read-only 狀態欄位與 badge。

`src/routeTree.gen.ts`：
- TanStack Router auto-generated 調整，約 -10 行。
- 已確認無 runtime 行為風險。

---

## 三、Implemented UI

Production `/admin/notifications` 顯示：

```text
通知設定
Email Provider 狀態
```

區塊說明文字：

```text
此頁僅供檢視，不可修改設定。實際寄送行為由部署環境變數控制。
```

顯示欄位包含：

```text
Email 寄件基礎設施
Email Provider Router
主要 Provider
備援機制
備援 Provider
Resend 設定狀態
Zoho SMTP 設定狀態
寄件網域
寄件人顯示
目前實際寄送模式
```

---

## 四、Security and Secrets Handling

`getEmailProviderStatus` 採用：

```text
requireSupabaseAuth middleware
handler-level admin role check via user_roles
```

非 admin 不應看到 provider 狀態。

Server response 僅回傳：

```text
boolean
enum
public string
```

明確未回傳：

```text
RESEND_API_KEY
SMTP_RELAY_URL
API key
SMTP credential
password
token
secret
JWT
raw env credential
```

Resend / Zoho SMTP 的設定狀態只以 boolean badge 呈現，例如「已設定 / 未設定」。

---

## 五、Preview Validation

Authenticated Preview Minimal Visual Check 已通過。

確認項目：

```text
1. /admin/notifications 可成功進入，未停留在「載入中…」
2. 可看到「通知設定」
3. 可看到「Email Provider 狀態」
4. 狀態欄位均有可讀值或 badge
5. 無 API key / SMTP URL / secret / token / password 外洩
6. 無白屏 / runtime error
7. 未發送 email
8. 未寫 queue / logs
9. 未 Publish
```

Preview 觀察值：

```text
Email 寄件基礎設施：已啟用
Email Provider Router：未啟用
主要 Provider：Resend
備援機制：未啟用
備援 Provider：Zoho SMTP
Resend 設定狀態：已設定
Zoho SMTP 設定狀態：未設定
寄件網域：PENDING
寄件人顯示：PENDING
目前實際寄送模式：Legacy Lovable Emails
```

---

## 六、Publish Pre-confirmation

Publish 前確認已通過。

確認事項：

```text
1. Authenticated Preview Minimal Visual Check 已通過
2. 實際檔案清單符合預期
3. src/routeTree.gen.ts 為 auto-generated 變更，無 runtime 行為風險
4. getEmailProviderStatus 為 admin-only
5. response 只包含 boolean / enum / public string
6. 無 API key / SMTP URL / secret 外洩
7. PENDING 為非機密 placeholder，不阻擋 Publish
8. 未發送 email
9. 未寫 queue / logs
10. 未改 Email Router / Edge Function
11. 未改 migration / RLS / schema / secrets
12. 未改 Auth / Unsubscribe / public submit endpoint
13. 未新增 route / package / provider
14. runtime risk 低
```

### Baseline Notes

`tsc --noEmit` 仍有既有 baseline 型別錯誤，涉及 AppSidebar、_authenticated、login、reset-password 的 navigate search params 型別問題。Phase 2.1c 新增與修改檔案為零錯誤，Vite build 不受影響。

Security scanner 結果對最新 commit 曾標示 stale；最近一次 baseline 無 critical 阻擋項。本階段變更為 read-only UI + read-only server function，未引入 secrets exposure 或寄信行為變更。

---

## 七、Production Publish

Phase 2.1c 已 Publish。

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
新增：src/lib/email-provider-status.functions.ts
修改：src/routes/_authenticated/admin/notifications.tsx
修改：src/routeTree.gen.ts
```

Publish 完成後確認：

```text
1. build / deployment error：無
2. Preview 已通過驗證
3. 未發送 email
4. 未寫 queue / logs
5. 未改 forbidden scope
```

---

## 八、Production Smoke Test

Production Smoke Test 已通過。

### 未登入狀態

確認：

```text
https://app.lohashare.com 可達，回應 200
未登入進入 /admin/notifications 時正確導向 /auth
_authenticated route gate 正常運作
未登入路徑無白屏、無 runtime error
```

### Admin 登入後人工確認

使用者以 production admin 帳號登入後確認：

```text
1. 看到「通知設定」：是
2. 看到「Email Provider 狀態」：是
3. 狀態欄位與 badge 都有顯示：是
4. 有顯示 PENDING，但沒有 secret 外洩：是
```

Production Smoke Test 結論：

```text
Production /admin/notifications 可正常顯示 Phase 2.1c read-only 狀態頁。
未發現 secrets 外洩。
未發送 email。
未寫 queue / logs。
未動 forbidden scope。
```

---

## 九、PENDING Placeholder Note

Production 中 `寄件網域` 與 `寄件人顯示` 顯示為：

```text
PENDING
```

此為非機密 placeholder string，不包含 API key / SMTP URL / token / password / JWT / credential。

此狀態不阻擋 Phase 2.1c，因本階段目的即為 read-only 顯示目前環境配置狀態。

後續可於獨立 Phase 配置正式：

```text
EMAIL_SENDER_DOMAIN
EMAIL_FROM_HEADER
```

---

## 十、Forbidden Scope Confirmation

本階段未修改：

```text
migration
RLS
schema
secrets
Email Router behavior
Edge Function
queue process
notification_logs write logic
email_send_log write logic
Auth flow
Unsubscribe behavior
public submit endpoint
CSV header / row order
provider adapters
failed retry / resend feature
new package
new provider
new route
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

## 十一、Final Status

```text
Phase 2.1c：Production Stable / Archived
```

Final status：

```text
Production Stable
Minimal Production Smoke Test Passed
GitHub Archived
```
