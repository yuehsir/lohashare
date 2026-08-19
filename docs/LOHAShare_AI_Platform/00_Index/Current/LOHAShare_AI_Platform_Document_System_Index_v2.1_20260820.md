# LOHAShare AI Platform Document System Index v2.1

版本時間：2026-08-20（Asia/Taipei）  
版本號：v2.1  
文件狀態：Draft / Index Upgrade / Not Committed by ChatGPT  
候選路徑：`docs/LOHAShare_AI_Platform/00_Index/Current/`  
基準來源：`LOHAShare_AI_Platform_Document_System_Index_v2.0_20260601.md`  
原始 v2.0 SHA：`2a8f45d2b60f8b86154d069707687904c50845e3`

本文件記錄 Phase 1 重整後的文件索引基準，並將新對話啟動總控文件由 v1.7 更新為 v1.8。

重要限制：

- 本文件目前僅為本地產生之 Markdown 歸檔素材。
- 本文件尚未寫入 GitHub。
- 本文件尚未 commit。
- 本文件尚未建立 PR。
- 本文件尚未移動 v1.7。
- 本文件尚未移動 v2.0。
- 若後續要寫入 GitHub，仍需經使用者確認或由具權限工具實際執行。

---

## 核心入口

- 00_Index/Current/
- 00_Main_PRD/Current/
- 01_Architecture_Governance/<Topic>/Current/
- 05_Developer_Prompts/<Category>/Current/

---

## 新對話啟動入口

目前新對話啟動總控文件為：

```text
00_Index/Current/LOHAShare_AI_Platform_New_Conversation_Handoff_v1.8_Preflight_Action_Guide_20260819.md
```

對應 GitHub Archive JSON metadata 為：

```text
00_Index/Current/LOHAShare_AI_Platform_New_Conversation_Handoff_v1.8_Preflight_Action_Guide_20260819.archive.json
```

本文件取代新對話啟動時對 v1.7 的優先引用。v1.7 可先保留在 Current 作為過渡版本；後續若確認 v2.1 無誤並已寫入 GitHub，可另行 dry-run 規劃移入：

```text
00_Index/99_Archive/
```

新對話應先依 v1.8 進入 Preflight Only Mode，完成四大區塊後，才可依使用者明確指示產生檔案或進行 GitHub / Lovable / Supabase 相關操作。

---

## New Conversation Handoff v1.8 寫入資訊

| 項目 | 內容 |
|---|---|
| Markdown GitHub path | `docs/LOHAShare_AI_Platform/00_Index/Current/LOHAShare_AI_Platform_New_Conversation_Handoff_v1.8_Preflight_Action_Guide_20260819.md` |
| Markdown commit SHA | `b4808ffa57cf6be06dd9c33d58038a3f1dbd0e59` |
| Markdown GitHub 檔案 SHA | `2ef0697f0eeb6656a65147aeeddf78a94d49d30a` |
| Archive JSON GitHub path | `docs/LOHAShare_AI_Platform/00_Index/Current/LOHAShare_AI_Platform_New_Conversation_Handoff_v1.8_Preflight_Action_Guide_20260819.archive.json` |
| Archive JSON commit SHA | `cb1579bb80e156340641765ef16aa897150b9147` |
| Archive JSON GitHub 檔案 SHA | `df8d088c6fee770d67eccf85d1263e69fb56ab2d` |

---

## GitHub Actions

- docs-governance-check.yml v0.5：已通過
- docs-package.yml：已通過
- docs-manifest-check.yml：維持有效

---

## 版本索引更新紀錄

| 日期 | 更新內容 | Commit 狀態 |
|---|---|---|
| 2026-06-09 | 新增 New Conversation Handoff v1.7 作為新對話啟動入口，避免未來新對話仍引用 v1.6。 | ChatGPT GitHub Connector 已寫入 |
| 2026-08-20 | 新增 New Conversation Handoff v1.8 作為新對話啟動入口，補強 DocOps 偏移校正、原文保留升版、Current 不作為工作暫存區、GitHub search 不作為第一判斷來源、dry-run 前置規則。 | 本地檔案已產生 / 尚未寫入 GitHub / 尚未 commit |

---

## v2.1 本版歸檔判斷

是否已從舊版新增補內容：  
是，從 v2.0 最小必要升版，將新對話啟動總控文件由 v1.7 更新為 v1.8，並新增 v1.8 Archive JSON metadata 路徑與寫入資訊。

從哪確認文件版本的來源：  
GitHub Connector 已 read-only fetch `LOHAShare_AI_Platform_Document_System_Index_v2.0_20260601.md`，原始 SHA 為 `2a8f45d2b60f8b86154d069707687904c50845e3`。

GitHub repo tree 驗證狀態：  
本次僅產生本地 Markdown 與 Archive JSON 檔案，尚未寫入 GitHub、尚未 commit、尚未建立 PR。

本版是否建議歸檔：  
可進入 GitHub 同名檔 read-only 檢查。若目標路徑無同名檔，再進入 GitHub 寫入前 dry-run。

---

## 後續處理建議

本文件寫入 GitHub 並確認可讀後，才建議另行 dry-run：

1. v2.0 Archive / superseded 規劃。
2. v1.7 Archive / superseded 規劃。
3. Current 目錄中舊版 Index / Handoff 的整理。
4. DocOps Current 過度文件化整理。
