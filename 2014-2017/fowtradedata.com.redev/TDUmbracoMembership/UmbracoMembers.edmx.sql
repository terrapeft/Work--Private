
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/18/2015 14:53:58
-- Generated from EDMX file: E:\stash\fowtradedata.com.redev\TDUmbracoMembership\UmbracoMembers.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [UmbracoMembers];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Companies]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Companies];
GO
IF OBJECT_ID(N'[dbo].[History]', 'U') IS NOT NULL
    DROP TABLE [dbo].[History];
GO
IF OBJECT_ID(N'[dbo].[Members]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Members];
GO
IF OBJECT_ID(N'[UmbracoMembersModelStoreContainer].[vwMembers]', 'U') IS NOT NULL
    DROP TABLE [UmbracoMembersModelStoreContainer].[vwMembers];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Companies'
CREATE TABLE [dbo].[Companies] (
    [CompanyId] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(100)  NOT NULL,
    [Address] nvarchar(500)  NULL,
    [Phone] nvarchar(50)  NULL
);
GO

-- Creating table 'Histories'
CREATE TABLE [dbo].[Histories] (
    [HistoryId] int IDENTITY(1,1) NOT NULL,
    [MemberId] int  NULL,
    [Username] nvarchar(50)  NULL,
    [TimestampUtc] datetime  NOT NULL,
    [Action] nvarchar(50)  NOT NULL,
    [Message] nvarchar(max)  NULL
);
GO

-- Creating table 'Members'
CREATE TABLE [dbo].[Members] (
    [MemberId] int IDENTITY(1,1) NOT NULL,
    [CompanyId] int  NOT NULL,
    [Firstname] nvarchar(100)  NOT NULL,
    [Middlename] nvarchar(100)  NULL,
    [Lastname] nvarchar(100)  NOT NULL,
    [Username] nvarchar(50)  NOT NULL,
    [Password] varbinary(300)  NULL,
    [Email] nvarchar(50)  NULL,
    [PlainPassword] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'MemberViews'
CREATE TABLE [dbo].[MemberViews] (
    [MemberId] int IDENTITY(1,1) NOT NULL,
    [CompanyId] int  NOT NULL,
    [Firstname] nvarchar(100)  NOT NULL,
    [Middlename] nvarchar(100)  NULL,
    [Lastname] nvarchar(100)  NOT NULL,
    [Username] nvarchar(50)  NOT NULL,
    [Password] nvarchar(100)  NULL,
    [Email] nvarchar(50)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [CompanyId] in table 'Companies'
ALTER TABLE [dbo].[Companies]
ADD CONSTRAINT [PK_Companies]
    PRIMARY KEY CLUSTERED ([CompanyId] ASC);
GO

-- Creating primary key on [HistoryId] in table 'Histories'
ALTER TABLE [dbo].[Histories]
ADD CONSTRAINT [PK_Histories]
    PRIMARY KEY CLUSTERED ([HistoryId] ASC);
GO

-- Creating primary key on [MemberId] in table 'Members'
ALTER TABLE [dbo].[Members]
ADD CONSTRAINT [PK_Members]
    PRIMARY KEY CLUSTERED ([MemberId] ASC);
GO

-- Creating primary key on [MemberId] in table 'MemberViews'
ALTER TABLE [dbo].[MemberViews]
ADD CONSTRAINT [PK_MemberViews]
    PRIMARY KEY CLUSTERED ([MemberId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------