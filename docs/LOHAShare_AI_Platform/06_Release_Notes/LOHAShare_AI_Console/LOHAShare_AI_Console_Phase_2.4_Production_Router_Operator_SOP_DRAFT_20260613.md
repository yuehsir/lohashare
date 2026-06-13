# LOHAShare AI Console — Phase 2.4 Production Router Operator SOP DRAFT

Date: 2026-06-13  
Status: Draft  
Owner: LOHAShare AI Platform  
Module: Email Notification / Email Provider Router  
Related planning:

- Phase 2.4-0 — Production Router Rollout Planning.
- Phase 2.4-a — Production Readiness Audit.
- Phase 2.4-a-1 — Operator Safety / SOP Draft Planning.

Canonical prior successful safe-test reference:

```text
c3596815-d602-498d-927e-a03376ca577b
```

---

## 1. Purpose

This SOP draft defines how operators should safely prepare, execute, monitor, and roll back the Email Provider Router during Phase 2.4 production rollout activities.

The immediate focus is Phase 2.4-b Production Safe Test Only.

This SOP does not authorize production customer rollout.

---

## 2. Scope

This draft covers:

1. Production safe-test preconditions.
2. Operator UI safety rules.
3. Production Router rollback SOP.
4. Production Safe Test execution SOP.
5. DB/log monitoring checklist.
6. Inbox verification checklist.
7. Stop / rollback criteria.
8. Incident documentation template.
9. Remaining implementation items before broader rollout.

Out of scope:

- Customer site rollout.
- Zoho SMTP fallback enablement.
- Full production GA.
- DNS or Resend Dashboard changes.

---

## 3. Roles and Permissions

| Role | Permission |
|---|---|
| System admin / Richard | May authorize and execute Phase 2.4-b safe-test. |
| Admin operator | May observe and assist after explicit authorization. |
| Observer | May review logs but may not flip Router or run tests. |
| Lovable app | May implement approved code changes only when explicitly instructed. |
| ChatGPT + GitHub | May draft and archive SOP/release notes when authorized. |

Production Safe Test must not be run without explicit user authorization.

---

## 4. Current Production Router State

Expected state before Phase 2.4-b:

| Setting | Expected value |
|---|---|
| `EMAIL_PROVIDER_ROUTER_ENABLED` | `false` |
| `EMAIL_FALLBACK_ENABLED` | `false` |
| Primary provider | Resend |
| Resend sender | `notify@send.lohashare.com` |
| Sender domain | `send.lohashare.com` |
| Actual default path | Legacy Lovable Emails |
| Customer Router rollout | Not started |

---

## 5. Production Safe Test Preconditions

Before Phase 2.4-b can start, all of the following must be true:

1. Phase 2.4-a audit report is archived.
2. Phase 2.4-a-1 planning report is archived.
3. This Operator SOP draft is archived.
4. B1 minimal UI safety lock is implemented and verified:
   - Admin-only render.
   - ConfirmDialog.
   - Required typing.
   - Environment badge.
   - Clear production warning label.
   - Stable test ids.
   - Visual separation between Preflight and Enqueue.
5. `EMAIL_FALLBACK_ENABLED=false`.
6. `RESEND_FROM_EMAIL=notify@send.lohashare.com`.
7. At least one valid `lohashare_recipients` recipient is configured.
8. User explicitly authorizes Phase 2.4-b.

---

## 6. Operator UI Safety Rules

Required production-safe UI behavior:

1. Production Safe Test button label must be explicit:

```text
Production Safe Test Enqueue（將真實寄送到 lohashare_recipients）
```

2. Clicking the button must open ConfirmDialog.
3. ConfirmDialog must require typing a site name or exact confirmation phrase.
4. ConfirmDialog must show:
   - Environment.
   - Provider path.
   - Sender email.
   - Sender domain.
   - Approved recipient source.
   - Approved recipient count.
   - Router enabled/disabled state.
   - Fallback enabled/disabled state.
5. Preflight and Enqueue must be visually separated.
6. Non-admin users must not see the Enqueue action.
7. UI must include stable test ids:
   - `prod-safe-test-enqueue-button`
   - `prod-safe-test-confirm-dialog`
   - `email-provider-status-card`
   - `router-mode-indicator`

---

## 7. Production Router Rollback SOP

### 7.1 Rollback triggers

Immediately rollback if any of the following happens:

1. Resend 403 / domain-unverified / API-key invalid.
2. More than three failed sends within ten minutes.
3. Any DLQ during safe-test window.
4. `email_unsubscribe_tokens` increases during safe-test window.
5. `monthly_usage.email_sent_count` increases during safe-test window.
6. Any customer recipient appears during safe-test window.
7. Inbox does not receive the safe-test within waiting window.
8. UI status card disagrees with expected state.
9. Operator is uncertain whether the correct action was clicked.

### 7.2 Pre-rollback record

Record:

1. Time in Asia/Taipei.
2. Trigger reason.
3. Router flag state.
4. Fallback flag state.
5. Latest testRunId if available.
6. `email_send_log` recent status distribution.
7. `notification_logs` recent status distribution.
8. `email_unsubscribe_tokens` count.
9. Current `monthly_usage` count.

### 7.3 Rollback execution

1. Set `EMAIL_PROVIDER_ROUTER_ENABLED=false`.
2. Confirm `EMAIL_FALLBACK_ENABLED=false`.
3. Wait at least ten seconds.
4. Refresh `/admin/notifications`.
5. Confirm actual mode returns to Legacy Lovable Emails.
6. Stop all enqueue/test/send actions.
7. Observe for five minutes.

### 7.4 Post-rollback final checks

Confirm:

1. No unexpected new `email_send_log` rows.
2. No unexpected new `notification_logs` rows.
3. `email_unsubscribe_tokens` unchanged.
4. `monthly_usage.email_sent_count` unchanged.
5. Router UI shows disabled.
6. Completion/incident note is archived in GitHub.

---

## 8. Production Safe Test Execution SOP

### 8.1 Fixed parameters

| Parameter | Required value |
|---|---|
| Recipient source | `notification_settings.lohashare_recipients` only |
| Recipient count | 1 for first production safe-test |
| Sender | `notify@send.lohashare.com` |
| Sender domain | `send.lohashare.com` |
| Provider path | `Router → resend（無 Fallback）` |
| Router flag during test | `true` |
| Fallback flag | `false` |
| Customer recipients | Forbidden |
| Target site | Internal LOHAShare test site only |

### 8.2 Execution stages

1. Pre-check.
2. Baseline DB snapshot.
3. Router flip true.
4. UI status verification.
5. Production Safe Test Enqueue with ConfirmDialog.
6. DB delta monitoring.
7. `email_send_log` verification.
8. Inbox verification.
9. Router rollback false.
10. Final DB safety check.
11. Completion note / GitHub archive.

---

## 9. DB / Log Monitoring Checklist

### 9.1 Baseline before Router flip

Capture:

1. `email_send_log` total.
2. `email_send_log` latest rows / status distribution.
3. `notification_logs` total.
4. `notification_logs is_test=true` count.
5. `notification_logs recipient_kind` distribution.
6. `activity_logs notification.test_send.queued` count.
7. `email_unsubscribe_tokens` count.
8. Current month `monthly_usage.email_sent_count`.
9. Current month `monthly_usage.lead_count`.
10. `notification_settings.max(updated_at)`.

### 9.2 Expected delta after safe-test

Expected:

- `email_send_log +1`, status `sent`.
- `activity_logs notification.test_send.queued +1`.

Expected no-change:

- `notification_logs` no unexpected change.
- `email_unsubscribe_tokens` unchanged.
- `monthly_usage.email_sent_count` unchanged.
- `monthly_usage.lead_count` unchanged.
- `notification_settings.updated_at` unchanged.
- No customer recipient row.

---

## 10. Inbox Verification Checklist

Verify:

1. Email received within waiting window.
2. Folder is Inbox, not spam.
3. Sender is `notify@send.lohashare.com`.
4. Subject includes safe-test wording.
5. Body includes test/safe-test warning wording.
6. No customer recipient is included.
7. Screenshot or manual note is recorded.

---

## 11. Stop / Rollback Criteria

Stop and rollback immediately if:

1. Enqueue response is not `queued`.
2. `blockers` are non-empty.
3. `queuedCount` is not 1.
4. `failedCount` is not 0.
5. `email_send_log` status is `failed` or `dlq`.
6. Inbox verification fails.
7. `email_unsubscribe_tokens` changes.
8. `monthly_usage` changes.
9. `notification_logs` shows a customer recipient.
10. Operator is unsure whether the correct button was clicked.

---

## 12. Incident Documentation Template

Use this template for any failed or rolled-back run:

```markdown
# LOHAShare AI Console — Phase 2.4 Incident Note

Date:
Environment:
Phase:
Operator:
Trigger:
Router flag before rollback:
Fallback flag before rollback:
Latest testRunId:

## What happened

## Evidence

## DB snapshot before rollback

## Rollback actions

## Final checks

## Root cause hypothesis

## Follow-up actions

## Decision
```

---

## 13. Remaining Implementation Items

Before Phase 2.4-b:

1. B1 UI safety lock implementation.
2. Production UI verification.
3. Final authorization.

Before internal real-lead Router enablement:

1. `email_send_log.sent_at` success-path write.
2. Automatic `notification_logs` terminal status update or automatic reconcile.
3. Accurate `monthly_usage` update under Router path.
4. Site-level Router gate.
5. Provider response id persistence.

Before first customer site rollout:

1. Full `unsubscribe_url` generation.
2. Footer policy in `lead-notification.tsx`.
3. List-Unsubscribe header verification.
4. Customer communication and rollback SOP.
5. Bounce / complaint handling.

---

## 14. Decision Before Phase 2.4-b

Phase 2.4-b must remain paused until:

1. B1 UI safety lock is implemented and verified.
2. This SOP draft is reviewed.
3. Router/fallback/sender state is confirmed.
4. User explicitly authorizes Production Safe Test Only.

This SOP draft does not authorize Phase 2.4-b.
