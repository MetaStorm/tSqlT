CREATE TABLE [Jira].[WorkflowTrantisionWithPosition] (
    [Workflow]     NVARCHAR (255) COLLATE SQL_Latin1_General_CP437_CI_AI NOT NULL,
    [StateFom]     [sysname]      NULL,
    [StateTo]      [sysname]      NULL,
    [PathPosition] INT            NULL
);

