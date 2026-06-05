# LOHAShare AI Platform 跨工具資源與 DocOps 自動化協同規則 v0.1

日期：2026-06-05  
狀態：Draft for Review  
性質：治理整合與自動化規劃文件

## 一、最高指導原則

GitHub 是 Working Source of Truth；GitHub Actions 是第一階段自動稽核引擎；Replit 是文件處理與 Worker 層；Lovable 是未來 DocOps Console / MVP UI 層；Resend 是通知層；Zoho 是任務、客戶與 CRM 延伸層；NotebookLM 是查詢與知識化層；ChatGPT 是顧問判斷與規則生成層。

## 二、三組對話角色

| 對話 | 定位 | 主要任務 |
|---|---|---|
| 文件治理與 GitHub 自動化總控 | 治理中樞 / GitHub Source of Truth / DocOps 自動化主線 | GitHub 結構、README/MD/DOCX 配對、YAML workflow、Inventory Audit、Intake Audit、正式歸檔判斷 |
| Nexus Lead Ops 產品規格 | 官方治理同步＋啟動前檢查 Prompt 原型場 | 產出可複製到所有模組對話的啟動前檢查標準 Prompt |
| 專案同步進行規劃與文件管理 | PMO / 多專案調度 / 任務分流中心 | 盤點專案、決定先後順序、判斷移交方向 |

## 三、最簡單自動化路線

1. Phase 1：GitHub-only read-only audit：`docs-intake-audit.yml` + `scripts/docops/intake_audit.py`
2. Phase 2：Replit 產生 README / MD / Release Note 補齊包
3. Phase 3：Resend 通知 workflow 完成、失敗或待人工確認
4. Phase 4：建立 branch / PR 草稿，不直推 master
5. Phase 5：Lovable DocOps Console MVP
6. Phase 6：Zoho 任務延伸與 NotebookLM 查詢層

## 四、下一步

建立真正可執行的：

- `.github/workflows/docs-intake-audit.yml`
- `scripts/docops/intake_audit.py`

第一版只做 read-only audit，不修改 repo。
