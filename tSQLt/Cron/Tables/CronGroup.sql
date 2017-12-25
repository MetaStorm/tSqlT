CREATE TABLE [Cron].[CronGroup] (
    [GroupName] VARCHAR (128) NOT NULL,
    [Project]   VARCHAR (128) NULL,
    [IssueType] VARCHAR (128) NULL,
    [Assignee]  VARCHAR (32)  NULL,
    CONSTRAINT [PK_GroupName] PRIMARY KEY CLUSTERED ([GroupName] ASC)
);


GO
CREATE TRIGGER [Cron].[triCronGroup] 
   ON  [Cron].[CronGroup] 
   INSTEAD OF INSERT
AS 
	SET NOCOUNT ON;
MERGE [Cron].[CronGroup] FT
USING inserted I ON FT.GroupName=I.GroupName
-- Insert
WHEN NOT MATCHED BY TARGET THEN
INSERT (GroupName)
VALUES(GroupName)
-- Update
WHEN NOT MATCHED BY SOURCE THEN
DELETE
;
SELECT FT.*
FROM [Cron].[CronGroup] FT
INNER JOIN inserted I ON FT.GroupName=I.GroupName