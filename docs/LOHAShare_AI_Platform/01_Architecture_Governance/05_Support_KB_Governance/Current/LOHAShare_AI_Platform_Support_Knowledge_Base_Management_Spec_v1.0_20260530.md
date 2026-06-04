**LOHAShare AI Platform**

**Support Knowledge Base 管理規範**

支援單、事件、排錯筆記、已知問題 FAQ 與已解決案例之分類管理標準

**版本：v1.0｜產出日：2026-05-30**

# **1. 文件定位**

本文件是 LOHAShare AI Platform 文件治理體系中的 Support Knowledge Base 專章文件，負責定義與 Support Team 往來、Incident、排錯筆記、Known Issues FAQ、Resolved Cases 的紀錄方式與升級規則。

# **2. Support KB 的目的**

- 讓每一次外部平台支援往來可被追蹤。

- 讓每一次系統異常形成可複用的排錯資產。

- 讓重複問題沉澱為 FAQ，而不是散落在聊天紀錄。

- 讓已解決案例可回寫 SOP、模組規格或開發提示詞。

- 避免 Support/Debug 細節污染主 PRD。

# **3. Support KB 文件類型**

| **文件類型**         | **用途**                                                                               | **範例**                                                        |
|----------------------|----------------------------------------------------------------------------------------|-----------------------------------------------------------------|
| Support Ticket Log   | 紀錄與 Lovable、Mailgun、Supabase、Cloudflare、Duda/Oasis、Google 等外部支援團隊的往來 | Lovable_Mailgun_Email_Delivery_Support_Ticket_Log_20260530.docx |
| Incident Log         | 紀錄一次具體系統異常的範圍、嚴重程度、影響模組、時間軸與處理狀態                       | Email_Delivery_Incident_Log_Inbox_Visibility_20260530.docx      |
| Troubleshooting Note | 紀錄排查步驟、已確認事項、尚未確認事項與判讀邏輯                                       | Email_Delivery_Troubleshooting_Note_20260530.docx               |
| Known Issues FAQ     | 把可重複遇到或需要教育團隊的問題整理成 FAQ                                             | Email_Delivery_Known_Issues_FAQ_v1.0_20260530.docx              |
| Resolved Case        | 問題解決後，紀錄根因、解法、避免再發生措施與應回寫文件                                 | Resolved_Case_Mailgun_Inbox_Visibility_YYYYMMDD.docx            |

# **4. 建立 Support Log 的觸發條件**

- 已向外部平台 Support Team 發出詢問或 Ticket。

- 問題影響到名單通知、Email delivery、嵌入碼顯示、資料寫入、登入、權限或正式展示。

- 問題需要等待第三方回覆，狀態為 Pending External。

- 問題可能在未來其他客戶或模組重複發生。

- 需要將排查過程交接給工程師、AI 工具、外包或團隊成員。

# **5. Support Ticket Log 標準欄位**

| **欄位**                | **說明**                                                              |
|-------------------------|-----------------------------------------------------------------------|
| Ticket ID               | 外部平台提供的支援單編號，若尚未提供則填 Pending。                    |
| 平台 / Provider         | Lovable、Mailgun、Supabase、Cloudflare、Duda/Oasis、Google 等。       |
| 關聯模組                | 例如 Email Notification Module、Embed Module、Lead Console。          |
| 問題摘要                | 用一句話描述問題。                                                    |
| 目前狀態                | Open / Pending External / Awaiting User / Resolved / Closed。         |
| 嚴重程度                | Low / Medium / High / Critical。                                      |
| 已提供給 Support 的資訊 | 網域、Log、時間、錯誤訊息、測試收件端等。                             |
| Support 回覆摘要        | 每次回覆需附日期與重點。                                              |
| 下一步                  | 待對方確認、待補資料、待重測、待切換策略等。                          |
| 應回寫文件              | Module Spec、SOP、Known Issues FAQ、Architecture Governance、主 PRD。 |

# **6. Support KB 升級規則**

| **原始紀錄**         | **何時升級**                                | **升級到哪裡**          |
|----------------------|---------------------------------------------|-------------------------|
| Support Ticket Log   | 同類型問題重複發生或 Support 回覆具通用價值 | Known Issues FAQ        |
| Incident Log         | 排查流程穩定且可重複執行                    | SOP / QA Checklist      |
| Troubleshooting Note | 排查結果導致模組功能調整                    | Module Spec             |
| Resolved Case        | 解法成為未來預防措施                        | SOP + Developer Prompt  |
| 多次事件顯示架構風險 | 需要改變模組化規則或通知基礎建設            | Architecture Governance |

# **7. 建議資料夾**

> 04_Support_Knowledge_Base/  
> ├─ Email_Delivery_Support_Log/  
> ├─ Lovable_Support_Tickets/  
> ├─ Supabase_Issues/  
> ├─ Provider_Debug_History/  
> ├─ Known_Issues_FAQ/  
> └─ Resolved_Cases/
