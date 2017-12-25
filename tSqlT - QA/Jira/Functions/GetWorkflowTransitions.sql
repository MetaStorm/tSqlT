CREATE FUNCTION [Jira].[GetWorkflowTransitions](
@x XML --=(SELECT  convert(xml,cast([DESCRIPTOR] as varchar(max)),2)FROM [Jira].[jiraworkflows] WWHERE workflowname='IPB - MIAMI - Workflow - CLF');
)RETURNS TABLE RETURN(

--SELECT * from xmltable(@x) WHERE FullPath LIKE 'workflow/%/action' NodeName = 'step' AND NodeType ='Element'

WITH  Steps AS
(
SELECT * FROM JIra.GetWorkflowSteps(@x)
),Step0 AS
(
SELECT t.c.value('@id','sysname')Id
FROM @x.nodes('/workflow/initial-actions/action')t(c)
), CA AS
(
SELECT 
	s.c.value('@id','sysname')ActionId,
	s.c.value('@name','sysname')Transition,
	ur.c.value('@step','sysname')StepToId
FROM @x.nodes('workflow/common-actions/action')s(c)
CROSS APPLY s.c.nodes('results/unconditional-result') ur(c)
), GA AS
(
SELECT 
	s.c.value('@name','sysname')Transition,
	ur.c.value('@step','sysname')StepToId
FROM @x.nodes('workflow/global-actions/action')s(c)
CROSS APPLY s.c.nodes('results/unconditional-result') ur(c)
)
,TransA AS-- Transitions
(
SELECT 
	Steps.Name StepFrom,
	ur.c.value('../../@name','sysname')Transition,
	ur.c.value('@step','sysname')StepToId
FROM @x.nodes('workflow/steps/step')s(c)
CROSS APPLY s.c.nodes('actions/action/results/unconditional-result') ur(c)
INNER JOIN Steps ON Steps.Id = s.c.value('@id','sysname')
),TransC AS-- Transitions
(
SELECT 
	Steps.Name StepFrom,
	CA.Transition,
	CA.StepToId
FROM @x.nodes('workflow/steps/step')s(c)
CROSS APPLY s.c.nodes('actions/common-action') a(c)
INNER JOIN CA ON CA.ActionId = a.c.value('@id','sysname')
INNER JOIN Steps ON Steps.Id = s.c.value('@id','sysname')
),TransG AS-- Transitions
(
SELECT 
	S.Name,
	GA.Transition,
	GA.StepToId
FROM Steps S
CROSS JOIN GA
), Trans AS
(
SELECT * FROM TransA
UNION ALL
SELECT * FROM TransC
UNION ALL
SELECT * FROM TransG
), WT AS
(
SELECT T.StepFrom,T.Transition,S.Name StepTo
FROM Trans T
INNER HASH JOIN Steps S on S.Id = T.StepToId
), WT0 AS
(
SELECT 
	ur.c.value('@step','sysname')StepToId
FROM @x.nodes('workflow/initial-actions/action')s(c)
CROSS APPLY s.c.nodes('results/unconditional-result') ur(c)
), WTC AS
(
SELECT '{Start}'StateFrom,'Create Issue' Transition,Steps.Name StepTo
FROM WT0
INNER HASH JOIN Steps ON Steps.Id = WT0.StepToId
), WTU AS
(
SELECT *,1 IsVirtual FROM WTC
UNION ALL
SELECT *,0 FROM WT
)
SELECT StateFrom,Transition,StepTo, ISNULL(CAST(IsVirtual as bit),0) IsVirtual FROM WTU
)
/** Test **
EXEC sp_describe_first_result_set @tsql =   
N'SELECT * FROM jira.[GetWorkflowTransitions](@x)'  
, @params = N'@x xml'  

SELECT  WS.*
FROM [Jira].[jiraworkflows] W
CROSS APPLY jira.[GetWorkflowTransitions](convert(xml,cast([DESCRIPTOR] as varchar(max)),2))WS
WHERE workflowname='IPB - MIAMI - Workflow - CLF'
*/