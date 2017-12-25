CREATE VIEW Jira.vProjectWorkflowSchemeDraft
AS
SELECT        DWS.ID, PWS.ProjectID, PWS.ProjectKey, PWS.WorkflowSchemeName
FROM            jiraschema.draftworkflowscheme AS DWS INNER JOIN
                         Jira.vProjectWorkflowScheme AS PWS ON DWS.WORKFLOW_SCHEME_ID = PWS.WorkflowSchemeID