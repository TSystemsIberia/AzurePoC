CREATE TABLE [dbo].[ActivityLogSet] (
    [Id]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [LogTime]     DATETIME       NOT NULL,
    [LogRequest]  NVARCHAR (MAX) NOT NULL,
    [SourceIP]    NVARCHAR (MAX) NOT NULL,
    [FK_DeviceId] BIGINT         NOT NULL,
    CONSTRAINT [PK_ActivityLogSet] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_DeviceActivityLog] FOREIGN KEY ([FK_DeviceId]) REFERENCES [dbo].[DeviceSet] ([Id]) ON DELETE CASCADE
);




GO
CREATE NONCLUSTERED INDEX [IX_FK_DeviceActivityLog]
    ON [dbo].[ActivityLogSet]([FK_DeviceId] ASC);

