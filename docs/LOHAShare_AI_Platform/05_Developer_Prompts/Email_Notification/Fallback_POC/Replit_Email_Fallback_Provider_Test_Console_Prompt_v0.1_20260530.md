我現在要建立一個新的 Replit 工具，名稱暫定為：



《**LOHAShare Email Fallback Provider Test Console**》



背景：

目前 LOHAShare 的 Nexus Lead Ops / Lovable / Supabase 專案正在等待 Lovable Support / Mailgun 排查 Email delivery 問題。現況是系統或 provider 顯示 sent / accepted，但 Gmail、Zoho、Yahoo 等收件端未必收到信件。



重要限制：

請不要建議我現在修改現有 Lovable production 專案。

請不要修改 notify.lohashare.com DNS。

請不要修改 Mailgun / Lovable Emails 主線。

請不要修改 dispatchLeadNotification、process-email-queue、pgmq queue、email\_send\_log。

這個工具只做獨立 POC，不接入正式 production。



目標：

請協助我撰寫一份可直接貼給 Replit 的開發提示詞，用來建立一個獨立的 Email Provider Test Console。



這個 Replit 工具需要支援：



1\. 測試不同 Email provider 的寄信能力

2\. 可輸入收件人 Email

3\. 可輸入寄件標題

4\. 可輸入信件內容

5\. 可選擇 provider，例如 Resend、ZeptoMail、Postmark、SMTP，先以可擴充架構設計

6\. 可記錄每次寄信測試結果

7\. 可顯示 provider response

8\. 可標記測試收件端，例如 Gmail、Yahoo、Zoho、Outlook

9\. 可記錄測試時間

10\. 可匯出測試紀錄

11\. 不儲存敏感 API Key 到前端

12\. API Key 必須使用 Replit Secrets / Environment Variables

13\. 前端要簡單清楚，適合非工程人員操作

14\. 後端要有清楚的 provider adapter 架構，方便未來加入更多 provider

15\. 這個工具的目的不是取代 Lovable，而是作為 Email fallback provider POC 與排查工具



請輸出：



1\. Replit 專案定位

2\. MVP 功能範圍

3\. 不做事項

4\. 建議技術架構

5\. Provider Adapter 架構

6\. 資料欄位設計

7\. UI 頁面需求

8\. 安全注意事項

9\. 測試情境

10\. 可直接貼給 Replit 的完整開發 Prompt v0.1



請用繁體中文整理，並且最後提供一份「可以直接複製貼到 Replit AI Agent」的完整提示詞。



