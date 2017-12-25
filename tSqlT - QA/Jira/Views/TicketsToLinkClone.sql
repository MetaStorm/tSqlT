CREATE VIEW Jira.TicketsToLinkClone
AS
SELECT        TOP (100) PERCENT T.IssueKey, T.Project, T.IssueType, T.StatusFrom, T.StatusTo, T.TransitionDate, ISNULL(LC.ProjectCreate, LC.Project) AS ProjectCreate, 
                         LC.IssueTypeCreate, LC.CustomFields, LC.IsActive
FROM            Jira.LinkedClone AS LC INNER JOIN
                         Jira.JIRA_Transition AS T ON LC.Project COLLATE SQL_Latin1_General_CP437_CI_AI = T.Project AND 
                         LC.IssueType COLLATE SQL_Latin1_General_CP437_CI_AI = T.IssueType AND LC.StatusFrom COLLATE SQL_Latin1_General_CP437_CI_AI = T.StatusFrom AND 
                         LC.StatusTo COLLATE SQL_Latin1_General_CP437_CI_AI = T.StatusTo LEFT OUTER JOIN
                         Jira.JIRA_Issue_LinkedIssue AS ILI ON T.IssueKey = ILI.IssueKey AND LC.ProjectCreate = ILI.ProjectLinked COLLATE SQL_Latin1_General_CP1_CI_AS AND 
                         LC.IssueTypeCreate = ILI.IssueTypeLinked COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE        (ILI.IssueKeyLinked IS NULL)