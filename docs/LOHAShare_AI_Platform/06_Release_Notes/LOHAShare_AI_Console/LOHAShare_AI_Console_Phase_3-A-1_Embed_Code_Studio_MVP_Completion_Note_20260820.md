# LOHAShare AI Console｜Phase 3-A-1 Embed Code Studio MVP Completion Note

Version: v0.1  
Status: Archived / Founder UI Verification Passed / No Publish / No Field Test  
Date: 2026-08-20  
Project: LOHAShare AI Platform  
Module: LOHAShare AI Console / Embed Code Studio  
Phase: Phase 3-A-1  
Canonical Working Thread: Lovable 做網站後台  
Document Type: Completion Note / Release Governance Note / Lovable Build Completion Record  
GitHub Status: Written to GitHub / Committed / No PR  
Prepared For: DocOps / GitHub Archive  

Status Before Archive: Draft｜Founder Review Required｜Not Yet Archived  
Post-Archive Status: Archived / Founder UI Verification Passed / No Publish / No Field Test  

---

## 1. Completion Summary

Phase 3-A-1 — Embed Code Studio MVP Build has been completed by Lovable and passed Founder UI Verification.

The `/admin/embeds` page is no longer a placeholder and now provides a first usable Embed Code Studio MVP for generating iframe embed codes for LOHAShare AI Console public forms.

This phase enables admin / operator users to select a customer, site, and form, generate a Duda / Oasis-ready iframe snippet, copy the embed code, preview the form, adjust iframe height, configure basic UTM / source parameters, and view allowed domain status / warnings.

This phase did not include Duda / Oasis field testing, form submission testing, publishing, Email Router testing, or Phase 2.4-b Production Safe Test execution.

---

## 2. Governance Status

Current governance status:

```text
Phase 3-A-1｜Embed Code Studio MVP Build
Status: Completed by Lovable / Typecheck Passed / Founder UI Verification Passed / No Publish / No Field Test
```

Related prior status:

```text
Phase 2.4-b｜Production Safe Test Only
Status: Read-only Preflight Completed / BLOCKER-1 Cleared / Not Authorized / No Execution
```

Phase 2.4-b remains paused and was not executed during this phase.

---

## 3. Scope Approved by Founder

Founder accepted the Phase 3-A-1 Scope and authorized Lovable to build the Embed Code Studio MVP.

Approved scope included:

1. Convert `/admin/embeds` from placeholder into an Embed Code Studio MVP.
2. Use `src/routes/_authenticated/admin/embeds.tsx` as the primary implementation file.
3. Generate iframe embed code using `https://app.lohashare.com`.
4. Support admin and operator users.
5. Exclude client-facing access from this phase.
6. Include customer / site / form selection.
7. Include iframe code generation.
8. Include copy-to-clipboard.
9. Include iframe preview.
10. Include adjustable iframe height.
11. Include basic UTM / source query builder.
12. Include selected customer / site / form summary.
13. Include allowed domain status / warning.
14. Include Duda / Oasis paste instructions.
15. Avoid DB schema change, migration, RLS change, server function change, Email Router change, Publish, Duda / Oasis field testing, and test form submission.

---

## 4. Files Modified

Lovable reported that only the following file was modified:

```text
src/routes/_authenticated/admin/embeds.tsx
```

No other files were modified.

---

## 5. Implementation Result

| Item | Result |
|---|---|
| `/admin/embeds` no longer placeholder | Passed |
| Customer / Site / Form selection | Passed |
| Three-level cascading selection | Passed |
| iframe code generation | Passed |
| iframe base URL | `https://app.lohashare.com` |
| Lovable preview URL avoided | Passed |
| Copy-to-clipboard | Passed |
| iframe height adjustment | Passed |
| Basic UTM / source query builder | Passed |
| Selected customer / site / form summary | Passed |
| allowed domain status / warning | Passed |
| iframe preview | Passed |
| Duda / Oasis paste instructions | Passed |
| Phase 3-B reminder | Passed |

---

## 6. iframe Code Behavior

The generated iframe code uses:

```html
<iframe src="https://app.lohashare.com/embed/forms/{slug}" width="100%" height="720" style="border:0;"></iframe>
```

Key behavior:

1. `APP_BASE_URL` is currently defined in the page as `https://app.lohashare.com`.
2. Lovable preview URL is not used.
3. `forms.slug` is used to generate the embed URL.
4. Default width is 100%.
5. Default height is 720.
6. Height can be adjusted by the user.
7. UTM / source query parameters can be appended to the iframe source URL.

Known implementation note:

`APP_BASE_URL` is currently a page-level constant and has not yet been extracted into env / config.

This is a known gap but not a blocker for Phase 3-A-1 MVP completion.

---

## 7. UTM / Source Parameters

The Phase 3-A-1 UI supports the following query parameters:

1. `utm_source`
2. `utm_medium`
3. `utm_campaign`
4. `utm_content`
5. `utm_term`
6. `source_platform`
7. `source_channel`
8. `source_campaign_name`

The implementation does not use the incorrect names:

1. `source_medium`
2. `source_campaign`

This matches the Phase 3-A-0 inspection finding that:

1. `source_medium` should map to `source_channel`.
2. `source_campaign` should map to `source_campaign_name`.

No DB schema change was made for UTM / source parameters.

---

## 8. allowed domain Handling

Phase 3-A-1 includes allowed domain status / warning behavior.

Founder UI Verification confirmed the selected test case displayed:

```text
已設定允許網域
```

Phase 3-A-1 only displays allowed domain status / warning.

It does not:

1. Add allowed domains.
2. Modify allowed domain mutations.
3. Modify site detail page behavior.
4. Modify RLS.
5. Perform Duda / Oasis field testing.
6. Submit any test form.

---

## 9. Founder UI Verification

Founder completed UI verification and reported:

| Verification Item | Founder Result |
|---|---|
| `/admin/embeds` opens normally | Yes |
| Page is no longer placeholder | Yes |
| Can select customer / site / form | Yes |
| iframe code uses `https://app.lohashare.com` | Yes |
| Does not use preview URL | Yes |
| Can copy embed code | Yes |
| Height is adjustable | Yes |
| UTM / source fields are normal | Yes |
| Selected summary is normal | Yes |
| allowed domain status / warning is normal | Yes — 已設定允許網域 |
| iframe preview is normal | Yes |
| Duda / Oasis paste instructions are normal | Yes |
| Visual abnormalities found | None |
| Publish performed | No |
| Test form submitted | No |
| iframe pasted into Duda / Oasis | No |
| Conclusion | Passed |

---

## 10. Explicit Non-Actions

This phase explicitly did not perform the following actions:

1. No DB schema change.
2. No migration.
3. No RLS modification.
4. No server function modification.
5. No Email Router modification.
6. No Resend modification.
7. No Zoho SMTP modification.
8. No queue / process modification.
9. No secrets modification.
10. No email sent.
11. No Publish.
12. No Duda / Oasis field test.
13. No test form submission.
14. No Phase 2.4-b Production Safe Test.
15. No Router flag flip.
16. No Fallback flag flip.
17. No customer rollout.
18. No `/admin/usage`.
19. No `/admin/reports`.
20. No FAQ / AEO.
21. No Customer Portal.
22. No script auto-height.
23. No same-page allowed domain mutation.
24. No Duda API.

---

## 11. Typecheck / Lint Status

Lovable reported:

```text
tsgo --noEmit: Passed / exit 0 / no output
```

Lint was not executed. Lovable reported that no new lint-related structural risk was introduced.

---

## 12. Known Gaps / Notes

Known non-blocking notes:

1. `APP_BASE_URL` is currently defined as a page-level constant rather than env / config.
2. iframe preview loads the production custom domain `https://app.lohashare.com`, therefore preview reflects the published public form version rather than Lovable preview state.
3. Phase 3-B is still required for actual Duda / Oasis embed field testing.
4. Test form submission has not yet been performed.
5. Duda / Oasis page has not yet received the iframe code.
6. script auto-height remains deferred.
7. allowed domain inline add remains deferred.
8. Duda API remains out of scope.

---

## 13. Phase Boundary

Phase 3-A-1 is now complete as a Console-side MVP build.

The following phase is not yet authorized:

```text
Phase 3-B｜Duda / Oasis Embed Field Test
```

Before entering Phase 3-B, Founder should explicitly authorize:

1. Which Duda / Oasis page will be used.
2. Whether the page is preview-only or published.
3. Which iframe code will be pasted.
4. Whether test form submission is allowed.
5. Which test data may be submitted.
6. Whether notification behavior should remain disabled / not tested.
7. How to verify lead creation in LOHAShare AI Console.
8. Whether any email notifications should remain out of scope.

---

## 14. Recommended Archive Status

Recommended archive status:

```text
Archived after Founder approval
```

Recommended current status before archive:

```text
Draft｜Founder Review Required
```

Recommended post-archive status:

```text
Archived / Founder UI Verification Passed / No Publish / No Field Test
```

---

## 15. Recommended File Name

Recommended Markdown filename:

```text
LOHAShare_AI_Console_Phase_3-A-1_Embed_Code_Studio_MVP_Completion_Note_20260820.md
```

Recommended archive JSON filename:

```text
LOHAShare_AI_Console_Phase_3-A-1_Embed_Code_Studio_MVP_Completion_Note_20260820.archive.json
```

Recommended path:

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/
```

---

## 16. Recommended Commit Message

Recommended commit message:

```text
docs: archive phase 3-a-1 embed code studio completion note
```

---

## 17. Final Status

```text
Phase 3-A-1｜Embed Code Studio MVP Build
Status: Completed by Lovable / Typecheck Passed / Founder UI Verification Passed / No Publish / No Field Test / Archived
```

---

## 18. Next Step

Next recommended action:

Keep Phase 3-A-1 archived and wait for separate Founder authorization before proceeding to Phase 3-B.

Do not proceed to Phase 3-B until Founder explicitly authorizes the next phase.
