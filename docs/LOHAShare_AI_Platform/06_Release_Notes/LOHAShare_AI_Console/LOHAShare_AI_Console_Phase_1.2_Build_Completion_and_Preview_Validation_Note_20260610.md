# LOHAShare AI Console Phase 1.2 Build Completion & Preview Validation Note

版本日期：2026-06-10（Asia/Taipei）  
文件狀態：Build Completion & Preview Validation Note / Draft for GitHub Archive  
對應產品化名稱：LOHAShare AI Console / Nexus Lead Ops  
正式治理模組名稱：Lead Console  
對應階段：Phase 1.2 — Social / LINE OA Lead Tracking MVP  
是否已 Publish / Update production：否  
是否已修改 Email Router / Unsubscribe / RLS / secrets / router flags：否  

---

## 1. 文件目的

本文件記錄 LOHAShare AI Console Phase 1.2 — Social / LINE OA Lead Tracking MVP 的 Build 完成結果、Preview 驗證結果、暫時授權 Preview domain 的收尾、以及尚未進入 Production Publish 的狀態。

本文件不是 Production Release Note。  
本文件不是 Publish approval。  
本文件不是 migration rollback 指令。  
本文件不是新的 Developer Prompt。  

本文件用途：

1. 作為 Phase 1.2 Build 完成後的驗收紀錄。
2. 記錄 Preview validation 已通過，但尚未 Publish / Update production。
3. 記錄此次 Build 僅限 Social / LINE OA Lead Tracking MVP，不包含 Email Router / Unsubscribe / Production Update。
4. 作為未來是否進入 Production Publish Gate 的前置依據。

---

## 2. 依據文件與 GitHub 記錄

### 2.1 Developer Prompt 單一可信來源

本次 Build 依據以下已歸檔文件：

```text
docs/LOHAShare_AI_Platform/05_Developer_Prompts/LOHAShare_AI_Console/Current/LOHAShare_AI_Console_v2.0_Lovable_Developer_Prompt_Candidate_v0.3_20260610.md
```

### 2.2 IN-001 補登記錄

已於 v0.3 文件中補登：

```text
IN-001: CSV Export — Source/UTM Column Placement
```

IN-001 決策：

- 12 個 source / UTM 欄位 append 到既有 CSV headers 尾端。
- 不插入中間。
- 目的為避免既有 BI / Excel / Google Sheet 欄位索引位移。
- 此 note 僅影響 CSV header 位置，不影響 DB schema、submit route、LeadDetailDrawer、trigger blocklist 或其他 Phase 1.2 決策。

### 2.3 GitHub commit 記錄

v0.3 Developer Prompt 原始歸檔 commit：

```text
db7c232e50b1bde225dade2c2b7de6f0c0ed9310
```

IN-001 補登 commit：

```text
b8567b329b34c8a67401643807ee770b35ce3900
```

---

## 3. Phase 1.2 Build Scope

Phase 1.2 Build 僅包含以下 5 項：

1. Migration：
   - `public.leads` 新增 12 個 nullable text 欄位。
   - 建立 5 個 btree index。
   - 同步更新 `leads_restrict_operator_update` trigger blocklist。

2. `/api/public/forms/submit`：
   - 支援 `source: {...}` payload。
   - 新增 zod schema / whitelist validation / length cap。
   - invalid whitelist value 不 reject 整筆 submission。

3. `src/routes/embed.forms.$slug.tsx`：
   - SSR-safe 讀取 query string / referrer / href。
   - 組成 `source: {...}` payload。
   - query string 優先於 hidden fields。

4. `LeadDetailDrawer`：
   - 新增「來源 Source」collapsible 區塊。
   - 全部 source / UTM 欄位為 NULL 時隱藏。

5. `exportLeadsCsv`：
   - 依 IN-001 append 12 個 source / UTM 欄位到 CSV headers 尾端。
   - BOM / CAP 10000 / escaping / 既有欄位順序不變。

---

## 4. Migration 完成結果

### 4.1 Migration 狀態

Migration 已成功執行至 connected database。

### 4.2 新增欄位

`public.leads` 已新增以下 12 個 nullable text 欄位：

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

欄位性質：

- nullable
- text
- no default
- no DB enum
- no check constraint
- no backfill

### 4.3 新增 index

已新增 5 個 btree index：

```text
leads_source_type_idx
leads_source_platform_idx
leads_source_campaign_id_idx
leads_utm_source_idx
leads_utm_campaign_idx
```

### 4.4 Trigger 更新

已更新：

```text
leads_restrict_operator_update
```

更新方式：

- 透過 `pg_get_functiondef` 讀取原完整函式定義。
- 保留原 16 個既有 blocklist 欄位。
- 附加 12 個 source / UTM 新欄位。
- admin bypass logic 保留。
- operator 只可更新允許欄位，source / UTM 欄位不得被 operator 修改。
- 欄位、index、trigger 更新於單一 transaction 中完成。

### 4.5 Migration 注意事項

Lovable 回報 linter warnings 為既有警告，例如 search_path / SECURITY DEFINER 相關警告，非本次 migration 新增。

---

## 5. Code Build 完成結果

### 5.1 修改檔案清單

本次 code edits 僅修改以下 4 個檔案：

```text
src/routes/api/public/forms/submit.ts
src/routes/embed.forms.$slug.tsx
src/components/admin/LeadDetailDrawer.tsx
src/lib/leads.functions.ts
```

另有一個 migration 檔案：

```text
supabase/migrations/20260609184643_*.sql
```

自動生成檔案：

```text
types.ts
routeTree.gen.ts
```

### 5.2 submit route

`src/routes/api/public/forms/submit.ts` 完成：

- 新增 `SOURCE_PLATFORMS` 8 值白名單。
- 新增 `SOURCE_TYPES` 6 值白名單。
- 新增 `SourceFieldSchema`，包含 trim 與 500 chars 上限。
- 新增 `SourceSchema`，12 個 optional source / UTM 欄位。
- 新增 `normalizeSource()`。
- `source_platform` / `source_type` 會 `.toLowerCase().trim()` 後進行白名單比對。
- invalid whitelist value 靜默轉為 NULL。
- 不 reject 整筆 lead submission。
- 其他 source / UTM 欄位 trim 後寫入。
- insert 時展開 sourceFields 寫入 lead row。

白名單：

```text
source_platform:
tiktok, instagram, youtube, threads, facebook, linkedin, line, other

source_type:
website_form, social_link, line_oa, social_comment, referral, manual_import
```

### 5.3 embed form

`src/routes/embed.forms.$slug.tsx` 完成：

- 使用 SSR-safe `useEffect`。
- 僅在 client 讀取：
  - `window.location.search`
  - `window.location.href`
  - `document.referrer`
- 解析 query string 中 12 個 source / UTM keys。
- 組成 `source: {...}` payload。
- query string 優先於 hidden `source__*` fields。
- 舊 embed snippets 繼續可用。
- `page_url` 使用 captured `pageHref` state。

### 5.4 LeadDetailDrawer

`src/components/admin/LeadDetailDrawer.tsx` 完成：

- 新增 `<SourceSection lead={lead} />`。
- 放置於 info tab 的 User-Agent 欄位後。
- 顯示 12 個 source / UTM 欄位。
- 若 12 欄全部 NULL / empty，SourceSection return null，不顯示整個區塊。
- `source_content_url` 與 `source_landing_url` 使用外部連結開啟：
  - `target="_blank"`
  - `rel="noopener noreferrer"`
- 純 additive display，不影響 status change / notes / activity timeline。

### 5.5 CSV export

`src/lib/leads.functions.ts` 完成：

- 依 IN-001 將 12 個 source / UTM 欄位 append 到 CSV headers 尾端。
- 欄位順序為：

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

保持不變：

- BOM
- CAP 10000
- escaping
- 既有欄位順序
- `null` / `undefined` 輸出為空字串

---

## 6. Typecheck 與 Build 檢查

Lovable 回報：

```text
bunx tsc --noEmit → exit 0, no errors
```

過程中曾出現一個 transient error：

```text
Cannot find name 'SourceSection'
```

已於同一回合修正，最終 typecheck clean。

另有一次 intermediate mistake：

```text
ACTION_LABEL 曾被意外清空
```

已立即恢復。

目前無 remaining TypeScript errors。

---

## 7. Preview Domain 驗證設定與收尾

### 7.1 問題背景

初次使用 Preview URL 測試時出現：

```text
此網域未獲授權，無法送出。
```

原因為 Preview host 未列入 `allowed_domains`。

### 7.2 Preview host 暫時授權

為完成 Preview validation，曾暫時新增以下 allowed domain：

```text
id-preview--8a6788ab-4762-4e8a-9953-5f351ec760a0.lovable.app
```

對應：

```text
site_id: 169aa3ac-644c-4ad9-8cb1-7c4e172b9f1b
form slug: contact
site name: LOHAShare 官網測試站
```

此變更為純資料設定變更：

- 無 code 修改
- 無 Publish / Update production
- 無 RLS 修改
- 無 secrets 修改
- 無 router flags 修改

### 7.3 Preview host 收尾移除

Preview validation 完成後，已移除上述 Preview allowed domain。

驗證結果：

```text
allowed_domains 已不再包含 id-preview--8a6788ab-4762-4e8a-9953-5f351ec760a0.lovable.app
查詢回傳 0 筆
```

---

## 8. Preview Validation 測試結果

### 8.1 Valid source / UTM submission

測試 email：

```text
phase12-preview-valid@lohashare.test
```

測試 URL：

```text
https://id-preview--8a6788ab-4762-4e8a-9953-5f351ec760a0.lovable.app/embed/forms/contact?utm_source=line&utm_campaign=test&source_platform=line&source_type=line_oa
```

SQL 驗證結果：

```text
created_at: 2026-06-10 10:54:51 UTC
source_type = line_oa
source_platform = line
utm_source = line
utm_campaign = test
```

結果：PASS

### 8.2 Invalid whitelist submission

測試 email：

```text
phase12-preview-invalid@lohashare.test
```

測試 URL：

```text
https://id-preview--8a6788ab-4762-4e8a-9953-5f351ec760a0.lovable.app/embed/forms/contact?source_platform=invalid_xyz&source_type=bad_type&utm_source=valid_pass
```

SQL 驗證結果：

```text
created_at: 2026-06-10 10:56:01 UTC
source_type = NULL
source_platform = NULL
utm_source = valid_pass
utm_campaign = NULL
```

結果：PASS

判斷：

- invalid `source_type` 已被清成 NULL。
- invalid `source_platform` 已被清成 NULL。
- `utm_source` 為 passthrough，成功寫入 `valid_pass`。
- lead 沒有因 invalid whitelist value 被 reject。

### 8.3 No source submission

測試 email：

```text
phase12-preview-nosource@lohashare.test
```

測試 URL：

```text
https://id-preview--8a6788ab-4762-4e8a-9953-5f351ec760a0.lovable.app/embed/forms/contact
```

SQL 驗證結果：

```text
created_at: 2026-06-10 10:56:44 UTC
All 12 source / UTM fields = NULL
```

結果：PASS

預期：

- lead 成功建立。
- 12 個 source / UTM 欄位全部 NULL。
- LeadDetailDrawer 的「來源 Source」區塊應隱藏。

---

## 9. Non-Goals 確認

Lovable 已確認本次未修改：

```text
Email Router
Unsubscribe route
UNSUBSCRIBE_BASE_URL
Zoho SMTP
RLS policies
secrets
router flags
app.lohashare.com routing
social platform APIs
social_lead_candidates
Lead List platform filter
Admin Source Report
Form Editor
monthly_usage
usage_logs
Edge Functions
```

Production 狀態：

```text
No Publish
No Update production
```

---

## 10. Production 狀態與注意事項

### 10.1 尚未 Publish

目前 Phase 1.2 code patch 僅存在於 Preview build。

尚未執行：

```text
Publish
Update production
app.lohashare.com production update
```

### 10.2 Production domain 測試注意

`nexus-lead-ops.lovable.app` 與 `app.lohashare.com` 指向 production deployment。

在未 Publish Phase 1.2 前，使用 app.lohashare.com 測試不會驗到 Phase 1.2 新 code。

先前以 app.lohashare.com 送出的 lead，其 12 個 source / UTM 欄位皆為 NULL，這是因為 production 尚未包含 Phase 1.2 patch，非本次功能錯誤。

---

## 11. Remaining Issues

### 11.1 Phase 1.2 related issues

目前無 Phase 1.2 related blocking issue。

### 11.2 Pre-existing warnings

以下警告為既有問題，非 Phase 1.2 新增：

```text
hydration mismatch data-google-analytics-opt-out
DialogContent missing Description
search_path / SECURITY DEFINER warning on unrelated functions
```

這些不阻擋 Phase 1.2 Preview validation。

---

## 12. Current Status

```text
Phase 1.2 Migration: Completed
Phase 1.2 Code Build: Completed
TypeScript Check: Passed
Preview Validation: Passed
Temporary Preview allowed domain: Removed
Production Publish / Update: Not performed
Email Router / Unsubscribe / RLS / secrets / router flags: Not modified
```

---

## 13. Recommended Next Steps

### 13.1 建議立即下一步

將本文件歸檔至 GitHub。

建議路徑：

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/LOHAShare_AI_Console_Phase_1.2_Build_Completion_and_Preview_Validation_Note_20260610.md
```

### 13.2 Production Publish Gate

完成本文件歸檔後，若要進入 production，必須另行取得明確批准：

```text
Publish Phase 1.2 to production
```

Production Publish 不屬於本文件已批准事項。

### 13.3 Production Smoke Test 建議

若未來 Publish，建議執行：

1. app.lohashare.com valid source / UTM submission。
2. app.lohashare.com invalid whitelist submission。
3. app.lohashare.com no source submission。
4. LeadDetailDrawer Source 區塊顯示 / 隱藏確認。
5. CSV export 確認 12 欄 append 在尾端。
6. Email Router / Unsubscribe / notification smoke check，確認未受影響。
7. No regression on old embed form。
