# LOHAShare AI Platform Document System Index v2.0

本文件記錄 Phase 1 重整後的文件索引基準。

## 核心入口

- 00_Index/Current/
- 00_Main_PRD/Current/
- 01_Architecture_Governance/<Topic>/Current/
- 05_Developer_Prompts/<Category>/Current/

## 新對話啟動入口

目前新對話啟動總控文件為：

```text
00_Index/Current/LOHAShare_AI_Platform_New_Conversation_Handoff_v1.7_Preflight_Action_Guide_20260609.md
```

本文件取代新對話啟動時對 v1.6 的優先引用。v1.6 可保留作為歷史版本，後續若確認 v1.7 無誤，可移入：

```text
00_Index/99_Archive/
```

新對話應先依 v1.7 進入 Preflight Only Mode，完成四大區塊後，才可依使用者明確指示產生檔案或進行 GitHub / Lovable / Supabase 相關操作。

## GitHub Actions

- docs-governance-check.yml v0.5：已通過
- docs-package.yml：已通過
- docs-manifest-check.yml：維持有效

## 版本索引更新紀錄

| 日期 | 更新內容 | Commit 狀態 |
|---|---|---|
| 2026-06-09 | 新增 New Conversation Handoff v1.7 作為新對話啟動入口，避免未來新對話仍引用 v1.6。 | ChatGPT GitHub Connector 已寫入 |
