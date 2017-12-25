CREATE VIEW [test].[olympic_portfolio_capital_duplicate] AS
WITH SRS AS
(
SELECT
  DOCLIR Root
, DOCLIS Sequence
, CONVERT(datetime,STUFF(STUFF(DODTOU,3,0,'/'),6,0,'/'),3) Date_OU
, CPCRAC+'-'+CPCGRE+'-'+CPCRUB+'-'+CPCMON CapitalAccount
, CPIRAC+'-'+CPIGRE+'-'+CPIRUB+'-'+CPIMON InterestAccount
, CPRRAC+'-'+CPRGRE+'-'+CPRRUB+'-'+CPRMON IncomeAccount 
, CPFRAC+'-'+CPFGRE+'-'+CPFRUB+'-'+CPFMON CostAccount_Gain
, CPPRAC+'-'+CPPGRE+'-'+CPPRUB+'-'+CPPMON CostsAccount_Loss
FROM olympic.FDBDOS DOS
INNER JOIN olympic.FDBCLI C ON DOS.DOCLIR = C.CLRACI
WHERE DOS.DOETAT <> 'A' AND C.CLETAT <> 'A' AND C.CLRACI > '5000000'
), D AS
(
SELECT Root,CapitalAccount
FROM SRS
GROUP BY Root,CapitalAccount
HAVING COUNT(*) > 1
)
SELECT P.* 
FROM SRS P INNER JOIN D ON P.Root = D.Root AND P.CapitalAccount = D.CapitalAccount
--WHERE P.Root = '5001067'