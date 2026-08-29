# Test Data Retention Decision Note｜Create Customer with Initial Subscription Sprint v0.1

Status: Archived  
Scope: Test Data Retention / Missing Log Repair Decision  
Decision: Keep Test Data / Do Not Repair Missing Log / Do Not Delete Test Records  
Date: 2026-08-29

## 1. Background

Create Customer with Initial Subscription Sprint v0.1 has been completed and archived.

Archived completion note:

`docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/Create_Customer_with_Initial_Subscription_Sprint_v0_1_Completion_Note_20260829.md`

During the sprint, two Founder Controlled Write Tests were executed to verify the Create Customer + Initial Subscription flow.

The purpose of this Decision Note is to record the decision regarding:

1. whether to retain the controlled test data
2. whether to repair the missing `subscription.create` activity log from Controlled Write Test #1
3. whether to delete the test customers, subscriptions, and related logs

No production publish was performed.

## 2. Current Verified Data State

A read-only verification confirmed the current data state:

- `customers = 7`
- `subscriptions = 7`
- `activity_logs = 101`
- `leads = 18`
- `notification_logs = 49`
- `email_send_log = 57`

These values are the current post-test baseline after Create Customer with Initial Subscription Sprint v0.1.

## 3. Controlled Write Test #1

Test customer:

`b806e7e3-5759-4371-afab-e6cd34bb678a`

Test subscription:

`6c95eb31-70dd-4fec-b8fb-3ba17b6863be`

Verified state:

- customer exists
- subscription exists
- customer status is active
- subscription uses the enterprise plan
- subscription billing status is trial
- subscription is current
- `customer.create` activity log exists
- `subscription.create` activity log is missing

This missing `subscription.create` activity log was the reason Activity Log Patch v0.1 was created and verified.

## 4. Controlled Write Test #2

Test customer:

`1ee7a0ea-33d3-4154-9992-2e9786172d79`

Test subscription:

`8c8b1679-cbb3-40a2-85bb-1240ee41317b`

Verified state:

- customer exists
- subscription exists
- customer status is active
- subscription uses the enterprise plan
- subscription billing status is trial
- subscription is current
- `customer.create` activity log exists
- `subscription.create` activity log exists

Controlled Write Test #2 verified that Activity Log Patch v0.1 fixed the missing `subscription.create` activity log behavior for newly created initial subscriptions.

## 5. Decision Options Reviewed

### Option A｜Keep All Test Data

Keep both test customers, subscriptions, and existing activity logs.

No data repair.

No data deletion.

Benefits:

- zero data write risk
- zero deletion risk
- preserves the original verification trail
- preserves evidence of the pre-patch missing log behavior
- preserves evidence that the patched flow worked correctly in Controlled Write Test #2

Trade-off:

- two `TEST｜` customers remain visible in `/admin/customers`
- Controlled Write Test #1 remains with a known missing `subscription.create` log
- future baselines must remember the post-test counters:
  - `customers = 7`
  - `subscriptions = 7`
  - `activity_logs = 101`

### Option B｜Repair Missing Log for Controlled Write Test #1

Insert one missing `subscription.create` activity log for:

`6c95eb31-70dd-4fec-b8fb-3ba17b6863be`

Assessment:

- technically feasible
- would require writing one new row into `activity_logs`
- does not require migration / schema / RLS / GRANT changes
- would not trigger email / notification / queue / lead flow

Reason not selected:

- the log would be a later manual repair, not the original event-time log
- the missing log itself is useful evidence of the pre-patch issue
- repairing it could obscure the historical reason the Activity Log Patch was required
- any repair would require separate Founder approval and a separate Data Repair Implementation

### Option C｜Delete Test Customers, Subscriptions, and Activity Logs

Delete both test customers, subscriptions, and related logs.

Assessment:

- not recommended
- would damage verification traceability
- would make archived completion notes harder to verify later
- `activity_logs` appears intentionally append-only and does not currently support ordinary DELETE
- deletion would require a higher-risk Data Cleanup Implementation and possibly special handling

Reason not selected:

- deletion conflicts with auditability
- deletion may break the traceability of archived sprint evidence
- retaining clearly prefixed `TEST｜` records is safer at this stage

## 6. Founder Decision

Founder adopts:

`Option A｜Keep All Test Data`

Decision:

- keep both controlled test customers
- keep both controlled test subscriptions
- keep all existing activity logs
- do not repair the missing `subscription.create` activity log from Controlled Write Test #1
- do not delete test data
- do not modify code
- do not modify Supabase schema / RLS / GRANT / secrets
- do not publish

## 7. Rationale

This decision preserves the most complete audit trail.

Controlled Write Test #1 documents the original missing `subscription.create` activity log problem.

Controlled Write Test #2 documents that the Activity Log Patch fixed the problem.

Keeping both test cases provides a clear before / after validation trail:

- Test #1: pre-patch behavior with missing `subscription.create` log
- Test #2: post-patch behavior with complete `customer.create` and `subscription.create` logs

This is more useful for governance and future debugging than deleting or manually repairing the historical test data.

## 8. Future Handling

The test records should remain clearly identifiable as test data by their names:

- `TEST｜Initial Subscription｜2026-08-29`
- `TEST｜Initial Subscription｜2026-08-29 #2`

Future cleanup may be reconsidered only if:

- production customer data import begins
- test records interfere with reporting
- a dedicated test-data filtering feature is added
- Founder explicitly authorizes a separate Data Cleanup Implementation

Any future data repair or deletion must require separate Founder approval.

## 9. Explicitly Not Authorized

This Decision Note does not authorize:

- data deletion
- missing log repair
- activity_logs manual insertion
- customer deletion
- subscription deletion
- schema change
- RLS / GRANT change
- secrets change
- migration
- Publish
- email send
- enqueue
- DLQ retry
- public form submit
- lead creation
- code change

## 10. Completion Decision

Test Data Retention Decision is complete after:

- Founder approves this Decision Note
- Decision Note is archived to GitHub

No Publish is authorized by this note.
