CREATE TABLE [dbo].[CallButtonDeviceSet] (
    [Id]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (MAX) NOT NULL,
    [MAC]  NCHAR (12)     NOT NULL,
    CONSTRAINT [PK_CallButtonDeviceSet] PRIMARY KEY CLUSTERED ([Id] ASC)
);

