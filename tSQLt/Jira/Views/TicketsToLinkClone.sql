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
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Jira', @level1type = N'VIEW', @level1name = N'TicketsToLinkClone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[9] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[41] 4[34] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "LC"
            Begin Extent = 
               Top = 92
               Left = 325
               Bottom = 350
               Right = 488
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 18
               Left = 568
               Bottom = 227
               Right = 719
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ILI"
            Begin Extent = 
               Top = 16
               Left = 50
               Bottom = 231
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3435
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'Jira', @level1type = N'VIEW', @level1name = N'TicketsToLinkClone';

