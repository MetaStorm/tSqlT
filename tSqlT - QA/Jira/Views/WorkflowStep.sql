
CREATE VIEW [Jira].[WorkflowStep]
AS
WITH WS AS (SELECT DISTINCT Workflow, StepFrom AS Step, IsVirtual
                              FROM            Jira.WorkflowTransition
                              UNION
                              SELECT DISTINCT Workflow, StepTo, 0 AS Expr1
                              FROM            Jira.WorkflowTransition AS WorkflowTransition_1
                              UNION
                              SELECT        workflowname AS Workflow, '{LOOP}' AS Expr1, 1 AS Expr2
                              FROM            Jira.Workflow AS jiraworkflows_1)
    SELECT        ISNULL(Workflow, '') AS Workflow, Step, ISNULL(CAST(IsVirtual AS bit), 0) AS IsVirtual
     FROM            WS AS WS_1