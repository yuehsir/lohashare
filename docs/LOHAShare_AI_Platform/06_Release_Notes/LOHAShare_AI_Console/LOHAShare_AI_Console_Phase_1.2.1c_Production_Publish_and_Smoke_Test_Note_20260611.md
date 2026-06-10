# LOHAShare AI Console Phase 1.2.1c Production Publish & Smoke Test Note

版本日期：2026-06-11（Asia/Taipei）  
文件狀態：Production Publish & Smoke Test Note / GitHub Archive  
產品化名稱：LOHAShare AI Console / Nexus Lead Ops  
正式治理模組名稱：Lead Console  
對應階段：Phase 1.2.1c — Source / Campaign Reporting Summary  
本階段狀態：Production Stable  
Production URL：`https://app.lohashare.com`  

---

## 1. Summary

Phase 1.2.1c 已完成並通過 production smoke test。

本階段目標是在 Leads page 增加最小可行的「來源摘要」區塊，協助 admin 快速查看：

```text
來源平台分布
來源類型分布
Top UTM Source
Top UTM Campaign
```

正式結論：

```text
Read-only Inspection: Completed
Build: Completed
Code-level Validation: Passed
Interactive Preview Validation: Passed
Production Publish: Completed
Production Smoke Test: Passed
Status: Production Stable
```

---

## 2. Scope

本階段只包含：

```text
1. 新增「來源摘要」區塊
2. Source platform summary
3. Source type summary
4. Top 5 UTM Source
5. Top 5 UTM Campaign
6. 5,000 rows cap
7. no_source 空狀態
8. loading / empty / over-cap friendly messages
```

修改檔案僅包含：

```text
src/routes/_authenticated/admin/sites.$id.leads.index.tsx
```

---

## 3. Build Result

Build 完成後確認：

```text
只修改 1 個檔案
新增區塊位置在既有 4 張 summary cards 下方、filter bar 上方
Source platform summary 顯示 8 platform + no source
Source type summary 顯示 6 source types
Top UTM Source / Campaign 使用 client-side Map reduce
TOP_UTM_CAP = 5000
TOP_UTM_LIMIT = 5
no_source 模式下 Top UTM Source / Campaign 顯示「尚無資料」
```

Source platform summary 包含：

```text
LINE
Instagram
Facebook
TikTok
YouTube
Threads
LinkedIn
Other
無來源
```

Source type summary 包含：

```text
website_form
social_link
line_oa
social_comment
referral
manual_import
```

---

## 4. Preview Validation Result

Preview validation 已完成。

Code-level validation：通過。  
Interactive preview validation：通過。  

Preview data observation：

```text
全部名單：16
LINE：2
無來源：12
Top UTM Source：line 2 / valid_pass 2
Top UTM Campaign：test 1 / prodtest 1
```

Preview validation confirmed：

```text
來源摘要區塊位置正確
9 個來源平台 chips 顯示正常
6 個來源類型 chips 顯示正常
Top UTM Source 排序由大到小，無 NULL / 空字串
Top UTM Campaign 排序由大到小，無 NULL / 空字串
sourcePlatform = 無來源時 Top UTM Source / Campaign 顯示「尚無資料」
utm_source filter 不造成 Top UTM Source 循環收斂
utm_campaign filter 不造成 Top UTM Campaign 循環收斂
既有 4 張 summary cards 無 regression
filter bar / list / pagination / drawer 無 regression
```

5,000 rows cap：

```text
Code-level check passed
Runtime over-cap scenario not triggered due to dataset size
```

---

## 5. Production Publish Result

Phase 1.2.1c 已完成 production publish。

Production URL：

```text
https://app.lohashare.com
```

Publish report：

```text
Publish / Update production：已排程
Build / deployment error：無
實際 publish 檔案：src/routes/_authenticated/admin/sites.$id.leads.index.tsx
src/routeTree.gen.ts：未變更
```

---

## 6. Production Smoke Test Result

Production smoke test 已完成。

結果：

```text
1–14 項：PASS / 全部通過
```

第 15 項：

```text
Pagination / status / date regression：PASS
Status / date filter 正常
目前資料量不足以明確測試 pagination
未見異常
```

第 16 項：

```text
Operator site-scoped 帳號：DEFERRED / 後續補測
目前沒有可用 operator 測試帳號
本階段未修改 RLS / Auth / operator 權限
列為後續補測
```

Production smoke test conclusion：

```text
Phase 1.2.1c Production Smoke Test: PASS
```

---

## 7. CSV / Export Protection

本階段確認未修改：

```text
src/lib/leads.functions.ts
CSV export implementation
CSV headers
CSV row order
Phase 1.2 IN-001 append rule
```

結論：

```text
CSV export / CSV header / CSV row order unchanged
```

---

## 8. Non-goals Confirmation

本階段確認未動：

```text
migration
RLS policies
secrets
router flags
Email Router
Unsubscribe route
UNSUBSCRIBE_BASE_URL
Zoho SMTP
notification dispatch pipeline
app.lohashare.com routing
Edge Functions
Auth flow
Forgot Password / Reset Password
social_lead_candidates
monthly_usage
usage_logs
new server function
RPC
database index
route
sidebar
production settings
```

---

## 9. Known Notes

Security scan：

```text
security scan 對最新 commit 為 stale
本次只動單一 admin 頁面 UI
風險低
建議廣泛分享前重跑
```

Operator site-scoped 帳號補測：

```text
目前沒有可用 operator 測試帳號
本階段未修改 RLS / Auth / operator permissions
不阻擋 Phase 1.2.1c production stable closure
```

---

## 10. Current Status

```text
Phase 1.2.1c Read-only Inspection: Completed
Phase 1.2.1c Build: Completed
Code-level Validation: Passed
Interactive Preview Validation: Passed
Production Publish: Completed
Production Smoke Test: Passed
CSV export / CSV header / CSV row order: Unchanged
Migration / RLS / RPC / server function / index: Unchanged
Non-goals: Protected
Status: Production Stable
Closure: Completed
```

---

## 11. Next Gate Candidates

下一階段可從以下 Gate 擇一：

```text
A. Auth UX Improvement — Forgot Password / Reset Password Flow
B. Phase 1.3 — Source / UTM URL Search Params & Index Evaluation
C. Operator site-scoped 帳號補測與角色測試資料建立
```

建議下一階段仍先執行 read-only inspection，不直接 build。

---

## 12. Closure Statement

Phase 1.2.1c 已完成：

```text
Read-only Inspection → Build → Code-level Validation → Interactive Preview Validation → Production Publish → Production Smoke Test
```

本階段正式標記為：

```text
Production Stable
GitHub Archived
Closed as Completed
```
