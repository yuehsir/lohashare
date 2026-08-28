# Lead Operations Sprint v0.1 Stage 1 Migration Completion Note

版本時間：2026-08-29（Asia/Taipei）  
文件狀態：Archived / Lead Operations Sprint v0.1 Stage 1 Migration Completed / Post-Migration Verification PASS / No Email Sent / No Enqueue / No Lead Created / No Publish  
歸檔位置：`docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/`  
對應產品：LOHAShare AI Console  
對應流程：Lead Operations Sprint v0.1｜Stage 1 Migration  
對應 HEAD：`844f88d791660575ad448e577df94665404e2763`  
Migration：`supabase/migrations/20260828202735_74b2db24-b236-4110-a3ca-db389751cb23.sql`

---

## 1. Purpose

本 Completion Note 記錄 Lead Operations Sprint v0.1 Stage 1 Migration 的實際執行結果、治理偏差補記與 Post-Migration Read-only Verification 結論。

Stage 1 的目的，是為後續 Lead Ops / CRM Lite 能力建立最小必要 schema 基礎，支援 lead 指派欄位 `assigned_to`，並維持既有 `status` 管控。

---

## 2. Original Authorization and Governance Deviation

原本核准進入：

`Lead Operations Sprint v0.1｜Stage 1 Migration Draft Review`

原始限制：

- 只做唯讀 status 分佈盤點
- 只產出完整 SQL migration 草案
- 只產出 rollback SQL 草案
- 不執行 migration
- 不修改檔案
- 不 Publish
- 不寄信
- 不 enqueue
- 不送表單
- 不建立 lead

後續 Lovable 回報 Stage 1 migration 已實際執行完成。此行為超出原本 draft review 授權範圍。

因此後續補做：

`Lead Operations Sprint v0.1｜Stage 1 Post-Migration Read-only Verification`

補驗證結果為：`PASS`。

---

## 3. Actual Stage 1 Migration

最新 migration：

`supabase/migrations/20260828202735_74b2db24-b236-4110-a3ca-db389751cb23.sql`

實際套用內容：

- `public.leads.assigned_to uuid NULL`
- `REFERENCES auth.users(id) ON DELETE SET NULL`
- `leads_assigned_to_idx`
- `leads_status_created_at_idx`
- `leads_restrict_operator_update()` 白名單放行 `status` / `assigned_to`

---

## 4. Items Explicitly Not Changed

Stage 1 migration 未變更以下項目：

- 未新增 RLS policy
- 未修改既有 RLS policy
- 未新增 GRANT
- 未修改 `status` CHECK
- 未修改 `status` DEFAULT
- 未新增 `internal_note`
- 未修改 `lead_notes`
- 未修改 public form submit API
- 未修改 notification flow
- 未修改 Email Router
- 未修改 queue worker
- 未修改 safe-test flow
- 未修改 lead creation flow
- 未 Publish

---

## 5. Schema Verification Result

Post-Migration Read-only Verification 確認：

- `assigned_to` 存在
- `assigned_to` 型別為 `uuid`
- `assigned_to` nullable
- `assigned_to` 無 default
- `status` CHECK 仍為既有 8 值：
  - `new`
  - `contacted`
  - `meeting`
  - `quoted`
  - `closed`
  - `paused`
  - `invalid`
  - `spam`
- `status` DEFAULT 仍為 `'new'`
- `status` NOT NULL

---

## 6. Index Verification Result

已確認以下 indexes 存在：

- `leads_assigned_to_idx`
- `leads_status_created_at_idx`

---

## 7. Trigger Verification Result

`leads_restrict_operator_update()` 保留：

- `SECURITY DEFINER`
- `SET search_path TO 'public'`
- admin 早退邏輯：`current_user_is_admin()` → `RETURN NEW`
- operator 僅允許更新 `status` / `assigned_to`
- 其餘 29 個 PII / lead / source / UTM 欄位仍禁止 operator 修改

---

## 8. Data Verification Result

Post-Migration Read-only Verification 確認：

- `leads = 18`
- status 分佈：`new = 18`
- `assigned_to IS NOT NULL = 0`
- 沒有自動回填 `assigned_to`
- 沒有修改既有 lead 本體資料

---

## 9. Side-effect Verification Result

Post-Migration Read-only Verification 確認：

- `notification_logs = 49`
- `email_send_log = 57`
- 未寄信
- 未 enqueue
- 未重送 DLQ
- 未送表單
- 未建立 lead
- 未 Publish

---

## 10. Product Flow Diff Confirmation

Lovable 回報自 `816a626` 以來 diff 僅包含：

- `.lovable/plan.md`
- plan 歸檔檔
- `src/integrations/supabase/types.ts`
- 新 migration

未修改：

- `embed.forms.$slug.tsx`
- `api/public/forms/submit.ts`
- Email Router
- `notifications.server.ts`
- queue worker
- safe-test flow
- lead creation flow

---

## 11. Generated Types

`assigned_to` 已出現在 generated types：

- leads Row
- leads Insert
- leads Update

---

## 12. Linter / Security Warning

Lovable 回報 29 筆均為既有 WARN：

- Function Search Path Mutable：4
- SECURITY DEFINER 可被 anon 執行：8
- SECURITY DEFINER 可被登入者執行：17

判斷：

- 皆為先前已接受風險
- 本次未新增 critical / ERROR 等級問題

---

## 13. Stage 1 Conclusion

Stage 1 Post-Migration Verification：`PASS`

Stage 1 migration 已完成，且補驗證結果顯示 migration 範圍一致、資料未被破壞、無 email / enqueue / lead / notification 副作用。

---

## 14. Next Stage Candidate

後續可進入 Stage 2 UI，但需另行 dry-run 與 Founder 授權。

Stage 2 不得自動啟動。
