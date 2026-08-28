# Decision-only Controlled Sprint Admin Usage / Reports / FAQ / Leads Completion Note

版本時間：2026-08-28（Asia/Taipei）  
文件狀態：Archived / Decision-only Controlled Sprint Completed / Publish Verified / No Email Sent / No DB Schema Change / No Router Change  
歸檔位置：`docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/`  
對應產品：LOHAShare AI Console  
對應流程：Decision-only Controlled Sprint  
對應 HEAD：`37ca8081567a9e3a1a49af8221fe330dcd81cb01`  
Production URL：`https://app.lohashare.com`

---

## 1. Purpose

本 Completion Note 記錄 2026-08-28 Decision-only Controlled Sprint 的完成、發布與發布後唯讀驗證結果。

本次 Sprint 的目的，是在不觸碰 Email Router、通知主流程、Supabase schema / RLS / secrets、表單送出與 lead creation 的前提下，補齊 LOHAShare AI Console 後台左側功能列中剩餘 placeholder / 未完整頁面，使主要後台導航達到可展示、可理解、可驗收、可延續的狀態。

---

## 2. Scope Completed

本次完成範圍如下：

1. `/admin/usage` — 使用量頁
   - read-only usage dashboard
   - 月份切換
   - 客戶篩選
   - `monthly_usage` × `sites` × `customers` × `plans` / `subscriptions` 彙總
   - 名單、寄信、AI 額度進度條
   - 超額警示
   - CSV 匯出

2. `/admin/reports` — 月報草稿頁
   - 客戶與月份選擇
   - leads 統計彙總
   - status / site / source 分布
   - 與上月比較
   - Plain Text / HTML / Preview
   - 複製功能
   - AI 中文摘要按鈕，僅手動觸發
   - AI 失敗時 fallback 為純統計草稿

3. `/admin/faq` — FAQ / AEO 設計預覽頁
   - UI Shell / Design Preview
   - FAQ editor mock
   - JSON-LD preview
   - Duda embed code draft preview
   - 頁面外觀 preview
   - 明確標示設計預覽，不作為正式 DB-backed FAQ 模組

4. `/admin/leads` — 全域名單總覽頁
   - 跨客戶 / 跨網站 leads 總覽
   - 客戶、網站、狀態、來源、關鍵字、日期篩選
   - 連結至既有 lead detail
   - CSV 匯出能力沿用既有能力

5. `src/lib/reports.functions.ts`
   - 新增月報 AI 摘要 server function
   - 使用既有 Lovable AI Gateway
   - 無 DB 寫入
   - 無自動寄送

---

## 3. Explicit Non-Scope

本次明確不包含以下項目：

- 不修改 Supabase schema
- 不建立 migration
- 不修改 RLS / GRANT
- 不修改 secrets
- 不啟用 Email Router
- 不啟用 Fallback
- 不修改 Email Router 程式
- 不修改 `notifications.server.ts`
- 不修改 queue worker
- 不修改 safe-test flow
- 不修改 form submit flow
- 不修改 lead creation flow
- 不寄信
- 不 enqueue
- 不重送 DLQ
- 不送出表單
- 不建立 lead
- 不建立 PR
- 不修改 Current folder
- 不修改 Document System Index
- 不修改 New Conversation Handoff

---

## 4. Implementation Verification

Lovable 回報本次 Sprint 完成後的狀態如下：

- Current HEAD：`37ca8081567a9e3a1a49af8221fe330dcd81cb01`
- Git status：clean
- Typecheck：`bunx tsgo --noEmit` PASS（exit 0）
- Founder Preview Smoke Test：PASS
- Founder Manual Preview：PASS
- Publish Preflight：PASS

本次 Sprint 修改檔案清單如下：

| File | Purpose |
|---|---|
| `.lovable/plan.md` | Plan 文件更新，非產品程式碼 |
| `src/integrations/supabase/types.ts` | 平台自動產生型別 |
| `src/lib/reports.functions.ts` | P2 月報 AI 彙整 function |
| `src/routes/_authenticated/admin/faq.tsx` | P3 FAQ UI shell / design preview |
| `src/routes/_authenticated/admin/leads.tsx` | P4 全域名單總覽 |
| `src/routes/_authenticated/admin/reports.tsx` | P2 月報草稿頁 |
| `src/routes/_authenticated/admin/usage.tsx` | P1 使用量頁 |

---

## 5. Publish Verification

Founder 核准單次 Publish 後，Lovable 回報本次 Publish 結果為 PASS。

Publish 前檢查：

- HEAD：`37ca8081567a9e3a1a49af8221fe330dcd81cb01`，與 Founder 授權一致
- Git status：clean
- Typecheck：PASS
- `notification_logs`：49
- `email_send_log`：57
- `leads`：18

Publish 後正式站唯讀驗證：

- `/admin/usage`：HTTP 200
- `/admin/reports`：HTTP 200
- `/admin/faq`：HTTP 200
- `/admin/leads`：HTTP 200

桌機 1280px 與手機 390px 皆正常渲染。

正式站驗證內容包括：

- Usage KPI / CSV 可見
- Reports 客戶 + 月份 + AI 摘要按鈕可見
- FAQ 設計預覽可見
- Leads 顯示「共 18 筆」與篩選功能可見

---

## 6. Production Safety Verification

發布後確認以下數量未變：

| Item | Before Publish | After Publish | Result |
|---|---:|---:|---|
| `notification_logs` | 49 | 49 | Unchanged |
| `email_send_log` | 57 | 57 | Unchanged |
| `leads` | 18 | 18 | Unchanged |
| DLQ count | 5 | 5 | Unchanged |

發布後確認：

- Router / Fallback 維持 `false`
- 未寄信
- 未 enqueue
- 未重送 DLQ
- 未送表單
- 未建立 lead
- 未修改 schema / migration / RLS
- 未修改 secrets
- 未修改通知相關流程

---

## 7. Deployment Record

ChatGPT Lovable deploy_project tool response returned:

- Status：pending
- Deployment ID：`84c3006d-fc18-48ed-be4a-965b2ce9bafd`
- URL：`https://nexus-lead-ops.lovable.app`
- Preview URL：`https://id-preview--8a6788ab-4762-4e8a-9953-5f351ec760a0.lovable.app`

Lovable UI / `preview_ui--publish` later reported PASS and live URL:

- Live URL：`https://app.lohashare.com`
- Deployment ID：not returned by `preview_ui--publish` tool path

Interpretation:

The deployment ID above is retained as the ChatGPT Lovable deploy_project tool response record. Lovable UI / preview_ui--publish did not return a deployment_id in its response. This is treated as a tool response difference, not a publish failure.

---

## 8. Known Limitations

1. FAQ / AEO remains a design preview.
   - No `faqs` table exists.
   - No migration was executed.
   - No RLS / GRANT / anon SELECT was added.
   - Draft embed code does not function as a production public widget.
   - Editor content is not persisted after reload.

2. Reports AI summary is manual.
   - AI summary is only triggered by an authenticated admin action.
   - It does not automatically run.
   - It does not send email.
   - If AI fails, the page falls back to plain statistical report text.

3. Usage page is read-only.
   - It displays existing `monthly_usage` data only.
   - It does not recalculate or correct historical usage.

4. Leads overview currently limits listing to recent 300 records.

5. Mobile reports toolbar has a minor layout observation.
   - On mobile `/admin/reports`, the toolbar line break can visually separate the previous-month arrow and month dropdown.
   - This is a non-blocking UI observation and does not affect operation.

---

## 9. Non-blocking Observation

During mobile production verification, Lovable observed one Supabase `_getUser` `Failed to fetch` event during session restoration. The page content still rendered normally, and Lovable classified it as a temporary session/network restoration issue rather than a blocking error caused by this release.

This observation does not block completion.

---

## 10. Final Status

Final status:

`Archived / Decision-only Controlled Sprint Completed / Publish Verified / No Email Sent / No DB Schema Change / No Router Change`

This Sprint is complete and verified.

Recommended next stage, if needed, should be planned separately and must require new authorization before any migration, RLS, public embed route, email automation, report scheduling, or AI Hub expansion work.
