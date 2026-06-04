**LOHAShare AI Platform**

**LOHAShare DocOps MVP n8n Workflow 建置提示詞 v0.1**

給 n8n / Replit / AI 工具使用的第一版文件自動化工作流建置指令

| **欄位** | **內容**                                                                        |
|----------|---------------------------------------------------------------------------------|
| 版本     | v0.1                                                                            |
| 狀態     | Developer Prompt                                                                |
| 產出日期 | 2026-05-30                                                                      |
| 文件目的 | 將自動化策略、文件治理、工程備援、Support KB 與 DocOps MVP 建立一致的執行方向。 |

# 1. 使用目的

本提示詞用於建立 LOHAShare AI Platform DocOps MVP。目標是透過 n8n 建立「新增模組文件包」與「新增 Support / Incident 紀錄」的自動化工作流。

# 2. 可直接使用的建置提示詞

> 請協助建立 LOHAShare AI Platform DocOps MVP 的 n8n workflow。  
>   
> 目標：  
> 當使用者透過表單輸入新模組或新支援事件時，n8n 自動建立標準資料夾與 Markdown 文件模板，並產生通知與文件索引草稿。  
>   
> Workflow A：新增模組文件包  
> 輸入欄位：  
> - module_name_zh  
> - module_code_en  
> - module_type  
> - roadmap_phase  
> - dependencies  
> - owner  
> - billing_module_yes_no  
> - initial_status  
> - notes  
>   
> 輸出：  
> - docs/02-modules/{module_code}/README.md  
> - docs/02-modules/{module_code}/PRD.md  
> - docs/02-modules/{module_code}/DATA_MODEL.md  
> - docs/02-modules/{module_code}/UI_SPEC.md  
> - docs/02-modules/{module_code}/TEST_CHECKLIST.md  
> - docs/02-modules/{module_code}/CHANGELOG.md  
> - docs/02-modules/{module_code}/prompts/lovable-build-prompt.md  
> - docs/02-modules/{module_code}/prompts/claude-review-prompt.md  
>   
> Workflow B：新增 Support / Incident 紀錄  
> 輸入欄位：  
> - incident_title  
> - platform  
> - related_module  
> - severity  
> - current_status  
> - summary  
> - ticket_url  
> - occurred_at  
> - owner  
>   
> 輸出：  
> - docs/04-support-knowledge-base/{platform}/support-ticket-log.md  
> - docs/04-support-knowledge-base/email-delivery/incident-log.md  
> - docs/04-support-knowledge-base/known-issues-faq/pending-faq.md  
>   
> 限制：  
> - 不得自動覆蓋主 PRD。  
> - 不得自動刪除任何文件。  
> - 所有產出狀態預設為 Draft Generated。  
> - 需要人工審核後才能標示 Approved 或 Stable。  
>   
> 請提供：  
> 1. n8n 節點清單  
> 2. 每個節點設定說明  
> 3. Google Drive / GitHub / OpenAI credential 需求  
> 4. 範例資料  
> 5. 錯誤處理流程  
> 6. 人工審核節點設計  
> 7. 後續可擴充到 GitHub Actions 的建議。

# 3. n8n 節點建議

| **節點**                             | **用途**                                  |
|--------------------------------------|-------------------------------------------|
| Manual Trigger / Google Form Trigger | 啟動新增模組或新增事件流程                |
| Set / Edit Fields                    | 整理輸入欄位與標準命名                    |
| IF / Switch                          | 判斷文件類型：Module / Support / Incident |
| Google Drive Node                    | 建立正式文件資料夾或草稿文件              |
| GitHub Node                          | 建立 Markdown 文件，第二階段啟用          |
| OpenAI Node                          | 產生 README / PRD / FAQ 草稿              |
| Email / LINE / Slack Node            | 通知負責人審核                            |

# 4. 審核與安全規則

- 所有自動產出文件狀態預設 Draft Generated。

- 系統只建立，不覆蓋。

- 正式文件版本號由人工確認。

- Support 事件可自動建檔，但根因分析必須由人工補上。

- Email provider 切換不得由 n8n 自動執行，除非未來有明確授權與 rollback 機制。
