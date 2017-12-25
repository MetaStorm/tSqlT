CREATE VIEW [Jira].[ProjectIssueTypeWorkflowStep] AS
SELECT DISTINCT RITW.Project, ISNULL(NULLIF(RITW.IssueType,''),PIT.IssueType)IssueType, RITW.Workflow,WS.Step
FROM            Jira.vProjectIssueTypeWorkflow AS RITW INNER JOIN
                         Jira.WorkflowStep AS WS ON RITW.Workflow collate SQL_Latin1_General_CP1_CI_AS = WS.Workflow
					inner join Jira.vProjectIssueType PIT ON PIT.Project collate SQL_Latin1_General_CP1_CI_AS = RITW.Project
--where RITW.Project='DIT' AND RITW.IssueType = ''
--ORDER BY RITW.IssueType DESC