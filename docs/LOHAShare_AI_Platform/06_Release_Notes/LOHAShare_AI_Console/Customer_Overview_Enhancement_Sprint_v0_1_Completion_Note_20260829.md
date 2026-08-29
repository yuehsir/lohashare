# Customer Overview Enhancement Sprint v0.1｜Completion Note

Status: Archived  
Scope: Customer Overview Read-only Enhancement / Create Customer Dialog UX Hint  
Result: Completed / Founder Preview PASS / Final Read-only Verification PASS / No Publish  
Date: 2026-08-29

## 1. Summary

Customer Overview Enhancement Sprint v0.1 has been completed and verified.

This sprint upgraded `/admin/customers` from a basic customer list into a read-only customer overview, allowing admin users to see each LOHAShare service customer’s current subscription plan, subscription status, subscription period, and site count directly from the customer management page.

This sprint also added a clear UX hint to the Create Customer dialog, clarifying that subscription plan and service period setup should be completed from the customer detail page after the customer record is created.

Founder Preview has passed, and final post-implementation read-only verification has passed.

No publish was performed.

## 2. Final Verified HEAD

Final verified HEAD:

`fe4edd850c21017d2397aa11bb43d7dda9a2c373`

Git status:

`clean`

Typecheck:

`tsgo --noEmit PASS`

## 3. Product File Modified

Expected product file modified in this sprint:

- `src/routes/_authenticated/admin/customers.index.tsx`

Non-product Lovable planning artifacts were also produced:

- `.lovable/plan.md`
- `.lovable/plan/*`

No other product page was modified in this sprint.

## 4. Completed Scope

### 4.1 `/admin/customers` Customer Overview

Verified:

- H1 remains:
  - `客戶管理`

- Page description remains:
  - `管理所有訂閱 LOHAShare 網站垂直整合應用服務的客戶`

- Table title changed to:
  - `客戶總覽`

Existing columns remain available:

- `客戶名稱`
- `聯絡人`
- `Email`
- `狀態`
- `操作 / 詳情`

New read-only columns were added:

- `目前訂閱方案`
- `訂閱狀態`
- `訂閱起始日`
- `當期結束日`
- `站台數`

### 4.2 Read-only Data Rules

Verified:

- Current subscriptions are read from existing `subscriptions` data where `is_current = true`
- Plan display uses existing `plans` data
- Site count is calculated from existing `sites` data by `customer_id`
- No server function was added
- No schema change was made
- No subscription write flow was added

Display rules:

- Customers without subscription data display:
  - `未設定`

- Customers without sites display:
  - `0`

- Subscription status labels:

  - `trial` → `試用`
  - `active` → `啟用中`
  - `past_due` → `逾期`
  - `paused` → `暫停`
  - `canceled / cancelled` → `已取消`

- If one customer has multiple `is_current = true` subscriptions:
  - use the subscription with the latest `current_period_end`
  - if equal or missing, use the latest `updated_at`

### 4.3 Existing Behaviors Preserved

Verified:

- Keyword search remains available
- Customer status filter remains available
- Add Customer dialog still opens
- Customer detail link still routes to:
  - `/admin/customers/$id`
- Existing create customer flow remains unchanged
- No subscription status filter was added
- No plan filter was added
- No add/edit subscription function was added to the customer list page

### 4.4 Create Customer Dialog UX Hint

Verified:

The Add Customer dialog now includes the highlighted hint:

`重點提示：建立客戶後，請點按客戶總覽清單右側的詳情按鈕，增設訂閱方案與起訖日。`

The hint is visually highlighted using:

- left primary border
- primary-tinted background
- Info icon
- bold `重點提示`

This hint clarifies the correct flow:

1. Create the basic customer record
2. Return to the customer overview list
3. Click the detail button
4. Set the subscription plan and service period from the customer detail page

No subscription fields were added to the Add Customer dialog.

## 5. Explicitly Not Modified

Final read-only verification confirmed that the sprint did not modify:

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

## 6. Safety Verification

Final read-only verification confirmed:

- No migration
- No Supabase schema change
- No RLS change
- No GRANT change
- No secrets change
- No Publish
- No email sent
- No enqueue
- No DLQ retry
- No form submit
- No lead created
- No write to customers / subscriptions / plans / sites

Counters remained unchanged:

- `leads = 18`
- `notification_logs = 49`
- `email_send_log = 57`

## 7. Founder Preview

Founder Preview result:

`PASS`

Founder confirmed:

`Founder Preview PASS：Create Customer Dialog UX Hint Copy & Highlight Patch 符合預期。`

## 8. Follow-up Recommendation

Do not publish from this note.

Potential future sprint, only if Founder approves later:

`Create Customer with Initial Subscription Sprint v0.1`

Possible scope:

- Add optional initial subscription fields to Create Customer dialog
- Create customer and initial subscription in one controlled flow
- Preserve existing customer detail subscription management

This follow-up was intentionally not implemented in Customer Overview Enhancement Sprint v0.1.

## 9. Completion Decision

Customer Overview Enhancement Sprint v0.1 is considered complete after:

- Founder Preview PASS
- Final Read-only Verification PASS
- Completion Note approval and archive to GitHub

No Publish has been authorized by this note.
