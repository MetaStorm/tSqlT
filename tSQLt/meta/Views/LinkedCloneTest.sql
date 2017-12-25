CREATE VIEW meta.LinkedCloneTest
AS
SELECT        ID, Project, IssueType, Transition, Action, ProjectMissing, IssueTypeMissing, TransitionMissing, ActionMissing
FROM            meta.vLinkedCloneTest_10 AS TAT
WHERE        (ISNULL(CAST(CASE WHEN ProjectMissing COLLATE SQL_Latin1_General_CP1_CI_AS + IssueTypeMissing COLLATE SQL_Latin1_General_CP1_CI_AS + TransitionMissing
                          COLLATE SQL_Latin1_General_CP1_CI_AS + ActionMissing COLLATE SQL_Latin1_General_CP1_CI_AS IS NULL THEN 1 ELSE 0 END AS bit), 0) = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'meta', @level1type = N'VIEW', @level1name = N'LinkedCloneTest';

