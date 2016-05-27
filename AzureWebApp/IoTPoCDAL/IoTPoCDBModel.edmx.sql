
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 05/24/2016 18:41:18
-- Generated from EDMX file: D:\GitRoot\Azure\AzureWebApp\IoTPoCDAL\IoTPoCDBModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [IoTPoCDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_CallButtonLogCallButtonLogParams]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CallButtonLogParamsSet] DROP CONSTRAINT [FK_CallButtonLogCallButtonLogParams];
GO
IF OBJECT_ID(N'[dbo].[FK_CallButtonDeviceCallButtonLog]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CallButtonLogSet] DROP CONSTRAINT [FK_CallButtonDeviceCallButtonLog];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[CallButtonLogSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CallButtonLogSet];
GO
IF OBJECT_ID(N'[dbo].[CallButtonLogParamsSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CallButtonLogParamsSet];
GO
IF OBJECT_ID(N'[dbo].[CallButtonDeviceSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CallButtonDeviceSet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'CallButtonLogSet'
CREATE TABLE [dbo].[CallButtonLogSet] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [LogTime] datetime  NOT NULL,
    [LogRequest] nvarchar(max)  NOT NULL,
    [Ip] nvarchar(max)  NOT NULL,
    [CallButtonDeviceId] bigint  NOT NULL
);
GO

-- Creating table 'CallButtonLogParamsSet'
CREATE TABLE [dbo].[CallButtonLogParamsSet] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Param] nvarchar(max)  NOT NULL,
    [Value] nvarchar(max)  NOT NULL,
    [CallButtonLogId] bigint  NOT NULL
);
GO

-- Creating table 'CallButtonDeviceSet'
CREATE TABLE [dbo].[CallButtonDeviceSet] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [MAC] nchar(12)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'CallButtonLogSet'
ALTER TABLE [dbo].[CallButtonLogSet]
ADD CONSTRAINT [PK_CallButtonLogSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'CallButtonLogParamsSet'
ALTER TABLE [dbo].[CallButtonLogParamsSet]
ADD CONSTRAINT [PK_CallButtonLogParamsSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'CallButtonDeviceSet'
ALTER TABLE [dbo].[CallButtonDeviceSet]
ADD CONSTRAINT [PK_CallButtonDeviceSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CallButtonLogId] in table 'CallButtonLogParamsSet'
ALTER TABLE [dbo].[CallButtonLogParamsSet]
ADD CONSTRAINT [FK_CallButtonLogCallButtonLogParams]
    FOREIGN KEY ([CallButtonLogId])
    REFERENCES [dbo].[CallButtonLogSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CallButtonLogCallButtonLogParams'
CREATE INDEX [IX_FK_CallButtonLogCallButtonLogParams]
ON [dbo].[CallButtonLogParamsSet]
    ([CallButtonLogId]);
GO

-- Creating foreign key on [CallButtonDeviceId] in table 'CallButtonLogSet'
ALTER TABLE [dbo].[CallButtonLogSet]
ADD CONSTRAINT [FK_CallButtonDeviceCallButtonLog]
    FOREIGN KEY ([CallButtonDeviceId])
    REFERENCES [dbo].[CallButtonDeviceSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CallButtonDeviceCallButtonLog'
CREATE INDEX [IX_FK_CallButtonDeviceCallButtonLog]
ON [dbo].[CallButtonLogSet]
    ([CallButtonDeviceId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------