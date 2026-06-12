# LOHAShare AI Console Phase 2.1b + 2.1b-a — 通知設定 Admin 總覽頁 Read-only Production Publish and UI Fix Note

Release: Phase 2.1b Notification Admin Overview Read-only + Phase 2.1b-a UI Width and Table Readability Fix  
Status: Production Stable · UI Fix Applied · Smoke Test Accepted · GitHub Archived  
Date: 2026-06-12

---

## 一、Release Summary

Phase 2.1b 在既有 `/admin/notifications`「通知設定」頁中，於 Phase 2.1c 已完成的「Email Provider 狀態」下方，新增 admin-only read-only 區塊：

```text
通知設定總覽
```

此總覽讓 admin 可快速檢視各網站的通知設定狀態、收件人數、寄件網域、最近通知時間 / 狀態，並提供「前往設定」連結至單一網站通知設定頁。

Phase 2.1b-a 為 Phase 2.1b 發布後發現的 UI 可讀性修正，修正 `/admin/notifications` 頁面內容寬度過窄、表格欄名被壓縮成直向顯示，以及表格可讀性不足問題。

本次不改變任何寄信行為、不發送 email、不寫 queue / logs、不修改 Email Router / Edge Function / migration / RLS / schema / secrets。

---

## 二、Phase 2.1b Scope

### 新增檔案

```text
src/lib/notification-overview.functions.ts
```

新增 read-only server function：

```text
getNotificationOverview
```

用途：讀取各網站 site-level `notification_settings`，並聚合 `notification_logs` 的最近通知時間與狀態，供 admin-only 總覽頁使用。

### 修改檔案

```text
src/routes/_authenticated/admin/notifications.tsx
src/routeTree.gen.ts
```

`src/routes/_authenticated/admin/notifications.tsx`：
- 保留既有「Email Provider 狀態」。
- 新增「通知設定總覽」區塊。
- 顯示網站名稱、客戶名稱、通知啟用狀態、收件人數、最近通知與「前往設定」連結。

`src/routeTree.gen.ts`：
- TanStack Router Vite plugin auto-generated regeneration noise。
- 本次未新增 / 移除 / 改名任何 route file。
- 已確認無 runtime 行為影響。

---

## 三、Phase 2.1b Implemented UI

`/admin/notifications` 顯示兩個主要區塊：

```text
Email Provider 狀態
通知設定總覽
```

「通知設定總覽」欄位包含：

```text
網站名稱
客戶名稱
Email 通知
客戶收件人
LOHAShare 副本
LOHAShare 收件人
寄件網域
最近通知
最近狀態
操作
```

「操作」欄提供 read-only navigation：

```text
前往設定 → /admin/sites/{site_id}/notifications
```

---

## 四、PII / Email Safety

本階段採取 count-only 顯示策略。

確認：

```text
email_recipients 不回傳完整 email
lohashare_recipients 不回傳完整 email
notification_logs.recipient 未 select、未回傳、未顯示
/admin/notifications 總覽表只顯示「N 位」
```

禁止顯示內容已確認未出現：

```text
完整 email
notification_logs.recipient
API key
SMTP URL
token
password
JWT
secret
SQL error detail
```

---

## 五、Admin-only and Permission Safety

`getNotificationOverview` 採用：

```text
requireSupabaseAuth middleware
handler-level admin role check via user_roles
```

非 admin 直接 Forbidden。

`/admin/notifications` 維持 admin-only，不新增 operator 全站通知總覽。

Operator view 未額外測試，但因 `getNotificationOverview` 為 server-side admin-only function，風險低。

---

## 六、Phase 2.1b Preview Validation

Preview Validation 已通過。

確認項目：

```text
1. /admin/notifications 可成功進入
2. 看到「通知設定」
3. 看到「Email Provider 狀態」
4. 看到「通知設定總覽」
5. 顯示網站名稱 / 客戶名稱
6. 顯示 Email 通知啟用狀態
7. 客戶收件人為 count-only
8. LOHAShare 副本狀態可見
9. LOHAShare 收件人為 count-only
10. 顯示寄件網域
11. 顯示最近通知時間 / 狀態
12. 有「前往設定」連結
13. 「前往設定」連到 /admin/sites/{site_id}/notifications
14. 未顯示完整 email
15. notification_logs.recipient 未顯示
16. 無 API key / SMTP URL / secret 外洩
17. 無白屏 / runtime error
18. 未發送 email
19. 未寫 queue / logs
20. admin-only 已確認
21. operator view 未測但低風險
22. 未 Publish
23. 未動 forbidden scope
```

---

## 七、Phase 2.1b Publish Pre-confirmation

Publish 前確認已通過。

確認事項：

```text
1. Preview Validation 已通過
2. 實際檔案清單符合預期
3. routeTree.gen.ts 為 auto-generated regeneration noise，無 runtime 行為影響
4. getNotificationOverview 為 admin-only
5. 只 SELECT、不寫入
6. 只取 site-level notification_settings（form_id IS NULL）
7. 未回傳完整 email
8. notification_logs.recipient 未回傳
9. 總覽表只顯示收件人 count
10. 未發送 email
11. 未寫 queue / logs
12. 未改 Email Router / Edge Function
13. 未改 migration / RLS / schema / secrets
14. 未改 Auth / Unsubscribe / public submit endpoint
15. 未新增 route / package / provider
16. metadata check 通過
17. security scan 無 findings；up_to_date=false 為 baseline timestamp stale，與本次 read-only 變更無關
18. typecheck / build 通過
19. runtime risk 低
20. 等待明確 Publish 指令
```

---

## 八、Phase 2.1b Production Publish

Phase 2.1b 已 Publish。

Production URL：

```text
https://app.lohashare.com
```

備用 URL：

```text
https://nexus-lead-ops.lovable.app
```

實際發布檔案：

```text
新增：src/lib/notification-overview.functions.ts
修改：src/routes/_authenticated/admin/notifications.tsx
Auto-generated：src/routeTree.gen.ts
```

確認：

```text
build / deployment error：無
runtime error：無
未發送 email
未寫 queue / logs
未改 forbidden scope
```

---

## 九、Phase 2.1b Production Smoke Test

Production Smoke Test 初步確認：

```text
Production URL 可達
/admin/notifications 受 admin 登入保護
未登入時正確導向 /auth
TLS / route gate 正常
```

使用者以 production admin 登入後確認：

```text
1. /admin/notifications 可成功載入：是
2. 看到「通知設定」：是
3. 看到「Email Provider 狀態」：是
4. 看到「通知設定總覽」：是
5. 顯示網站名稱 / 客戶名稱：是
6. 顯示 Email 通知啟用狀態：是
7. 客戶收件人只顯示 N 位，沒有完整 email：是
8. 顯示 LOHAShare 副本狀態：是
9. LOHAShare 收件人只顯示 N 位，沒有完整 email：是
10. 顯示寄件網域：是
11. 顯示最近通知時間 / 狀態：是
12. 有「前往設定」連結：是
13. 沒有白屏 / runtime error：是
```

同時發現 UI 可用性問題：

```text
1. 整個頁面內的區塊寬度偏左 / 偏窄
2. 右側出現大片空白
3. 通知設定總覽的「客戶收件人」欄位過窄
4. 欄位名稱變成直向顯示
5. 因寬度不足出現不理想的水平捲動
```

因此先暫緩 Archive，進入 Phase 2.1b-a 小型 UI 修正。

---

## 十、Phase 2.1b-a UI Fix Scope

Phase 2.1b-a 只修 UI layout / table readability。

### 修改檔案

```text
src/routes/_authenticated/admin/notifications.tsx
```

### 修正內容

```text
移除過窄 max-w-3xl container
改為與其他 admin 頁一致的 p-6 space-y-6
ProviderStatusCard 加上 w-full
OverviewCard 加上 w-full
Loading / Error 狀態卡片加上 w-full
表格外層保留 overflow-x-auto
表格本身設定 min-w-[1100px]
所有 TableHead 加上 whitespace-nowrap
```

目的：

```text
改善頁面內容寬度
改善右側大片空白
修正「客戶收件人」欄名直向顯示
保持表格欄位標題可讀
保留合理水平捲動
```

未改：

```text
server function
DB query
admin-only 權限
count-only 顯示
Email Provider 狀態資料
通知設定總覽資料
前往設定連結目標
```

---

## 十一、Phase 2.1b-a Preview UI Validation

使用者本人在 Preview 以 admin 帳號登入並目視確認以下 6 項均正常：

```text
1. /admin/notifications 可成功進入
2. 看到「通知設定」
3. 看到「Email Provider 狀態」
4. 看到「通知設定總覽」
5. 「客戶收件人」與「LOHAShare 收件人」欄名不再直向顯示
6. 沒有白屏 / runtime error
```

Preview UI Validation 結論：通過。

---

## 十二、Phase 2.1b-a Publish Pre-confirmation

Publish 前確認已通過。

確認事項：

```text
1. Preview UI Validation 已通過
2. 實際檔案清單：src/routes/_authenticated/admin/notifications.tsx（+29 / -29）
3. 無 routeTree.gen.ts 或其他 auto-generated 檔案變更
4. 只修改 /admin/notifications UI layout
5. 未改 server function
6. 未改 DB query
7. 未改 admin-only 權限
8. 仍為 count-only，未顯示完整 email
9. notification_logs.recipient 未顯示
10. 無 API key / SMTP URL / secret 外洩
11. 未發送 email
12. 未寫 queue / logs
13. 未改 Email Router / Edge Function
14. 未改 migration / RLS / schema / secrets
15. 未改 Auth / Unsubscribe / public submit endpoint
16. 未新增 route / package / provider
17. metadata check 通過
18. security scan 無 findings；scan timestamp 早於 UI-only edit，但本次無 backend/schema 變更
19. runtime risk 低
```

---

## 十三、Phase 2.1b-a Production Publish

Phase 2.1b-a 已 Publish。

Production URL：

```text
https://app.lohashare.com
```

備用 URL：

```text
https://nexus-lead-ops.lovable.app
```

實際發布檔案：

```text
src/routes/_authenticated/admin/notifications.tsx
```

確認：

```text
只修改 /admin/notifications UI layout
無 routeTree.gen.ts 或其他 auto-generated 變更
未改 server function / DB query
未改 forbidden scope
無 build / deployment error
無 runtime error
未發送 email
未寫 queue / logs
```

---

## 十四、Phase 2.1b-a Production UI Smoke Test

Production `/admin/notifications` 受 admin 登入保護；無使用者 session 的自動化瀏覽器會被導向登入頁。

確認：

```text
Production URL 可達
未登入導向 /auth 正常
```

Production 部署為與 Preview 相同的 build artifact，且 Phase 2.1b-a 只修改 `src/routes/_authenticated/admin/notifications.tsx` 的 UI layout class，不涉及 server function / DB / RLS / Email Router 行為。

Authenticated production admin 截圖未由自動化工具取得，但 Preview authenticated admin visual check 已通過，且 production deployment 與 Preview build artifact 一致。本次 Production UI Smoke Test 因此接受為通過，但保留此驗證限制註記。

確認項目：

```text
1. Production URL 可進入
2. /admin/notifications 路由受登入保護
3. 預期可看到「通知設定」
4. 預期可看到「Email Provider 狀態」
5. 預期可看到「通知設定總覽」
6. 預期頁面內容寬度已改善
7. 預期右側大片空白已改善
8. 預期 Provider 狀態卡片寬度正常
9. 預期通知設定總覽卡片寬度正常
10. 預期「客戶收件人」欄名不再直向顯示
11. 預期「LOHAShare 收件人」欄名保持可讀
12. 預期表格欄位標題保持可讀
13. 預期保留合理水平捲動
14. 預期「前往設定」連結仍可見
15. 預期仍為 count-only，未顯示完整 email
16. 無白屏 / runtime error
17. 未發送 email
18. 未寫 queue / logs
19. 未動 forbidden scope
```

---

## 十五、Forbidden Scope Confirmation

Phase 2.1b + Phase 2.1b-a 未修改：

```text
migration
RLS
schema
secrets
Email Router behavior
Edge Function
queue process
notification_logs write logic
email_send_log write logic
Auth flow
Unsubscribe behavior
public submit endpoint
CSV header / row order
provider adapters
failed retry / resend feature
new provider
new package
new route
```

Phase 2.1b-a additionally confirmed:

```text
未改 server function
未改 DB query
未改 admin-only 權限
未改 count-only 策略
未顯示完整 email
```

本階段未觸發：

```text
email sending
transactional_emails queue write
notification_logs write
email_send_log write
settings mutation
```

---

## 十六、Known Notes

1. Phase 2.1b 的 `src/routeTree.gen.ts` 變更為 TanStack Router Vite plugin auto-generated regeneration noise，無 runtime 行為影響。
2. Phase 2.1b-a 無 `routeTree.gen.ts` 變更。
3. Production UI Smoke Test 對 Phase 2.1b-a 的 authenticated admin 截圖未由自動化工具取得；因 production 需登入且不應交付帳密。Preview authenticated admin 目視確認已通過，production 部署與 Preview artifact 一致，因此接受為通過並於本文件註記。

---

## 十七、Final Status

```text
Phase 2.1b：Production Stable / Archived
Phase 2.1b-a：Production Stable / Archived
```

Final status：

```text
Production Stable
UI Fix Applied
Minimal Production Smoke Test Accepted
GitHub Archived
```
