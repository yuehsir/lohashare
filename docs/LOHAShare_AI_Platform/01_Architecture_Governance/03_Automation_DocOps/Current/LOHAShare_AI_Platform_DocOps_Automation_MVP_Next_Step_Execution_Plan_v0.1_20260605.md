# LOHAShare AI Platform DocOps Automation MVP 下一步執行計畫 v0.1

日期：2026-06-05  
狀態：Draft for Review

## 目標

建立第一條真正可執行的 DocOps 自動化流程：

- `.github/workflows/docs-intake-audit.yml`
- `scripts/docops/intake_audit.py`

## 安全邊界

第一版只做 read-only audit：

- 不修改 repo
- 不搬移文件
- 不刪除文件
- 不覆蓋 Current
- 不自動升版 Stable

## v0.1 產出

- `new_document_intake_audit.csv`
- `new_document_intake_audit_report.md`
- GitHub Actions artifact：`LOHAShare_AI_Platform_docops_intake_audit`

## 建議執行順序

1. 建立 `scripts/docops/intake_audit.py`
2. 建立 `.github/workflows/docs-intake-audit.yml`
3. commit / push
4. 手動執行 workflow
5. 下載 artifact
6. 分析分類與路徑建議是否合理
