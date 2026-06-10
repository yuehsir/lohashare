# LOHAShare AI Console Phase 1.2.1b Production Publish & Smoke Test Note

版本日期：2026-06-11（Asia/Taipei）
文件狀態：Production Publish & Smoke Test Note / GitHub Archive
產品化名稱：LOHAShare AI Console / Nexus Lead Ops
正式治理模組名稱：Lead Console
對應階段：Phase 1.2.1b — Filter-aware CSV Export + UTM Filters
本階段狀態：Production Stable

---

## 1. Summary

Phase 1.2.1b 已完成並通過 production smoke test。

本階段目標是讓 Leads page 的 source / UTM 篩選條件與 CSV export 結果一致，補齊 Phase 1.2.1a 後留下的 CSV 匯出差距。

正式結論：

```text
Build: Completed
Preview Validation: Passed
Manual CSV Preview Validation: Passed
Production Publish: Completed
Production Smoke Test: Passed
Status: Production Stable
```

---

## 2. Scope

本階段僅包含：

```text
A. Filter-aware CSV export
B. utm_source / utm_campaign filter UI
```

新增 CSV export filters：

```text
sourcePlatform
sourceType
utmSource
utmCampaign
```

新增 Leads page filters：

```text
utm_source
utm_campaign
```

no_source 模式使用 4-NULL 條件：

```text
source_type IS NULL
source_platform IS NULL
utm_source IS NULL
utm_campaign IS NULL
```

---

## 3. Files Changed

Lovable 回報本階段實際修改檔案：

```text
src/lib/leads.functions.ts
src/routes/_authenticated/admin/sites.$id.leads.index.tsx
```

`src/routeTree.gen.ts` 未變更，因為未新增、移除或改名 route file。

---

## 4. Build Result

Build 完成結果：

```text
exportLeadsCsv input 支援 sourcePlatform / sourceType / utmSource / utmCampaign
buildQuery 加入 source / UTM filter logic
Leads page 新增 utmSource / utmCampaign state
Leads page 新增 utm_source / utm_campaign text inputs
queryKey 加入 utmSource / utmCampaign
export mutation payload 傳入新增 filters
no_source 模式下 sourceType / utmSource / utmCampaign disabled 並忽略
```

Typecheck / build：通過。

---

## 5. CSV Header / Row Order

本階段未修改 CSV headers 或 row order。

Phase 1.2 IN-001 append rule 保留。

CSV 尾端 12 欄仍為：

```text
source_type
source_platform
source_channel
source_content_url
source_campaign_id
source_campaign_name
source_landing_url
utm_source
utm_medium
utm_campaign
utm_content
utm_term
```

結果：PASS

---

## 6. Preview Validation

Preview validation 已完成並通過。

測試重點：

```text
Leads page 載入正常
既有 filters 正常
utm_source input 顯示與 ilike 篩選正常
utm_campaign input 顯示與 ilike 篩選正常
no_source 模式下 3 個相關欄位 disabled
no_source list 套用 4-NULL
CSV header / row order 未變
Lead Detail Drawer 無 regression
Pagination / status / date filters 無 regression
```

結果：PASS

---

## 7. Manual CSV Preview Validation

因 browser automation 無法擷取 blob download，使用者已手動完成 CSV preview validation。

結果：

```text
LINE CSV: Passed
utm_source CSV: Passed
utm_campaign CSV: Passed
no_source CSV: Passed
CSV header last 12 columns: Passed
```

結果：PASS

---

## 8. Production Publish

Production publish 已完成。

Publish 範圍僅包含 Phase 1.2.1b 已驗證通過之 build。

Publish 後確認：

```text
No build/deployment error
No additional schema or database changes
No new reporting cards
No new server function / RPC / index
CSV header / row order unchanged
IN-001 append rule preserved
```

結果：PASS

---

## 9. Production Smoke Test

使用者已於 production 正式站完成 Phase 1.2.1b production smoke test。

測試項目：

```text
1. Leads page 正常載入
2. 既有 filters 正常
3. utm_source filter 正常
4. utm_campaign filter 正常
5. no_source 模式 disabled 行為正常
6. no_source list 4-NULL 正常
7. LINE CSV export 正常
8. utm_source CSV export 正常
9. utm_campaign CSV export 正常
10. no_source CSV export 正常
11. CSV header 最後 12 欄正確
12. Drawer / pagination / status / date 無 regression
```

使用者回報：

```text
Phase 1.2.1b Production Smoke Test
1–12 項全部通過
```

結果：PASS

---

## 10. Non-goals Confirmation

本階段未執行以下事項：

```text
migration
RLS policy changes
Email Router changes
Unsubscribe changes
notification dispatch changes
app routing changes
Edge Function changes
Auth flow changes
Forgot Password / Reset Password changes
social lead candidate features
monthly usage features
usage log features
Top UTM Source summary cards
Top UTM Campaign summary cards
new server function
new RPC
new database index
```

結果：PASS

---

## 11. Current Status

```text
Phase 1.2.1b Read-only Inspection: Completed
Phase 1.2.1b Build: Completed
Preview Validation: Passed
Manual CSV Preview Validation: Passed
Production Publish: Completed
Production Smoke Test: Passed
CSV Header / Row Order: Unchanged
IN-001 Append Rule: Preserved
Production Stable: Yes
```

正式狀態：

```text
Phase 1.2.1b production stable
```

---

## 12. Known Notes

### 12.1 Source / Campaign Reporting Summary

Top UTM Source / Top UTM Campaign summary cards 未包含於本階段，建議另開：

```text
Phase 1.2.1c — Source / Campaign Reporting Summary
```

### 12.2 Auth UX Improvement

Forgot Password / Reset Password Flow 未包含於本階段，建議另開獨立 Gate：

```text
Auth UX Improvement — Forgot Password / Reset Password Flow
```

### 12.3 Phase 1.3 Candidates

後續可評估：

```text
Filters 寫入 URL search params
Source / UTM index 評估
大量資料查詢效能優化
可分享的 Leads filtered view
```

---

## 13. Closure Statement

Phase 1.2.1b 已完成：

```text
Read-only Inspection → Build → Preview Validation → Manual CSV Preview Validation → Production Publish → Production Smoke Test
```

本階段正式標記為 production stable，並建議 closed as completed。
