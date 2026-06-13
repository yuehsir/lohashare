# LOHAShare AI Console — Phase 2.4-a-1 Operator Safety / SOP Draft Planning

Date: 2026-06-13  
Environment: Read-only Planning  
Status: Archived  
Owner: LOHAShare AI Platform  
Module: Email Notification / Email Provider Router  
Previous milestones:

- Phase 2.4-0 — Production Router Rollout Planning, commit `2f520ea8fc8f7982626e8c8dcb37298e076982fc`.
- Phase 2.4-a — Production Readiness Audit, commit `aaa82beb820d7e366a72045d8b7edd83f245f1f1`.

Canonical prior successful safe-test testRunId:

```text
c3596815-d602-498d-927e-a03376ca577b
```

Note: if later planning drafts repeat the earlier one-character testRunId discrepancy, use this DB canonical value.

---

## 1. Summary

Phase 2.4-a-1 defines the operator-safety and SOP planning needed before Phase 2.4-b Production Safe Test Only.

Phase 2.4-a concluded that the project is not yet suitable to proceed directly to Phase 2.4-b. The immediate required items are:

- B1 — Operator UI safety lock.
- B2 — Production Router rollback SOP.
- B3 — Production Safe Test execution SOP.

This planning round performed no code, build, publish, secret, Router flag, enqueue, send, Preflight, Safe Test, DNS, DB schema, or migration changes.

---

## 2. Guardrails

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
| DNS modified | No ✅ |

---

## 3. B1 — Operator UI Safety Lock Planning

### Current read-only finding

Server-side `sendSafeTestNotification` already has hard blockers:

- Router disabled → blocker `router_required_for_safe_test`.
- Fallback enabled → blocker `fallback_enabled_safe_test_disabled`.
- Admin role re-check exists.

Client-side concern:

- Safe Test harness is visible in published preview/production context.
- Button label is currently DEV-oriented.
- Safe Test Enqueue is a single-click action without ConfirmDialog.
- Existing `ConfirmDialog` / `useConfirm` supports `requireTyping` and can be reused.

### Options evaluated

#### Option A — Hide DEV-only harness completely in production

Pros:

- Lowest accidental-send risk.
- Cleanest UI.
- Very low implementation cost.

Cons:

- Does not support Phase 2.4-b Production Safe Test Only.
- Forces testing back to Preview/Staging.

Decision: not suitable for Phase 2.4-b.

#### Option B — Keep production safe-test with admin + ConfirmDialog + warning

Pros:

- Supports Phase 2.4-b.
- Reuses existing ConfirmDialog / requireTyping patterns.
- Backend already has admin and Router/fallback blockers.
- Low code surface.

Cons:

- Same UI surface still carries DEV and production semantics.
- Requires very explicit wording and visual separation.

Decision: recommended for Phase 2.4-b.

#### Option C — New production-safe test page / modal

Pros:

- Cleanest separation between DEV and PROD operation.
- Can provide stronger context and metadata.

Cons:

- More implementation work.
- New route/modal surface area.
- Over-designed for first Production Safe Test.

Decision: suitable later, but not recommended as the minimal next step.

### B1 recommendation

Use Option B.

Required implementation spec before Phase 2.4-b:

1. Production button label:

```text
Production Safe Test Enqueue（將真實寄送到 lohashare_recipients）
```

2. Click opens ConfirmDialog.
3. ConfirmDialog requires typing the site name or exact confirmation string.
4. Dialog must display:
   - Environment.
   - Provider path.
   - Sender domain.
   - Approved recipient source.
   - Approved recipient count.
   - Router flag.
   - Fallback flag.
5. Add stable test ids:
   - `data-testid="prod-safe-test-enqueue-button"`
   - `data-testid="prod-safe-test-confirm-dialog"`
6. Visually separate Preflight and Enqueue.
7. Only admins can render Enqueue action.
8. Show Router/fallback/sender/provider status cards near the action.

No DB schema change is required for B1.

---

## 4. B2 — Production Router Rollback SOP Draft

### Rollback triggers

Rollback immediately if any trigger occurs:

1. Resend 403 / domain-unverified / API-key invalid.
2. `email_send_log.status='failed'` more than three times within ten minutes.
3. Any `email_send_log.status='dlq'` appears during the test window.
4. `email_unsubscribe_tokens` increases during safe-test window.
5. `monthly_usage.email_sent_count` increases during safe-test window.
6. `notification_logs.recipient_kind='customer'` appears during safe-test window.
7. Inbox does not receive the safe-test within the defined waiting window.
8. UI status card and expected flag/provider/sender values disagree.
9. Operator is uncertain whether the correct button was clicked.

### Who can execute rollback

- Phase 2.4-b: Richard / system admin only.
- Later phases: admin role with second-operator acknowledgement.

### Pre-rollback record

Before rollback, record:

1. Time in Asia/Taipei.
2. Trigger code/reason.
3. Current Router and fallback flag state.
4. Latest testRunId if available.
5. `email_send_log` recent status distribution.
6. `notification_logs` recent status distribution.
7. `email_unsubscribe_tokens` count.
8. Current `monthly_usage` month count.

### Rollback execution steps

1. Set `EMAIL_PROVIDER_ROUTER_ENABLED=false`.
2. Confirm `EMAIL_FALLBACK_ENABLED=false`.
3. Wait for the next invocation context to read updated environment.
4. Refresh `/admin/notifications`.
5. Confirm mode returns to Legacy Lovable Emails.
6. Stop all test/send actions.
7. Observe for five minutes.

### Final checks

After rollback, confirm:

1. No new `email_send_log` rows after rollback except expected pre-recorded rows.
2. No new `notification_logs` rows after rollback.
3. `email_unsubscribe_tokens` unchanged.
4. `monthly_usage.email_sent_count` unchanged.
5. UI displays Router disabled / Legacy Lovable Emails.
6. Incident or completion note is archived in GitHub.

---

## 5. B3 — Production Safe Test Execution SOP Draft

### Fixed parameters

- Allowed recipient source: `notification_settings.lohashare_recipients` only.
- Do not fall back to `current_admin_self` if approved recipients are empty.
- Recommended first test approved recipient count: 1.
- Sender: `notify@send.lohashare.com`.
- Sender domain: `send.lohashare.com`.
- Provider path: `Router → resend（無 Fallback）`.
- Router flag during test window: `EMAIL_PROVIDER_ROUTER_ENABLED=true`.
- Fallback flag: `EMAIL_FALLBACK_ENABLED=false`.
- Target: internal LOHAShare test site only.
- Customer recipients: forbidden.

### Execution stages

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

### Baseline checklist

Before flipping Router:

- `email_send_log` total and latest rows.
- `notification_logs` total, `is_test=true`, `recipient_kind` distribution.
- `activity_logs.notification.test_send.queued` count.
- `email_unsubscribe_tokens` count.
- `monthly_usage` current month `email_sent_count` and `lead_count`.
- `notification_settings.updated_at`.

### Expected DB delta

Expected:

- `email_send_log` +1 with `status='sent'`.
- `activity_logs.notification.test_send.queued` +1.

Expected no-change invariants:

- `notification_logs` unchanged for production safe-test if safe-test path remains separate from customer notification logs.
- `email_unsubscribe_tokens` unchanged.
- `monthly_usage` unchanged.
- No `recipient_kind='customer'` row.
- `notification_settings.updated_at` unchanged.

### Pass criteria

All must be true:

1. Response `status='queued'`.
2. `queuedCount=1`.
3. `failedCount=0`.
4. `blockers=[]`.
5. Provider path is Router → Resend without fallback.
6. `email_send_log` latest safe-test row is `sent`.
7. Inbox receives the safe-test from `notify@send.lohashare.com`.
8. No safety invariant is violated.
9. Router is rolled back to false.
10. Final DB safety check has no unexpected deltas.

### Fail / stop criteria

Stop and rollback if any condition occurs:

1. Response is not queued.
2. Blockers are non-empty.
3. `email_send_log` has `failed` or `dlq`.
4. Inbox does not receive email in the waiting window.
5. `email_unsubscribe_tokens` changes.
6. `monthly_usage` changes.
7. Any customer recipient appears.
8. UI status disagrees with expected mode.
9. Operator is uncertain about the operation.

---

## 6. Operator SOP Draft File Plan

Recommended SOP file:

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/LOHAShare_AI_Console_Phase_2.4_Production_Router_Operator_SOP_DRAFT_20260613.md
```

Recommended sections:

1. Purpose.
2. Scope.
3. Roles and Permissions.
4. Current Production Router State.
5. Production Safe Test Preconditions.
6. Operator UI Safety Rules.
7. Production Router Rollback SOP.
8. Production Safe Test Execution SOP.
9. DB / Log Monitoring Checklist.
10. Inbox Verification Checklist.
11. Stop / Rollback Criteria.
12. Incident Documentation Template.
13. Remaining Implementation Items.
14. Decision Before Phase 2.4-b.

---

## 7. Work Classification

### A. Documentation-only items

Can be completed by ChatGPT + GitHub:

1. Archive this Phase 2.4-a-1 planning report.
2. Archive Operator SOP draft.
3. Convert rollback SOP to Markdown.
4. Convert safe-test execution SOP to Markdown.
5. Create incident documentation template.
6. Keep using canonical testRunId `c3596815-d602-498d-927e-a03376ca577b` where prior successful smoke test is referenced.

### B. Lovable app implementation items

Require future app/code work:

1. Production Safe Test Enqueue label + ConfirmDialog + requireTyping.
2. Environment badge.
3. `data-testid` additions.
4. Visual separation between Preflight and Enqueue.
5. Admin render-time gate.
6. Provider status card visibility validation.
7. Later: `sent_at`, automatic reconcile, site-level Router flag.

### C. Must complete before Phase 2.4-b

1. Archive Phase 2.4-a-1 report.
2. Archive Operator SOP draft.
3. Implement B1 minimal UI safety lock.
4. Verify B1 in production UI.
5. Confirm `EMAIL_FALLBACK_ENABLED=false`.
6. Confirm `RESEND_FROM_EMAIL=notify@send.lohashare.com`.
7. Confirm at least one valid `lohashare_recipients` recipient.
8. Obtain explicit user authorization to start Phase 2.4-b.

---

## 8. Decision

Phase 2.4-a-1 planning is complete.

The recommended safety decision is:

```text
Use B1 Option B for Phase 2.4-b readiness.
```

Meaning:

- Keep a production safe-test action available.
- Protect it with admin-only render, ConfirmDialog, required typing, environment badge, provider/sender/recipient visibility, stable test ids, and visual separation from Preflight.

Next sequence:

1. ChatGPT + GitHub archive this planning report.
2. ChatGPT + GitHub archive Operator SOP draft.
3. Lovable implements B1 minimal UI safety lock.
4. After B1 is verified, reevaluate whether Phase 2.4-b Production Safe Test Only can begin.

Phase 2.4-b is not yet authorized by this note.

No code, build, publish, secret, Router flag, enqueue, send, Preflight, Safe Test, DNS, DB schema, or migration changes were performed in this planning stage.
