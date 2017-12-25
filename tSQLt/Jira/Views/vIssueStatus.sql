CREATE VIEW Jira.vIssueStatus
AS
SELECT        ID, SEQUENCE, pname, DESCRIPTION, ICONURL, STATUSCATEGORY
FROM            jiraschema.issuestatus