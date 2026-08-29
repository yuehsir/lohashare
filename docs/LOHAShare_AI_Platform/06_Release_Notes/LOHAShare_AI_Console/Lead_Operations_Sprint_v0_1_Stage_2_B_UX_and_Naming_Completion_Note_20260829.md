# Lead Operations Sprint v0.1｜Stage 2-B Completion Note

Status: Archived / Founder Preview PASS / Final Read-only Verification PASS / No Publish  
Scope: Stage 2-B Global Lead Overview, Site Lead UX Clarification, Naming & Business Context  
Date: 2026-08-29

## 1. Summary

Lead Operations Sprint v0.1 Stage 2-B has been completed and verified.

This stage improved the lead operations UI after Stage 2-A Drawer Assignment by clarifying:

1. Global lead overview usage on `/admin/leads`
2. Site-specific customer lead filtering on `/admin/sites/$id/leads`
3. Detail entry visibility for both global and site-specific lead lists
4. Business wording for customer leads, subscribed customers, and service plans

Founder Preview has passed, and final post-implementation read-only verification has passed.

No publish was performed.

## 2. Final Verified HEAD

Final verified HEAD:

`28a49079d899a323c9339b35d71ee30238b67f25`

Git status:

`clean`

Typecheck:

`tsgo --noEmit PASS`

## 3. Product Files Modified in Stage 2-B

Expected product files modified during Stage 2-B:

- `src/routes/_authenticated/admin/leads.tsx`
- `src/routes/_authenticated/admin/sites.$id.leads.index.tsx`
- `src/routes/_authenticated/admin/sites.$id.index.tsx`
- `src/routes/_authenticated/admin/customers.index.tsx`
- `src/routes/_authenticated/admin/plans.tsx`

Stage 2-A related product files remain part of the broader Lead Operations Sprint context, but were not modified by the final Naming & Business Context fix:

- `src/lib/leads.functions.ts`
- `src/components/admin/LeadDetailDrawer.tsx`

Non-product Lovable planning artifacts were also produced:

- `.lovable/plan.md`
- `.lovable/plan/*`

## 4. Completed Scope

### 4.1 `/admin/leads` Global Lead Overview

Verified:

- H1 remains `名單總覽`
- Page description remains cross-customer / cross-site oriented
- Assignee filter exists
- Assignee filter includes:
  - `全部負責人`
  - `未指派`
  - specific assignable users
- Table includes assignee column
- Table includes detail column
- Each row includes a `查看` button
- Table title displays:
  - `名單列表 — 共 N 筆（最近 300 筆範圍內）`
- CSV export was not modified

### 4.2 `/admin/sites/$id/leads` Site Customer Lead Filtering

Verified:

- Breadcrumb final label is `站台名單篩選`
- H1 is `站台名單篩選`
- Page description clarifies:
  - `此頁只顯示本網站收到的客戶名單，可依表單、狀態、日期、來源與 UTM 條件篩選。共 N 筆。`
- Table title displays:
  - `客戶名單列表 — 共 N 筆`
- Table includes detail column
- Each row includes a `查看` button
- `查看` uses same-page `?leadId=<id>` Drawer behavior
- Existing row-click-to-open-Drawer behavior is preserved
- Drawer assignee Select does not include `全部負責人`

### 4.3 `/admin/sites/$id` Site Detail Page

Verified:

- Sub-function entry card title:
  - `站台名單篩選`
- Sub-function entry card description:
  - `瀏覽與篩選本網站收到的客戶名單`

### 4.4 `/admin/customers` Customer Management

Verified:

- Page description:
  - `管理所有訂閱 LOHAShare 網站垂直整合應用服務的客戶`
- No customer list columns were added
- Subscription plan / start date / end date / subscription status fields were not added
- Customer query and business logic were not modified

### 4.5 `/admin/plans` Plans and Quotas

Verified:

- Page description:
  - `管理 LOHAShare 所提供的各種網站垂直整合應用服務的訂閱方案`
- Plan data, plan names, quotas, pricing, and database content were not modified

## 5. Safety Verification

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
- No public submit API change
- No embed form route change
- No notification flow change
- No Email Router change
- No queue worker change
- No safe-test flow change
- No lead creation flow change

Counters remained unchanged:

- `leads = 18`
- `notification_logs = 49`
- `email_send_log = 57`

## 6. Founder Preview

Founder Preview result:

`PASS`

Founder confirmed:

`Naming & Business Context 文案符合預期。`

## 7. Follow-up Recommendation

Do not enter Stage 2-C or Publish from this note.

Recommended next follow-up item, if Founder approves later:

`Customer Overview Enhancement Sprint`

Purpose:

Enhance `/admin/customers` from a basic customer list into a customer overview by evaluating whether existing `subscriptions`, `plans`, and `sites` data can support:

- Current subscription plan
- Subscription status
- Start date
- Current period end date
- Site count

This follow-up was intentionally not implemented in Stage 2-B.

## 8. Completion Decision

Stage 2-B is considered complete after:

- Founder Preview PASS
- Final Read-only Verification PASS
- Completion Note approval and archive to GitHub

No Publish has been authorized by this note.
