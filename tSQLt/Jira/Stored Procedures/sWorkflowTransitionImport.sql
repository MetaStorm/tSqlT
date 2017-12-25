CREATE PROCEDURE [Jira].[sWorkflowTransitionImport] AS
SET NOCOUNT ON SET XACT_ABORT ON

BEGIN TRAN

DELETE Jira.WorkflowTransition
INSERT INTO Jira.WorkflowTransition
OUTPUT inserted.*
SELECT DISTINCT W.workflowname Workflow,T.*,-1
FROM [Jira].[jiraworkflows] W
CROSS APPLY Jira.GetWorkflowTransitions(convert(xml,cast([DESCRIPTOR] as varchar(max)),2)) T

INSERT INTO Jira.WorkflowTransition
SELECT WS.Workflow,'{ANY}','',WS.Step,1,-1
FROM Jira.WorkflowStep WS
WHERE WS.IsVirtual = 0
--where workflowname='IPB - MIAMI - Workflow - Wire Notification - Multiple Bi-directional'

COMMIT