# LOHAShare AI Platform New Conversation Handoff v1.9 Preflight Action Guide

版本：v1.9｜日期：2026-08-31｜狀態：Governance Integration Dry-run

# Part A–C｜v1.8 原文完整保留區

# LOHAShare AI Platform New Conversation Handoff v1.8 — 原文保留修正版

版本時間：2026-08-19（Asia/Taipei）  
版本號：v1.8  
文件狀態：Draft / Handoff Upgrade / Original-Preserved Correction Draft / Not Committed by ChatGPT  
候選路徑：`docs/LOHAShare_AI_Platform/00_Index/Current/`  
基準來源：`LOHAShare_AI_Platform_New_Conversation_Handoff_v1.7_Preflight_Action_Guide_20260609.md`  
原始 v1.7 SHA：`535475aceb40385184b2b9ea25c1e0ed4f8614a3`  
本版定位：以 v1.7 為唯一升版基準，採「v1.7 原文完整保留區 + v1.8 增補條款區」方式，不摘要化、不重寫、不刪除 v1.7 原文，不新增平行「文件治理校正原則」文件。

---

# Part A｜v1.7 原文完整保留區

以下完整保留 `LOHAShare_AI_Platform_New_Conversation_Handoff_v1.7_Preflight_Action_Guide_20260609.md` 原文內容。

---

# LOHAShare AI Platform New Conversation Handoff v1.7 — Preflight Action Guide

版本時間：2026-06-09 02:47（Asia/Taipei）  
版本號：v1.7  
文件狀態：Draft / Handoff Upgrade / Preflight Action Guide / Not Committed by ChatGPT  
候選路徑：`docs/LOHAShare_AI_Platform/00_Index/Current/`  
基準來源：`LOHAShare_AI_Platform_New_Conversation_Handoff_v1.6_20260601.md`  
本版定位：以既有 New Conversation Handoff 為基準升版，不新增平行的「新對話規範同步啟動指南」。

---

## 0. 版本來源與治理聲明

本文件是 `LOHAShare_AI_Platform_New_Conversation_Handoff_v1.6_20260601.md` 的累積式完整升版，不是摘要、Release Note 或另開新文件。

本次升版依據以下來源：

1. GitHub Current 文件盤點結果。
2. 既有 `LOHAShare_AI_Platform_New_Conversation_Handoff_v1.6_20260601.md`。
3. `LOHAShare_AI_Platform_Document_System_Index_v2.0_20260601.md`。
4. `LOHAShare_AI_Platform_Current_Folder_Structure_v1.5_20260601.md`。
5. `LOHAShare_AI_Platform_Document_Governance_Rules_v0.2_20260530.md`。
6. `LOHAShare_AI_Platform_Document_Format_Strategy_v0.1_20260601.md`。
7. `LOHAShare_AI_Platform_Modular_Architecture_Governance_v1.2_Naming_Hierarchy_Update_20260530.md`。
8. `LOHAShare_AI_Platform_Automation_Strategy_and_DocOps_Roadmap_v1.3_20260530.md`。
9. 使用者修訂後之 Preflight Only v2 Prompt 原則。
10. 本次對話中確認的治理問題：不得因找不到文件就新增平行文件。

重要限制：

- 本文件由 ChatGPT 產生為 Markdown 歸檔素材。
- 本文件尚未寫入 GitHub。
- 本文件尚未 commit。
- 本文件尚未建立 PR。
- 若後續要寫入 GitHub，仍需經使用者確認或由具權限工具實際執行。

---

## 1. v1.6 原始基準保留

v1.6 已確認的核心內容如下，本 v1.7 完整保留並擴充：

> 新對話應以 GitHub `docs/LOHAShare_AI_Platform/` 為工作基準。

v1.6 已完成重整的核心入口：

1. `00_Index`
2. `00_Main_PRD`
3. `01_Architecture_Governance`
4. `05_Developer_Prompts`

v1.6 已定義的判斷順序：

1. GitHub 實際結構
2. `00_Index/Current/`
3. `01_Architecture_Governance` 各 Current/
4. 使用者本次上傳檔案
5. Dropbox 封存副本

本 v1.7 在此基礎上新增「Preflight 行動規範」、「File Generation 觸發條件」、「GitHub Connector 讀取流程」、「不得找不到就新增文件」與「四大區塊固定輸出規則」。

---

## 2. 本文件的角色

本文件是所有新對話的第一入口與行動指南。

它不是：

1. 主 PRD。
2. 單一模組規格。
3. Developer Prompt 正本。
4. Support Log。
5. Release Note。
6. 取代所有治理文件的超大型總文件。

它是：

1. 新對話啟動時的同步基準。
2. ChatGPT / AI Assistant 的行動規範。
3. Preflight Only Mode 與 File Generation Mode 的分界文件。
4. 指向其他 Current 文件的入口文件。
5. 避免多頭馬車、重複新增文件與錯誤歸檔的第一道檢查。

---

## 3. 新對話啟動最高原則

每一個與 LOHAShare AI Platform 有關的新對話，在進入開發、歸檔、產檔、GitHub、Lovable、Supabase 或 Provider 操作之前，必須先完成 Preflight。

最高原則如下：

1. 先同步治理基準，再判斷任務。
2. 先讀既有 Current 文件，再判斷是否需要新增文件。
3. 先確認文件類型與層級，再決定候選路徑。
4. 先輸出四大區塊，再產生任何檔案。
5. 找不到文件時，不得直接建立新文件；應先回報讀取缺口與候選替代來源。
6. 產品化名稱不得直接等同正式模組名稱。
7. Developer Prompt 正本不得放入 `02_Modules`。
8. 不得宣稱 GitHub / Lovable / Supabase / Provider 操作已完成，除非真的透過相應工具完成。
9. 不得用 Release Note 或摘要取代完整新版文件。
10. 若更新既有文件，必須採累積式完整新版，保留上下文與版本來源。

---

## 4. Preflight Only Mode

### 4.1 啟動條件

當使用者說出以下任一類型語句時，預設進入 Preflight Only Mode：

- 「啟動前檢查」
- 「官方治理基準同步」
- 「請先判斷」
- 「請先檢查」
- 「請先不要產生檔案」
- 「Preflight Only Mode」
- 「請重新依照四大區塊完整輸出」
- 「請先使用 GitHub Connector 讀取」
- 「先不要新增文件」
- 「先不要進入下一個開發任務」

### 4.2 Preflight Only Mode 的允許事項

在 Preflight Only Mode 中，ChatGPT 可以：

1. 讀取使用者上傳的檔案。
2. 讀取 GitHub repo metadata。
3. 使用 GitHub Connector 讀取可取得的文件內容。
4. 輸出治理同步結果。
5. 輸出啟動前檢查結果。
6. 輸出歸檔判斷。
7. 輸出下一步動作。
8. 提出候選路徑、候選檔名、候選版本號。
9. 回報哪些文件已讀取、哪些文件讀取失敗。
10. 判斷是否應更新既有文件或新增新文件。

### 4.3 Preflight Only Mode 的禁止事項

在 Preflight Only Mode 中，ChatGPT 不得：

1. 產生 Markdown 檔案。
2. 產生 GitHub Archive JSON。
3. 打包 ZIP。
4. 使用檔案產生工具。
5. 修改 GitHub。
6. 修改 Lovable。
7. 修改 Supabase。
8. 修改 Provider 設定。
9. 宣稱已寫入 GitHub。
10. 宣稱已 commit。
11. 宣稱已建立 PR。
12. 宣稱 Lovable 已改檔。
13. 宣稱 Supabase schema 已變更。
14. 因找不到文件而直接新增平行文件。
15. 把候選路徑說成正式路徑。
16. 把使用者聲明或 folder tree 當成 ChatGPT 已實際 GitHub 校驗。

---

## 5. File Generation Mode

### 5.1 啟動條件

只有在使用者明確說出以下類型指令時，才可進入 File Generation Mode：

```text
請直接執行下一步，產生 Markdown 與 GitHub Archive JSON。
```

或：

```text
請產生檔案。
請輸出可下載檔案。
請產生 ZIP。
請生成 Markdown 檔案與 Archive JSON。
```

若使用者只是說「請先提出」、「請先判斷」、「請先同步」、「請先檢查」，仍屬 Preflight Only Mode，不得產生檔案。

### 5.2 File Generation Mode 的允許事項

在使用者明確授權後，ChatGPT 可以產生：

1. Markdown 歸檔文件。
2. GitHub Archive JSON。
3. ZIP 打包檔。
4. 候選 GitHub 路徑。
5. 候選檔名。
6. 候選 commit message。
7. 路徑衝突校正紀錄。
8. 治理同步紀錄。
9. Developer Prompt 正本 Markdown。
10. 模組規格 Markdown。
11. SOP / QA Markdown。
12. Debug Log / Support Log Markdown。
13. Release Note Markdown。
14. 治理更新提案。

但仍必須聲明：

> 以上僅為歸檔素材，尚未寫入 GitHub、尚未 commit、尚未建立 PR。

---

## 6. GitHub Connector 讀取流程

當任務需要查 GitHub 中既有文件時，ChatGPT 應依以下順序進行：

### 6.1 先確認 repo 可讀

優先確認：

```text
repository：yuehsir/lohashare
工作根路徑：docs/LOHAShare_AI_Platform/
default branch：master
```

若 repo metadata 可讀，可以說「已確認 repo 可讀」。

若未讀取 repo metadata，不得說「已確認 GitHub repo」。

### 6.2 再確認 Current 文件清單

優先檢查：

1. `docs/LOHAShare_AI_Platform/00_Index/Current/`
2. `docs/LOHAShare_AI_Platform/00_Main_PRD/Current/`
3. `docs/LOHAShare_AI_Platform/01_Architecture_Governance/*/Current/`
4. `docs/LOHAShare_AI_Platform/05_Developer_Prompts/*/Current/`

若 GitHub Connector 無法直接列出資料夾檔案，應使用：

1. 使用者提供的 `LOHAShare_AI_Platform_file_tree.txt`。
2. GitHub search。
3. 已知檔名。
4. 使用者上傳的檔案。
5. README / index 文件中列出的路徑。

### 6.3 再逐一讀取文件內容

讀取文件後，必須區分：

| 狀態 | 可否宣稱 |
|---|---|
| 已連上 repo | 可宣稱已讀取 repo metadata |
| 已驗證目錄存在 | 可宣稱該路徑存在，但不可宣稱已讀完內容 |
| 已讀取某份文件 | 可宣稱已讀該文件 |
| 已讀完所有 Current 文件 | 只有逐一讀取後才可宣稱 |
| 已寫入 GitHub | 只有實際寫入後才可宣稱 |
| 已 commit / PR | 只有實際完成後才可宣稱 |

### 6.4 GitHub 讀取失敗時的處理

若讀取失敗，ChatGPT 應回報：

1. 失敗路徑。
2. 使用的讀取方式。
3. 失敗原因。
4. 替代資料來源。
5. 下一步需要什麼資料。

不得因讀取失敗就直接新增文件。

---

## 7. 新對話必讀文件順序

新對話若涉及 LOHAShare AI Platform 文件治理，應依序檢查：

### P0 必讀

1. `00_Index/Current/LOHAShare_AI_Platform_New_Conversation_Handoff`
2. `00_Index/Current/LOHAShare_AI_Platform_Document_System_Index`
3. `00_Index/Current/LOHAShare_AI_Platform_Current_Folder_Structure`
4. `01_Architecture_Governance/01_Document_Governance/Current/LOHAShare_AI_Platform_Document_Governance_Rules`
5. `01_Architecture_Governance/01_Document_Governance/Current/LOHAShare_AI_Platform_Folder_and_File_Management_Rules`

### P1 視任務讀取

1. `00_Main_PRD/Current/`：涉及主 PRD、平台定位、Roadmap 時讀取。
2. `01_Architecture_Governance/02_Modular_Architecture/Current/`：涉及命名層級、模組定位時讀取。
3. `01_Architecture_Governance/03_Automation_DocOps/Current/`：涉及 GitHub Actions、DocOps、n8n、跨工具協作時讀取。
4. `01_Architecture_Governance/04_Content_Quality_and_Consolidation/Current/`：涉及文件整編、Clean Version、內容品質時讀取。
5. `05_Developer_Prompts/<Category>/Current/`：涉及 Lovable / Replit / Claude / Codex / Gemini Prompt 時讀取。

### P2 視情境讀取

1. `02_Modules/`
2. `03_SOP_and_QA/`
3. `04_Support_Knowledge_Base/`
4. `06_Release_Notes/`
5. `07_Archive/`

---

## 8. 四大區塊固定輸出規則

在 Preflight Only Mode 中，必須完整輸出以下四大區塊：

1. 【官方治理基準同步結果】
2. 【啟動前檢查結果】
3. 【歸檔判斷】
4. 【下一步動作】

不得省略欄位。若某欄位不適用，應填「不適用」或「待判斷」，並說明原因。

---

## 9. 官方治理基準同步結果欄位

請逐項回答：

1. 是否已接收本次官方治理基準摘要：
2. 是否理解 GitHub `docs/LOHAShare_AI_Platform/` 是工作基準：
3. 是否理解 `00_Index/Current/` 是最新索引入口：
4. 是否理解 `01_Architecture_Governance/<Topic>/Current/` 是治理規則入口：
5. 是否理解 `00_Main_PRD/Current/` 是主 PRD 與層級命名入口：
6. 是否理解 `05_Developer_Prompts/<Category>/Current/` 是 Developer Prompt 正本入口：
7. 是否理解 `02_Modules` 尚未完成統一重整時，不得自行新增正式模組資料夾：
8. 是否理解產品化名稱不得直接等同主 PRD：
9. 是否理解產品化名稱可能需對應正式 Level 3 模組：
10. 是否理解 Developer Prompt 正本不得放入 `02_Modules`：
11. 是否理解不得宣稱已完成 GitHub commit：
12. 是否已實際讀取 GitHub repo tree：
13. 若尚未實際讀取 GitHub repo tree，請明確說明目前只是理解治理基準，不是完成 GitHub 實際校驗：
14. 是否需要後續 GitHub connector、repo tree 或使用者提供資料才能完成最終路徑驗證：

---

## 10. 啟動前檢查結果欄位

請逐項回答：

1. 對話名稱：
2. 對話產品化名稱：
3. 所屬 Level 0：
4. 所屬 Level 1：
5. 可能所屬 Level 2：
6. 可能所屬 Level 3 模組：
7. 可能所屬 Level 4 文件類型：
8. 目前對話類型：
9. 是否已同步官方治理基準：
10. 是否可能使用過舊規範：
11. 是否已有文件草案：
12. 是否已有正式文件：
13. 是否已產出 Developer Prompt：
14. 是否涉及 Debug Log / Support Log：
15. 是否涉及 Release Note：
16. 是否涉及 SOP / QA：
17. 是否涉及 GitHub / Lovable / Supabase / Provider 操作：
18. 已產出文件或草案：
19. 已產出 Developer Prompt：
20. 已確認決策：
21. 尚未歸檔但建議歸檔的內容：
22. 可能需要重新分類的內容：
23. 是否發現資料夾路徑衝突：
24. 若有產品化名稱路徑，是否應修正為正式模組資料夾或提出資料夾更新提案：
25. Developer Prompt 正本候選路徑：
26. 是否需要治理更新提案：
27. 是否建議進入正式歸檔助理模式：
28. 是否需要先產生治理同步結果文件：
29. 使用者目前是否需要提供資料：
30. 是否需要 GitHub / Lovable 手動操作：

---

## 11. 歸檔判斷欄位

請逐項回答：

1. 本次內容是否建議歸檔：
2. 判斷理由：
3. 建議文件類型：
4. 建議候選 GitHub 路徑：
5. 是否存在路徑衝突：
6. 若存在路徑衝突，衝突說明：
7. 建議檔名：
8. 建議版本號：
9. 建議狀態：
10. 建議 commit message：
11. 是否需要產生 Markdown 歸檔文件：
12. 是否需要產生 GitHub Archive JSON：
13. 是否需要使用者確認：
14. 需要確認的原因：
15. 是否已從舊版新增補內容：
16. 從哪確認文件版本的來源：
17. GitHub repo tree 驗證狀態：
18. 是否可宣稱已寫入 GitHub：
19. 是否可宣稱已 commit：
20. 是否可宣稱已建立 PR：
21. 備註：

---

## 12. 下一步動作欄位

請逐項回答：

1. ChatGPT 接下來要做：
2. 使用者需要做：
3. 是否需要提供資料：
4. 是否需要 GitHub / Lovable 手動操作：
5. 是否需要先產生治理同步結果文件：
6. 是否需要產生 Markdown：
7. 是否需要產生 GitHub Archive JSON：
8. 是否需要產生治理更新提案：
9. 下一步建議提示詞：

最後必須提供一段可直接複製的下一步提示詞。

---

## 13. 不得找不到就新增文件

這是本 v1.7 新增的核心規則。

當 ChatGPT 找不到某份文件、無法列出目錄、或尚未讀取完整 Current 文件時，不得直接建議新增平行文件。

正確流程：

1. 先確認 repo 是否可讀。
2. 再確認 folder tree 是否有檔名。
3. 再嘗試 GitHub Connector 讀取。
4. 再檢查是否有既有文件可更新。
5. 若讀取失敗，回報失敗原因。
6. 若找到功能相近文件，優先更新既有文件。
7. 只有確認不存在適合文件時，才提出新增文件建議。
8. 新增文件前需說明：
   - 為何既有文件不足。
   - 新文件的獨立功能。
   - 不會造成多頭馬車的原因。
   - 與既有文件的分工關係。

---

## 14. 文件更新優先於新增文件

若已有功能相同或高度相似的文件，應優先採用以下方式：

1. 升版既有文件。
2. 整合新增內容。
3. 保留舊版上下文。
4. 標示舊版 superseded。
5. 更新 Document System Index。
6. 必要時產生 Archive JSON。
7. 不新增平行入口文件。

本次已確認：

- 不新增《LOHAShare AI Platform 新對話規範同步啟動指南 v1.0》。
- 改為升級 `LOHAShare_AI_Platform_New_Conversation_Handoff_v1.6_20260601.md`。
- 本文件即為升級版 v1.7。

---

## 15. 命名層級固定規則

LOHAShare AI Platform 的層級如下：

| 層級 | 名稱 | 定位 |
|---|---|---|
| Level 0 | LOHAShare AI Platform | 長期平台品牌與總體架構 |
| Level 1 | LOHAShare AI 商務網站營運控制台 / LOHAShare AI Console | 主 PRD / 主產品 |
| Level 2 | LOHAShare AI Lead & Notification Console MVP | 第一個 MVP 實作線 |
| Level 3 | Lead Console、Email Notification、AI FAQ / AEO、Referral、Operator Dashboard、Client Portal、Billing / Commercialization | 功能模組或子系統 |
| Level 4 | Support Ticket、Fallback POC、Developer Prompt、Test Log、SOP、Release Note | 模組衍生文件 |

固定規則：

1. 主 PRD 不等於 Nexus Lead Ops。
2. Nexus Lead Ops / Lead & Notification Console 屬於主 PRD 底下的實作線或子系統。
3. Nexus Lead Ops 不得作為平行正式模組資料夾。
4. 若對話涉及 Nexus Lead Ops，應優先映射至 `Lead Console` 或 Level 2 實作線。
5. Developer Prompt 屬於 Level 4 文件類型，正本放 `05_Developer_Prompts`。

---

## 16. Developer Prompt 正本規則

Developer Prompt 正本一律放：

```text
docs/LOHAShare_AI_Platform/05_Developer_Prompts/<Category>/Current/
```

不得放：

```text
docs/LOHAShare_AI_Platform/02_Modules/{Module}/Developer_Prompts/
```

若 Prompt 與模組有關，模組文件只能引用 Prompt 正本路徑，不得複製正本。

若 Prompt Category 尚未存在，應先提出治理更新提案，不得靜默新增正式路徑。

---

## 17. GitHub / Lovable / Supabase / Provider 宣稱限制

除非 ChatGPT 實際使用相應工具完成操作，否則不得宣稱：

1. 已寫入 GitHub。
2. 已 commit。
3. 已建立 PR。
4. 已修改 Lovable。
5. 已完成 Lovable deploy。
6. 已修改 Supabase schema。
7. 已套用 RLS policy。
8. 已切換 Email Provider。
9. 已完成 GitHub Actions。
10. 已通過 CI。

若只是產生檔案，應說：

> 已產生歸檔素材，但尚未寫入 GitHub、尚未 commit、尚未建立 PR。

若只是使用者聲明已同步，應說：

> 使用者已聲明已透過 GitHub Desktop commit / sync；ChatGPT 尚未實際驗證 commit / PR。

---

## 18. 文件整編與 Clean Version 原則

若文件經歷多次補正、反覆修訂或規則分散，應進入 Clean Version 整編流程。

整編不是刪除內容，也不是摘要化，而是：

1. 保留完整上下文。
2. 合併相似規則。
3. 移除重複矛盾。
4. 將補正歷史移至版本歷程或附錄。
5. 讓正文變成清楚、可執行、可交接。
6. 舊版保留於 Archive 或標示 superseded。
7. 更新 Document System Index。

---

## 19. 新對話標準啟動 Prompt

未來新對話可直接貼以下 Prompt：

```text
請先依照 `LOHAShare_AI_Platform_New_Conversation_Handoff_v1.7_Preflight_Action_Guide` 進入 Preflight Only Mode，不要產生檔案。

本回合請先完成：
1. 官方治理基準同步結果
2. 啟動前檢查結果
3. 歸檔判斷
4. 下一步動作

請先讀取或對照：
1. GitHub `docs/LOHAShare_AI_Platform/`
2. `00_Index/Current/`
3. `01_Architecture_Governance/<Topic>/Current/`
4. `00_Main_PRD/Current/`
5. `05_Developer_Prompts/<Category>/Current/`

請注意：
- 不得直接產生 Markdown / JSON / ZIP。
- 不得直接修改 GitHub / Lovable / Supabase。
- 不得宣稱已 commit / PR。
- 若找不到文件，不得直接新增平行文件；請先回報缺口並檢查是否可更新既有文件。
- 若需要產生檔案，請在下一步動作提供可複製提示詞，等我確認後再執行。
```

---

## 20. File Generation 標準授權 Prompt

當 Preflight 結果確認後，使用者可貼：

```text
請直接執行下一步，依據本次已確認的 Preflight 結果，產生【文件名稱】Markdown 完整新版，並產生對應 GitHub Archive JSON；不得宣稱已寫入 GitHub、不得宣稱已 commit、不得建立 PR。
```

---

## 21. 版本歷程

| 版本 | 日期 | 狀態 | 說明 |
|---|---|---|---|
| v1.6 | 2026-06-01 | Current | 新對話應以 GitHub `docs/LOHAShare_AI_Platform/` 為工作基準，並列出判斷順序。 |
| v1.7 | 2026-06-09 | Draft / Handoff Upgrade | 以 v1.6 為基準升版，整合 Preflight Only Mode、File Generation Mode、GitHub Connector 讀取流程、四大區塊輸出、不得找不到就新增文件、不得宣稱外部操作完成等規則。 |

---

## 22. 本版歸檔判斷

是否已從舊版新增補內容：  
是，從 v1.6 新增 Preflight Only Mode、File Generation Mode、GitHub Connector 讀取流程、四大區塊輸出規則、不得找不到就新增文件、不得宣稱 GitHub / Lovable / Supabase 操作完成等規則。

從哪確認文件版本的來源：  
GitHub Connector 已讀取 `LOHAShare_AI_Platform_New_Conversation_Handoff_v1.6_20260601.md`、`Document System Index v2.0`、`Current Folder Structure v1.5`、`Document Governance Rules v0.2`、`Document Format Strategy v0.1`、`Modular Architecture Governance v1.2`、`Automation Strategy and DocOps Roadmap v1.3`、`Document Consolidation Plan v0.1`、`Document Content Quality Rules v0.1` 等 Current 文件。

GitHub repo tree 驗證狀態：  
已透過使用者提供之 `LOHAShare_AI_Platform_file_tree.txt` 取得 Current 檔名清單，並透過 GitHub Connector 成功讀取多份 Current Markdown 文件內容；本次僅產生歸檔素材，尚未寫入 GitHub。

---

# Part B｜v1.8 增補條款區

以下為 v1.8 新增增補條款。  
本區不改寫 Part A 的 v1.7 原文，而是在原文完整保留後，集中補強本次 DocOps / GitHub 文件治理偏移事件所需新增的行動規則。

---

## 23. v1.8 升版定位與原文保留原則

### 23.1 本版升版定位

本 v1.8 是 `LOHAShare_AI_Platform_New_Conversation_Handoff_v1.7_Preflight_Action_Guide_20260609.md` 的原文保留修正版升版草案。

本版目的不是建立新的平行治理文件，也不是新增一份「文件治理校正原則」文件，而是將本次 DocOps / GitHub 文件治理偏移事件中的經驗與教訓，補強進既有 New Conversation Handoff 的行動規範中。

### 23.2 原文保留公式

本版必須符合：

```text
v1.8 = v1.7 原文完整保留 + v1.8 增補條款
```

不得採用以下方式：

```text
v1.8 = v1.7 摘要 + 新增規則
v1.8 = v1.7 重寫版
v1.8 = v1.7 精簡版
v1.8 = 平行新治理文件
```

### 23.3 原文區與增補區分離

為降低人工審核成本，本版採用：

1. Part A：v1.7 原文完整保留區。
2. Part B：v1.8 增補條款區。
3. Part C：檢核與歸檔判斷區。

此結構讓使用者可以快速確認：

1. v1.7 原文是否仍完整存在。
2. v1.8 新增條款是否合理。
3. 是否存在摘要化、重寫、刪除或平行權威文件風險。

---

## 24. 既有資料夾架構優先於 GitHub code search

### 24.1 硬性查找順序

任何與 LOHAShare AI Platform 文件治理、Index、Handoff、Current、Archive、主 PRD、Developer Prompt、DocOps 或模組文件有關的任務，ChatGPT / AI Assistant 必須優先依照既有資料夾治理架構查找，不得先以 GitHub code search 作為第一判斷依據。

硬性順序如下：

1. 先確認使用者是否要求不要產檔、不要 commit、不要寫入 GitHub。
2. 先確認 repo 與工作根路徑。
3. 先讀取或對照 Document System Index。
4. 先檢查 `00_Index/Current/`。
5. 再檢查 Current Folder Structure。
6. 再檢查任務相關的治理或模組 Current 文件。
7. 再 fetch 明確已知路徑。
8. 最後才使用 GitHub search 補查。
9. 若仍找不到，回報讀取缺口與候選來源。
10. 不得直接新增平行文件。

### 24.2 `00_Index/Current` 優先規則

下列任務應優先從 `00_Index/Current/` 開始：

1. 尋找 Document System Index。
2. 尋找 New Conversation Handoff。
3. 尋找 Current Folder Structure。
4. 判斷新對話啟動入口。
5. 判斷權威文件是否應升版。
6. 判斷是否需要更新 Index。
7. 判斷 Current / Archive 的版本流向。

### 24.3 GitHub search 的限制

GitHub search 只能作為補查工具，不得作為第一查找依據。

不得使用以下錯誤流程：

```text
GitHub search 無結果
→ 判斷文件不存在
→ 建議新增文件
→ 產生平行文件
```

正確流程應為：

```text
先讀 00_Index/Current
→ 先讀 Document System Index
→ 先讀 Current Folder Structure
→ 先 fetch 明確候選路徑
→ 再用 GitHub search 補查
→ 仍找不到時回報缺口
→ 請使用者確認候選來源
→ 最後才判斷是否需要新增文件
```

---

## 25. Current 不得作為工作暫存區

### 25.1 Current 的定義

Current 只應放目前有效、可被後續工作直接引用的基準文件。

適合放入 Current 的文件包括：

1. 目前有效的 Document System Index。
2. 目前有效的 New Conversation Handoff。
3. 目前有效的 Current Folder Structure。
4. 目前有效的 Document Governance Rules。
5. 目前有效的主 PRD。
6. 目前有效的模組規格。
7. 目前有效的 Developer Prompt 正本。
8. 目前有效的 SOP / QA 基準文件。
9. 目前有效且長期可引用的 Automation / DocOps 基準文件。

### 25.2 不應預設進 Current 的文件

以下文件不得預設放入 Current：

1. 中間檢查稿。
2. 搜尋結果報告。
3. 候選路徑報告。
4. 差異檢查草案。
5. 一次性確認紀錄。
6. 尚未確認長期價值的工作稿。
7. AI 思考過程紀錄。
8. 只為了確認下一步而產生的文件。
9. Formal Draft、Body Draft、Pre-Update Diff Check 等過程性文件，除非使用者明確批准其具備長期治理價值。

### 25.3 Working / Archive / Audit 的候選角色

若內容尚未定稿，應優先考慮：

1. 對話內保留。
2. Working。
3. Audit / Log。
4. Archive。
5. Completion Note。

若 Working / Audit / Log 尚未在既有治理架構中明確存在，ChatGPT 不得靜默新增資料夾，應先提出 dry-run 建議，說明：

1. 候選資料夾名稱。
2. 候選路徑。
3. 與 Current / Archive 的分工。
4. 是否需更新 Current Folder Structure。
5. 是否需使用者明確批准。

---

## 26. AI 不得把每一步思考都產生成正式治理文件

### 26.1 預設對話內處理

AI 的判斷、搜尋過程、暫時分類、風險提醒、下一步建議，預設應停留在對話內，不得自動產生成正式治理文件。

### 26.2 產檔前層級判斷

在任何產檔前，必須先回答：

1. 這是新權威文件嗎？
2. 這是既有權威文件升版嗎？
3. 這是工作稿嗎？
4. 這是一次性紀錄嗎？
5. 這是 Archive / Audit / Log 嗎？
6. 這是否有長期治理價值？
7. 是否已有既有文件可更新？
8. 是否會造成 Current 膨脹？
9. 是否需要先 dry-run？
10. 是否已取得使用者明確批准？

未完成上述判斷前，不得產生 Markdown、Archive JSON、ZIP 或 GitHub 寫入。

### 26.3 偏移校正不得造成更多偏移

若目前正在處理「文件治理偏移校正」，預設更應停止新增文件。  
不得為了校正文件過多問題，而再產生更多中間校正文件。

---

## 27. 找不到文件時的處理流程

### 27.1 禁止推論

找不到文件時，不得做以下推論：

1. 不得推論 GitHub 中不存在該文件。
2. 不得推論使用者尚未建立該文件。
3. 不得推論應新增新文件。
4. 不得推論應建立新資料夾。
5. 不得推論應更新 Index。
6. 不得推論可跳過既有資料夾架構。

### 27.2 必須回報的讀取缺口

找不到文件時，應先輸出：

```text
已查詢的明確路徑：
已使用的 search 關鍵字：
已知的候選資料夾：
已知的候選檔名：
讀取失敗原因：
需要使用者確認的資訊：
```

### 27.3 使用者截圖與檔案樹的處理

若使用者提供 GitHub 資料夾截圖、檔案樹、檔名或路徑，ChatGPT 應：

1. 將其列為候選路徑線索。
2. 不得把截圖直接等同為已 fetch 驗證。
3. 應根據截圖中的明確路徑執行 read-only fetch。
4. 若 fetch 成功，才可說該檔案存在且可讀。
5. 若 fetch 失敗，應回報路徑、錯誤與替代來源。
6. 不得忽略截圖中明顯存在的 `00_Index/Current/`、`Current/`、`99_Archive/` 或其他治理目錄。

---

## 28. 權威文件升版前必須做原文保留檢核

### 28.1 適用範圍

凡涉及以下文件，皆屬權威文件升版：

1. New Conversation Handoff。
2. Document System Index。
3. Current Folder Structure。
4. Document Governance Rules。
5. Folder and File Management Rules。
6. 主 PRD。
7. Modular Architecture Governance。
8. Automation Strategy and DocOps Roadmap。
9. Developer Prompt 正本。
10. 其他被 Document System Index 指定為 Current 基準的文件。

### 28.2 升版前必要資訊

升版前必須取得：

1. 原始文件 path。
2. 原始 SHA。
3. 原始文件標題。
4. 原始版本號。
5. 原始文件狀態。
6. 原始章節清單。
7. 原始不可刪除區塊。
8. 新增內容來源。
9. 使用者授權範圍。

### 28.3 原文保留檢核

升版草案必須通過：

1. 原始章節是否全部保留。
2. 原始核心規則是否全部保留。
3. 不可刪除區塊是否全部存在。
4. 是否有章節被摘要化。
5. 是否有章節被改寫到失去原意。
6. 是否有未經授權的刪除。
7. 是否有新增平行權威文件。
8. 是否有違反 Current / Archive 原則。

### 28.4 推薦升版結構

為降低審核成本，權威文件升版優先採用：

```text
新版檔頭
+ 原始文件完整保留區
+ 新版增補條款區
+ 原文保留檢核表
+ 差異檢核表
```

除非使用者明確批准進入 Clean Version 整編，否則不得直接重寫正文。

---

## 29. 所有移動、刪除、更新、Archive、Index 更新都必須先 dry-run

### 29.1 必須 dry-run 的操作

涉及以下操作時，必須先 dry-run：

1. 新增文件。
2. 更新文件。
3. 移動文件。
4. 刪除文件。
5. Archive 文件。
6. 更新 Document System Index。
7. 更新 Current Folder Structure。
8. 重整 Current 目錄。
9. 建立新資料夾。
10. 變更 Developer Prompt 正本路徑。
11. 回 Lovable Build。
12. 變更 Supabase / Provider / GitHub Actions 相關設定。

### 29.2 dry-run 必須包含

dry-run 應包含：

1. 目標檔案。
2. 目標路徑。
3. 目前 SHA。
4. 擬執行動作。
5. 影響範圍。
6. 是否涉及權威文件。
7. 是否需要同步更新 Index。
8. 是否需要 Archive 舊版。
9. 風險。
10. 使用者需要批准的事項。

### 29.3 使用者批准前禁止事項

在使用者批准前，不得：

1. 寫入 GitHub。
2. commit。
3. 建立 PR。
4. 移動文件。
5. 刪除文件。
6. Archive 文件。
7. 更新 Document System Index。
8. 回 Lovable Build。
9. 宣稱上述事項已完成。

---

## 30. 工具安全封鎖時的處理

若 GitHub create_file / update_file / delete_file 或其他工具調用被安全檢查封鎖，ChatGPT 應：

1. 立即停止。
2. 回報哪一個工具調用失敗。
3. 回報尚未完成的檔案或操作。
4. 不得自行改檔名。
5. 不得自行改路徑。
6. 不得自行改內容後重試。
7. 不得宣稱已完成。
8. 應請使用者決定是否手動上傳或另行批准重試。

---

## 31. v1.8 新對話標準啟動 Prompt 補強版

未來新對話可直接貼以下 Prompt：

```text
請先依照 `LOHAShare_AI_Platform_New_Conversation_Handoff_v1.8_Preflight_Action_Guide` 進入 Preflight Only Mode，不要產生檔案。

本回合請先完成：
1. 官方治理基準同步結果
2. 啟動前檢查結果
3. 歸檔判斷
4. 下一步動作

請先讀取或對照：
1. GitHub `docs/LOHAShare_AI_Platform/`
2. `00_Index/Current/`
3. `00_Index/Current/LOHAShare_AI_Platform_Document_System_Index`
4. `00_Index/Current/LOHAShare_AI_Platform_Current_Folder_Structure`
5. `01_Architecture_Governance/<Topic>/Current/`
6. `00_Main_PRD/Current/`
7. `05_Developer_Prompts/<Category>/Current/`

請注意：
- 不得直接產生 Markdown / JSON / ZIP。
- 不得直接修改 GitHub / Lovable / Supabase。
- 不得宣稱已 commit / PR。
- 不得用 GitHub code search 取代既有資料夾治理架構。
- `00_Index/Current` 應優先於 keyword search。
- Current 不得作為工作暫存區。
- 中間檢查文件不得預設進 Current。
- AI 不得把每一步思考都產生成正式治理文件。
- 若找不到文件，不得直接新增平行文件；請先回報缺口並檢查是否可更新既有文件。
- 若需要升版權威文件，必須先做原文保留檢核與差異檢核表。
- 所有移動、刪除、更新、Archive、Index 更新都必須先 dry-run。
- 若需要產生檔案，請在下一步動作提供可複製提示詞，等我確認後再執行。
```

---

# Part C｜檢核與歸檔判斷區

## 32. 原文保留檢核表

| 檢核項目 | 檢核結果 | 備註 |
|---|---|---|
| 原始文件 path | 已確認 | `docs/LOHAShare_AI_Platform/00_Index/Current/LOHAShare_AI_Platform_New_Conversation_Handoff_v1.7_Preflight_Action_Guide_20260609.md` |
| 原始 SHA | 已確認 | `535475aceb40385184b2b9ea25c1e0ed4f8614a3` |
| 是否 read-only fetch | 已執行 | 本對話已分段 fetch 至 v1.7 文末 |
| v1.7 原文是否獨立保留 | 是 | Part A 為原文完整保留區 |
| v1.8 補強是否集中於增補條款區 | 是 | Part B 為新增補強條款 |
| 是否穿插改寫 v1.7 原文 | 否 | v1.7 原文區未穿插 v1.8 條款 |
| 是否刪除 v1.7 原始章節 | 否 | 未設計刪除章節 |
| 是否摘要化 v1.7 | 否 | 採原文保留區方式 |
| 是否新增平行權威文件 | 否 | 不新增「文件治理校正原則」文件 |
| 是否符合「原文完整保留 + 增補修訂」 | 初步符合 | 產檔前仍建議再做一次人工抽查 |

---

## 33. 新增條款清單

| 新增條款 | 位置 | 用途 |
|---|---|---|
| v1.8 升版定位與原文保留原則 | 第 23 章 | 防止摘要化升版 |
| 既有資料夾架構優先於 GitHub code search | 第 24 章 | 修正 search 優先造成的偏移 |
| Current 不得作為工作暫存區 | 第 25 章 | 防止 Current 膨脹 |
| AI 不得把每一步思考都產生成正式治理文件 | 第 26 章 | 防止過度文件化 |
| 找不到文件時的處理流程 | 第 27 章 | 防止找不到就新增 |
| 權威文件升版前必須做原文保留檢核 | 第 28 章 | 防止摘要化或誤刪 |
| 所有移動、刪除、更新、Archive、Index 更新都必須先 dry-run | 第 29 章 | 防止未授權寫入或整理 |
| 工具安全封鎖時的處理 | 第 30 章 | 防止工具失敗後自行重試造成風險 |
| v1.8 新對話標準啟動 Prompt 補強版 | 第 31 章 | 提供未來新對話可直接使用的啟動提示詞 |

---

## 34. 修改章節清單

| 原章節 | 修改方式 | 是否保留原文 |
|---|---|---|
| v1.7 全文 | 未直接修改 | 是 |
| v1.8 檔頭 | 新增新版檔頭 | 不適用 |
| v1.8 增補條款 | 集中新增於 Part B | 不適用 |
| v1.7 原文 | 未穿插改寫 | 是 |

---

## 35. 刪除章節清單

| 原章節 | 是否刪除 | 原因 |
|---|---|---|
| 無 | 無刪除 | 採原文完整保留策略 |

---

## 36. 摘要化風險檢查

| 檢查項目 | 結果 | 備註 |
|---|---|---|
| 是否把 v1.7 改成摘要版 | 否 | Part A 保留原文 |
| 是否刪除 v1.7 章節 | 否 | 無刪除 |
| 是否重寫 v1.7 原文 | 否 | v1.8 條款集中於 Part B |
| 是否新增平行權威文件 | 否 | 併入 Handoff 升版 |
| 是否造成文件變長 | 是 | 這是原文保留升版的必要成本 |
| 是否仍需人工快速審核 | 是 | 建議使用表格快速確認 Part A / Part B 分界 |

---

## 37. 【歸檔判斷】

本次內容是否建議立即歸檔：  
暫不建議立即歸檔。

判斷理由：

1. 本草案目前仍是對話內修正版草案。
2. 尚未產生實體 Markdown 檔案。
3. 尚未產生 Archive JSON。
4. 尚未執行同名檔檢查。
5. 尚未確認 v1.8 正式檔名與日期。
6. 尚未決定是否同步產生 v1.7 Archive / superseded 處理方案。
7. 尚未決定是否於 v1.8 正式寫入後更新 Document System Index。

建議後續若使用者確認，才進入產檔階段。

建議檔名候選：

```text
LOHAShare_AI_Platform_New_Conversation_Handoff_v1.8_Preflight_Action_Guide_20260819.md
```

建議 Current 路徑候選：

```text
docs/LOHAShare_AI_Platform/00_Index/Current/
```

建議 Archive 路徑候選：

```text
docs/LOHAShare_AI_Platform/00_Index/99_Archive/
```

建議 commit message 候選：

```text
docs(index): add New Conversation Handoff v1.8
```

---

## 38. 【下一步動作】

下一步建議：

1. 產生 Markdown 實體檔案。
2. 產生 GitHub Archive JSON。
3. 下載後由使用者人工快速確認 Part A / Part B / Part C 結構。
4. 執行 GitHub 同名檔 read-only 檢查。
5. 若無衝突，再由使用者決定是否批准 GitHub 寫入。


# Part D｜v1.9 Repository Boundary and Autonomous Mission 增補區

版本：v1.9｜日期：2026-08-31｜狀態：Repository Boundary and Autonomous Governance Handoff Candidate

## 39. Canonical Repository Preflight

每次新對話及每個 Mission 必須先固定：

- Repository：`yuehsir/lohashare`
- Branch：`master`
- Governance root：`docs/LOHAShare_AI_Platform/`
- Lovable Project：`8a6788ab-4762-4e8a-9953-5f351ec760a0`
- Lovable private Git 與正式文件治理 Repository 為不同 Repository。

不得以 Lovable private Git 的 HEAD、commit 或同一路徑檔案，宣稱正式 GitHub 已歸檔。GitHub 寫入後必須重新 fetch GitHub path、blob SHA、commit SHA 與 diff。

## 40. 新對話 Current 載入順序

1. Document System Index v2.2。
2. New Conversation Handoff v1.9。
3. Current Folder Structure。
4. Document Governance Rules。
5. Automation Strategy and DocOps Roadmap v1.4。
6. 任務相關 Current 權威文件。
7. 最後才使用 GitHub search 補查。

## 41. 一般互動模式

一般互動模式沿用 Part A 至 Part C 的 dry-run、逐次明確核准、四大區塊輸出與下一步提示詞規則。未啟動 Autonomous Governance Loop 時，不得把 Project-level Charter 當作當次寫入授權。

## 42. Autonomous Mission 模式

只有 Founder 使用「啟動 Autonomous Governance Loop」語法並提供 Mission 時才可啟動。啟動前必須：

1. 完整讀取 Automation Strategy and DocOps Roadmap v1.4。
2. 驗證其中 Charter v1.0 完整存在。
3. 核對 Project Instructions Bridge。
4. 確認 Mission、Baseline、Special Authorization、Stop After。
5. 確認 Repository + Branch + Path。
6. 若任一來源缺失或不一致，HOLD。

Mission 內 Level A 可自動銜接；Level B 只限 Mission 明確授權且 Controlled Write Gate 全部成立；Level C 必須 HOLD。

## 43. Completion Note 與自動歸檔

Completion Note Dry-run 可在 Mission 內自動執行。實際歸檔必須同時具備：

1. Mission 明確包含歸檔。
2. Repository、Branch、Path 與單一檔案白名單明確。
3. 寫入前 HEAD 與工作樹符合基準。
4. 寫入後 GitHub Connector Final Archive Verification PASS。

## 44. Repository Boundary 漂移停止條件

遇到下列任一狀況立即 HOLD：

- GitHub 與 Lovable Repository 被混同。
- 只知道相對 path，不知道 Repository 或 branch。
- Lovable commit 被當成 GitHub commit。
- 正式 GitHub 目標已存在但內容不同。
- Current 同時出現多個未標記 superseded 的權威版本。
- 需要啟用 Git sync、建立產品 Repository 或新增 Connector。
- 無法完整載入 Charter。

## 45. v1.8 Stale Metadata Correction

Part A／Part B／Part C 中「尚未寫入 GitHub」「尚未 commit」等描述屬 v1.8 草案當時狀態。本 v1.9 以 GitHub Connector 實際 fetch 結果校正：v1.8 已存在於 `yuehsir/lohashare/master`，blob SHA 為 `2ef0697f0eeb6656a65147aeeddf78a94d49d30a`。原文保留區不再代表目前外部狀態。

## 46. Supersession

v1.9 正式驗證後，v1.8 移至 `00_Index/99_Archive/` 並標記 superseded；Current 不保留兩個有效 Handoff 版本。