CREATE TABLE [Jira].[TransitionAction] (
    [ID]         INT            IDENTITY (1, 1) NOT NULL,
    [Project]    VARCHAR (64)   NOT NULL,
    [IssueType]  VARCHAR (128)  NOT NULL,
    [StatusFrom] VARCHAR (64)   NOT NULL,
    [StatusTo]   VARCHAR (64)   NOT NULL,
    [Action]     VARCHAR (256)  NOT NULL,
    [Comment]    NVARCHAR (256) NULL,
    [IsActive]   BIT            CONSTRAINT [DF_TransitionAction_IsActive] DEFAULT ((1)) NOT NULL,
    [IsLocked]   BIT            CONSTRAINT [DF_TransitionAction_IsLocked] DEFAULT ((1)) NOT NULL,
    [IsTest]     BIT            CONSTRAINT [DF_TransitionAction_IsTest] DEFAULT ((0)) NOT NULL,
    [Position]   INT            CONSTRAINT [DF_TransitionAction_Position] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TransitionAction] PRIMARY KEY NONCLUSTERED ([ID] ASC),
    CONSTRAINT [FK_TransitionAction_Action] FOREIGN KEY ([Action]) REFERENCES [meta].[Action] ([FullName])
);


GO
ALTER TABLE [Jira].[TransitionAction] NOCHECK CONSTRAINT [FK_TransitionAction_Action];


GO
CREATE UNIQUE CLUSTERED INDEX [IX_TransitionAction]
    ON [Jira].[TransitionAction]([Project] ASC, [IssueType] ASC, [Position] ASC, [StatusFrom] ASC, [StatusTo] ASC);


GO
CREATE TRIGGER [Jira].[trdTransitionAction] 
   ON  Jira.TransitionAction 
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
GO
CREATE TRIGGER [Jira].[truTransitionAction] 
   ON  [Jira].[TransitionAction] 
   AFTER INSERT,UPDATE
AS 
BEGIN
SET NOCOUNT ON; SET XACT_ABORT ON

declare @MissingTrans varchar(max)=
(
SELECT   TOP (1)     CONCAT(TA.Project, '::', TA.IssueType, '::', TA.StatusFrom, '::', TA.StatusTo, '::', TA.Action, ' is missing')  AS TransitionDoesNotExist
FROM            inserted AS TA LEFT OUTER JOIN
                         Jira.ProjectIssueTypeWorkflowTransition AS PITWT ON TA.Project = PITWT.Project COLLATE SQL_Latin1_General_CP1_CI_AS AND 
                         TA.IssueType = PITWT.IssueType COLLATE SQL_Latin1_General_CP1_CI_AS AND TA.StatusFrom = PITWT.StepFrom AND TA.StatusTo = PITWT.StepTo
WHERE        (PITWT.Project IS NULL) AND (TA.IsActive = 1)
)

IF @MissingTrans > '' THROW 50000,@MissingTrans,1

DECLARE @MissingAction varchar(max)=
(
SELECT        TOP (1) CONCAT(TA.Action, ' is missing')  AS ActionDoesNotExist
FROM            inserted AS TA LEFT OUTER JOIN
                         meta.Action ON TA.Action = meta.Action.FullName
WHERE        (TA.IsActive = 1) AND (meta.Action.FullName IS NULL)
)

IF @MissingAction > '' THROW 50000,@MissingAction,1


DECLARE @RC int = (SELECT COUNT(*) FROM
(
SELECT Project, IssueType, StatusFrom, StatusTo, Action, Comment, IsActive,IsTest, Position FROM inserted
EXCEPT
SELECT Project, IssueType, StatusFrom, StatusTo, Action, Comment, IsActive, IsTest, Position FROM deleted
)T
)
DECLARE @IsLocked varchar(max) = 
(
SELECT TOP (1)       CONCAT(TA.Project, '::', TA.IssueType, ' is LOCKED in meta.TestTableJiraSettings') AS TransitionIsLocked
FROM            inserted AS TA INNER JOIN
                         meta.TestTableJiraSettings AS JS ON TA.Project = JS.Project AND TA.IssueType = JS.IssueType
WHERE  TA.IsLocked = 1 AND(JS.IsLocked = 1)
)

IF @RC > 0 AND @IsLocked > '' THROW 50000,@IsLocked,1

UPDATE TA SET IsLocked = 1
FROM Jira.TransitionAction TA
INNER JOIN inserted i ON TA.ID = i.ID

END