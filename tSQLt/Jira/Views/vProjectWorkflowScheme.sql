CREATE VIEW Jira.vProjectWorkflowScheme
AS
SELECT        ISNULL(p.pkey, N'') AS ProjectKey, ws.NAME AS WorkflowSchemeName, p.ID AS ProjectID, ws.ID AS WorkflowSchemeID
FROM            jiraschema.project AS p LEFT OUTER JOIN
                         jiraschema.nodeassociation AS na ON na.SOURCE_NODE_ID = p.ID AND na.SINK_NODE_ENTITY = 'WorkflowScheme' LEFT OUTER JOIN
                         jiraschema.workflowscheme AS ws ON ws.ID = na.SINK_NODE_ID