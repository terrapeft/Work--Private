USE [master]
GO
/****** Object:  Database [Users]    Script Date: 09/10/2014 15:27:48 ******/
CREATE DATABASE [Users] ON  PRIMARY 
( NAME = N'Users', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\Users.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Users_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\Users_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Users] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Users].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Users] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Users] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Users] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Users] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Users] SET ARITHABORT OFF
GO
ALTER DATABASE [Users] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Users] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Users] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Users] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Users] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Users] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Users] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Users] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Users] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Users] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Users] SET  DISABLE_BROKER
GO
ALTER DATABASE [Users] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Users] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Users] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Users] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Users] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Users] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Users] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Users] SET  READ_WRITE
GO
ALTER DATABASE [Users] SET RECOVERY FULL
GO
ALTER DATABASE [Users] SET  MULTI_USER
GO
ALTER DATABASE [Users] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Users] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'Users', N'ON'
GO
USE [Users]
GO
/****** Object:  User [IIS APPPOOL\TradeDataAppPool]    Script Date: 09/10/2014 15:27:48 ******/
CREATE USER [IIS APPPOOL\TradeDataAppPool] FOR LOGIN [IIS APPPOOL\TradeDataAppPool]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 09/10/2014 15:27:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 09/10/2014 15:27:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](500) NULL,
	[Phone] [bigint] NULL,
	[Fax] [bigint] NULL,
	[LastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 09/10/2014 15:27:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[Firstname] [nvarchar](100) NOT NULL,
	[Middlename] [nvarchar](100) NULL,
	[Lastname] [nvarchar](100) NOT NULL,
	[Phone] [bigint] NULL,
	[PhoneExt] [smallint] NULL,
	[Username] [varchar](15) NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[FailedLoginAttemptsCnt] [smallint] NOT NULL,
	[LastFailedAttempt] [datetime] NULL,
	[LastUpdated] [datetime] NOT NULL,
	[AccountExpirationDate] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_Users] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 09/10/2014 15:27:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[RoleId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsageStats]    Script Date: 09/10/2014 15:27:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsageStats](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[RequestDate] [datetime] NULL,
	[StoredProcedure] [nvarchar](128) NULL,
	[RequestParameters] [nvarchar](500) NULL,
	[DataFormat] [nchar](10) NULL,
	[CountryLookup] [nvarchar](50) NOT NULL,
	[Ip] [nvarchar](15) NULL,
	[FullLookupInfo] [nvarchar](500) NULL,
	[RequestDuration] [bigint] NULL,
 CONSTRAINT [PK_UsageStats] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF_Companies_LastUpdate]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF_Companies_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdated]
GO
/****** Object:  Default [DF_Users_CompanyId]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_CompanyId]  DEFAULT ((1)) FOR [CompanyId]
GO
/****** Object:  Default [DF_Users_IsActive]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_Users_FailedLoginAttemptsCnt]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_FailedLoginAttemptsCnt]  DEFAULT ((0)) FOR [FailedLoginAttemptsCnt]
GO
/****** Object:  Default [DF_Users_When]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_When]  DEFAULT (getutcdate()) FOR [LastUpdated]
GO
/****** Object:  Default [DF_UsageStats_RequestDate]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[UsageStats] ADD  CONSTRAINT [DF_UsageStats_RequestDate]  DEFAULT (getutcdate()) FOR [RequestDate]
GO
/****** Object:  ForeignKey [FK_Users_Companies]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Companies] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Companies]
GO
/****** Object:  ForeignKey [FK_Users_Roles]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
/****** Object:  ForeignKey [FK_UserRole_Roles]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Roles]
GO
/****** Object:  ForeignKey [FK_UserRole_Users1]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Users1] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Users1]
GO
/****** Object:  ForeignKey [FK_UsageStats_Users]    Script Date: 09/10/2014 15:27:49 ******/
ALTER TABLE [dbo].[UsageStats]  WITH CHECK ADD  CONSTRAINT [FK_UsageStats_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UsageStats] CHECK CONSTRAINT [FK_UsageStats_Users]
GO
