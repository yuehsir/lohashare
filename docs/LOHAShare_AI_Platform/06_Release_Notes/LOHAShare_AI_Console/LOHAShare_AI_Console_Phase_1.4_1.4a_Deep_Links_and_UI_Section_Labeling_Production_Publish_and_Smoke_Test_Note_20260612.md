# LOHAShare AI Console Phase 1.4 + 1.4a Deep Links and UI Section Labeling Production Publish and Smoke Test Note

Release: Phase 1.4 Clickable Deep Links + Phase 1.4a UI Section Labeling  
Status: Production Stable · Adjusted Production Smoke Test Passed · GitHub Archived  
Date: 2026-06-12

---

## 一、已完成項目

| Phase | 內容 | 狀態 |
|---|---|---|
| 1.4 | 來源摘要 / 名單概況可點擊 deep links（source_platform、source_type、utm_source、utm_campaign、no_source） | ✅ 完成 |
| 1.4a | 新增「名單概況」「篩選條件」「名單列表」區塊標題 | ✅ 完成 |
| — | Preview 精準驗證（使用者手動 9 項） | ✅ 通過 |
| — | Production 最小 smoke test（使用者手動 8 項） | ✅ 通過 |

---

## 二、實際變更檔案

- `src/routes/_authenticated/admin/sites.$id.leads.index.tsx`  
  主要手動變更，包含 Phase 1.4 clickable deep links 與 Phase 1.4a UI section labels。

- `src/routeTree.gen.ts`  
  +10 行 auto-generated type augmentation，為 TanStack / React Start router tooling 自動產生的 `declare module` 類型註冊碼。此變更無 runtime 行為影響，非手動修改，不涉及 forbidden scope。

> 更正聲明：Publish Pre-confirmation 曾回報 `src/routeTree.gen.ts` unchanged。Production Smoke Test final confirmation 更正為：該檔實際有 +10 行 auto-generated diff，屬 router tooling 正常行為，不涉及 forbidden scope。

---

## 三、Preview 精準驗證結果

使用者已於 Preview 手動確認以下 9 項：

1. 是否看到「名單概況」標題：是
2. 是否看到「篩選條件」標題：是
3. 是否看到「名單列表」標題：是
4. 點「LINE 名單」是否出現 `source_platform=line`：是
5. 點「無來源名單」是否出現 `source_platform=no_source`，且沒有 `source_type` / `utm_source` / `utm_campaign`：是
6. 「社群名單」是否不可點或點擊後 URL 不變：是
7. 點「來源摘要」任一項，例如 Top 5 UTM Source > line，URL 是否正確變化：是
8. 是否有畫面錯誤 / 白屏 / runtime error：無
9. 是否確認未 Publish：是

---

## 四、Production 最小 Smoke Test 結果

使用者已於 Production 手動確認以下 8 項：

1. 可登入 `https://app.lohashare.com`
2. 可進入「網站管理 > LOHAShare 官網測試站 > 名單管理」
3. 可看到新增區塊標題：
   - 名單概況
   - 篩選條件
   - 名單列表
4. 點「LINE 名單」後，URL 出現 `source_platform=line`
5. 點「無來源名單」後，URL 出現 `source_platform=no_source`，且 URL 沒有 `source_type` / `utm_source` / `utm_campaign`
6. 「社群名單」維持不可點，或點擊後 URL 不變
7. 點「來源摘要」任一項，例如 Top 5 UTM Source > line，URL 正確變化
8. 無畫面錯誤 / 白屏

---

## 五、未變更項目（Forbidden Scope 確認）

| 類別 | 狀態 |
|---|---|
| migration / RLS / schema / secrets | ❌ 未變 |
| CSV header / row order | ❌ 未變 |
| Email Router / Unsubscribe / Auth flow | ❌ 未變 |
| production settings / user / role / site access / operator fixture | ❌ 未變 |
| public signup / register | ❌ 未變 |
| `src/lib/leads.functions.ts` | ❌ 未變 |
| server function signature | ❌ 未變 |
| new filters / new URL params / multi-value URL params | ❌ 未新增 |
| global dashboard drill-down / cross-site search / public reporting links | ❌ 未新增 |

---

## 六、風險註記

- `operator scope` 未完整重測，但 Phase 1.4 / 1.4a 未改 `leads.functions.ts`、RLS、site access、operator fixture，因此風險評估為低。
- `src/routeTree.gen.ts` 的 +10 行變更為 auto-generated type augmentation，無 runtime 行為影響。
- Security scan baseline 顯示 stale，但本次只改 authenticated admin route 的前端 UI labels 與 same-route Link navigation，未動 RLS / server functions / schema / secrets / Edge Functions / connectors，且 findings 為 0，因此不阻擋 Publish。

---

## 七、已知限制與後續工作

- 本階段不進入 Phase 4，除非使用者明確指示。
- 若未來需要進一步改善操作理解，可延伸建立「名單管理頁 UI 區塊命名規範」與「測試指令命名規範」，避免再次使用 Summary / KPI / Grid 等未對應畫面標題的開發名詞。

---

## 八、最終狀態

Phase 1.4 + Phase 1.4a 狀態標記為：

```text
Production Stable
Adjusted Production Smoke Test Passed
GitHub Archived
```
