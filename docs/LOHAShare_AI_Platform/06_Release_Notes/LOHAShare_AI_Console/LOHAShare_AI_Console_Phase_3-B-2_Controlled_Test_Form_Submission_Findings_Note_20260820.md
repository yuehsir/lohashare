# LOHAShare AI Console｜Phase 3-B-2 Controlled Test Form Submission Findings Note

Version: v0.1  
Status: Archived / Partial Pass with Findings / Lead Created / Attribution Verified / Source-UTM Gap / Unexpected Legacy Email Sent / No Next Submission Authorized  
Date: 2026-08-20  
Project: LOHAShare AI Platform  
Module: LOHAShare AI Console / Embed Code Studio  
Phase: Phase 3-B-2  
Canonical Working Thread: Lovable 做網站後台  
Document Type: Findings Note / Release Governance Note / Controlled Field Test Record  
GitHub Status: Written to GitHub / Committed / No PR  
Prepared For: DocOps / GitHub Archive  

Status Before Archive: Draft｜Founder Review Required｜Not Yet Archived  
Post-Archive Status: Archived / Partial Pass with Findings / Lead Created / Attribution Verified / Source-UTM Gap / Unexpected Legacy Email Sent / No Next Submission Authorized  

---

## 1. Findings Summary

Phase 3-B-2 — Controlled Test Form Submission was executed once under Founder authorization.

The controlled test form submission successfully created a lead in LOHAShare AI Console, and Lovable read-only investigation later confirmed that the lead was correctly attributed to the expected customer, site, and form.

However, this phase also produced important findings:

1. Source / UTM attribution did not trace back to the Duda / Oasis parent page.
2. Three legacy notification emails were sent despite the original test boundary stating no email.
3. The email sender was `notify@notify.lohashare.com`, not `notify@send.lohashare.com`.
4. The email path was Legacy Lovable Emails / Mailgun-managed path, not Resend.
5. Router and Fallback remained disabled.
6. The existing legacy notification path is not suppressed merely by keeping the Email Provider Router disabled.
7. Form Builder field types are currently limited and do not yet support select / dropdown / radio / checkbox / multi-select / list.

Therefore, this phase should be recorded as:

```text
Partial Pass with Findings / Lead Created / Attribution Verified / Source-UTM Gap / Unexpected Legacy Email Sent / No Next Submission Authorized
```

This document is a findings note, not a clean completion note.

---

## 2. Governance Status

Current governance status:

```text
Phase 3-B-2｜Controlled Test Form Submission
Status: Partial Pass with Findings / Lead Created / Attribution Verified / Source-UTM Gap / Unexpected Legacy Email Sent
```

Related prior status:

```text
Phase 3-B-1｜Duda / Oasis Embed Display Test
Status: Archived / iframe Display Verified / No Form Submission / No Email / No Router Enabled / Metadata Corrected
```

Related paused phase:

```text
Phase 2.4-b｜Production Safe Test Only
Status: Read-only Preflight Completed / BLOCKER-1 Cleared / Not Authorized / No Execution
```

Phase 2.4-b remained paused and was not executed during this phase.

---

## 3. Founder Authorization Boundary

Founder authorized one controlled test form submission only.

Authorized scope:

- Submit one internal test form.
- Allow creation of one test lead.
- Allow read-only verification in LOHAShare AI Console.
- Keep Email Notification out of scope.
- Keep Router disabled.
- Keep Fallback disabled.
- Do not modify Lovable.
- Do not modify Supabase.
- Do not modify Duda / Oasis.
- Do not perform a second submission.

Original authorization explicitly stated:

```text
只允許建立一筆測試 lead，不寄信、不測 Email Notification、不啟用 Router / Fallback、不修改系統。
```

Actual result differed from the no-email expectation because the existing legacy lead notification path sent emails automatically after lead creation.

---

## 4. Test Page and Submission Information

Duda / Oasis test page:

```text
https://www.lohashare.com/ai-console-form-test
```

Test page status:

```text
Published as a hidden / non-menu test page
```

Form submission count:

```text
One submission only
```

Test data used:

```text
姓名：LOHAShare Embed Test
Email：richard.yueh@lohashare.com
電話：0900000000
訊息：Phase 3-B-2 Duda/Oasis controlled embed form submission test. Internal test only.
```

Founder reported:

| Item | Result |
|---|---|
| Test page opened | Yes |
| iframe displayed normally | Yes |
| Specified test data used | Yes |
| Submitted only once | Yes |
| Frontend success message shown | Yes |
| Error message shown | No |
| New lead visible in LOHAShare AI Console | Yes |
| Duplicate submission | No |
| Lovable / Supabase / Duda / Oasis modified | No |
| Publish performed during this phase | No |
| Added to main menu / footer | No |
| Initial conclusion | Conditional pass |

---

## 5. Lead Creation Result

Lovable read-only investigation confirmed that the test lead was created.

Lead details:

| Field | Value |
|---|---|
| lead id | `65faa43b-c7ab-488d-9277-43ef0667b913` |
| created_at | `2026-08-20 02:56:59 UTC` |
| Taipei time | `2026-08-20 10:56` |
| customer_id | `bd174782-6591-4f67-a4ad-4fdc72637fb1` |
| site_id | `169aa3ac-644c-4ad9-8cb1-7c4e172b9f1b` |
| form_id | `95818bbc-00ae-4fb6-af61-d5c7c88368e0` |
| form slug | `formtest` |
| customer name | `LOHAShare 測試客戶` |
| site name | `LOHAShare 官網測試站` |
| primary_domain | `www.lohashare.com` |
| form name | `表單測試` |

Attribution result:

```text
customer / site / form attribution: Confirmed correct
```

This resolves the Founder’s earlier UI-level uncertainty about whether the lead belonged to the correct customer, site, and form.

---

## 6. Source / UTM Attribution Finding

Lovable read-only investigation found that source / UTM attribution was not preserved as expected.

Database values:

```text
source_landing_url: NULL
source_type: NULL
source_platform: NULL
source_channel: NULL
source_campaign_name: NULL
utm_source: NULL
utm_medium: NULL
utm_campaign: NULL
utm_content: NULL
utm_term: NULL
```

Observed values:

```text
source_page_url = https://app.lohashare.com/embed/forms/formtest
source_referer = https://app.lohashare.com/embed/forms/formtest
```

Duda / Oasis parent page was not captured:

```text
https://www.lohashare.com/ai-console-form-test
```

Finding:

```text
The embed flow currently traces the iframe URL, not the Duda / Oasis parent page URL.
```

Interpretation:

This is likely an iframe attribution limitation. The embedded form cannot automatically infer the parent Duda page unless the iframe URL includes UTM / source query parameters or the embed architecture later supports parent-page communication, such as postMessage.

Recommended follow-up phase:

```text
Phase 3-B-3｜Embed UTM / Source Attribution Enhancement
```

---

## 7. Unexpected Legacy Email Finding

Although the original Phase 3-B-2 authorization excluded email testing, three emails were sent after the lead was created.

Email recipients:

- `richard.yueh@lohashare.com`
- `yuehsir168@gmail.com`
- `yuehsir.prc@gmail.com`

Lovable confirmed:

```text
email_send_log: 3 new rows
notification_logs: 3 new rows
status: sent
is_test: false
```

Latest email_send_log example:

| Field | Value |
|---|---|
| id | `a7c4f444-…0a972b5a` |
| created_at | `2026-08-20 02:57:37Z` |
| status | `sent` |
| provider_used | `NULL` |
| recipient_email | `richard.yueh@lohashare.com` |
| message_id | `46992779-…` |

Latest notification_logs example:

| Field | Value |
|---|---|
| id | `d612e534-…` |
| created_at | `2026-08-20 02:57:01Z` |
| status | `sent` |
| recipient | `richard.yueh@lohashare.com` |
| recipient_kind | `lohashare` |
| channel | `email` |
| is_test | `false` |
| lead_id | `65faa43b-c7ab-488d-9277-43ef0667b913` |

Sender confirmed:

```text
notify@notify.lohashare.com
```

Subject pattern:

```text
[新名單] LOHAShare 官網測試站 - 表單測試
```

---

## 8. Email Provider / Path Finding

Lovable confirmed that the email was not sent through Resend and not sent through `send.lohashare.com`.

Confirmed path:

```text
/api/public/forms/submit
→ dispatchLeadNotification
→ enqueue_email('transactional_emails')
→ /lovable/email/queue/process
→ sendLovableEmail
→ Legacy Lovable Emails / Mailgun-managed path
```

Relevant sender configuration:

```text
src/lib/notifications.server.ts
FROM_HEADER = LOHAShare 通知 <notify@notify.lohashare.com>
sender_domain = notify.lohashare.com
```

Provider path:

```text
Legacy Lovable Emails / Mailgun-managed path
```

Confirmed not used:

- Resend
- send.lohashare.com
- notify@send.lohashare.com
- Email Provider Router path

Router / Fallback status:

```text
EMAIL_PROVIDER_ROUTER_ENABLED = false
EMAIL_FALLBACK_ENABLED = false / unset
Router UI = disabled
Fallback UI = disabled
```

Finding:

```text
Router disabled does not mean no email. With Router disabled, the queue consumer uses the legacy Lovable Email path.
```

Therefore, Phase 3-B-2 cannot be described as “No Email.”

---

## 9. Why Email Was Sent

Lovable confirmed the reason:

```text
The existing lead notification design sends email after lead creation when site notification settings are enabled.
```

Relevant conditions:

```text
notification_settings.enabled = true
notify_lohashare = true
lohashare_recipients = {richard.yueh@lohashare.com}
email_recipients = {yuehsir168@gmail.com, yuehsir.prc@gmail.com}
```

Explanation:

Because site notification settings were enabled, lead creation triggered the legacy notification dispatch. Since the Router was disabled, the queue consumer used the legacy Lovable Email path.

This appears to be consistent with the existing system design.

---

## 10. No-Email Boundary Failure

Original test boundary:

- No email.
- No Email Notification test.
- No Router / Fallback enablement.

Actual result:

```text
Three emails sent through legacy Lovable Emails.
```

Conclusion:

```text
Phase 3-B-2 cannot claim No Email.
```

Correct wording:

```text
Unexpected Legacy Email Sent
```

Future no-email lead-creation testing would require one of the following before submission:

- Temporarily disable the site’s `notification_settings.enabled`.
- Temporarily clear or disable `lohashare_recipients`.
- Temporarily clear or disable customer `email_recipients`.
- Add a test-mode no-email mechanism.
- Explicitly accept that the test will send email and authorize it.

No such change was performed during this phase.

---

## 11. Form Builder Field Type Gap

Founder also observed that the current Form Builder does not provide flexible input types for “需求類型” or custom fields.

Lovable read-only investigation confirmed:

Currently supported field types:

Fixed fields:

- name
- email
- phone
- company
- need type
- message

Custom fields:

- text
- email
- tel
- textarea

Custom field limit:

- 3

Not supported:

- select / dropdown
- radio
- checkbox
- multi-select
- list
- need_type options editor UI

Lovable noted that the DB has `field_need_type_options`, but the editor does not currently provide an options input UI and the public form does not render a dropdown for it.

Recommended follow-up phase:

```text
Phase 3-C｜Form Field Type Expansion
```

Potential scope:

- Need type options editor.
- Select / dropdown.
- Radio.
- Checkbox.
- Multi-select.
- Custom field limit review.
- Embed-side rendering.
- Submit validation update.

No implementation was performed during this investigation.

---

## 12. Blockers

Current blockers before any additional embedded form submission:

1. Additional submissions will send real emails unless notification settings are changed or a no-email test mechanism is added.
2. Legacy sender `notify@notify.lohashare.com` remains active and inconsistent with the Resend sender strategy `notify@send.lohashare.com`.
3. Source / UTM does not currently trace to the Duda / Oasis parent page.
4. The current UI does not visibly expose customer / site / form attribution to the Founder, requiring read-only investigation to confirm.
5. Form Builder field type flexibility is insufficient for selectable “需求類型” use cases.

---

## 13. Risks

Known risks:

- Future tests may unintentionally send email to external Gmail recipients.
- Router disabled may be misunderstood as “no email,” but currently means “legacy email path.”
- If `notify.lohashare.com` or Lovable Emails / Mailgun path is later disabled, legacy notifications may fail.
- Without explicit UTM / source query parameters, Duda / Oasis parent-page attribution may be lost.
- The hidden test page is accessible by direct URL.
- Field type limitations may reduce usefulness of embedded forms for real qualification workflows.

---

## 14. Deferred Follow-up Phases

Recommended follow-up phases:

```text
Phase 3-B-3｜Embed UTM / Source Attribution Enhancement
```

Purpose:

Ensure iframe embed codes can preserve Duda / Oasis page attribution through explicit UTM / source query parameters or another controlled attribution mechanism.

Potential scope:

- Add default UTM / source presets in Embed Code Studio.
- Ensure generated iframe code includes selected UTM / source query parameters.
- Consider explicit page URL parameter, if appropriate.
- Define whether parent page attribution should rely on UTM query or postMessage.
- Verify lead source fields after submission.

```text
Phase 3-C｜Form Field Type Expansion
```

Purpose:

Expand Form Builder field types for real lead qualification.

Potential scope:

- Select / dropdown.
- Radio.
- Checkbox.
- Multi-select.
- List.
- Need type options editor.
- Custom field limit review.
- Embed-side rendering.
- Submit validation alignment.

```text
Phase 2.4-x｜Legacy / Router Sender Alignment
```

Purpose:

Clarify and align legacy Lovable Email sender behavior with the Resend / Router sender strategy.

Potential scope:

- Decide whether legacy path should remain.
- Decide whether lead notifications should always go through Router.
- Decide whether `notify@notify.lohashare.com` should be deprecated.
- Decide whether `notify@send.lohashare.com` should become the unified sender.
- Add test-mode no-email capability.
- Prevent accidental email during lead-only tests.

---

## 15. Explicit Non-Actions

This phase and investigation did not perform:

- No second form submission.
- No file modification.
- No Build.
- No Publish.
- No Router flag flip.
- No Fallback flag flip.
- No Supabase schema change.
- No migration.
- No RLS change.
- No Email Router change.
- No Resend change.
- No Zoho fallback change.
- No Duda / Oasis modification.
- No new Lovable Build Prompt.
- No Phase 2.4-b execution.
- No Phase 3-B-3 execution.
- No Phase 3-C execution.
- No additional email intentionally sent after investigation.
- No customer rollout.

---

## 16. Recommended Archive Status

Recommended current status before archive:

```text
Draft｜Founder Review Required
```

Recommended post-archive status:

```text
Archived / Partial Pass with Findings / Lead Created / Attribution Verified / Source-UTM Gap / Unexpected Legacy Email Sent / No Next Submission Authorized
```

---

## 17. Recommended File Name

Recommended Markdown filename:

```text
LOHAShare_AI_Console_Phase_3-B-2_Controlled_Test_Form_Submission_Findings_Note_20260820.md
```

Recommended archive JSON filename:

```text
LOHAShare_AI_Console_Phase_3-B-2_Controlled_Test_Form_Submission_Findings_Note_20260820.archive.json
```

Recommended path:

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/
```

---

## 18. Recommended Commit Message

Recommended commit message:

```text
docs: archive phase 3-b-2 controlled test form submission findings note
```

---

## 19. Final Status

```text
Phase 3-B-2｜Controlled Test Form Submission
Status: Partial Pass with Findings / Lead Created / Attribution Verified / Source-UTM Gap / Unexpected Legacy Email Sent / Ready for DocOps Archive
```

---

## 20. Next Step

Next recommended action:

Submit this Findings Note to LOHAShare AI Platform 文件治理與 GitHub 自動化總控 for archive only.

Do not authorize another form submission, Phase 3-B-3, Phase 3-C, or Phase 2.4-b until the findings are reviewed and archived.
