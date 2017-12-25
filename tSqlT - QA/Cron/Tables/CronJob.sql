CREATE TABLE [Cron].[CronJob] (
    [JobName]   VARCHAR (128) NOT NULL,
    [GroupName] VARCHAR (128) NOT NULL,
    [IsActive]  BIT           NOT NULL,
    [Project]   VARCHAR (128) NULL,
    [IssueType] VARCHAR (128) NULL,
    [Assignee]  VARCHAR (32)  NULL,
    CONSTRAINT [PK_CronJob] PRIMARY KEY CLUSTERED ([GroupName] ASC, [JobName] ASC),
    CONSTRAINT [FK_CronJob_CronGroup] FOREIGN KEY ([GroupName]) REFERENCES [Cron].[CronGroup] ([GroupName])
);


GO
ALTER TABLE [Cron].[CronJob] NOCHECK CONSTRAINT [FK_CronJob_CronGroup];


GO
CREATE TRIGGER [Cron].[triCronJob] 
   ON  [Cron].[CronJob] 
   INSTEAD OF INSERT
AS 
	SET NOCOUNT ON;
MERGE [Cron].[CronJob] FT
USING inserted I ON FT.GroupName=I.GroupName
					AND FT.[JobName] = I.JobName
-- Insert
WHEN NOT MATCHED BY TARGET THEN
INSERT (GroupName,JobName,IsActive)
VALUES(GroupName,JobName,IsActive)
-- Update
WHEN MATCHED 
    THEN UPDATE SET IsActive = I.IsActive
-- Delete
WHEN NOT MATCHED BY SOURCE THEN
DELETE
;
SELECT FT.*
FROM [Cron].[CronJob] FT
INNER JOIN inserted I ON FT.GroupName=I.GroupName
					AND FT.[JobName] = I.JobName