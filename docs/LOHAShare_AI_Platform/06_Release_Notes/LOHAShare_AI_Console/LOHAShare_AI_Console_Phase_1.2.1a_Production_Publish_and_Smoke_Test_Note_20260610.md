# LOHAShare AI Console Phase 1.2.1a Production Publish & Smoke Test Note

版本日期：2026-06-10（Asia/Taipei）  
文件狀態：Production Publish & Smoke Test Note / Draft for GitHub Archive  
對應產品化名稱：LOHAShare AI Console / Nexus Lead Ops  
正式治理模組名稱：Lead Console  
對應階段：Phase 1.2.1a — Lead Source Visibility & Reporting  
前一階段狀態：Phase 1.2 — Production Stable  
本階段狀態：Production Stable  
Production URL：`https://app.lohashare.com`  
是否已 Publish / Update production：是  
是否已修改 migration / server function / RLS / secrets / router flags：否  
是否已修改 Email Router / Unsubscribe / Notification dispatch：否  

---

## 1. 文件目的

本文件記錄 LOHAShare AI Console Phase 1.2.1a — Lead Source Visibility & Reporting 的 production publish 結果與 production smoke test 結果。

Phase 1.2.1a 是 Phase 1.2 之後的小步延伸，目的不是新增來源資料欄位，而是讓後台管理者可以在名單管理頁更容易辨識、篩選與初步判讀名單來源。

本文件不是新的 Developer Prompt。  
本文件不是新的 migration 指令。  
本文件不是新的 production publish approval。  
本文件不是 Phase 1.2.1b 或 Phase 1.3 的啟動文件。  

---

## 2. 前置基準

Phase 1.2 已於前一階段正式收尾並標記為 production stable。

Phase 1.2 已完成：

```text
Source / UTM 欄位寫入
Preview validation
Production publish
Production smoke test
Notification smoke test
Notification recipient source check
GitHub release note archive
Status index update
```

Phase 1.2 主要相關 commit：

```text
Developer Prompt v0.3:
db7c232e50b1bde225dade2c2b7de6f0c0ed9310

IN-001:
b8567b329b34c8a67401643807ee770b35ce3900

Build Completion & Preview Validation Note:
1d910ca774b57948dc3e85cbbfbc3728e0876097

Production Publish & Smoke Test Note redacted:
6b366955b75a45383d73bcc1be5d061a645625c8

Status Index Update:
837d0402bed33d868273cbac6da84b052f72ea99
```

---

## 3. Phase 1.2.1a Scope

本次 Phase 1.2.1a 只包含後台名單來源可視化與篩選功能。

已發佈功能範圍：

```text
Lead List Source column
source_platform filter
source_type filter
no_source filter
Source summary cards
```

本階段未包含：

```text
Filter-aware CSV export
完整 Admin Source Report module
任何 migration
任何 server function 修改
任何 Email Router / Unsubscribe / Notification dispatch 修改
任何 social_lead_candidates / 社群平台 API 整合
```

---

## 4. Build Scope 與修改檔案

Lovable 回報本階段 build 修改範圍如下：

```text
src/routes/_authenticated/admin/sites.$id.leads.index.tsx
src/routeTree.gen.ts
```

其中：

```text
src/routes/_authenticated/admin/sites.$id.leads.index.tsx
```

為本階段唯一手動修改檔案。

```text
src/routeTree.gen.ts
```

為自動產生檔案。

未修改：

```text
src/lib/leads.functions.ts
LeadDetailDrawer implementation
CSV export implementation
server functions
migration files
RLS policies
secrets
router flags
Email Router
Unsubscribe route
notification dispatch pipeline
Edge Functions
```

---

## 5. Phase 1.2.1a 功能完成結果

### 5.1 Lead List Source Column

完成：

```text
在 Admin → Leads list 新增 Source column
位置在「表單」欄之後、「狀態」欄之前
```

顯示邏輯：

```text
source_platform + source_type → {platform label} · {source_type}
source_platform only → {platform label}
source_type only → {source_type}
utm_source / utm_campaign fallback → UTM: {utm_source} / {utm_campaign}
無來源資料 → —
```

已確認範例：

```text
phase12-prod-valid → LINE · line_oa
phase12-prod-invalid → UTM: valid_pass / —
phase12-prod-nosource → —
```

結果：PASS

### 5.2 Source Platform Filter

完成：

```text
新增 source_platform filter
包含 8 個平台與 no_source 特殊選項
```

平台範圍：

```text
line
instagram
facebook
tiktok
youtube
threads
linkedin
other
no_source
```

Production smoke test：

```text
Platform = LINE filter：通過
Platform = 無來源 filter：通過
```

結果：PASS

### 5.3 Source Type Filter

完成：

```text
新增 source_type filter
```

source_type 範圍：

```text
website_form
social_link
line_oa
social_comment
referral
manual_import
```

Production smoke test：

```text
Type = line_oa filter：通過
```

結果：PASS

### 5.4 No Source Filter

完成：

```text
source_platform = no_source 時，source_type filter disabled 並被忽略
```

No source 判斷邏輯：

```text
source_type IS NULL
AND source_platform IS NULL
AND utm_source IS NULL
AND utm_campaign IS NULL
```

結果：PASS

### 5.5 Source Summary Cards

完成：

```text
在 Leads 頁面 header 下方、filter bar 上方新增 4 張 cards
```

cards：

```text
全部名單
LINE 名單
社群名單
無來源名單
```

確認：

```text
Summary cards 顯示正確
Source filter 不影響 summary cards，避免循環統計
```

結果：PASS

---

## 6. Preview Validation Summary

Phase 1.2.1a Preview validation 已完成。

Preview validation 通過項目：

```text
Preview build 正常開啟
Admin → Leads 頁面正常載入
Source column 顯示正確
Source summary cards 顯示正確
source_platform filter 正常
source_type filter 正常
no_source filter 正常
Lead Detail Drawer Source section 正常
CSV export trigger 正常
CSV header 尾端 12 個 source / UTM 欄位確認齊全
既有 filters / pagination 無明顯 regression
Non-goals 未動
```

Preview validation 結論：

```text
Phase 1.2.1a Preview validation completed
No production publish had been performed at preview validation stage
```

---

## 7. Production Publish Result

Production publish 已執行並完成。

Production URL：

```text
https://app.lohashare.com
```

Lovable URL：

```text
https://nexus-lead-ops.lovable.app
```

Lovable 回報：

```text
No build / deployment errors
Publish accepted successfully
Only Phase 1.2.1a changes deployed
No new code change, migration, schema change, server function change, or setting change introduced during publish
```

結果：PASS

---

## 8. Production Smoke Test Result

使用者已於 production 正式站執行 Phase 1.2.1a production smoke test。

Production smoke test 結果：

```text
1. Leads page 正常載入：通過
2. Source column：通過
3. Source summary cards：通過
4. Platform = LINE filter：通過
5. Platform = 無來源 filter：通過
6. Type = line_oa filter：通過
7. Lead Detail Drawer Source section：通過
8. CSV export header：通過
9. 既有 filters / pagination：通過
```

結論：

```text
Phase 1.2.1a Production Smoke Test: PASS
```

---

## 9. CSV Export Regression Check

CSV export implementation 本階段未修改。

已確認：

```text
CSV export 可下載
CSV header 最後 12 欄仍為 Phase 1.2 source / UTM 欄位
既有 CSV 欄位順序未被 Phase 1.2.1a 變更
```

尾端 12 欄：

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

## 10. Lead Detail Drawer Regression Check

Lead Detail Drawer implementation 本階段未修改。

已確認：

```text
Lead Detail Drawer 可正常開啟
Source section 可正常展開
Source section 顯示 12 個 source / UTM 欄位
source_platform / source_type / utm_source / utm_campaign 顯示正確
列表 Source column 與 Drawer Source section 顯示一致
```

結果：PASS

---

## 11. Non-goals Confirmation

本階段 production publish 後，以下項目確認未動：

```text
migration
server functions
src/lib/leads.functions.ts
CSV export implementation
Lead Detail Drawer implementation
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
social_lead_candidates table
monthly_usage
usage_logs
social platform APIs
```

結果：PASS

---

## 12. Current Status

```text
Phase 1.2.1a Build: Completed
Preview Validation: Passed
Production Publish: Completed
Production Smoke Test: Passed
Lead Detail Drawer Regression Check: Passed
CSV Export Regression Check: Passed
Existing Filters / Pagination Regression Check: Passed
No Migration: Confirmed
No Server Function Change: Confirmed
No Email Router / Unsubscribe / RLS / secrets / router flags Changes: Confirmed
Production Stable: Yes
```

正式狀態：

```text
Phase 1.2.1a production stable
```

---

## 13. Known Notes

### 13.1 Operator Account Test

Lovable 建議可用 operator account 補測 site-scoped access。

本階段未修改 RLS，也未修改 operator access control。若目前沒有可用 operator 帳號，可列為後續補測，不阻擋 Phase 1.2.1a stable。

### 13.2 Filter-aware CSV Export

Filter-aware CSV export 本階段未做。

建議列為：

```text
Phase 1.2.1b
```

### 13.3 Forgot Password / Reset Password Flow

登入過程中曾發現 production login page 目前沒有 Forgot Password / Reset Password flow。

使用者已找到密碼並成功登入，因此本階段不處理 Auth flow。

建議列為後續獨立小型 Gate：

```text
Auth UX Improvement — Forgot Password / Reset Password Flow
```

不應混入 Phase 1.2.1a stable closure。

---

## 14. Recommended Closure Status

建議正式標記：

```text
Phase 1.2.1a — Lead Source Visibility & Reporting
Status: Production Stable
Closed as: Completed
```

不建議在 Phase 1.2.1a gate 內繼續追加功能。

---

## 15. Next Gate Candidates

### 15.1 Phase 1.2.1b — Filter-aware CSV Export & Source Reporting Improvements

建議優先度：高  
風險：低至中  

可能範圍：

```text
Filter-aware CSV export
utm_source filter
utm_campaign filter
Top campaign card
Source report improvements
```

### 15.2 Auth UX Improvement — Forgot Password / Reset Password Flow

建議優先度：中  
風險：中  

可能範圍：

```text
Forgot Password link
Password recovery email handling
Reset Password route
Recovery hash handling
Supabase Auth password update flow
```

注意：

```text
此項屬 Auth UX / Security flow，需獨立 Gate，不應混入 Lead Source Reporting。
```

### 15.3 Phase 1.3 — Social Lead Candidate Pipeline

建議優先度：中  
風險：中至高  

可能範圍：

```text
social_lead_candidates
社群留言 / 私訊名單候選
人工審核後轉 lead
LINE / FB / IG / YouTube 等來源延伸
```

建議先產 PRD / Developer Prompt Candidate，不建議直接 Build。

---

## 16. Recommended GitHub Archive Path

建議歸檔路徑：

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/LOHAShare_AI_Console_Phase_1.2.1a_Production_Publish_and_Smoke_Test_Note_20260610.md
```

建議 commit message：

```text
docs: add Phase 1.2.1a production publish and smoke test note
```

---

## 17. Final Closure Statement

Phase 1.2.1a 已完成：

```text
Planning Brief → Read-only Inspection → Build → Preview Validation → Production Publish → Production Smoke Test
```

本階段正式標記為 production stable。

下一步應先歸檔本文件，再另開新 Gate，避免在 stable closure 中混入新功能。
