# LOHAShare AI Console Phase 1.5b — Validation Instruction Standard & UI Naming Governance Note

Release: Phase 1.5b Validation Instruction Standard & UI Naming Governance  
Status: Governance Standard · Approved · GitHub Archived  
Date: 2026-06-12

---

## 一、文件目的

本文件用於正式固化 LOHAShare AI Console 後續開發、驗證、Preview Validation、Production Smoke Test 的溝通規範。

Phase 1.4 / 1.4a 過程中，曾因測試指令使用開發端名詞，例如：

```text
Summary cards
KPI cards
Grid
Drawer
Site Leads page
Filter Panel
Leads Table
```

但使用者在畫面上實際看到的是：

```text
名單管理
名單概況
來源摘要
篩選條件
名單列表
名單明細抽屜
```

導致操作位置不清楚、測試反覆、溝通成本增加。

因此，自 Phase 1.5b 起，所有測試與驗證指令必須優先使用「使用者畫面上可見的區塊名稱」，不得只使用開發端元件或內部稱呼。

---

## 二、核心原則

### 1. 使用者可見名稱優先

所有測試指令應優先使用畫面上看得到的文字，例如：

```text
名單概況
來源摘要
篩選條件
名單列表
基本資料
計費資訊
旗下網站
允許網域
子功能入口
```

不得只寫：

```text
KPI card
Summary
Grid
Drawer
Detail page
Picker
```

若必須使用開發端名詞，需同時附上使用者可見名稱。

範例：

```text
在「名單概況」（開發端稱 KPI cards）區塊中，點擊「LINE 名單」。
```

---

### 2. 每個操作都必須包含畫面定位

未來測試指令不得只寫：

```text
點 LINE
點無來源
開 drawer
檢查 grid
```

必須明確描述：

```text
畫面名稱：網站管理 > LOHAShare 官網測試站 > 名單管理
操作區塊：名單概況
操作項目：LINE 名單
操作方式：點擊
預期結果：URL 出現 source_platform=line
```

---

### 3. 只檢查本階段真正受影響的內容

每個 Phase 的驗證不得無差別重跑所有舊測試。

應先判斷本階段實際改動：

```text
本階段改了什麼？
哪些功能可能受影響？
哪些功能沒有改、不需要重測？
哪些高風險項目仍需確認未改？
```

範例：

```text
Phase 1.5a 只補 UI 區塊標題，因此只需確認標題是否出現、原本列表是否存在、是否無白屏或 runtime error。
不需要重測 CRUD / CSV / RLS / Auth / Email Router。
```

---

### 4. Preview Validation 與 Production Smoke Test 應分層

Preview Validation 可較完整確認新功能互動。

Production Smoke Test 只做最小確認：

```text
正式站是否部署成功
新功能是否可見或可用
沒有白屏
沒有 runtime error
Diff scope 是否正確
Forbidden scope 是否未改
```

不得把 Preview 已通過的完整測試在 Production 全部重跑，除非本階段屬於高風險變更。

---

### 5. Authenticated UI 驗證需遵守登入邊界

Lovable / headless browser 不應自行填寫或索取帳密。

正確流程：

```text
使用者本人先在 Preview / Production 中登入。
登入後，Lovable 可在既有 session 下截圖或檢查畫面。
不得把帳密交給 Lovable。
不得要求 Lovable 自行登入。
```

若 Lovable 無登入 session，應回報：

```text
目前停在 login/auth bridge page，無法檢查 authenticated admin UI。
請使用者本人先登入後再繼續。
```

---

## 三、標準測試指令格式

所有後續 Preview Validation / Production Smoke Test 應採用以下格式。

```text
畫面名稱：
{Sidebar 名稱} > {實體名稱} > {子頁名稱}

URL 範本：
/admin/sites/{id}/leads

操作區塊：
{使用者可見區塊標題}

操作項目：
{使用者可見項目名稱}

操作方式：
點擊 / 輸入 / 選擇 / 開啟 / 下載 / 目視確認

預期結果：
{明確、可驗證的 URL 或畫面變化}

本階段需要檢查：
{只列本階段受影響項目}

本階段不需要重測：
{列出未修改範圍，例如 CSV / RLS / Auth / Email Router}

Forbidden Scope 確認：
{列出不得修改的高風險區域}
```

---

## 四、標準回報格式

### 1. Preview Validation 回報格式

```text
Phase X.X Preview Validation Result

1. 畫面名稱是否正確：
2. 操作區塊是否可見：
3. 新增 / 修改項目是否顯示：
4. 新增 / 修改項目是否可操作：
5. 預期 URL 或畫面變化是否正確：
6. 原本主要區塊是否仍存在：
7. 是否有畫面錯誤 / 白屏 / runtime error：
8. 是否未改 forbidden scope：
9. 是否仍未 Publish：
```

### 2. Publish Pre-confirmation 回報格式

```text
Phase X.X Publish Pre-confirmation Report

1. Preview Validation 是否已通過：
2. 本次準備 Publish 的實際檔案清單：
3. 是否有 routeTree.gen.ts 或其他 auto-generated 檔案變更：
4. 是否確認未改功能邏輯：
5. 是否確認未改 route / navigation：
6. 是否確認未改 data fetching / permissions：
7. 是否確認未改 migration / RLS / schema / secrets：
8. 是否確認未改 CSV / Email Router / Auth / Unsubscribe：
9. 是否確認沒有 public signup / register：
10. 是否確認沒有新增 route / package / DB table / server function：
11. metadata check 是否通過：
12. security scan / baseline 狀態：
13. typecheck / build 是否通過：
14. runtime risk 是否低：
15. 是否仍未 Publish：
16. 是否等待明確 Publish 指令：
```

### 3. Production Smoke Test 回報格式

```text
Phase X.X Production Smoke Test — Final Confirmation

1. Production deployment 是否完成：
2. build / deployment error：
3. runtime error：
4. 使用者人工確認項目是否正常：
5. 原本主要區塊是否仍存在：
6. production diff scope 是否正確：
7. routeTree.gen.ts 是否 unchanged 或 auto-generated diff 已說明：
8. forbidden scope 是否未改：
9. 是否可進入 GitHub Archive Note：
```

---

## 五、開發端稱呼 vs 使用者可見稱呼對照表

| 開發端稱呼 | 使用者可見稱呼 |
|---|---|
| Site Leads page | 網站管理 > {網站名稱} > 名單管理 |
| KPI cards / Summary cards | 名單概況 |
| Source Summary / Source breakdown | 來源摘要 |
| Filter Panel / Filters | 篩選條件 |
| Leads Table / Grid | 名單列表 |
| Lead Detail Drawer | 名單明細抽屜 |
| Sites picker / admin/leads | 名單管理（選擇網站） |
| Forms picker / admin/forms | 表單管理（選擇網站） |
| Site Detail page | 網站管理 > {網站名稱}（網站詳情） |
| Site Modules / Module Entry | 子功能入口 |
| Allowed Domains section | 允許網域 |
| Customer Detail page | 客戶管理 > {客戶名稱}（客戶詳情） |
| Customer Sites section | 旗下網站 |
| Billing / Plan section | 計費資訊 |
| Plans page | 方案與額度 |
| Dashboard cards | 儀表板 > 概況卡片 |
| Notifications page | 通知設定 |
| FAQ page | FAQ / AEO |
| Usage page | 使用量 |
| Reports page | 月報草稿 |
| Embeds page | 嵌入碼 |

---

## 六、常見錯誤與修正方式

### 錯誤 1：只使用開發端名稱

錯誤：

```text
Click KPI card.
```

修正：

```text
在「名單概況」區塊中，點擊「LINE 名單」卡片。
```

---

### 錯誤 2：只描述元件，不描述畫面位置

錯誤：

```text
Open drawer and check leadId.
```

修正：

```text
在「名單列表」區塊中，點擊任一筆名單，開啟「名單明細抽屜」，確認 URL 出現 leadId。
```

---

### 錯誤 3：要求重跑未受影響功能

錯誤：

```text
Phase 1.5a 請重新測 CSV、RLS、Auth、Email Router。
```

修正：

```text
Phase 1.5a 只補 UI section labels，因此只需確認新標題顯示、原本列表存在、無白屏或 runtime error。CSV / RLS / Auth / Email Router 未修改，不需重測。
```

---

### 錯誤 4：登入邊界不清楚

錯誤：

```text
Lovable 請自行登入 Preview。
```

修正：

```text
使用者本人先登入 Preview；Lovable 在既有 authenticated session 下進行截圖或檢查。不得要求使用者提供帳密。
```

---

## 七、分階段驗證強度建議

| 變更類型 | Preview Validation | Production Smoke Test |
|---|---|---|
| 純 UI 標題 / 文案 | 目視確認標題與無白屏 | 最小確認即可 |
| URL filter / navigation | 測主要點擊與 URL 變化 | 測 1–2 個代表性項目 |
| CSV / export | Preview 測下載與格式 | Production 測可下載 |
| Auth / Login / Reset Password | Preview 完整流程 | Production 最小登入/重設 smoke |
| RLS / permissions | Preview 角色測試 | Production 低風險驗證或必要角色測 |
| Email / notification | Preview 或 POC 測發送 | Production 需 smoke 發送或 queue 確認 |
| DB / migration | 必須完整驗證 | Production 需 migration / rollback 風險檢查 |

---

## 八、Forbidden Scope 檢查標準

每次 Publish Pre-confirmation 與 Production Smoke Test 都應確認以下項目是否未改：

```text
migration / RLS / schema / secrets
CSV header / row order
Email Router / Unsubscribe / Auth flow
production settings
user account
role assignment
site access assignment
operator QA fixture
server function signature
Edge Functions
public signup / register
new route / new package / new DB table
```

若有任何 auto-generated diff，例如：

```text
src/routeTree.gen.ts
```

必須誠實列出並說明：

```text
是否 auto-generated
是否有 runtime 行為影響
是否涉及 forbidden scope
是否需要阻擋 Publish
```

不得在不確定時宣稱 unchanged。

---

## 九、歸檔規則

每個 Phase 完成後，Archive Note 應包含：

```text
Release 名稱
Status
Date
完成項目
實際變更檔案
Preview Validation 結果
Production Smoke Test 結果
Forbidden Scope 確認
風險註記
已知限制與後續工作
最終狀態
```

最終狀態可使用：

```text
Production Stable
Minimal Production Smoke Test Passed
GitHub Archived
```

若只完成 Preview，尚未 Publish，則不可標記 Production Stable。

---

## 十、最終結論

自 Phase 1.5b 起，LOHAShare AI Console 的驗證與測試指令應遵守以下原則：

```text
使用者可見名稱優先
每個操作都要有畫面定位
只測本階段真正受影響的項目
Preview 與 Production 測試強度分層
Authenticated UI 不交付帳密
Auto-generated diff 必須誠實揭露
Archive Note 必須記錄實際狀態
```
