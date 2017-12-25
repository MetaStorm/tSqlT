CREATE TABLE [Cron].[CronTask] (
    [TaskId]            VARCHAR (128) NOT NULL,
    [TaskName]          VARCHAR (128) NOT NULL,
    [GroupName]         VARCHAR (128) NOT NULL,
    [JobName]           VARCHAR (128) NOT NULL,
    [TaskTime]          DATETIME      NOT NULL,
    [IsActive]          BIT           NOT NULL,
    [TaskType]          VARCHAR (64)  NOT NULL,
    [Credentials]       VARCHAR (64)  NULL,
    [ExitCodeResult]    VARCHAR (16)  NOT NULL,
    [Status]            VARCHAR (16)  NOT NULL,
    [DateLastExecution] DATETIME      NOT NULL,
    [ExecutionSeconds]  FLOAT (53)    NULL,
    [ExecutionHours]    AS            (round([ExecutionSeconds]/(3600),(1))) PERSISTED,
    [CmdLine]           VARCHAR (MAX) NULL,
    [CmdArguments]      VARCHAR (MAX) NULL,
    [Project]           VARCHAR (128) NULL,
    [IssueType]         VARCHAR (128) NULL,
    [Assignee]          VARCHAR (32)  NULL,
    CONSTRAINT [PK_CronTask] PRIMARY KEY CLUSTERED ([TaskName] ASC, [GroupName] ASC, [JobName] ASC),
    CONSTRAINT [FK_CronTask_CronJob1] FOREIGN KEY ([GroupName], [JobName]) REFERENCES [Cron].[CronJob] ([GroupName], [JobName])
);


GO
ALTER TABLE [Cron].[CronTask] NOCHECK CONSTRAINT [FK_CronTask_CronJob1];


GO
CREATE TRIGGER [Cron].[triCronTask] 
   ON  Cron.CronTask 
   INSTEAD OF INSERT
AS 
	SET NOCOUNT ON;
MERGE [Cron].[CronTask] FT
USING inserted I ON FT.GroupName=I.GroupName
					AND FT.[JobName] = I.JobName
					AND FT.[TaskName] = I.TaskName
-- Insert
WHEN NOT MATCHED BY TARGET THEN
INSERT (TaskId, GroupName,JobName,TaskName,ExecutionSeconds,ExitCodeResult,Status,DateLastExecution,IsActive,CmdLine,CmdArguments,[TaskType],[Credentials],TaskTime)
VALUES(TaskId, GroupName,JobName,TaskName,ExecutionSeconds,ExitCodeResult,Status,DateLastExecution,IsActive,CmdLine,CmdArguments,[TaskType],[Credentials],TaskTime)
-- Update
WHEN MATCHED 
    THEN UPDATE SET 
			ExecutionSeconds = I.ExecutionSeconds,
			ExitCodeResult = I.ExitCodeResult,
			Status = I.Status,
			IsActive = I.IsActive,
			DateLastExecution = I.DateLastExecution,
			CmdLine = I.CmdLine,
			CmdArguments = I.CmdArguments,
			[TaskType] = I.[TaskType],
      [Credentials] = I.[Credentials],
      [TaskTime] = I.[TaskTime]

-- Delete
WHEN NOT MATCHED BY SOURCE THEN
DELETE
;
SELECT FT.*
FROM [Cron].[CronTask] FT
INNER JOIN inserted I ON FT.GroupName=I.GroupName
					AND FT.[JobName] = I.JobName
					AND FT.[TaskName] = I.TaskName