CREATE PROCEDURE test.sRemoveDuplicates AS
WITH cte
     AS (SELECT ROW_NUMBER() OVER (PARTITION BY T.CRC ORDER BY ( SELECT 0)) RN
         FROM   [temp].[AllBahamasWithMiami] T)
DELETE FROM cte
WHERE  RN > 1;