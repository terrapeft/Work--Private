USE [TRADEdataAPI]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_XymREUTERSTradedSeriesGLOBAL_XymRootLevelGLOBAL]') AND parent_object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]'))
ALTER TABLE [dbo].[XymREUTERSTradedSeriesGLOBAL] DROP CONSTRAINT [FK_XymREUTERSTradedSeriesGLOBAL_XymRootLevelGLOBAL]
GO

USE [TRADEdataAPI]
GO

/****** Object:  Table [dbo].[XymREUTERSTradedSeriesGLOBAL]    Script Date: 12/19/2014 13:09:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]') AND type in (N'U'))
DROP TABLE [dbo].[XymREUTERSTradedSeriesGLOBAL]
GO

/****** Object:  Table [dbo].[XymRootLevelGLOBAL]    Script Date: 12/19/2014 13:09:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XymRootLevelGLOBAL]') AND type in (N'U'))
DROP TABLE [dbo].[XymRootLevelGLOBAL]
GO


