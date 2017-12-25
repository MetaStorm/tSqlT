CREATE TABLE [Jira].[WorkflowTransition] (
    [Workflow]   NVARCHAR (255) COLLATE SQL_Latin1_General_CP437_CI_AI NOT NULL,
    [StepFrom]   [sysname]      NOT NULL,
    [Transition] [sysname]      NOT NULL,
    [StepTo]     [sysname]      NOT NULL,
    [IsVirtual]  BIT            NOT NULL,
    [Position]   INT            CONSTRAINT [DF_WorkflowTransition_Position] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_WorkflowTransition] PRIMARY KEY CLUSTERED ([Workflow] ASC, [StepFrom] ASC, [StepTo] ASC, [Transition] ASC)
);

