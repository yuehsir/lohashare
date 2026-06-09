# LOHAShare AI Console v2.0 Lovable Developer Prompt Candidate v0.3

版本時間：2026-06-10（Asia/Taipei）  
版本號：v0.3  
文件狀態：Developer Prompt Candidate / Markdown Generated / GitHub Archive Prepared / Not Committed  
建議 GitHub Repo：`yuehsir/lohashare`  
建議 GitHub 路徑：`docs/LOHAShare_AI_Platform/05_Developer_Prompts/LOHAShare_AI_Console/Current/LOHAShare_AI_Console_v2.0_Lovable_Developer_Prompt_Candidate_v0.3_20260610.md`

---

## 0. 文件用途與使用方式

本文件是要提供給 Lovable 的 Developer Prompt 候選稿，用於未來在明確獲得使用者二次確認後，執行：

> Phase 1.2 — Social / LINE OA Lead Tracking

本文件不是 Build approval。  
本文件不是 migration approval。  
本文件不是 production update approval。  
本文件不是 GitHub commit note。  
本文件不是 Release Note。  
本文件不是主 PRD。  

本文件目的：

1. 將多回合對話中已確認的 Phase 1.2 Build Plan 整合為單一可信來源。
2. 降低 Lovable 上下文被裁切後誤解需求的風險。
3. 明確定義 Phase 1.2 必做項目、禁止事項、資料模型變更、server/client contract、UI delta、rollback plan 與 approval gates。
4. 確保本階段不碰 Email Router、Unsubscribe、Production Update、平台 API、Candidate Table、Referral / Partner attribution。

---

# Lovable Developer Prompt 正文

請注意：以下是 Developer Prompt 正文。  
請貼給 Lovable 時，直接從下一行開始貼入。

---

# Phase 1.2 — Social / LINE OA Lead Tracking MVP

請先再次確認：本次是否已取得使用者第二次明確 Build approval。  
如果使用者只是說「可以開始了」、「就照這個做」、「OK」、「go」等模糊指令，請不要直接 Build。請先回覆並要求使用者明確確認：

> 我即將執行 Phase 1.2 MVP 必做 5 項，包括 migration 與 code 變更。請最後確認是否開始 Build。

只有在使用者第二次明確回覆 yes / 確認 Build / 開始執行後，才可進入 migration / code 變更。

如果尚未取得第二次明確 Build approval，請只回覆 readiness / plan，不要修改任何檔案。

---

## 1. Phase Scope & Non-Goals

### 1.1 本次 Phase 1.2 目標

本次目標是讓現有 Lead Console 支援：

- Social / Short Video lead tracking
- LINE OA lead tracking
- UTM tracking
- Campaign source tracking
- Lead Drawer source display
- CSV export source fields

本次不是要建立新的社群爬取系統，也不是要串接社群平台 API。

### 1.2 本次必做範圍

若已取得二次 Build approval，僅可執行以下 5 項：

1. 單一 migration：
   - `leads` 新增 12 個 nullable source / UTM 欄位
   - 建立 5 個 btree index
   - 同步更新 `leads_restrict_operator_update` trigger blocklist
   - 欄位新增與 trigger 更新必須在同一個 transaction 中完成
   - trigger 更新失敗則整個 migration rollback，不可只新增欄位

2. `/api/public/forms/submit`：
   - zod schema 擴充
   - source / UTM 白名單驗證
   - 字串長度上限
   - INSERT 寫入新欄位

3. `embed.forms.$slug.tsx`：
   - 讀取 query string
   - 讀取 referrer
   - SSR-safe pattern
   - 注入 submit payload
   - 不破壞舊嵌入碼

4. `LeadDetailDrawer`：
   - 新增「來源 Source」collapsible 區塊
   - 全部 source 欄位為 NULL 時整區隱藏

5. `exportLeadsCsv`：
   - headers 新增 12 欄
   - row mapping 新增 12 欄
   - BOM / CAP 10000 / escaping 邏輯不變

### 1.3 本次不做事項

本次明確不做：

- TikTok API 串接
- Instagram API 串接
- YouTube API 串接
- Threads API 串接
- Facebook API 串接
- LINE Messaging API / Webhook 串接
- `line_*` 專屬欄位
- `social_lead_candidates` table
- 留言 / 私訊 CSV import
- AI intent scoring
- spam scoring
- Referral / Partner attribution
- Partner / Referral / Billing 完整功能
- Email Router cutover
- Email Provider Router flags
- Unsubscribe route
- `UNSUBSCRIBE_BASE_URL`
- app.lohashare.com route 上線驗證
- Option B unsubscribe preview 驗證
- Production Update / Publish
- Zoho SMTP Edge Function
- root domain DNS
- `send.lohashare.com`
- `notify.lohashare.com`
- `_dmarc rua`
- GitHub commit
- PR

### 1.4 本次不碰的 Email / Router / App Domain 範圍

本次與以下檔案 / 設定零交集，不可讀取、不修改、不開啟：

- `src/lib/email-router/*`
- `src/lib/email-templates/lead-notification.tsx`
- `src/lib/email-templates/lead-subject.ts`
- `src/lib/notifications.server.ts`
- `src/lib/notifications.functions.ts`
- `src/lib/notifications-reconcile.functions.ts`
- `src/routes/api/public/u/$token.ts`
- `src/routes/lovable/email/queue/process.ts`
- `EMAIL_PROVIDER_ROUTER_ENABLED`
- `EMAIL_ROUTER_TEST_ENABLED`
- `EMAIL_FALLBACK_ENABLED`
- `UNSUBSCRIBE_BASE_URL`

---

## 2. Data Model Delta

### 2.1 Migration 原則

對 `public.leads` 做純 additive migration。

所有新增欄位必須：

- nullable
- no default
- no DB enum
- no check constraint
- no backfill
- 不修改既有資料
- 不破壞既有 insert path

Migration 建議名稱：

```text
add_social_source_columns_to_leads
```

### 2.2 新增欄位清單

請在 `public.leads` 新增以下 12 個欄位：

| 欄位 | 型別 | Nullable | Default | Index | 用途 |
|---|---|---|---|---|---|
| `source_type` | text | YES | NULL | btree | 區分 website_form / social_link / line_oa / referral / manual_import |
| `source_platform` | text | YES | NULL | btree | TikTok / Instagram / YouTube / Threads / Facebook / LinkedIn / LINE / other |
| `source_channel` | text | YES | NULL | no | 帳號名稱 / LINE OA 名稱 |
| `source_content_url` | text | YES | NULL | no | 影片 / 貼文 / profile / LINE link |
| `source_campaign_id` | text | YES | NULL | btree | campaign 聚合 |
| `source_campaign_name` | text | YES | NULL | no | 人類可讀 campaign 名稱 |
| `source_landing_url` | text | YES | NULL | no | 首觸 campaign landing URL |
| `utm_source` | text | YES | NULL | btree | UTM source |
| `utm_medium` | text | YES | NULL | no | UTM medium |
| `utm_campaign` | text | YES | NULL | btree | UTM campaign |
| `utm_content` | text | YES | NULL | no | UTM content |
| `utm_term` | text | YES | NULL | no | UTM term |

### 2.3 Index 策略

僅新增以下 5 個 btree index：

```text
source_type
source_platform
source_campaign_id
utm_source
utm_campaign
```

不要對 URL、channel、name 類欄位加 index。

### 2.4 text + app 層白名單

不要使用 DB enum。  
請採用 `text` 欄位 + app 層 zod 白名單。

理由：

1. 未來新增平台不需 migration。
2. DB enum 改動成本高。
3. Phase 1.2 仍處於早期擴充階段，需要保留彈性。

---

## 3. Trigger / Operator Permission Caveat

### 3.1 現有 trigger 狀態

已確認：

```text
leads_restrict_operator_update
```

是 blocklist 模式，不是 allowlist 模式。

意思是：

- trigger 目前列出 operator 禁止修改的欄位。
- 未列入 blocklist 的新欄位，operator 預設可能可以修改。
- 因此新增 source / UTM 欄位時，必須同步更新 trigger blocklist。

### 3.2 權限決策

source / UTM 欄位屬於審計與歸因資料，operator 不應可修改。

理由：

1. 保留 lead attribution 證據鏈。
2. 避免歸因被竄改。
3. 避免 partner / campaign / social source 未來計費或分潤時失真。
4. operator 只應能改 status 等允許欄位。

### 3.3 Trigger 更新策略

在同一個 migration / transaction 內執行：

```sql
CREATE OR REPLACE FUNCTION public.leads_restrict_operator_update()
```

請在現有禁改欄位清單末尾追加 12 個新欄位的 `IS DISTINCT FROM` 判斷。

不可變更：

- admin 短路邏輯
- operator 可改 status 的行為
- 既有 RLS policy
- 既有 trigger 掛載方式

若 trigger 更新失敗，整個 migration 必須 rollback。  
不得只新增欄位而不更新 trigger。

### 3.4 未來 caveat

新增任何 `leads` 欄位都必須評估是否要加入 `leads_restrict_operator_update` blocklist，避免重蹈 source / UTM 欄位風險。

---

## 4. Server Contract Delta

### 4.1 影響檔案

預期影響：

```text
src/routes/api/public/forms/submit.ts
```

請不要修改 unrelated server route。

### 4.2 Payload 結構決策

新增欄位請放在 submit payload 的巢狀物件：

```ts
source: {
  source_type?: string;
  source_platform?: string;
  source_channel?: string;
  source_content_url?: string;
  source_campaign_id?: string;
  source_campaign_name?: string;
  source_landing_url?: string;
  utm_source?: string;
  utm_medium?: string;
  utm_campaign?: string;
  utm_content?: string;
  utm_term?: string;
}
```

理由：

1. 與現有 `custom` 巢狀結構一致。
2. 未來易擴充。
3. 不污染 top-level namespace。
4. client / server contract 清楚。

### 4.3 zod 驗證

請在 handler 內用 zod 驗證，不依賴任何 Node-only library。

TanStack Start server route 目前在 Cloudflare Worker runtime，必須沿用現有 runtime-safe pattern。

### 4.4 白名單

`source_platform` 白名單：

```text
tiktok
instagram
youtube
threads
facebook
linkedin
line
other
```

`source_type` 白名單：

```text
website_form
social_link
line_oa
social_comment
referral
manual_import
```

未通過白名單：

- 該欄位寫 NULL
- 不 reject 整筆 lead submission
- 不讓攻擊者透過錯誤 source 值造成表單失效

### 4.5 字串長度上限

每個 source / UTM 欄位建議字串上限：

```text
500 chars / field
```

超過上限時請安全截斷或視為 invalid 並寫 NULL。  
請使用現有安全模式，不引入 Node-only dependency。

### 4.6 supabaseAdmin caveat

`/api/public/forms/submit` 使用 `supabaseAdmin` service role，會 bypass RLS。

因此：

1. 白名單驗證必須在 zod / handler 階段完成。
2. 不可依賴 RLS 擋惡意 source input。
3. PR review checklist 必須明確檢查這一點。

---

## 5. Client Contract Delta

### 5.1 影響檔案

預期影響：

```text
src/routes/embed.forms.$slug.tsx
```

### 5.2 現有機制 caveat

此檔案已存在：

- `loaded_at`
- `page_url`
- `honeypot`
- `document.referrer`

新增 source 收集必須複用既有 useEffect 與 SSR-safe pattern：

```ts
typeof window !== "undefined"
typeof document !== "undefined"
```

避免 SSR crash。

### 5.3 Source 收集

mount 時讀取：

- `window.location.search`
- `document.referrer`
- `window.location.href`

解析：

- `utm_source`
- `utm_medium`
- `utm_campaign`
- `utm_content`
- `utm_term`
- `source_type`
- `source_platform`
- `source_channel`
- `source_content_url`
- `source_campaign_id`
- `source_campaign_name`

並組成：

```ts
source: { ... }
```

送至 submit payload。

### 5.4 source_landing_url vs source_page_url

請明確定義：

```text
source_landing_url = 首觸 campaign landing URL
source_page_url = 既有欄位，保留現行語意，代表送出時頁面 URL / 表單所在頁追蹤欄位
```

Column comment 中必須寫明此差異。

注意：

在現行 iframe 架構下，因 iframe 內看到的是 form 頁，`source_landing_url` 與 `source_page_url` 短期內可能常常相同。  
Phase 1.2 接受這個取捨。  
差異會在 Phase 1.3 後新版 snippet / direct hosted form / parent page query forwarding 才更明顯。

### 5.5 iframe caveat

父頁 query string 不會自動進 iframe。

因此 Phase 1.2 預期：

1. customer 可以自行把 UTM 加到 iframe src。
2. 或未來 optional 新 snippet 將 parent page `location.search` forward 到 iframe URL。
3. 本次不要求所有舊嵌入自動取得父頁 UTM。
4. 舊嵌入碼必須維持可用。

### 5.6 Query string vs hidden fields 優先序

若未來同時存在 query string 與 hidden fields，優先序為：

```text
query string 優先
hidden fields 作為 fallback
```

理由：實際點擊路徑比 snippet 預設值更接近真實來源。

請在 `/api/public/forms/submit` 文件註解中記錄此規則。

---

## 6. UI Delta

### 6.1 Lead Drawer

影響檔案：

```text
src/components/admin/LeadDetailDrawer.tsx
```

新增「來源 Source」collapsible 區塊。

顯示：

- source_type
- source_platform
- source_channel
- source_campaign_id
- source_campaign_name
- source_content_url
- source_landing_url
- utm_source
- utm_medium
- utm_campaign
- utm_content
- utm_term

規則：

1. 若 12 個欄位全部為 NULL，整個 Source 區塊隱藏。
2. `source_content_url`、`source_landing_url` 可點擊新分頁。
3. 只做 additive display，不影響 status change / lead notes / activity timeline。

### 6.2 CSV Export

影響函式：

```text
exportLeadsCsv
```

已知 caveat：

- `exportLeadsCsv` 的 select 是 `*`
- migration 後新欄位會自動被 select 出來
- CSV 端只需要加 headers / row mapping
- 不需改 select 字串

請在 `source_user_agent` 之後、`custom.*` 之前插入 12 個新欄位：

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
- 舊資料空值輸出空字串

### 6.3 Lead List filter

本次不做。

Lead List `source_platform` filter 屬 optional nice-to-have，另開 Phase 1.2.1，不夾帶進 Phase 1.2 MVP。

### 6.4 Source Report

本次不做。

Admin Source Report 屬 optional nice-to-have，另開 Phase 1.2.1 或後續 Reporting phase。

---

## 7. Invariants

請維持以下不變條件：

1. 舊 embed form / 舊 snippet 繼續可用。
2. 舊 lead submission 不含 `source` 物件時仍可成功 INSERT。
3. 新欄位全為 nullable，不 backfill 舊資料。
4. `monthly_usage.lead_count` 不變。
5. `usage_logs` schema 不變。
6. `plans` 不變。
7. `subscriptions` 不變。
8. `forms` table 不變。
9. `getPublicForm` 不變。
10. `FormEditor` 不變。
11. `allowed_domains` 不變。
12. `Email Notification` 不變。
13. `Email Provider Router` 不變。
14. `Unsubscribe Route` 不變。
15. `Production Update / Publish` 不執行。
16. operator 不可修改 source / UTM 欄位。
17. admin 既有權限不受影響。
18. RLS policy 不變。
19. `activity_logs` 不變。
20. 若某些 dashboard 指標尚未串接，不得假造資料。

---

## 8. Rollback Plan

### 8.1 Migration rollback

因為 12 個欄位皆為 nullable、無 FK、無 check、無 backfill，可安全 rollback：

```sql
ALTER TABLE public.leads DROP COLUMN ...
```

Index rollback：

```sql
DROP INDEX IF EXISTS ...
```

Trigger rollback：

```sql
CREATE OR REPLACE FUNCTION public.leads_restrict_operator_update()
```

還原舊版本。

請在 migration 註解中保留前版 trigger definition 作為 rollback 腳本素材。

### 8.2 UI rollback

純前端 revert：

- Lead Drawer Source 區塊
- CSV export mapping
- embed form source collect
- submit schema source collect

可用 git revert 回復。

### 8.3 資料修復

Phase 1.2 不需 backfill script。

若 deploy 後發現 source / UTM 對應錯誤，只影響 attribution，不影響 core lead fields。

可用一次性資料操作修復指定 leads：

```sql
UPDATE public.leads
SET utm_source = ..., utm_medium = ...
WHERE id IN (...);
```

資料操作需另行批准，不屬於 Phase 1.2 MVP Build。

---

## 9. Approval Gates

請把 approval 拆成以下 gates，不可混在一起：

### Gate 1 — Plan approval

目前已完成。  
代表方向可接受，但不可 Build。

### Gate 2 — Build approval

尚未完成。  
必須由使用者第二次明確確認：

```text
Build Phase 1.2 MVP 必做 5 項
```

並再次回答 yes / 確認後才可開始。

### Gate 3 — Migration execution gate

Build approval 後，執行 migration 前請再次列出：

- 12 欄位
- 5 index
- trigger blocklist 更新
- rollback strategy

若 trigger 無法安全更新，停止。

### Gate 4 — Code implementation gate

Migration 設計確認後，才改：

- `/api/public/forms/submit`
- `embed.forms.$slug.tsx`
- `LeadDetailDrawer`
- `exportLeadsCsv`

### Gate 5 — Production Update gate

本次不執行。  
任何 Publish / Update production 必須另行取得明確批准。

---

## 10. Codebase-specific Caveats

請務必遵守以下 codebase caveats：

1. `exportLeadsCsv` 的 select 是 `*`。新欄位 migration 後會自動 select 出來，只需加 headers / row mapping，不需改 select 字串。

2. Build PR 中必須明確回歸測試：
   - 新欄位加入 trigger 禁改清單後，operator 透過 UI 改 status 仍正常。

3. `leads_restrict_operator_update` 是 blocklist 模式，不是 allowlist。新增任何 `leads` 欄位都必須評估是否要加入 blocklist。

4. `embed.forms.$slug.tsx` 已有 `loaded_at` / `page_url` / `honeypot` / `document.referrer` 機制。新增 source 收集必須複用既有 useEffect 與 SSR-safe pattern。

5. Submit payload 目前是扁平結構，`custom` 是巢狀。Phase 1.2 新欄位請放進 `source: {...}` 巢狀物件。

6. `getPublicForm` 回傳的 `PublicFormDTO` 不含 form 層級 source 設定。Phase 1.2 client 收集 source 完全靠 URL / referrer，不靠 form 設定。

7. 不修改 `forms` table。

8. 不修改 `getPublicForm`。

9. 不修改 `FormEditor`。

10. `/api/public/forms/submit` 使用 `supabaseAdmin` service role，會 bypass RLS。因此 source 白名單驗證必須在 zod / handler 階段完成。

11. 父頁 query string 不會自動進 iframe。Phase 1.2 不保證所有舊嵌入自動取得父頁 UTM。

12. `source_landing_url` 與 `source_page_url` 在現行 iframe 架構下可能等值。Phase 1.2 接受這個短期限制。

13. `activity_logs` 不需要 Phase 1.2 改動。若未來想 audit source 欄位寫入，是另一個 feature，不在本次範圍。

14. TanStack Start server route 在 Cloudflare Worker runtime。zod 驗證、字串長度上限必須在 handler 內完成，不依賴 Node-only library。

---

## 11. Build Output Requirements

若未來取得 Build approval，請輸出：

1. 修改檔案清單。
2. Migration 檔案名稱。
3. 新增欄位清單。
4. 新增 index 清單。
5. trigger 更新摘要。
6. Server schema 變更摘要。
7. Client source collect 變更摘要。
8. Drawer / CSV 變更摘要。
9. 未修改項目清單，特別是：
   - Email Router 未動
   - Unsubscribe 未動
   - Production Update 未動
   - Platform API 未動
   - Candidate table 未建
10. 測試與驗收清單。
11. rollback 方法。

---

## 12. Acceptance Criteria

Phase 1.2 MVP 完成後，必須符合：

1. 舊表單送出仍成功。
2. 不含 source payload 的 submission 仍成功。
3. 含 valid source / UTM 的 submission 可寫入 leads 新欄位。
4. invalid source_platform / source_type 不會 reject 整筆，只會寫 NULL 或忽略該欄。
5. 字串長度上限生效。
6. operator 仍可改 lead status。
7. operator 不可修改 source / UTM 欄位。
8. admin 權限不受影響。
9. RLS policy 不變。
10. Lead Drawer 有 source 欄位時顯示 Source 區塊。
11. 舊 lead source 全 NULL 時 Drawer 不顯示 Source 區塊。
12. CSV export 多 12 欄。
13. CSV BOM / escaping / CAP 10000 不變。
14. `monthly_usage.lead_count` 不變。
15. Email Notification 不變。
16. Email Router 不變。
17. Unsubscribe Route 不變。
18. No Production Update。
19. No platform API。
20. No `social_lead_candidates` table。
21. No `line_*` API columns。

---

## 13. Final Reminder

如果尚未取得第二次明確 Build approval，請不要執行上述任何 migration 或 code change。

請先回覆：

```markdown
# Phase 1.2 v0.3 Prompt Acknowledgement

## 1. Scope Understood

## 2. Non-Goals Understood

## 3. Required Second Build Approval

## 4. Any Remaining Questions Before Build
```

除非使用者再次明確批准 Build，否則請停在 acknowledgement。
