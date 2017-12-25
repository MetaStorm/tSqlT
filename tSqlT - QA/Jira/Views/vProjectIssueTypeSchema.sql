CREATE VIEW [Jira].[vProjectIssueTypeSchema]
AS
     SELECT isnull(CC.PROJECT, 0) AS ProjectId,
            isnull(CC.FIELDCONFIGSCHEME, 0) AS IssueTypeSchemaId,
            FCS.configname AS IssueTypeSchemaName,
            jiraschema.project.pname AS ProjectName,
            jiraschema.project.pkey AS ProjectKey
     FROM jiraschema.configurationcontext AS CC
          INNER JOIN jiraschema.fieldconfigscheme AS FCS ON CC.FIELDCONFIGSCHEME = FCS.ID
          INNER JOIN jiraschema.project ON CC.PROJECT = jiraschema.project.ID
     WHERE(CC.customfield = N'issuetype')
          AND (FCS.FIELDID = N'issuetype');