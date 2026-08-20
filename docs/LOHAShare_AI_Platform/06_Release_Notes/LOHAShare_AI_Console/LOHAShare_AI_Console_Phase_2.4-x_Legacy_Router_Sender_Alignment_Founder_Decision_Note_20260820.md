# LOHAShare AI Console｜Phase 2.4-x Legacy / Router Sender Alignment Founder Decision Note

Version: v0.1  
Status: Archived / Founder Decision Recorded / Short-term Safety Rule Adopted / Implementation Deferred / No Next Submission Authorized  
Date: 2026-08-20  
Project: LOHAShare AI Platform  
Module: LOHAShare AI Console / Email Notification / Embed Code Studio  
Phase: Phase 2.4-x  
Canonical Working Thread: Lovable 做網站後台  
Document Type: Founder Decision Note / Release Governance Note / Email Notification Governance Record  
GitHub Status: Written to GitHub / Committed / No PR  
Prepared For: Founder Review / DocOps Archive  

Status Before Archive: Draft｜Founder Review Required｜Not Yet Archived  
Post-Archive Status: Archived / Founder Decision Recorded / Short-term Safety Rule Adopted / Implementation Deferred / No Next Submission Authorized

---

## 1. Decision Summary

Founder reviewed the Phase 3-B-2 Controlled Test Form Submission Findings and accepted the recommended short-term safety decision for Legacy / Router Sender Alignment.

The key finding is:

```text
Router disabled does not mean no-email.
```

During Phase 3-B-2, Founder authorized one controlled embedded form submission with the intended boundary of:

```text
Lead creation only / No Email / No Email Notification / No Router or Fallback enablement
```

However, after the lead was created, three legacy notification emails were sent through the existing Lovable Emails / Mailgun-managed legacy path.

The sender was:

```text
notify@notify.lohashare.com
```

This was not the Resend sender:

```text
notify@send.lohashare.com
```

Therefore, Founder accepts the decision to adopt a short-term safety rule, defer implementation, and plan a later no-email test mode / sender alignment design.

---

## 2. Related Findings Source

This decision is based on the archived findings from:

```text
Phase 3-B-2｜Controlled Test Form Submission
Status: Archived / Partial Pass with Findings / Lead Created / Attribution Verified / Source-UTM Gap / Unexpected Legacy Email Sent / No Next Submission Authorized / Metadata Corrected
```

Key Phase 3-B-2 confirmed facts:

- One test lead was created successfully.
- Lead attribution to customer / site / form was confirmed correct.
- Source / UTM attribution did not trace back to the Duda / Oasis parent page.
- Three emails were sent unexpectedly.
- Sender was `notify@notify.lohashare.com`.
- Provider path was Legacy Lovable Emails / Mailgun-managed path.
- Resend / send.lohashare.com was not used.
- Router and Fallback remained disabled.
- Router disabled did not suppress legacy notification sending.
- No second submission was authorized.

---

## 3. Problem Statement

The current system has two different email sending paths and two different operational meanings.

### 3.1 Resend / Router Governance Path

The intended formal email provider strategy is:

- Primary provider: Resend
- Sender: `notify@send.lohashare.com`
- Domain: `send.lohashare.com`
- Router flag: `EMAIL_PROVIDER_ROUTER_ENABLED`
- Fallback: Zoho SMTP, not yet enabled

This is the direction of the Phase 2.4 production router rollout.

### 3.2 Legacy Lovable Email Path

The actual email triggered during Phase 3-B-2 used:

- Legacy Lovable Emails / Mailgun-managed path
- Sender: `notify@notify.lohashare.com`

Lovable read-only investigation confirmed the path:

```text
/api/public/forms/submit
→ dispatchLeadNotification
→ enqueue_email('transactional_emails')
→ /lovable/email/queue/process
→ sendLovableEmail
→ Legacy Lovable Emails / Mailgun-managed path
```

The legacy path was triggered because:

```text
notification_settings.enabled = true
notify_lohashare = true
lohashare_recipients = {richard.yueh@lohashare.com}
email_recipients = {yuehsir168@gmail.com, yuehsir.prc@gmail.com}
```

---

## 4. Core Risk

The core risk is not only that an email was sent.

The larger governance risk is:

```text
Operators may believe that Router disabled means no email, while the system may still send emails through the legacy path.
```

| Risk | Description | Severity |
|---|---|---|
| Test boundary failure | A no-email test may still send email | High |
| Sender inconsistency | Some emails use notify@notify.lohashare.com, while formal strategy expects notify@send.lohashare.com | High |
| Router semantics ambiguity | Router disabled currently means “use legacy path,” not “disable email” | High |
| Customer rollout risk | Future customer forms may trigger unexpected notifications | High |
| Compliance / trust risk | Test or customer data may be emailed to unintended recipients | High |
| Debugging difficulty | Legacy provider path may leave provider_used blank / NULL | Medium-high |

---

## 5. Founder Decision

Founder accepts the following decision:

```text
Decision: Adopt Short-term Safety Rule / Defer Implementation
```

### 5.1 Short-term Safety Rule

For any future embedded form submission test:

1. Router disabled must not be interpreted as no-email.
2. Before any lead-only test, the site’s notification settings and recipients must be checked.
3. If the test objective is no-email, the test must not proceed unless one of the following is true:
   - The site notification settings are temporarily disabled.
   - Relevant recipients are temporarily cleared or disabled.
   - A safe no-email test mechanism exists.
   - Founder explicitly accepts and authorizes that the test will send email.
4. No additional embedded form submission is authorized by this decision.
5. No Email Router production safe test is authorized by this decision.

### 5.2 Implementation Deferred

This decision does not authorize code changes.

Specifically, this decision does not authorize:

- Modifying Lovable code.
- Modifying Supabase schema.
- Adding migrations.
- Modifying RLS.
- Modifying secrets.
- Modifying Resend.
- Modifying Zoho fallback.
- Modifying Duda / Oasis.
- Changing sender behavior.
- Disabling legacy notifications.
- Enabling Router.
- Sending additional emails.

---

## 6. Corrected Operational Interpretation

The following interpretation is now deprecated:

```text
Router disabled = no email
```

The corrected interpretation is:

```text
Router disabled = the new Email Provider Router is disabled; the system may still use the legacy Lovable Email path.
```

The following statement is also required for future tests:

```text
To guarantee no-email behavior, notification settings or recipients must be controlled, or a dedicated no-email test mode must exist.
```

---

## 7. Decision Options Reviewed

### Option A｜Short-term Safety Control

Description:

Keep the legacy path for now, but require notification_settings / recipient checks before any lead-only submission test.

Decision:

```text
Accepted as short-term rule.
```

Reason:

- Fastest way to prevent accidental repeat emails.
- Does not require code changes.
- Preserves current system state.
- Avoids mixing Email Router production rollout with Embed testing.

Limitations:

- Relies on operator discipline.
- Does not solve sender inconsistency.
- Does not create a true no-email test mode.

### Option B｜Lead-only Test Mode / No-email Mode

Description:

Design a controlled test mode that allows lead creation without notification email.

Decision:

```text
Accepted as future design direction, not authorized for implementation yet.
```

Possible future phase:

```text
Phase 2.4-x-1｜Lead-only Test Mode / No-email Safety Design
```

Notes:

This must be designed carefully. Public URL parameters should not allow arbitrary visitors to suppress notifications unless protected by admin-generated token, site-level setting, or another safe mechanism.

### Option C｜Unify Lead Notification Through Router / Resend

Description:

Route lead notification through the Email Provider Router and align sender to `notify@send.lohashare.com`.

Decision:

```text
Accepted as long-term direction, not authorized for implementation yet.
```

Possible future phase:

```text
Phase 2.4-x-2｜Legacy / Router Sender Alignment Design
```

Relation to existing phase:

```text
Phase 2.4-b remains paused and not authorized.
```

### Option D｜Temporarily Disable Legacy Notification

Description:

Temporarily disable `notification_settings.enabled` or recipients to prevent additional emails.

Decision:

```text
Allowed only under a separate explicit Founder authorization for a specific test.
```

This decision note does not authorize immediate disabling.

---

## 8. Short-term Safety Policy

Effective immediately for future tests:

```text
Any embedded form submission test must be preceded by a notification settings check.
```

Required checks before any future test submission:

- Confirm `notification_settings.enabled`.
- Confirm `notify_lohashare`.
- Confirm `lohashare_recipients`.
- Confirm `email_recipients`.
- Confirm Router status.
- Confirm Fallback status.
- Confirm whether email is expected or prohibited.
- Confirm Founder authorization for the expected email behavior.

If no-email is required, the test must stop unless:

- Notifications are disabled for the target site; or
- Recipients are safely disabled / cleared; or
- A no-email test mode exists; or
- Founder explicitly changes the test boundary to allow email.

---

## 9. Current Non-Authorization

This Founder Decision does not authorize:

- Second embedded form submission.
- Phase 3-B-3 execution.
- Phase 3-C execution.
- Phase 2.4-b execution.
- Email sending.
- Router enablement.
- Fallback enablement.
- Legacy sender change.
- Sender unification.
- Lovable Build.
- Supabase modification.
- Duda / Oasis modification.
- GitHub code modification.
- Customer rollout.

---

## 10. Follow-up Phases

Recommended follow-up candidates:

```text
Phase 2.4-x-1｜Lead-only Test Mode / No-email Safety Design
```

Purpose:

Design a safe way to allow lead-only test submissions without sending notification emails.

Potential design questions:

- Should no-email mode be an admin-only UI option?
- Should no-email mode require a temporary token?
- Should no-email mode be limited to test forms / test sites?
- Should notification suppression be logged?
- Should the public submit API accept any suppression parameter?
- How should abuse be prevented?

```text
Phase 2.4-x-2｜Legacy / Router Sender Alignment Design
```

Purpose:

Align lead notification sender behavior with the Resend / Router strategy.

Potential design questions:

- Should legacy Lovable Emails remain available?
- Should all lead notifications go through Router?
- Should `notify@notify.lohashare.com` be deprecated?
- Should `notify@send.lohashare.com` become the unified sender?
- How should `provider_used` be logged?
- How should fallback be represented?
- What is the rollback strategy?

```text
Phase 3-B-3｜Embed UTM / Source Attribution Enhancement
```

Purpose:

Fix Duda / Oasis parent-page attribution loss in iframe embedded forms.

This is related to Phase 3-B-2 but should remain separate from Email Sender Alignment.

```text
Phase 3-C｜Form Field Type Expansion
```

Purpose:

Expand Form Builder field types for practical lead qualification.

This is a product UX enhancement and should remain separate from Email Sender Alignment.

---

## 11. Recommended Status

Recommended current status before archive:

```text
Draft｜Founder Review Required
```

Recommended post-archive status:

```text
Archived / Founder Decision Recorded / Short-term Safety Rule Adopted / Implementation Deferred / No Next Submission Authorized
```

---

## 12. Recommended File Name

Recommended Markdown filename:

```text
LOHAShare_AI_Console_Phase_2.4-x_Legacy_Router_Sender_Alignment_Founder_Decision_Note_20260820.md
```

Recommended archive JSON filename:

```text
LOHAShare_AI_Console_Phase_2.4-x_Legacy_Router_Sender_Alignment_Founder_Decision_Note_20260820.archive.json
```

Recommended path:

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/
```

---

## 13. Recommended Commit Message

Recommended commit message:

```text
docs: archive phase 2.4-x legacy router sender alignment decision
```

---

## 14. Final Status

```text
Phase 2.4-x｜Legacy / Router Sender Alignment Founder Review
Status: Founder Decision Drafted / Short-term Safety Rule Accepted / Implementation Deferred / Ready for DocOps Archive
```

---

## 15. Next Step

Next recommended action:

```text
Archive this Founder Decision Note only.
```

Do not authorize implementation, second form submission, Phase 3-B-3, Phase 3-C, or Phase 2.4-b until this decision is reviewed and archived.
