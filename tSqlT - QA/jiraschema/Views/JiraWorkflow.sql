CREATE VIEW jiraschema.JiraWorkflow
AS
SELECT        ISNULL(workflowname, '') AS WorkflowName, DESCRIPTOR
FROM            jiraschema.jiraworkflows