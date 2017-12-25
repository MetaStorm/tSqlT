CREATE TABLE [Jira].[Workflow] (
    [WorkflowName] NVARCHAR (255) COLLATE SQL_Latin1_General_CP437_CI_AI NOT NULL,
    [Description]  VARCHAR (MAX)  NOT NULL,
    CONSTRAINT [PK_Workflow] PRIMARY KEY CLUSTERED ([WorkflowName] ASC)
);


GO
CREATE TRIGGER Jira.triWorkflow 
   ON  Jira.Workflow 
   AFTER INSERT
AS 
SET NOCOUNT ON; SET XACT_ABORT ON;

DELETE Jira.WorkflowTransition 
WHERE Workflow IN
(
SELECT DISTINCT W.workflowname 
FROM inserted W
)

INSERT INTO Jira.WorkflowTransition
SELECT DISTINCT W.workflowname Workflow,T.*,-1
FROM inserted W
CROSS APPLY Jira.GetWorkflowTransitions(convert(xml,W.[Description] ,2)) T

INSERT INTO Jira.WorkflowTransition
SELECT WS.Workflow,'{ANY}','',WS.Step,1,-1
FROM Jira.WorkflowStep WS
INNER JOIN inserted i ON WS.Workflow = i.WorkflowName
WHERE WS.IsVirtual = 0