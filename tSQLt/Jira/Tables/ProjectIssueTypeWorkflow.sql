CREATE TABLE [Jira].[ProjectIssueTypeWorkflow] (
    [ID]        INT            IDENTITY (1, 1) NOT NULL,
    [Project]   NVARCHAR (5)   NOT NULL,
    [IssueType] NVARCHAR (64)  NOT NULL,
    [Workflow]  NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_ProjectIssueTypeWorkflow] PRIMARY KEY NONCLUSTERED ([ID] ASC)
);


GO
CREATE CLUSTERED INDEX [IX_ProjectIssueTypeWorkflow]
    ON [Jira].[ProjectIssueTypeWorkflow]([Project] ASC, [IssueType] ASC, [Workflow] ASC);


GO
CREATE TRIGGER [Jira].[trProjectIssueTypeWorkflow] 
   ON  [Jira].[ProjectIssueTypeWorkflow] 
   INSTEAD OF INSERT
AS 
SET NOCOUNT ON;

UPDATE T SET Workflow = i.Workflow
--OUTPUT inserted.*
FROM ProjectIssueTypeWorkflow T INNER JOIN inserted i ON T.Project = i.Project and T.IssueType=i.IssueType


INSERT INTO ProjectIssueTypeWorkflow
--OUTPUT inserted.*
SELECT i.Project, i.IssueType, i.Workflow
FROM inserted i
LEFT OUTER JOIN ProjectIssueTypeWorkflow T ON T.Project = i.Project and T.IssueType=i.IssueType
WHERE T.ID IS NULL

SELECT T.*
FROM ProjectIssueTypeWorkflow T INNER JOIN inserted i ON T.Project = i.Project and T.IssueType=i.IssueType