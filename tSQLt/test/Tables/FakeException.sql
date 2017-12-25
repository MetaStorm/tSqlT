CREATE TABLE [test].[FakeException] (
    [Account Number] VARCHAR (50)  NOT NULL,
    [Order Number]   VARCHAR (50)  CONSTRAINT [DF_FakeException_Order Number] DEFAULT ('') NOT NULL,
    [Date]           DATE          NOT NULL,
    [Subject]        VARCHAR (512) NULL,
    [Assignee]       VARCHAR (50)  NULL,
    [Reporter]       VARCHAR (50)  NULL,
    [Project]        VARCHAR (50)  NULL,
    [IssueType]      VARCHAR (128) NULL,
    CONSTRAINT [PK_FakeExcepton] PRIMARY KEY CLUSTERED ([Account Number] ASC, [Order Number] ASC)
);

