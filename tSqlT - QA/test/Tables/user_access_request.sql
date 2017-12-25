CREATE TABLE [test].[user_access_request] (
    [UserID]                    VARCHAR (10)  NOT NULL,
    [Full Mame]                 VARCHAR (64)  NOT NULL,
    [Component/s]               VARCHAR (32)  NOT NULL,
    [Applications List]         NCHAR (10)    NOT NULL,
    [Applications And Services] VARCHAR (64)  NOT NULL,
    [Description]               VARCHAR (128) NOT NULL,
    CONSTRAINT [PK_user_access_request] PRIMARY KEY CLUSTERED ([UserID] ASC)
);

