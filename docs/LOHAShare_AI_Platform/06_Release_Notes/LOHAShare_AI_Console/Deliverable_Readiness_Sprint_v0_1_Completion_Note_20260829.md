# Deliverable Readiness Sprint v0.1 Completion Note

版本時間：2026-08-29（Asia/Taipei）  
文件狀態：Archived / Deliverable Readiness Sprint v0.1 Completed / Publish Verified / No Email Sent / No DB Schema Change / No Router Change  
歸檔位置：`docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/`  
對應產品：LOHAShare AI Console  
對應流程：Deliverable Readiness Sprint v0.1  
對應 HEAD：`cf68b2f4ef44b057404d12607d038b836827ebb6`  
Production URL：`https://app.lohashare.com`

---

## 1. Purpose

本 Completion Note 記錄 2026-08-29 Deliverable Readiness Sprint v0.1 的完成、發布與發布後唯讀驗證結果。

本次 Sprint 的目的，是提升 LOHAShare AI Console 的商業交付準備度，優先補齊最接近 MVP 交付價值的功能。

本次 Sprint 維持 Controlled Sprint 限制：不修改 Supabase schema / migration / RLS、不修改 secrets、不寄信、不 enqueue、不建立 lead、不送出表單、不重送 DLQ、不啟用 Router / Fallback、不修改公開表單頁 `embed.forms.$slug.tsx`、不修改 `api/public/forms/submit`、不修改 Email Router / notifications / queue / safe-test / lead creation flow。

---

## 2. Scope Completed

本次完成範圍如下：

1. `/admin/embeds` — 嵌入碼補強
   - 補齊 12 個 `source_` / `utm_` 欄位。
   - 新增最終 query string 預覽。
   - 保留複製嵌入碼功能。
   - 新增複製公開表單 URL。
   - 新增桌機 / 手機 preview 切換。
   - 固定高度 iframe 維持建議模式。
   - 自動高度 script 標示為 Beta / future-ready。
   - 未修改公開表單頁與公開送單 API。

2. `/admin` — Dashboard 唯讀資料補齊
   - 補齊後台 dashboard 8 張卡。
   - 每張卡顯示真實唯讀統計或可信狀態文案。
   - 每張卡新增「來源：」說明。
   - FAQ 顯示「模組未啟用」，不填假數字。
   - 未授權網域顯示「尚無可靠資料來源」，不填假數字。

3. `/admin/forms` — 跨站表單管理總攬
   - 從站台選擇器升級為跨站表單清單。
   - 顯示表單名稱、slug、狀態、站台、客戶與近 30 天送單數。
   - 頁面標題調整為「表單管理總攬」。
   - 新增唯讀跨站安全提示。
   - 提供「設定嵌入碼」與「進表單管理」入口。
   - 入口僅導向後台管理頁，不送出公開表單、不建立 lead。

4. `src/lib/embed-code.ts`
   - 新增嵌入碼產生相關純函式。
   - 建立 12 個參數契約與 snippet builder。

5. `src/lib/dashboard-metrics.ts`
   - 新增 dashboard 唯讀 count / summary 支援。
   - 僅讀取既有資料表，不寫 DB。

6. `docs/drafts/lead-status-machine.sql`
   - 新增名單狀態機 schema / RLS / GRANT 草案。
   - 此檔案僅為文字草案。
   - 未執行 migration。
   - 未建立 table / constraint / enum / trigger。
   - 未寫入 Supabase。

---

## 3. Explicit Non-Scope

本次明確不包含以下項目：

- 不修改 Supabase schema。
- 不建立或執行 migration。
- 不修改 RLS / GRANT。
- 不修改 secrets。
- 不啟用 Email Router。
- 不啟用 Fallback。
- 不寄信。
- 不 enqueue。
- 不重送 DLQ。
- 不送出表單。
- 不建立 lead。
- 不執行 `docs/drafts/lead-status-machine.sql`。
- 不修改公開表單頁 `embed.forms.$slug.tsx`。
- 不修改 `api/public/forms/submit`。
- 不修改 Email Router。
- 不修改 `notifications.server.ts`。
- 不修改 queue worker。
- 不修改 safe-test flow。
- 不修改 form submit flow。
- 不修改 lead creation flow。
- 不新增 FAQ database backend。
- 不新增月報寄送或排程。

---

## 4. Implementation Files

本次 Deliverable Readiness Sprint v0.1 主要檔案如下：

- `src/lib/embed-code.ts`
- `src/lib/dashboard-metrics.ts`
- `docs/drafts/lead-status-machine.sql`
- `src/routes/_authenticated/admin/embeds.tsx`
- `src/routes/_authenticated/admin/forms.tsx`
- `src/routes/_authenticated/admin/index.tsx`

Publish Preflight 另記錄附帶檔案：

- `.lovable/plan.md`
- `src/integrations/supabase/types.ts`

其中 `src/integrations/supabase/types.ts` 被 Lovable 判定為平台附帶型別同步，不代表實際 DB schema 變更。

---

## 5. Founder Preview and Correction History

Founder Preview 初驗後，發現兩項 UI 說明不足：

1. `/admin` dashboard 看不到清楚的「資料來源」說明，無法確認每張卡的數字來源。
2. `/admin/forms` 看不到清楚提示，無法確認「設定嵌入碼 / 進表單管理」入口只是後台導頁，不會送出表單或建立 lead。

後續修正內容：

- `/admin` 8 張卡新增「來源：」小字說明。
- `/admin/forms` 標題改為「表單管理總攬」。
- `/admin/forms` 新增唯讀導頁安全提示。
- `/admin/forms` 按鈕文字調整為「設定嵌入碼」與「進表單管理」。

Founder Preview 重新驗收結果：PASS。

---

## 6. Publish Preflight Result

Publish Preflight 結果：PASS。

Preflight 主要確認如下：

- HEAD：`cf68b2f4ef44b057404d12607d038b836827ebb6`
- git status：clean
- Typecheck：`bunx tsgo --noEmit` PASS
- `/admin/embeds`：HTTP 200
- `/admin`：HTTP 200
- `/admin/forms`：HTTP 200
- `leads = 18`
- `notification_logs = 49`
- `email_send_log = 57`
- Router：false
- Fallback：false / unset
- `docs/drafts/lead-status-machine.sql` 僅為草案，未執行 migration
- 未修改公開表單頁與 submit API
- 未修改 Email Router、notification、queue、safe-test、form submit、lead creation flow

---

## 7. Publish Result

Publish 結果：PASS。

Publish 前最終確認：

- 完整 HEAD：`cf68b2f4ef44b057404d12607d038b836827ebb6`
- git status：clean
- Typecheck：PASS
- `leads = 18`
- `notification_logs = 49`
- `email_send_log = 57`
- Router：false
- Fallback：false / unset
- `docs/drafts/lead-status-machine.sql` 未執行
- `src/integrations/supabase/types.ts` 僅為平台附帶型別同步，無實際 schema 變更

Lovable publish 工具未回傳 deployment_id。Lovable 回報此為平台限制：publish 為非同步排程，僅回傳 live URL。

Live URL：`https://app.lohashare.com`

---

## 8. Post-Publish Read-only Verification

發布後唯讀驗證結果：PASS。

正式站頁面驗證：

- `/admin`：正常載入
- `/admin/forms`：正常載入
- `/admin/embeds`：正常載入
- `/admin/reports`：正常載入
- `/admin/usage`：正常載入
- `/admin/faq`：正常載入
- `/admin/leads`：正常載入

`/admin` 驗證：

- 8 張卡皆顯示「來源：」說明。
- 來源說明計數 = 8。

`/admin/forms` 驗證：

- 顯示「表單管理總攬」。
- 顯示唯讀跨站安全提示。
- 顯示「設定嵌入碼」。
- 顯示「進表單管理」。
- 入口僅為後台導頁。
- 未送出公開表單。
- 未建立 lead。

`/admin/embeds` 驗證：

- 顯示 12 個 `source_` / `utm_` 欄位。
- 顯示最終 query string。
- 顯示複製嵌入碼。
- 顯示複製公開表單 URL。
- 顯示自動高度 Beta 標示。
- 桌機 / 手機切換為選定表單後才出現的預覽區塊；此為設計行為，不列為缺失。

---

## 9. Safety Verification

發布後安全副作用確認如下：

- 未送出任何公開表單。
- 未點擊任何寄信 / enqueue 功能。
- 未寄信。
- 未 enqueue。
- 未重送 DLQ。
- 未建立 lead。
- `leads = 18`，未變。
- `notification_logs = 49`，未變。
- `email_send_log = 57`，未變。
- Router / Fallback 仍為 false。
- 未修改 Supabase schema / migration / RLS。
- 未修改 secrets。

---

## 10. Non-blocking Observations

本次記錄以下非阻斷觀察：

1. Lovable publish 工具未回傳 deployment_id，僅回傳 live URL。
2. Live URL 為 `https://app.lohashare.com`。
3. `nexus-lead-ops.lovable.app` 會 302 轉往自訂網域。
4. Console 有 1 筆沙箱驗證流程中的 Supabase session `Failed to fetch`，頁面渲染正常，未阻擋驗證。
5. 安全掃描無 critical 阻斷項，僅 TanStack transitive dependency warn，與本次改動無關。

---

## 11. Final Status

Deliverable Readiness Sprint v0.1 最終狀態：

`Archived / Deliverable Readiness Sprint v0.1 Completed / Publish Verified / No Email Sent / No DB Schema Change / No Router Change`
