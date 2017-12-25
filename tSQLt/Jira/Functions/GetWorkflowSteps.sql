CREATE FUNCTION [Jira].[GetWorkflowSteps](
@x XML --=(SELECT  convert(xml,cast([DESCRIPTOR] as varchar(max)),2)FROM [Jira].[jiraworkflows] WWHERE workflowname='IPB - MIAMI - Workflow - CLF');
)RETURNS @T TABLE( Name sysname collate SQL_Latin1_General_CP437_CI_AI,Id sysname collate SQL_Latin1_General_CP437_CI_AI PRIMARY KEY)
AS BEGIN
INSERT INTO @T
SELECT TOP 10000 
	jls.pname Name,
	s.c.value('@id','sysname')Id
FROM @x.nodes('workflow/steps/step')s(c)
CROSS APPLY s.c.nodes('meta') ls(c)
INNER HASH JOIN [jiraschema].[issuestatus] jls ON jls.ID = ls.c.value('.','sysname')
WHERE ls.c.value('@name','sysname') = 'jira.status.id'
ORDER BY 1,2

RETURN
END
/** Test **
EXEC sp_describe_first_result_set @tsql =   
N'SELECT * FROM [Jira].[GetWorkflowSteps](@x)'  
, @params = N'@x xml'  
*/