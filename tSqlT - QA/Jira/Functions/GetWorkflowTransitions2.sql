CREATE FUNCTION [Jira].[GetWorkflowTransitions2](
@WorkFlow sysname
)RETURNS @T TABLE( StateFrom varchar(128)  ,StateTo varchar(128), ParentsCount int PRIMARY KEY CLUSTERED (StateFrom,StateTo,ParentsCount))
AS BEGIN

DECLARE @T0 TABLE( StateFrom varchar(128)  ,StateTo varchar(128) PRIMARY KEY CLUSTERED (StateFrom,StateTo))
INSERT INTO @T0
SELECT StepFrom StateFom, StepTo StateTo 
FROM Jira.WorkflowTransition 
where Workflow=@WorkFlow

INSERT INTO @T
SELECT TR.*,TRP.ParentsCount
FROM @T0 TR
CROSS APPLY
(
SELECT COUNT(*) ParentsCount FROM @T0 WHERE StateTo = TR.StateFrom
)TRP


RETURN
END