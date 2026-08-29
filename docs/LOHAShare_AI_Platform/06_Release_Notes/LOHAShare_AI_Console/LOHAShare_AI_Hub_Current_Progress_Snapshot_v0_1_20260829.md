# LOHAShare AI Hub Current Progress Snapshot v0.1

Status: Archived  
Scope: LOHAShare AI Hub / Admin Console / Left Sidebar Feature Progress / Risk Baseline  
Result: Current Progress Snapshot / No Code Change / No Data Change / No Publish  
Date: 2026-08-29

## 1. Purpose

This document records the current feature completion baseline of the LOHAShare AI Hub / Admin Console left sidebar.

It is created after the Left Sidebar Feature Completion Audit v0.1 Scope Audit.

The purpose is to preserve a clear governance snapshot of:

1. which sidebar features already exist
2. which features are mostly complete
3. which features are still shell / preview only
4. which features have write capability but lack controlled verification
5. which features should not be expanded before Founder approval
6. what the recommended next Sprint sequence should be

This document is a progress snapshot only.

It does not authorize:

- Publish
- Supabase schema change
- data write
- data deletion
- email sending
- enqueue
- DLQ retry
- public form submit
- lead creation
- Lovable implementation
- GitHub code change

## 2. Audit Source

Audit source:

- Lovable project: `LOHAShare AI Hub`
- Sidebar source file:
  - `src/components/admin/AppSidebar.tsx`
- Audit type:
  - read-only Scope Audit
- Audit result:
  - PASS
- Product file modification:
  - none
- Supabase data write/delete:
  - none
- Publish:
  - none

Lovable plan artifact commit generated during plan mode:

`3a359d9c5a1294ac3127ff38975df87d0a76ea5f`

This is a planning artifact, not a product implementation commit.

## 3. Current Sidebar Feature Completion Table

| Sidebar Entry | Route | Completion | Current Status | Risk |
|---|---:|---:|---|---|
| 儀表板 | `/admin` | 90% | Read-only statistics and data source hints exist | Low |
| 客戶管理 | `/admin/customers` | 90% | Customer overview, detail, create customer, initial subscription, activity log patch, dialog scroll fix verified | Medium |
| 網站管理 | `/admin/sites` | 75% | Site list, detail, site leads/forms/notifications sub-entries exist | Medium |
| 方案與額度 | `/admin/plans` | 75% | Plan CRUD exists, but lacks controlled write test and archive | Medium |
| 表單管理 | `/admin/forms` | 75% | Cross-site form summary and site-level form management exist | Low |
| 名單管理 | `/admin/leads` | 90% | Owner assignment, filters, detail drawer, CSV and related stages verified and archived | Low |
| FAQ / AEO | `/admin/faq` | 25% | UI shell / design preview only; no formal FAQ table or CRUD yet | Low |
| 通知中心 | `/admin/notifications` | 75% | Provider status, logs, safe test and site notification settings exist; Email Router remains disabled | High |
| 嵌入碼 | `/admin/embeds` | 90% | Embed code generator, UTM, allowed-domain warning and sender-domain hints exist | Low |
| 使用量 | `/admin/usage` | 90% | Monthly usage, quota comparison and CSV exist; data baseline is still thin | Medium |
| 月報草稿 | `/admin/reports` | 90% | Customer/internal report draft generation and HTML copy exist; no report history persistence yet | Low |
| AI Hub | `/ai` | 75% | AI conversation flow and Gemini 2.5 Flash exist; multiple tools remain coming soon | Medium |

## 4. Current Data Baseline

Read-only counters confirmed during audit:

- `leads = 18`
- `notification_logs = 49`
- `email_send_log = 57`
- `customers = 7`
- `subscriptions = 7`
- `activity_logs = 101`
- `sites = 4`
- `forms = 7`
- `plans = 5`
- `ai_conversations = 2`
- `ai_messages = 4`
- `monthly_usage = 4`

This is the current post-test baseline after:

- Create Customer with Initial Subscription Sprint v0.1
- Activity Log Patch v0.1
- Controlled Write Test #2
- Test Data Retention Decision

## 5. Feature Classification

### 5.1 Mostly Complete / Usable MVP Features

The following features are considered mostly complete for MVP-level internal use:

- 儀表板
- 客戶管理
- 名單管理
- 嵌入碼
- 使用量
- 月報草稿

These are not necessarily production-final, but they already provide practical internal management value.

### 5.2 Functional but Lacking Controlled Verification / Archive

The following features exist and appear functional, but still need controlled validation or completion notes before broader use:

- 方案與額度
- 站台表單編輯器
- AI Hub conversation flow

### 5.3 Shell / Preview Only

The following feature is still mainly shell / preview:

- FAQ / AEO

Current state:

- UI shell exists
- JSON-LD / embed-code concept exists
- no formal FAQ table
- no FAQ CRUD
- no public embed route
- no controlled write test

### 5.4 High-Risk / Do Not Expand Without Founder Approval

The following should not be expanded or used broadly without explicit Founder approval:

- 通知中心
- `/admin/email-router-verify`
- Email Router / fallback / provider routing
- DLQ retry or resend flow

Current governance restriction remains:

- Email Router remains disabled
- Fallback remains disabled
- no email sending without explicit phased approval

## 6. Highest-Risk Gaps

### 6.1 Email Router Production Rollout Not Completed

Risk level: High

The notification center exists, but production rollout remains intentionally restricted.

No next step should activate Router, fallback, resend, DLQ retry or real email sending unless Founder explicitly authorizes a dedicated controlled test.

### 6.2 Plans and Quotas Have Write Capability but Lack Controlled Verification

Risk level: Medium

The plans module has CRUD capability and is connected to subscriptions / usage interpretation.

Because this affects subscription and billing-related interpretation, it should receive:

- Scope Dry-run
- Controlled Write Test
- Completion Note

before broader use.

### 6.3 Usage Data Baseline Is Thin

Risk level: Medium

`monthly_usage = 4`

The usage page appears mature, but its data baseline is still small.

Before using it for client-facing reporting, the source and completeness of monthly usage data should be clarified.

## 7. Recommended Next Sprint Sequence

### Sprint 1｜Monthly Report History & Deliverable Sprint v0.2

Recommended priority: High

Purpose:

- allow report drafts to be saved
- allow history review
- make monthly report output more deliverable-ready

Expected risk:

- Low to Medium

Important condition:

- likely requires a schema dry-run first, because it may need a new `report_drafts` table

Not authorized by this snapshot.

### Sprint 2｜Usage Data Integrity Sprint v0.1

Recommended priority: Medium

Purpose:

- clarify the source of `monthly_usage`
- add read-only data gap warnings
- add reconciliation hints
- improve confidence in report and quota interpretation

Expected risk:

- Low

Recommended because it can likely start read-only.

Not authorized by this snapshot.

### Sprint 3｜FAQ / AEO Foundation Sprint v0.1

Recommended priority: Medium

Purpose:

- move FAQ / AEO from shell to real data-backed feature
- introduce FAQ data model
- prepare future AEO / JSON-LD / embed capability

Expected risk:

- Medium

Important condition:

- must begin with schema dry-run
- no table creation without Founder approval

Not authorized by this snapshot.

### Sprint 4｜Plans and Quotas Controlled Verification Sprint v0.1

Recommended priority: Medium

Purpose:

- verify plan CRUD safely
- confirm subscription / usage dependency behavior
- archive a completion note

Expected risk:

- Medium

Recommended before broader plan editing.

Not authorized by this snapshot.

## 8. Recommended Immediate Decision

The recommended immediate next action is not a code sprint.

Recommended decision:

- archive this Current Progress Snapshot first
- use it as the baseline for selecting the next Sprint

After this snapshot is archived, the recommended next implementation planning item is:

`Monthly Report History & Deliverable Sprint v0.2｜Schema Dry-run`

## 9. Explicitly Not Authorized

This snapshot does not authorize:

- Publish
- production email sending
- Email Router activation
- fallback activation
- queue worker changes
- DLQ retry
- public form submit
- lead creation
- customer data write
- subscription data write
- activity log repair
- test data cleanup
- migration
- schema change
- RLS / GRANT change
- secrets change
- Lovable implementation
- GitHub code change

## 10. Completion Decision

This Current Progress Snapshot v0.1 is complete after:

- Founder approves this dry-run
- the snapshot is archived to GitHub

No Publish is authorized by this note.
