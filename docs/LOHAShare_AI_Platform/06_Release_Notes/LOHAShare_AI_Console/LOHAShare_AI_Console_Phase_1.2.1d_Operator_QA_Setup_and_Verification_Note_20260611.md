# LOHAShare AI Console Phase 1.2.1d Operator Site-scoped QA Setup & Verification Note

版本日期：2026-06-11（Asia/Taipei）  
文件狀態：QA Setup & Verification Note / GitHub Archive  
產品化名稱：LOHAShare AI Console / Nexus Lead Ops  
正式治理模組名稱：Lead Console  
對應階段：Phase 1.2.1d — Operator Site-scoped QA Setup & Verification  
本階段狀態：Verification Completed / Cleanup Pending  
Production URL：`https://app.lohashare.com`  

---

## 1. Summary

Phase 1.2.1d 已完成 operator site-scoped QA setup 與權限驗證。

本階段不是功能開發、不是 Build、不是 Publish。  
本階段補齊 Phase 1.2.1c 唯一 deferred 項目：operator site-scoped 帳號測試。

正式結論：

```text
Read-only Inspection: Completed
Operator QA setup: Completed
Server-side verification: Passed
Interactive validation: Passed
Operator update permission verification: Passed
Negative mutation test: Deferred for production safety
Cleanup plan: Completed
Cleanup execution: Pending
Status: QA Verification Completed
```

---

## 2. Scope

本階段範圍：

```text
1. 建立 operator QA 帳號
2. 建立 operator role assignment
3. 建立 operator site access assignment
4. 驗證 operator 只看得到授權站點
5. 驗證 Phase 1.2.1c 來源摘要在 operator scope 下正常
6. 驗證 CSV export 只含授權站點 leads
7. 驗證 operator update permission
8. 產出 cleanup plan
```

本階段未修改：

```text
application code
migration
RLS policies
schema
secrets
router flags
Email Router
Unsubscribe
Auth flow
CSV export
CSV headers
CSV row order
route
sidebar
production settings
```

---

## 3. Operator QA Accounts

### 3.1 operator-test@lohashare.com

初始測試帳號：

```text
email: operator-test@lohashare.com
user id: 7108b124-59e7-46a5-a3cb-083d59310723
role: operator
site access: LOHAShare 官網測試站
```

此帳號不是可確認收信的真實 inbox，因此未用於 interactive validation。

狀態：

```text
auth user exists
user_roles exists
operator_site_access exists
not used for interactive validation
cleanup recommended
```

### 3.2 tech@lohashare.com

實際 QA 帳號：

```text
email: tech@lohashare.com
user id: 051a1fd2-4f0c-42dd-80eb-27b95117ed84
email_confirmed: true
metadata: { purpose: "operator-qa", phase: "1.2.1d" }
```

建立資料：

```text
public.user_roles:
user_id = 051a1fd2-4f0c-42dd-80eb-27b95117ed84
role = operator

public.operator_site_access:
user_id = 051a1fd2-4f0c-42dd-80eb-27b95117ed84
site_id = 169aa3ac-644c-4ad9-8cb1-7c4e172b9f1b
customer_id = NULL
```

授權站點：

```text
LOHAShare 官網測試站
site_id: 169aa3ac-644c-4ad9-8cb1-7c4e172b9f1b
customer_id: bd174782-6591-4f67-a4ad-4fdc72637fb1
```

Negative test site：

```text
site_id: c1e2c054-2752-4cd7-b562-b4f69208490a
```

---

## 4. Server-side Verification

Server-side verification 已通過：

```text
auth user exists: PASS
user_roles row exists: PASS
operator_site_access row exists: PASS
has_role(uid,'operator') equivalent: true
has_site_access(uid, authorized site) equivalent: true
has_site_access(uid, other site) equivalent: false
leads_restrict_operator_update_trg enabled: PASS
```

補充：

```text
raw functions has_role / has_site_access could not be invoked from read-query role due to EXECUTE permission;
verification was completed by running equivalent SQL bodies inline against the same tables.
No function, schema, or grant was modified.
```

---

## 5. Recovery Session / Login Method

Lovable Cloud Users UI did not expose a visible password reset action.

One-time recovery link was generated for `tech@lohashare.com`.

Pre-flight confirmations：

```text
single-use: yes
expiry: default 1 hour
scope: tech@lohashare.com only
admin accounts: not affected
operator-test@lohashare.com: not touched
user_roles / operator_site_access: unchanged
```

Important caveat：

```text
The app does not yet implement a /reset-password page.
Recovery link establishes recovery session and redirects to /login.
This was sufficient for Phase 1.2.1d operator scope validation.
```

Decision：

```text
Proceed with Option B — recovery session validation
Do not add /reset-password route in Phase 1.2.1d
Do not modify Auth flow
```

---

## 6. Interactive Validation Result

Interactive validation with `tech@lohashare.com` was completed.

Confirmed：

```text
operator can enter system
authorized site data displays normally
unauthorized site data does not display
Leads page loads normally
existing summary cards work
Phase 1.2.1c Source Summary works under operator scope
Source platform summary works
Source type summary works
Top UTM Source / Campaign works
sourcePlatform = no_source empty state works
CSV export works
CSV header / row order unchanged
Lead Detail Drawer opens
no unauthorized data leakage observed
```

Result：

```text
Interactive validation: PASS
```

---

## 7. Operator Update Permission Verification

UI-level inspection：

```text
LeadDetailDrawer is the only lead-edit surface
Status edit entry: available
Non-status edit entry: not available / hidden
Leads list page has no inline edit
```

Status update：

```text
<Select onValueChange={handleStatusChange}> calls updateLeadStatus server function
Works for both admin and operator
No role gating in UI
```

Non-status fields are rendered read-only：

```text
name
email
phone
company
message
form
custom_data
source_*
utm_*
IP
UA
referer
```

Trigger verification：

```text
leads_restrict_operator_update_trg: enabled
tgenabled = 'O'
BEFORE UPDATE ON public.leads FOR EACH ROW
EXECUTE FUNCTION leads_restrict_operator_update()
```

Trigger function purpose：

```text
If caller is not admin, raise exception:
Operator can only update lead.status
when any field other than status changes.
```

RLS policies confirmed：

```text
leads_admin_all
leads_operator_select
leads_operator_update
```

Combined enforcement：

```text
operator can update status on authorized site leads
operator cannot update fields other than status
operator cannot update unauthorized site leads
```

Negative mutation test：

```text
not executed due to production safety
substituted with trigger + RLS + code-level verification
```

Result：

```text
Operator update permission verification: PASS
```

---

## 8. Cleanup Plan

Cleanup plan has been completed, but cleanup has not been executed.

### 8.1 operator-test@lohashare.com

Recommendation：

```text
remove public.user_roles row
remove public.operator_site_access row
keep auth user
do not delete auth user
```

Reason：

```text
not used for interactive validation
non-real inbox
keeping role/access is unnecessary permission exposure
auth user can be retained for audit / future reuse
```

### 8.2 tech@lohashare.com

Recommendation：

```text
keep auth user
keep operator role
keep operator_site_access
use as long-lived operator QA fixture
```

Reason：

```text
real inbox
verified recovery/session path
verified site-scoped access
useful for future operator regression tests
authorization scope limited to LOHAShare 官網測試站
```

### 8.3 Cleanup Row Impact

If approved, cleanup affects only：

```text
operator-test@lohashare.com:
DELETE FROM public.operator_site_access WHERE user_id = '7108b124-59e7-46a5-a3cb-083d59310723';
DELETE FROM public.user_roles WHERE user_id = '7108b124-59e7-46a5-a3cb-083d59310723' AND role = 'operator';

auth.users row: not touched
tech@lohashare.com: not touched
```

Expected impact：

```text
2 rows deleted
0 auth users deleted
fully reversible
no production behavior impact
```

---

## 9. Known Notes

### 9.1 operator_site_access INSERT policy

Pre-existing note：

```text
operator_site_access INSERT policy has empty WITH CHECK
This is outside Phase 1.2.1d scope
Record for future audit
```

### 9.2 Password / Reset Password Flow

Phase 1.2.1d did not implement reset password UI.

Recommended future Gate：

```text
Auth UX Improvement — Forgot Password / Reset Password Flow
```

### 9.3 Recovery Session Limitation

Because `/reset-password` is not implemented, recovery link can establish a session but cannot complete a permanent user-driven password reset in app UI.

This did not block operator scope validation, but should be handled before broader operator onboarding.

---

## 10. Current Status

```text
Phase 1.2.1d Read-only Inspection: Completed
Operator QA setup: Completed
tech@lohashare.com setup: Completed
Server-side verification: Passed
Interactive validation: Passed
Operator update permission verification: Passed
Negative mutation test: Deferred for production safety
Cleanup plan: Completed
Cleanup execution: Pending
Code / migration / RLS / CSV / Auth flow: Unchanged
Status: QA Verification Completed
```

---

## 11. Next Step

Recommended sequence：

```text
1. Execute cleanup for operator-test@lohashare.com only
2. Keep tech@lohashare.com as long-lived operator QA fixture
3. Archive cleanup note if cleanup is executed
4. Start next Gate with read-only inspection
```

Potential next Gate candidates：

```text
A. Execute 2-row cleanup for operator-test@lohashare.com
B. Auth UX Improvement — Forgot Password / Reset Password Flow
C. Phase 1.3 — Source / UTM URL Search Params & Index Evaluation
```

---

## 12. Closure Statement

Phase 1.2.1d has completed operator QA setup and verification.

Final status before cleanup：

```text
QA Verification Completed
GitHub Archived
Cleanup Pending
```
