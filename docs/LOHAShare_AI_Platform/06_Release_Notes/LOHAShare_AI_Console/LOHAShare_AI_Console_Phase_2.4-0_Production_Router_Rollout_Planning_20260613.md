# LOHAShare AI Console — Phase 2.4-0 Production Router Rollout Planning

Date: 2026-06-13  
Environment: Planning / Post-Preview Success  
Status: Archived  
Owner: LOHAShare AI Platform  
Module: Email Notification / Email Provider Router  
Previous milestone: Phase 2.3c-b-d-e Successful

---

## 1. Summary

This document defines the Phase 2.4 production rollout planning for the LOHAShare AI Console Email Provider Router.

Phase 2.3c-b-d-e successfully verified the Preview real-send chain:

```text
Router → Resend → Safe Test Send → email_send_log sent → inbox received
```

The verified DB canonical testRunId was:

```text
c3596815-d602-498d-927e-a03376ca577b
```

The goal of Phase 2.4 is to move from a successful Preview safe-test to a controlled, monitored, reversible Production Router rollout.

This planning document is read-only and does not start Phase 2.4 implementation.

---

## 2. Guardrails

This planning stage did not perform any system-changing action.

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

---

## 3. Current State

| Area | Current state |
|---|---|
| Primary provider | Resend |
| Resend sender | `notify@send.lohashare.com` |
| Resend sender domain | `send.lohashare.com`, verified by user-provided Resend Dashboard evidence |
| Router flag | `EMAIL_PROVIDER_ROUTER_ENABLED=false` |
| Fallback state | `EMAIL_FALLBACK_ENABLED=false` |
| Zoho SMTP | Adapter/design exists; Zoho SMTP was tested separately but is not yet enabled as production fallback |
| Safe Test Send | Preview success verified in Phase 2.3c-b-d-e |
| Customer recipients | Not yet routed through the Email Provider Router |
| Safe-test monthly usage impact | No pollution; safe-test excluded |
| Safe-test unsubscribe token impact | No token generated |
| Send result truth source | `email_send_log` is the current primary source of truth |
| `notification_logs` terminal status | Known gap: queued/sent synchronization is not fully automatic |

Known remaining risks:

1. `notification_logs` terminal status and `email_send_log` synchronization still depend on `reconcileRecentEmailLogs` being triggered manually or on-demand.
2. `email_send_log.sent_at` write behavior should be aligned between Router and Legacy paths.
3. `monthly_usage.email_sent_count` may lag until reconcile updates queued notifications to sent.
4. Zoho SMTP fallback is not yet validated in the production Router path.
5. Production-only safe-test flow is not yet formalized; current safe-test UI is DEV-only.
6. Production rollback runbook and operator SOP need to be written and reviewed.

---

## 4. Proposed Phase 2.4 Stages

### Phase 2.4-a — Production Readiness Audit

| Item | Plan |
|---|---|
| Goal | Audit all blockers before production Router use. |
| Allowed | Read-only DB queries, code review, documentation draft. |
| Forbidden | Code change, secret change, Router flip, enqueue, send. |
| Prerequisite | Phase 2.3c-b-d-e Successful. |
| Steps | Review `email_send_log`, `notification_logs`, `monthly_usage`, `email_unsubscribe_tokens`, Router path, Legacy path, unsubscribe policy, operator UI, and rollback gaps. |
| DB / log indicators | Audit checklist only; no writes. |
| Rollback | Not applicable; read-only. |
| Pass criteria | Complete audit report and blocker list. |
| Fail criteria | Unknown production risk requiring spike. |
| GitHub archive | Required: planning doc and audit report. |

### Phase 2.4-b — Production Safe Test Only

| Item | Plan |
|---|---|
| Goal | Run a production safe-test to LOHAShare recipients only. |
| Allowed | Short production Router ON window, LOHAShare safe-test enqueue, immediate rollback. |
| Forbidden | Customer recipient enqueue, fallback enablement, DNS change. |
| Prerequisite | Phase 2.4-a pass; production safe-test UI/safety lock reviewed. |
| Steps | Turn Router ON, verify provider status, run safe-test, monitor DB delta, verify inbox, turn Router OFF. |
| DB / log indicators | `email_send_log +1 sent`, `notification_logs is_test=true +1`, `monthly_usage delta=0`, `email_unsubscribe_tokens delta=0`. |
| Rollback | Immediate flag OFF if any unexpected indicator appears. |
| Pass criteria | Production safe-test matches Preview success with no customer pollution. |
| Fail criteria | Domain/auth/422 error or monthly usage pollution. |
| GitHub archive | Required: smoke test note. |

### Phase 2.4-c — Internal LOHAShare-only Router Enablement

| Item | Plan |
|---|---|
| Goal | Enable Router for real lead notifications on LOHAShare-owned internal test site only. |
| Allowed | Site-scoped Router enablement, real internal lead notification. |
| Forbidden | Any external customer site through Router. |
| Prerequisite | Phase 2.4-b pass; site-scoped gating mechanism designed. |
| Steps | Submit real internal lead, observe Router send, verify email_send_log and reconcile behavior. |
| DB / log indicators | `email_send_log sent`, `notification_logs queued → sent`, `monthly_usage` increments correctly for internal customer/site. |
| Rollback | Flag/site allowlist OFF if more than one failed send or reconcile mismatch occurs. |
| Pass criteria | N consecutive internal leads succeed and reconcile correctly. |
| Fail criteria | Auth/domain/rate error not automatically recoverable. |
| GitHub archive | Required. |

### Phase 2.4-d — Single Test Customer Site Router Enablement

| Item | Plan |
|---|---|
| Goal | Enable Router for one low-traffic cooperative customer site. |
| Allowed | One selected `site_id` sends real customer notifications via Router. |
| Forbidden | Any other customer site through Router. |
| Prerequisite | Phase 2.4-c stable for an agreed period, List-Unsubscribe/footer ready. |
| Steps | Notify customer, enable selected site, monitor real leads, reconcile logs, collect feedback. |
| DB / log indicators | Sent rate, bounce/suppression, unsubscribe token generation/usage, customer feedback. |
| Rollback | Turn off selected site if bounce/complaint rises or customer reports issue. |
| Pass criteria | Stable observation period with correct logs and no customer objection. |
| Fail criteria | Deliverability degradation or incorrect monthly usage. |
| GitHub archive | Required. |

### Phase 2.4-e — Customer Notification Controlled Rollout

| Item | Plan |
|---|---|
| Goal | Gradually migrate customer sites to Router. |
| Allowed | Batch enablement such as 10% → 50% → 100%. |
| Forbidden | One-step all-customer migration without observation. |
| Prerequisite | Phase 2.4-d pass, operator SOP complete, rollback runbook complete. |
| Steps | Enable one batch, observe, expand only if metrics pass. |
| DB / log indicators | Sent ratio, bounce ratio, suppression ratio, reconcile lag. |
| Rollback | Return to previous stable batch if redline metric triggers. |
| Pass criteria | 100% rollout passes stability window. |
| Fail criteria | Any batch fails SLA. |
| GitHub archive | Required. |

### Phase 2.4-f — Zoho SMTP Fallback Planning / Enablement

| Item | Plan |
|---|---|
| Goal | Enable Zoho SMTP fallback after Router primary path is stable. |
| Allowed | Fallback flag ON, controlled primary failure injection, fallback observation. |
| Forbidden | Fallback enablement before Router GA or untested SMTP credentials. |
| Prerequisite | Phase 2.4-e GA, Zoho production secrets ready, adapter audit pass. |
| Steps | Staging/preview fallback audit, production fallback ON, primary failure injection, observe. |
| DB / log indicators | `fallback_used=true`, fallback success rate, reconcile consistency. |
| Rollback | `EMAIL_FALLBACK_ENABLED=false` if fallback introduces errors. |
| Pass criteria | Fallback rescues primary failure and does not affect happy path. |
| Fail criteria | High fallback failure rate or unexpected branch behavior. |
| GitHub archive | Required. |

### Phase 2.4-g — Monitoring / Rollback / Operator SOP Finalization

| Item | Plan |
|---|---|
| Goal | Finalize production monitoring, rollback runbook, operator SOP, and release note. |
| Allowed | Documentation, UI text, dashboard/read-only query design. |
| Forbidden | Router/secret actions. |
| Prerequisite | Phase 2.4-e, fallback optional. |
| Steps | Define dashboard views, write SOP, write incident checklist, run operator drill. |
| DB / log indicators | SOP coverage and operator drill pass/fail. |
| Rollback | Not applicable. |
| Pass criteria | SOP reviewed and drill successful. |
| Fail criteria | Drill exposes unresolved gap. |
| GitHub archive | Required: Operator SOP and release note. |

---

## 5. Production Readiness Blockers

Before formal customer notification through the Router, the following items should be completed:

1. `email_send_log.sent_at` must be written consistently in Router and Legacy paths.
2. `notification_logs` terminal status should be automatically reconciled, not only on-demand.
3. `monthly_usage.email_sent_count` must be accurate under automatic reconcile.
4. List-Unsubscribe header and footer policy must be implemented for the Resend customer path.
5. `email_unsubscribe_tokens` must be generated and bound for customer notifications.
6. Fallback-disabled error, retry, and DLQ behavior must be verified.
7. Operator UI safety locks must be reviewed for production mode.
8. Production rollback SOP must cover flag rollback, DNS/provider incident, and support escalation.
9. Support / incident log SOP must define who monitors `email_send_log`, suppressed, bounced, and failed sends.

---

## 6. Items That Can Be Deferred

The following can be deferred until after primary Router production readiness:

1. Zoho SMTP fallback production enablement.
2. Advanced admin dashboard charts.
3. Multi-region sender planning.
4. Multi-sender routing policy.

---

## 7. Items Not Recommended Now

The following should not be done at this point:

1. Full customer Router switch in one step.
2. Customer Router send before reconcile, unsubscribe, and List-Unsubscribe are ready.
3. Simultaneous Router + Fallback production enablement.
4. Production Router enablement without rollback SOP.

---

## 8. Recommended Next Step

Recommended next step:

```text
Phase 2.4-a — Production Readiness Audit（read-only）
```

This should be performed before any additional production send test.

Recommended outputs for Phase 2.4-a:

1. Production readiness audit report.
2. Blocker list.
3. Initial Operator SOP draft.
4. GitHub planning / audit archive.

---

## 9. Decision

Phase 2.4-0 is a planning milestone and is now archived.

Phase 2.4 should proceed only with explicit user authorization and should start with:

```text
Phase 2.4-a — Production Readiness Audit（read-only）
```

No production Router enablement is authorized by this planning note.

No code, build, publish, secret, Router flag, enqueue, send, preflight, safe-test, DNS, Resend Dashboard, or DB schema changes were performed in this planning stage.
