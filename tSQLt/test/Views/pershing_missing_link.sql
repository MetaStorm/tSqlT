
CREATE VIEW [test].[pershing_missing_link] AS
WITH  D AS
(SELECT n.NURACI,
                       n.NUREFE
                FROM   olympic.FDBNUM AS n
                WHERE  (n.NUTYPE IN ('202', '212', '219'))
                       AND (n.NUETAT <> 'A')
), E AS
(SELECT   SUBSTRING(AccountNumber,1,9)AccountNumber,
                         COUNT(*) AS PositionCount
                FROM     Pershing.[GCUS.A]
                WHERE    (DateOfData = (SELECT MAX(DateOfData) AS Expr1
                                        FROM   Pershing.[GCUS.A] AS p1))
                GROUP BY SUBSTRING(AccountNumber,1,9))
,   O AS     
(SELECT aa.AccountNumber,
               aa.AccountStatusIndicator,
               D.NURACI AS OlympicAccount,
               B.BankLinkDDANumber,
							 I.CustomFieldDetailText3,
               E.PositionCount
        FROM   Pershing.[ACCT_ACCF.A] AS aa
               LEFT OUTER JOIN D               
               ON aa.AccountNumber = LTRIM(RTRIM(D.NUREFE))
               INNER JOIN E
               ON aa.AccountNumber = SUBSTRING(E.AccountNumber, 1, 9)
							 LEFT JOIN [Pershing].[ACCT_ACCF.B] B
							 ON aa.AccountNumber = B.AccountNumber
							 LEFT JOIN [Pershing].[ACCT_ACCF.I] I
							 ON aa.AccountNumber = I.AccountNumber
        WHERE  (SUBSTRING(aa.AccountNumber, 1, 3) IN ('JT1', 'JT2', 'JTU', 'JT9'))
               AND (aa.AccountStatusIndicator <> 'C')
               AND (aa.AccountNumber NOT IN ('JT1000000', 'JT2000000', 'JT9000000', 'JTU000000'))
               AND (D.NURACI IS NULL)
)
SELECT AccountNumber+'/'+RTRIM(CustomFieldDetailText3)+'/'+BankLinkDDANumber AS [Account Number],
       CAST (DATEADD(dd, 0, GETDATE()) AS DATE) AS Date,
			 OlympicAccount,
       AccountStatusIndicator,
       PositionCount
FROM   O AS ORPH
--ORDER BY [Account Number];