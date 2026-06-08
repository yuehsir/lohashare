# Developer Prompt 正本路徑治理更新提案 — LOHAShare AI Console v0.1

版本時間：2026-06-09 00:25（Asia/Taipei）  
版本號：v0.1  
文件狀態：Draft / Governance Proposal / Not Committed by ChatGPT  
候選路徑：`LOHAShare_AI_Platform/01_Architecture_Governance/01_Document_Governance/Current/`  
關聯文件：
- `LOHAShare_AI_Console_Platform_PRD_v2.0_Draft_20260609.md`
- `LOHAShare_AI_Console_UIUX_Sitemap_v0.1_20260609.md`
- `Lead_Console_MVP_Current_UI_Baseline_v0.1_20260609.md`

---

## 0. 治理聲明

本文件是 Developer Prompt 正本路徑治理更新提案，不是 Developer Prompt 正本，不是主 PRD，也不是 Lovable 實作紀錄。

本次依據使用者提供之 `LOHAShare_AI_Platform_folder_tree.txt` 進行候選路徑校正。使用者已聲明該 folder tree 已透過 GitHub Desktop commit / sync 至雲端 GitHub，但 ChatGPT 尚未實際進入 GitHub repo tree 做 connector 校驗。

因此，本文件僅為歸檔素材：

- 不得宣稱已寫入 GitHub。
- 不得宣稱已 commit。
- 不得宣稱已建立 PR。
- 不得宣稱 ChatGPT 已實際校驗 GitHub repo tree。

---

# 一、現況判斷

目前 `LOHAShare_AI_Platform_folder_tree.txt` 顯示：

```text
05_Developer_Prompts/
├─DocOps_MVP
│  ├─99_Archive
│  ├─assets
│  └─Current
└─Email_Notification
    └─Fallback_POC
        ├─99_Archive
        └─Current
```

目前尚未看到以下正式資料夾：

```text
05_Developer_Prompts/Lead_Console/
05_Developer_Prompts/LOHAShare_AI_Console/
05_Developer_Prompts/Lovable/
```

依據治理規則，Developer Prompt 正本不得放入 `02_Modules`。因此，即使本次 prompt 是針對 Lead Console / LOHAShare AI Console 的 Lovable 開發，也不應放入：

```text
02_Modules/Lead_Console/Developer_Prompts/
02_Modules/Nexus_Lead_Ops/Developer_Prompts/
```

同時，不得新增 `Nexus_Lead_Ops` 平行資料夾。

---

# 二、治理問題

本次要產生的文件是：

> 《LOHAShare AI Console v2.0 對 Lovable 的開發提示詞候選稿》

它同時具備以下特性：

| 判斷面向 | 說明 |
|---|---|
| 工具 | Lovable |
| 產品層級 | Level 1：LOHAShare AI Console |
| MVP 實作線 | Level 2：LOHAShare AI Lead & Notification Console MVP |
| 正式模組關聯 | Level 3：Lead Console、AI FAQ / AEO、Email Notification、Operator Dashboard、Report Center |
| 文件類型 | Level 4：Developer Prompt |

因此，它不適合直接放在 `02_Modules/Lead_Console/`，也不宜只歸入 `05_Developer_Prompts/Email_Notification/`。

---

# 三、建議路徑方案

## 方案 A：建立平台級 Developer Prompt 類別（建議）

建議新增：

```text
LOHAShare_AI_Platform/05_Developer_Prompts/LOHAShare_AI_Console/
├─99_Archive
└─Current
```

本次 Developer Prompt 正本候選路徑：

```text
LOHAShare_AI_Platform/05_Developer_Prompts/LOHAShare_AI_Console/Current/
```

建議檔名：

```text
LOHAShare_AI_Console_v2.0_Lovable_Developer_Prompt_Candidate_v0.1_20260609.md
```

### 優點

- 對應 Level 1 主平台，不把平台級 prompt 窄化成單一模組。
- 可容納未來 Lovable / Replit / Codex / Claude / Gemini 等針對主平台的 Developer Prompt。
- 避免把 `Lead_Console` 當成平台母體。

### 注意

此方案需要治理核准新增 `05_Developer_Prompts/LOHAShare_AI_Console/` 類別。

---

## 方案 B：建立 Lead Console Developer Prompt 類別（保守短期方案）

若暫時不建立平台級 prompt 類別，可新增：

```text
LOHAShare_AI_Platform/05_Developer_Prompts/Lead_Console/
├─99_Archive
└─Current
```

本次 Developer Prompt 正本候選路徑：

```text
LOHAShare_AI_Platform/05_Developer_Prompts/Lead_Console/Current/
```

### 優點

- 對應既有 `02_Modules/Lead_Console/` 模組。
- 適合保存「現有 Lovable Lead & AEO Console MVP」的開發提示詞。

### 風險

- 本次 prompt 已經提升到 LOHAShare AI Console v2.0 平台級，不完全只是 Lead Console 模組。
- 未來若平台級 prompt 變多，仍需再建立 `LOHAShare_AI_Console` 類別。

---

## 方案 C：建立工具別 Lovable 類別（不建議作為第一優先）

可新增：

```text
LOHAShare_AI_Platform/05_Developer_Prompts/Lovable/
├─99_Archive
└─Current
```

### 優點

- 依開發工具分類，直覺上容易找。

### 風險

- 未來同一產品可能有 Lovable / Replit / Codex / Claude 等不同工具 prompt，容易讓產品脈絡分散。
- 與既有 `DocOps_MVP`、`Email_Notification` 這種產品 / 模組導向分類不完全一致。

---

# 四、建議決策

建議採用：

```text
方案 A：建立平台級 Developer Prompt 類別
```

建議正式新增候選路徑：

```text
LOHAShare_AI_Platform/05_Developer_Prompts/LOHAShare_AI_Console/
├─99_Archive
└─Current
```

本次提示詞候選稿建議放置於：

```text
LOHAShare_AI_Platform/05_Developer_Prompts/LOHAShare_AI_Console/Current/LOHAShare_AI_Console_v2.0_Lovable_Developer_Prompt_Candidate_v0.1_20260609.md
```

若正式治理尚未核准，則本次僅標示為「候選路徑」，不得宣稱該資料夾已建立或已寫入 GitHub。

---

# 五、治理更新提案摘要

建議新增 Developer Prompt 分類規則：

1. 若 Developer Prompt 針對 Level 1 主平台，歸入：

```text
05_Developer_Prompts/LOHAShare_AI_Console/Current/
```

2. 若 Developer Prompt 針對明確 Level 3 模組，歸入：

```text
05_Developer_Prompts/{Module_Name}/Current/
```

3. 若 Developer Prompt 針對工具本身操作流程，不綁定產品或模組，才考慮工具別分類，例如：

```text
05_Developer_Prompts/Lovable/Current/
```

4. Developer Prompt 正本不得放入：

```text
02_Modules/{Module}/Developer_Prompts/
```

5. `Nexus Lead Ops` 僅為產品化名稱、實作線或別名，不得新增：

```text
05_Developer_Prompts/Nexus_Lead_Ops/
02_Modules/Nexus_Lead_Ops/
```

---

# 六、歸檔判斷

| 項目 | 判斷 |
|---|---|
| 本文件是否建議歸檔 | 是 |
| 文件類型 | Governance Proposal / Developer Prompt Path Policy |
| 候選路徑 | `LOHAShare_AI_Platform/01_Architecture_Governance/01_Document_Governance/Current/` |
| 是否需要新增正式路徑 | 是，建議新增 `05_Developer_Prompts/LOHAShare_AI_Console/Current/` 與 `99_Archive/` |
| 是否已從舊版新增補內容 | 是，依據 folder tree 與 PRD v2.0 補充 Developer Prompt 分類策略 |
| GitHub repo tree 驗證狀態 | 使用者聲明已 GitHub Desktop commit / sync；ChatGPT 尚未 connector 校驗 |
| 是否可宣稱已寫入 GitHub | 否 |
| 是否可宣稱已 commit | 否 |
| 是否可宣稱已建立 PR | 否 |
