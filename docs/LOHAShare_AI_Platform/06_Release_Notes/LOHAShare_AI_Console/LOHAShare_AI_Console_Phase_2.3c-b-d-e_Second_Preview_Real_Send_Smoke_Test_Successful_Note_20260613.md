# LOHAShare AI Console — Phase 2.3c-b-d-e Second Preview Real Send Smoke Test Successful Note

Date: 2026-06-13  
Environment: Preview  
Result: ✅ Successful  
Status: Archived  
Owner: LOHAShare AI Platform  
Module: Email Notification / Email Provider Router / Safe Test Send

---

## 1. Summary

Phase 2.3c-b-d-e completed the Preview real-send smoke test for the LOHAShare AI Console Email Provider Router.

The verified chain was:

```text
Router → Resend → Safe Test Send → email_send_log sent → inbox received
```

After verification, `EMAIL_PROVIDER_ROUTER_ENABLED` was rolled back to `false`, and the system returned to Legacy Lovable Emails mode. No customer recipients were involved, and no production behavior was changed.

---

## 2. Scope

This phase covered:

- Preview-only Router flag flip: `EMAIL_PROVIDER_ROUTER_ENABLED=true` then rollback to `false`.
- Single Safe Test Enqueue execution through the Router-only Resend path.
- DB delta and `email_send_log` monitoring.
- Inbox verification by the user.
- UI cleanup completed during the same working window:
  - Browser timezone auto-detect with `Asia/Taipei` fallback.
  - Dynamic Resend sender display using `send.lohashare.com`.
  - Global navigation label changed to `通知中心`.
  - Website-level notification pages/cards changed to `網站通知設定`.
- Final rollback and final DB safety check.

Out of scope:

- Production publish.
- Queue worker modification.
- DB schema migration.
- General customer notification rollout.
- Zoho SMTP fallback rollout.
- Production Router enablement.

---

## 3. Final Result

✅ Successful.

The Preview real-send path through Resend worked end to end:

```text
Router → Resend → Safe Test Send → email_send_log sent → inbox received
```

The previous `notify.lohashare.com` Resend 403 issue did not recur. The sender path correctly used the Resend-verified sender domain:

```text
notify@send.lohashare.com
```

---

## 4. Key Evidence

| Indicator | Value |
|---|---|
| Step 4b-2 response.status | `queued` |
| queuedCount | `1` |
| failedCount | `0` |
| blockers | `[]` |
| DB canonical testRunId | `c3596815-d602-498d-927e-a03376ca577b` |
| providerPathLabel | `Router → resend（無 Fallback）` |
| approvedSource | `lohashare_recipients` |
| approvedRecipients count | `1` |
| customer recipients involved | No |
| latest email_send_log.status | `sent` |
| latest email_send_log.error_message | `null / empty` |
| message_id / provider_message_id | `dc1356fb-243e-47b3-a281-f85479daf758` |
| from | `notify@send.lohashare.com` |
| inbox received | Yes |

---

## 5. DB Delta

Baseline before successful enqueue:

| Table / Indicator | Before | After | Delta |
|---|---:|---:|---:|
| `email_send_log` total | 41 | 42 | +1 ✅ |
| `email_send_log` safe-test count | 1 | 2 | +1 ✅ |
| `notification_logs` total | 38 | 39 | +1 ✅ |
| `notification_logs` `is_test=true` | 5 | 6 | +1 ✅ |
| `notification_logs` `recipient_kind='lohashare'` | 13 | 14 | +1 ✅ |
| `activity_logs` `notification.test_send.queued` | 1 | 2 | +1 ✅ |

New safe-test linkage:

| Field | Value |
|---|---|
| New `notification_logs` row id | `e9301ee9-0d0f-46d8-a226-a5d8061f9b9d` |
| New `notification_logs` status | `queued` |
| `lead_id` | `null` |
| `form_id` | `null` |
| `recipient_kind` | `lohashare` |
| `notification_logs.provider_message_id` | `dc1356fb-243e-47b3-a281-f85479daf758` |
| Latest `email_send_log` row id | `71641860-2018-4743-b4ec-2cf6f9d73efe` |
| Latest `email_send_log.message_id` | `dc1356fb-243e-47b3-a281-f85479daf758` |
| Message id match | Yes |
| Latest safe-test status | `sent` |
| Latest safe-test error | `null / empty` |

---

## 6. Inbox Verification

The user manually verified delivery in Gmail.

| Indicator | Value |
|---|---|
| Received | Yes |
| Folder | Inbox |
| Sender display | `LOHAShare通知` |
| Sender email | `notify@send.lohashare.com` |
| Subject | `[測試] [新名單] LOHAShare 官網測試站 - 安全測試` |
| Received time | 下午 05:22 |
| Test / safe-test wording visible | Yes |
| Conclusion | Successful |

---

## 7. Safety Invariants

All safety invariants held.

| Indicator | Before | After | Delta |
|---|---:|---:|---:|
| `email_unsubscribe_tokens` | 4 | 4 | 0 ✅ |
| `monthly_usage` 2026-06 `email_sent_count` | 14 | 14 | 0 ✅ |
| `monthly_usage` 2026-06 `lead_count` | 9 | 9 | 0 ✅ |
| `notification_settings.max(updated_at)` | `2026-05-28 15:24:03.515452+00` | same | 0 ✅ |
| customer recipient rows | 0 | 0 | 0 ✅ |
| non-safe-test customer send | 0 | 0 | 0 ✅ |

Additional safety checks:

- ✅ `notify.lohashare.com` Resend 403 did not recur.
- ✅ `send.lohashare.com` domain error did not occur.
- ✅ API key / auth error did not occur.
- ✅ No fallback path was used.
- ✅ Customer recipients did not participate.

---

## 8. Rollback Result

After inbox verification, the Router flag was rolled back.

| Rollback item | Result |
|---|---|
| `EMAIL_PROVIDER_ROUTER_ENABLED` | `false` ✅ |
| Email Provider Router UI | `未啟用` ✅ |
| Current actual sending mode | `Legacy Lovable Emails` ✅ |
| Fallback mechanism | `未啟用` ✅ |
| Primary Provider display | `Resend` ✅ |

Final post-rollback DB check:

| Indicator | Step 5 after send | Step 7 after rollback | Delta |
|---|---:|---:|---:|
| `email_send_log` total | 42 | 42 | 0 ✅ |
| `notification_logs` total | 39 | 39 | 0 ✅ |
| `notification_logs` `is_test=true` | 6 | 6 | 0 ✅ |
| `activity_logs` `notification.test_send.queued` | 2 | 2 | 0 ✅ |
| `email_unsubscribe_tokens` | 4 | 4 | 0 ✅ |
| `monthly_usage` 2026-06 `email_sent_count` | 14 | 14 | 0 ✅ |
| `monthly_usage` 2026-06 `lead_count` | 9 | 9 | 0 ✅ |
| `notification_settings.max(updated_at)` | `2026-05-28 15:24:03.515452+00` | same | 0 ✅ |

Rollback did not cause any additional send-side activity.

---

## 9. Known Non-blocking Events

The following events occurred during the phase and were confirmed to be non-blocking:

1. The first Step 4 Safe Test Enqueue attempt was blocked by `rate_limited`.
   - No enqueue.
   - No email send.
   - No `notification_logs` row.
   - No `email_send_log` row.
   - Only a blocked audit row was created.

2. A later retry attempt accidentally clicked the Preflight button instead of Safe Test Enqueue.
   - Only a `notification.test_send.preflight_ok` audit row was created.
   - Safe Test Enqueue was never invoked.
   - No queue write.
   - No send attempt.
   - This did not consume the Safe Test Enqueue quota.

3. UI cleanup was completed before the successful retry:
   - Browser timezone auto-detect implemented using `Intl.DateTimeFormat().resolvedOptions().timeZone`.
   - Fallback timezone: `Asia/Taipei`.
   - Resend sender display corrected to `send.lohashare.com`.
   - Global navigation label changed from `通知設定` to `通知中心`.
   - Website-level label changed to `網站通知設定`.
   - Website detail child card changed to `網站通知設定`.

4. Step 4b-2 then succeeded with a single Safe Test Enqueue click.

---

## 10. Remaining Follow-up Items

Recommended follow-up items for later phases:

1. Phase 2.4 — Production Router rollout planning.
2. `SAFE_TEST_AUDIT_SALT` setup.
3. Fallback provider / Zoho SMTP rollout planning.
4. Auto-reconcile / `notification_logs` terminal status improvement.
5. Safe Test button UI hardening:
   - Add `data-testid="preflight-btn"`.
   - Add `data-testid="safe-test-enqueue-btn"`.
   - Improve button labels.
   - Add `ConfirmDialog` for Safe Test Enqueue.
   - Add stronger visual separation between Preflight and Safe Test Enqueue.
6. Production monitoring and rollback policy for Email Provider Router.
7. Decide whether safe-test `sent_at` should be populated in `email_send_log` for successful sends.

Known note about testRunId:

```text
Step 4b-2 使用者回報中的 testRunId 曾有一字轉錄差異，正式紀錄以 DB activity_logs canonical testRunId = c3596815-d602-498d-927e-a03376ca577b 為準。
```

---

## 11. Decision

✅ Phase 2.3c-b-d-e is marked as Successful.

The Preview real send smoke test verified the complete chain:

```text
Router → Resend → Safe Test Send → email_send_log sent → inbox received
```

Router was safely rolled back to `false` after verification.

No customer recipients were involved.

No `monthly_usage`, `email_unsubscribe_tokens`, `notification_settings`, or customer-send side effects were introduced.

This phase is a valid foundation for the next planning phase:

```text
Phase 2.4 — Production Router rollout planning
```

Phase 2.4 is not started by this note and requires explicit user authorization.
