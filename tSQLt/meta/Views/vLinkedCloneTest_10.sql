CREATE VIEW meta.vLinkedCloneTest_10
AS
SELECT        TA.ID, TA.Project, TA.IssueType, TA.StatusFrom + '=>' + TA.StatusTo AS Transition, TA.Action, P.Project AS ProjectMissing, PIT.IssueType AS IssueTypeMissing, 
                         PITWT.StepFrom + '=>' + PITWT.StepTo AS TransitionMissing, CASE WHEN TA.Action > '' THEN A.FullName ELSE 'OK' END AS ActionMissing
FROM            Jira.LinkedClone AS TA LEFT OUTER JOIN
                         Jira.Project AS P ON TA.Project = P.Project COLLATE SQL_Latin1_General_CP1_CI_AS LEFT OUTER JOIN
                         Jira.ProjectIssueTypeWorkflowTransition AS PITWT ON TA.StatusTo = PITWT.StepTo AND TA.StatusFrom = PITWT.StepFrom AND 
                         TA.IssueType COLLATE SQL_Latin1_General_CP437_CI_AI = PITWT.IssueType AND 
                         TA.Project COLLATE SQL_Latin1_General_CP437_CI_AI = PITWT.Project LEFT OUTER JOIN
                         Jira.ProjectIssueType AS PIT ON TA.Project = PIT.Project COLLATE SQL_Latin1_General_CP1_CI_AS AND 
                         TA.IssueType = PIT.IssueType COLLATE SQL_Latin1_General_CP1_CI_AS LEFT OUTER JOIN
                         meta.Action AS A ON TA.Action = A.FullName
WHERE        (TA.IsActive = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'meta', @level1type = N'VIEW', @level1name = N'vLinkedCloneTest_10';

