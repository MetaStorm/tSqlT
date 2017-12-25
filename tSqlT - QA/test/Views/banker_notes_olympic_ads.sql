CREATE VIEW test.banker_notes_olympic_ads AS
SELECT     B.ipbID, B.office, B.officer, B.olympicID, B.pershingID, B.segment, B.serviceUnit,U.cn AdsCN,OB.BankerStatus
FROM         [Notes].[Source_UOfficers] AS B 
LEFT OUTER JOIN ADS.[User] AS U ON B.ipbID = U.sAMAccountName
LEFT JOIN DataHub.olympic.[vBanker:FDBTAB] OB ON B.olympicID = OB.BankerID
--WHERE     (B.office = N'miami')