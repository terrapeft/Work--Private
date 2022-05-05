use [spans];
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_Tier]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_Tier];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_TierProduct]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_TierProduct];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_Rates]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_Rates];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_MarginProduct]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_MarginProduct];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_BFCC]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_BFCC];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_Tiers]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_Tiers];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_VolSomRates]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_VolSomRates];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_ProductFamily]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_ProductFamily];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_Groups]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_Groups];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_BFCCProductFamily]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_BFCCProductFamily];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_MarginProductProductFamily]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginRates_MarginProductProductFamily];
END
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginRates_Created]') AND type in (N'U')) 
BEGIN 
CREATE TABLE [dbo].[MarginRates_Created](
	[spanFile] [nvarchar](50) NULL,
	[created] [nvarchar](50) NULL,
	[lastUpdated] [datetime] default sysutcdatetime() NOT NULL
) ON [PRIMARY]
END
GO

CREATE TABLE [dbo].[MarginRates_Tier] ( 
[Id] [int] identity(1, 1) NOT NULL,
[TierProductId] [int] NULL,
[TierSeqNumber] [tinyint] NULL,
[StartTierPeriodType] [nvarchar] (1024) NULL,
[StartPeriodSeq] [nvarchar] (1024) NULL,
[EndTierPeriodType] [nvarchar] (1024) NULL,
[EndPeriodSeq] [nvarchar] (1024) NULL,
[Effetive] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_Tier] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[MarginRates_TierProduct] ( 
[Id] [int] identity(1, 1) NOT NULL,
[TierId] [int] NULL,
[IsCurrent] [tinyint] NULL,
[TierProductDescription] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_TierProduct] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[MarginRates_MarginProduct] ( 
[Id] [int] identity(1, 1) NOT NULL,
[GroupId] [int] NULL,
[IsCurrent] [bit] NULL,
[Outright] [bit] NULL,
[IntraCommodity] [bit] NULL,
[InterCommodity] [bit] NULL,
[Intex] [bit] NULL,
[ProductDescription] [nvarchar] (1024) NULL,
[BFCC_ID] [int] NULL,
[CCCode] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_MarginProduct] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[MarginRates_Rates] ( 
[Id] [int] identity(1, 1) NOT NULL,
[MarginProductId] [int] NULL,
[RateType] [nvarchar] (1024) NULL,
[Ratio] [nvarchar] (1024) NULL,
[isPercentage] [bit] NULL,
[ISOCode] [nvarchar] (1024) NULL,
[Symbol] [nvarchar] (1024) NULL,
[InitialRequirement] [numeric] (18, 6) NULL,
[MaintenanceRequirement] [numeric] (18, 6) NULL,
[Effective] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_Rates] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[MarginRates_BFCC] ( 
[Id] [int] identity(1, 1) NOT NULL,
[CCCode] [nvarchar] (1024) NULL,
[CCName] [nvarchar] (1024) NULL,
[Effective] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_BFCC] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[MarginRates_Tiers] ( 
[Id] [int] identity(1, 1) NOT NULL,
[TierTypeDescription] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_Tiers] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[MarginRates_VolSomRates] ( 
[Id] [int] identity(1, 1) NOT NULL,
[Ticker] [nvarchar] (1024) NULL,
[ProductName] [nvarchar] (1024) NULL,
[isPctM] [bit] NULL,
[MaintToInit] [nvarchar] (1024) NULL,
[isPctV] [bit] NULL,
[VolScan] [nvarchar] (1024) NULL,
[isPctS] [bit] NULL,
[SOM] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_VolSomRates] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[MarginRates_ProductFamily] ( 
[Id] [nvarchar] (32) NOT NULL,
[PFCode] [nvarchar] (1024) NULL,
[Long_Name] [nvarchar] (1024) NULL,
[ScalingFactor] [numeric] (18, 6) NULL,
[PFType] [nvarchar] (1024) NULL,
[C21Type] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_ProductFamily] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[MarginRates_Groups] ( 
[Id] [int] identity(1, 1) NOT NULL,
[GroupDescription] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED ([Id] ASC))
GO

CREATE TABLE [dbo].[MarginRates_BFCCProductFamily] ( 
[ProductFamilyId] [nvarchar] (32) NOT NULL,
[BFCCID] [int] NOT NULL
, CONSTRAINT [PK_BFCCProductFamily] PRIMARY KEY CLUSTERED ([ProductFamilyId] ASC, [BFCCID] ASC))
GO

CREATE TABLE [dbo].[MarginRates_MarginProductProductFamily] ( 
[ProductFamilyId] [nvarchar] (32) NOT NULL,
[MarginProductId] [int] NOT NULL
, CONSTRAINT [PK_MarginProductProductFamily] PRIMARY KEY CLUSTERED ([ProductFamilyId] ASC, [MarginProductId] ASC))
GO


ALTER TABLE [dbo].[MarginRates_MarginProduct] WITH CHECK ADD CONSTRAINT [FK_Group_MarginProduct] FOREIGN KEY([GroupId]) 
REFERENCES [dbo].[MarginRates_Groups] ([Id]) 
GO

ALTER TABLE [dbo].[MarginRates_Rates] WITH CHECK ADD CONSTRAINT [FK_MarginProduct_Rates] FOREIGN KEY([MarginProductId]) 
REFERENCES [dbo].[MarginRates_MarginProduct] ([Id]) 
GO

ALTER TABLE [dbo].[MarginRates_TierProduct] WITH CHECK ADD CONSTRAINT [FK_Tiers_TierProduct] FOREIGN KEY([TierId]) 
REFERENCES [dbo].[MarginRates_Tiers] ([Id]) 
GO

ALTER TABLE [dbo].[MarginRates_Tier] WITH CHECK ADD CONSTRAINT [FK_TierProduct_Tier] FOREIGN KEY([TierProductId]) 
REFERENCES [dbo].[MarginRates_TierProduct] ([Id]) 
GO


 -- !!!!!!!!!!!!!! Run this script manually for the Spans database.