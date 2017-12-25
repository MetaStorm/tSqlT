
CREATE VIEW [meta].[vTestTableJiraSettings_10]AS
SELECT  TA.TableName,     TA.Project, TA.IssueType,  P.Project AS ProjectMissing, PIT.IssueType AS IssueTypeMissing
                         
FROM           [meta].[TestTableJiraSettings] AS TA 
LEFT OUTER JOIN
                         Jira.Project AS P ON TA.Project = P.Project COLLATE SQL_Latin1_General_CP1_CI_AS

												 LEFT OUTER JOIN                         Jira.ProjectIssueType AS PIT ON TA.Project = PIT.Project COLLATE SQL_Latin1_General_CP1_CI_AS AND 
                         TA.IssueType = PIT.IssueType COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE        (TA.IsActive = 1)