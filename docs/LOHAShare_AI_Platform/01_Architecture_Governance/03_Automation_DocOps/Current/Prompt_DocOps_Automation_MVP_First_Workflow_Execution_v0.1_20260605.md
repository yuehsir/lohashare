# Prompt：DocOps Automation MVP 第一條流程執行 v0.1

```text
請依據目前 LOHAShare AI Platform 文件治理基準，開始建立 DocOps Automation MVP 第一條可執行流程 v0.1。

【目標】
建立以下兩個檔案：
1. `.github/workflows/docs-intake-audit.yml`
2. `scripts/docops/intake_audit.py`

【流程名稱】
LOHAShare AI Platform New Document Intake Audit Workflow v0.1

【安全邊界】
本階段只能做 read-only audit：
- 不得修改 repo 既有文件
- 不得搬移文件
- 不得刪除文件
- 不得覆蓋 Current
- 不得自動升版 Stable
- 不得宣稱已完成歸檔或 commit，除非 GitHub 工具回傳成功

【第一版功能】
請讓 workflow 可以：
1. 手動 workflow_dispatch 執行
2. push 到 `docs/LOHAShare_AI_Platform/**` 或 workflow/script 自身時執行
3. checkout repo
4. 執行 `scripts/docops/intake_audit.py`
5. 產生 artifact：`LOHAShare_AI_Platform_docops_intake_audit`

請讓 Python script 可以：
1. 掃描 `docs/LOHAShare_AI_Platform/`
2. 產生檔案 inventory
3. 初步判斷文件類型：
   - Main PRD
   - Architecture Governance
   - Module Spec / Module Document
   - Support / Incident / Known Issue / Resolved Case
   - Developer Prompt
   - Release Note
   - Archive / Package Export
   - Unknown / Needs Human Review
4. 依分類產生建議放置路徑
5. 檢查是否缺 README 或空白 README
6. 檢查 Current 資料夾中的 DOCX 是否缺 MD
7. 對可能放錯位置的檔案標示 `needs_human_review`
8. 輸出：
   - `new_document_intake_audit.csv`
   - `new_document_intake_audit_report.md`

【輸出要求】
請提供完整可貼入 GitHub 的：
1. `docs-intake-audit.yml` 完整 YAML 程式碼
2. `intake_audit.py` 完整 Python 程式碼
3. 檔案放置路徑
4. commit message 建議
5. 執行與驗收步驟

【重要規則】
請不要只描述流程，請提供完整程式碼。
請不要要求我自己寫程式。
請不要直接進入 v0.2。
請先完成 v0.1 read-only audit。

```
