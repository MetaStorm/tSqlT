CREATE VIEW test.swift_security_master
AS
SELECT        SecurityNumber AS [Account Number], LastDate AS Date, SecurityName AS Description
FROM            olympic.vSecurityMasterTest
WHERE        (IsOk = 0) AND (Status = '') AND (LastDate > CONVERT(DATETIME, '2017-04-01 00:00:00', 102))