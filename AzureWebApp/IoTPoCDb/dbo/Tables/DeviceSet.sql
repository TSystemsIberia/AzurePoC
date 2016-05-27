CREATE TABLE [dbo].[DeviceSet] (
    [Id]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (MAX) NOT NULL,
    [MAC]         NCHAR (12)     NOT NULL,
    [Type]        NVARCHAR (MAX) NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_DeviceSet] PRIMARY KEY CLUSTERED ([Id] ASC)
);

