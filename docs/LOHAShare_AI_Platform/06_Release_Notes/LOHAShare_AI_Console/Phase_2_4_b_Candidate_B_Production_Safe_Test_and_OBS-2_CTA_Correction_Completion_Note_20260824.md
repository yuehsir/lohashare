# Phase 2.4-b Completion Note｜Candidate B Production Safe Test and OBS-2 CTA Correction

Status：Archived / Completion Note / Founder Approved  
Date：2026-08-24  
Project：LOHAShare AI Platform / LOHAShare AI Console  
Module：Email Notification / Provider Router  
Scope：Phase 2.4-b Candidate B production-safe testing and Safe Test Email CTA correction  
Prepared by：ChatGPT / Lovable assisted workflow  
Founder：岳汝誠（Richard Yueh）

---

## 1. Purpose

本文件記錄 LOHAShare AI Console Email Notification / Provider Router 子模組於 Phase 2.4-b 的完成結果。

本階段主要目的為驗證：

1. 在 `EMAIL_PROVIDER_ROUTER_ENABLED=false`、`EMAIL_FALLBACK_ENABLED=false` 的 production-safe 條件下，Safe Test 是否可透過 payload-driven router override 走 Resend。
2. Resend 是否可於 production queue worker 實際送達 Founder inbox。
3. Safe Test Email 是否不會建立正式 lead、不會寄送 customer recipients、不會影響 monthly_usage、不會重送 DLQ。
4. 修正 OBS-2：Safe Test Email 不應顯示導向 dummy lead 的「前往後台查看名單」CTA。
5. 修正後的 Safe Test Email 是否已於 production 實際寄送並由 Founder 視覺確認。

---

## 2. Baseline and Constraints

本階段執行期間維持以下限制：

- Router global flag 維持 false。
- Fallback 維持 false。
- 不啟用正式 Router rollout。
- 不送出前台表單。
- 不建立正式 lead。
- 不寄送 customer recipients。
- 不重送 DLQ。
- 不修改 Supabase schema / RLS / secrets。
- Publish 僅限已授權 HEAD。
- 所有高風險操作皆採 dry-run、Founder 授權、單步執行、完成後停止。

---

## 3. Candidate B Design Summary

Phase 2.4-b 採用 Candidate B：

> payload-driven router override

核心設計為：

- 不依賴全域 Router flag。
- Safe Test payload 明確指定 router override。
- provider 指定為 Resend。
- fallback hard disabled。
- customer recipient count 必須為 0。
- lead_id 必須為 null。
- recipient_kind 必須為 lohashare。
- router decision source 必須為 `safe_test_payload`。
- `EMAIL_PROVIDER_ROUTER_ENABLED` 即使為 false，Safe Test 仍可在嚴格 payload guard 下走 Resend。
- 正式 lead notification 主流程不因此被打開。

---

## 4. Candidate B Implementation Result

Candidate B 已完成實作並部署至 production。

已知實作範圍包含 Safe Test payload override、queue processor guard、router dispatch override、preflight output 與 UI 說明調整。

其後確認：

- Candidate B code 已進入 production。
- Safe Test 可在 Router=false / Fallback=false 下透過 payload override 使用 Resend。
- 正式 lead notification 主流程未被改為全域 Router。
- auth_emails / non-safe-test 路徑未納入本次測試範圍。
- Fallback 未啟用。

---

## 5. Production Safe Test Result｜Step 2-fix-b6-Retry

Step 2-fix-b6-Retry 執行 Direct Single Safe Test Enqueue。

執行條件：

- Router=false
- Fallback=false
- Safe Test payload override → Router path → Resend
- No preflight
- No Publish
- No Router flip
- No Fallback
- No DLQ retry
- No form submit
- No lead creation

執行結果：

- Enqueue：成功
- Enqueue count：1
- testRunId：`dbaf96d4-fccd-4441-b17c-9b9a84a09965`
- queue_id：`36`
- provider_primary：`resend`
- provider_used：`resend`
- fallback_used：`false`
- metadata.send_path：`router`
- metadata.router_decision_source：`safe_test_payload`
- metadata.provider_requested：`resend`
- metadata.global_router_flag：`false`
- metadata.disable_fallback：`true`
- legacy path：無
- Lovable Emails 400：無
- customer recipient logs：0
- leads：18 → 18
- monthly_usage 2026-08：email 3 / lead 1 → unchanged
- DLQ：5 → 5
- suppressed_emails：0 → 0

Founder inbox confirmation：

- Founder confirmed receipt.
- Sender confirmed as `notify@send.lohashare.com`.
- Delivery path confirmed as Resend production-safe Safe Test.

Result：

```text
Step 2-fix-b6-Retry：PASS
```

---

## 6. OBS-2 Identified｜Safe Test Email CTA Misleading

After Step 2-fix-b6-Retry, Founder reported that the received Safe Test Email still contained CTA：

> 前往後台查看名單

The link pointed to a dummy lead id：

```text
00000000-0000-0000-0000-000000000000
```

Observed behavior：

- Clicking the CTA opened the backend lead page.
- No lead appeared.
- This was expected from data-safety design because Safe Test does not create a real lead.
- However, the CTA was misleading from a UX / email template perspective.

OBS-2 conclusion：

```text
Safe Test Email should not display a lead-detail CTA when no real lead is created.
```

Impact：

- Not a delivery failure.
- Not a Resend failure.
- Not a Router failure.
- Not a DB failure.
- Classified as UX / template correction.

---

## 7. OBS-2 Dry-run Analysis｜Step 2-fix-b7

Step 2-fix-b7 performed read-only analysis.

Findings：

- Safe Test and formal lead notification share `LeadNotificationEmail`.
- CTA is generated in：

```text
src/lib/email-templates/lead-notification.tsx
```

- Dummy leadId source was identified in Safe Test path.
- `isTest=true` already exists and is sufficient for branching.
- Formal lead notification uses `isTest=false` and must preserve original CTA.

Candidate fixes：

1. Remove CTA for `isTest=true` and display plain text notice.
2. Replace CTA with notification settings page.
3. Combine plain text notice and settings link.

Selected option：

```text
Candidate 1：Remove CTA for Safe Test and display plain text notice.
```

Reason：

- Minimal change.
- One file only.
- No new props.
- No schema / RLS / secrets.
- Lowest production risk.
- Does not affect formal lead notification HTML.

Result：

```text
Step 2-fix-b7：Dry-run PASS
```

---

## 8. OBS-2 Implementation｜Step 2-fix-b8

Step 2-fix-b8 implemented Candidate 1.

Modified file：

```text
src/lib/email-templates/lead-notification.tsx
```

Change summary：

- `isTest=true`：
  - Removed CTA button.
  - Removed dummy lead link exposure.
  - Added plain text notice：

```text
此為安全測試信，不會建立真實名單，因此後台不會出現對應 lead。
```

- `isTest=false`：
  - Preserved formal lead notification CTA.
  - Preserved original `Button href={leadUrl}` behavior.
  - Preserved CTA text：

```text
前往後台查看名單
```

Typecheck：

```text
bunx tsgo --noEmit
PASS
```

No prohibited changes：

- No notification server changes.
- No Safe Test payload changes.
- No Router / Fallback logic changes.
- No queue processor changes.
- No DB / migration / schema / RLS / secrets changes.
- No Publish in this step.
- No enqueue.
- No email.

Result：

```text
Step 2-fix-b8：Implemented / Typecheck Passed
```

---

## 9. Static Verification｜Step 2-fix-b9

Step 2-fix-b9 performed read-only verification.

Verification results：

- Only `src/lib/email-templates/lead-notification.tsx` was changed.
- Forbidden files had no changes.
- `isTest=true` branch removed CTA and dummy lead link.
- `isTest=true` branch displayed the plain text notice.
- `isTest=false` branch preserved formal CTA.
- Typecheck passed.
- No DB / migration / schema / RLS / secrets changes.

HEAD note：

- Expected b8 reference：`400ba2b...`
- Actual post-b8 reference：`4d2fec7...`
- Later platform auto-commit advanced HEAD, but tree remained equivalent for the tested scope.
- The HEAD shift was classified as non-blocking after confirming tree-equivalent content for the relevant files.

Result：

```text
Step 2-fix-b9：Static Verification PASS
```

---

## 10. Publish｜Step 2-fix-b10

Step 2-fix-b10 authorized production Publish.

Initial Publish attempt was stopped because requested HEAD and actual HEAD differed.

Founder then authorized updated publish target：

```text
4a3ffde27272326db89063ab588cb7b5d1fab2d2
```

Publish was triggered.

Deployment：

```text
deployment_id = 2da6e6f2-96e7-4e50-b63b-4824459ef15e
production_url = https://nexus-lead-ops.lovable.app
preview_url = https://id-preview--8a6788ab-4762-4e8a-9953-5f351ec760a0.lovable.app
```

Post-publish read-only verification：

- Production URL responded normally.
- No enqueue.
- No email.
- No Router / Fallback change.
- No DLQ retry.
- No form submit.
- No lead creation.
- No DB abnormal change.
- `leads` remained 18.
- Known log increases were from prior safe-test actions, not from publish.
- Production did not expose commit SHA header; this was recorded as normal platform limitation.

Result：

```text
Step 2-fix-b10：Publish Triggered / Post-Publish Read-only Verification PASS with known limitations
```

Known limitation：

- Production did not return commit SHA header.
- Router runtime value requires authenticated admin status access.
- Both were classified as normal platform/security constraints, not blockers.

---

## 11. Visual Verification｜Step 2-fix-b11

Step 2-fix-b11 authorized and executed one production Safe Test Enqueue for visual verification.

Execution constraints：

- One Safe Test Enqueue only.
- Recipient only：`richard.yueh@lohashare.com`.
- No Publish.
- No Router / Fallback change.
- No DLQ retry.
- No form submit.
- No lead creation.
- No preflight.
- No retry.

Pre-check：

- working tree clean.
- HEAD：`77671a83`.
- Template `isTest=true` branch showed plain text notice and no `<Button>`.
- approved internal recipient count = 1.
- approved internal recipient = `richard.yueh@lohashare.com`.
- No overlap with customer `email_recipients`.
- Router disabled.
- Fallback disabled.
- Sender：`notify@send.lohashare.com`.
- Domain：`send.lohashare.com`.

Execution result：

- status：`queued`
- queuedCount：1
- skipped：0
- failed：0
- testRunId：`18c28f1d-174c-4113-8f8b-5d49f60bbd34`
- message_id：`605ef4f8-5c92-4661-bfab-858bee2c647b`
- queue_id：`37`
- providerPathLabel：Router → resend（Safe Test payload override，無 Fallback）

Delta：

| Item | Before | After | Result |
|---|---:|---:|---|
| notification_logs | 48 | 49 | +1 |
| notification_logs is_test | 12 | 13 | +1 |
| email_send_log | 56 | 57 | +1 |
| leads | 18 | 18 | unchanged |
| monthly_usage 2026-08 | email 3 / lead 1 | email 3 / lead 1 | unchanged |
| DLQ | 5 | 5 | unchanged |

New record：

- status：`sent`
- provider_used：`resend`
- router_decision_source：`safe_test_payload`
- send_path：`router`
- global_router_flag：`false`
- fallback_used：`false`
- recipient：`richard.yueh@lohashare.com`
- customer recipient：none
- sent_at：`2026-08-23 20:35:23Z`

Founder visual confirmation：

Founder confirmed the received b11 email：

- Email received.
- Sender：`notify@send.lohashare.com`.
- The CTA button「前往後台查看名單」was removed.
- Plain text notice appeared correctly：

```text
此為安全測試信，不會建立真實名單，因此後台不會出現對應 lead。
```

- No blank CTA or visual break was reported.

Result：

```text
Step 2-fix-b11：PASS
```

---

## 12. Final Completion Status

Phase 2.4-b Candidate B production-safe testing and OBS-2 CTA correction are complete.

Final status：

```text
Candidate B payload-driven router override：PASS
Production Safe Test Enqueue：PASS
Resend Delivery：PASS
Founder Inbox Confirmation：PASS
OBS-2 Safe Test CTA Correction：PASS
Founder Visual Confirmation：PASS
No customer recipient：PASS
No lead creation：PASS
No monthly_usage impact：PASS
No DLQ retry：PASS
Router remains false：PASS
Fallback remains false：PASS
```

---

## 13. Items Not Authorized / Not Performed

The following were not authorized or not performed：

- No formal lead notification Router rollout.
- No global Router enablement.
- No Fallback enablement.
- No customer recipient email.
- No front-end form submission.
- No Duda / Oasis hidden iframe submission.
- No lead creation.
- No DLQ retry.
- No webhook delivery event implementation.
- No schema / RLS / secrets modification.
- No automatic follow-up test beyond authorized single actions.

---

## 14. Known Remaining Items

The following remain outside this completion scope：

1. Formal lead notification Router rollout planning.
2. Site-level or provider-level rollout gates.
3. OBS-1b webhook delivery event visibility.
4. Health/status endpoint for non-sensitive runtime status.
5. Production commit SHA exposure / build metadata endpoint.
6. DLQ historical cleanup policy.
7. Customer-facing unsubscribe / List-Unsubscribe / compliance items for broader rollout.
8. Formal release note archival and GitHub commit.

---

## 15. Archival Location

GitHub archival path：

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/Phase_2_4_b_Candidate_B_Production_Safe_Test_and_OBS-2_CTA_Correction_Completion_Note_20260824.md
```

This file was approved by Founder for GitHub archival write after dry-run review.

---

## 16. Final Decision Record

Founder approved archival write：

```text
核准 Phase 2.4-b Completion Note 歸檔寫入 GitHub；路徑使用 dry-run 建議路徑；只允許建立該 Markdown 檔案並 commit，不建立 PR、不修改 Lovable、不修改 Supabase。
```
