
CREATE VIEW [Jira].[ProjectIssueTypeWorkflowTransition]AS
SELECT        PITWS.Project, PITWS.IssueType, PITWS.Step AS StepFrom, WT.StepTo
FROM            Jira.ProjectIssueTypeWorkflowStep AS PITWS INNER JOIN
                         Jira.WorkflowTransition AS WT ON PITWS.Workflow  collate SQL_Latin1_General_CP1_CI_AS = WT.Workflow AND PITWS.Step = WT.StepFrom