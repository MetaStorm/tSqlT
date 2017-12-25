
CREATE VIEW [test].[CronHandledTask]AS
SELECT        TOP (10000) CONVERT(varchar(MAX), CAST(CHECKSUM(Subject) AS varbinary(30)), 2) AS [Account Number], TaskTime, Subject, Project, IssueType, Assignee, 
                         Description
FROM            Cron.vCronTaskTest
WHERE        (IsICEed = 1)