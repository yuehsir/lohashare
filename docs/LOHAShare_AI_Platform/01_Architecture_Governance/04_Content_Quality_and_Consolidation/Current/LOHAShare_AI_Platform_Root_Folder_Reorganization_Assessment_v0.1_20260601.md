# LOHAShare AI Platform 根目錄資料夾重整評估表 v0.1

日期：2026-06-01  
狀態：Draft for Review  
用途：評估各根目錄是否需要重整、如何重整、何時重整，以及使用者需要配合的 GitHub 操作。

## 一、文件目的

本文件用於判斷 LOHAShare_AI_Platform 根目錄下各資料夾是否需要採用 Current / 99_Archive、日期分類、事件流程分類或維持現狀。

本文件不是直接搬移檔案的執行結果，而是搬移前的評估與分批執行依據。

核心原則：不要把 01_Architecture_Governance 的二級分類做法硬套到所有資料夾；每個根目錄應依文件性質採用不同治理模型。

## 二、目前已確認的治理前提

- GitHub 是 Working Source of Truth，Dropbox 是 Formal Archive / Distribution Copy。
- 文件版本採用「新版本產生新檔案」策略，不覆蓋舊版。
- 最新版文件應便於快速查找；舊版文件應保留可追溯性。
- 治理文件已開始採用 Markdown 工作版 + DOCX 閱讀版雙格式策略。
- GitHub Actions 已可執行 Docs Package、Docs Governance Check、Docs Manifest Check。
- 01_Architecture_Governance 已完成二級分類第一輪重整與 GitHub Actions 驗收。

## 三、根目錄重整評估總表

| 根目錄 | 是否需調整 | 建議治理模型 | 優先級 | 理由 |
|---|---|---|---|---|
| 00_Index | 需要小幅調整 | Current / 99_Archive | 高 | 索引、Handoff、Folder Structure 會持續升版，最新版必須好找。 |
| 00_Main_PRD | 需要但不急 | Current / 99_Archive + v2 Workspace | 中高 | 主 PRD 是產品主軸，未來 v2.0 Clean Version 需要工作區。 |
| 01_Architecture_Governance | 已完成第一輪 | 主題分類 + Current / 99_Archive | 已完成 | 檔案量最大，已先行重整。 |
| 02_Modules | 需要逐模組處理 | 模組工作流程型 + 局部 Current / 99_Archive | 中 | 模組內含規格、測試、截圖、決策紀錄，不能硬套單一模型。 |
| 03_SOP_and_QA | 暫時不急 | 依 SOP 類別分層，必要時 Current / 99_Archive | 低 | 目前內容量少，先維持現狀即可。 |
| 04_Support_Knowledge_Base | 需要另一套流程 | Incident / Ticket / Known Issue / Resolved | 中 | Support KB 是事件與知識累積，不適合純版本治理。 |
| 05_Developer_Prompts | 需要逐步調整 | 依工具/模組分類 + Current / 99_Archive | 高 | Prompt 版本會快速累積，容易混淆正本位置。 |
| 06_Release_Notes | 暫時不需 Current / Archive | 日期或版本序列 | 低 | Release Notes 本身就是時間序列紀錄。 |
| 07_Archive | 不需同樣調整 | 平台級封存 | 低 | 用於錯誤結構、舊 ZIP、廢止資料，不再建立複雜版本層。 |

## 四、建議分批執行順序

1. Phase A：00_Index
2. Phase B：00_Main_PRD
3. Phase C：05_Developer_Prompts
4. Phase D：02_Modules
5. Phase E：04_Support_Knowledge_Base

## 五、您現在需要做什麼

- 暫時不要搬移其他根目錄檔案。
- 先確認本評估表中的分批策略是否合理。
- 若確認，下一步建議先處理 00_Index。
- 處理 00_Index 前，需先列出該資料夾目前有哪些檔案與版本。
- 每完成一個根目錄重整，都需 commit / push，然後跑 Docs Governance Check 與 Docs Package。

## 六、初步結論

其他根目錄不是不需要重整，而是不應全部照 01_Architecture_Governance 的方式一次套用。

最安全、有效、適合自動化的策略是：先評估各根目錄文件性質，再分批重整，每次重整後都同步更新治理文件與 GitHub Actions 檢查。

本文件建議下一步優先處理 00_Index，接著處理 00_Main_PRD 與 05_Developer_Prompts。
