台灣時間 2026-05-28 02:16

以下為整理後版本：

**《LOHAShare AI 商務網站營運控制台 PRD v1.2 — 需求釐清後版本》**

版本：v1.2  
狀態：需求釐清完成版  
產品階段：MVP 規格定義  
開發策略：先完成 Lovable MVP，再逐步正式部署  
核心方向：Oasis 外部雲端後台 + 表單名單 + FAQ/AEO + Email 通知 + 方案額度控管  
第一版定位：LOHAShare 內部代維運使用，保留未來客戶登入與 SaaS 化架構

**1. 產品名稱**

**中文名稱**

**LOHAShare AI 商務網站營運控制台**

**MVP 名稱**

**LOHAShare AI Lead & AEO Console v1**

**英文暫名**

**LOHAShare AI Business Website Operation Console**

或簡稱：

**LOHAShare AI Console**

**2. 產品一句話定位**

**LOHAShare AI 商務網站營運控制台，是一套建立在 Oasis / Duda 外部的雲端後台，透過 iframe、HTML Widget、JS embed、外部資料庫與 AI API，協助 LOHAShare 內部管理網站名單、FAQ/AEO、Email 通知、來源追蹤、方案額度與月費代維運服務，讓網站從一次性建置服務升級為可持續收月費的 AI 行銷營運系統。**

**3. 本產品不是什麼**

第一版不做以下事情：

1.  不取代 Oasis / Duda。

2.  不做 Wix / Duda 類型完整 CMS。

3.  不做拖拉式網站編輯器。

4.  不直接修改 Oasis 後台。

5.  不依賴 Duda / Oasis API。

6.  不做完整白牌網站平台。

7.  不做完整 SaaS 自助開通。

8.  不做完整預約系統。

9.  不做完整 CRM。

10. 不做完整聯盟分潤結算。

11. 不做完整金流訂閱扣款。

12. 不做自動發票。

13. 不做 Search Console / Google Business Profile 深度 API 串接。

第一版只聚焦：

**讓 LOHAShare 能用自己的雲端後台，為 Oasis 網站提供名單追蹤、FAQ/AEO、Email 通知、AI 月報草稿與月費代維運支撐。**

**4. 產品核心目的**

**4.1 解決 LOHAShare 目前的商業問題**

目前網站設計案常見問題：

1.  網站做完後，缺乏持續收月費的理由。

2.  客戶表單名單散落在 Email、LINE、Google Sheet，後續追蹤不清楚。

3.  AEO / FAQ 常被客戶視為一次性建置，而不是持續服務。

4.  Oasis 雖能做網站，但 LOHAShare 不容易掌握後續營運資料。

5.  既有客戶需要一個「網站做完後還能持續優化」的服務理由。

6.  像十方光合這類已做過一次性 FAQ/AEO 的客戶，需要轉化成每月維運服務。

7.  未來若要發展聯合營業處、Referral、AI 顧問服務，需要自己的控制台與資料層。

**4.2 第一版要達成的成果**

MVP v1 要做到：

1.  給 **LOHAShare 內部代維運使用**。

2.  保留未來客戶登入架構，但 v1 不開放客戶操作。

3.  支援表單名單管理。

4.  支援 FAQ/AEO 管理。

5.  支援 AI FAQ 改寫。

6.  支援 AI 月報草稿。

7.  支援 Email 即時通知。

8.  支援 iframe 嵌入 Oasis HTML Widget。

9.  FAQ/AEO 保留 JS embed 備援方案。

10. 支援授權網域檢查。

11. 支援測試期寬鬆、正式期嚴格的網域白名單機制。

12. 支援方案與額度控管，但不接金流。

13. 可用於 LOHAShare 官網與聯合營業處頁面示範。

14. 可作為未來推廣給十方光合這類 AEO 客戶的示範。

**5. 目標使用者與權限定位**

**5.1 v1 實際主要使用者**

**LOHAShare Admin**

第一版主要給 LOHAShare 內部使用。

可操作：

- 客戶管理

- 網站管理

- 表單管理

- 名單管理

- FAQ/AEO 管理

- Email 通知設定

- AI FAQ 改寫

- AI 月報草稿

- iframe / embed code 產生

- 方案與額度設定

- 授權網域設定

**Internal Operator**

可管理指定客戶或網站。

適合未來 LOHAShare 團隊成員、專案執行者或外包維運人員。

**5.2 v1 保留但不公開的角色**

**Client User**

第一版保留資料架構與角色設計，但不公開客戶入口。

未來可依收費等級開放：

| **收費等級** | **客戶權限**             | **商業意義**                        |
|--------------|--------------------------|-------------------------------------|
| 基礎代維運版 | 客戶不登入               | LOHAShare 代管、代更新、代追蹤      |
| 報表檢視版   | 客戶可唯讀登入           | 客戶可看 FAQ 狀態、名單數、月報摘要 |
| 自主管理版   | 客戶可編輯 FAQ / 看名單  | 提高客戶參與度，可提高月費          |
| SaaS 版      | 客戶可自行建立表單與 FAQ | 未來產品化、自助式使用              |

**6. 第一個示範場景**

**6.1 主要示範場景**

第一版先用在：

1.  **LOHAShare 自己官網**

2.  **聯合營業處頁面**

示範功能：

- 表單名單進後台

- Email 通知

- FAQ/AEO 區塊

- AI FAQ 改寫

- AI 月報草稿

- referral_code 欄位保留

- 名單狀態追蹤

**6.2 商業驗證參考場景**

十方光合這類已做過一次性 AEO / FAQ 服務的客戶，作為未來推廣參考。

此類客戶的核心轉換論述：

**一次性 FAQ/AEO 是初始建置；每月服務是持續蒐集新問題、更新回答、檢查內容是否仍符合現況、產出月報與下一步優化建議。**

**7. MVP 功能範圍總覽**

v1 必做模組：

1.  客戶 / 網站管理模組

2.  表單 / 名單管理模組

3.  FAQ / AEO 管理模組

4.  AI FAQ 改寫與 AI 月報草稿模組

5.  Email 通知模組

6.  嵌入碼與雙嵌入模式模組

7.  授權網域與防盜模組

8.  方案與額度控管模組

9.  使用紀錄模組

v1 不做完整版本，但保留 Roadmap：

- 完整 CRM

- LINE OA 通知

- Webhook

- Google Sheet 同步

- 完整活動報名

- Referral 完整分潤

- 金流訂閱

- 客戶自助開通

- 客戶完整自主管理

**8. 模組一：客戶 / 網站管理模組**

**8.1 目的**

建立每個客戶與網站專案的基礎資料，讓後續表單、FAQ、通知、授權網域、方案額度都能綁定到正確客戶。

**8.2 核心功能**

**客戶管理**

欄位包含：

- 客戶名稱

- 公司名稱

- 聯絡人

- Email

- 電話

- LINE ID

- 備註

- 客戶狀態

客戶狀態：

- 潛在客戶

- 試用中

- 已啟用

- 暫停

- 已取消

**網站管理**

每個客戶可建立一個或多個網站專案。

欄位包含：

- 網站名稱

- 網站網址

- 平台類型

  - Oasis / Duda

  - WordPress

  - Lovable

  - Replit

  - 其他

- 授權網域

- 測試網域

- 網站狀態

- 對應客戶

- 啟用模組

- 備註

**8.3 MVP 驗收標準**

v1 必須做到：

- 可新增客戶

- 可新增網站

- 可設定網站平台

- 可設定正式網域

- 可設定測試網域

- 可設定網站狀態

- 每個網站自動產生 site_id

- 每個網站可綁定多個 allowed_domains

- 每個網站可啟用表單 / FAQ / 通知 / AI 模組

**9. 模組二：表單 / 名單管理模組**

**9.1 目的**

讓 Oasis 網站上的表單資料不只是寄到 Email，而是進入 LOHAShare AI Console，形成可追蹤、可分類、可回報、可支撐月費代維運的名單資料庫。

**9.2 表單欄位策略**

v1 採用：

**固定欄位 + 少量自訂欄位**

不做完整表單編輯器。

**9.3 標準欄位**

每個表單預設支援：

- 姓名

- 電話

- Email

- 公司名稱

- 需求類型

- 留言內容

- 同意隱私權政策

**9.4 可選欄位**

可開關：

- 預算區間

- 預計開始時間

- 是否已有網站

- 想諮詢的服務

- 報名場次

- 參與人數

**9.5 自訂欄位**

每個表單最多支援 1～3 個自訂欄位。

v1 自訂欄位類型先支援：

- 文字欄位

- 下拉選單

v1 不做：

- 檔案上傳

- 複雜條件邏輯

- 多頁表單

- 完整表單編輯器

**9.6 隱藏追蹤欄位**

每筆名單應保留：

- site_id

- form_id

- source_url

- source_domain

- referral_code

- utm_source

- utm_medium

- utm_campaign

- utm_content

- submitted_at

**9.7 名單管理深度**

v1 採用：

**名單列表 + 狀態管理 + 備註紀錄**

**名單狀態**

- 新名單

- 已聯絡

- 已約談

- 已報價

- 已成交

- 暫緩

- 無效

**備註紀錄**

每筆名單可新增備註，例如：

- 聯絡時間

- 客戶回應

- 下一步

- 報價狀況

- 是否需要追蹤

- 是否可轉成 FAQ 題目

**9.8 名單篩選**

v1 支援：

- 依網站篩選

- 依表單篩選

- 依狀態篩選

- 依日期篩選

- 依關鍵字搜尋

- 依來源 URL / referral_code 篩選

**9.9 匯出功能**

v1 支援 CSV 匯出。

**9.10 未來升級：簡易 CRM**

未來高階方案可加入：

- 負責人

- 下次追蹤日期

- 任務提醒

- 洽談紀錄時間軸

- 成交金額

- 標籤分類

- AI 名單摘要

- CRM 模組

**10. 模組三：FAQ / AEO 管理模組**

**10.1 目的**

讓 LOHAShare 能協助客戶持續管理 FAQ、AEO 問答、Schema 與 AI 搜尋友善內容，形成月費代維運服務的核心價值。

**10.2 管理權限**

v1 採用：

**完全由 LOHAShare 內部管理，同時保留未來客戶唯讀查看架構。**

客戶目前不直接編輯 FAQ。

**10.3 FAQ 素材來源**

可來自：

- 客戶訪談

- LINE 對話

- 老闆口述

- 客戶服務紀錄

- 表單問題

- Google Ads 搜尋詞

- Search Console 查詢字詞，未來

- 客戶現場常見問題

- 業務問答紀錄

**10.4 FAQ 欄位**

每題 FAQ 包含：

- 問題

- 原始回答

- AEO 友善短回答

- 詳細回答

- 分類

- 對應網站

- 對應頁面

- 狀態

  - 草稿

  - 待審核

  - 已發布

  - 停用

- 排序

- Schema JSON

- 本月是否更新

- 更新備註

**10.5 FAQ / AEO 月費服務意義**

v1 必須支撐以下說法：

**AEO 不是一次性服務。因為客戶問題會變、服務內容會變、搜尋行為會變、AI 搜尋摘要邏輯會變，FAQ/AEO 需要每月持續更新、檢查、擴充與回報。**

每月可服務項目：

- 新增 FAQ 題目

- 更新舊 FAQ 回答

- 修正不再準確的資訊

- 根據客戶新問題整理內容

- 根據表單問題產生 FAQ 候選題

- 根據銷售對話補充 FAQ

- 產生 Schema 草稿

- 產生月報摘要

- 提供下月優化建議

**11. 模組四：AI 功能模組**

**11.1 v1 AI 功能範圍**

v1 採用：

**AI FAQ 改寫 + AI 月報草稿**  
並保留未來 AI 名單摘要欄位。

**11.2 AI FAQ 改寫**

功能包含：

- 將原始回答改寫成 AEO 友善短回答

- 產生較完整詳細回答

- 調整語氣

- 產生 SEO / AEO 建議標題

- 產生 FAQ Schema 草稿

- 保留人工審核流程

**11.3 AI 月報草稿**

系統可根據本月資料產生月報草稿，包括：

- 本月新增名單數

- 本月 FAQ 新增題數

- 本月 FAQ 更新題數

- 本月表單來源摘要

- 本月 AEO 維運摘要

- 下月建議行動

- 可回報客戶的服務成果文字

**11.4 v1 保留資料欄位，未來做 AI 名單摘要**

未來可讓 AI 分析：

- 這位名單可能需要什麼

- 需求類型

- 優先程度

- 建議下一步

- 是否適合轉成 FAQ 題目

**11.5 未來 Roadmap**

未來升級：

- v1.5：AI 名單摘要

- v2：AI 內容主題建議

- v3：完整 AI 營運助理

- 備用策略：若 AI API 暫時不穩，保留人工代維運流程

**12. 模組五：Email 通知模組**

**12.1 目的**

當表單名單進入後，不只存進後台，也能即時通知指定人員，避免漏接客戶詢問，並提升月費服務價值。

**12.2 v1 通知策略**

v1 採用：

**做通知架構，但先只啟用 Email。**

未來保留：

- LINE OA 通知

- Webhook

- Google Sheet 同步

- CRM 串接

- 每日摘要

- 每週摘要

**12.3 v1 Email 即時通知功能**

每個表單可設定：

- 通知開關

- 通知收件者

- 多位收件者

- 是否通知 LOHAShare 內部

- 通知 Email 標題

- 通知內容模板

**12.4 Email 通知內容**

通知內容需包含：

- 表單名稱

- 網站名稱

- 客戶姓名

- 電話

- Email

- 公司名稱

- 需求類型

- 留言內容

- 自訂欄位

- 來源頁面

- referral_code

- UTM

- 送出時間

- 後台查看連結

**12.5 通知紀錄**

每次通知需記錄：

- lead_id

- form_id

- site_id

- recipient_email

- notification_type

- status

  - sent

  - failed

  - skipped

- error_message

- sent_at

**12.6 Email 通知額度**

Email 通知需納入方案額度。

建議初版方案：

| **方案**     | **每月名單上限** | **Email 通知上限** | **每表單收件者** |
|--------------|------------------|--------------------|------------------|
| 基礎代維運版 | 100 筆           | 300 封             | 最多 2 位        |
| AEO Growth   | 300 筆           | 1,000 封           | 最多 5 位        |
| Pro 營運版   | 1,000 筆         | 3,000 封           | 最多 10 位       |
| 企業版       | 客製             | 客製               | 客製             |

**12.7 未來通知 Roadmap**

v1.5：

- 每日摘要

- 每週摘要

- 尚未聯絡提醒

v2：

- LINE OA 通知

- Google Sheet 同步

- Webhook

v3：

- CRM 串接

- AI 優先名單提醒

- 自訂通知規則

**13. 模組六：嵌入碼與雙嵌入模式**

**13.1 目的**

讓 LOHAShare 控制台功能可嵌入 Oasis / Duda 網站，並兼顧穩定性、RWD、外觀與未來擴展性。

**13.2 v1 採用雙嵌入模式**

v1 採用：

**iframe 為預設方案，JS embed 作為 FAQ/AEO 的備援與未來優化方案。**

**13.3 表單嵌入策略**

表單 v1 以 iframe 優先。

原因：

- 穩定

- 安全

- 好控

- 較不受 Oasis CSS 影響

- 適合表單驗證與送出流程

範例：

\<iframe  
src="https://app.lohashare.com/embed/form?site_id=SITE_ID&form_id=FORM_ID"  
width="100%"  
height="680"  
frameborder="0"  
style="border:0; width:100%; max-width:100%;"  
loading="lazy"\>  
\</iframe\>

**13.4 FAQ/AEO 嵌入策略**

FAQ/AEO v1 支援 iframe，並規劃 JS embed 備援。

iframe 範例：

\<iframe  
src="https://app.lohashare.com/embed/faq?site_id=SITE_ID"  
width="100%"  
height="800"  
frameborder="0"  
style="border:0; width:100%; max-width:100%;"  
loading="lazy"\>  
\</iframe\>

JS embed 未來範例：

\<div  
id="lohashare-faq"  
data-site-id="SITE_ID"  
data-widget-id="WIDGET_ID"\>  
\</div\>  
\<script src="https://app.lohashare.com/embed/faq-widget.js"\>\</script\>

**13.5 RWD 與高度策略**

v1 必做：

- iframe 內頁本身 RWD

- 手機版單欄

- 欄位寬度 100%

- FAQ 文字自動換行

- 提供不同高度版本

  - 短版

  - 標準版

  - 長版

v1.5 / v2 可做：

- iframe 高度自動調整

- postMessage 高度同步

- JS embed 取代 FAQ iframe

**14. 模組七：外觀樣式與品牌設定**

**14.1 v1 外觀策略**

採用：

**2～3 種基本樣式模板 + 簡單品牌色設定**

**14.2 v1 樣式模板**

建議提供：

1.  標準白底版

2.  LOHAShare 橘色版

3.  簡潔卡片版

**14.3 品牌設定**

每個網站可設定：

- 主色

- 按鈕色

- 標題色

- 圓角大小

- 按鈕文字

- 是否顯示 Powered by LOHAShare

**14.4 Powered by LOHAShare 策略**

可作為方案差異：

- 基礎方案：顯示 Powered by LOHAShare

- 高階方案：可隱藏

- 企業方案：可客製品牌

**15. 模組八：授權網域、防盜與測試模式**

**15.1 目的**

避免客戶或第三方複製 iframe / JS embed code 後，在未授權網站使用。

**15.2 v1 授權策略**

採用：

**測試期寬鬆、正式啟用後嚴格，並支援多網域白名單。**

**15.3 網站狀態**

每個網站狀態：

- draft：測試中，可允許測試網域

- active：正式啟用，只允許正式網域與白名單

- suspended：暫停，不顯示有效內容

- cancelled：取消，不顯示有效內容

**15.4 多網域白名單**

每個網站可設定多個 allowed_domains，例如：

- 正式網域

- Oasis 預覽網址

- Lovable 測試網址

- Vercel 測試網址

- 客戶暫存網址

**15.5 授權檢查邏輯**

每次 iframe / JS embed 載入時檢查：

1.  site_id 是否存在

2.  widget_id / form_id / faq_id 是否存在

3.  widget 是否啟用

4.  網站狀態是否允許顯示

5.  來源網域是否符合白名單

6.  方案狀態是否 active / trial

7.  是否超過使用量限制

8.  是否已 suspended / cancelled

**15.6 非授權處理**

未授權時顯示：

此模組尚未啟用，請聯絡 LOHAShare。

或：

This widget is not authorized for this domain.

**15.7 來源網域紀錄**

需記錄所有載入來源，包含：

- source_domain

- source_url

- widget_id

- site_id

- event_type

- 是否授權成功

- error_message

**16. 模組九：方案與額度控管模組**

**16.1 目的**

v1 不接金流，但必須能支撐收費方案、功能分級與額度管理。

**16.2 v1 採用策略**

採用：

**v1 做方案與額度控管，但不接金流。**

付款、續約、報價、開通由 LOHAShare 人工處理。

**16.3 v1 要做的方案控管**

後台可設定：

- 方案名稱

- 方案狀態

- 啟用模組

- 每月名單上限

- 每月 Email 通知上限

- 每月 AI FAQ 改寫上限

- 每月 FAQ 更新題數

- 是否開放客戶登入

- 是否開放報表檢視

- 是否開放自主管理

- 服務開始日

- 下次續約日

- 收費備註

**16.4 方案狀態**

- trial

- active

- past_due

- suspended

- cancelled

**16.5 v1 不做金流**

v1 不做：

- 線上刷卡

- 自動扣款

- 自動發票

- 自助升級

- 付款失敗自動催收

- 自動開通 / 停用完整流程

**16.6 未來金流 Roadmap**

v1.5 / v2 再評估：

- 綠界

- 藍新

- TapPay

- Stripe

- 自動續約

- 付款提醒

- 發票流程

- 自動升降級方案

**17. 初步方案與收費設計**

**17.1 對外商品名稱**

建議第一版對外名稱：

**AI 商務網站基礎營運模組**

或：

**AI AEO 與名單追蹤代維運服務**

**17.2 建置費**

建議：

NT\$12,000 ～ NT\$25,000 / 站

包含：

- 客戶網站建檔

- 表單設定

- iframe 嵌入

- FAQ 初始設定

- 基本 AEO 問答建置

- Email 通知設定

- 授權網域設定

- 測試與上線

**17.3 月費方案草案**

| **方案**     | **建議月費**     | **客戶登入**        | **表單** | **名單上限** | **Email 通知** | **FAQ 更新**  | **AI 月報** |
|--------------|------------------|---------------------|----------|--------------|----------------|---------------|-------------|
| 基礎代維運版 | NT\$1,500～2,500 | 不開放              | 1 個     | 100 筆       | 300 封         | 3 題          | 簡易摘要    |
| AEO Growth   | NT\$3,800～5,000 | 不開放 / 可加購唯讀 | 2 個     | 300 筆       | 1,000 封       | 6 題          | 有          |
| Pro 營運版   | NT\$6,800～9,800 | 可唯讀              | 5 個     | 1,000 筆     | 3,000 封       | 10 題         | 有          |
| 自主管理版   | NT\$12,000 起    | 可操作              | 10 個    | 依方案       | 依方案         | 可提交 / 編輯 | 有          |
| 企業版       | 客製             | 客製                | 客製     | 客製         | 客製           | 客製          | 客製        |

**18. 資料表設計 v1.2**

**18.1 customers**

| **欄位**     | **說明** |
|--------------|----------|
| customer_id  | 客戶 ID  |
| company_name | 公司名稱 |
| contact_name | 聯絡人   |
| email        | Email    |
| phone        | 電話     |
| line_id      | LINE ID  |
| status       | 客戶狀態 |
| notes        | 備註     |
| created_at   | 建立時間 |
| updated_at   | 更新時間 |

**18.2 sites**

| **欄位**    | **說明**                               |
|-------------|----------------------------------------|
| site_id     | 網站 ID                                |
| customer_id | 對應客戶                               |
| site_name   | 網站名稱                               |
| domain      | 正式網域                               |
| platform    | Oasis / WordPress / 其他               |
| status      | draft / active / suspended / cancelled |
| created_at  | 建立時間                               |
| updated_at  | 更新時間                               |

**18.3 allowed_domains**

| **欄位**    | **說明**                                     |
|-------------|----------------------------------------------|
| domain_id   | 網域 ID                                      |
| site_id     | 對應網站                                     |
| domain      | 授權網域                                     |
| domain_type | production / preview / staging / development |
| status      | active / inactive                            |
| created_at  | 建立時間                                     |

**18.4 plans**

| **欄位**                 | **說明**            |
|--------------------------|---------------------|
| plan_id                  | 方案 ID             |
| plan_name                | 方案名稱            |
| lead_limit_monthly       | 每月名單上限        |
| email_limit_monthly      | 每月 Email 通知上限 |
| ai_rewrite_limit_monthly | 每月 AI 改寫上限    |
| faq_update_quota_monthly | 每月 FAQ 更新題數   |
| form_limit               | 表單數量上限        |
| client_login_enabled     | 是否允許客戶登入    |
| report_view_enabled      | 是否允許報表檢視    |
| self_manage_enabled      | 是否允許自主管理    |
| created_at               | 建立時間            |

**18.5 subscriptions**

| **欄位**        | **說明**                                          |
|-----------------|---------------------------------------------------|
| subscription_id | 訂閱 / 服務 ID                                    |
| customer_id     | 對應客戶                                          |
| site_id         | 對應網站                                          |
| plan_id         | 對應方案                                          |
| billing_mode    | manual / future_online                            |
| billing_status  | trial / active / past_due / suspended / cancelled |
| start_date      | 服務開始日                                        |
| renewal_date    | 下次續約日                                        |
| notes           | 備註                                              |
| created_at      | 建立時間                                          |
| updated_at      | 更新時間                                          |

**18.6 forms**

| **欄位**             | **說明**          |
|----------------------|-------------------|
| form_id              | 表單 ID           |
| site_id              | 對應網站          |
| form_name            | 表單名稱          |
| form_type            | 表單類型          |
| fields_config        | 欄位設定 JSON     |
| custom_fields_config | 自訂欄位 JSON     |
| success_message      | 成功訊息          |
| status               | active / inactive |
| created_at           | 建立時間          |
| updated_at           | 更新時間          |

**18.7 leads**

| **欄位**      | **說明**      |
|---------------|---------------|
| lead_id       | 名單 ID       |
| form_id       | 對應表單      |
| site_id       | 對應網站      |
| customer_id   | 對應客戶      |
| name          | 姓名          |
| phone         | 電話          |
| email         | Email         |
| company_name  | 公司名稱      |
| need_type     | 需求類型      |
| message       | 留言          |
| custom_fields | 自訂欄位 JSON |
| source_url    | 來源頁面      |
| source_domain | 來源網域      |
| referral_code | 推薦碼        |
| utm_source    | UTM 來源      |
| utm_medium    | UTM 媒介      |
| utm_campaign  | UTM 活動      |
| status        | 名單狀態      |
| notes         | 備註          |
| ai_summary    | 未來 AI 摘要  |
| created_at    | 建立時間      |
| updated_at    | 更新時間      |

**18.8 lead_notes**

| **欄位**   | **說明** |
|------------|----------|
| note_id    | 備註 ID  |
| lead_id    | 對應名單 |
| note       | 備註內容 |
| created_by | 建立者   |
| created_at | 建立時間 |

**18.9 faqs**

| **欄位**           | **說明**                              |
|--------------------|---------------------------------------|
| faq_id             | FAQ ID                                |
| site_id            | 對應網站                              |
| customer_id        | 對應客戶                              |
| page_key           | 對應頁面                              |
| question           | 問題                                  |
| raw_answer         | 原始回答                              |
| short_answer       | AEO 短回答                            |
| long_answer        | 詳細回答                              |
| category           | 分類                                  |
| sort_order         | 排序                                  |
| schema_json        | FAQ Schema                            |
| status             | draft / review / published / inactive |
| updated_this_month | 是否本月更新                          |
| update_notes       | 更新備註                              |
| created_at         | 建立時間                              |
| updated_at         | 更新時間                              |

**18.10 widgets**

| **欄位**       | **說明**                  |
|----------------|---------------------------|
| widget_id      | Widget ID                 |
| site_id        | 對應網站                  |
| widget_type    | form / faq                |
| related_id     | 對應 form_id 或 faq group |
| embed_mode     | iframe / js               |
| public_key     | 公開識別 key              |
| style_template | 樣式模板                  |
| brand_color    | 品牌主色                  |
| status         | active / inactive         |
| created_at     | 建立時間                  |
| updated_at     | 更新時間                  |

**18.11 notification_settings**

| **欄位**                | **說明**           |
|-------------------------|--------------------|
| notification_setting_id | 通知設定 ID        |
| form_id                 | 對應表單           |
| site_id                 | 對應網站           |
| email_enabled           | 是否啟用 Email     |
| notify_lohashare        | 是否通知 LOHAShare |
| recipients              | 收件者 JSON        |
| subject_template        | 信件標題模板       |
| created_at              | 建立時間           |
| updated_at              | 更新時間           |

**18.12 notification_logs**

| **欄位**            | **說明**                |
|---------------------|-------------------------|
| notification_log_id | 通知紀錄 ID             |
| lead_id             | 對應名單                |
| form_id             | 對應表單                |
| site_id             | 對應網站                |
| notification_type   | email / line / webhook  |
| recipient           | 收件者                  |
| status              | sent / failed / skipped |
| error_message       | 錯誤訊息                |
| sent_at             | 發送時間                |

**18.13 usage_logs**

| **欄位**      | **說明**                             |
|---------------|--------------------------------------|
| log_id        | 紀錄 ID                              |
| site_id       | 對應網站                             |
| widget_id     | 對應 Widget                          |
| event_type    | view / submit / error / unauthorized |
| source_domain | 來源網域                             |
| source_url    | 來源網址                             |
| ip_hash       | IP 雜湊                              |
| user_agent    | 瀏覽器資訊                           |
| created_at    | 建立時間                             |

**18.14 monthly_usage**

| **欄位**          | **說明**     |
|-------------------|--------------|
| usage_id          | 使用量 ID    |
| site_id           | 對應網站     |
| customer_id       | 對應客戶     |
| year_month        | 年月         |
| lead_count        | 名單數       |
| email_sent_count  | Email 寄送數 |
| ai_rewrite_count  | AI 改寫次數  |
| faq_updated_count | FAQ 更新題數 |
| created_at        | 建立時間     |
| updated_at        | 更新時間     |

**19. 雲端部署策略**

**19.1 開發期**

採用：

**Lovable 預設網址 + Supabase**

用途：

- 快速建立 MVP

- 測試後台

- 測試表單 iframe

- 測試 FAQ

- 測試 Email 通知

- 測試授權網域

**19.2 示範期**

採用：

**Lovable + Supabase + app.lohashare.com**

用途：

- 放到 LOHAShare 官網示範

- 放到聯合營業處頁面示範

- 給既有 Oasis 客戶展示

- 給十方光合類 AEO 客戶展示月費服務概念

**19.3 正式收費期**

採用：

**GitHub + Vercel + Supabase + app.lohashare.com**

理由：

- 保留程式碼控制權

- 提高正式營運穩定度

- 方便工程師接手

- 方便版本控管

**19.4 擴大量期**

採用：

**Vercel 管後台，Cloudflare 管 embed / API，Supabase 管資料**

未來可拆成：

- console.lohashare.com

- embed.lohashare.com

- api.lohashare.com

**20. v1 成功標準**

v1 成功標準採用：

**B + C + D + 部分 E**

**20.1 可在 LOHAShare 官網展示**

必須能示範：

- 表單名單進後台

- Email 即時通知

- FAQ/AEO 區塊

- AI FAQ 改寫

- AI 月報草稿

- 授權網域控制

- 方案額度設定

**20.2 可向既有 Oasis 客戶說明並銷售**

需要具備：

- 商品名稱

- 建置費

- 月費方案

- 功能分級

- 名單通知額度

- FAQ 更新額度

- AI 改寫額度

- Demo 頁面

- 簡易月報

**20.3 可推廣給十方光合這類 AEO 客戶**

需要能說明：

- 為什麼 AEO 不是一次性服務

- 為什麼每月要更新 FAQ

- 為什麼需要月報

- 為什麼表單問題可變成新 FAQ

- 為什麼 AI + 人工審核能提高內容品質

- 為什麼這是網站持續營運服務

**20.4 具備部分正式商業化能力**

v1 要做到：

- 可設定方案

- 可設定方案狀態

- 可設定啟用模組

- 可設定名單上限

- 可設定 Email 通知上限

- 可設定 AI 改寫額度

- 可設定 FAQ 更新題數

- 可記錄使用量

- 超量可提醒 LOHAShare 管理者

v1 不要求：

- 線上刷卡

- 自動扣款

- 自動發票

- 自助開通

- 完整 SaaS 訂閱

**21. Roadmap**

**v1：AI Lead & AEO Console**

核心：

- 客戶 / 網站管理

- 表單名單

- Email 通知

- FAQ/AEO

- AI FAQ 改寫

- AI 月報草稿

- iframe 嵌入

- FAQ JS embed 備援規劃

- 授權網域

- 方案額度控管

**v1.5：月報與名單摘要強化**

新增：

- AI 名單摘要

- 每日 / 每週通知摘要

- 月報格式強化

- UTM 報表

- FAQ 更新歷程

- 未聯絡名單提醒

**v2：活動 / 報名模組**

新增：

- 活動建立

- 報名表

- 名額管理

- 報名名單

- 報到狀態

- 活動成效

**v3：Referral / 聯合營業處模組**

新增：

- 合作夥伴管理

- referral code

- referral URL

- QR Code

- 推薦來源追蹤

- 成交狀態

- 合作夥伴後台

**v4：AI 商務流程系統**

新增：

- AI 提案生成

- AI 客戶需求分析

- AI 行銷建議

- AI 報表 PDF

- LINE OA 通知

- Google Sheet 同步

- Webhook

- Google Business Profile 輕量串接

- Search Console 輕量串接

**v5：正式 SaaS 化**

新增：

- 客戶自助開通

- 線上訂閱金流

- 自動續約

- 自動停用

- 客戶自主管理

- 使用量計費

- 多租戶完整權限

- console.lohashare.com

- embed.lohashare.com

- api.lohashare.com

**22. 下一步**

接下來建議依序執行：

**Step 1：產生 Lovable 開發提示詞**

把 PRD v1.2 轉成一份可直接貼給 Lovable 的完整開發提示詞。

**Step 2：先建立 Supabase 資料表**

至少先建立：

- customers

- sites

- allowed_domains

- plans

- subscriptions

- forms

- leads

- lead_notes

- faqs

- widgets

- notification_settings

- notification_logs

- usage_logs

- monthly_usage

**Step 3：用 Lovable 做內部版後台**

先完成：

- 登入

- 客戶管理

- 網站管理

- 表單管理

- 名單管理

- FAQ 管理

- 通知設定

- 方案額度設定

**Step 4：做第一個 iframe 表單**

成功標準：

後台建立表單 → 產生 iframe → 貼到 Oasis → 訪客送出 → 後台收到名單 → Email 通知寄出。

**Step 5：做 FAQ/AEO 區塊**

成功標準：

後台建立 FAQ → AI 改寫 → 產生 FAQ iframe / JS embed 備援 → 貼到 Oasis → 顯示 FAQ → 產生 Schema 草稿。

**Step 6：做月報草稿**

成功標準：

系統根據當月名單、FAQ 更新、AI 改寫次數、Email 通知數，產生一份可人工修改的月報草稿。

**23. PRD v1.2 核心結論**

這套系統第一版不是 CMS，也不是 SaaS 自助平台。

它的本質是：

**LOHAShare 內部使用的 AI AEO 與名單營運後台，用來支撐既有 Oasis 網站客戶的月費代維運服務。**

第一版的最小成功閉環是：

**表單進名單 → Email 通知 → 名單狀態追蹤 → FAQ/AEO 更新 → AI 月報草稿 → 方案額度控管 → 可向客戶說明月費價值。**

這樣才不是只做一個工具，而是形成：

**AI 行銷營運系統 + AI 商務流程系統 + 月費服務交付後台。**

# **24. v1.3 增補說明：以 v1.2 全文保留為基準的更新版**

版本：v1.3

狀態：基於 v1.2「需求釐清後版本」之延伸更新

產品階段：MVP 規格定義完成後，進入平台化藍圖補強

開發策略：先完成 Lovable MVP，再逐步補強模組化平台能力

核心方向：Oasis 外部雲端後台 + 表單名單 + FAQ/AEO + Email 通知 + 方案額度控管 + 未來模組化 AI 商務營運總控台

版本定位：本版不是摘要版，也不是取代原文的精簡版。本版完整保留 v1.2 原文，僅在後方增補版本歷史、差異比較、平台模組藍圖、總控 Dashboard 規劃、模組分支進度管理規則與當前模組狀態。

## **24.1 本次修正原則**

• 不得刪除 v1.2 原始正文。

• 不得將 Lead Console、Email Delivery、Referral 等子模組誤寫成主 PRD。

• 主 PRD 版本只記錄產品定位、MVP 範圍、Roadmap、模組架構、商業模式、部署策略等主軸變化。

• 各模組的開發進度、除錯紀錄、Build Plan、E2E 驗收與 Support Ticket，另列為模組分支紀錄。

• v1.3 是在 v1.2 基礎上的增補版，不是重寫版。

## **24.2 v1.2 與 v1.3 的差異摘要**

| **項目**  | **v1.2 內容**                                                                                          | **v1.3 增補**                                                                |
|-----------|--------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| 主定位    | LOHAShare 內部使用的 AI AEO 與名單營運後台，用來支撐 Oasis 網站客戶月費代維運服務。                    | 定位不變；補充未來可延伸為 LOHAShare 自己的 AI 商務管理後台。                |
| MVP 範圍  | 客戶/網站、表單名單、FAQ/AEO、AI FAQ 改寫、AI 月報、Email 通知、嵌入碼、授權網域、方案額度、使用紀錄。 | 不擴大 v1 必做範圍；新增未來模組藍圖與分支版本管理。                         |
| Roadmap   | v1 到 v5：Lead & AEO、月報摘要、活動/報名、Referral、AI 商務流程、SaaS 化。                            | 保留原 Roadmap；補充預約、Landing Page、GBP、授權碼、總控 Dashboard 的位置。 |
| Dashboard | v1.2 未將 Dashboard 作為獨立規劃章節。                                                                 | 新增未來「總控 Dashboard / 模組中心 / SaaS 管理中心」規劃。                  |
| 文件管理  | 尚未明確區分主 PRD、模組 PRD、實作文件。                                                               | 新增主軸與分支的文件層級與版本紀錄規則。                                     |
| 模組進度  | 列出 v1 模組與 Roadmap 模組。                                                                          | 新增模組狀態表與版本歷史管理格式。                                           |

# **25. v1.3 平台模組藍圖**

本章將 v1.2 已定義的 v1 必做模組與未來 Roadmap 模組，整理成「平台模組藍圖」。此藍圖不代表 v1 立即全做，而是用來明確區分哪些是目前 MVP 核心，哪些是未來階段的模組化擴充。

## **25.1 模組與用途總表**

| **模組**          | **用途**                                                             | **主 PRD 關係**                                   | **建議階段**      |
|-------------------|----------------------------------------------------------------------|---------------------------------------------------|-------------------|
| AI FAQ / AEO 模組 | 產生 FAQ、Schema、AEO 內容，支撐每月 AEO 維運服務。                  | v1 MVP 核心模組之一。                             | v1 / Phase 4 實作 |
| 表單名單模組      | 收集潛在客戶、分類、追蹤、備註、狀態管理、CSV 匯出。                 | v1 MVP 核心模組之一。                             | v1 已先行實作     |
| Email 通知模組    | 表單送出後即時通知 LOHAShare、客戶或指定人員，並記錄通知狀態與額度。 | v1 MVP 核心模組之一。                             | v1 進行中         |
| 預約模組          | 活動、顧問、課程、服務預約，名額管理與報到狀態。                     | v1 不做完整預約系統，Roadmap 保留。               | v2                |
| Referral 模組     | 推薦碼、推薦連結、QR Code、分潤來源、成交歸因。                      | v1 保留 referral_code 欄位。                      | v3                |
| GBP 模組          | 管理 Google 商家資訊、評論、預約連結，未來可做輕量串接。             | v1 不做深度 API 串接。                            | v4                |
| Landing Page 模組 | 快速生成活動頁、招商頁、說明會頁，並串接表單與 Referral。            | v1 不做，屬未來導流模組。                         | v2 / v4           |
| AI 提案模組       | 根據客戶需求產出提案草稿、報價初稿、顧問建議。                       | v1 不做，屬 AI 商務流程系統。                     | v4                |
| AI 報表模組       | 產生月報、成效摘要、改善建議，支撐月費服務交付。                     | v1 做月報草稿，未來強化。                         | v1.5 / v4         |
| 授權碼模組        | 管理聯合營業處夥伴權限、可用模組與夥伴等級。                         | v1 不做完整授權碼，與 Referral / 聯合營業處相關。 | v3                |
| 總控 Dashboard    | 顯示所有模組、總管理、統計分析、銷售績效、系統健康與模組擴充。       | 未來平台化核心，不屬 v1 必做。                    | v5                |

## **25.2 模組中心的長期方向**

未來 LOHAShare AI 商務網站營運控制台可逐步形成「模組中心」，讓管理者能看到每個客戶或網站啟用了哪些模組、每個模組的使用量、錯誤狀態、收費方案與後續升級機會。

• 每個網站可啟用不同模組，例如表單名單、FAQ/AEO、Email 通知、Referral、預約、Landing Page。

• 每個模組可對應不同方案、額度與月費價值。

• 模組可支援不同權限，例如 LOHAShare Admin、Internal Operator、Client Read-only、Partner。

• 未來 SaaS 化時，模組中心可作為客戶自助開通與升級的基礎。

# **26. 未來總控 Dashboard 規劃**

v1.3 確認：總控 Dashboard 適合作為未來某一階段的規劃，但不列入 v1 MVP 必做。它應成為 LOHAShare AI 商務網站營運控制台的平台首頁與營運指揮中心。

## **26.1 Dashboard 可以看到的內容**

| **Dashboard 區塊**    | **可顯示資訊**                                                     | **商業價值**                                  |
|-----------------------|--------------------------------------------------------------------|-----------------------------------------------|
| 模組總覽              | 已啟用模組、未啟用模組、即將推出模組、模組健康狀態。               | 讓 LOHAShare 掌握各客戶可升級模組與服務深度。 |
| 客戶與網站總覽        | 客戶數、網站數、方案狀態、平台類型、啟用模組。                     | 支援代維運與續約管理。                        |
| 表單名單統計          | 本月名單數、狀態分布、來源、UTM、referral_code。                   | 用數據證明網站持續營運價值。                  |
| FAQ / AEO 統計        | FAQ 題數、本月新增/更新、Schema、AI 改寫次數。                     | 支撐 AEO 月費維運服務。                       |
| 通知狀態              | Email sent / failed / skipped、通知額度、錯誤警示。                | 降低漏接名單風險。                            |
| 預約與活動            | 活動數、報名數、名額使用率、報到率、顧問預約數。                   | 支援說明會、課程與顧問服務。                  |
| Referral 與聯合營業處 | 推薦來源、夥伴貢獻、成交歸因、分潤待結算。                         | 支援 S2B2C 與共享經濟模式。                   |
| 銷售績效              | 建置費、月費、MRR、ARR、續約率、成交率、方案升級。                 | 支援經營決策與業務管理。                      |
| AI 交付成果           | AI 提案、AI 月報、AI FAQ 改寫、採用率。                            | 展現 AI 顧問服務的交付價值。                  |
| 系統健康              | API、Embed、授權網域、Email provider、錯誤紀錄、Security warning。 | 支援正式營運監控。                            |

## **26.2 Dashboard 階段定位**

| **階段** | **Dashboard 形式**                                                 |
|----------|--------------------------------------------------------------------|
| v1       | 各模組頁面內的基本統計，不做完整總控 Dashboard。                   |
| v1.5     | 加入月報、名單摘要、UTM 報表、FAQ 更新歷程。                       |
| v2       | 加入活動、報名、預約統計。                                         |
| v3       | 加入 Referral、Partner、授權碼與分潤統計。                         |
| v4       | 加入 AI 提案、AI 報表、GBP、Webhook、Google Sheet 等商務流程資料。 |
| v5       | 形成正式總控 Dashboard / 模組中心 / SaaS 管理中心。                |

# **27. 模組開發進度與版本歷史管理規則**

為避免再次混淆主 PRD 與模組開發紀錄，從 v1.3 起，所有模組開發都必須建立獨立版本歷史。主 PRD 只記錄產品主軸變動；模組文件才記錄 Build、Debug、E2E 驗收、Support Ticket、Provider 切換等細節。

## **27.1 主 PRD 版本更新條件**

只有以下變動才更新主 PRD 版本：

• 產品定位改變。

• MVP 範圍改變。

• Roadmap 改變。

• 商業模式或收費方案改變。

• 模組架構改變。

• 角色權限策略改變。

• 部署策略改變。

• 正式將新模組納入主平台規劃。

## **27.2 模組版本更新條件**

以下內容只更新模組版本，不更新主 PRD 主版本：

• Email provider debug。

• Lead Drawer 修正。

• Forms CRUD 修正。

• Security warning 修正。

• allowed_domains 修正。

• notification_logs 修正。

• ZeptoMail adapter 或其他 provider adapter。

• Lovable / Replit / Claude Build 指令。

• E2E 驗收結果。

• Support Ticket 與外部平台回覆。

## **27.3 模組版本歷史格式**

| **欄位**     | **說明**                                                                                                      |
|--------------|---------------------------------------------------------------------------------------------------------------|
| 模組名稱     | 例如：表單名單模組、Email 通知模組、FAQ/AEO 模組。                                                            |
| 版本編號     | 例如：Lead-v1.0、Email-v0.9、AEO-v0.1。                                                                       |
| 時間         | 版本建立或更新時間。                                                                                          |
| 狀態         | Concept / PRD Draft / Planning / Build / Preview Verified / Stable / Pending External / Paused / Deprecated。 |
| 產品階段     | 該模組所屬主 Roadmap 階段。                                                                                   |
| 開發策略     | 先做 MVP、先做內部版、先做 fallback、先做 API 等。                                                            |
| 核心方向     | 該版本要解決的核心問題。                                                                                      |
| 版本定位     | 該版本是規格、實作、驗收、修正或穩定版。                                                                      |
| 增訂修改部分 | 具體新增、修改、刪除或暫緩內容。                                                                              |

## **27.4 目前模組進度總表**

| **模組**               | **目前狀態**               | **目前版本 / 階段**       | **備註**                                                               |
|------------------------|----------------------------|---------------------------|------------------------------------------------------------------------|
| 客戶 / 網站管理模組    | Build 已進行               | Lead Console MVP 內已實作 | 屬於 v1 MVP 基礎。                                                     |
| 表單名單模組           | Build 已進行               | Phase 3c Stable           | 已完成主要表單與 Lead 功能。                                           |
| Email 通知模組         | Pending External           | Phase 3d-2                | Provider accepted，但 inbox visibility pending，等待 Lovable Support。 |
| FAQ / AEO 模組         | Planning                   | Phase 4 待啟動            | v1 MVP 必做，但尚未實作。                                              |
| AI FAQ 改寫 / 月報模組 | Planning                   | Phase 4 / v1.5            | 尚未實作。                                                             |
| 嵌入碼 / 授權網域模組  | 部分完成                   | Lead Console MVP 內已實作 | 表單 iframe 已先行實作。                                               |
| 方案與額度控管模組     | 部分完成                   | v1 MVP 內已建立基礎       | 金流不做。                                                             |
| 預約模組               | Concept                    | v2 候選                   | 非 v1。                                                                |
| Referral 模組          | Concept / 規劃中           | v3 候選                   | 與聯合營業處高度相關。                                                 |
| GBP 模組               | Concept                    | v4 候選                   | 可連 SBIR / 創新案。                                                   |
| Landing Page 模組      | Concept                    | v2 / v4 候選              | 與活動與表單整合。                                                     |
| AI 提案模組            | Concept                    | v4 候選                   | 顧問交付自動化。                                                       |
| AI 報表模組            | Planning                   | v1.5 / v4                 | 月報草稿先做，完整報表後做。                                           |
| 授權碼模組             | Concept / 已有外部專案經驗 | v3 候選                   | 聯合營業處夥伴權限。                                                   |
| 總控 Dashboard         | Concept                    | v5 候選                   | 平台化與 SaaS 化核心。                                                 |

# **28. v1.3 更新後的 Roadmap 補充說明**

本章不取代 v1.2 第 21 章 Roadmap，而是在原 Roadmap 上補充模組化理解。

| **Roadmap 階段**              | **v1.2 原方向**                                                                                           | **v1.3 補充說明**                                                              |
|-------------------------------|-----------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| v1：AI Lead & AEO Console     | 客戶/網站、表單名單、Email、FAQ/AEO、AI FAQ、AI 月報、嵌入碼、授權網域、方案額度。                        | 維持為 MVP 主軸；目前 Lead Console 已先行實作，FAQ/AEO 尚待 Phase 4。          |
| v1.5：月報與名單摘要強化      | AI 名單摘要、通知摘要、月報強化、UTM 報表、FAQ 更新歷程。                                                 | 可作為 AI 報表模組的早期版本。                                                 |
| v2：活動 / 報名模組           | 活動建立、報名表、名額管理、報名名單、報到狀態、活動成效。                                                | v1.3 補充為活動 / 報名 / 預約模組，可支援顧問、課程與服務預約。                |
| v3：Referral / 聯合營業處模組 | 合作夥伴、referral code、URL、QR Code、推薦來源、成交狀態、合作夥伴後台。                                 | v1.3 補充授權碼模組與分潤來源管理。                                            |
| v4：AI 商務流程系統           | AI 提案、AI 客戶需求分析、AI 行銷建議、AI 報表 PDF、LINE OA、Google Sheet、Webhook、GBP、Search Console。 | v1.3 補充 Landing Page、GBP Center、AI Proposal Studio、AI Report Studio。     |
| v5：正式 SaaS 化              | 客戶自助開通、金流、自動續約、客戶自主管理、多租戶、console/embed/api 子網域。                            | v1.3 補充總控 Dashboard、模組中心、MRR/ARR、Partner 貢獻、銷售績效與系統健康。 |

# **29. v1.3 核心結論**

v1.3 的核心結論如下：

• LOHAShare AI 商務網站營運控制台仍以 v1.2 為主 PRD 基準。

• 本次更新不刪除 v1.2 內容，也不將任何子模組誤升級為主產品。

• v1.3 主要新增平台模組化藍圖、總控 Dashboard 規劃、模組版本歷史規則與目前模組狀態。

• Lead Console / Nexus Lead Ops 是表單名單模組的實作分支，不是主 PRD 本身。

• Email Delivery 的 Mailgun / Lovable debug 是 Email 通知模組的技術驗收分支，不是主 PRD 本體。

• 未來若有模組開發，必須新增該模組自己的開發進度與版本歷史，不得混入主 PRD 主軸。

• 總控 Dashboard 適合作為 v5 正式 SaaS 化與平台化的核心模組。

本文件後續更新時，應持續保留 v1.2 原文，並以增補章節、差異表、版本歷史表與模組進度表方式擴充，不得為了縮短篇幅而刪除原始需求內容。

# 30. v1.4 增補：模組化平台架構與開發治理摘要

版本：v1.4｜狀態：基於 v1.3+v1.2 全文保留版之架構治理增補｜產出日：2026-05-30

本章不刪除、不取代 v1.2 與 v1.3 原文，而是在既有主 PRD 後方新增「模組化平台架構治理摘要」，用來把未來各模組之開發方式、相依規則、訂閱控管與文件分冊關係固定下來。

## 30.1 本次 v1.4 更新原則

> • 主 PRD 繼續以 v1.2 全文為基準，v1.3 作為平台模組藍圖與版本管理增補。
>
> • v1.4 僅新增架構治理摘要與文件分冊關係，不把完整治理文件全文塞入主 PRD。
>
> • Lead Console / Nexus Lead Ops、Referral、Email Delivery、AI FAQ / AEO 等均視為模組或分支文件，不再混入主 PRD 主軸。
>
> • 未來所有模組開發均需遵守 Core + Module + Subscription Entitlement 的治理原則。
>
> • MVP 階段採 Modular Monolith 模組化單體，不提前拆成微服務。

## 30.2 主 PRD 與分冊文件關係

| **文件**              | **定位**                  | **管理內容**                                                                              |
|-----------------------|---------------------------|-------------------------------------------------------------------------------------------|
| 主 PRD                | 產品主線                  | 產品定位、MVP 範圍、Roadmap、商業模式、角色策略、部署策略、模組藍圖。                     |
| 架構治理文件          | 開發規則與技術治理        | Core / Module 分層、module_entitlements、Feature Flag、事件目錄、依賴規則、模組開發門檻。 |
| Referral 模組文件     | 應用場景與通路分潤模組    | 合夥人、Referral Link / QR Code、來源歸屬、成交追蹤、分潤規則、Partner 後台。             |
| Lead Console 模組文件 | v1 MVP 功能與資料欄位分支 | 客戶、網站、表單、名單、通知、嵌入、方案額度、操作頁面與資料欄位。                        |

## 30.3 模組化平台核心架構

LOHAShare AI Platform

│

├─ Core 基礎底座｜必備

│ ├─ customers / sites / users / roles

│ ├─ plans / subscriptions / module_entitlements

│ ├─ activity_logs / usage_logs / notification_core

│ └─ allowed_domains / embed authorization

│

├─ Lead Core｜第一個業務底座

│ ├─ forms / leads / lead_notes / lead_sources

│ └─ lead_status / CSV export / basic tracking

│

├─ Optional Modules｜可選配模組

│ ├─ Referral

│ ├─ AI FAQ / AEO

│ ├─ Booking

│ ├─ Landing Page

│ ├─ GBP

│ ├─ AI Proposal

│ └─ AI Report

## 30.4 模組依賴原則

> • 每個模組可以依賴 Core，但不得任意硬綁其他選配模組。
>
> • Lead Core 是第一個業務底座；Referral 可依賴 Lead Core，但 AI FAQ / AEO 不應依賴 Referral。
>
> • 模組間資料交換優先透過共用 ID、事件、權限與訂閱控管，不直接互相寫死流程。
>
> • 每個模組都必須能定義單獨價值與組合後的加乘價值。
>
> • 新增模組前必須建立 Module Manifest，確認依賴、資料表、事件、權限、方案與驗收條件。

## 30.5 module_entitlements 必要性

v1.3 已提到每個網站可啟用不同模組，v1.4 進一步確認：未來若要支援模組選購、升級、停用、試用與方案差異，必須建立 module_entitlements 或同等資料結構。

| **欄位**                | **用途**                                               |
|-------------------------|--------------------------------------------------------|
| entitlement_id          | 模組啟用紀錄 ID                                        |
| customer_id             | 對應客戶                                               |
| site_id                 | 對應網站                                               |
| module_key              | 例如 lead_core / referral / aeo_faq / booking / report |
| status                  | trial / active / suspended / cancelled                 |
| plan_id                 | 對應方案                                               |
| started_at / expires_at | 啟用與到期時間                                         |
| usage_limit_json        | 該模組的用量限制與額度設定                             |

## 30.6 立即調整建議

> • 目前已開發內容不需要重做，但需補上 module_entitlements / feature_flags 的設計概念。
>
> • Referral 不應獨立另做成孤島，而應定位為 Lead Core 上方的標準模組。
>
> • Email 通知應升級為 Notification Core 的第一個 provider，不只當成單一寄信問題。
>
> • 方案與額度控管需從 plans / subscriptions 延伸到模組啟用層級。
>
> • 未來交給 Lovable / Replit / Claude 的開發提示詞，必須附上模組治理原則。

## 30.7 v1.4 後續文件版本關係

| **文件名稱**                                   | **建議版本** | **用途**                                               |
|------------------------------------------------|--------------|--------------------------------------------------------|
| LOHAShare AI 商務網站營運控制台 PRD            | v1.4         | 主 PRD，保留 v1.2 全文與 v1.3 增補，新增架構治理摘要。 |
| LOHAShare AI Platform 模組化架構與開發治理原則 | v1.0         | 單獨管理的架構治理憲法。                               |
| Nexus Lead Ops Referral MVP 產品規格書         | v1.0         | Referral / QR Code / 名單來源 / 分潤追蹤模組規格。     |
| Nexus Lead Ops MVP 功能清單與資料欄位表        | v1.1         | Lead Console / 表單名單核心功能與資料欄位規格。        |

# **v1.5 增補：命名層級與 Nexus Lead Ops 定位修正**

版本註記：基於 v1.4，新增命名層級架構圖與主 PRD / MVP / 模組 / 衍生文件關係說明。

本次更新目的：修正先前部分文件中把 Nexus Lead Ops 或 Lead & Notification Console 寫得過於接近「產品母體」的語境，正式確認其在主 PRD 底下的層級定位。

<img src="/mnt/data/LOHAShare_AI_Platform_P0_DOCX_to_MD_Backfill_Package_v0.1_20260604/docs/LOHAShare_AI_Platform/01_Architecture_Governance/04_Content_Quality_and_Consolidation/Current/assets/P0_DOCX_to_MD_Backfill_20260604/LOHAShare_AI_Business_Website_Operation_Console_PRD_v1.5_Naming_Hierarchy_Update_20260530/media/image1.png" style="width:6.4in;height:4.8in" />

圖：LOHAShare AI Platform 命名層級架構圖

## **正式命名層級**

| **層級** | **名稱**                                                                                                                 | **定位**                                         |
|----------|--------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| Level 0  | LOHAShare AI Platform                                                                                                    | 長期平台品牌與總體架構。                         |
| Level 1  | LOHAShare AI 商務網站營運控制台                                                                                          | 主 PRD / 主產品。                                |
| Level 2  | LOHAShare AI Lead & Notification Console MVP                                                                             | 第一個 MVP 實作版本，屬於主 PRD 底下的實作線。   |
| Level 3  | Lead Console、Email Notification、AI FAQ / AEO、Referral、Operator Dashboard、Client Portal、Billing / Commercialization | 功能模組或子系統。                               |
| Level 4  | Support Ticket、Fallback POC、Developer Prompt、Test Log、SOP、Release Note                                              | 模組衍生文件，用於實作、驗收、排錯、交付與維護。 |

## **本次修正後的核心規則**

• 主 PRD 不等於 Nexus Lead Ops。

• Nexus Lead Ops / Lead & Notification Console 屬於主 PRD 底下的實作線或子系統，不得取代主 PRD。

• 最早開發的是 MVP 模組，不是整個 LOHAShare AI Platform 一次完成。

• Referral、AI FAQ / AEO、Email Delivery、Fallback POC、Operator Dashboard、Client Portal、Billing / Commercialization 皆屬主 PRD 底下的模組、子系統或衍生文件。

• 未來任何新對話若將 Nexus Lead Ops 誤稱為主 PRD 或平台母體，應立即依本章修正。

## **對既有文件的影響**

• 涉及主產品定位、文件索引、跨對話交接、模組規格、Developer Prompt、POC 規格者，均需補充此命名層級。

• 涉及單次 Support / Incident / Test Log 的文件，若未錯置主 PRD 定位，可不重開主版本；但索引中需標示其 Level 4 層級。

• 文件放置位置仍依資料夾治理規則：主 PRD 放 00_Main_PRD；模組規格放 02_Modules；Prompt 放 05_Developer_Prompts；Support / Incident 放 04_Support_Knowledge_Base。
