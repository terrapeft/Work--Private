use [spans];
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_OofSpecsVenue]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_OofSpecsVenue];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_FwdSpecsVenue]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_FwdSpecsVenue];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_FutSpecsVenue]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_FutSpecsVenue];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_OofSpecs]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_OofSpecs];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_FwdSpecs]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_FwdSpecs];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_FutSpecs]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_FutSpecs];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_OofPf]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_OofPf];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_FwdPf]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_FwdPf];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_FutPf]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_FutPf];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_Exchange]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_Exchange];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_Venue]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_Venue];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_ClearingOrg]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CmeCntrSpecs_ClearingOrg];
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CmeCntrSpecs_Created]') AND type in (N'U')) 
BEGIN 
CREATE TABLE [dbo].[CmeCntrSpecs_Created](
	[spanFile] [nvarchar](50) NULL,
	[created] [nvarchar](50) NULL,
	[lastUpdated] [datetime] default sysutcdatetime() NOT NULL
) ON [PRIMARY]
END
GO

CREATE TABLE [dbo].[CmeCntrSpecs_OofSpecsVenue] ( 
[VenueId] [int] NOT NULL,
[OofSpecsId] [int] NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_OofSpecsVenue] PRIMARY KEY CLUSTERED ([VenueId] ASC, [OofSpecsId] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_FwdSpecsVenue] ( 
[VenueId] [int] NOT NULL,
[FwdSpecsId] [int] NOT NULL
, CONSTRAINT [PK_FwdSpecsVenue] PRIMARY KEY CLUSTERED ([VenueId] ASC, [FwdSpecsId] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_FutSpecsVenue] ( 
[VenueId] [int] NOT NULL,
[FutSpecsId] [int] NOT NULL
, CONSTRAINT [PK_FutSpecsVenue] PRIMARY KEY CLUSTERED ([VenueId] ASC, [FutSpecsId] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_OofSpecs] ( 
[Id] [int] identity(1, 1) NOT NULL,
[OofPfId] [int] NOT NULL,
[aliasDesc] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_OofSpecs] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_FwdSpecs] ( 
[Id] [int] identity(1, 1) NOT NULL,
[FwdPfId] [int] NOT NULL,
[aliasDesc] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_FwdSpecs] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_FutSpecs] ( 
[Id] [int] identity(1, 1) NOT NULL,
[FutPfId] [int] NOT NULL,
[aliasDesc] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_FutSpecs] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_OofPf] ( 
[Id] [int] identity(1, 1) NOT NULL,
[ExchangeId] [int] NOT NULL,
[status] [nvarchar] (1024) NOT NULL,
[rptOrder] [nvarchar] (1024) NOT NULL,
[pageBreak] [nvarchar] (1024) NOT NULL,
[pfCode] [nvarchar] (1024) NOT NULL,
[name] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_OofPf] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_FwdPf] ( 
[Id] [int] identity(1, 1) NOT NULL,
[ExchangeId] [int] NOT NULL,
[status] [nvarchar] (1024) NOT NULL,
[rptOrder] [nvarchar] (1024) NOT NULL,
[pageBreak] [nvarchar] (1024) NOT NULL,
[pfCode] [nvarchar] (1024) NOT NULL,
[name] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_FwdPf] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_FutPf] ( 
[Id] [int] identity(1, 1) NOT NULL,
[ExchangeId] [int] NOT NULL,
[status] [nvarchar] (1024) NOT NULL,
[rptOrder] [nvarchar] (1024) NOT NULL,
[pageBreak] [nvarchar] (1024) NOT NULL,
[pfCode] [nvarchar] (1024) NOT NULL,
[name] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_FutPf] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_Exchange] ( 
[Id] [int] identity(1, 1) NOT NULL,
[ClearingOrgId] [int] NOT NULL,
[exch] [nvarchar] (1024) NOT NULL,
[exchAlias] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_Exchange] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_Venue] ( 
[Id] [int] NOT NULL,
[name] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_Venue] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[CmeCntrSpecs_ClearingOrg] ( 
[Id] [int] identity(1, 1) NOT NULL,
[ec] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_ClearingOrg] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


ALTER TABLE [dbo].[CmeCntrSpecs_Exchange] WITH CHECK ADD CONSTRAINT [FK_ClearingOrg_Exchange] FOREIGN KEY([ClearingOrgId]) 
REFERENCES [dbo].[CmeCntrSpecs_ClearingOrg] ([Id]) 
GO
ALTER TABLE [dbo].[CmeCntrSpecs_FutPf] WITH CHECK ADD CONSTRAINT [FK_Exchange_FutPf] FOREIGN KEY([ExchangeId]) 
REFERENCES [dbo].[CmeCntrSpecs_Exchange] ([Id]) 
GO
ALTER TABLE [dbo].[CmeCntrSpecs_FutSpecs] WITH CHECK ADD CONSTRAINT [FK_FutPf_FutSpecs] FOREIGN KEY([FutPfId]) 
REFERENCES [dbo].[CmeCntrSpecs_FutPf] ([Id]) 
GO
ALTER TABLE [dbo].[CmeCntrSpecs_FwdPf] WITH CHECK ADD CONSTRAINT [FK_Exchange_FwdPf] FOREIGN KEY([ExchangeId]) 
REFERENCES [dbo].[CmeCntrSpecs_Exchange] ([Id]) 
GO
ALTER TABLE [dbo].[CmeCntrSpecs_FwdSpecs] WITH CHECK ADD CONSTRAINT [FK_FwdPf_FwdSpecs] FOREIGN KEY([FwdPfId]) 
REFERENCES [dbo].[CmeCntrSpecs_FwdPf] ([Id]) 
GO
ALTER TABLE [dbo].[CmeCntrSpecs_OofPf] WITH CHECK ADD CONSTRAINT [FK_Exchange_OofPf] FOREIGN KEY([ExchangeId]) 
REFERENCES [dbo].[CmeCntrSpecs_Exchange] ([Id]) 
GO
ALTER TABLE [dbo].[CmeCntrSpecs_OofSpecs] WITH CHECK ADD CONSTRAINT [FK_OofPf_OofSpecs] FOREIGN KEY([OofPfId]) 
REFERENCES [dbo].[CmeCntrSpecs_OofPf] ([Id]) 
GO
ALTER TABLE [dbo].[CmeCntrSpecs_FutSpecsVenue] WITH CHECK ADD CONSTRAINT [FK_FutSpecs_FutSpecsVenue] FOREIGN KEY([FutSpecsId]) 
REFERENCES [dbo].[CmeCntrSpecs_FutSpecs] ([Id]) 
GO
ALTER TABLE [dbo].[CmeCntrSpecs_FwdSpecsVenue] WITH CHECK ADD CONSTRAINT [FK_FwdSpecs_FwdSpecsVenue] FOREIGN KEY([FwdSpecsId]) 
REFERENCES [dbo].[CmeCntrSpecs_FwdSpecs] ([Id]) 
GO
ALTER TABLE [dbo].[CmeCntrSpecs_OofSpecsVenue] WITH CHECK ADD CONSTRAINT [FK_OofSpecs_OofSpecsVenue] FOREIGN KEY([OofSpecsId]) 
REFERENCES [dbo].[CmeCntrSpecs_OofSpecs] ([Id]) 
GO


 -- !!!!!!!!!!!!!! Run this script manually for the Spans database.