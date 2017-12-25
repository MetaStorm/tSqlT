
CREATE VIEW [Jira].[JIRA_LinkedIssue]
AS
SELECT     ISRS.IssueID AS IssueIDSrc, ISRS.IssueKey AS IssueKeySrc, ISRS.Project AS ProjectSrc, ISRS.IssueType AS IssueTypeSrc, IDEST.IssueID AS IssueIDDest, 
                      IDEST.IssueKey AS IssueKeyDest, IDEST.Project AS ProjectDest, IDEST.IssueType AS IssueTypeDest
FROM         jiraschema.issuelink AS IL LEFT OUTER JOIN
                      Jira.JIRA_Issue AS IDEST ON IL.DESTINATION = CAST(IDEST.IssueID AS varchar(30)) LEFT OUTER JOIN
                      Jira.JIRA_Issue AS ISRS ON IL.SOURCE = CAST(ISRS.IssueID AS varchar(30))