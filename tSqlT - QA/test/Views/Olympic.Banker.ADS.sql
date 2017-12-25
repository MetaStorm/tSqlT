CREATE VIEW test.[Olympic.Banker.ADS] AS
SELECT     B.ipbID, B.office, B.officer, B.olympicID, B.pershingID, B.segment, B.serviceUnit
FROM         test.Banker AS B LEFT OUTER JOIN
                      ADS.[User] AS U ON B.ipbID = U.sAMAccountName
WHERE     (B.office = N'miami')