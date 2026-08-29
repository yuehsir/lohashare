# Create Customer with Initial Subscription Sprint v0.1｜Completion Note

Status: Archived  
Scope: Create Customer Flow / Initial Subscription Creation / Activity Log Reliability / Dialog Scroll Fix  
Result: Completed / Founder Preview PASS / Controlled Write Test PASS / Final Read-only Verification PASS / No Publish  
Date: 2026-08-29

## 1. Summary

Create Customer with Initial Subscription Sprint v0.1 has been completed and verified.

This sprint enhanced `/admin/customers` so an admin can optionally create an initial subscription when creating a new customer.

The Create Customer dialog now supports:

- creating the basic customer record
- optionally enabling an initial subscription section
- selecting an active plan
- selecting subscription status
- setting subscription start date
- setting current period start date
- setting current period end date
- adding subscription manual note

If no initial plan is selected, the flow remains compatible with the previous behavior and creates only the customer record.

If an initial plan is selected, the flow creates the customer first, then creates one `subscriptions` row with `is_current = true`, and writes a `subscription.create` activity log.

The sprint also fixed the Create Customer dialog height issue by making the dialog vertically scrollable across desktop, tablet, and mobile viewports.

No publish was performed.

## 2. Final Verified HEAD

Final verified HEAD:

`90fbd728e6df23a2de31af09c4b1d2c09b1f0f18`

Git status:

`clean`

Typecheck:

`tsgo --noEmit PASS`

## 3. Product File Modified

Expected product file modified in this sprint:

- `src/routes/_authenticated/admin/customers.index.tsx`

Non-product Lovable planning artifacts may also have been produced:

- `.lovable/plan.md`
- `.lovable/plan/*`

No other product page was modified in this sprint.

## 4. Completed Scope

### 4.1 Create Customer Dialog

The Create Customer dialog now includes:

- existing customer basic fields:
  - customer name
  - contact person
  - contact phone
  - contact email
  - customer status
  - customer notes

- new optional section:
  - `初始訂閱（選填）`

The initial subscription section is disabled / collapsed by default, so the existing fast customer creation flow remains available.

### 4.2 Initial Subscription Fields

When enabled, the initial subscription section includes:

- plan
- subscription status
- subscription start date
- current period start date
- current period end date
- subscription manual note

Plan options are read from existing active plans:

- `plans`
- `is_active = true`

No plan write was added.

### 4.3 Create Flow Behavior

Verified behavior:

- If the initial subscription section is not enabled, or no plan is selected:
  - create customer only
  - do not create subscription
  - do not write `subscription.create` activity log

- If a plan is selected:
  - create customer first
  - create one `subscriptions` row
  - set `is_current = true`
  - set selected `billing_status`
  - set selected date fields when provided
  - set `manual_note` when provided
  - set `created_by` from current user
  - write `subscription.create` activity log

### 4.4 Activity Log Reliability Patch

During Controlled Write Test #1, the main customer and subscription data were created successfully, but the `subscription.create` activity log was missing.

Root cause analysis found that `logActivity` depends on a role lookup network request and may fail silently under some client request lifecycle conditions.

The minimal patch kept `customer.create` using existing `logActivity(...)`, but changed the initial subscription path so `subscription.create` is written directly to `activity_logs` from `customers.index.tsx`.

Verified direct activity log fields:

- `action = subscription.create`
- `actor_user_id`
- `actor_role = admin`
- `entity_type = subscription`
- `entity_id = subscription.id`
- `customer_id = customer.id`
- `after_data = subscription data`
- `description = 建立初始訂閱：<客戶名稱>`

No global `logActivity` helper was modified.

### 4.5 Dialog Scroll Fix

Founder Preview found the expanded Create Customer dialog exceeded viewport height and was not scrollable.

The dialog was patched with viewport-constrained scroll behavior:

- `max-h-[90vh]`
- `overflow-y-auto`
- `sm:max-w-lg`
- `w-[calc(100vw-2rem)]`

Verified across:

- desktop `1280×800`
- tablet `768×1024`
- mobile `375×667`

Result:

- dialog scroll works
- initial subscription section remains usable
- bottom save button is reachable
- no horizontal overflow on mobile

## 5. Controlled Write Tests

### 5.1 Controlled Write Test #1

Founder authorized one controlled write test.

Result:

- customer created successfully
- subscription created successfully
- `/admin/customers` displayed the new subscription data correctly
- `/admin/customers/$id` displayed the subscription correctly
- `customer.create` activity log existed
- `subscription.create` activity log was missing

Test data retained:

- customer id:
  - `b806e7e3-5759-4371-afab-e6cd34bb678a`
- subscription id:
  - `6c95eb31-70dd-4fec-b8fb-3ba17b6863be`

This led to the Activity Log Patch v0.1.

### 5.2 Controlled Write Test #2

After the Activity Log Patch, Founder authorized a second controlled write test.

Result:

- customer created successfully
- subscription created successfully
- `/admin/customers` displayed the new customer and subscription correctly
- `/admin/customers/$id` displayed the subscription correctly
- `customer.create` activity log existed
- `subscription.create` activity log existed

Test data retained:

- customer id:
  - `1ee7a0ea-33d3-4154-9992-2e9786172d79`
- subscription id:
  - `8c8b1679-cbb3-40a2-85bb-1240ee41317b`
- plan:
  - `企業版 / enterprise`
- plan id:
  - `4881d313-4ff0-49e9-b3e1-241d0dab454b`

Controlled Write Test #2 result:

`PASS`

## 6. Final Data State

Final verified data state after Controlled Write Test #2:

- `customers = 7`
- `subscriptions = 7`
- `activity_logs = 101`

Unaffected counters:

- `leads = 18`
- `notification_logs = 49`
- `email_send_log = 57`

No third test customer was created during the final dialog scroll fix verification.

## 7. Explicitly Not Modified

Final verification confirmed this sprint did not modify:

- customer detail page
- plans page
- AppSidebar
- `/admin/leads`
- LeadDetailDrawer
- CSV
- public submit API
- embed form route
- notification flow
- Email Router
- queue worker
- safe-test flow
- lead creation flow
- Supabase schema
- RLS / GRANT
- secrets
- migration files
- global `logActivity` helper
- `roles.functions.ts`

## 8. Safety Verification

Final verification confirmed:

- No Publish
- No migration
- No Supabase schema change
- No RLS change
- No GRANT change
- No secrets change
- No email sent
- No enqueue
- No DLQ retry
- No public form submit
- No lead created
- No plan write
- No site write
- No subscription UPDATE
- No subscription DELETE
- No customer DELETE
- No server function added

## 9. Founder Preview

Founder Preview results:

- `Founder Preview UI PASS：初始訂閱選填區塊符合預期。`
- `Founder Preview PASS：Activity Log Patch v0.1 UI 正常，核准 Controlled Write Test #2。`
- `Founder Preview PASS：新增客戶 Dialog scroll fix 符合預期。`

## 10. Follow-up Recommendation

Do not publish from this note.

Potential future follow-up items, only if Founder approves later:

1. Test data cleanup / archive decision
   - decide whether to retain or delete the controlled test customers and subscriptions
   - do not delete without explicit Founder approval

2. Missing activity log repair for Controlled Write Test #1
   - optional one-time data repair for subscription id:
     - `6c95eb31-70dd-4fec-b8fb-3ba17b6863be`
   - should require separate Founder approval

3. Global Activity Log Reliability Sprint
   - evaluate whether `logActivity` should be made more reliable across all admin flows
   - not included in this sprint

## 11. Completion Decision

Create Customer with Initial Subscription Sprint v0.1 is considered complete after:

- Implementation PASS
- Activity Log Patch PASS
- Controlled Write Test #2 PASS
- Dialog Scroll Fix PASS
- Founder Preview PASS
- Completion Note approval and archive to GitHub

No Publish has been authorized by this note.
