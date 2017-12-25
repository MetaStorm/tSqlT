CREATE FUNCTION [Jira].[GetWorkflowTransitionsOrdered](
@WorkFlow sysname = 'Investment Profile Suitability Review'
)RETURNS TABLE RETURN(
WITH T0 AS(
SELECT StateFrom, StateTo,ParentsCount FROM [Jira].[GetWorkflowTransitions2](@WorkFlow)
), T1 AS
(
SELECT DISTINCT StateFrom HeadStateID ,0 PathPosition,'{'+CAST(StateFrom AS varchar(max))+','+CAST(StateTo AS varchar(max))+'}'  U, T.* FROM T0 T WHERE T.StateFrom='{Start}'
UNION ALL
SELECT T1.HeadStateID, PathPosition + 1,U+'{'+CAST(T.StateFrom AS varchar(max))+','+CAST(T.StateTo AS varchar(max))+'}' , T.* FROM T0 T INNER JOIN T1 ON T1.StateTo = T.StateFrom 
WHERE NOT T1.U LIKE '%{'+CAST(T.StateFrom AS varchar(max))+','+CAST(T.StateTo AS varchar(max))+'}%'
), T2 AS
(
SELECT HeadStateID,StateFrom,StateTo,MIN(PathPosition)PathPosition
FROM T1 T 
GROUP BY HeadStateID,StateTo,StateFrom 
)
SELECT TOP (10000) * FROM T2 T ORDER BY PathPosition
)