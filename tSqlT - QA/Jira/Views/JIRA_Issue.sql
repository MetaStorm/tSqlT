
CREATE VIEW [Jira].[JIRA_Issue]
AS
SELECT        I.ID AS IssueID, ISNULL(P.pkey + N'-' + CAST(I.issuenum AS varchar(10)), N'') AS IssueKey, P.pkey AS Project, IT.pname AS IssueType, R.pname AS Resolution, 
                         IST.pname AS IssueStatus, I.TIMEESTIMATE, I.TIMEORIGINALESTIMATE, I.UPDATED AS UpdatedDate, I.CREATED AS CreatedDate
FROM            jiraschema.project AS P INNER JOIN
                         jiraschema.jiraissue AS I ON P.ID = I.PROJECT INNER JOIN
                         jiraschema.issuetype AS IT ON I.issuetype = IT.ID INNER JOIN
                         jiraschema.issuestatus AS IST ON I.issuestatus = IST.ID LEFT OUTER JOIN
                         jiraschema.resolution AS R ON I.RESOLUTION = R.ID