
CREATE VIEW [Jira].[JIRA_Issue_LinkedIssue]
AS
SELECT        I.IssueID, I.IssueKey, I.Project, I.IssueType, ISNULL(LIS.IssueIDDest, LID.IssueIDSrc) AS IssueIDLinked, ISNULL(LIS.IssueKeyDest, LID.IssueKeySrc) 
                         AS IssueKeyLinked, ISNULL(LIS.ProjectDest, LID.ProjectSrc) AS ProjectLinked, ISNULL(LIS.IssueTypeDest, LID.IssueTypeSrc) AS IssueTypeLinked
FROM            Jira.JIRA_Issue AS I LEFT OUTER JOIN
                         Jira.JIRA_LinkedIssue AS LIS ON I.IssueID = LIS.IssueIDSrc LEFT OUTER JOIN
                         Jira.JIRA_LinkedIssue AS LID ON I.IssueID = LID.IssueIDDest