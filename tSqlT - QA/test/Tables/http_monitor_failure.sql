CREATE TABLE [test].[http_monitor_failure] (
    [Monitor Name]  VARCHAR (256) NOT NULL,
    [Date]          DATE          NOT NULL,
    [Server Name]   VARCHAR (32)  NOT NULL,
    [Service Name]  VARCHAR (64)  NULL,
    [Monitored Url] VARCHAR (265) NOT NULL,
    [Reference Url] VARCHAR (256) NULL,
    CONSTRAINT [PK_http_monitor_failure] PRIMARY KEY CLUSTERED ([Monitor Name] ASC)
);

