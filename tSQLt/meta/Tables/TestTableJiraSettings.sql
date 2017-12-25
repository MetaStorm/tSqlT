CREATE TABLE [meta].[TestTableJiraSettings] (
    [TableName]     NVARCHAR (256)  NOT NULL,
    [ReportItem]    VARCHAR (32)    CONSTRAINT [DF_TestTableJiraSettings_ReportItem] DEFAULT ('') NOT NULL,
    [Project]       NVARCHAR (50)   NULL,
    [IssueType]     NVARCHAR (128)  NULL,
    [Subject]       NVARCHAR (258)  NULL,
    [Description]   NVARCHAR (1024) NULL,
    [IsActive]      BIT             CONSTRAINT [DF_TestTableJiraSettings_IsActive] DEFAULT ((1)) NOT NULL,
    [Error]         AS              (case when [ReportItem]>'' OR object_id('test.'+[TableName])>(0) then '' else ('Table [test].['+[TableName])+'] does not exist.' end),
    [Assignee]      VARCHAR (50)    NULL,
    [GroupAssignee] VARCHAR (50)    NULL,
    [Reporter]      VARCHAR (50)    NULL,
    [Action]        VARCHAR (128)   NULL,
    [CustomFields]  VARCHAR (MAX)   NULL,
    [RowKey]        VARCHAR (MAX)   NULL,
    [TicketKey]     VARCHAR (64)    NULL,
    [IsLocked]      BIT             CONSTRAINT [DF_TestTableJiraSettings_IsLocked] DEFAULT ((1)) NOT NULL,
    [OnOrphaned]    VARCHAR (32)    NULL,
    [Link]          VARCHAR (MAX)   NULL,
    CONSTRAINT [PK_TestTableJiraSettings] PRIMARY KEY CLUSTERED ([TableName] ASC, [ReportItem] ASC),
    CONSTRAINT [CK_TestTableJiraSettings_Assignee_GroupAssignee] CHECK (isnull([Assignee],'')='' OR isnull([GroupAssignee],'')='')
);


GO
CREATE TRIGGER [meta].[trTestTableJiraSettings] 
   ON  meta.TestTableJiraSettings 
   AFTER INSERT,UPDATE
AS 
BEGIN
SET NOCOUNT ON; SET XACT_ABORT ON

DECLARE @RC int = (SELECT COUNT(*) FROM
(
SELECT  TableName, ReportItem, Project, IssueType, Subject, Description, IsActive, Error, Assignee, GroupAssignee, Reporter, Action, CustomFields, RowKey, TicketKey, OnOrphaned FROM inserted
EXCEPT
SELECT TableName, ReportItem, Project, IssueType, Subject, Description, IsActive, Error, Assignee, GroupAssignee, Reporter, Action, CustomFields, RowKey, TicketKey, OnOrphaned FROM deleted
)T
)

DECLARE @IsLocked varchar(max) = 
(
SELECT TOP (1)       CONCAT(TA.TableName, '::', 'meta.TestTableJiraSettings is LOCKED') AS TransitionIsLocked
FROM            inserted AS TA 
WHERE    TA.IsLocked = 1 
)

IF @RC > 0 AND @IsLocked > '' THROW 50000,@IsLocked,1

UPDATE TA SET IsLocked = 1
FROM  [meta].[TestTableJiraSettings] TA
INNER JOIN inserted i ON TA.TableName = i.TableName

END