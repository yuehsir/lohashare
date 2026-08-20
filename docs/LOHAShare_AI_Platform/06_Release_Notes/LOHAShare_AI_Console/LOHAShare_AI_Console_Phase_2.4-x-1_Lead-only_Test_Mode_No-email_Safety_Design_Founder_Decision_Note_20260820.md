# LOHAShare AI Console｜Phase 2.4-x-1 Lead-only Test Mode / No-email Safety Design Founder Decision Note

Version: v0.1  
Status: Archived / Founder Decision Recorded / Lead-only No-email Design Direction Approved / Site-level Test Mode Preferred / Implementation Deferred / No Next Submission Authorized  
Date: 2026-08-20  
Project: LOHAShare AI Platform  
Module: LOHAShare AI Console / Email Notification / Embed Code Studio  
Phase: Phase 2.4-x-1  
Canonical Working Thread: Lovable 做網站後台  
Document Type: Founder Decision Note / Release Governance Note / Email Notification Safety Design Record / No-email Test Mode Design Decision  
GitHub Status: Written to GitHub / Committed / No PR  
Prepared For: Founder Review / DocOps Archive  

Status Before Archive: Draft｜Founder Review Required｜Not Yet Archived  
Post-Archive Status: Archived / Founder Decision Recorded / Lead-only No-email Design Direction Approved / Site-level Test Mode Preferred / Implementation Deferred / No Next Submission Authorized

---

## 1. Decision Summary

Founder reviewed the need for a Lead-only Test Mode / No-email Safety Design after the Phase 3-B-2 embedded form submission test unexpectedly sent legacy notification emails.

Founder accepts the following decision:

```text
Decision: Approve Design Direction / Defer Implementation
```

This decision approves the design direction for a future no-email lead submission testing mechanism, but does not authorize implementation.

The key design principle is:

```text
Future lead-only tests must be able to create leads without sending notification emails, but this behavior must be controlled, auditable, and not triggerable by arbitrary public visitors.
```

---

## 2. Related Governance Sources

This decision follows two archived records.

### 2.1 Phase 3-B-2 Findings

```text
Phase 3-B-2｜Controlled Test Form Submission
Status: Archived / Partial Pass with Findings / Lead Created / Attribution Verified / Source-UTM Gap / Unexpected Legacy Email Sent / No Next Submission Authorized / Metadata Corrected
```

Key findings:

- One embedded form submission successfully created a lead.
- Lead attribution to customer / site / form was verified.
- Source / UTM did not trace back to the Duda / Oasis parent page.
- Three legacy notification emails were sent unexpectedly.
- Sender was notify@notify.lohashare.com.
- Resend / notify@send.lohashare.com was not used.
- Router and Fallback remained disabled.
- Router disabled did not prevent legacy notification sending.
- No second submission was authorized.

### 2.2 Phase 2.4-x Founder Decision

```text
Phase 2.4-x｜Legacy / Router Sender Alignment Founder Review
Status: Archived / Founder Decision Recorded / Short-term Safety Rule Adopted / Implementation Deferred / No Next Submission Authorized / Metadata Corrected
```

Key decision:

```text
Router disabled must not be interpreted as no-email.
```

Corrected operational interpretation:

```text
Router disabled = the new Email Provider Router is disabled; the system may still use the legacy Lovable Email path.
```

---

## 3. Problem Statement

The current embedded form submission flow can create leads successfully, but when site notification settings are enabled and recipients exist, the system may also send notification emails.

Current known behavior:

```text
Public embedded form submission
→ lead creation
→ dispatchLeadNotification
→ queue
→ legacy Lovable Email path if Router disabled
→ notification email sent
```

Therefore, future lead-only tests need a controlled way to avoid sending email.

The design challenge is:

```text
How can LOHAShare safely test embedded form submissions and lead creation without sending notification emails, while preventing public misuse or accidental suppression of real customer notifications?
```

---

## 4. Design Boundary

This phase is a design decision only.

This decision does not authorize:

- Code changes.
- Database schema changes.
- Migration creation.
- RLS changes.
- Lovable Build.
- Supabase modification.
- Duda / Oasis modification.
- Secret changes.
- Sender changes.
- Router enablement.
- Fallback enablement.
- Email sending.
- Second form submission.
- Phase 3-B-3 execution.
- Phase 3-C execution.
- Phase 2.4-b execution.
- Customer rollout.

---

## 5. Rejected or Not Recommended Approaches

### 5.1 Public URL Parameter Only

The following approach is not recommended:

```text
?no_email=true
?suppress_email=true
?test_mode=true
```

Reason:

If public visitors can suppress notification emails by editing an iframe URL or public form URL, then real lead notifications could be bypassed.

Risks:

- Customers may not receive real lead notifications.
- Leads may be silently created without alerting anyone.
- Public users may intentionally or accidentally suppress notifications.
- Test behavior may leak into production behavior.
- Debugging notification delivery becomes harder.

Conclusion:

```text
No-email behavior must not be controlled by an unprotected public URL parameter.
```

### 5.2 Manual Recipient Clearing as the Only Method

Manually clearing recipients before each test is not recommended as the long-term design.

Examples:

```text
clear lohashare_recipients
clear email_recipients
disable notify_lohashare
```

Reason:

This approach is fast but fragile.

Risks:

- Operator may forget to clear recipients.
- Operator may forget to restore recipients.
- Formal notifications may be accidentally disabled.
- No clear suppression audit record exists.
- Multi-operator consistency is weak.

Conclusion:

```text
Manual recipient control may remain a short-term safety rule, but should not be the long-term product design.
```

### 5.3 Immediately Disabling Legacy Notification Globally

Global legacy notification shutdown is not recommended under this decision.

Reason:

The system has not yet completed Email Router production rollout, sender alignment, fallback validation, unsubscribe validation, or production monitoring design.

Conclusion:

```text
Legacy notification should not be globally disabled by this decision.
```

---

## 6. Design Options Reviewed

### Option A｜Manual Pre-test Safety Rule

Description:

Before any embedded form submission test, operators must check:

- notification_settings.enabled
- notify_lohashare
- lohashare_recipients
- email_recipients
- Router status
- Fallback status
- Whether email is expected or prohibited
- Founder authorization for the expected behavior

Decision:

```text
Accepted as short-term rule.
```

Rationale:

- Fastest available safety measure.
- Requires no code change.
- Reduces risk before the next test.
- Keeps Phase 2.4-b, Phase 3-B-3, and Phase 3-C separate.

Limitation:

```text
This is procedural safety, not system-level safety.
```

### Option B｜Site-level Test Mode

Description:

Create a site-level setting that allows a specific site to enter a lead-only test mode.

Example future concept:

```text
lead_submission_test_mode_enabled = true
suppress_notification_email_for_test = true
```

Expected behavior:

```text
Embedded form submission
→ lead created
→ lead marked as test / internal validation
→ notification email suppressed
→ suppression audit record created
```

Decision:

```text
Accepted as the preferred near-term design direction.
```

Rationale:

- Easier to understand than token-based flow.
- Suitable for Duda / Oasis hidden test page validation.
- Controlled from admin / operator UI.
- Avoids relying on public URL parameters.
- Better fit for current MVP stage.

Required safeguards:

- Admin / authorized operator only.
- Clear warning UI.
- Explicit confirmation before enabling.
- Visible status while enabled.
- Audit log for enable / disable.
- Suppression record for affected submissions.
- Formal reminder to disable before production launch.

### Option C｜Admin-generated Test Token

Description:

Admin generates a temporary or one-time test token and appends it to the iframe or test URL.

Example future concept:

```text
https://app.lohashare.com/embed/forms/formtest?test_token=xxxx
```

Expected behavior:

- Backend validates token.
- Lead is created as test or internal validation.
- Notification email is suppressed.
- Suppression is logged.
- Token expires or can be revoked.

Decision:

```text
Accepted as a future medium-term option, not preferred as first MVP implementation.
```

Rationale:

- More secure than public URL parameters.
- Better for customer onboarding.
- Supports time-limited or one-time validation.
- More complex than site-level test mode.

### Option D｜Form-level Test Form / Sandbox Form

Description:

Mark a form as test-only or sandbox.

Example future concept:

```text
form_mode = test
is_test_form = true
```

Expected behavior:

- Test form creates test lead.
- Test lead does not trigger formal notification.
- Test status is visible in lead list.
- Test form is not used for customer-facing production.

Decision:

```text
Accepted as an alternative design candidate, not selected as the preferred near-term direction.
```

Rationale:

This may be useful later, but the current risk emerged at site / embed validation level. Site-level mode is more directly aligned with the Duda / Oasis hidden test page workflow.

### Option E｜Notification Suppression Audit-only Mode

Description:

Instead of only saying “no email,” the system explicitly records that notification was intentionally suppressed.

Example future concepts:

```text
notification_status = suppressed
suppression_reason = lead_only_test_mode
notification_suppressed = true
```

Decision:

```text
Accepted as required governance concept for any future implementation.
```

Rationale:

- Avoids confusion between “email failed” and “email intentionally suppressed.”
- Improves auditability.
- Helps support future customer onboarding.
- Supports governance and debugging.

---

## 7. Founder Decision

Founder approves the following design direction:

```text
Decision: Approve Design Direction / Defer Implementation
```

Founder decision details:

- Lead-only Test Mode / No-email Safety Design is necessary.
- Short-term safety remains manual pre-test notification settings and recipient checks.
- No-email test behavior must not be controlled by an unprotected public URL parameter.
- Site-level Test Mode is the preferred near-term design direction.
- Admin-generated Test Token may be considered as a medium-term enhancement.
- Notification Suppression Audit-only Mode should be included in any future implementation design.
- Future no-email testing must create an auditable suppression record.
- This phase approves design direction only.
- This phase does not authorize implementation.
- This phase does not authorize another embedded form submission.
- This phase does not authorize Phase 3-B-3.
- This phase does not authorize Phase 3-C.
- This phase does not authorize Phase 2.4-b.

---

## 8. Required Safety Principles for Future Implementation

Any future implementation of Lead-only Test Mode must follow these principles:

- No public visitor can arbitrarily suppress notification emails.
- No-email behavior must be controlled by admin / authorized operator action.
- Enabling no-email mode must require explicit confirmation.
- Active no-email mode must be visibly shown in the admin UI.
- No-email mode must be auditable.
- Suppressed notifications must be distinguishable from failed notifications.
- Suppression reason must be recorded.
- Affected lead IDs must be traceable.
- Recipient count suppressed should be recordable if feasible.
- No-email mode must not silently affect production customer flows.
- Formal launch checks must confirm no-email mode is disabled unless explicitly intended.

---

## 9. Recommended Future UI Location

Preferred UI location:

```text
網站管理 > 網站詳情 > 網站通知設定
```

Reason:

Whether notification emails are sent is a site-level notification governance decision, not a public form URL decision.

Suggested future label:

```text
Lead-only Test Mode｜只建立名單，不寄通知
```

Suggested warning text:

```text
啟用後，此網站的測試表單送出將只建立 lead，不寄出 Email Notification。請僅用於內部測試、嵌入驗證或客戶 onboarding 前測試。正式上線前必須關閉。
```

Suggested confirmation text:

```text
我了解啟用此模式期間，新名單通知將被抑制，不會寄信給 LOHAShare 或客戶收件人。
```

---

## 10. Recommended Future Data / Log Requirements

A future implementation should consider recording:

- site_id
- test_mode_enabled
- enabled_by
- enabled_at
- disabled_by
- disabled_at
- suppression_reason
- affected_lead_id
- notification_suppressed
- recipient_count_suppressed
- suppression_created_at
- suppression_source
- Related audit log event.

Recommended log semantics:

```text
notification_status = suppressed
suppression_reason = lead_only_test_mode
```

---

## 11. Relationship to Other Phases

This phase does not replace or authorize other phases.

| Phase | Relationship |
|---|---|
| Phase 2.4-x-1 | Designs lead-only no-email safety |
| Phase 2.4-b | Production Safe Test Only remains paused |
| Phase 2.4-x-2 | Future legacy / Router sender alignment design |
| Phase 3-B-3 | Future embed UTM / source attribution enhancement |
| Phase 3-C | Future form field type expansion |

Current status of Phase 2.4-b:

```text
Not Authorized / No Execution
```

---

## 12. Explicit Non-Authorizations

This Founder Decision does not authorize:

- Lovable Build.
- Lovable code modification.
- Supabase modification.
- Database migration.
- RLS change.
- Secret change.
- Duda / Oasis modification.
- Sender change.
- Legacy notification shutdown.
- Router enablement.
- Fallback enablement.
- Email sending.
- Second embedded form submission.
- Phase 3-B-3 execution.
- Phase 3-C execution.
- Phase 2.4-b execution.
- GitHub code modification.
- Customer rollout.

---

## 13. Recommended Follow-up

Recommended next design phase candidate:

```text
Phase 2.4-x-1A｜Lead-only Test Mode Scope Definition
```

Purpose:

Define exact MVP scope, required fields, admin UI behavior, audit log behavior, and suppression logging before any Lovable Build Prompt is produced.

This next step should also remain design-only unless Founder separately authorizes implementation planning.

---

## 14. Recommended Archive Status

Recommended current status before archive:

```text
Draft｜Founder Review Required
```

Recommended post-archive status:

```text
Archived / Founder Decision Recorded / Lead-only No-email Design Direction Approved / Site-level Test Mode Preferred / Implementation Deferred / No Next Submission Authorized
```

---

## 15. Recommended File Name

Recommended Markdown filename:

```text
LOHAShare_AI_Console_Phase_2.4-x-1_Lead-only_Test_Mode_No-email_Safety_Design_Founder_Decision_Note_20260820.md
```

Recommended archive JSON filename:

```text
LOHAShare_AI_Console_Phase_2.4-x-1_Lead-only_Test_Mode_No-email_Safety_Design_Founder_Decision_Note_20260820.archive.json
```

Recommended path:

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/
```

---

## 16. Recommended Commit Message

Recommended commit message:

```text
docs: archive phase 2.4-x-1 lead-only no-email safety design decision
```

---

## 17. Final Status

```text
Phase 2.4-x-1｜Lead-only Test Mode / No-email Safety Design
Status: Founder Decision Drafted / Design Direction Approved / Site-level Test Mode Preferred / Implementation Deferred / Ready for DocOps Archive Dry-run
```

---

## 18. Next Step

Next recommended action:

```text
Submit this Founder Decision Note to LOHAShare AI Platform 文件治理與 GitHub 自動化總控 for archive dry-run only.
```

Do not authorize implementation, another form submission, Phase 3-B-3, Phase 3-C, or Phase 2.4-b until this decision is reviewed and archived.
