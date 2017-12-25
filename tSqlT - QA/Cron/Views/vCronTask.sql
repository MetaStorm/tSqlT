CREATE VIEW Cron.vCronTask
AS
SELECT        T.GroupName, T.JobName, T.TaskName, T.TaskTime, T.IsActive AS TaskActive, J.IsActive AS JobActive, T.ExitCodeResult AS ExitCode, T.Status, 
                         T.DateLastExecution, T.ExecutionSeconds AS Seconds, T.ExecutionHours AS Hours, FT.TaskError, T.CmdLine, T.CmdArguments
FROM            Cron.CronTask AS T INNER JOIN
                         Cron.CronJob AS J ON T.GroupName = J.GroupName AND T.JobName = J.JobName LEFT OUTER JOIN
                         Cron.CronFailedTask AS FT ON T.TaskName = FT.TaskName AND T.GroupName = FT.GroupName AND T.JobName = FT.JobName