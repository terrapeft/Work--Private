use [spans];
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_PointDefScanPoint]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_PointDefScanPoint];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_PointDefDeltaPoint]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_PointDefDeltaPoint];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_BFPFLinkageMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_BFPFLinkageMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_XMAMasterRounding]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_XMAMasterRounding];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_ClearingOrgMasterRounding]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_ClearingOrgMasterRounding];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_ProductFamilyMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_ProductFamilyMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_PointDef]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_PointDef];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_BFExchLinkageMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_BFExchLinkageMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_BFCOLinkageMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_BFCOLinkageMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_ExchangeMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_ExchangeMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_DeltaPoint]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_DeltaPoint];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_ScanPoint]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_ScanPoint];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_Rounding]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_Rounding];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_AccountTypeMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_AccountTypeMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_SegTypeMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_SegTypeMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_CurrencyMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_CurrencyMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_PBClassDefMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_PBClassDefMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_ClearingOrgMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_ClearingOrgMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgMaster_XMAMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OrgMaster_XMAMaster];
END
GO

CREATE TABLE [dbo].[OrgMaster_PointDefScanPoint] ( 
[PointDefId] [int] NULL,
[ScanPointId] [nvarchar] (32) NULL
--, CONSTRAINT [PK_PointDefScanPoint] PRIMARY KEY CLUSTERED ([PointDefId] ASC, [ScanPointId] ASC)
)
GO


CREATE TABLE [dbo].[OrgMaster_PointDefDeltaPoint] ( 
[PointDefId] [int] NULL,
[DeltaPointId] [nvarchar] (32) NULL
--, CONSTRAINT [PK_PointDefDeltaPoint] PRIMARY KEY CLUSTERED ([PointDefId] ASC, [DeltaPointId] ASC)
)
GO


CREATE TABLE [dbo].[OrgMaster_BFPFLinkageMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[BFExchLinkageMasterId] [int] NOT NULL,
[PFCode] [nvarchar] (1024) NULL,
[Type] [tinyint] NOT NULL,
[PFCodeAlias] [nvarchar] (1024) NULL,
[SettleDecLoc] [tinyint] NOT NULL,
[StrikeDecLoc] [nvarchar] (1024) NULL,
[SettleAlignCode] [nvarchar] (1024) NULL,
[StrikeAlignCode] [nvarchar] (1024) NULL,
[CabinetOptionValue] [numeric] (18, 6) NOT NULL,
[SkipOnLoad] [tinyint] NOT NULL,
[CurrentlyActive] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_BFPFLinkageMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_XMAMasterRounding] ( 
[RoundingId] [nvarchar] (32) NOT NULL,
[XMAMasterId] [int] NOT NULL
, CONSTRAINT [PK_XMAMasterRounding] PRIMARY KEY CLUSTERED ([RoundingId] ASC, [XMAMasterId] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_ClearingOrgMasterRounding] ( 
[RoundingId] [nvarchar] (32) NOT NULL,
[ClearingOrgMasterId] [int] NOT NULL
, CONSTRAINT [PK_ClearingOrgMasterRounding] PRIMARY KEY CLUSTERED ([RoundingId] ASC, [ClearingOrgMasterId] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_ProductFamilyMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[ExchangeMasterId] [int] NOT NULL,
[PFCode] [nvarchar] (1024) NULL,
[Type] [tinyint] NOT NULL,
[PFName] [nvarchar] (1024) NULL,
[CVM] [numeric] (18, 6) NOT NULL,
[SettleDecLoc] [tinyint] NOT NULL,
[StrikeDecLoc] [nvarchar] (1024) NULL,
[SettleAlignCode] [nvarchar] (1024) NULL,
[StrikeAlignCode] [nvarchar] (1024) NULL,
[CabinetOptionValue] [numeric] (18, 6) NOT NULL,
[SkipOnLoad] [tinyint] NOT NULL,
[CurrentlyActive] [nvarchar] (1024) NULL,
[PricingModel] [nvarchar] (1024) NULL,
[PriceQuotationMethod] [nvarchar] (1024) NULL,
[ValuationMethod] [nvarchar] (1024) NULL,
[SettlementMethod] [nvarchar] (1024) NULL,
[SettleCurrencyCode] [nvarchar] (1024) NULL,
[CountryCode] [nvarchar] (1024) NULL,
[ExerciseStyle] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_ProductFamilyMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_PointDef] ( 
[id] [int] identity(1, 1) NOT NULL,
[XMAMasterId] [int] NULL,
[ClearingOrgMasterId] [int] NULL,
[PBClassID] [tinyint] NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_PointDef] PRIMARY KEY CLUSTERED ([id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_BFExchLinkageMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[BFCOLinkageMasterId] [int] NOT NULL,
[ExchAcro] [nvarchar] (1024) NULL,
[ExchAcroAlias] [nvarchar] (1024) NULL,
[ExchCodeAlias] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_BFExchLinkageMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_BFCOLinkageMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[XMAMasterId] [int] NOT NULL,
[COAcro] [nvarchar] (1024) NULL,
[COAcroAlias] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_BFCOLinkageMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_ExchangeMaster] ( 
[ClearingOrgMasterId] [int] NOT NULL,
[Id] [int] identity(1, 1) NOT NULL,
[ExchAcro] [nvarchar] (1024) NULL,
[ExchCode] [nvarchar] (1024) NULL,
[ExchName] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_ExchangeMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_DeltaPoint] ( 
[Id] [nvarchar] (32) NULL,
[PointNumber] [tinyint] NOT NULL,
[PriceScanMult] [numeric] (18, 6) NOT NULL,
[PriceScanNumerator] [numeric] (18, 6) NOT NULL,
[PriceScanDenominator] [numeric] (18, 6) NOT NULL,
[VolScanMult] [numeric] (18, 6) NOT NULL,
[VolScanNumerator] [numeric] (18, 6) NOT NULL,
[VolScanDenominator] [numeric] (18, 6) NOT NULL,
[DeltaProbWeight] [numeric] (18, 6) NOT NULL,
[MissingElements] [xml] NULL
--, CONSTRAINT [PK_DeltaPoint] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO


CREATE TABLE [dbo].[OrgMaster_ScanPoint] ( 
[Id] [nvarchar] (32) NULL,
[PointNumber] [tinyint] NOT NULL,
[PriceScanMult] [numeric] (18, 6) NOT NULL,
[PriceScanNumerator] [numeric] (18, 6) NOT NULL,
[PriceScanDenominator] [numeric] (18, 6) NOT NULL,
[VolScanMult] [numeric] (18, 6) NOT NULL,
[VolScanNumerator] [numeric] (18, 6) NOT NULL,
[VolScanDenominator] [numeric] (18, 6) NOT NULL,
[DeltaProbWeight] [numeric] (18, 6) NOT NULL,
[PairedPointNumber] [tinyint] NOT NULL,
[MissingElements] [xml] NULL
--, CONSTRAINT [PK_ScanPoint] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO


CREATE TABLE [dbo].[OrgMaster_Rounding] ( 
[Id] [nvarchar] (32) NULL,
[RoundingPlace] [tinyint] NOT NULL,
[RoundingType] [tinyint] NOT NULL,
[DecimalDigits] [tinyint] NOT NULL,
[MissingElements] [xml] NULL
--, CONSTRAINT [PK_Rounding] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO


CREATE TABLE [dbo].[OrgMaster_AccountTypeMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[AcctTypeCode] [nvarchar] (1024) NULL,
[AcctTypeDesc] [nvarchar] (1024) NULL,
[IsClearingLevel] [tinyint] NOT NULL,
[IsGrossMargin] [tinyint] NOT NULL,
[Priority] [tinyint] NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_AccountTypeMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_SegTypeMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[SegTypeCode] [nvarchar] (1024) NULL,
[SegTypeDesc] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_SegTypeMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_CurrencyMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[CurrencyCode] [nvarchar] (1024) NULL,
[CurrencySymbol] [nvarchar] (1024) NULL,
[CurrencyName] [nvarchar] (1024) NULL,
[DecPos] [tinyint] NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_CurrencyMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_PBClassDefMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[PBClassID] [tinyint] NOT NULL,
[PBClassCode] [nvarchar] (1024) NULL,
[PBClassDesc] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_PBClassDefMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_ClearingOrgMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[COAcro] [nvarchar] (1024) NULL,
[COName] [nvarchar] (1024) NULL,
[COAcroAlias] [nvarchar] (1024) NULL,
[IsGrossMargin] [tinyint] NOT NULL,
[DoContractScaling] [tinyint] NOT NULL,
[DoIntercommSpreading] [tinyint] NOT NULL,
[LoadDeltaScalingFactors] [tinyint] NOT NULL,
[LoadRedefRecords] [tinyint] NOT NULL,
[LimitOptionValue] [tinyint] NOT NULL,
[AggregateByPosType] [tinyint] NOT NULL,
[SOMGross] [tinyint] NOT NULL,
[PrefixCCNames] [tinyint] NOT NULL,
[LoadScanSpreads] [tinyint] NOT NULL,
[CustUseLov] [tinyint] NOT NULL,
[UseLovPct] [numeric] (18, 6) NOT NULL,
[LimitSubAccountOffset] [tinyint] NOT NULL,
[DefaultWFPRMeth] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_ClearingOrgMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[OrgMaster_XMAMaster] ( 
[Id] [int] identity(1, 1) NOT NULL,
[COAcro] [nvarchar] (1024) NULL,
[COName] [nvarchar] (1024) NULL,
[COAcroAlias] [nvarchar] (1024) NULL,
[IsGrossMargin] [tinyint] NOT NULL,
[DoContractScaling] [tinyint] NOT NULL,
[DoIntercommSpreading] [tinyint] NOT NULL,
[LoadDeltaScalingFactors] [tinyint] NOT NULL,
[LoadRedefRecords] [tinyint] NOT NULL,
[LimitOptionValue] [tinyint] NOT NULL,
[AggregateByPosType] [tinyint] NOT NULL,
[SOMGross] [tinyint] NOT NULL,
[PrefixCCNames] [tinyint] NOT NULL,
[LoadScanSpreads] [tinyint] NOT NULL,
[CustUseLov] [tinyint] NOT NULL,
[UseLovPct] [numeric] (18, 6) NOT NULL,
[LimitSubAccountOffset] [tinyint] NOT NULL,
[DefaultWFPRMeth] [nvarchar] (1024) NULL,
[BusFuncType] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_XMAMaster] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


ALTER TABLE [dbo].[OrgMaster_ProductFamilyMaster] WITH CHECK ADD CONSTRAINT [FK_ExchangeMaster_ProductFamilyMaster] FOREIGN KEY([ExchangeMasterId]) 
REFERENCES [dbo].[OrgMaster_ExchangeMaster] ([Id]) 
GO
ALTER TABLE [dbo].[OrgMaster_ExchangeMaster] WITH CHECK ADD CONSTRAINT [FK_ClearingOrgMaster_ExchangeMaster] FOREIGN KEY([ClearingOrgMasterId]) 
REFERENCES [dbo].[OrgMaster_ClearingOrgMaster] ([Id]) 
GO
ALTER TABLE [dbo].[OrgMaster_PointDef] WITH CHECK ADD CONSTRAINT [FK_ClearingOrgMaster_PointDef] FOREIGN KEY([ClearingOrgMasterId]) 
REFERENCES [dbo].[OrgMaster_ClearingOrgMaster] ([Id]) 
GO
ALTER TABLE [dbo].[OrgMaster_ClearingOrgMasterRounding] WITH CHECK ADD CONSTRAINT [FK_ClearingOrgMaster_ClearingOrgMasterRounding] FOREIGN KEY([ClearingOrgMasterId]) 
REFERENCES [dbo].[OrgMaster_ClearingOrgMaster] ([Id]) 
GO
ALTER TABLE [dbo].[OrgMaster_XMAMasterRounding] WITH CHECK ADD CONSTRAINT [FK_XMAMaster_XMAMasterRounding] FOREIGN KEY([XMAMasterId]) 
REFERENCES [dbo].[OrgMaster_XMAMaster] ([Id]) 
GO
ALTER TABLE [dbo].[OrgMaster_PointDef] WITH CHECK ADD CONSTRAINT [FK_XMAMaster_PointDef] FOREIGN KEY([XMAMasterId]) 
REFERENCES [dbo].[OrgMaster_XMAMaster] ([Id]) 
GO
ALTER TABLE [dbo].[OrgMaster_BFCOLinkageMaster] WITH CHECK ADD CONSTRAINT [FK_XMAMaster_BFCOLinkageMaster] FOREIGN KEY([XMAMasterId]) 
REFERENCES [dbo].[OrgMaster_XMAMaster] ([Id]) 
GO
ALTER TABLE [dbo].[OrgMaster_BFExchLinkageMaster] WITH CHECK ADD CONSTRAINT [FK_BFCOLinkageMaster_BFExchLinkageMaster] FOREIGN KEY([BFCOLinkageMasterId]) 
REFERENCES [dbo].[OrgMaster_BFCOLinkageMaster] ([Id]) 
GO
ALTER TABLE [dbo].[OrgMaster_BFPFLinkageMaster] WITH CHECK ADD CONSTRAINT [FK_BFExchLinkageMaster_BFPFLinkageMaster] FOREIGN KEY([BFExchLinkageMasterId]) 
REFERENCES [dbo].[OrgMaster_BFExchLinkageMaster] ([Id]) 
GO
ALTER TABLE [dbo].[OrgMaster_PointDefDeltaPoint] WITH CHECK ADD CONSTRAINT [FK_PointDef_PointDefDeltaPoint] FOREIGN KEY([PointDefId]) 
REFERENCES [dbo].[OrgMaster_PointDef] ([id]) 
GO
ALTER TABLE [dbo].[OrgMaster_PointDefScanPoint] WITH CHECK ADD CONSTRAINT [FK_PointDef_PointDefScanPoint] FOREIGN KEY([PointDefId]) 
REFERENCES [dbo].[OrgMaster_PointDef] ([id]) 
GO


 -- !!!!!!!!!!!!!! Run this script manually for the Spans database.