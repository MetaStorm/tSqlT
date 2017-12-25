
CREATE VIEW [test].[olympic_rm_missing] AS
SELECT Root AS [Account Number], CAST(DATEADD(dd,0,GETDATE()) AS date) Date, Status, [Group], ClientType, ManagementType, ManagementGroup, RMID, RMStatus, RMMG
, MGAsRM, MGAsBStatus, RMName, IsRMOk, IsRMMGOk, HasMGAsRMOk, IsMGAsRMOk
FROM test.client_banker_managementgroup
WHERE (IsRMOk = 0)