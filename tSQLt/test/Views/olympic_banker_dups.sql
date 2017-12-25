CREATE VIEW test.olympic_banker_dups AS
SELECT        BankerID AS [Account Number], CONVERT(date, GETDATE()) AS Date, BankerName, ManagementGroupID, ManagementGroupName
FROM            DataHub.DIT.olympic_banker_dups