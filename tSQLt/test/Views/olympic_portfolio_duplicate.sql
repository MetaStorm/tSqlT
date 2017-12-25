CREATE VIEW test.olympic_portfolio_duplicate AS
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
WHERE DOS.DOETAT <> 'A' AND C.CLETAT <> 'A'
), D AS
(
SELECT Root,Sequence,CostAccount_Gain
FROM SRS
GROUP BY Root,CostAccount_Gain,Sequence
HAVING COUNT(*) > 1
)
SELECT P.* 
FROM SRS P INNER JOIN D ON P.Root = D.Root AND P.Sequence = D.Sequence AND P.CostAccount_Gain = D.CostAccount_Gain