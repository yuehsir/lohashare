# LOHAShare AI Console Phase 1.3 URL Search Params Production Publish & Smoke Test Note

版本日期：2026-06-11（Asia/Taipei）  
文件狀態：Production Publish & Smoke Test Note / GitHub Archive  
產品化名稱：LOHAShare AI Console / Nexus Lead Ops  
正式治理模組名稱：Lead Console  
對應階段：Phase 1.3 — Source / UTM URL Search Params Sync  
Production URL：`https://app.lohashare.com`  
本階段狀態：Production Smoke Test Passed / Archived  

---

## 1. 文件目的

本文件記錄 Phase 1.3 — Source / UTM URL Search Params Sync 的 read-only inspection、build、preview validation、publish、production smoke test 與最終狀態。

本階段目標是讓 Lead Console 既有篩選條件與 URL search params 同步，使管理者可複製篩選後 URL、重新整理後保留篩選狀態、以新分頁重現查詢結果，並支援未來 dashboard / report deep link。

---

## 2. 前置狀態

進入 Phase 1.3 前，以下階段已完成並歸檔：

```text
Phase 1.2：Production Stable / GitHub Archived
Phase 1.2.1a：Production Stable / GitHub Archived
Phase 1.2.1b：Production Stable / GitHub Archived
Phase 1.2.1c：Production Stable / GitHub Archived
Phase 1.2.1d：Closed as Completed / GitHub Archived
Auth UX Improvement Phase A：Closed as Completed / GitHub Archived
```

---

## 3. Read-only Inspection 結論

Read-only inspection 結論：

```text
可行
風險低
建議只做 URL sync
Index 已齊全，本階段不新增 index
URL sync 與 index evaluation 應拆成不同 Gate
```

現有 filter 狀態：

```text
formId
status
from / to
q
sourcePlatform
sourceType
utmSource
utmCampaign
page
leadId
```

Inspection 發現：

```text
1. 所有 filters 皆為 local state
2. list / summary / CSV 均已使用這些 filters
3. filters 尚未同步到 URL
4. reload page 後 filters / page 會遺失
5. leadId 已作為 drawer URL state
6. no_source 已以 sourcePlatform === "no_source" 特殊值處理
```

---

## 4. Index Evaluation 結論

`public.leads` 既有 indexes：

```text
idx_leads_created
idx_leads_customer
idx_leads_form
idx_leads_site
idx_leads_status
leads_source_platform_idx
leads_source_type_idx
leads_source_campaign_id_idx
leads_utm_source_idx
leads_utm_campaign_idx
leads_pkey
```

結論：

```text
Phase 1.2 已建立 source / UTM 單欄 indexes
site_id / form_id / status / created_at 單欄 indexes 已存在
目前 leads_total = 17
資料量極小，不需要新增 composite index
本階段不做 migration
等 production leads 達 10k–50k 並有 EXPLAIN ANALYZE slow query 證據後，再評估 composite index
```

---

## 5. Build Scope

本階段 Build 目標：

```text
URL search params sync for existing Lead Console filters only
```

實際發布檔案清單：

```text
src/routes/_authenticated/admin/sites.$id.leads.index.tsx
src/routeTree.gen.ts
```

其中：

```text
src/routeTree.gen.ts
```

為 TanStack Router auto-generated 變更，非手動修改。

未修改：

```text
src/lib/leads.functions.ts
supabase/migrations/*
RLS policies
schema
secrets
CSV header
CSV row order
Email Router
Unsubscribe
UNSUBSCRIBE_BASE_URL
Zoho SMTP
notification dispatch pipeline
Edge Functions
social_lead_candidates
monthly_usage
usage_logs
production settings
user account
role assignment
site access assignment
operator QA fixture
Auth flow
login
reset-password
public signup
register
```

未新增：

```text
new filters
utm_medium
utm_content
composite index
migration
server function signature change
new package
public signup
/register
```

---

## 6. URL Search Params Schema

Phase 1.3 支援以下 search params：

```text
form_id
status
from
to
q
source_platform
source_type
utm_source
utm_campaign
page
leadId
```

設計原則：

```text
URL search params as single source of truth
Default / empty values omitted
page is 1-based in URL
page=1 omitted
leadId preserved for drawer state
Invalid query fallback is safe and does not throw
```

範例：

```text
?form_id=<uuid>
?status=new
?from=2026-06-01
?to=2026-06-30
?q=keyword
?source_platform=line
?source_type=line_oa
?utm_source=LINE
?utm_campaign=prodtest
?page=2
?leadId=<uuid>
```

---

## 7. no_source 設計

沿用現有設計：

```text
source_platform=no_source
```

未新增：

```text
no_source=1
```

互斥規則：

```text
source_platform=no_source 時，URL 不應同時包含：
source_type
utm_source
utm_campaign
```

本階段已完成：

```text
no_source mutex behavior
source_type cleanup
utm_source cleanup
utm_campaign cleanup
list / summary / CSV 使用相同 search-derived filter 語意
```

---

## 8. Implementation Summary

Build 回報摘要：

```text
parseLeadsSearch：plain TypeScript safe parser，無新套件
每個欄位皆 safe fallback
UUID regex validation
status enum validation
date YYYY-MM-DD validation
platform/type enum validation
page >= 2 validation
trim strings
invalid values silently dropped
never throws
```

移除 local state：

```text
formId
status
from
to
q
sourcePlatform
sourceType
utmSource
utmCampaign
page
```

改為：

```text
Route.useSearch()
```

`updateSearch` helper 已完成：

```text
strips defaults
trims q / utm_source / utm_campaign
handles no_source mutex
resets page when filters change
keeps page only when pagination changes
uses replace: true for filter changes
preserves filters when opening / closing drawer
```

---

## 9. Preview Validation

Preview URL：

```text
https://id-preview--8a6788ab-4762-4e8a-9953-5f351ec760a0.lovable.app
```

測試 site：

```text
site_id = 169aa3ac-644c-4ad9-8cb1-7c4e172b9f1b
```

Preview Validation 手動結果：

```text
1. 無 query 預設載入是否正常：是
2. status URL sync 是否通過：是
3. form_id URL sync 是否通過：是
4. date range URL sync 是否通過：是
5. q trim / URL sync 是否通過：是
6. source_platform URL sync 是否通過：是
7. source_type URL sync 是否通過：是
8. utm_source / utm_campaign URL sync 是否通過：是
9. no_source 互斥是否通過：是
10. pagination URL sync 是否通過：是
11. filter change reset page 是否通過：是
12. reload 後 filters / page 是否保留：是
13. 複製 URL 到新分頁是否可重現同樣結果：是
14. browser back / forward：通過，但註記 history stack 包含 drawer leadId state
15. drawer leadId 是否保留 filters：是
16. CSV export 是否仍正常：是
17. invalid query fallback 是否安全：是
18. operator scope regression：未完整互動測；因本次未改 RLS / site access / leads.functions.ts / operator fixture，標記為低風險，Production Smoke 補測或註記
19. 是否有 console / runtime error：無
20. 是否確認未 Publish：是
```

第 14 項說明：

```text
openLead / closeLead 會 push drawer URL state。
filter changes 使用 replace: true，避免每次輸入都污染 history。
因此 Back 回到 leadId drawer state、Forward 回到 filter-only state，屬於可接受行為，不是 bug。
```

---

## 10. Publish Pre-confirmation

Publish 前確認結果：

```text
Preview Validation：Passed
Diff scope：Accepted
routeTree.gen.ts：auto-generated / accepted
Forbidden scope：Clean
Security scan：Passed
Metadata check：Passed
Runtime risk：Low
Publish：Pending at that time
```

Security scan note：

```text
Publish tool 回報 security scan 對 latest commit 為 stale。
本 Phase 純前端 URL state 重構，未動 RLS / functions / schema，不引入新的後端風險，因此不阻擋本次 Publish。
若進入更廣範圍分享或 Phase 1.4，可重新跑 security scan 更新 baseline。
```

---

## 11. Production Publish

Production Publish 狀態：

```text
Published / Completed
```

Production URL：

```text
https://app.lohashare.com
```

Published commit：

```text
ef649ed
```

發布檔案：

```text
src/routes/_authenticated/admin/sites.$id.leads.index.tsx
src/routeTree.gen.ts
```

Build / deployment error：

```text
None
```

---

## 12. Adjusted Production Smoke Test

因 Phase 1.3 是前端 URL search params sync，且 Preview 已完成完整互動驗證，Production Smoke Test 採取最小人工確認，不完整重跑所有 Preview filter 組合。

使用者人工確認結果：

```text
1. https://app.lohashare.com 可登入並進入 Leads 頁：通過
2. 任一 filter 可寫入 URL：通過
   - 測試例：status=new
   - URL 會出現 ?status=new
3. CSV export 可下載：通過
```

Lovable final confirmation：

```text
1. Production deployment 是否完成：完成
2. build / deployment error：無
3. runtime error：無，read_runtime_errors 回傳 No runtime errors found
4. production diff scope 是否仍正確：是
5. forbidden scope 是否未改：全部未動
6. invalid query fallback 標記接受：Preview passed; not re-tested in authenticated production session
7. operator scope 低風險標記接受：not fully retested in production; no RLS / site access / leads.functions.ts / operator fixture changes in Phase 1.3; risk remains low
8. 是否可進入 GitHub Archive Note：可以
```

---

## 13. Operator Scope Note

Production 未完整互動重測 operator scope。

正式註記：

```text
operator scope not fully retested in production;
no RLS / site access / leads.functions.ts / operator fixture changes in Phase 1.3;
risk remains low.
```

理由：

```text
Phase 1.3 只改前端 URL state。
未修改 RLS、has_site_access、leads.functions.ts、operator_site_access、user_roles 或 operator QA fixture。
URL query params 不應改變 server-side authorization boundary。
```

---

## 14. CSV Regression Note

CSV export 經 production minimal smoke 確認可下載。

本階段未修改：

```text
CSV header
CSV row order
src/lib/leads.functions.ts
server function signature
```

CSV filter 參數來源改為 search-derived values，但下游語意維持一致。

---

## 15. Non-change Verification

本階段確認未修改：

```text
migration
RLS
schema
secrets
CSV header
CSV row order
Email Router
Unsubscribe
UNSUBSCRIBE_BASE_URL
Zoho SMTP
notification dispatch pipeline
Edge Functions
social_lead_candidates
monthly_usage
usage_logs
production settings
user / role / site access
operator QA fixture
Auth flow
login
reset-password
public signup
register
```

---

## 16. Final Status

Phase 1.3 final status：

```text
Read-only Inspection：Completed
Build：Completed
Preview Validation：Passed
Publish Pre-confirmation：Passed
Production Publish：Completed
Adjusted Production Smoke Test：Passed
GitHub Archive：Completed
Status：Production Stable
Closure：Closed as Completed
```

---

## 17. GitHub Archive Path

Path：

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/LOHAShare_AI_Console_Phase_1.3_URL_Search_Params_Production_Publish_and_Smoke_Test_Note_20260611.md
```

Commit message：

```text
docs: add Phase 1.3 URL search params production smoke test note
```

---

## 18. Closure Statement

Phase 1.3 — Source / UTM URL Search Params Sync has been published to production and smoke tested.

Final status：

```text
Production Stable
Adjusted Production Smoke Test Passed
No forbidden scope changes
No migration / RLS / schema changes
No CSV header / row order changes
GitHub Archived
Closed as Completed
```
