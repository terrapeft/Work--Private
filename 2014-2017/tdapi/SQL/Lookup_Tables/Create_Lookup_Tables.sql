USE [TRADEdataAPI]
GO

/****** Object:  Table [dbo].[XymRootLevelGLOBAL]    Script Date: 12/19/2014 13:08:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XymRootLevelGLOBAL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[XymRootLevelGLOBAL](
	[ExchangeCode] [varchar](12) COLLATE Latin1_General_CI_AI NOT NULL,
	[ExchangeName] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[ExchangeCountry] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[ContractCode] [varchar](38) COLLATE Latin1_General_CI_AI NULL,
	[ContractNumber] [int] NOT NULL,
	[ContractName] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[FutureOrOption] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[CompositeReutersExchange] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[CompositeReutersUnderlyingRIC] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[CompositeReutersRootRIC] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[ElectronicReutersExchange] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[ElectronicReutersUnderlyingRIC] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[ElectronicReutersRootRIC] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[FloorReutersExchange] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[FloorReutersUnderlyingRIC] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[FloorReutersRootRIC] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[BloombergExchangeCode] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[BloombergCode] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[BloombergYellowKey] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[GMIExchangeCode] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[GMIContractCode] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[GMIFutureOrOption] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[ClearingExchangeTicker] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[ElectronicExchangeTicker] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[FloorExchangeTicker] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[ContractType] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[FSAContractType] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[ACN] [varchar](4) COLLATE Latin1_General_CI_AI NULL,
	[TickerCode] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[GLCodeMarket] [varchar](2) COLLATE Latin1_General_CI_AI NULL,
	[GLMapCode] [varchar](12) COLLATE Latin1_General_CI_AI NULL,
	[GLCodeExchangePlace] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[GLCode] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[UBIXExchangeCode] [varchar](5) COLLATE Latin1_General_CI_AI NULL,
	[UBIXContractCodeInternal] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[UBIXFOQualifier] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[ISOMIC] [varchar](4) COLLATE Latin1_General_CI_AI NULL,
	[ClearVisionCode] [varchar](8) COLLATE Latin1_General_CI_AI NULL,
	[RISCCode] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[NumericContractSize] [decimal](22, 2) NULL,
	[TickSize] [decimal](17, 8) NULL,
	[TickNumerator] [decimal](17, 2) NULL,
	[TickDenominator] [decimal](17, 2) NULL,
	[TickValue] [decimal](17, 8) NULL,
	[QuoteFraction] [decimal](17, 8) NULL,
	[TickSizeChar] [varchar](18) COLLATE Latin1_General_CI_AI NULL,
	[TickValueChar] [varchar](18) COLLATE Latin1_General_CI_AI NULL,
	[QuoteFractionChar] [varchar](18) COLLATE Latin1_General_CI_AI NULL,
	[ExerciseType] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[ContractSizeText] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[BaseCurrency] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[SettlementCurrency] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[AIIExchangeSymbol] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[GMISubExchangeCode] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[MiFIDIndicator] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[ActualContractType] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[StartDate] [datetime] NULL,
	[DelistDate] [datetime] NULL,
	[CycleCode] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[SuspendedIndicator] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[ProductType] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[MaturityType] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[Delivery] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[PremiumPayment] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[RandNMarketCode] [varchar](4) COLLATE Latin1_General_CI_AI NULL,
	[RandNExchangeID] [varchar](6) COLLATE Latin1_General_CI_AI NULL,
	[RandNCode] [varchar](6) COLLATE Latin1_General_CI_AI NULL,
	[RandNExchangeCode] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[RandNExternalCode] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[TickValueDescription] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[OtherUnitCode] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[OtherUnitDescription] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[ElectronicCQGName] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[ShortContractName] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[BloombergExchangeCodeUSByTicker] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[BloombergCodeUSByTicker] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[BloombergYellowKeyUSByTicker] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [PK_XymRootLevelGLOBAL] PRIMARY KEY CLUSTERED 
(
	[ExchangeCode] ASC,
	[ContractNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO

USE [TRADEdataAPI]
GO

/****** Object:  Table [dbo].[XymREUTERSTradedSeriesGLOBAL]    Script Date: 12/19/2014 13:08:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[XymREUTERSTradedSeriesGLOBAL](
	[ExchangeCode] [varchar](12) COLLATE Latin1_General_CI_AI NULL,
	[ISOMIC] [varchar](4) COLLATE Latin1_General_CI_AI NULL,
	[ContractNumber] [int] NULL,
	[ContractCode] [varchar](25) COLLATE Latin1_General_CI_AI NULL,
	[ContractName] [varchar](263) COLLATE Latin1_General_CI_AI NULL,
	[FutureOrOption] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[ContractSize] [decimal](12, 2) NULL,
	[ContractType] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[FSAContractType] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[StartDate] [datetime] NULL,
	[DelistDate] [datetime] NULL,
	[ReutersExchangeCode] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[ReutersUnderlyingRIC] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[ReutersRootRIC] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[ReutersRIC] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[DateType] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[PromptMonth] [varchar](6) COLLATE Latin1_General_CI_AI NULL,
	[PromptMonthCode] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[ActionDate] [varchar](8) COLLATE Latin1_General_CI_AI NULL,
	[ReutersStrikePrice] [varchar](25) COLLATE Latin1_General_CI_AI NULL,
	[ReutersStrikePriceCurrency] [varchar](3) COLLATE Latin1_General_CI_AI NULL,
	[ReutersFOIndicator] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[ReutersSessionTypeIndicator] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[ReutersCompositeIndicator] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[ACN] [varchar](4) COLLATE Latin1_General_CI_AI NULL,
	[ActionIndicator] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[ReutersExpiryDate] [varchar](8) COLLATE Latin1_General_CI_AI NULL,
	[ProductType] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[ISIN] [varchar](12) COLLATE Latin1_General_CI_AI NULL,
	[ActualContractType] [varchar](1) COLLATE Latin1_General_CI_AI NULL,
	[TickerCode] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[ContractYear] [smallint] NULL,
	[ContractMonth] [tinyint] NULL,
	[FirstTradingDate] [datetime] NULL,
	[AIIExchangeCode] [char](4) COLLATE Latin1_General_CI_AI NULL,
	[AIIExchangeProductCode] [char](12) COLLATE Latin1_General_CI_AI NULL,
	[AIIDerivativeType] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[AIIPutCallIdentifier] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[AIIExpiryOrDeliveryDate] [char](10) COLLATE Latin1_General_CI_AI NULL,
	[AIIStrikePrice] [char](19) COLLATE Latin1_General_CI_AI NULL,
	[CycleCode] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[LotSize] [varchar](255) COLLATE Latin1_General_CI_AS NULL,
	[StrikePriceMultiplier] [decimal](12, 5) NULL,
	[CFICode] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[CFIUnderlyingAssetCode] [varchar](3) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO


USE [TRADEdataAPI]
/****** Object:  Index [IX_XymREUTERSTradedSeriesGLOBAL_ActionDate]    Script Date: 12/19/2014 13:08:39 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]') AND name = N'IX_XymREUTERSTradedSeriesGLOBAL_ActionDate')
CREATE NONCLUSTERED INDEX [IX_XymREUTERSTradedSeriesGLOBAL_ActionDate] ON [dbo].[XymREUTERSTradedSeriesGLOBAL] 
(
	[ActionDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO


USE [TRADEdataAPI]
/****** Object:  Index [IX_XymREUTERSTradedSeriesGLOBAL_ContractMonth]    Script Date: 12/19/2014 13:08:39 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]') AND name = N'IX_XymREUTERSTradedSeriesGLOBAL_ContractMonth')
CREATE NONCLUSTERED INDEX [IX_XymREUTERSTradedSeriesGLOBAL_ContractMonth] ON [dbo].[XymREUTERSTradedSeriesGLOBAL] 
(
	[ContractMonth] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO


USE [TRADEdataAPI]
/****** Object:  Index [IX_XymREUTERSTradedSeriesGLOBAL_ContractYear]    Script Date: 12/19/2014 13:08:39 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]') AND name = N'IX_XymREUTERSTradedSeriesGLOBAL_ContractYear')
CREATE NONCLUSTERED INDEX [IX_XymREUTERSTradedSeriesGLOBAL_ContractYear] ON [dbo].[XymREUTERSTradedSeriesGLOBAL] 
(
	[ContractYear] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO


USE [TRADEdataAPI]
/****** Object:  Index [IX_XymREUTERSTradedSeriesGLOBAL_ExchangeCode_ContractNumber]    Script Date: 12/19/2014 13:08:39 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]') AND name = N'IX_XymREUTERSTradedSeriesGLOBAL_ExchangeCode_ContractNumber')
CREATE NONCLUSTERED INDEX [IX_XymREUTERSTradedSeriesGLOBAL_ExchangeCode_ContractNumber] ON [dbo].[XymREUTERSTradedSeriesGLOBAL] 
(
	[ExchangeCode] ASC,
	[ContractNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [TRADEdataAPI]
/****** Object:  Index [IX_XymREUTERSTradedSeriesGLOBAL_ExchangeCodeReutersSessionTypeIndicator]    Script Date: 12/19/2014 13:08:39 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]') AND name = N'IX_XymREUTERSTradedSeriesGLOBAL_ExchangeCodeReutersSessionTypeIndicator')
CREATE NONCLUSTERED INDEX [IX_XymREUTERSTradedSeriesGLOBAL_ExchangeCodeReutersSessionTypeIndicator] ON [dbo].[XymREUTERSTradedSeriesGLOBAL] 
(
	[ExchangeCode] ASC,
	[ReutersSessionTypeIndicator] ASC
)
INCLUDE ( [ContractNumber],
[ReutersExchangeCode],
[ReutersUnderlyingRIC],
[ReutersRootRIC],
[ReutersRIC],
[DateType],
[PromptMonthCode],
[ActionDate],
[ReutersStrikePrice],
[ReutersStrikePriceCurrency],
[ReutersFOIndicator],
[ReutersCompositeIndicator],
[ReutersExpiryDate],
[ContractYear],
[ContractMonth],
[CycleCode],
[StrikePriceMultiplier]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [TRADEdataAPI]
/****** Object:  Index [IX_XymREUTERSTradedSeriesGLOBAL_ReutersExpiryDate]    Script Date: 12/19/2014 13:08:39 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]') AND name = N'IX_XymREUTERSTradedSeriesGLOBAL_ReutersExpiryDate')
CREATE NONCLUSTERED INDEX [IX_XymREUTERSTradedSeriesGLOBAL_ReutersExpiryDate] ON [dbo].[XymREUTERSTradedSeriesGLOBAL] 
(
	[ReutersExpiryDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_XymREUTERSTradedSeriesGLOBAL_XymRootLevelGLOBAL]') AND parent_object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]'))
ALTER TABLE [dbo].[XymREUTERSTradedSeriesGLOBAL]  WITH CHECK ADD  CONSTRAINT [FK_XymREUTERSTradedSeriesGLOBAL_XymRootLevelGLOBAL] FOREIGN KEY([ExchangeCode], [ContractNumber])
REFERENCES [dbo].[XymRootLevelGLOBAL] ([ExchangeCode], [ContractNumber])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_XymREUTERSTradedSeriesGLOBAL_XymRootLevelGLOBAL]') AND parent_object_id = OBJECT_ID(N'[dbo].[XymREUTERSTradedSeriesGLOBAL]'))
ALTER TABLE [dbo].[XymREUTERSTradedSeriesGLOBAL] CHECK CONSTRAINT [FK_XymREUTERSTradedSeriesGLOBAL_XymRootLevelGLOBAL]
GO


