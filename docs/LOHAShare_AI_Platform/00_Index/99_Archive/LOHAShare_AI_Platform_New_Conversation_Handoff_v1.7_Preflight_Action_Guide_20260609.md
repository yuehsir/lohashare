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
