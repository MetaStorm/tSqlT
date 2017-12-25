CREATE TABLE [Jira].[ProjectIssueType] (
    [ID]        INT            IDENTITY (1, 1) NOT NULL,
    [Project]   NVARCHAR (5)   COLLATE SQL_Latin1_General_CP437_CI_AI NOT NULL,
    [IssueType] NVARCHAR (255) COLLATE SQL_Latin1_General_CP437_CI_AI NOT NULL,
    CONSTRAINT [PK_ProjectIssueType] PRIMARY KEY NONCLUSTERED ([ID] ASC)
);


GO
CREATE CLUSTERED INDEX [IX_ProjectIssueType]
    ON [Jira].[ProjectIssueType]([Project] ASC, [IssueType] ASC);

