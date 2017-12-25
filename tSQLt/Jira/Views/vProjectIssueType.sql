CREATE VIEW Jira.vProjectIssueType
AS
SELECT        ISNULL(P.pkey, N'') AS Project, ISNULL(IT.pname, N'') AS IssueType, P.ID AS ProjectID, IT.ID AS IssueTypeID
FROM            jiraschema.project AS P INNER JOIN
                         jiraschema.configurationcontext AS CC ON P.ID = CC.PROJECT INNER JOIN
                         jiraschema.fieldconfigschemeissuetype AS FCI ON FCI.FIELDCONFIGSCHEME = CC.FIELDCONFIGSCHEME INNER JOIN
                         jiraschema.optionconfiguration AS OC ON OC.FIELDCONFIG = FCI.FIELDCONFIGURATION INNER JOIN
                         jiraschema.issuetype AS IT ON IT.ID = OC.OPTIONID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Jira', @level1type = N'VIEW', @level1name = N'vProjectIssueType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'ut = 720
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
', @level0type = N'SCHEMA', @level0name = N'Jira', @level1type = N'VIEW', @level1name = N'vProjectIssueType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
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
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "P"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CC"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 453
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FCI"
            Begin Extent = 
               Top = 6
               Left = 491
               Bottom = 135
               Right = 703
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC"
            Begin Extent = 
               Top = 6
               Left = 741
               Bottom = 135
               Right = 911
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "IT"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
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
         Column = 2310
         Alias = 1005
         Table = 1170
         Outp', @level0type = N'SCHEMA', @level0name = N'Jira', @level1type = N'VIEW', @level1name = N'vProjectIssueType';

