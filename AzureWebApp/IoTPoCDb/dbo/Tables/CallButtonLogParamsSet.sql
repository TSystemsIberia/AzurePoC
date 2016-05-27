CREATE TABLE [dbo].[CallButtonLogParamsSet] (
    [Id]              BIGINT         IDENTITY (1, 1) NOT NULL,
    [Param]           NVARCHAR (MAX) NOT NULL,
    [Value]           NVARCHAR (MAX) NOT NULL,
    [CallButtonLogId] BIGINT         NOT NULL,
    CONSTRAINT [PK_CallButtonLogParamsSet] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_CallButtonLogCallButtonLogParams] FOREIGN KEY ([CallButtonLogId]) REFERENCES [dbo].[CallButtonLogSet] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_FK_CallButtonLogCallButtonLogParams]
    ON [dbo].[CallButtonLogParamsSet]([CallButtonLogId] ASC);

