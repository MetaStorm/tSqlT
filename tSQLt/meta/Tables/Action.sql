CREATE TABLE [meta].[Action] (
    [ID]         INT           IDENTITY (1, 1) NOT NULL,
    [Namespace]  VARCHAR (64)  NOT NULL,
    [ClassName]  VARCHAR (64)  NOT NULL,
    [MethodName] VARCHAR (64)  NOT NULL,
    [FullName]   AS            (isnull(CONVERT([varchar](256),((([Namespace]+'.')+[ClassName])+'.')+[MethodName]),'')) PERSISTED NOT NULL,
    [DLL]        VARCHAR (256) NULL,
    CONSTRAINT [PK_Action] PRIMARY KEY NONCLUSTERED ([ID] ASC)
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_Action]
    ON [meta].[Action]([FullName] ASC);

