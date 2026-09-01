# LOHAShare AI Hub｜Usage Integrity Data Layer｜Application RPC Integration｜Stage 2-D Completion Note

Status: IMPLEMENTED & PREVIEW VERIFIED  
Scope: Usage Integrity Data Layer / Application RPC Integration / Asia-Taipei UI Alignment  
Implementation Baseline: `bdf5f7a1c926f4b8eae356a22b0cca3694eb8f8e`  
Completed and Preview-Verified HEAD: `3a7913c8d24c94928e179072a5a9b94ad570db43`  
Date: 2026-08-30

## 1. Purpose

This Completion Note archives the implementation and verification result of:

`Stage 2-D｜Usage Integrity Data Layer｜Application RPC Integration`

The stage integrated the existing server-side atomic usage counter RPC into the lead and email application paths, and aligned Dashboard and Usage month handling with Asia/Taipei boundaries.

This note records the completed scope only. It does not authorize further controlled data verification, data correction, Email Router activation, fallback activation, production email sending, form submission, lead creation, reconciliation, DLQ operations or Publish.

## 2. Governance Baseline

Canonical implementation baseline:

`bdf5f7a1c926f4b8eae356a22b0cca3694eb8f8e`

Completed and Preview-verified HEAD:

`3a7913c8d24c94928e179072a5a9b94ad570db43`

Stage 2-C service_role Controlled Function Verification remains:

`HOLD`

Reason:

The available tool environment could not guarantee all of the following in one controlled database session:

- `SET LOCAL ROLE service_role`
- one single session
- one single transaction
- mandatory final `ROLLBACK`

No direct service_role function verification was executed in Stage 2-C.

## 3. Approved and Actual File Scope

The implementation modified exactly the following six approved files:

1. `src/routes/api/public/forms/submit.ts`
2. `src/lib/notifications-reconcile.functions.ts`
3. `src/lib/dashboard-metrics.ts`
4. `src/routes/_authenticated/admin/index.tsx`
5. `src/routes/_authenticated/admin/usage.tsx`
6. `src/lib/taipei-month.ts`

No migration, generated Supabase type file, Supabase server client file or `.lovable/plan.md` change was included in the Stage 2-D implementation diff.

## 4. Lead Counter Integration

The public form submission application path was updated so that:

- the successful lead insert returns `id` and `created_at`
- the server-side `supabaseAdmin` client calls `bump_monthly_usage`
- `_occurred_at` uses `lead.created_at`
- `_lead_delta = 1`
- `_email_delta = 0`
- the previous `monthly_usage` read-then-write flow was removed
- application-side `year_month` generation was removed from this path
- an RPC failure does not recreate the lead
- an RPC failure does not change the successful public form response into a failure response
- the RPC is not automatically retried
- failure handling records a non-PII `usage.counter_update_failed` / `reconciliation_required` signal
- customer name, email, telephone and other lead PII are not included in the usage counter failure log

This preserves the lead as the primary successful event while clearly marking counter reconciliation as required if the secondary usage update fails.

## 5. Email Counter Integration

The notification reconciliation application path was updated so that:

- the `email_send_log` query includes `sent_at`
- the queued-to-sent update uses a status guard
- the update returns the actually transitioned row
- an update returning zero rows does not increment usage
- counting eligibility requires:
  - `recipient_kind = 'customer'`
  - `is_test = false`
  - provider status is `sent`
  - `sent_at` is valid
  - this execution actually completed the queued-to-sent transition
- `_occurred_at` uses `email_send_log.sent_at`
- `_lead_delta = 0`
- `_email_delta = 1`
- the previous `monthly_usage` read-then-write flow and UTC `ymFor` generation were removed
- queued, failed, skipped, test and LOHAShare-recipient records are not counted
- retry, resend, repeated reconciliation and DLQ processing cannot increment the same non-transitioned event again
- `usageIncrements` increases only after the counter RPC succeeds
- an RPC failure does not resend email, requeue the email, restore queued status or automatically retry
- an RPC failure leaves a `reconciliation_required` record

The returned-row status guard is the application-level duplicate prevention boundary for this integration.

## 6. Asia/Taipei Integration

A new pure helper was added:

`src/lib/taipei-month.ts`

The helper:

- has no Supabase dependency
- has no side effects
- calculates Asia/Taipei month identity
- calculates start-inclusive and end-exclusive UTC timestamps for a selected Taipei calendar month
- supports month switching across month-end and year-end boundaries

Dashboard integration:

- uses Asia/Taipei month boundaries
- queries with start-inclusive / end-exclusive semantics
- displays the Asia/Taipei (UTC+8) month explanation
- no longer displays the previous UTC-only wording

Usage integration:

- selected month and displayed boundaries switch together
- displays the corresponding Taipei start and `endExclusive`
- preserves incomplete, unavailable and cache-status distinctions

The authenticated frontend and client bundle do not call `taipei_year_month`.

The database function ACL was not lowered, and authenticated users were not granted EXECUTE permission.

## 7. TypeScript, Build and Client Safety

Verification results:

- `tsgo --noEmit`: PASS
- Production Build: PASS
- client bundle service-role key inspection: PASS
- no service-role key found in the client bundle
- no client import of `client.server.ts` was introduced
- the existing generated RPC types were sufficient
- `src/integrations/supabase/types.ts` was not modified

## 8. Lovable-native Read-only Preview Verification

Lovable Agent used the project's existing internal Preview environment in read-only mode.

Dashboard:

- Asia/Taipei (UTC+8) month explanation: PASS
- previous UTC-only wording absent: PASS
- current-month lead source explanation uses Asia/Taipei: PASS
- incomplete / unavailable / cache warnings remain distinguishable: PASS
- FAQ remains displayed as module not enabled: PASS

Usage:

- selected month Taipei start / `endExclusive` display: PASS
- previous-month / next-month switching: PASS
- boundaries update consistently with the selected month: PASS
- incomplete cache warning: PASS
- Email remains unverified cache: PASS
- AI rewrite remains unavailable: PASS
- AI quota percentage and overage judgment remain absent: PASS

Observed 2026-08 boundary example:

- start: `2026-07-31T16:00:00.000Z`
- endExclusive: `2026-08-31T16:00:00.000Z`

CSV was not downloaded.

Static source verification confirmed that:

- `Data_Status` remains present
- `Data_Note` remains present

No blocking UI issue was found.

## 9. Non-blocking Observation

During authenticated session hydration, Preview may briefly display:

`載入中…`

After the session becomes ready, Dashboard and Usage load normally.

This observation is non-blocking and did not require a code or permission change.

## 10. Governance Restrictions Maintained

The following restrictions remained in force throughout implementation and verification:

- Stage 2-C service_role Controlled Function Verification remains HOLD
- Router = false
- Fallback = false
- no Supabase schema change
- no database function change
- no RLS change
- no GRANT change
- no data modification
- no form submission
- no lead creation
- no email sending
- no reconciliation execution
- no DLQ operation
- no direct call to `bump_monthly_usage`
- no direct call to `taipei_year_month`
- no monthly report generation or persistence
- no Publish

## 11. Change Scope Verification

Compared with implementation baseline:

`bdf5f7a1c926f4b8eae356a22b0cca3694eb8f8e`

the Stage 2-D implementation diff was limited to the six approved files listed in this note.

The tree diff between intermediate commit:

`c4d914cb4c6b3ac820098194d30c8159ccbc99fe`

and completed HEAD:

`3a7913c8d24c94928e179072a5a9b94ad570db43`

was empty.

The Lovable-native read-only Preview verification produced:

- no file change
- no commit
- no code change
- no data change

## 12. Completion Decision

Stage 2-D completion status:

`IMPLEMENTED & PREVIEW VERIFIED`

After this Completion Note is archived and its one-file diff is verified, Stage 2-D may be formally marked CLOSED.

Recommended next stage:

`Stage 2-E｜Usage Integrity Data Layer｜Minimum Controlled Verification Planning Dry-run`

Stage 2-E must remain planning-only until separately authorized controlled tests are approved.
