CREATE VIEW [Cron].[vCronTaskTest]
AS
     WITH T
          AS (
          SELECT T.TaskTime,
                 T.GroupName+'/'+T.JobName+'/'+T.TaskName AS Subject,
                 COALESCE(T.Project, J.Project, G.Project) AS Project,
                 COALESCE(T.IssueType, J.IssueType, G.IssueType) AS IssueType,
                 COALESCE(T.Assignee, J.Assignee, G.Assignee) AS Assignee,
                 FT.TaskError AS Description,
                 CAST(CASE
                          WHEN ID IS NULL
                          THEN 0
                          ELSE 1
                      END AS BIT) AS IsError
          FROM Cron.CronJob AS J
               INNER JOIN Cron.CronTask AS T ON J.GroupName = T.GroupName
                                                AND J.JobName = T.JobName
               INNER JOIN Cron.CronGroup AS G ON J.GroupName = G.GroupName
               LEFT OUTER JOIN Cron.CronFailedTask AS FT ON T.TaskName = FT.TaskName
                                                            AND T.GroupName = FT.GroupName
                                                            AND T.JobName = FT.JobName)
          SELECT TOP 100000 CONVERT(VARCHAR(MAX), CAST(CHECKSUM(Subject) AS VARBINARY(30)), 2) [Account Number],
                            *,
                            CAST(CASE
                                     WHEN Assignee IS NULL
                                          OR Project IS NULL
                                          OR IssueType IS NULL
                                     THEN 0
                                     ELSE 1
                                 END AS BIT) IsICEed
          FROM T
          ORDER BY Subject;