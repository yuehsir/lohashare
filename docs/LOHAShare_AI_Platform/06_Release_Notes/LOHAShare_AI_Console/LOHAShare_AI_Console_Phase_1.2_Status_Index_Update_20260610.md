# LOHAShare AI Console Phase 1.2 Status Index Update

版本日期：2026-06-10（Asia/Taipei）  
文件狀態：Status Index Update / Draft for GitHub Archive  
對應產品化名稱：LOHAShare AI Console / Nexus Lead Ops  
正式治理模組名稱：Lead Console  
對應階段：Phase 1.2 — Social / LINE OA Lead Tracking MVP  
目前狀態：Production Stable  

---

## 1. 文件目的

本文件作為 Phase 1.2 的狀態索引更新，用於快速回顧 Phase 1.2 從 Developer Prompt、Build、Preview Validation、Production Publish 到 Smoke Test 的完整收尾狀態。

本文件不是新的開發提示詞。  
本文件不是新的 migration 指令。  
本文件不是新的 production publish 指令。  
本文件不是 Phase 1.2.1 或 Phase 1.3 的啟動文件。  

本文件用途：

1. 標記 Phase 1.2 已完成並進入 production stable。
2. 彙整 Phase 1.2 相關 GitHub commit。
3. 彙整已完成驗證紀錄。
4. 明確列出後續可選 Gate。
5. 防止未來誤以為 Phase 1.2 尚未完成或仍在 Preview 階段。

---

## 2. Phase 1.2 範圍摘要

Phase 1.2 主題：

```text
Social / LINE OA Lead Tracking MVP
```

本階段目的：

```text
讓 LOHAShare AI Console 的表單名單可以記錄 social / LINE OA / UTM 來源資料，
並讓後台可以檢視、匯出與驗證來源追蹤結果。
```

本階段完成的主要項目：

1. `public.leads` 新增 12 個 source / UTM 欄位。
2. 新增 5 個 source / UTM index。
3. 更新 operator update restriction trigger。
4. 表單 submit route 支援 source payload。
5. embed form 支援 query string / hidden field source collection。
6. LeadDetailDrawer 新增「來源 Source」區塊。
7. CSV export 依 IN-001 將 12 欄 append 到尾端。
8. Preview validation 通過。
9. Production publish 完成。
10. Production smoke test 通過。
11. Notification / Email smoke test 通過。
12. Notification recipient source check 通過。

---

## 3. Current Status

```text
Phase 1.2 Migration: Completed
Phase 1.2 Code Build: Completed
TypeScript Check: Passed
Preview Validation: Passed
Production Publish: Completed
Production Smoke Test: Passed
Notification Smoke Test: Passed
Notification Recipient Source Check: Passed
Temporary Preview allowed domain: Removed
Production Stable: Yes
Email Router / Unsubscribe / RLS / secrets / router flags: Not modified
```

總結：

```text
Phase 1.2 is production stable.
```

---

## 4. Key GitHub Commits

### 4.1 Developer Prompt v0.3

```text
Commit SHA:
db7c232e50b1bde225dade2c2b7de6f0c0ed9310
```

對應文件：

```text
docs/LOHAShare_AI_Platform/05_Developer_Prompts/LOHAShare_AI_Console/Current/LOHAShare_AI_Console_v2.0_Lovable_Developer_Prompt_Candidate_v0.3_20260610.md
```

用途：

```text
Phase 1.2 Lovable Developer Prompt 單一可信來源。
```

### 4.2 IN-001 補登

```text
Commit SHA:
b8567b329b34c8a67401643807ee770b35ce3900
```

用途：

```text
補登 CSV source / UTM 欄位 append 到尾端的 Implementation Note。
```

IN-001 決策：

```text
12 個 source / UTM 欄位 append 到既有 CSV headers 尾端，
避免破壞既有 BI / Excel / Google Sheet 欄位索引。
```

### 4.3 Build Completion & Preview Validation Note

```text
Commit SHA:
1d910ca774b57948dc3e85cbbfbc3728e0876097
```

對應文件：

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/LOHAShare_AI_Console_Phase_1.2_Build_Completion_and_Preview_Validation_Note_20260610.md
```

用途：

```text
記錄 Phase 1.2 Build completed、Preview validation passed、Preview allowed domain 已移除。
```

### 4.4 Production Publish & Smoke Test Note — Redacted Version

```text
Commit SHA:
6b366955b75a45383d73bcc1be5d061a645625c8
```

對應文件：

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/LOHAShare_AI_Console_Phase_1.2_Production_Publish_and_Smoke_Test_Note_20260610_redacted.md
```

用途：

```text
記錄 Phase 1.2 Production Publish completed、Production smoke test passed、Notification smoke test passed。
```

備註：

```text
GitHub 歸檔版為 redacted version，已移除個人 email 與敏感收件人資訊。
```

---

## 5. Validation Summary

### 5.1 Preview Validation

Preview validation 結果：

```text
Valid source / UTM: PASS
Invalid whitelist: PASS
No source: PASS
Temporary Preview allowed domain removed: PASS
```

### 5.2 Production Smoke Test

Production smoke test 結果：

```text
Valid source / UTM: PASS
Invalid whitelist: PASS
No source: PASS
```

### 5.3 Notification / Email Smoke Test

Notification / Email smoke test 結果：

```text
Notification logs: PASS
Email send logs: PASS
Activity logs: PASS
No related DLQ / error for this batch: PASS
```

### 5.4 Notification Recipient Source Check

Recipient source check 結果：

```text
Source: public.notification_settings site-level row
Form-level override: No
Environment variable: No
Hardcoded fallback: No
Cross-site leakage: No
Expected behavior: PASS
```

---

## 6. Non-Goals Safety Confirmation

本階段完成後，以下項目未被修改：

```text
Email Router
Unsubscribe route
UNSUBSCRIBE_BASE_URL
Zoho SMTP
RLS policies
secrets
router flags
app.lohashare.com routing
social platform APIs
social_lead_candidates table
Lead List platform filter
Admin Source Report
Form Editor
monthly_usage
usage_logs
Edge Functions
```

此確認很重要，因為 Phase 1.2 僅完成來源追蹤 MVP，不應與 Email Router / Unsubscribe / Social Candidate Pipeline 混在同一 Gate。

---

## 7. Known Pre-existing Warnings

以下為既有警告，非 Phase 1.2 新增，不阻擋 production stable：

```text
hydration mismatch data-google-analytics-opt-out
DialogContent missing Description
search_path / SECURITY DEFINER warning on unrelated functions
historical failed / DLQ rows from earlier batch
```

---

## 8. Recommended Closure Status

建議正式標記：

```text
Phase 1.2 — Social / LINE OA Lead Tracking MVP
Status: Production Stable
Closed as: Completed
Next action: Open a new Gate before additional development
```

不建議在 Phase 1.2 gate 內繼續追加功能。

---

## 9. Next Gate Candidates

### 9.1 Phase 1.2.1 — Lead Source Visibility & Reporting

建議優先度：高  
風險：低至中  
最自然延伸：是  

可能範圍：

```text
Lead List source_platform filter
Lead List source_type filter
Admin Source Report
CSV / reporting improvements
Source / UTM dashboard cards
```

適合目的：

```text
讓管理者更容易從後台看出名單來自 LINE、社群、活動、推薦或其他來源。
```

### 9.2 Option B — Unsubscribe Preview

建議優先度：中  
風險：中  
是否應立即接續：不建議與 Phase 1.2 同回合混做  

可能範圍：

```text
Unsubscribe preview
通知 email 取消訂閱連結
UNSUBSCRIBE_BASE_URL planning
Email compliance workflow
```

注意：

```text
此工作屬 Email / Notification 主線，需獨立 Gate。
不得在未確認前啟用 production unsubscribe。
```

### 9.3 Phase 1.3 — Social Lead Candidate Pipeline

建議優先度：中  
風險：中至高  
是否應立即接續：建議先規劃，不立刻 Build  

可能範圍：

```text
social_lead_candidates
社群留言 / 私訊名單候選
人工審核後轉 lead
LINE / FB / IG / YouTube 等來源延伸
```

注意：

```text
此階段範圍較大，應先產 PRD / Developer Prompt Candidate，不建議直接進 Lovable Build。
```

### 9.4 Documentation / Governance Update

建議優先度：高  
風險：低  

可能範圍：

```text
Update module status index
Update release note index
Add Decision Record for Phase 1.2 production stable
Prepare next conversation handoff
```

---

## 10. Recommended Immediate Next Step

建議下一步：

```text
先將本 Phase 1.2 Status Index Update 寫入 GitHub 歸檔。
```

建議 GitHub 路徑：

```text
docs/LOHAShare_AI_Platform/06_Release_Notes/LOHAShare_AI_Console/LOHAShare_AI_Console_Phase_1.2_Status_Index_Update_20260610.md
```

建議 commit message：

```text
docs: add Phase 1.2 status index update
```

完成後，再決定是否開啟：

```text
Phase 1.2.1 Planning Gate
```

---

## 11. Recommended Next Conversation Title

若要另開新對話，建議標題：

```text
LOHAShare AI Console Phase 1.2.1 — Lead Source Visibility & Reporting
```

用途：

```text
專注規劃 Lead List source filter、Admin Source Report、CSV/reporting improvements。
```

---

## 12. Final Closure Statement

Phase 1.2 已完成：

```text
Build → Preview Validation → Production Publish → Production Smoke Test → Notification Check → GitHub Release Note Archive
```

本階段建議正式收尾，不再直接追加功能。

下一個實作應另開 Gate，以避免 Phase 1.2 stable 狀態被後續變更混淆。
