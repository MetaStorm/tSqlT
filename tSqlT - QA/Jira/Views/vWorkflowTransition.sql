
CREATE VIEW Jira.vWorkflowTransition AS
SELECT W.workflowname Workflow,T.*
FROM [Jira].[jiraworkflows] W
CROSS APPLY Jira.GetWorkflowTransitions(convert(xml,cast([DESCRIPTOR] as varchar(max)),2)) T