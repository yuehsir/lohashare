# LOHAShare AI Console Phase 2.3c-a — Safe Test Send Preflight-only Production Publish and Smoke Test Note

Release: Phase 2.3c-a Safe Test Send Preflight-only  
Status: Production Stable / Smoke Test Accepted / GitHub Archived  
Date: 2026-06-13

---

## 1. Release Summary

Phase 2.3c-a 新增 Safe Test Send 的 preflight-only server function：

```text
sendSafeTestNotificationPreflight
```

本階段只允許：

```text
admin-only server-side preflight
audit-only activity_logs write
safe summary response
```

本階段不做：

```text
email sending
queue enqueue
notification_logs write
email_send_log write
formal unsubscribe record creation
notification_settings mutation
production UI enablement
```

---

## 2. Implemented Scope

新增：

```text
src/lib/notification-safe-test-send-preflight.functions.ts
```

修改：

```text
src/routes/_authenticated/admin/sites.$id.notifications.tsx
```

通知設定頁只加入 development-only runtime validation harness：

```text
import preflight function
import.meta.env.DEV gate
SafeTestSendPreflightDevHarness component
```

Production build 不 render 該 harness。

---

## 3. Server Function Guardrails

`sendSafeTestNotificationPreflight` 已確認具備：

```text
requireSupabaseAuth
handler-level user_roles admin re-check
zod input validation
server-side approved recipient resolution
no client-provided recipients
customer recipients exclusion
lohashare.com allowlist enforcement
suppressed recipient count-only handling
rate-limit check using activity_logs
Email Router enabled check
Fallback disabled check
safe summary response only
```

Router 未啟用時會安全阻擋：

```text
blocker = router_required_for_safe_test
```

Fallback enabled 時會安全阻擋：

```text
blocker = fallback_enabled_safe_test_disabled
```

---

## 4. Activity Log Audit

唯一允許 write：

```text
activity_logs
```

允許 action：

```text
notification.test_send.blocked
notification.test_send.preflight_ok
```

本階段曾發現 `entity_type` 使用複數值造成 DB check constraint 擋下 audit insert。已執行最小修補：

```text
notification_settings -> notification_setting
```

修補後 runtime validation 已確認 audit row 成功寫入。

Audit payload 只包含 counts、source enum、provider path label、status、blockers、warnings 與 phase metadata；不包含完整收件資訊、credential、provider raw response 或 raw error。

---

## 5. Runtime Validation Result

Preview admin session 使用 development-only harness 實際觸發一次 preflight。

Result：

```json
{
  "status": "blocked",
  "wouldQueueCount": 0,
  "skippedCount": 0,
  "failedCount": 0,
  "approvedRecipientCount": 1,
  "approvedSuppressedCount": 0,
  "approvedSource": "lohashare_recipients",
  "providerPathLabel": "Legacy Lovable Emails（Router 未啟用）",
  "blockers": ["router_required_for_safe_test"],
  "warnings": [
    "email_router_disabled_legacy_path",
    "safe_test_send_not_yet_enabled",
    "missing_safe_test_audit_salt"
  ]
}
```

Interpretation：此結果符合安全設計。Router 未啟用時，Safe Test Send 不可進入 legacy path，因此必須 block。

---

## 6. DB Side-effect Verification

修補後驗證已確認：

```text
activity_logs 成功新增 1 筆 notification.test_send.blocked audit
entity_type = notification_setting
outcome = blocked
blockers 包含 router_required_for_safe_test
warnings 包含 email_router_disabled_legacy_path / safe_test_send_not_yet_enabled / missing_safe_test_audit_salt
```

同時確認未發生：

```text
email sending
queue enqueue
notification_logs write
email_send_log write
formal unsubscribe record creation
notification_settings mutation
```

相關 baseline 未變動：

```text
notification_logs latest remains 2026-06-10 12:33:49
email_send_log latest remains 2026-06-10 12:33:55
email_unsubscribe_tokens latest remains 2026-05-29
notification_settings latest updated_at remains 2026-05-28
```

---

## 7. Fresh Security Scan

Fresh security scan completed at：

```text
2026-06-12T22:51:45Z
```

Scanners：

```text
connector_security_scan
supabase
supabase_lov
tanstack
```

Results：

```text
critical = 0
high = 0
medium = 0
warn = 25
```

25 warn findings are existing accepted baseline and unrelated to this release：

```text
SUPA_function_search_path_mutable
SUPA_anon_security_definer_function_executable
SUPA_authenticated_security_definer_function_executable
```

No new finding blocks publish.

---

## 8. Production Publish

Published URLs：

```text
https://app.lohashare.com
https://nexus-lead-ops.lovable.app
```

Publish confirmed：

```text
preflight-only function added
dev-only harness added but production hidden
no sendSafeTestNotification added
no queue enqueue
no email sending
no notification_logs write
no email_send_log write
no formal unsubscribe record creation
no notification_settings mutation
no Email Router / queue worker / provider adapter changes
no migration / RLS / schema changes
existing Test Send button unchanged
formal Safe Test Send button remains disabled
```

---

## 9. Production Smoke Test

User manually confirmed production admin UI：

```text
Production URL reachable
notification settings page normal
Safe Test Send disabled card visible
formal Safe Test Send button remains disabled
preview dialog works
result placeholder remains visible
existing Test Send button unchanged
no white screen / runtime error
```

Supplement verification clarified that the `確認寄出（尚未啟用）` button is inside the preview dialog and only appears after clicking `預覽確認對話內容`. It is disabled and has no send handler.

Production confirmed not showing development-only harness：

```text
Phase 2.3c-a Preflight Runtime Validation Only not visible
執行 Preflight（audit-only） button not visible
import.meta.env.DEV gate not rendered in production
```

Production no-side-effect verification passed：

```text
transactional_emails queue = 0
DLQ old data unchanged
notification_logs count / latest unchanged
email_send_log count / latest unchanged
email_unsubscribe_tokens count / latest unchanged
notification_settings count / latest updated_at unchanged
```

---

## 10. Forbidden Scope Confirmation

Phase 2.3c-a did not modify or trigger：

```text
sendTestNotification
dispatchLeadNotification
existing notification sending behavior
Email Router
Edge Function
queue process
provider adapters
migration
RLS
schema
public submit endpoint
unsubscribe
Auth
CSV
new route
new package
```

---

## 11. Known Notes

1. Runtime result is blocked because Email Router is not enabled. This is expected and safe.
2. Audit salt is not configured; Option A was used, so recipient hashes were omitted and warning `missing_safe_test_audit_salt` was returned.
3. Development-only harness exists only for Preview/runtime validation and is not rendered in production.
4. Phase 2.3c-a does not enable real Safe Test Send.
5. Existing scan warn findings are accepted baseline and unrelated.

---

## 12. Recommended Next Step

Recommended next phase：

```text
Phase 2.3c-b — Safe Test Send Router-only Enqueue Planning
```

Before any real enqueue, resolve：

```text
Email Router path requirement
legacy path block
fallback-disabled guarantee
SAFE_TEST_AUDIT_SALT decision
queue payload for is_test / safe_test / test_run_id
worker behavior for safe_test flags
whether to remove or keep development-only harness
```

---

## 13. Final Status

```text
Phase 2.3c-a: Production Stable / Archived
```

Final result：

```text
Preflight-only server function added
Audit-only activity_logs write validated
Entity type fix completed
Runtime invocation completed
Router-disabled safe block validated
No email sent
No queue written
No notification_logs written
No email_send_log written
No unsubscribe record created
Production Smoke Test accepted
GitHub Archived
```
