CREATE VIEW [test].[olympic_custodian_with_balance] AS
SELECT Root [Account Number], CAST(GETDATE() AS date) Date, CONCAT(Custodian+':',SUM(BalanceOriginal)) Subject 
FROM [olympic].[vCustodianBalance] 
GROUP BY Root,Custodian
HAVING SUM(BalanceOriginal) <> 0