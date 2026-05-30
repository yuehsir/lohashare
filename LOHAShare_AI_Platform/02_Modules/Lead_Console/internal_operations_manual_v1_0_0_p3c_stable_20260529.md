# 內部操作手冊

> 文件編號：LOHAShare-LNC-OPS-MANUAL-v1.0.0-P3c-Stable-20260529  
> 版本識別：v1.0.0-P3c-Stable-20260529  
> 基準版本：Phase 3c Stable — Lead & Notification Console MVP  
> 文件日期：2026-05-29  
> 用途：儲存、更新、交接與下一階段規劃

---


## 一、系統入口

目前系統 Published URL：`https://nexus-lead-ops.lovable.app`

後台入口：`/admin`

公開表單入口範例：`/embed/forms/contact`

注意：正式商用前，未來建議改綁定 `app.lohashare.com`。

## 二、角色與權限

### Admin

Admin 可操作全部功能：客戶管理、網站管理、授權網域、表單管理、Lead 管理、Lead Notes、Lead Status、CSV 匯出、Notification Settings、Plans / Subscriptions、Operator 授權、Activity Logs。

### Operator

Operator 僅能操作被授權 site。可查看 Leads、修改 Lead Status、新增 Lead Notes、匯出 CSV；不可修改 Forms、Notification Settings、Plans / Subscriptions，不可查看 email_recipients / lohashare_recipients 明細，不可刪除 Leads。

## 三、建立客戶與網站

### 建立 Customer

1. 前往 `/admin/customers`。
2. 點擊新增客戶。
3. 輸入客戶名稱、聯絡人、Email、電話。
4. 設定狀態為 active。
5. 儲存。

### 建立 Site

1. 前往 `/admin/sites`。
2. 點擊新增網站。
3. 選擇所屬 customer。
4. 輸入網站名稱與 primary_domain。
5. 選擇平台：oasis、duda、wordpress、lovable、replit 或 other。
6. 設定 status = active。
7. 儲存。

## 四、設定 allowed_domains

allowed_domains 用來限制哪些網站可以送出該 site 的表單，避免 iframe 表單被未授權網站濫用。

操作：

1. 進入 `/admin/sites/{site_id}`。
2. 找到 Allowed Domains 區塊。
3. 新增授權網域。

範例：

- 表單放在 `https://www.lohashare.com/contact`，請新增 `www.lohashare.com`。
- 若測試表單直接在 Lovable Published URL，請新增 `nexus-lead-ops.lovable.app`。

注意：不需輸入 `https://`；若輸入，系統應自動 normalize。

## 五、建立表單

1. 前往 `/admin/sites/{site_id}/forms`。
2. 點擊新增表單。
3. 輸入表單名稱，例如「聯絡我們」。
4. slug 可留空讓系統自動產生，或手動輸入 contact / aeo-consult。
5. 設定成功訊息。
6. 開啟所需固定欄位：phone、company_name、need_type、message。
7. 視需要新增自訂欄位。
8. 儲存。

Slug 是網址用代碼，不是顯示名稱。可用 contact、aeo-consult、joint-office；不可用中文、空白、特殊符號。

## 六、嵌入 iframe 表單

在表單編輯頁可取得 iframe code。

```html
<iframe
  src="https://nexus-lead-ops.lovable.app/embed/forms/contact"
  width="100%"
  height="600"
  frameborder="0">
</iframe>
```

操作：複製 iframe code，到 Oasis / Duda 的 HTML Widget 貼上，發布網站，並確認該網站 domain 已加入 allowed_domains。

## 七、測試表單送出

測試網址範例：`https://nexus-lead-ops.lovable.app/embed/forms/contact`

成功時應顯示：送出成功、success_message、再填一筆、返回原頁。

若出現「此網域未獲授權，無法送出」，請檢查 form 所屬 site、site allowed_domains、referer / origin、site.status 與 subscription.billing_status。

## 八、查看 Leads

路徑：`/admin/sites/{site_id}/leads`

功能：查看 Lead 列表、依 status 篩選、搜尋姓名 / Email / 電話、依日期篩選、分頁、點擊 Lead 開啟 Drawer、匯出 CSV。

## 九、Lead Drawer 使用方式

點擊 Leads 列表任一 Lead，右側會開啟 Lead Drawer。Drawer 是從右側滑出的詳情面板。URL 會出現 `?leadId={lead_id}`，關閉後移除。

Drawer 包含三個 Tab：資料、備註、活動。

## 十、資料 Tab

資料 Tab 顯示姓名、Email、電話、公司名稱、需求類型、留言、自訂欄位、表單來源、source page、referer、IP、User-Agent、建立時間。

## 十一、修改 Lead Status

在 Drawer 中可修改 Lead 狀態：new、contacted、meeting、quoted、closed、paused、invalid、spam。一般狀態可直接修改；改為 spam / invalid 時會要求確認。狀態修改後會寫入 activity_logs。

## 十二、新增 Lead Notes

在 Drawer 的「備註」Tab 輸入內容並點擊新增備註。備註會出現在時間軸，並記錄作者。系統會寫入 activity_logs.lead.note_add。

## 十三、Activity Tab

Activity Tab 顯示此 Lead 的活動紀錄，包含建立名單、通知派送、狀態變更、新增備註、CSV 匯出。預設顯示人類可讀摘要，需要技術細節時可展開 JSON。

## 十四、CSV 匯出

在 Leads 列表點擊「匯出 CSV」。系統依目前篩選條件匯出，單次最多 10,000 筆，使用 UTF-8 with BOM，custom_data 會攤平成 custom.{key} 欄位。

## 十五、Notification Settings

路徑：`/admin/sites/{site_id}/notifications`

Admin 可設定 enabled、email_recipients、notify_lohashare、lohashare_recipients、email_subject_template、from_domain。目前 from_domain 為 `notify.lohashare.com`。

## 十六、Notification skipped 模式說明

目前表單送出後，系統會觸發通知流程，但不會真的寄 Email。

系統會寫入：notification_logs.status = skipped、error_message = email_infra_not_configured、activity_logs.notification.dispatch，monthly_usage.email_sent_count 維持 0。

這是正常狀態，不是錯誤。正式寄信需等 Email Delivery Activation 完成。

## 十七、常見問題

### Q1：為什麼表單送出成功後沒有收到 Email？
因為目前是 skipped 模式，Email infrastructure 尚未設定。

### Q2：為什麼送出時出現「此網域未獲授權」？
代表目前送出表單的網域不在該 site 的 allowed_domains 中。

### Q3：為什麼 Operator 看不到通知收件人 Email？
這是安全設計。Operator 只能看到 count，不能看到實際 Email 清單。

### Q4：為什麼 Security Scan 還有 0028 / 0029 warnings？
這些是 accepted-by-design 的 current-user wrapper 或 safe utility，已記錄於 Security Memory，不應自動修復。

### Q5：何時可以正式寄 Email？
需完成下一階段 Email Delivery Activation，包括 notify.lohashare.com DNS 驗證與 Email provider 設定。

## 十八、不可自行操作事項

除非明確指示，不得自動 Fix security warnings、修改 RLS / SQL functions / GRANT、清除測試資料、啟用 Phase 4、新增 FAQ / AEO / AI、新增 LINE / Webhook / Google Sheet、新增金流、修改 Supabase project-level 設定、開放 anon / public 直接讀寫資料表或更改 current-user wrapper 授權架構。

