CREATE VIEW [test].[olympic_missing_cost_account]AS
WITH   C
AS     (SELECT CLI.CLRACI AS [Root],
               CLI.CLETAT AS [Status],
               CLI.CLGRPE AS [Group],
               CLI.CLTYPE AS [Type],
               CLI.CLGEST AS ManagementType,
               CLI.CLGRPG AS ManagementGroup,
               CLI.CLNOM AS Name,
               CLI.CLGERA AS RelationshipManager,
               CLI.clcent AS BookingUnit,
               CONVERT (DATETIME, STUFF(STUFF(CLI.CLDTOU, 3, 0, '/'), 6, 0, '/'), 3) AS DateOpen,
               CASE WHEN CLI.CLDTAN = '000000'
                         OR CLI.CLDTAN = '' THEN '1/1/1900' ELSE CONVERT (DATETIME, STUFF(STUFF(CLI.CLDTAN, 3, 0, '/'), 6, 0, '/'), 3) END AS DateClose,
               CLI.CLDTAN
        FROM   OLYMPIC.FDBCLI AS CLI),
       T
AS     (SELECT DOCLIR AS Root,
               DOCLIS AS Sequence,
               CONVERT (DATETIME, STUFF(STUFF(DODTOU, 3, 0, '/'), 6, 0, '/'), 3) AS Date_OU,
               CPCRAC + '-' + CPCGRE + '-' + CPCRUB + '-' + CPCMON AS CapitalAccount,
               CPIRAC + '-' + CPIGRE + '-' + CPIRUB + '-' + CPIMON AS InterestAccount,
               CPRRAC + '-' + CPRGRE + '-' + CPRRUB + '-' + CPRMON AS IncomeAccount,
               CPFRAC + '-' + CPFGRE + '-' + CPFRUB + '-' + CPFMON AS CostAccount_Gain,
               CPPRAC + '-' + CPPGRE + '-' + CPPRUB + '-' + CPPMON AS CostsAccount_Loss
        FROM   olympic.FDBDOS AS DOS
               INNER JOIN
               C AS CA
               ON CA.Root = DOS.DOCLIR
        WHERE  DOS.DOETAT <> 'A'),
       P
AS     (SELECT T.Root,
               T.Sequence,
               T.Date_OU,
               T.CapitalAccount,
               T.InterestAccount,
               T.IncomeAccount,
               T.CostAccount_Gain,
               T.CostsAccount_Loss,
               C.Status AS CostAccount_Gain_Status
        FROM   T
               LEFT OUTER JOIN
               C
               ON C.Root = LEFT(T.CostAccount_Gain, 7))
SELECT P.Root AS [Account Number],
       CAST (GETDATE() AS DATE) AS Date,
       P.Sequence AS Portfolio,
       CostAccount_Gain,
       CostAccount_Gain_Status,
       C.Status AS RootStatus,
       ISNULL(SMG.Description, C.ManagementGroup) AS [Management Group],
			 C.Type,
			 C.ManagementType
FROM   P
       INNER JOIN
       C
       ON P.Root = C.Root
       LEFT OUTER JOIN
       MIS.SourceManagementGroup AS SMG
       ON C.ManagementGroup = SMG.Code
WHERE  C.Status <> 'A'
       AND (ISNULL(CostAccount_Gain, '') = '' OR CostAccount_Gain_Status = 'A');