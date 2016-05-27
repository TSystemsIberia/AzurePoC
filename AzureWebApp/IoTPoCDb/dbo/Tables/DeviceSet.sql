CREATE TABLE [dbo].[DeviceSet] (
    [Id]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (MAX) NOT NULL,
    [MAC]         NCHAR (12)     NOT NULL,
    [Type]        NVARCHAR (MAX) NULL,
    [Description] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_DeviceSet] PRIMARY KEY CLUSTERED ([Id] ASC)
);



