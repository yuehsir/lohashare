# LOHAShare AI Platform 文件格式與雙軌治理策略 v0.1

版本：v0.1  
日期：2026-06-01  
狀態：Draft Generated｜需人工審核後才可標記為 Stable  
建議放置位置：`LOHAShare_AI_Platform/01_Architecture_Governance/`  
英文名稱：LOHAShare AI Platform Document Format Strategy v0.1

---

## 0. 文件定位聲明

本文件不是會議紀錄，也不是摘要收錄。  
本文件是 LOHAShare AI Platform 文件治理體系中的「文件格式與雙軌治理策略」正式規則草案，用來定義未來 `.md`、`.docx`、`.pdf`、`.yml` 等格式在文件治理、AI 審查、GitHub Actions 自動化、正式交付與封存中的分工。

本文件回應一個核心問題：

> 若 LOHAShare AI Platform 的正式文件多為 DOCX，GitHub Actions 與 AI 如何進一步協助內容分析、文件整編、邏輯一致性檢查與閱讀友善化？

本文件的核心結論是：

> DOCX 不應被取消；但 DOCX 不能單獨承擔「文件即程式」的工作。  
> 未來應採用「Markdown / YAML 作為自動化工作層，DOCX / PDF 作為正式閱讀與交付層」的雙軌治理模式。

---

## 1. 背景與問題

目前 LOHAShare AI Platform 的文件治理已經建立 GitHub repository、`docs/LOHAShare_AI_Platform/` 資料夾基準、GitHub Actions 打包與治理檢查、以及 `module.manifest.yml`。這些工作已經讓文件開始具備「可被檢查、可被打包、可被驗證」的能力。

然而，這些能力目前仍偏向「結構治理」，例如：

- 檢查資料夾是否存在。
- 檢查禁用資料夾是否出現。
- 檢查 `module.manifest.yml` 是否具備必要欄位。
- 打包 `docs/LOHAShare_AI_Platform/` 為 ZIP artifact。

但若要進一步做到：

- 分析文件是否摘要化導致內容遺失。
- 判斷文件是否邏輯斷裂。
- 判斷主 PRD、MVP、模組與衍生文件的定位是否一致。
- 將補丁式文件整編成閱讀友善的 Clean Version。
- 讓 AI / GitHub Actions / scripts 可以自動檢查內容品質。

只靠 DOCX 會非常困難。

### 1.1 DOCX 的優點

DOCX 適合：

- 正式閱讀。
- 內部交付。
- 對外轉 PDF。
- 放圖片、表格、版面設計。
- 顧問式文件呈現。
- 客戶或非工程人員閱讀。

### 1.2 DOCX 的限制

DOCX 不適合單獨作為文件即程式主線，原因包括：

- GitHub diff 不容易看出內文變更。
- GitHub Actions 不容易穩定解析章節與段落。
- AI / scripts 若沒有先抽取文字，難以直接進行一致性檢查。
- 表格、圖片、頁首頁尾在轉換過程中容易造成解析差異。
- 若文件被摘要化或補丁化，GitHub 難以自動判斷閱讀品質。

因此，DOCX 應繼續存在，但需要搭配 Markdown / YAML 層。

---

## 2. 雙格式治理總原則

LOHAShare AI Platform 從本文件發布後，採用以下文件格式分工：

| 格式 | 正式角色 | 主要用途 | 是否適合自動化 | 是否適合正式閱讀 |
|---|---|---|---|---|
| `.md` | Markdown 工作版 | 內容主體、GitHub diff、AI 審查、GitHub Actions 內容檢查 | 高 | 中 |
| `.docx` | Word 閱讀版 | 正式閱讀、內部交付、排版、圖片、表格 | 中低 | 高 |
| `.pdf` | 發布 / 封存版 | 對外發布、不可任意修改、封存 | 低 | 高 |
| `.yml` / `.yaml` | 機器可讀規則版 | manifest、任務清單、狀態、治理檢查、AI / scripts 指令來源 | 高 | 低 |
| `.txt` | 輕量索引 / Tree | folder tree、README、純文字紀錄 | 高 | 中 |
| `.csv` | 測試與稽核資料 | 測試紀錄、矩陣、表格式數據 | 高 | 中 |

核心規則：

> Markdown / YAML 是自動化工作層。  
> DOCX / PDF 是正式閱讀與交付層。

---

## 3. Source of Truth 規則

### 3.1 GitHub 是工作基準

在文件治理與自動化流程中，GitHub repository 中的 `docs/LOHAShare_AI_Platform/` 是 Working Source of Truth，也就是「工作中的唯一基準」。

GitHub 負責：

- 文件版本管理。
- 資料夾結構管理。
- Markdown 工作版管理。
- YAML manifest 管理。
- GitHub Actions 檢查與打包。
- 文件即程式自動化基礎。

### 3.2 Dropbox 是正式封存與分享副本

Dropbox 不作為工作基準，而是 Formal Archive / Distribution Copy。

Dropbox 適合放：

- 最終 DOCX。
- 最終 PDF。
- ZIP 匯出包。
- 對外分享文件。
- 已核准的封存版本。

若 GitHub 與 Dropbox 不一致，除非使用者明確聲明「本次上傳人工修訂版為正式版本」，否則工作判斷以 GitHub 為準。

### 3.3 Local PC 是實際編輯工作區

Local PC 是實際編輯位置，但不應成為單獨真相來源。Local PC 文件完成後，應同步到 GitHub；正式封存時，再匯出到 Dropbox。

---

## 4. 新文件建立規則

從本文件發布後，凡屬以下類型的新文件，建議同時建立 `.md` 與 `.docx`：

- 架構治理文件。
- 文件治理文件。
- 自動化策略文件。
- 文件內容品質規則。
- 文件整編計畫。
- 文件稽核與補正總表。
- 主 PRD v2.0 Clean Version。
- 重要模組規格 v2.0 Clean Version。
- 重要 SOP / Playbook。

### 4.1 新文件的建議檔案組合

以「文件格式與雙軌治理策略」為例：

```text
LOHAShare_AI_Platform_Document_Format_Strategy_v0.1_20260601.md
LOHAShare_AI_Platform_Document_Format_Strategy_v0.1_20260601.docx
```

若需要對外發布，再建立：

```text
LOHAShare_AI_Platform_Document_Format_Strategy_v0.1_20260601.pdf
```

### 4.2 短期執行方式

在 GitHub Actions 自動轉檔尚未建立前，短期由 ChatGPT 或人工流程同時產出：

- `.md` 工作版。
- `.docx` 閱讀版。

這是過渡期策略，不是最終自動化架構。

### 4.3 中期執行方式

中期建立 GitHub Actions workflow：

```text
.github/workflows/docs-convert-md-to-docx.yml
```

流程：

```text
Markdown 更新
→ GitHub Actions 執行轉檔
→ 產生 DOCX artifact
→ 必要時產生 PDF
→ 打包進文件包
```

### 4.4 長期執行方式

長期以 Markdown 作為核心內容工作版，DOCX / PDF 作為自動輸出結果。正式文件的發布狀態需由 Document System Index 標示。

---

## 5. 舊文件追溯轉換規則

本文件不主張立即將所有舊 DOCX 文件一次性轉為 Markdown。

### 5.1 不立即全面追溯的原因

不立即全面追溯，並不是因為舊文件不重要，而是基於以下治理風險：

1. 舊文件數量多，全面轉換會產生大量新檔，增加管理負擔。
2. 部分舊文件仍存在摘要化、補丁化或層級定位偏差，若直接轉換，等於把問題複製到 Markdown。
3. DOCX 轉 Markdown 可能造成表格、圖片、標題層級與格式遺失。
4. 目前內容品質規則與 v2.0 Clean Version 流程仍在建立中，若先大量轉檔，後續可能重做。
5. 舊文件應先稽核、補正、整編，再進入雙格式治理。

### 5.2 舊文件追溯原則

舊文件採取分批追溯：

- 先追溯治理核心文件。
- 再追溯主 PRD 與主要模組文件。
- 最後追溯 SOP、Support KB、Release Notes 與 Archive 中仍具參考價值的文件。

### 5.3 優先轉換清單

第一批建議轉 Markdown 的核心文件：

1. Current Folder Structure。
2. New Conversation Handoff。
3. Document System Index。
4. Document Governance and Automation Spec。
5. Automation Strategy and DocOps Roadmap。
6. Document Content Quality Rules。
7. Document Consolidation Plan。
8. Document Audit and Correction Log。
9. Document Format Strategy。

---

## 6. v2.0 Clean Version 的雙格式規則

凡進入 v2.0 Clean Version 的文件，原則上應同時具備：

```text
.md    工作版 / AI 與 GitHub Actions 可讀
.docx  閱讀版 / 顧問式交付版
.pdf   發布版 / 封存版（視需要）
```

### 6.1 v2.0 不等於補丁版

v2.0 Clean Version 必須是重新整編後的正式閱讀版，不得只是補丁堆疊。

v2.0 應做到：

- 保留完整內容，不摘要化刪除。
- 修正主 PRD、MVP、模組與衍生文件的定位。
- 重排章節，使閱讀動線清楚。
- 將補正紀錄移至附錄或稽核文件，不污染正文。
- 移除重複、矛盾與過期表述。
- 讓 Markdown 可被 GitHub / AI / scripts 使用。
- 讓 DOCX 適合正式閱讀。

### 6.2 Markdown 與 DOCX 不一致時的處理

若 `.md` 與 `.docx` 內容不一致，處理順序如下：

1. 查 Document System Index。
2. 查該文件版本紀錄。
3. 查是否有人工審核聲明。
4. 若 Markdown 是工作版但尚未審核，DOCX 可暫作閱讀版。
5. 若 Markdown 是最新審核版，應重新產出 DOCX。
6. 若使用者明確上傳人工修訂 DOCX 並聲明為正式版，則以該 DOCX 作為臨時正式版本，並應回補 Markdown。

---

## 7. Markdown 工作版內容規範

Markdown 文件應具備以下基本結構：

```markdown
# 文件標題

版本：vX.X
日期：YYYY-MM-DD
狀態：Draft / Reviewed / Stable / Deprecated
建議放置位置：...

## 1. 文件目的
## 2. 適用範圍
## 3. 核心規則
## 4. 執行流程
## 5. 不適用情境
## 6. 與其他文件關係
## 7. 版本沿革
```

Markdown 應避免：

- 只有摘要，沒有判斷邏輯。
- 只有補丁段落，沒有重新整編。
- 只有會議記錄語氣，沒有正式治理規則。
- 沒有版本、狀態、放置位置。
- 未標示與主 PRD、模組、SOP、Support KB 的關係。

---

## 8. DOCX 閱讀版內容規範

DOCX 閱讀版應具備：

- 清楚封面或標題頁。
- 文件定位與版本資訊。
- 清楚章節層級。
- 表格不跨頁破裂或標題孤立。
- 必要時加入圖表與架構圖。
- 補正紀錄不污染正文。
- 適合非工程人員閱讀。

DOCX 不應只是一份 Markdown 的機械轉換結果。若是正式交付版，仍應檢查排版與閱讀體驗。

---

## 9. YAML / Manifest 規則

YAML 不負責人類閱讀，而是用來承載機器可讀的模組、任務與狀態。

YAML 適合定義：

- 模組名稱。
- 模組層級。
- 主 PRD 關係。
- Required documents。
- Required prompts。
- Required test logs。
- Next actions。
- Production safety boundaries。
- Human review policy。

YAML 不應承載長篇策略正文。長篇策略正文應放 Markdown / DOCX。

---

## 10. GitHub Actions 自動化路線

目前已完成：

- `docs-package.yml`：打包文件。
- `docs-governance-check.yml`：檢查資料夾治理。
- `docs-manifest-check.yml`：檢查 manifest。

下一階段建議：

### 10.1 Markdown 內容品質檢查

建立：

```text
.github/workflows/docs-content-quality-check.yml
```

檢查：

- 是否缺少版本資訊。
- 是否缺少文件定位。
- 是否出現禁用語或定位錯誤。
- 是否缺少人工作審核狀態。
- 是否未區分正文與補正紀錄。

### 10.2 Markdown 轉 DOCX

建立：

```text
.github/workflows/docs-convert-md-to-docx.yml
```

初期可只針對少數核心 Markdown 文件測試，不應一開始套用全部文件。

### 10.3 Release Package 整合

未來 Docs Package 可將：

- Markdown 工作版。
- DOCX 閱讀版。
- PDF 發布版。
- YAML manifest。
- folder tree。

統一打包。

---

## 11. AI 文件審查與人工核准

AI 可以協助：

- 判斷文件是否摘要化。
- 判斷是否有定位偏差。
- 判斷是否補丁化。
- 建議章節重排。
- 建議 v2.0 Clean Version 架構。
- 產出補正清單。

但 AI 不應自動：

- 覆蓋 Stable 文件。
- 刪除舊版本。
- 宣告文件已正式核准。
- 直接修改 production 相關規則。

正式文件狀態必須經人工確認後，才可從 Draft Generated 進入 Reviewed / Stable。

---

## 12. 執行路線圖

### Phase 1：新文件雙格式化

從本文件後，新治理文件優先同時產出 `.md` 與 `.docx`。

### Phase 2：核心文件 Markdown 化

優先轉換 00_Index 與 01_Architecture_Governance 中的核心文件。

### Phase 3：建立內容品質檢查 workflow

針對 Markdown 文件建立內容品質檢查。

### Phase 4：建立 Markdown 轉 DOCX workflow

先測試少數文件，再擴展到 v2.0 Clean Version。

### Phase 5：v2.0 Clean Version 全面雙格式治理

所有進入 v2.0 的核心文件，應同時具備 `.md`、`.docx`，必要時加 `.pdf`。

---

## 13. 版本沿革

| 版本 | 日期 | 狀態 | 重點 |
|---|---|---|---|
| v0.1 | 2026-06-01 | Draft Generated | 建立 DOCX / Markdown / PDF / YAML 雙軌治理策略，定義新文件雙格式、舊文件分批追溯與 v2.0 Clean Version 規則。 |

---

## 14. 總結

本文件的核心立場是：

> 不放棄 DOCX，也不把 DOCX 當成唯一正本。  
> 不立即全面追溯舊文件，但核心文件必須分批轉換。  
> 新文件從現在開始應逐步採用 Markdown + DOCX 雙格式。  
> 真正的文件即程式，必須建立 Markdown / YAML 工作層，再以 DOCX / PDF 作為正式閱讀與交付層。
