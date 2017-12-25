CREATE VIEW Jira.vProjectIssueType
AS
SELECT        ISNULL(P.pkey, N'') AS Project, ISNULL(IT.pname, N'') AS IssueType, P.ID AS ProjectID, IT.ID AS IssueTypeID
FROM            jiraschema.project AS P INNER JOIN
                         jiraschema.configurationcontext AS CC ON P.ID = CC.PROJECT INNER JOIN
                         jiraschema.fieldconfigschemeissuetype AS FCI ON FCI.FIELDCONFIGSCHEME = CC.FIELDCONFIGSCHEME INNER JOIN
                         jiraschema.optionconfiguration AS OC ON OC.FIELDCONFIG = FCI.FIELDCONFIGURATION INNER JOIN
                         jiraschema.issuetype AS IT ON IT.ID = OC.OPTIONID