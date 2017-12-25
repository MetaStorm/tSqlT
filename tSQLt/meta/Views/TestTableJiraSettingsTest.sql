
CREATE VIEW [meta].[TestTableJiraSettingsTest]AS
SELECT       TableName, Project, IssueType, ProjectMissing, IssueTypeMissing
FROM            [meta].[vTestTableJiraSettings_10] AS TAT
WHERE        (ISNULL(CAST(CASE WHEN ProjectMissing COLLATE SQL_Latin1_General_CP1_CI_AS + IssueTypeMissing COLLATE SQL_Latin1_General_CP1_CI_AS  IS NULL THEN 1 ELSE 0 END AS bit), 0) = 1)