文件名稱：**LOHAShare Email Fallback Provider POC 決策紀錄**

版本：v0.1

日期：2026-05-30

專案：LOHAShare Email Fallback Provider Test Console

工具：Replit

Provider：Resend



一、背景

Nexus Lead Ops / Lovable / Supabase 專案目前等待 Lovable Support / Mailgun 排查 Email delivery 問題。

因 production 系統顯示 sent / accepted，但 Gmail、Zoho、Yahoo 等收件端未必收到，因此建立獨立 Replit POC 工具測試不同 Email provider。



二、本次測試內容

本次測試使用 Replit 建立 Email Fallback Provider Test Console。

測試 provider 為 Resend。

From Email 使用：LOHAShare Test <onboarding@resend.dev>

Recipient 使用：yuehsir@gmail.com

Mailbox Type：Gmail



三、測試結果

1\. Replit 工具可正常登入。

2\. ADMIN\_ACCESS\_TOKEN 安全機制可正常使用。

3\. RESEND\_API\_KEY 與 RESEND\_FROM\_EMAIL 可由 Replit Secrets 讀取。

4\. Replit 可成功呼叫 Resend API。

5\. Resend 回傳 accepted。

6\. Message ID 正常產生。

7\. Gmail 實際收到測試信。

8\. Test History 狀態已修正為 Success。

9\. Manual Result 可標記實際收件結果。

10\. CSV 匯出成功。



四、重要限制

1\. 本次使用 onboarding@resend.dev，屬於 Resend 測試寄件網域。

2\. Resend 目前只允許寄給帳號本人 yuehsir@gmail.com。

3\. 本次尚未驗證 LOHAShare 自有測試子網域。

4\. 本次尚未測試 Yahoo、Zoho、Outlook。

5\. 本次尚未測試 SMTP、Postmark、ZeptoMail。

6\. 本次結果不能直接視為 production fallback 已成立。



五、目前決策

Resend adapter 與 Replit Email Test Console v0.1 已通過第一階段 POC。

此工具可繼續作為 Email fallback provider 測試與排查工具。



六、下一步

1\. 完成 Resend Test 002 重複測試。

2\. 測試 CSV 是否能完整保存 Success / Accepted / Inbox Received。

3\. 評估是否測試 SMTP。

4\. 後續再規劃獨立測試子網域，例如 resend-test.lohashare.com，但暫不修改 notify.lohashare.com 或 Mailgun production 主線。

