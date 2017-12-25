CREATE TABLE [Jira].[LinkedClone] (
    [ID]              INT           IDENTITY (1, 1) NOT NULL,
    [Project]         VARCHAR (64)  NOT NULL,
    [IssueType]       VARCHAR (64)  NOT NULL,
    [Workflow]        VARCHAR (128) NULL,
    [StatusFrom]      VARCHAR (64)  NULL,
    [StatusTo]        VARCHAR (64)  NOT NULL,
    [ProjectCreate]   VARCHAR (64)  NULL,
    [IssueTypeCreate] VARCHAR (64)  NOT NULL,
    [CustomFields]    VARCHAR (MAX) NULL,
    [Action]          VARCHAR (256) NULL,
    [DateStart]       DATE          NULL,
    [DateEnd]         DATE          NULL,
    [IsActive]        BIT           CONSTRAINT [DF_LinkedClone_IsActive] DEFAULT ((0)) NOT NULL,
    [IsLocked]        BIT           CONSTRAINT [DF_LinkedClone_IsLocked] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_LinkedClone] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_LinkedClone_Action] FOREIGN KEY ([Action]) REFERENCES [meta].[Action] ([FullName]),
    CONSTRAINT [IX_LinkedClone] UNIQUE NONCLUSTERED ([Project] ASC, [IssueType] ASC, [StatusFrom] ASC, [StatusTo] ASC, [ProjectCreate] ASC, [IssueTypeCreate] ASC)
);


GO
ALTER TABLE [Jira].[LinkedClone] NOCHECK CONSTRAINT [FK_LinkedClone_Action];


GO
CREATE TRIGGER [Jira].[truLinkedClone] 
   ON  [Jira].[LinkedClone] 
   AFTER INSERT,UPDATE
AS 
BEGIN
SET NOCOUNT ON; SET XACT_ABORT ON

declare @MissingTrans varchar(max)=
(
SELECT   TOP (1)     CONCAT(TA.Project, '::', TA.IssueType, '::', TA.StatusFrom, '::', TA.StatusTo, '::', ' is missing')  AS TransitionDoesNotExist
FROM            inserted AS TA LEFT OUTER JOIN
                         Jira.ProjectIssueTypeWorkflowTransition AS PITWT ON TA.Project = PITWT.Project COLLATE SQL_Latin1_General_CP1_CI_AS AND 
                         TA.IssueType = PITWT.IssueType COLLATE SQL_Latin1_General_CP1_CI_AS AND TA.StatusFrom = PITWT.StepFrom AND TA.StatusTo = PITWT.StepTo
WHERE        (PITWT.Project IS NULL) AND (TA.IsActive = 1)
)

IF @MissingTrans > '' THROW 50000,@MissingTrans,1


DECLARE @RC int = (SELECT COUNT(*) FROM
(
SELECT         Project, IssueType, Workflow, StatusFrom, StatusTo, ProjectCreate, IssueTypeCreate, CustomFields, Action, DateStart, DateEnd, IsActive FROM inserted
EXCEPT
SELECT         Project, IssueType, Workflow, StatusFrom, StatusTo, ProjectCreate, IssueTypeCreate, CustomFields, Action, DateStart, DateEnd, IsActive FROM deleted
)T
)


DECLARE @IsLocked varchar(max) = 
(
SELECT TOP (1)       CONCAT(TA.Project, '::', TA.IssueType, ' is LOCKED in meta.TestTableJiraSettings') AS TransitionIsLocked
FROM            inserted AS TA INNER JOIN
                         meta.TestTableJiraSettings AS JS ON TA.Project = JS.Project AND TA.IssueType = JS.IssueType
WHERE    TA.IsLocked = 1 AND (JS.IsLocked = 1)
)

IF @RC > 0 AND @IsLocked > '' THROW 50000,@IsLocked,1

UPDATE TA SET IsLocked = 1
FROM Jira.[LinkedClone] TA
INNER JOIN inserted i ON TA.ID = i.ID

END
GO
CREATE TRIGGER [Jira].[trdLinkedClone] 
   ON  Jira.LinkedClone 
   AFTER DELETE
AS 
BEGIN
SET NOCOUNT ON; SET XACT_ABORT ON

DECLARE @IsLocked varchar(max) = 
(
SELECT TOP (1)       CONCAT(TA.Project, '::', TA.IssueType, ' is LOCKED in meta.TestTableJiraSettings') AS TransitionIsLocked
FROM            deleted AS TA INNER JOIN
                         meta.TestTableJiraSettings AS JS ON TA.Project = JS.Project AND TA.IssueType = JS.IssueType
WHERE        (JS.IsLocked = 1)
)

IF @IsLocked > '' THROW 50000,@IsLocked,1

END