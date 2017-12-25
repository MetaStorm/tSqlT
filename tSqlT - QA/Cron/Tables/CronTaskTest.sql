CREATE TABLE [Cron].[CronTaskTest] (
    [TaskId]           VARCHAR (128) NOT NULL,
    [TaskName]         VARCHAR (128) NOT NULL,
    [GroupName]        VARCHAR (128) NOT NULL,
    [JobName]          VARCHAR (128) NOT NULL,
    [TaskTime]         DATETIME      NOT NULL,
    [TaskType]         VARCHAR (64)  NOT NULL,
    [Credentials]      VARCHAR (64)  NULL,
    [ExitCodeResult]   VARCHAR (16)  NOT NULL,
    [Status]           VARCHAR (16)  NOT NULL,
    [ExecutionSeconds] FLOAT (53)    NULL,
    [CmdLine]          VARCHAR (MAX) NULL,
    [CmdArguments]     VARCHAR (MAX) NULL,
    CONSTRAINT [PK_CronTaskTest] PRIMARY KEY CLUSTERED ([TaskName] ASC, [GroupName] ASC, [JobName] ASC),
    CONSTRAINT [FK_CronTaskTest_CronJob1] FOREIGN KEY ([GroupName], [JobName]) REFERENCES [Cron].[CronJob] ([GroupName], [JobName])
);


GO
ALTER TABLE [Cron].[CronTaskTest] NOCHECK CONSTRAINT [FK_CronTaskTest_CronJob1];

