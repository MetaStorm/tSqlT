CREATE VIEW [test].[discrepancy_mail_address]
AS
WITH     D0
AS       (SELECT OlympicAccountNumber,
                 PershingAccountNumber,
                 DiscrepancyCode,
                 OlympicInformation,
                 PershingInformation,
                 [dbo].[fStripCharacters](OlympicInformation, '^a-z^0-9') AS O,
                 [dbo].[fStripCharacters](PershingInformation, '^a-z^0-9') AS P,
                 Comment,
                 DiscrepancyDate,
                 ExceptionDate,
                 ExceptionIndicator
          FROM   ClientDataSynchronization.Discrepancies AS D
          WHERE  (DiscrepancyCode = 3)
                 AND ExceptionIndicator = 1),
         D
AS       (SELECT ABS(dbo.LEVENSHTEIN(D.O, D.P)) AS Dist,
                 D.*
          FROM   D0 AS D
          WHERE  DiscrepancyCode = 3),
         D1
AS       (SELECT   OlympicAccountNumber,
                   PershingAccountNumber,
                   MAX(ExceptionDate) AS ExceptionDate,
                   MAX(DiscrepancyDate) AS DiscrepancyDate
          FROM     D0
          GROUP BY OlympicAccountNumber, PershingAccountNumber)
SELECT   DISTINCT TOP (100000) D.OlympicAccountNumber AS [Account Number],
                               D.ExceptionDate,
                               D.PershingAccountNumber AS [IIS Accounts],
                               OlympicInformation + '
' + PershingInformation AS Address,
                               D.DiscrepancyDate,
                               Dist
FROM     D
         INNER JOIN
         D1
         ON D.OlympicAccountNumber = D1.OlympicAccountNumber
            AND D.PershingAccountNumber = D1.PershingAccountNumber
            AND D.ExceptionDate = D1.ExceptionDate
            AND D.DiscrepancyDate = D1.DiscrepancyDate
WHERE    (Dist > 0)
ORDER BY Dist DESC, [Account Number];