CREATE TABLE [Cron].[CronFailedTask] (
    [ID]        INT           IDENTITY (1, 1) NOT NULL,
    [TaskName]  VARCHAR (128) NOT NULL,
    [GroupName] VARCHAR (128) NOT NULL,
    [JobName]   VARCHAR (128) NOT NULL,
    [TaskTime]  DATETIME      NOT NULL,
    [TaskError] VARCHAR (MAX) NULL,
    CONSTRAINT [PK_FailedTask] PRIMARY KEY NONCLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CronFailedTask_CronTask] FOREIGN KEY ([TaskName], [GroupName], [JobName]) REFERENCES [Cron].[CronTask] ([TaskName], [GroupName], [JobName])
);


GO
ALTER TABLE [Cron].[CronFailedTask] NOCHECK CONSTRAINT [FK_CronFailedTask_CronTask];


GO
CREATE TRIGGER [Cron].[triFailedTask] 
   ON  [Cron].[CronFailedTask] 
   INSTEAD OF INSERT
AS 
	SET NOCOUNT ON;
MERGE [Cron].[CronFailedTask] FT
USING inserted I ON FT.GroupName=I.GroupName
					AND FT.[JobName] = I.JobName
					AND FT.[TaskName] = I.TaskName
-- Insert
WHEN NOT MATCHED BY TARGET THEN
INSERT (GroupName,JobName,TaskName,TaskTime,TaskError)
VALUES(GroupName,JobName,TaskName,TaskTime,TaskError)
-- Update
WHEN MATCHED 
    THEN UPDATE SET TaskTime = I.TaskTime,TaskError = I.TaskError
-- Delete
WHEN NOT MATCHED BY SOURCE THEN
DELETE
;
SELECT FT.*
FROM [Cron].[CronFailedTask] FT
INNER JOIN inserted I ON FT.GroupName=I.GroupName
					AND FT.[JobName] = I.JobName
					AND FT.[TaskName] = I.TaskName