

CREATE VIEW ReportServer.vReportInfo AS
SELECT Path
FROM [ReportServer].[Catalog] C
WHERE Type = 2;