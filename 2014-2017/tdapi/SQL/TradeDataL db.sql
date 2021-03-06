USE [master]
GO
/****** Object:  Database [TradeDataL]    Script Date: 09/01/2014 20:14:04 ******/
CREATE DATABASE [TradeDataL] ON  PRIMARY 
( NAME = N'TradeDataL', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\TradeDataL.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TradeDataL_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008\MSSQL\DATA\TradeDataL_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TradeDataL] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TradeDataL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TradeDataL] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [TradeDataL] SET ANSI_NULLS OFF
GO
ALTER DATABASE [TradeDataL] SET ANSI_PADDING OFF
GO
ALTER DATABASE [TradeDataL] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [TradeDataL] SET ARITHABORT OFF
GO
ALTER DATABASE [TradeDataL] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [TradeDataL] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [TradeDataL] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [TradeDataL] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [TradeDataL] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [TradeDataL] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [TradeDataL] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [TradeDataL] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [TradeDataL] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [TradeDataL] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [TradeDataL] SET  DISABLE_BROKER
GO
ALTER DATABASE [TradeDataL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [TradeDataL] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [TradeDataL] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [TradeDataL] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [TradeDataL] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [TradeDataL] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [TradeDataL] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [TradeDataL] SET  READ_WRITE
GO
ALTER DATABASE [TradeDataL] SET RECOVERY FULL
GO
ALTER DATABASE [TradeDataL] SET  MULTI_USER
GO
ALTER DATABASE [TradeDataL] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [TradeDataL] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'TradeDataL', N'ON'
GO
USE [TradeDataL]
GO
/****** Object:  Table [dbo].[Manufacturers]    Script Date: 09/01/2014 20:14:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturers](
	[ManufacturerId] [int] IDENTITY(1,1) NOT NULL,
	[ManufacturerName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Manufacturers] PRIMARY KEY CLUSTERED 
(
	[ManufacturerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grades]    Script Date: 09/01/2014 20:14:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grades](
	[GradeId] [int] IDENTITY(1,1) NOT NULL,
	[GradeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Grades] PRIMARY KEY CLUSTERED 
(
	[GradeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Options]    Script Date: 09/01/2014 20:14:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Options](
	[OptionId] [int] IDENTITY(1,1) NOT NULL,
	[OptionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Options] PRIMARY KEY CLUSTERED 
(
	[OptionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Models]    Script Date: 09/01/2014 20:14:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Models](
	[ModelId] [int] IDENTITY(1,1) NOT NULL,
	[ModelName] [nvarchar](50) NOT NULL,
	[ManufacturerId] [int] NOT NULL,
 CONSTRAINT [PK_Models] PRIMARY KEY CLUSTERED 
(
	[ModelId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GradeOption]    Script Date: 09/01/2014 20:14:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GradeOption](
	[OptionId] [int] NOT NULL,
	[GradeId] [int] NOT NULL,
 CONSTRAINT [PK_GradeOption] PRIMARY KEY CLUSTERED 
(
	[OptionId] ASC,
	[GradeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cars]    Script Date: 09/01/2014 20:14:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cars](
	[CarId] [int] IDENTITY(1,1) NOT NULL,
	[CarColor] [nvarchar](50) NOT NULL,
	[ModelId] [int] NOT NULL,
	[GradeId] [int] NOT NULL,
 CONSTRAINT [PK_Cars] PRIMARY KEY CLUSTERED 
(
	[CarId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spGetCars]    Script Date: 09/01/2014 20:14:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP PROCEDURE spGetCars
--GO

create procedure [dbo].[spGetCars](@param1 int, @param2 int output) as

select c. CarId, mn.ManufacturerName, m.ModelName, g.GradeName, c.CarColor
from Cars c with (nolock) join Models m with (nolock) on c.ModelId = m.ModelId
     join Manufacturers mn with (nolock) on m.ManufacturerId = mn.ManufacturerId
     join Grades g with (nolock) on g.GradeId = c.GradeId
     
select @param2 = 42;

return (select count(*) from (
select c. CarId, mn.ManufacturerName, m.ModelName, g.GradeName, c.CarColor
from Cars c with (nolock) join Models m with (nolock) on c.ModelId = m.ModelId
     join Manufacturers mn with (nolock) on m.ManufacturerId = mn.ManufacturerId
     join Grades g with (nolock) on g.GradeId = c.GradeId
     

)as c);
GO
/****** Object:  ForeignKey [FK_Models_Manufacturers]    Script Date: 09/01/2014 20:14:05 ******/
ALTER TABLE [dbo].[Models]  WITH CHECK ADD  CONSTRAINT [FK_Models_Manufacturers] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturers] ([ManufacturerId])
GO
ALTER TABLE [dbo].[Models] CHECK CONSTRAINT [FK_Models_Manufacturers]
GO
/****** Object:  ForeignKey [FK_GradeOption_Grades]    Script Date: 09/01/2014 20:14:05 ******/
ALTER TABLE [dbo].[GradeOption]  WITH CHECK ADD  CONSTRAINT [FK_GradeOption_Grades] FOREIGN KEY([GradeId])
REFERENCES [dbo].[Grades] ([GradeId])
GO
ALTER TABLE [dbo].[GradeOption] CHECK CONSTRAINT [FK_GradeOption_Grades]
GO
/****** Object:  ForeignKey [FK_GradeOption_Options]    Script Date: 09/01/2014 20:14:05 ******/
ALTER TABLE [dbo].[GradeOption]  WITH CHECK ADD  CONSTRAINT [FK_GradeOption_Options] FOREIGN KEY([OptionId])
REFERENCES [dbo].[Options] ([OptionId])
GO
ALTER TABLE [dbo].[GradeOption] CHECK CONSTRAINT [FK_GradeOption_Options]
GO
/****** Object:  ForeignKey [FK_Cars_Models]    Script Date: 09/01/2014 20:14:05 ******/
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [FK_Cars_Models] FOREIGN KEY([ModelId])
REFERENCES [dbo].[Models] ([ModelId])
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [FK_Cars_Models]
GO
