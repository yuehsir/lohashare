# Phase 2.4-b Production Safe Test Only Preflight Checklist

文件日期：2026-08-20  
文件類型：Preflight Checklist / Production Safe Test Gate / Release Governance Note  
適用範圍：LOHAShare AI Platform、LOHAShare AI Console、Email Notification、Email Provider Router、Phase 2.4-b  
文件狀態：Archived / Founder Review Required / Not Authorized for Execution  
來源狀態：Founder-provided phase status and checklist summary  
GitHub 狀態：已寫入 GitHub、已 commit、未建立 PR  
Phase 授權狀態：Phase 2.4-b 尚未授權  
Email send 授權狀態：未授權  
Router flag 授權狀態：未授權 flip EMAIL_PROVIDER_ROUTER_ENABLED  
Publish 授權狀態：未授權  
Lovable Build Prompt 狀態：未產生 / 未授權  

---

## 1. 文件目的

本文件用於判斷是否具備進入：

`Phase 2.4-b — Production Safe Test Only`

的最低前置條件。

本文件只做 preflight planning，不執行任何實際測試，不授權寄信，不授權 flip Router flag，不授權 Publish，不授權 Phase 2.4-b 執行，也不產生 Lovable Build Prompt。

---

## 2. Phase 定位

```text
LOHAShare AI Lead & Notification Console MVP
└─ Email Notification / Email Provider Router
   └─ Phase 2.4 Production Router Rollout
      └─ Phase 2.4-b Production Safe Test Only
```

---

## 3. 前一階段狀態

Phase 2.4-a-2-B1 Minimal UI Safety Lock 已完成，狀態為：

```text
Completed / UI Verified by Lovable Report / Founder Visual Spot Check Passed / Completion Note Archived
```

已知前置背景：

1. Phase 2.4-a-2-B1 已由 Lovable 回報完成。
2. Lovable UI Verification 已完成。
3. Founder Visual Spot Check 已通過。
4. Phase 2.4-a-2-B1 Completion Note 已完成 GitHub 歸檔與 metadata correction。
5. 目前尚未授權 Phase 2.4-b。
6. 尚未寄信。
7. 尚未 flip Router flag。
8. 尚未 Publish。
9. 尚未回 Lovable Build。

---

## 4. Governance 條件

Phase 2.4-b 前置必要 Governance 條件：

1. Founder 必須明確授權進入 Phase 2.4-b。
2. 本階段只允許 Production Safe Test Only。
3. 禁止 customer rollout。
4. 禁止非白名單收件人。
5. 禁止修改 DB schema / migration。
6. 禁止修改 secrets。
7. 禁止新增 Email Provider。
8. 禁止改 Zoho fallback。
9. 禁止進入 Phase 2.4-c。
10. 禁止同時進行 Embed Code Studio / Duda 實地驗收。

---

## 5. GitHub / 文件條件

Phase 2.4-b 前置必要 GitHub / 文件條件：

1. Phase 2.4-a-2-B1 Completion Note 已歸檔。
2. archive JSON 已歸檔。
3. metadata correction 已完成。
4. 不需要新增 ROD。
5. 不需要更新主 PRD 才能進入 Phase 2.4-b。
6. 若需要更新 Phase Control Board 或 Document System Index，應另走 dry-run，不得混入本測試。

---

## 6. Lovable UI 條件

Phase 2.4-b 前置必要 Lovable UI 條件：

1. 路徑為「網站管理 > 網站詳情 > 網站通知設定」。
2. Email Provider 狀態（唯讀）卡片可見。
3. Router 狀態可見。
4. Fallback 狀態可見。
5. Preflight 區塊顯示 audit-only / 不寄信說明。
6. Safe Test Enqueue warning card 可見。
7. Safe Test Enqueue button 為 destructive 樣式。
8. ConfirmDialog 需要輸入 `PRODUCTION SAFE TEST`。
9. 非 admin gate 仍存在。
10. `data-testid` 仍存在。

---

## 7. Router / Email Provider 條件

Phase 2.4-b 前置必要 Router / Email Provider 條件：

1. `EMAIL_PROVIDER_ROUTER_ENABLED` 目前應為 `false`。
2. `EMAIL_FALLBACK_ENABLED` 目前應為 `false`。
3. Primary provider 預期為 Resend。
4. Sender 預期為 `notify@send.lohashare.com`。
5. Sender domain 顯示 `PENDING` 的原因需在 Phase 2.4-b 前釐清。
6. 若 Sender domain 正確值應為 `send.lohashare.com`，需在 Phase 2.4-b 前確認。
7. 不得使用 `notify.lohashare.com` 作為 Resend sender。
8. 不得使用 `send.send.lohashare.com` 作為一般寄件網域判斷。
9. Zoho SMTP fallback 不得在本階段啟用。

---

## 8. Recipient / White-list 條件

Phase 2.4-b 前置必要 Recipient / White-list 條件：

1. safe test 只允許寄送到 `lohashare_recipients`。
2. Approved recipient count 已確認。
3. 目前畫面顯示 Approved recipient count = 1。
4. 實際測試收件人必須是 Founder 可確認的 LOHAShare 內部信箱。
5. 不得寄送到客戶、陌生名單、production leads 或非白名單 email。
6. 測試收件人由 Founder 明確確認。

---

## 9. Database Baseline 條件

Phase 2.4-b 前置必要 Database Baseline 條件：

1. `email_send_log` 目前 safe-test 相關筆數需可確認。
2. `notification_logs` 目前 safe-test 相關狀態需可確認。
3. `monthly_usage` 目前 email sent count 需可確認。
4. `lohashare_recipients` 目前 approved recipient count 需可確認。
5. 最近一次成功 Preview safe test 的 `testRunId` 需可追溯。
6. canonical `testRunId` 應使用：

```text
c3596815-d602-498d-927e-a03376ca577b
```

7. 不得使用錯誤的 `c3596015...` 版本。
8. baseline 查詢必須 read-only。

---

## 10. Rollback 條件

Phase 2.4-b 前置必要 Rollback 條件：

1. 若 Router flag 開啟，必須有明確 rollback 步驟。
2. rollback 後必須確認 `EMAIL_PROVIDER_ROUTER_ENABLED=false`。
3. rollback 後必須確認 `EMAIL_FALLBACK_ENABLED=false`。
4. rollback 後必須確認沒有額外非預期 `email_send_log`。
5. rollback 後必須確認沒有非預期 `notification_logs`。
6. rollback 後必須回報 Founder。
7. 若 rollback 無法確認，禁止執行 Phase 2.4-b。

---

## 11. Phase 2.4-b 未來明確授權後可允許事項

僅限未來 Founder 明確授權後，Phase 2.4-b 可允許：

1. read-only preflight。
2. 確認 Router / Fallback / Sender / Sender domain / Recipient 狀態。
3. 在明確授權後，執行一次 Production Safe Test。
4. Safe Test 僅寄送到 `lohashare_recipients`。
5. 測試後立即 rollback。
6. 測試後 read-only 驗證 DB log。
7. Founder 確認信箱是否收到測試信。
8. 記錄結果。

---

## 12. Phase 2.4-b 禁止事項

Phase 2.4-b 禁止：

1. Customer rollout。
2. 對客戶站台啟用正式通知。
3. 對非白名單寄信。
4. 啟用 Zoho fallback。
5. 修改 secrets。
6. 修改 DNS。
7. 修改 DB schema。
8. 新增 migration。
9. 修改 RLS。
10. 修改 Email Router server logic。
11. 修改 Resend integration。
12. 修改 Zoho SMTP integration。
13. 修改 queue / process function。
14. 進入 Phase 2.4-c。
15. 同時做 Embed Code Studio。
16. 同時做 Duda / Oasis 測試頁。
17. 同時做 `/admin/usage`。
18. 同時做 FAQ / AEO。
19. Publish 未經確認的其他變更。

---

## 13. Stop Conditions

出現以下任一情況，應停止，不得執行 Phase 2.4-b：

1. Sender domain 仍顯示 `PENDING` 且無法判斷原因。
2. Router 狀態與預期不一致。
3. Fallback 狀態與預期不一致。
4. Approved recipient count 不是預期值。
5. `lohashare_recipients` 不是唯一收件來源。
6. safe test recipient 無法由 Founder 確認。
7. UI 安全鎖消失。
8. ConfirmDialog 不要求 `PRODUCTION SAFE TEST`。
9. Preflight 與 Enqueue 無法清楚分辨。
10. baseline 查詢結果不一致。
11. 出現不明 `email_send_log`。
12. 出現不明 `notification_logs`。
13. Router flag 無法 rollback。
14. Lovable 嘗試擴大修改範圍。
15. Lovable 嘗試進 Phase 2.4-c。
16. Lovable 嘗試同時做 Embed Code Studio 或 Duda 整合。
17. Founder 未明確授權寄信。

---

## 14. 建議狀態

```text
Phase 2.4-b — Production Safe Test Only
Status: Preflight Checklist Archived / Not Authorized / No Execution
```

---

## 15. 明確下一步

本文件歸檔後，下一步仍不是執行 Phase 2.4-b。

建議下一步是由 Founder 審查本 Preflight Checklist，並另行決定是否授權產生 Lovable Build Prompt 或進行 Phase 2.4-b execution preflight。

未取得 Founder 明確授權前，不得寄信、不得 flip Router flag、不得 Publish、不得回 Lovable Build。
