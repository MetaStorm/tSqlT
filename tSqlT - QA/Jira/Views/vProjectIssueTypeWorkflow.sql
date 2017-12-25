CREATE VIEW [Jira].[vProjectIssueTypeWorkflow] AS
WITH PITW AS
(
SELECT        ISNULL(p.pkey, N'') AS Project, ISNULL(it.pname, N'') AS IssueType, wse.WORKFLOW AS Workflow
FROM            jiraschema.project AS p LEFT OUTER JOIN
                         jiraschema.nodeassociation AS na ON na.SOURCE_NODE_ID = p.ID AND na.SINK_NODE_ENTITY = 'WorkflowScheme' LEFT OUTER JOIN
                         jiraschema.workflowscheme AS ws ON ws.ID = na.SINK_NODE_ID LEFT OUTER JOIN
                         jiraschema.workflowschemeentity AS wse ON wse.SCHEME = ws.ID LEFT OUTER JOIN
                         jiraschema.jiraworkflows AS jw ON jw.workflowname = wse.WORKFLOW LEFT OUTER JOIN
                         jiraschema.issuetype AS it ON it.ID = wse.issuetype
)
SELECT PIT.Project,PIT.IssueType,COALESCE(PITW.Workflow,PITWD.Workflow,'JIRA Workflow (jira)')Workflow
FROM [Jira].[vProjectIssueType] PIT
LEFT JOIN PITW ON PIT.Project = PITW.Project AND PIT.IssueType = PITW.IssueType
LEFT JOIN PITW PITWD ON PIT.Project = PITWD.Project AND PITWD.IssueType = ''