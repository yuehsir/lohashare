# LOHAShare AI Console Phase 1.2 Production Publish and Smoke Test Note

Version date: 2026-06-10
Document status: GitHub archive redacted version
Product name: LOHAShare AI Console / Nexus Lead Ops
Governance module: Lead Console
Phase: Phase 1.2 Social / LINE OA Lead Tracking MVP
Production status: Stable

This redacted GitHub archive version intentionally removes individual email addresses, direct lead addresses, and sensitive recipient values. It preserves the production result, validation outcomes, and governance decisions.

---

## 1. Purpose

This note records the production publish and smoke test results for Phase 1.2. It follows the previously archived build completion and preview validation note.

Purpose:

1. Mark Phase 1.2 as published to production.
2. Record that production smoke testing passed.
3. Record that notification dispatch and email logging passed.
4. Confirm that notification recipient source was verified.
5. Confirm that Email Router, Unsubscribe, RLS, secrets, and router flags were not modified.

---

## 2. Prior archived records

Build completion and preview validation note commit:

```text
1d910ca774b57948dc3e85cbbfbc3728e0876097
```

Developer Prompt v0.3 archive commit:

```text
db7c232e50b1bde225dade2c2b7de6f0c0ed9310
```

IN-001 update commit:

```text
b8567b329b34c8a67401643807ee770b35ce3900
```

---

## 3. Production publish result

Production publish was executed and completed.

Production application:

```text
app.lohashare.com
```

The published scope was limited to Phase 1.2 changes that had passed preview validation:

1. Twelve source and UTM fields on `public.leads`.
2. Five source and UTM indexes.
3. Updated `leads_restrict_operator_update` trigger blocklist.
4. Public form submit source payload and whitelist sanitisation.
5. SSR-safe source collection in the embed form route.
6. Source section in LeadDetailDrawer.
7. CSV export source and UTM columns appended to the end per IN-001.

No new code change, migration, schema change, or setting change was added during the publish step.

---

## 4. Non-goals safety confirmation

The following areas were confirmed unchanged during this production publish:

```text
Email Router
Unsubscribe route
UNSUBSCRIBE_BASE_URL
Zoho SMTP
RLS policies
secrets
router flags
production routing
social platform APIs
social_lead_candidates table
Lead List platform filter
Admin Source Report
Form Editor
monthly_usage
usage_logs
Edge Functions
```

---

## 5. Production smoke test results

Three production lead submissions were tested.

### 5.1 Valid source and UTM submission

Expected and confirmed result:

```text
source_type = line_oa
source_platform = line
utm_source = line
utm_campaign = prodtest
```

Result: PASS

### 5.2 Invalid whitelist submission

Expected and confirmed result:

```text
source_type = NULL
source_platform = NULL
utm_source = valid_pass
utm_campaign = NULL
```

Result: PASS

### 5.3 No-source submission

Expected and confirmed result:

```text
source_type = NULL
source_platform = NULL
utm_source = NULL
utm_campaign = NULL
```

Result: PASS

---

## 6. Notification and email smoke test

Notification logs showed nine sent notification rows: three notification recipients for each of the three test leads.

Email send logs showed three matching lead-notification rows to the internal LOHAShare recipient channel. All were sent and had no errors.

Activity logs showed the expected lead creation and notification dispatch records.

Historical failed or DLQ rows from an earlier date were identified as unrelated to this smoke test batch.

Result: PASS

---

## 7. Notification recipient source check

A read-only check confirmed that notification recipients came from the site-level notification settings row:

```text
public.notification_settings
site_id = 169aa3ac-644c-4ad9-8cb1-7c4e172b9f1b
form_id IS NULL
```

Confirmed recipient source:

```text
site-level notification setting
```

Confirmed not to be:

```text
form-level override
customer owner auto-derivation
environment variable
hardcoded fallback
cross-site leakage
```

Expected behavior was confirmed: lead submissions notify internal managers and operations recipients, not the lead submitter email address.

Risk check result: recipients are bound only to the LOHAShare test site and do not affect other customer sites.

Result: PASS

---

## 8. Overall production result

Phase 1.2 production smoke test was fully verified:

```text
Source and UTM write path: PASS
Whitelist sanitisation: PASS
No-source fallback: PASS
Lead notification dispatch: PASS
Email provider log: PASS
Notification recipient source check: PASS
Non-goals safety: PASS
```

Final status:

```text
Phase 1.2 production stable
```

---

## 9. Known pre-existing warnings

The following were known pre-existing warnings and do not block production stable status:

```text
hydration mismatch data-google-analytics-opt-out
DialogContent missing Description
search_path / SECURITY DEFINER warning on unrelated functions
historical failed / DLQ rows from an earlier batch
```

---

## 10. Current status

```text
Phase 1.2 Migration: Completed
Phase 1.2 Code Build: Completed
TypeScript Check: Passed
Preview Validation: Passed
Production Publish: Completed
Production Smoke Test: Passed
Notification Smoke Test: Passed
Notification Recipient Source Check: Passed
Temporary Preview allowed domain: Removed
Production Stable: Yes
Email Router / Unsubscribe / RLS / secrets / router flags: Not modified
```

---

## 11. Recommended next gates

Future work should be opened as separate gates:

1. Phase 1.2.1: Lead List source platform filter, Admin Source Report, CSV/reporting improvements.
2. Phase 1.3: Social Lead Candidate Pipeline, updated snippet and parent page query forwarding.
3. Email / Notification: Option B unsubscribe preview, Email Router cutover planning, notification recipient configuration audit.
4. Documentation / Governance: module status index update, release note index update, decision record for Phase 1.2 production stable.

Do not combine these with the Phase 1.2 production stable closure.
