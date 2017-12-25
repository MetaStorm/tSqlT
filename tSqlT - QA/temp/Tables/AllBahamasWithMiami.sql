CREATE TABLE [temp].[AllBahamasWithMiami] (
    [AcctNo]             VARCHAR (50)   NULL,
    [Name]               NVARCHAR (255) NULL,
    [Bahamas Paper List] NVARCHAR (255) NULL,
    [CRC]                AS             (isnull(checksum([acctno]+[name]),(0))) PERSISTED NOT NULL,
    CONSTRAINT [PK_AllBahamasWithMiami] PRIMARY KEY CLUSTERED ([CRC] ASC)
);

