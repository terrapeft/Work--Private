
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 07/21/2015 17:14:55
-- Generated from EDMX file: E:\stash\spans\SpansLib\Db\SpansConfig.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Spans];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_ftp_FilesList_ftp_FileListingBatch]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ftp_FilesLists] DROP CONSTRAINT [FK_ftp_FilesList_ftp_FileListingBatch];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[cfg_ExtraFields]', 'U') IS NOT NULL
    DROP TABLE [dbo].[cfg_ExtraFields];
GO
IF OBJECT_ID(N'[dbo].[cfg_RecordsDefinitions]', 'U') IS NOT NULL
    DROP TABLE [dbo].[cfg_RecordsDefinitions];
GO
IF OBJECT_ID(N'[dbo].[cfg_RecordTableName]', 'U') IS NOT NULL
    DROP TABLE [dbo].[cfg_RecordTableName];
GO
IF OBJECT_ID(N'[dbo].[cfg_Relationships]', 'U') IS NOT NULL
    DROP TABLE [dbo].[cfg_Relationships];
GO
IF OBJECT_ID(N'[dbo].[ftp_Batches]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ftp_Batches];
GO
IF OBJECT_ID(N'[dbo].[ftp_FilesLists]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ftp_FilesLists];
GO
IF OBJECT_ID(N'[SpansModelStoreContainer].[import_Log]', 'U') IS NOT NULL
    DROP TABLE [SpansModelStoreContainer].[import_Log];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'ExtraFields'
CREATE TABLE [dbo].[cfg_ExtraFields] (
    [RecordId] nvarchar(2)  NOT NULL,
    [FileFormat] nvarchar(5)  NOT NULL,
    [FieldName] nvarchar(50)  NOT NULL,
    [FieldType] nvarchar(50)  NOT NULL,
    [Description] nchar(300)  NULL
);
GO

-- Creating table 'RecordTableNames'
CREATE TABLE [dbo].[cfg_RecordTableNames] (
    [RecordId] nvarchar(2)  NOT NULL,
    [FileFormat] nvarchar(5)  NOT NULL,
    [TableName] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Batches'
CREATE TABLE [dbo].[ftp_Batches] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Url] nvarchar(2000)  NOT NULL,
    [SearchFromDate] datetime  NULL,
    [BatchCreatedDateUTC] datetime  NOT NULL
);
GO

-- Creating table 'FilesLists'
CREATE TABLE [dbo].[ftp_FilesLists] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [BatchId] int  NOT NULL,
    [Path] nvarchar(2048)  NULL,
    [Url] nvarchar(2048)  NOT NULL,
    [FileDate] datetime  NOT NULL,
    [FileSize] bigint  NOT NULL
);
GO

-- Creating table 'RecordsDefinitions'
CREATE TABLE [dbo].[cfg_RecordsDefinitions] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [RecordType] nvarchar(2)  NOT NULL,
    [FieldLength] int  NOT NULL,
    [StartPosition] int  NOT NULL,
    [Definition] nvarchar(12)  NULL,
    [ValueFormat] nvarchar(15)  NULL,
    [DateFormat] nvarchar(25)  NULL,
    [ColumnName] nvarchar(50)  NULL,
    [DataType] nvarchar(20)  NOT NULL,
    [DefaultValue] nvarchar(50)  NULL,
    [Description] nvarchar(2500)  NULL,
    [Method] nvarchar(2)  NULL,
    [FileFormat] nvarchar(2)  NOT NULL
);
GO

-- Creating table 'Relationships'
CREATE TABLE [dbo].[cfg_Relationships] (
    [RecordId] nvarchar(2)  NOT NULL,
    [ParentRecordId] nvarchar(2)  NOT NULL,
    [FileFormat] nvarchar(5)  NOT NULL
);
GO

-- Creating table 'Logs'
CREATE TABLE [dbo].[Logs] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [BatchId] int  NULL,
    [Filename] nvarchar(2000)  NOT NULL,
    [UploadDateUTC] datetime  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [RecordId], [FileFormat], [FieldName] in table 'ExtraFields'
ALTER TABLE [dbo].[cfg_ExtraFields]
ADD CONSTRAINT [PK_cfg_ExtraFields]
    PRIMARY KEY CLUSTERED ([RecordId], [FileFormat], [FieldName] ASC);
GO

-- Creating primary key on [RecordId], [FileFormat] in table 'RecordTableNames'
ALTER TABLE [dbo].[cfg_RecordTableNames]
ADD CONSTRAINT [PK_cfg_RecordTableNames]
    PRIMARY KEY CLUSTERED ([RecordId], [FileFormat] ASC);
GO

-- Creating primary key on [Id] in table 'Batches'
ALTER TABLE [dbo].[ftp_Batches]
ADD CONSTRAINT [PK_ftp_Batches]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'FilesLists'
ALTER TABLE [dbo].[ftp_FilesLists]
ADD CONSTRAINT [PK_ftp_FilesLists]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'RecordsDefinitions'
ALTER TABLE [dbo].[cfg_RecordsDefinitions]
ADD CONSTRAINT [PK_cfg_RecordsDefinitions]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [RecordId], [ParentRecordId], [FileFormat] in table 'Relationships'
ALTER TABLE [dbo].[cfg_Relationships]
ADD CONSTRAINT [PK_cfg_Relationships]
    PRIMARY KEY CLUSTERED ([RecordId], [ParentRecordId], [FileFormat] ASC);
GO

-- Creating primary key on [Id], [Filename], [UploadDateUTC] in table 'Logs'
ALTER TABLE [dbo].[Logs]
ADD CONSTRAINT [PK_Logs]
    PRIMARY KEY CLUSTERED ([Id], [Filename], [UploadDateUTC] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [BatchId] in table 'FilesLists'
ALTER TABLE [dbo].[ftp_FilesLists]
ADD CONSTRAINT [FK_ftp_FilesList_ftp_FileListingBatch]
    FOREIGN KEY ([BatchId])
    REFERENCES [dbo].[ftp_Batches]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ftp_FilesList_ftp_FileListingBatch'
CREATE INDEX [IX_FK_ftp_FilesList_ftp_FileListingBatch]
ON [dbo].[ftp_FilesLists]
    ([BatchId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------