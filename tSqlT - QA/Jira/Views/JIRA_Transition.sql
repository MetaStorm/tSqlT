
CREATE VIEW [Jira].[JIRA_Transition]
AS
SELECT        I.IssueID, I.IssueKey, I.Project, I.IssueType, CAST(CI.OLDSTRING AS nvarchar(128)) AS StatusFrom, ISNULL(CAST(CI.NEWSTRING AS nvarchar(128)), I.IssueStatus) 
                         AS StatusTo, CG.AUTHOR, ISNULL(CG.CREATED, I.CreatedDate) AS TransitionDate
FROM            Jira.JIRA_Issue AS I LEFT OUTER JOIN
                         jiraschema.changegroup AS CG ON I.IssueID = CG.issueid LEFT OUTER JOIN
                         jiraschema.changeitem AS CI ON CG.ID = CI.groupid AND CI.FIELDTYPE = 'jira' AND CI.FIELD = 'status'