# LOHAShare AI Console Auth UX Improvement Phase A Production Publish & Smoke Test Note

版本日期：2026-06-11（Asia/Taipei）  
文件狀態：Production Publish & Smoke Test Note / GitHub Archive  
產品化名稱：LOHAShare AI Console / Nexus Lead Ops  
正式治理模組名稱：Lead Console  
對應階段：Auth UX Improvement Phase A — Forgot / Reset Password MVP  
Production URL：`https://app.lohashare.com`  
Default Published URL：`https://nexus-lead-ops.lovable.app`  
本階段狀態：Production Smoke Test Passed / Archived  

---

## 1. 文件目的

本文件記錄 Auth UX Improvement Phase A — Forgot / Reset Password MVP 的 production publish、production smoke test、redirect mismatch investigation 與最終 fresh production recovery test 結果。

本階段目標是補上管理後台缺少的 Forgot Password / Reset Password Flow，讓 admin / operator / client 既有帳號可透過 recovery email 重設密碼。

本階段不包含 public signup / register / self-service account creation。

---

## 2. 前置背景

Phase 1.2.1d Operator QA 測試期間確認：

```text
目前 app 尚未具備完整 /reset-password flow。
Recovery link 可建立 session，但 redirect 後沒有 reset password page 讓使用者設定新密碼。
```

因此啟動本小型 Gate：

```text
Auth UX Improvement Phase A — Forgot / Reset Password MVP
```

---

## 3. Scope

本階段允許範圍：

```text
src/routes/login.tsx
src/routes/reset-password.tsx
src/routeTree.gen.ts
```

本階段功能：

```text
1. /login 新增「忘記密碼？」入口
2. /login 內聯 forgot password mode
3. 呼叫 Supabase resetPasswordForEmail
4. 新增 public /reset-password route
5. Recovery session 下可輸入新密碼與確認密碼
6. 密碼規則 client-side validation
7. updateUser({ password })
8. 成功後清除 URL hash / token fragment
9. 成功後 signOut
10. 成功後導回 /login
11. /login 顯示成功訊息
12. /login 與 /reset-password 的 password 欄位支援顯示 / 隱藏
```

本階段明確不包含：

```text
migration
RLS policies
schema
secrets
router flags
Email Router
Unsubscribe
UNSUBSCRIBE_BASE_URL
Zoho SMTP
notification dispatch pipeline
Edge Functions
CSV export
CSV headers
CSV row order
social_lead_candidates
monthly_usage
usage_logs
production settings
user account changes
role assignment changes
site access assignment changes
operator QA fixture changes
/register
public signup
signUp form
self-service account creation
role auto-assignment
client self-registration
operator self-registration
```

---

## 4. Build Summary

修改檔案：

```text
src/routes/login.tsx
src/routes/reset-password.tsx
src/routeTree.gen.ts
```

其中 `src/routeTree.gen.ts` 為 TanStack Router Vite plugin 因新增 `/reset-password` route 自動產生。

---

## 5. Login Page Features

`/login` 已新增：

```text
forgot password mode
reset success alert
password show / hide toggle
```

Forgot password mode 使用中性訊息：

```text
若該 email 已註冊，您將收到密碼重設郵件。請至信箱查收。
```

此訊息避免帳號列舉，不顯示帳號是否存在。

---

## 6. Reset Password Page Features

新增 public route：

```text
/reset-password
```

此 route 不在 `_authenticated` 下，因此無 recovery session 時不會被 auth guard 擋掉。

密碼規則：

```text
至少 8 個字元
至少 1 個英文大寫
至少 1 個英文小寫
至少 1 個數字
兩次輸入一致
不強制符號
不加入 password strength meter
不加入 HIBP password check
```

提示文字：

```text
密碼至少 8 個字元，並需包含英文大寫、英文小寫與數字。
```

---

## 7. Security Handling

已確認安全行為：

```text
不支援 next= redirect
不自動登入 dashboard
reset 成功後 signOut
reset 成功後導回 /login
reset 成功後顯示成功訊息
清除 URL hash / token fragment
不揭露帳號是否存在
不新增 role-specific reset logic
不新增 public signup
```

Reset success flow：

```text
window.history.replaceState(null, "", window.location.pathname)
supabase.auth.signOut()
navigate({ to: "/login", search: { reset: "success" }, replace: true })
```

Login page 偵測 `?reset=success` 後顯示：

```text
密碼已更新，請使用新密碼重新登入。
```

顯示後清除 query param，避免 URL 汙染。

---

## 8. Preview Validation

Preview URL：

```text
https://id-preview--8a6788ab-4762-4e8a-9953-5f351ec760a0.lovable.app
```

Preview validation 結果：

```text
/login UI: Passed
forgot password mode: Passed
neutral message for nonexistent email: Passed
direct /reset-password invalid state: Passed
recovery email received: Passed
recovery link landing to preview /reset-password: Passed
password rules validation: Passed
valid password update: Passed
success feedback: Passed
signOut + back to /login: Passed
new password login: Passed
operator site scope: Passed
auth guard regression: Passed
no public signup: Passed
forbidden scope unchanged: Passed
```

---

## 9. Production Redirect URL Configuration

Auth Redirect URLs allow-list 已確認：

```text
https://app.lohashare.com/**
https://app.lohashare.com/reset-password
https://nexus-lead-ops.lovable.app/**
```

說明：

```text
https://nexus-lead-ops.lovable.app/** 已涵蓋 /reset-password。
嘗試手動新增 https://nexus-lead-ops.lovable.app/reset-password 時，系統顯示 system-managed URLs cannot be added manually。
```

Production redirect behavior：

```text
/login 使用 redirectTo: `${window.location.origin}/reset-password`
```

因此：

```text
from https://app.lohashare.com/login -> https://app.lohashare.com/reset-password
from https://nexus-lead-ops.lovable.app/login -> https://nexus-lead-ops.lovable.app/reset-password
```

---

## 10. Production Publish

Publish status：

```text
Published / Completed
```

Production URLs：

```text
https://app.lohashare.com
https://nexus-lead-ops.lovable.app
```

Published files：

```text
src/routes/login.tsx
src/routes/reset-password.tsx
src/routeTree.gen.ts
```

Build / deployment error：

```text
None
```

---

## 11. Production Smoke Test — Automated

Automated production smoke test passed：

```text
Production /login loads
Login password show / hide works
Show / hide button does not submit form
Forgot password mode works
Neutral message works for nonexistent email
Direct /reset-password invalid state works
Unauthenticated /admin redirects to /login
No public signup / register
No forbidden scope changes
No runtime error observed
```

---

## 12. Production Smoke Test — Manual

Manual production smoke test was performed using QA email：

```text
yuehsir.prc@gmail.com
```

Initial issue：

```text
A previous test clicked an old preview recovery email.
The link landed on preview /reset-password with otp_expired.
Investigation confirmed this was not a code issue and not a production redirect issue.
```

Investigation result：

```text
Latest auth logs showed the old link came from preview origin.
Production /recover had not been triggered in that attempt.
otp_expired most likely resulted from a single-use token already consumed by preview reset.
```

Fresh production recovery test was then performed from：

```text
https://app.lohashare.com/login
```

Final manual test result：

```text
Production fresh recovery test: Passed
Items 3-10 passed
Recovery email received
Latest recovery link host is app.lohashare.com
Recovery link lands on https://app.lohashare.com/reset-password
Valid password update succeeds
Success flow signs out and returns to /login
Success message appears
New password login succeeds
Operator site scope remains correct
No production error observed
```

Additional manual results confirmed：

```text
Password rule validation passed
Reset success feedback displayed
Lead Console accessible
Leads page normal
Source Summary normal
CSV export normal
Lead Detail Drawer normal
No production error
```

---

## 13. No Public Signup Decision

During testing, the absence of public signup was noted.

Decision：

```text
Do not add public signup in this phase.
```

Reason：

```text
This is an admin / operator / client management console.
Accounts should remain admin-created and role-assigned.
Public signup would require a separate Gate due to role approval, site ownership, RLS, abuse prevention, and onboarding risks.
```

No `/register` or public signup flow was added.

---

## 14. Remaining Known Notes

### 14.1 Auth Email Delivery Delay

`tech@lohashare.com` did receive the recovery email, but delivery was slower than expected.

Current interpretation：

```text
Auth email delivery pipeline works.
Email delivery may have delay depending on managed auth email sender and receiving inbox.
```

### 14.2 Managed Auth Email Pipeline

Auth recovery email does not use the project lead-notification queue / email_send_log.

Observed：

```text
Lovable managed auth email hook handles auth recovery email.
Project email_send_log is not expected to show auth recovery messages.
```

### 14.3 Future Security Gate

Future enhancements may include：

```text
password strength meter
HIBP password check
custom Supabase auth email templates
audit operator_site_access INSERT policy
public signup / invite flow design
```

These are outside Phase A.

---

## 15. Final Status

Auth UX Improvement Phase A final status：

```text
Read-only Inspection: Completed
Build: Completed
Password Rule Adjustment: Completed
Success Feedback Fix: Completed
Password Visibility Toggle: Completed
Preview Validation: Passed
Final Preview Regression: Passed
Production Publish: Completed
Production Smoke Test: Passed
GitHub Archive: Completed
Status: Production Stable
Closure: Closed as Completed
```

---

## 16. GitHub Archive Path

Path：

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/LOHAShare_AI_Console_Auth_UX_Phase_A_Production_Publish_and_Smoke_Test_Note_20260611.md
```

Commit message：

```text
docs: add Auth UX Phase A production publish and smoke test note
```

---

## 17. Closure Statement

Auth UX Improvement Phase A — Forgot / Reset Password MVP has been published to production and smoke tested.

Final status：

```text
Production Stable
Production Smoke Test Passed
No public signup
No forbidden scope changes
GitHub Archived
Closed as Completed
```
