
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 05/27/2016 15:13:08
-- Generated from EDMX file: D:\GitRoot\Azure\AzureWebApp\IoTPoCDAL\IoTPoCDBModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [iotpocdb01];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_CallButtonLogCallButtonLogParams]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LogParamsSet] DROP CONSTRAINT [FK_CallButtonLogCallButtonLogParams];
GO
IF OBJECT_ID(N'[dbo].[FK_CallButtonDeviceCallButtonLog]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ActivityLogSet] DROP CONSTRAINT [FK_CallButtonDeviceCallButtonLog];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[ActivityLogSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ActivityLogSet];
GO
IF OBJECT_ID(N'[dbo].[LogParamsSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LogParamsSet];
GO
IF OBJECT_ID(N'[dbo].[DeviceSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DeviceSet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'ActivityLogSet'
CREATE TABLE [dbo].[ActivityLogSet] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [LogTime] datetime  NOT NULL,
    [LogRequest] nvarchar(max)  NOT NULL,
    [SourceIP] nvarchar(max)  NOT NULL,
    [FK_DeviceId] bigint  NOT NULL
);
GO

-- Creating table 'LogParamsSet'
CREATE TABLE [dbo].[LogParamsSet] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Param] nvarchar(max)  NOT NULL,
    [Value] nvarchar(max)  NOT NULL,
    [FK_LogId] bigint  NOT NULL
);
GO

-- Creating table 'DeviceSet'
CREATE TABLE [dbo].[DeviceSet] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [MAC] nchar(12)  NOT NULL,
    [Type] nvarchar(max)  NULL,
    [Description] nvarchar(max)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'ActivityLogSet'
ALTER TABLE [dbo].[ActivityLogSet]
ADD CONSTRAINT [PK_ActivityLogSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'LogParamsSet'
ALTER TABLE [dbo].[LogParamsSet]
ADD CONSTRAINT [PK_LogParamsSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DeviceSet'
ALTER TABLE [dbo].[DeviceSet]
ADD CONSTRAINT [PK_DeviceSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [FK_LogId] in table 'LogParamsSet'
ALTER TABLE [dbo].[LogParamsSet]
ADD CONSTRAINT [FK_ActivityLogLogParams]
    FOREIGN KEY ([FK_LogId])
    REFERENCES [dbo].[ActivityLogSet]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ActivityLogLogParams'
CREATE INDEX [IX_FK_ActivityLogLogParams]
ON [dbo].[LogParamsSet]
    ([FK_LogId]);
GO

-- Creating foreign key on [FK_DeviceId] in table 'ActivityLogSet'
ALTER TABLE [dbo].[ActivityLogSet]
ADD CONSTRAINT [FK_DeviceActivityLog]
    FOREIGN KEY ([FK_DeviceId])
    REFERENCES [dbo].[DeviceSet]
        ([Id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DeviceActivityLog'
CREATE INDEX [IX_FK_DeviceActivityLog]
ON [dbo].[ActivityLogSet]
    ([FK_DeviceId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------