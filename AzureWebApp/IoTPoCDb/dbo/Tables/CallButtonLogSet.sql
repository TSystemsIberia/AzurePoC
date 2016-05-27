CREATE TABLE [dbo].[CallButtonLogSet] (
    [Id]                 BIGINT         IDENTITY (1, 1) NOT NULL,
    [LogTime]            DATETIME       NOT NULL,
    [LogRequest]         NVARCHAR (MAX) NOT NULL,
    [Ip]                 NVARCHAR (MAX) NOT NULL,
    [CallButtonDeviceId] BIGINT         NOT NULL,
    CONSTRAINT [PK_CallButtonLogSet] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_CallButtonDeviceCallButtonLog] FOREIGN KEY ([CallButtonDeviceId]) REFERENCES [dbo].[CallButtonDeviceSet] ([Id])
);






GO
CREATE NONCLUSTERED INDEX [IX_FK_CallButtonDeviceCallButtonLog]
    ON [dbo].[CallButtonLogSet]([CallButtonDeviceId] ASC);

