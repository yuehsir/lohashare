# LOHAShare AI Console — Phase 2.4-a Production Readiness Audit

Date: 2026-06-13  
Environment: Read-only Audit  
Status: Archived  
Owner: LOHAShare AI Platform  
Module: Email Notification / Email Provider Router  
Previous milestones:

- Phase 2.3c-b-d-e — Successful Preview real send smoke test.
- Phase 2.4-0 — Production Router Rollout Planning.

Verified prior chain:

```text
Router → Resend → Safe Test Send → email_send_log sent → inbox received
```

DB canonical testRunId for the successful Preview smoke test:

```text
c3596815-d602-498d-927e-a03376ca577b
```

---

## 1. Summary

Phase 2.4-a is a read-only production readiness audit for the LOHAShare AI Console Email Provider Router.

The audit confirms that the Resend primary path has been proven in Preview, but production customer rollout should not proceed until the identified readiness blockers are addressed.

The major blockers are:

1. `notification_logs` and `monthly_usage` depend on on-demand reconcile and are not yet automatically updated after queue processing.
2. `email_send_log.sent_at` exists but is not populated by the queue processor.
3. Customer Router path lacks complete List-Unsubscribe / footer / unsubscribe URL wiring.
4. Production operator safety controls and SOPs must be formalized before production safe-test.
5. Site-level Router gating is required before internal or customer real-lead rollout.

Recommended next action:

```text
Address B1–B3 before Phase 2.4-b Production Safe Test Only.
```

---

## 2. Guardrails

This audit performed no system-changing actions.

| Guardrail | Result |
|---|---|
| Application code changed | No ✅ |
| Build run | No ✅ |
| Publish run | No ✅ |
| Secrets modified | No ✅ |
| Router flag flipped | No ✅ |
| Enqueue executed | No ✅ |
| Email sent | No ✅ |
| Preflight / Safe Test executed | No ✅ |
| DB schema modified | No ✅ |
| Migration run | No ✅ |
| Production Router enabled | No ✅ |

---

## 3. Audit Scope

Read-only audit covered:

1. `process.ts` queue processing.
2. `router.server.ts`.
3. `dispatch.server.ts`.
4. `resend.server.ts`.
5. `notifications.server.ts` dispatcher.
6. `notifications-reconcile.functions.ts`.
7. `notification-safe-test-send.functions.ts`.
8. `lead-notification.tsx` email template.
9. DB schema/types related to:
   - `email_send_log`
   - `notification_logs`
   - `monthly_usage`
   - `email_unsubscribe_tokens`
10. Operator UI safety surfaces:
    - Safe Test Enqueue
    - Preflight
    - ConfirmDialog needs
    - Provider status cards

No writes were performed.

---

## 4. Log / Reconcile Audit

### 4.1 `email_send_log.status`

The queue processor writes `email_send_log.status` in the shared Router/Legacy queue-processing flow:

| Path | Status written |
|---|---|
| Success | `sent` |
| Failure | `failed` |
| DLQ | `dlq` |

Router and Legacy share the same try/catch handling, so status-writing behavior is mostly consistent.

### 4.2 `email_send_log.sent_at`

Audit finding:

```text
email_send_log.sent_at exists but process.ts does not populate it.
```

Successful sends write `status='sent'`, but `sent_at` remains null.

This affects:

- SLA calculations.
- Deliverability analysis.
- Time-to-send metrics.
- Support diagnostics.

This should be fixed before internal real-lead Router enablement.

### 4.3 `notification_logs.status`

Dispatcher writes `notification_logs.status='queued'`.

The queue worker does not update `notification_logs` after send completion.

Only `reconcileRecentEmailLogs` can update:

```text
queued → sent / failed
```

### 4.4 `reconcileRecentEmailLogs` trigger

Current triggers are on-demand UI entry points:

- `src/routes/_authenticated/admin/sites.$id.notifications.tsx`
- `src/components/admin/LeadDetailDrawer.tsx`

There is no cron, background job, queue-completion callback, or server-side automatic trigger.

### 4.5 `monthly_usage.email_sent_count`

`monthly_usage.email_sent_count` depends on reconcile.

It increments only when reconcile changes a real customer notification from queued to sent with:

```text
recipient_kind='customer'
is_test=false
```

Therefore:

```text
If Production customer notification goes through Router but reconcile is not automatically triggered, notification_logs may remain queued and monthly_usage.email_sent_count may lag until an operator opens the relevant UI.
```

This is a customer rollout blocker.

### 4.6 Router / Legacy path consistency

Consistent areas:

- `message_id`
- `notification_logs.provider_message_id`
- `email_send_log.message_id`
- `status`
- `error_message`
- `sent_at` currently consistently null

Known gap:

- Resend provider response id, such as `re_xxx`, is not persisted to `email_send_log` or `notification_logs`.
- This weakens support and deliverability diagnostics.

---

## 5. Unsubscribe Audit

### 5.1 List-Unsubscribe support

`resend.server.ts` supports:

- `List-Unsubscribe`
- `List-Unsubscribe-Post: One-Click`

However, these are injected only when `payload.unsubscribe_url` is a complete URL.

### 5.2 `unsubscribe_url` source

Current dispatcher behavior:

- `notifications.server.ts` creates or passes `unsubscribe_token`.
- The Router payload does not currently include a full `unsubscribe_url`.
- `process.ts` passes `unsubscribe_token` but not `unsubscribe_url`.

Result:

```text
Router → Resend currently sends without List-Unsubscribe header unless unsubscribe_url is explicitly added to payload.
```

### 5.3 `email_unsubscribe_tokens` customer path

Dispatcher does create or retrieve unsubscribe tokens for recipients, including customer recipients.

Safe-test intentionally does not create unsubscribe tokens.

### 5.4 Email footer policy

`lead-notification.tsx` currently includes a “do not reply” notice, but does not include:

- Unsubscribe link.
- Unsubscribe explanation.
- Footer policy text.

The `/u/$token` route exists, but the email template does not yet reference it.

### 5.5 Unsubscribe blocker decision

For internal LOHAShare-only notifications:

```text
List-Unsubscribe / footer / token wiring can be deferred.
```

For customer notifications:

```text
List-Unsubscribe / footer / unsubscribe_url wiring is a blocker.
```

Customer Router rollout should not proceed until the customer path includes:

1. Full unsubscribe URL generation.
2. Router payload injection.
3. Resend List-Unsubscribe header verification.
4. Email footer with unsubscribe link.

---

## 6. Fallback Audit

### 6.1 Fallback disabled behavior

With `EMAIL_FALLBACK_ENABLED=false`, Router primary failures are handled by primary-provider result and queue error logic.

Observed/expected behavior:

| Error type | Behavior |
|---|---|
| 429 | `failed`, `retry_after_until`, stop current batch |
| 403 | Immediate DLQ and stop current batch |
| Other failures | `failed`, retry after pgmq visibility timeout, DLQ after max retries |

### 6.2 Resend failure DLQ behavior

Resend failures are DLQ-capable:

- 403 goes to DLQ immediately.
- Other repeated failures DLQ after max retries.

However, `notification_logs` will not reflect terminal failed status unless reconcile runs.

### 6.3 Zoho SMTP readiness

Current state:

- `zoho-smtp.server.ts` exists.
- `SMTP_RELAY_URL` is present as a secret concept.
- `EMAIL_FALLBACK_ENABLED=false`.
- `EMAIL_FALLBACK_PROVIDER=zoho_smtp` is planned/defaulted.
- Zoho SMTP was tested separately, but the production fallback path has not been validated.

### 6.4 Fallback decision

Recommendation:

```text
Do not enable Zoho SMTP fallback during early production Router rollout.
```

Reason:

- It increases diagnostic complexity.
- It adds a second deliverability path before the primary production Router path has baseline metrics.
- It should remain in Phase 2.4-f.

---

## 7. Operator UI Safety Audit

### 7.1 Safe Test button production visibility

Safe Test Enqueue is blocked server-side when Router is not enabled. However, the UI/harness visibility should still be hardened for production.

Current concern:

```text
Production build may still show DEV-only harness labels unless hidden or gated.
```

Recommendation:

- Hide DEV-only harness in production, or
- Convert it into a production-safe admin-only safe-test action with explicit confirmation and clear warning labels.

### 7.2 ConfirmDialog

A ConfirmDialog is recommended before any production safe-test action.

Recommended confirmation text:

```text
I understand this will enqueue and send a production safe-test email.
```

### 7.3 `data-testid`

Add stable identifiers for future E2E and SOP automation:

- `data-testid="preflight-btn"`
- `data-testid="safe-test-enqueue-btn"`
- `data-testid="email-provider-status-card"`
- `data-testid="router-mode-indicator"`

### 7.4 Site-level allowlist / flag

A site-level Router gate is required before internal or customer real-lead rollout.

Current Router flag is global:

```text
EMAIL_PROVIDER_ROUTER_ENABLED
```

Recommended future design:

- `sites.email_router_enabled boolean`, or
- `notification_settings.router_mode enum`, such as:
  - `legacy`
  - `router_safe_test_only`
  - `router_internal_only`
  - `router_customer_enabled`

No schema change is authorized by this audit.

### 7.5 Role restriction

Safe-test / preflight server functions already require authenticated admin checks.

This is acceptable, but production UI should still clearly distinguish:

- Global notification settings.
- Website notification settings.
- Safe-test only actions.
- Production customer notification actions.

---

## 8. Production SOP Gaps

### 8.1 Rollback SOP gaps

Needed:

1. Router flag rollback SOP.
2. Site-level rollback SOP.
3. Fallback rollback SOP.
4. Resend incident SOP.
5. API key / domain verification incident SOP.

Router flag rollback has been proven in Phase 2.3c-b-d-e, but must be documented.

Site-level rollback cannot be completed until site-level Router gating exists.

### 8.2 Monitoring SOP gaps

Needed read-only monitoring queries for:

- DLQ count.
- Failed send ratio.
- Suppressed email growth.
- Bounce/complaint patterns.
- Reconcile lag.
- Queued notification age.
- Email provider status.

### 8.3 Support / incident SOP gaps

Needed:

- Standard response flow for “customer did not receive notification”.
- Bounce / complaint handling SOP.
- Suppression list ownership and cleanup process.
- Incident GitHub archive template.

---

## 9. Blocker Classification

### A. Must fix before any Production safe-test

1. B1 — Operator UI safety lock:
   - Hide DEV-only harness in production, or add admin-only production-safe confirmation with clear labels.
2. B2 — Production Router flag rollback SOP documentation.
3. B3 — Production safe-test execution SOP documentation.

### B. Must fix before internal LOHAShare-only real lead send

1. C1 — Populate `email_send_log.sent_at` in success path.
2. C2 — Add automatic `notification_logs` terminal status update or automatic reconcile.
3. C3 — Ensure `monthly_usage.email_sent_count` is accurate under automatic reconcile.
4. C4 — Add site-level Router enablement gate.
5. C5 — Persist provider response id for Resend where available.

### C. Must fix before first customer site rollout

1. D1 — Generate full `unsubscribe_url` in dispatcher and pass to Router payload.
2. D2 — Add unsubscribe footer to `lead-notification.tsx`.
3. D3 — Verify List-Unsubscribe header in customer Resend path.
4. D4 — Customer communication / consent process for sender change.
5. D5 — Bounce / complaint webhook handling to suppression list.
6. D6 — Customer rollback SOP using site flag and customer communication.

### D. Can defer to Phase 2.4-f / 2.4-g

1. Zoho SMTP fallback enablement.
2. Admin monitoring dashboard charts.
3. Auto-alert thresholds.
4. Multi-sender / multi-region policy.

### E. Not recommended now

1. Full all-customer Router switch in one step.
2. Simultaneous Router + Fallback production enablement.
3. Customer Router send before C1–C3.
4. Customer Router send before D1–D2.

---

## 10. Recommended Next Step

Recommended sequence:

1. Archive this Phase 2.4-a audit report.
2. Draft Operator SOP for production Router rollout.
3. Fix B1–B3.
4. Only then proceed to:

```text
Phase 2.4-b — Production Safe Test Only
```

Phase 2.4-b is not yet approved.

The immediate next working stage should be:

```text
Phase 2.4-a-1 — Operator Safety / SOP Draft Planning
```

---

## 11. Decision

Phase 2.4-a read-only audit is complete.

The audit concludes:

```text
It is not yet suitable to proceed directly to Phase 2.4-b Production Safe Test Only.
```

Before Phase 2.4-b, the following must be prepared:

1. Production-safe operator UI / button safety approach.
2. Production Router rollback SOP.
3. Production safe-test execution SOP.

Before customer rollout, additional blockers must be resolved:

1. Automatic reconcile or terminal status update.
2. `email_send_log.sent_at` writing.
3. Accurate `monthly_usage` under Router path.
4. Customer unsubscribe URL, footer, and List-Unsubscribe policy.
5. Site-level Router gating.

No production Router enablement is authorized by this audit.

No code, build, publish, secret, Router flag, enqueue, send, preflight, safe-test, DNS, Resend Dashboard, DB schema, or migration changes were performed.
