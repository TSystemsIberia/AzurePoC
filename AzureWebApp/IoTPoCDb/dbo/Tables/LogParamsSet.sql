CREATE TABLE [dbo].[LogParamsSet] (
    [Id]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [Param]    NVARCHAR (MAX) NOT NULL,
    [Value]    NVARCHAR (MAX) NOT NULL,
    [FK_LogId] BIGINT         NOT NULL,
    CONSTRAINT [PK_LogParamsSet] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ActivityLogLogParams] FOREIGN KEY ([FK_LogId]) REFERENCES [dbo].[ActivityLogSet] ([Id]) ON DELETE CASCADE
);




GO
CREATE NONCLUSTERED INDEX [IX_FK_ActivityLogLogParams]
    ON [dbo].[LogParamsSet]([FK_LogId] ASC);

