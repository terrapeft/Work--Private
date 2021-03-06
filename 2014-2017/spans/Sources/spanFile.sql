USE [Spans]
GO
/****** Object:  Table [dbo].[BusFunc]    Script Date: 07/21/2015 15:00:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFunc]') AND type in (N'U'))
DROP TABLE [dbo].[BusFunc]
GO
/****** Object:  Table [dbo].[BusFuncCcDef]    Script Date: 07/21/2015 15:00:05 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__BusFuncCc__concS__77551981]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[BusFuncCcDef] DROP CONSTRAINT [DF__BusFuncCc__concS__77551981]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDef]
GO
/****** Object:  Table [dbo].[BusFuncCcDefAdjRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefAdjRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefAdjRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefBasisRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefBasisRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefBasisRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefCdsRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefCdsRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefCdsRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefConcAdjRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefConcAdjRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefConcAdjRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpread]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpread]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpread]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadPLeg]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadPLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadPLeg]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadPLegRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadPLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadPLegRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadPmpsRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadPmpsRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadRpLeg]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadRpLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadRpLeg]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadRpLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadRpLegRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadTLeg]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadTLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadTLeg]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadTLegRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadTLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadTLegRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadVolRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadVolRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadVolRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadVolRateRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefDSpreadVolRateRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefFxHvarSetIds]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefFxHvarSetIds]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefFxHvarSetIds]
GO
/****** Object:  Table [dbo].[BusFuncCcDefGroup]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefGroup]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefGroup]
GO
/****** Object:  Table [dbo].[BusFuncCcDefHvarSetIds]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefHvarSetIds]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefHvarSetIds]
GO
/****** Object:  Table [dbo].[BusFuncCcDefInterTier]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefInterTier]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefInterTier]
GO
/****** Object:  Table [dbo].[BusFuncCcDefInterTierRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefInterTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefInterTierRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefInterTierScanRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefInterTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefInterTierScanRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefIntraTier]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefIntraTier]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefIntraTier]
GO
/****** Object:  Table [dbo].[BusFuncCcDefIntraTierRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefIntraTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefIntraTierRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefIntraTierScanRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefIntraTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefIntraTierScanRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefIntrRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefIntrRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefIntrRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefLiqRate]    Script Date: 07/21/2015 15:00:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefLiqRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefLiqRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefPfLink]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPfLink]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefPfLink]
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDef]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefPointDef]
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefDeltaPointDef]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefDeltaPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefPointDefDeltaPointDef]
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefDeltaPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefDeltaPointDefPriceScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefPointDefDeltaPointDefPriceScanDef]
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefDeltaPointDefVolScanDef]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefDeltaPointDefVolScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefPointDefDeltaPointDefVolScanDef]
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefScanPointDef]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefScanPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefPointDefScanPointDef]
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefScanPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefScanPointDefPriceScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefPointDefScanPointDefPriceScanDef]
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefScanPointDefVolScanDef]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefScanPointDefVolScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefPointDefScanPointDefVolScanDef]
GO
/****** Object:  Table [dbo].[BusFuncCcDefRateTier]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefRateTier]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefRateTier]
GO
/****** Object:  Table [dbo].[BusFuncCcDefRateTierRate]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefRateTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefRateTierRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefRateTierScanRate]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefRateTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefRateTierScanRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefScanTier]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefScanTier]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefScanTier]
GO
/****** Object:  Table [dbo].[BusFuncCcDefScanTierRate]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefScanTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefScanTierRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefScanTierScanRate]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefScanTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefScanTierScanRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefSomTier]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefSomTier]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefSomTier]
GO
/****** Object:  Table [dbo].[BusFuncCcDefSomTierRate]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefSomTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefSomTierRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefSomTierScanRate]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefSomTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefSomTierScanRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefSpotRate]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefSpotRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefSpotRate]
GO
/****** Object:  Table [dbo].[BusFuncCcDefVmRate]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefVmRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCcDefVmRate]
GO
/****** Object:  Table [dbo].[BusFuncCoLink]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLink]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLink]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLink]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLink]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLink]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLink]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLink]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLink]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfC]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfC]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfC]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRa]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRa]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRa]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRaA]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRaA]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRaA]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCScanRate]    Script Date: 07/21/2015 15:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCScanRate]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeries]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeries]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeries]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfC]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfC]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfC]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRa]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRa]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRa]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRaA]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRaA]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRaA]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCScanRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCScanRate]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesScanRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesScanRate]
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesUndC]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesUndC]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesUndC]
GO
/****** Object:  Table [dbo].[BusFuncCurConv]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCurConv]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCurConv]
GO
/****** Object:  Table [dbo].[BusFuncCurConvHFactor]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCurConvHFactor]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncCurConvHFactor]
GO
/****** Object:  Table [dbo].[BusFuncInterClearSpreads]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterClearSpreads]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterClearSpreads]
GO
/****** Object:  Table [dbo].[BusFuncInterClearSpreadsAwayLeg]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterClearSpreadsAwayLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterClearSpreadsAwayLeg]
GO
/****** Object:  Table [dbo].[BusFuncInterClearSpreadsHomeLeg]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterClearSpreadsHomeLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterClearSpreadsHomeLeg]
GO
/****** Object:  Table [dbo].[BusFuncInterClearSpreadsHomeLegRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterClearSpreadsHomeLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterClearSpreadsHomeLegRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpread]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpread]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpread]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadPLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadPLeg]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadPLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadPLegRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadPmpsRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadPmpsRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadRpLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadRpLeg]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadRpLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadRpLegRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadTLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadTLeg]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadTLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadTLegRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadVolRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadVolRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadVolRateRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsDSpreadVolRateRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpread]    Script Date: 07/21/2015 15:00:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpread]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsSSpread]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpreadRate]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsSSpreadRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpreadSLeg]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpreadSLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsSSpreadSLeg]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpreadSLegRate]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpreadSLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsSSpreadSLegRate]
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpreadSPointDef]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpreadSPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncInterSpreadsSSpreadSPointDef]
GO
/****** Object:  Table [dbo].[BusFuncPbRateDef]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPbRateDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncPbRateDef]
GO
/****** Object:  Table [dbo].[BusFuncPointDef]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncPointDef]
GO
/****** Object:  Table [dbo].[BusFuncPointDefDeltaPointDef]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefDeltaPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncPointDefDeltaPointDef]
GO
/****** Object:  Table [dbo].[BusFuncPointDefDeltaPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefDeltaPointDefPriceScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncPointDefDeltaPointDefPriceScanDef]
GO
/****** Object:  Table [dbo].[BusFuncPointDefDeltaPointDefVolScanDef]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefDeltaPointDefVolScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncPointDefDeltaPointDefVolScanDef]
GO
/****** Object:  Table [dbo].[BusFuncPointDefScanPointDef]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefScanPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncPointDefScanPointDef]
GO
/****** Object:  Table [dbo].[BusFuncPointDefScanPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefScanPointDefPriceScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncPointDefScanPointDefPriceScanDef]
GO
/****** Object:  Table [dbo].[BusFuncPointDefScanPointDefVolScanDef]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefScanPointDefVolScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncPointDefScanPointDefVolScanDef]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpread]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpread]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpread]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadPLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadPLeg]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadPLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadPLegRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadPmpsRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadPmpsRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadRate]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLeg]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLegRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadTLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadTLeg]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadTLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadTLegRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRateRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRateRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpread]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpread]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpread]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadPLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadPLeg]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadPLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadPLegRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadPmpsRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadPmpsRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadRpLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadRpLeg]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadRpLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadRpLegRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadsRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadsRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadsRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadTLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadTLeg]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadTLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadTLegRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadVolRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadVolRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadVolRateRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsDSpreadVolRateRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpread]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpread]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsSSpread]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpreadRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsSSpreadRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpreadSLeg]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpreadSLeg]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsSSpreadSLeg]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpreadSLegRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpreadSLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsSSpreadSLegRate]
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpreadSPointDef]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpreadSPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[BusFuncSuperSpreadsSSpreadSPointDef]
GO
/****** Object:  Table [dbo].[ClOrg]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrg]
GO
/****** Object:  Table [dbo].[ClOrgCcDef]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__ClOrgCcDe__concS__1F981505]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ClOrgCcDef] DROP CONSTRAINT [DF__ClOrgCcDe__concS__1F981505]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDef]
GO
/****** Object:  Table [dbo].[ClOrgCcDefAdjRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefAdjRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefAdjRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefBasisRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefBasisRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefBasisRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefCdsRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefCdsRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefCdsRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefConcAdjRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefConcAdjRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefConcAdjRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpread]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpread]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpread]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadPLeg]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadPLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadPLeg]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadPLegRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadPLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadPLegRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadPmpsRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadPmpsRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadRate]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadRpLeg]    Script Date: 07/21/2015 15:00:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadRpLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadRpLeg]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadRpLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadRpLegRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadTLeg]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadTLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadTLeg]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadTLegRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadTLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadTLegRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadVolRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadVolRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadVolRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadVolRateRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefDSpreadVolRateRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefFxHvarSetIds]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefFxHvarSetIds]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefFxHvarSetIds]
GO
/****** Object:  Table [dbo].[ClOrgCcDefGroup]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefGroup]
GO
/****** Object:  Table [dbo].[ClOrgCcDefHvarSetIds]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefHvarSetIds]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefHvarSetIds]
GO
/****** Object:  Table [dbo].[ClOrgCcDefInterTier]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefInterTier]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefInterTier]
GO
/****** Object:  Table [dbo].[ClOrgCcDefInterTierRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefInterTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefInterTierRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefInterTierScanRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefInterTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefInterTierScanRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefIntraTier]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefIntraTier]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefIntraTier]
GO
/****** Object:  Table [dbo].[ClOrgCcDefIntraTierRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefIntraTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefIntraTierRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefIntraTierScanRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefIntraTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefIntraTierScanRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefIntrRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefIntrRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefIntrRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefLiqRate]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefLiqRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefLiqRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefPfLink]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPfLink]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefPfLink]
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDef]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefPointDef]
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefDeltaPointDef]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefDeltaPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefPointDefDeltaPointDef]
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefDeltaPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefDeltaPointDefPriceScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefPointDefDeltaPointDefPriceScanDef]
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefDeltaPointDefVolScanDef]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefDeltaPointDefVolScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefPointDefDeltaPointDefVolScanDef]
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefScanPointDef]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefScanPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefPointDefScanPointDef]
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefScanPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefScanPointDefPriceScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefPointDefScanPointDefPriceScanDef]
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefScanPointDefVolScanDef]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefScanPointDefVolScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefPointDefScanPointDefVolScanDef]
GO
/****** Object:  Table [dbo].[ClOrgCcDefRateTier]    Script Date: 07/21/2015 15:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefRateTier]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefRateTier]
GO
/****** Object:  Table [dbo].[ClOrgCcDefRateTierRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefRateTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefRateTierRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefRateTierScanRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefRateTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefRateTierScanRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefScanTier]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefScanTier]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefScanTier]
GO
/****** Object:  Table [dbo].[ClOrgCcDefScanTierRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefScanTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefScanTierRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefScanTierScanRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefScanTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefScanTierScanRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefSomTier]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefSomTier]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefSomTier]
GO
/****** Object:  Table [dbo].[ClOrgCcDefSomTierRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefSomTierRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefSomTierRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefSomTierScanRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefSomTierScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefSomTierScanRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefSpotRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefSpotRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefSpotRate]
GO
/****** Object:  Table [dbo].[ClOrgCcDefVmRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefVmRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCcDefVmRate]
GO
/****** Object:  Table [dbo].[ClOrgCdsMarginParams]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCdsMarginParams]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCdsMarginParams]
GO
/****** Object:  Table [dbo].[ClOrgCdsMarginParamsSectorDef]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCdsMarginParamsSectorDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCdsMarginParamsSectorDef]
GO
/****** Object:  Table [dbo].[ClOrgCdsMarginParamsSectorDefHy]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCdsMarginParamsSectorDefHy]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCdsMarginParamsSectorDefHy]
GO
/****** Object:  Table [dbo].[ClOrgCdsMarginParamsSectorDefIg]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCdsMarginParamsSectorDefIg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCdsMarginParamsSectorDefIg]
GO
/****** Object:  Table [dbo].[ClOrgCurConv]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCurConv]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCurConv]
GO
/****** Object:  Table [dbo].[ClOrgCurConvHFactor]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCurConvHFactor]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgCurConvHFactor]
GO
/****** Object:  Table [dbo].[ClOrgExchange]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchange]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchange]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPf]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfAlias]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwap]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwap]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwap]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapAlias]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapDvad]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapDvad]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapDvad]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapIntrRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapIntrRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapIntrRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapRa]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapRaA]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapScanRate]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapTick]    Script Date: 07/21/2015 15:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapUndC]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapUndC]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapUndC]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapVenue]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapVenueTick]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfGroup]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfSpecs]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfSpecsFee]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfUndPf]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfVenue]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfVenueTick]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCDSwapPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPf]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfAlias]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfGroup]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfSpecs]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfSpecsFee]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfSpecsVenue]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfSpecsVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfSpecsVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfSpecsVenueTick]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfSpecsVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfSpecsVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfUndPf]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebt]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebt]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebt]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtAlias]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPf]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfAlias]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfGroup]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfSpecs]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfSpecsFee]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfVenue]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfVenueTick]    Script Date: 07/21/2015 15:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtTick]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtUndC]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtUndC]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtUndC]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtUndPf]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtVenue]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtVenueTick]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEDebtVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPf]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfAlias]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquity]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquity]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquity]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityAlias]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquityAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityDiv]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityDiv]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquityDiv]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityDivRate]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityDivRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquityDivRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityRa]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquityRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityRaA]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquityRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityScanRate]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquityScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityTick]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquityTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityVenue]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquityVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityVenueTick]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfEquityVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfGroup]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfSpecs]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfSpecsFee]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfVenue]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfVenueTick]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeEquityPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPf]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfAlias]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFut]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFut]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFut]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutAlias]    Script Date: 07/21/2015 15:00:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutDvad]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutDvad]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutDvad]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutIntrRate]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutIntrRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutIntrRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutRa]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutRaA]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutScanRate]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutTick]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutUndC]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutUndC]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutUndC]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutVenue]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutVenueTick]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfFutVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfGroup]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfSpecs]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfSpecsFee]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfUndPf]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfVenue]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfVenueTick]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFutPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPf]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfAlias]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwd]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwd]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwd]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdAlias]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdDvad]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdDvad]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdDvad]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdIntrRate]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdIntrRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdIntrRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdRa]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdRaA]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdScanRate]    Script Date: 07/21/2015 15:00:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdTick]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdUndC]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdUndC]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdUndC]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdVenue]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdVenueTick]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfFwdVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfGroup]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfSpecs]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfSpecsFee]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfUndPf]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfVenue]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfVenueTick]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeFwdPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPf]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfAlias]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfFixedLeg]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfFixedLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfFixedLeg]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfFloatLeg]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfFloatLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfFloatLeg]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfGroup]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwap]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwap]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwap]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapAlias]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapDvad]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapDvad]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapDvad]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLeg]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLeg]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCal]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCalCode]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCal]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCalCode]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegInitialStub]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegInitialStub]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegInitialStub]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCal]    Script Date: 07/21/2015 15:00:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLeg]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLeg]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCal]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCalCode]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegInitialStub]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegInitialStub]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegInitialStub]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCal]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCalCode]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapRa]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapRaA]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfSpecs]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfSpecsFee]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfUndPf]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfVenue]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfVenueTick]    Script Date: 07/21/2015 15:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfZeroCurveId]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfZeroCurveId]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeIRSwapPfZeroCurveId]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPf]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfAlias]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfGroup]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeries]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeries]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeries]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesAlias]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesDivRate]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesDivRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesDivRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesDivRateDiv]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesDivRateDiv]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesDivRateDiv]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesIntrRate]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesIntrRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesIntrRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesOpt]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesOpt]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesOpt]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesOptAlias]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesOptAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesOptAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesOptRa]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesOptRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesOptRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesOptRaA]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesOptRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesOptRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesScanRate]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesTick]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesUndC]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesUndC]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesUndC]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesVenue]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesVenueTick]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSeriesVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSpecs]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSpecsFee]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfUndPf]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfVenue]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfVenueTick]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOocPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePf]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfAlias]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfGroup]    Script Date: 07/21/2015 15:00:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeries]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeries]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeries]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesAlias]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesDivRate]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesDivRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesDivRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesDivRateDiv]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesDivRateDiv]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesDivRateDiv]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesIntrRate]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesIntrRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesIntrRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesOpt]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesOpt]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesOpt]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesOptAlias]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesOptAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesOptAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesOptRa]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesOptRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesOptRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesOptRaA]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesOptRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesOptRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesScanRate]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesTick]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesUndC]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesUndC]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesUndC]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesVenue]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesVenueTick]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSeriesVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSpecs]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSpecsFee]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfUndPf]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfVenue]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfVenueTick]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOoePfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPf]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfAlias]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfGroup]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeries]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeries]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeries]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesAlias]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesDivRate]    Script Date: 07/21/2015 15:00:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesDivRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesDivRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesDivRateDiv]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesDivRateDiv]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesDivRateDiv]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesIntrRate]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesIntrRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesIntrRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesOpt]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesOpt]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesOpt]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesOptAlias]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesOptAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesOptAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesOptRa]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesOptRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesOptRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesOptRaA]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesOptRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesOptRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesScanRate]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesTick]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesUndC]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesUndC]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesUndC]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesVenue]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesVenueTick]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSeriesVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSpecs]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSpecsFee]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfUndPf]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfVenue]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfVenueTick]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOofPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPf]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfAlias]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfGroup]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeries]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeries]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeries]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesAlias]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesDivRate]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesDivRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesDivRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesDivRateDiv]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesDivRateDiv]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesDivRateDiv]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesIntrRate]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesIntrRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesIntrRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesOpt]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesOpt]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesOpt]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesOptAlias]    Script Date: 07/21/2015 15:00:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesOptAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesOptAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesOptRa]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesOptRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesOptRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesOptRaA]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesOptRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesOptRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesScanRate]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesTick]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesUndC]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesUndC]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesUndC]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesVenue]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesVenueTick]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSeriesVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSpecs]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSpecsFee]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfUndPf]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfUndPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfUndPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfVenue]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfVenueTick]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeOopPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPf]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPf]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPf]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfAlias]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmb]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmb]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfCmb]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbAlias]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfCmbAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbDvad]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbDvad]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfCmbDvad]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbRa]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfCmbRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbRaA]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfCmbRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbScanRate]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfCmbScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbUndC]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbUndC]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangeCmbPfCmbUndC]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebt]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebt]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfDebt]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtAlias]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfDebtAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtRa]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfDebtRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtRaA]    Script Date: 07/21/2015 15:00:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfDebtRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtScanRate]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfDebtScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtTick]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfDebtTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtVenue]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfDebtVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtVenueTick]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfDebtVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfGroup]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfGroup]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfGroup]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhy]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhy]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfPhy]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyAlias]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyAlias]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfPhyAlias]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyRa]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyRa]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfPhyRa]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyRaA]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyRaA]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfPhyRaA]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyScanRate]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyScanRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfPhyScanRate]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyTick]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfPhyTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyVenue]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfPhyVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyVenueTick]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfPhyVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfSpecs]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfSpecs]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfSpecs]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfSpecsFee]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfSpecsFee]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfSpecsFee]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfVenue]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfVenue]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfVenue]
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfVenueTick]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfVenueTick]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgExchangePhyPfVenueTick]
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParams]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParams]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgHvarMarginParams]
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsFxHvarSet]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsFxHvarSet]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgHvarMarginParamsFxHvarSet]
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsFxHvarSetFxHvarData]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsFxHvarSetFxHvarData]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgHvarMarginParamsFxHvarSetFxHvarData]
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSet]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__ClOrgHvar__useRo__13323E20]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ClOrgHvarMarginParamsHvarSet] DROP CONSTRAINT [DF__ClOrgHvar__useRo__13323E20]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSet]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgHvarMarginParamsHvarSet]
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetHLogRet]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetHLogRet]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgHvarMarginParamsHvarSetHLogRet]
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetHRet]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetHRet]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgHvarMarginParamsHvarSetHRet]
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetHVal]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetHVal]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgHvarMarginParamsHvarSetHVal]
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetSeed]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetSeed]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgHvarMarginParamsHvarSetSeed]
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetSeedTm]    Script Date: 07/21/2015 15:00:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetSeedTm]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgHvarMarginParamsHvarSetSeedTm]
GO
/****** Object:  Table [dbo].[ClOrgInterClearSpreads]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterClearSpreads]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterClearSpreads]
GO
/****** Object:  Table [dbo].[ClOrgInterClearSpreadsAwayLeg]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterClearSpreadsAwayLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterClearSpreadsAwayLeg]
GO
/****** Object:  Table [dbo].[ClOrgInterClearSpreadsHomeLeg]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterClearSpreadsHomeLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterClearSpreadsHomeLeg]
GO
/****** Object:  Table [dbo].[ClOrgInterClearSpreadsHomeLegRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterClearSpreadsHomeLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterClearSpreadsHomeLegRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpread]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpread]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpread]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadPLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadPLeg]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadPLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadPLegRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadPmpsRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadPmpsRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadRpLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadRpLeg]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadRpLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadRpLegRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadTLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadTLeg]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadTLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadTLegRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadVolRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadVolRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadVolRateRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsDSpreadVolRateRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpread]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpread]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsSSpread]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpreadRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsSSpreadRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpreadSLeg]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpreadSLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsSSpreadSLeg]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpreadSLegRate]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpreadSLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsSSpreadSLegRate]
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpreadSPointDef]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpreadSPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgInterSpreadsSSpreadSPointDef]
GO
/****** Object:  Table [dbo].[ClOrgPbRateDef]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPbRateDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgPbRateDef]
GO
/****** Object:  Table [dbo].[ClOrgPointDef]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgPointDef]
GO
/****** Object:  Table [dbo].[ClOrgPointDefDeltaPointDef]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefDeltaPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgPointDefDeltaPointDef]
GO
/****** Object:  Table [dbo].[ClOrgPointDefDeltaPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefDeltaPointDefPriceScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgPointDefDeltaPointDefPriceScanDef]
GO
/****** Object:  Table [dbo].[ClOrgPointDefDeltaPointDefVolScanDef]    Script Date: 07/21/2015 15:00:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefDeltaPointDefVolScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgPointDefDeltaPointDefVolScanDef]
GO
/****** Object:  Table [dbo].[ClOrgPointDefScanPointDef]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefScanPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgPointDefScanPointDef]
GO
/****** Object:  Table [dbo].[ClOrgPointDefScanPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefScanPointDefPriceScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgPointDefScanPointDefPriceScanDef]
GO
/****** Object:  Table [dbo].[ClOrgPointDefScanPointDefVolScanDef]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefScanPointDefVolScanDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgPointDefScanPointDefVolScanDef]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpread]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpread]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpread]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadPLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadPLeg]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadPLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadPLegRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadPmpsRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadPmpsRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLeg]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLegRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadTLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadTLeg]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadTLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadTLegRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRateRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRateRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpread]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpread]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpread]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadPLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadPLeg]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadPLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadPLegRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadPmpsRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadPmpsRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadRpLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadRpLeg]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadRpLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadRpLegRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadsRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadsRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadsRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadTLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadTLeg]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadTLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadTLegRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadVolRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadVolRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadVolRateRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsDSpreadVolRateRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpread]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpread]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsSSpread]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpreadRate]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpreadRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsSSpreadRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpreadSLeg]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpreadSLeg]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsSSpreadSLeg]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpreadSLegRate]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpreadSLegRate]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsSSpreadSLegRate]
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpreadSPointDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpreadSPointDef]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgSuperSpreadsSSpreadSPointDef]
GO
/****** Object:  Table [dbo].[ClOrgZeroCurve]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgZeroCurve]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgZeroCurve]
GO
/****** Object:  Table [dbo].[ClOrgZeroCurveHistFix]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgZeroCurveHistFix]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgZeroCurveHistFix]
GO
/****** Object:  Table [dbo].[ClOrgZeroCurveZeroCurveData]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgZeroCurveZeroCurveData]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgZeroCurveZeroCurveData]
GO
/****** Object:  Table [dbo].[ClOrgZeroCurveZeroCurveDataTenor]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgZeroCurveZeroCurveDataTenor]') AND type in (N'U'))
DROP TABLE [dbo].[ClOrgZeroCurveZeroCurveDataTenor]
GO
/****** Object:  Table [dbo].[DefsAcctSubTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsAcctSubTypeDef]') AND type in (N'U'))
DROP TABLE [dbo].[DefsAcctSubTypeDef]
GO
/****** Object:  Table [dbo].[DefsAcctTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsAcctTypeDef]') AND type in (N'U'))
DROP TABLE [dbo].[DefsAcctTypeDef]
GO
/****** Object:  Table [dbo].[DefsCalDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsCalDef]') AND type in (N'U'))
DROP TABLE [dbo].[DefsCalDef]
GO
/****** Object:  Table [dbo].[DefsCalDefHolidays]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsCalDefHolidays]') AND type in (N'U'))
DROP TABLE [dbo].[DefsCalDefHolidays]
GO
/****** Object:  Table [dbo].[DefsCalDefStdWeekend]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsCalDefStdWeekend]') AND type in (N'U'))
DROP TABLE [dbo].[DefsCalDefStdWeekend]
GO
/****** Object:  Table [dbo].[DefsCurrencyDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsCurrencyDef]') AND type in (N'U'))
DROP TABLE [dbo].[DefsCurrencyDef]
GO
/****** Object:  Table [dbo].[DefsFeeTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsFeeTypeDef]') AND type in (N'U'))
DROP TABLE [dbo].[DefsFeeTypeDef]
GO
/****** Object:  Table [dbo].[DefsGroupDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsGroupDef]') AND type in (N'U'))
DROP TABLE [dbo].[DefsGroupDef]
GO
/****** Object:  Table [dbo].[DefsGroupTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsGroupTypeDef]') AND type in (N'U'))
DROP TABLE [dbo].[DefsGroupTypeDef]
GO
/****** Object:  Table [dbo].[DefsTickTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsTickTypeDef]') AND type in (N'U'))
DROP TABLE [dbo].[DefsTickTypeDef]
GO
/****** Object:  Table [dbo].[DefsVenueDef]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsVenueDef]') AND type in (N'U'))
DROP TABLE [dbo].[DefsVenueDef]
GO
/****** Object:  Table [dbo].[pointInTime]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pointInTime]') AND type in (N'U'))
DROP TABLE [dbo].[pointInTime]
GO
/****** Object:  Table [dbo].[portfolio]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__portfolio__qib__50FA666F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[portfolio] DROP CONSTRAINT [DF__portfolio__qib__50FA666F]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__portfolio__concA__51EE8AA8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[portfolio] DROP CONSTRAINT [DF__portfolio__concA__51EE8AA8]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolio]') AND type in (N'U'))
DROP TABLE [dbo].[portfolio]
GO
/****** Object:  Table [dbo].[portfolioAcctSubType]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioAcctSubType]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioAcctSubType]
GO
/****** Object:  Table [dbo].[portfolioCurVal]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioCurVal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioCurVal]
GO
/****** Object:  Table [dbo].[portfolioEcPort]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPort]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPort]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPort]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__portfolio__concS__631916AA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[portfolioEcPortCcPort] DROP CONSTRAINT [DF__portfolio__concS__631916AA]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPort]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPort]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortAsset]    Script Date: 07/21/2015 15:00:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortAsset]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortAsset]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortDReq]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortDReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortDReq]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortEdp]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortEdp]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortEdp]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGcp]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGcp]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGcp]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGp]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGp]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGp]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpAots]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpAots]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGpAots]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpOt]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpOt]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGpOt]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpOtLts]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpOtLts]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGpOtLts]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpOtssOt]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpOtssOt]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGpOtssOt]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpOtssOtLts]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpOtssOtLts]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGpOtssOtLts]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReq]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReq]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqAsomtr]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqAsomtr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqAsomtr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReq]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqIaReq]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqIatr]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqIatr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqIaReqIatr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqPd]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqPd]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqIaReqPd]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqSomtr]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqSomtr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqIaReqSomtr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqStr]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqStr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqIaReqStr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqStrSv]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqStrSv]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqIaReqStrSv]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNlr]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNlr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNlr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNlrPd]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNlrPd]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNlrPd]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNlrStr]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNlrStr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNlrStr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNlrStrSv]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNlrStrSv]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNlrStrSv]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReq]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNReq]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqIatr]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqIatr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNReqIatr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqIetr]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqIetr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNReqIetr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqIetrSv]    Script Date: 07/21/2015 15:00:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqIetrSv]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNReqIetrSv]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqPd]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqPd]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNReqPd]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqSomtr]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqSomtr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNReqSomtr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqStr]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqStr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNReqStr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqStrSv]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqStrSv]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNReqStrSv]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsr]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNsr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsrPd]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsrPd]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNsrPd]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsrSomtr]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsrSomtr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNsrSomtr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsrStr]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsrStr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNsrStr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsrStrSv]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsrStrSv]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortGReqNsrStrSv]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNcp]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNcp]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNcp]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNp]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNp]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNp]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNpAots]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNpAots]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNpAots]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNpOt]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNpOt]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNpOt]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNpOtLts]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNpOtLts]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNpOtLts]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReq]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNReq]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqIatr]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqIatr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNReqIatr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqIetr]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqIetr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNReqIetr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqIetrSv]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqIetrSv]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNReqIetrSv]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqPd]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqPd]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNReqPd]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqSomtr]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqSomtr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNReqSomtr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqStr]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqStr]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNReqStr]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqStrSv]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqStrSv]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortNReqStrSv]
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortSp]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortSp]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCcPortSp]
GO
/****** Object:  Table [dbo].[portfolioEcPortCurVal]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCurVal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortCurVal]
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReq]    Script Date: 07/21/2015 15:00:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortGrReq]
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReqCurVal]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReqCurVal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortGrReqCurVal]
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReqGrOReq]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReqGrOReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortGrReqGrOReq]
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReqGrOReqGrCurReq]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReqGrOReqGrCurReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortGrReqGrOReqGrCurReq]
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReqGroup]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReqGroup]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortGrReqGroup]
GO
/****** Object:  Table [dbo].[portfolioEcPortOReq]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortOReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortOReq]
GO
/****** Object:  Table [dbo].[portfolioEcPortOReqCurReq]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortOReqCurReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioEcPortOReqCurReq]
GO
/****** Object:  Table [dbo].[portfolioFixedLeg]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLeg]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLeg]
GO
/****** Object:  Table [dbo].[portfolioFixedLegcalcPerAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegcalcPerAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegcalcPerAdjCal]
GO
/****** Object:  Table [dbo].[portfolioFixedLegcalcPerAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegcalcPerAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegcalcPerAdjCalCode]
GO
/****** Object:  Table [dbo].[portfolioFixedLegfixingDateCal]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegfixingDateCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegfixingDateCal]
GO
/****** Object:  Table [dbo].[portfolioFixedLegfixingDateCalCode]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegfixingDateCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegfixingDateCalCode]
GO
/****** Object:  Table [dbo].[portfolioFixedLegInitialStub]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegInitialStub]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegInitialStub]
GO
/****** Object:  Table [dbo].[portfolioFixedLegMatDateAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegMatDateAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegMatDateAdjCal]
GO
/****** Object:  Table [dbo].[portfolioFixedLegMatDateAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegMatDateAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegMatDateAdjCalCode]
GO
/****** Object:  Table [dbo].[portfolioFixedLegPayAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegPayAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegPayAdjCal]
GO
/****** Object:  Table [dbo].[portfolioFixedLegPayAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegPayAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegPayAdjCalCode]
GO
/****** Object:  Table [dbo].[portfolioFixedLegResetDateAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegResetDateAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegResetDateAdjCal]
GO
/****** Object:  Table [dbo].[portfolioFixedLegResetDateAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegResetDateAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFixedLegResetDateAdjCalCode]
GO
/****** Object:  Table [dbo].[portfolioFloatLeg]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLeg]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLeg]
GO
/****** Object:  Table [dbo].[portfolioFloatLegcalcPerAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegcalcPerAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegcalcPerAdjCal]
GO
/****** Object:  Table [dbo].[portfolioFloatLegcalcPerAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegcalcPerAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegcalcPerAdjCalCode]
GO
/****** Object:  Table [dbo].[portfolioFloatLegfixingDateCal]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegfixingDateCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegfixingDateCal]
GO
/****** Object:  Table [dbo].[portfolioFloatLegfixingDateCalCode]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegfixingDateCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegfixingDateCalCode]
GO
/****** Object:  Table [dbo].[portfolioFloatLegInitialStub]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegInitialStub]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegInitialStub]
GO
/****** Object:  Table [dbo].[portfolioFloatLegMatDateAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegMatDateAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegMatDateAdjCal]
GO
/****** Object:  Table [dbo].[portfolioFloatLegMatDateAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegMatDateAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegMatDateAdjCalCode]
GO
/****** Object:  Table [dbo].[portfolioFloatLegPayAdjCal]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegPayAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegPayAdjCal]
GO
/****** Object:  Table [dbo].[portfolioFloatLegPayAdjCalCode]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegPayAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegPayAdjCalCode]
GO
/****** Object:  Table [dbo].[portfolioFloatLegResetDateAdjCal]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegResetDateAdjCal]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegResetDateAdjCal]
GO
/****** Object:  Table [dbo].[portfolioFloatLegResetDateAdjCalCode]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegResetDateAdjCalCode]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioFloatLegResetDateAdjCalCode]
GO
/****** Object:  Table [dbo].[portfolioLinkedAccts]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioLinkedAccts]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioLinkedAccts]
GO
/****** Object:  Table [dbo].[portfolioLinkedAcctsRefAcct]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioLinkedAcctsRefAcct]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioLinkedAcctsRefAcct]
GO
/****** Object:  Table [dbo].[portfolioOReq]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioOReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioOReq]
GO
/****** Object:  Table [dbo].[portfolioOReqCurReq]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioOReqCurReq]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioOReqCurReq]
GO
/****** Object:  Table [dbo].[portfolioParentAcct]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioParentAcct]') AND type in (N'U'))
DROP TABLE [dbo].[portfolioParentAcct]
GO
/****** Object:  Table [dbo].[spanFile]    Script Date: 07/21/2015 15:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spanFile]') AND type in (N'U'))
DROP TABLE [dbo].[spanFile]
GO
/****** Object:  Table [dbo].[spanFile]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spanFile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[spanFile](
	[spanFileId] int identity(1,1) primary key,
	[fileName] [nvarchar](1024) NULL,
	[loadTimeUtc] [datetime] NULL,
	[MissingElements] [nvarchar](max) NULL,
	[spanVersion] [nvarchar](1000) NULL,
	[fileFormat] [nvarchar](1000) NULL,
	[created] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioParentAcct]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioParentAcct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioParentAcct](
	[portfolioId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[firm] [nvarchar](1000) NULL,
	[acctId] [nvarchar](1000) NULL,
	[seg] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioOReqCurReq]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioOReqCurReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioOReqCurReq](
	[portfolioOReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[crossSavings] [float] NULL,
	[anov] [float] NULL,
	[portfolioOReqCurReqId] int identity(1,1) primary key,
	[portfolioOReqCurReqParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioOReq]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioOReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioOReq](
	[portfolioId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[crossSavings] [float] NULL,
	[anov] [float] NULL,
	[portfolioOReqId] int identity(1,1) primary key,
	[portfolioOReqParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioLinkedAcctsRefAcct]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioLinkedAcctsRefAcct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioLinkedAcctsRefAcct](
	[portfolioLinkedAcctsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[firm] [nvarchar](1000) NULL,
	[acctId] [nvarchar](1000) NULL,
	[seg] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioLinkedAccts]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioLinkedAccts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioLinkedAccts](
	[portfolioId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[creditDistMeth] [nvarchar](1000) NULL,
	[portfolioLinkedAcctsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegResetDateAdjCalCode]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegResetDateAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegResetDateAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFloatLegResetDateAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegResetDateAdjCal]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegResetDateAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegResetDateAdjCal](
	[portfolioFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFloatLegResetDateAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegPayAdjCalCode]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegPayAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegPayAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFloatLegPayAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegPayAdjCal]    Script Date: 07/21/2015 15:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegPayAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegPayAdjCal](
	[portfolioFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFloatLegPayAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegMatDateAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegMatDateAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegMatDateAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFloatLegMatDateAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegMatDateAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegMatDateAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegMatDateAdjCal](
	[portfolioFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFloatLegMatDateAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegInitialStub]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegInitialStub]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegInitialStub](
	[portfolioFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[firstRegPerStartDate] [nvarchar](1000) NULL,
	[rate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegfixingDateCalCode]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegfixingDateCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegfixingDateCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFloatLegfixingDateCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegfixingDateCal]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegfixingDateCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegfixingDateCal](
	[portfolioFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFloatLegfixingDateCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegcalcPerAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegcalcPerAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegcalcPerAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFloatLegcalcPerAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLegcalcPerAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLegcalcPerAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLegcalcPerAdjCal](
	[portfolioFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFloatLegcalcPerAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFloatLeg]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFloatLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFloatLeg](
	[portfolioEcPortCcPortSpId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[startDate] [nvarchar](1000) NULL,
	[matDate] [nvarchar](1000) NULL,
	[matAdjBusDayConv] [nvarchar](1000) NULL,
	[portfolioFloatLegId] int identity(1,1) primary key,
	[notional] [float] NULL,
	[rollConv] [nvarchar](1000) NULL,
	[fixedRate] [float] NULL,
	[payFreq] [nvarchar](1000) NULL,
	[payRelTo] [nvarchar](1000) NULL,
	[payAdjBusDayConv] [nvarchar](1000) NULL,
	[dayCount] [nvarchar](1000) NULL,
	[indx] [nvarchar](1000) NULL,
	[indexTenor] [nvarchar](1000) NULL,
	[spread] [float] NULL,
	[calcPerAdjBusDayConv] [nvarchar](1000) NULL,
	[calcFreq] [nvarchar](1000) NULL,
	[compMethod] [nvarchar](1000) NULL,
	[fixingDateOffset] [nvarchar](1000) NULL,
	[fixingDayType] [nvarchar](1000) NULL,
	[fixingDateBusDayConv] [nvarchar](1000) NULL,
	[resetFreq] [nvarchar](1000) NULL,
	[resetRelTo] [nvarchar](1000) NULL,
	[resetDateAdjDayConv] [nvarchar](1000) NULL,
	[currentPeriodRate] [float] NULL,
	[accruedInt] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegResetDateAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegResetDateAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegResetDateAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFixedLegResetDateAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegResetDateAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegResetDateAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegResetDateAdjCal](
	[portfolioFixedLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFixedLegResetDateAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegPayAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegPayAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegPayAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFixedLegPayAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegPayAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegPayAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegPayAdjCal](
	[portfolioFixedLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFixedLegPayAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegMatDateAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegMatDateAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegMatDateAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFixedLegMatDateAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegMatDateAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegMatDateAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegMatDateAdjCal](
	[portfolioFixedLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFixedLegMatDateAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegInitialStub]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegInitialStub]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegInitialStub](
	[portfolioFixedLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[firstRegPerStartDate] [nvarchar](1000) NULL,
	[rate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegfixingDateCalCode]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegfixingDateCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegfixingDateCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFixedLegfixingDateCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegfixingDateCal]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegfixingDateCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegfixingDateCal](
	[portfolioFixedLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFixedLegfixingDateCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegcalcPerAdjCalCode]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegcalcPerAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegcalcPerAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[portfolioFixedLegcalcPerAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLegcalcPerAdjCal]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLegcalcPerAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLegcalcPerAdjCal](
	[portfolioFixedLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioFixedLegcalcPerAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioFixedLeg]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioFixedLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioFixedLeg](
	[portfolioEcPortCcPortSpId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[startDate] [nvarchar](1000) NULL,
	[matDate] [nvarchar](1000) NULL,
	[matAdjBusDayConv] [nvarchar](1000) NULL,
	[portfolioFixedLegId] int identity(1,1) primary key,
	[notional] [float] NULL,
	[rollConv] [nvarchar](1000) NULL,
	[fixedRate] [float] NULL,
	[payFreq] [nvarchar](1000) NULL,
	[payRelTo] [nvarchar](1000) NULL,
	[payAdjBusDayConv] [nvarchar](1000) NULL,
	[dayCount] [nvarchar](1000) NULL,
	[indx] [nvarchar](1000) NULL,
	[indexTenor] [nvarchar](1000) NULL,
	[spread] [float] NULL,
	[calcPerAdjBusDayConv] [nvarchar](1000) NULL,
	[calcFreq] [nvarchar](1000) NULL,
	[compMethod] [nvarchar](1000) NULL,
	[fixingDateOffset] [nvarchar](1000) NULL,
	[fixingDayType] [nvarchar](1000) NULL,
	[fixingDateBusDayConv] [nvarchar](1000) NULL,
	[resetFreq] [nvarchar](1000) NULL,
	[resetRelTo] [nvarchar](1000) NULL,
	[resetDateAdjDayConv] [nvarchar](1000) NULL,
	[currentPeriodRate] [float] NULL,
	[accruedInt] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortOReqCurReq]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortOReqCurReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortOReqCurReq](
	[portfolioEcPortOReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[crossSavings] [float] NULL,
	[anov] [float] NULL,
	[portfolioEcPortOReqCurReqId] int identity(1,1) primary key,
	[portfolioEcPortOReqCurReqParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortOReq]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortOReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortOReq](
	[portfolioEcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[crossSavings] [float] NULL,
	[anov] [float] NULL,
	[portfolioEcPortOReqId] int identity(1,1) primary key,
	[portfolioEcPortOReqParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReqGroup]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReqGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortGrReqGroup](
	[portfolioEcPortGrReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReqGrOReqGrCurReq]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReqGrOReqGrCurReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortGrReqGrOReqGrCurReq](
	[portfolioEcPortGrReqGrOReqParentId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[crossSavings] [float] NULL,
	[anov] [float] NULL,
	[portfolioEcPortGrReqGrOReqGrCurReqId] int identity(1,1) primary key,
	[portfolioEcPortGrReqGrOReqGrCurReqParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReqGrOReq]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReqGrOReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortGrReqGrOReq](
	[portfolioEcPortGrReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[crossSavings] [float] NULL,
	[anov] [float] NULL,
	[exLOV] [float] NULL,
	[sumCCReq] [float] NULL,
	[sumCCExLOV] [float] NULL,
	[totalReq] [float] NULL,
	[portfolioEcPortGrReqGrOReqId] int identity(1,1) primary key,
	[portfolioEcPortGrReqGrOReqParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReqCurVal]    Script Date: 07/21/2015 15:00:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReqCurVal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortGrReqCurVal](
	[portfolioEcPortGrReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[lfv] [nvarchar](1000) NULL,
	[sfv] [nvarchar](1000) NULL,
	[lov] [nvarchar](1000) NULL,
	[sov] [nvarchar](1000) NULL,
	[lovf] [nvarchar](1000) NULL,
	[sovf] [nvarchar](1000) NULL,
	[lpv] [nvarchar](1000) NULL,
	[spv] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[svp] [nvarchar](1000) NULL,
	[svpt] [nvarchar](1000) NULL,
	[op] [nvarchar](1000) NULL,
	[ap] [nvarchar](1000) NULL,
	[dva] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[lue] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[otep] [nvarchar](1000) NULL,
	[plp] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortGrReq]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortGrReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortGrReq](
	[portfolioEcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[portfolioEcPortGrReqId] int identity(1,1) primary key,
	[lfv] [nvarchar](1000) NULL,
	[sfv] [nvarchar](1000) NULL,
	[lov] [nvarchar](1000) NULL,
	[sov] [nvarchar](1000) NULL,
	[lovf] [nvarchar](1000) NULL,
	[sovf] [nvarchar](1000) NULL,
	[lpv] [nvarchar](1000) NULL,
	[spv] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[svp] [nvarchar](1000) NULL,
	[svpt] [nvarchar](1000) NULL,
	[op] [nvarchar](1000) NULL,
	[ap] [nvarchar](1000) NULL,
	[dva] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[lue] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[otep] [nvarchar](1000) NULL,
	[plp] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCurVal]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCurVal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCurVal](
	[portfolioEcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[lfv] [nvarchar](1000) NULL,
	[sfv] [nvarchar](1000) NULL,
	[lov] [nvarchar](1000) NULL,
	[sov] [nvarchar](1000) NULL,
	[lovf] [nvarchar](1000) NULL,
	[sovf] [nvarchar](1000) NULL,
	[lpv] [nvarchar](1000) NULL,
	[spv] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[svp] [nvarchar](1000) NULL,
	[svpt] [nvarchar](1000) NULL,
	[op] [nvarchar](1000) NULL,
	[ap] [nvarchar](1000) NULL,
	[dva] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[lue] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[otep] [nvarchar](1000) NULL,
	[plp] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortSp]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortSp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortSp](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[portfolioEcPortCcPortSpId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqStrSv]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqStrSv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNReqStrSv](
	[sv] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortNReqStrId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqStr]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNReqStr](
	[portfolioEcPortCcPortNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sr] [nvarchar](1000) NULL,
	[activeScenario] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortNReqStrId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqSomtr]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqSomtr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNReqSomtr](
	[portfolioEcPortCcPortNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[som] [nvarchar](1000) NULL,
	[sco] [nvarchar](1000) NULL,
	[spo] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqPd]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqPd]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNReqPd](
	[portfolioEcPortCcPortNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[od] [nvarchar](1000) NULL,
	[gd] [nvarchar](1000) NULL,
	[rd] [nvarchar](1000) NULL,
	[drs] [nvarchar](1000) NULL,
	[dro] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqIetrSv]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqIetrSv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNReqIetrSv](
	[sv] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortNReqIetrId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqIetr]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqIetr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNReqIetr](
	[portfolioEcPortCcPortNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[ie] [nvarchar](1000) NULL,
	[iex] [nvarchar](1000) NULL,
	[wpr] [nvarchar](1000) NULL,
	[pr] [nvarchar](1000) NULL,
	[tr] [nvarchar](1000) NULL,
	[vr] [nvarchar](1000) NULL,
	[sr] [nvarchar](1000) NULL,
	[activeScenario] [nvarchar](1000) NULL,
	[ld] [nvarchar](1000) NULL,
	[sd] [nvarchar](1000) NULL,
	[rld] [nvarchar](1000) NULL,
	[rsd] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortNReqIetrId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReqIatr]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReqIatr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNReqIatr](
	[portfolioEcPortCcPortNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[ld] [nvarchar](1000) NULL,
	[sd] [nvarchar](1000) NULL,
	[rld] [nvarchar](1000) NULL,
	[rsd] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNReq]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNReq](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[anov] [float] NULL,
	[sr] [nvarchar](1000) NULL,
	[ia] [nvarchar](1000) NULL,
	[basis] [nvarchar](1000) NULL,
	[dr] [nvarchar](1000) NULL,
	[ie] [nvarchar](1000) NULL,
	[iex] [nvarchar](1000) NULL,
	[som] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortNReqId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNpOtLts]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNpOtLts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNpOtLts](
	[portfolioEcPortCcPortNpOtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[net] [int] NULL,
	[p] [float] NULL,
	[pl] [nvarchar](1000) NULL,
	[ts] [nvarchar](1000) NULL,
	[ctid] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNpOt]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNpOt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNpOt](
	[portfolioEcPortCcPortNpId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[net] [int] NULL,
	[oqty] [nvarchar](1000) NULL,
	[p] [float] NULL,
	[mp] [nvarchar](1000) NULL,
	[mpd] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[ts] [nvarchar](1000) NULL,
	[ctid] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortNpOtId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNpAots]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNpAots]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNpAots](
	[portfolioEcPortCcPortNpId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[net] [int] NULL,
	[p] [float] NULL,
	[dva] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNp]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNp](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[net] [int] NULL,
	[equiv] [nvarchar](1000) NULL,
	[split] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortNpId] int identity(1,1) primary key,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortNcp]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortNcp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortNcp](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[net] [int] NULL,
	[equiv] [nvarchar](1000) NULL,
	[split] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsrStrSv]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsrStrSv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNsrStrSv](
	[sv] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNsrStrId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsrStr]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsrStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNsrStr](
	[portfolioEcPortCcPortGReqNsrId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sr] [nvarchar](1000) NULL,
	[activeScenario] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNsrStrId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsrSomtr]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsrSomtr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNsrSomtr](
	[portfolioEcPortCcPortGReqNsrId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[som] [nvarchar](1000) NULL,
	[sco] [nvarchar](1000) NULL,
	[spo] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsrPd]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsrPd]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNsrPd](
	[portfolioEcPortCcPortGReqNsrId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[od] [nvarchar](1000) NULL,
	[gd] [nvarchar](1000) NULL,
	[rd] [nvarchar](1000) NULL,
	[drs] [nvarchar](1000) NULL,
	[dro] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNsr]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNsr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNsr](
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[dr] [nvarchar](1000) NULL,
	[som] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNsrId] int identity(1,1) primary key,
	[portfolioEcPortCcPortGReqId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqStrSv]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqStrSv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNReqStrSv](
	[sv] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNReqStrId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqStr]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNReqStr](
	[portfolioEcPortCcPortGReqNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sr] [nvarchar](1000) NULL,
	[activeScenario] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNReqStrId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqSomtr]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqSomtr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNReqSomtr](
	[portfolioEcPortCcPortGReqNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[som] [nvarchar](1000) NULL,
	[sco] [nvarchar](1000) NULL,
	[spo] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqPd]    Script Date: 07/21/2015 15:00:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqPd]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNReqPd](
	[portfolioEcPortCcPortGReqNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[od] [nvarchar](1000) NULL,
	[gd] [nvarchar](1000) NULL,
	[rd] [nvarchar](1000) NULL,
	[drs] [nvarchar](1000) NULL,
	[dro] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqIetrSv]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqIetrSv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNReqIetrSv](
	[sv] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNReqIetrId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqIetr]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqIetr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNReqIetr](
	[portfolioEcPortCcPortGReqNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[ie] [nvarchar](1000) NULL,
	[iex] [nvarchar](1000) NULL,
	[wpr] [nvarchar](1000) NULL,
	[pr] [nvarchar](1000) NULL,
	[tr] [nvarchar](1000) NULL,
	[vr] [nvarchar](1000) NULL,
	[sr] [nvarchar](1000) NULL,
	[activeScenario] [nvarchar](1000) NULL,
	[ld] [nvarchar](1000) NULL,
	[sd] [nvarchar](1000) NULL,
	[rld] [nvarchar](1000) NULL,
	[rsd] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNReqIetrId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReqIatr]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReqIatr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNReqIatr](
	[portfolioEcPortCcPortGReqNReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[ld] [nvarchar](1000) NULL,
	[sd] [nvarchar](1000) NULL,
	[rld] [nvarchar](1000) NULL,
	[rsd] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNReq]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNReq](
	[portfolioEcPortCcPortGReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[anov] [float] NULL,
	[sr] [nvarchar](1000) NULL,
	[ia] [nvarchar](1000) NULL,
	[basis] [nvarchar](1000) NULL,
	[dr] [nvarchar](1000) NULL,
	[ie] [nvarchar](1000) NULL,
	[iex] [nvarchar](1000) NULL,
	[som] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNReqId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNlrStrSv]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNlrStrSv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNlrStrSv](
	[sv] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNlrStrId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNlrStr]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNlrStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNlrStr](
	[portfolioEcPortCcPortGReqNlrId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sr] [nvarchar](1000) NULL,
	[activeScenario] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNlrStrId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNlrPd]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNlrPd]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNlrPd](
	[portfolioEcPortCcPortGReqNlrId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[od] [nvarchar](1000) NULL,
	[gd] [nvarchar](1000) NULL,
	[rd] [nvarchar](1000) NULL,
	[drs] [nvarchar](1000) NULL,
	[dro] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqNlr]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqNlr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqNlr](
	[portfolioEcPortCcPortGReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[dr] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqNlrId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqStrSv]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqStrSv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqIaReqStrSv](
	[sv] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqIaReqStrId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqStr]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqStr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqIaReqStr](
	[portfolioEcPortCcPortGReqIaReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sr] [nvarchar](1000) NULL,
	[activeScenario] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqIaReqStrId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqSomtr]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqSomtr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqIaReqSomtr](
	[portfolioEcPortCcPortGReqIaReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[som] [nvarchar](1000) NULL,
	[sco] [nvarchar](1000) NULL,
	[spo] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqPd]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqPd]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqIaReqPd](
	[portfolioEcPortCcPortGReqIaReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[od] [nvarchar](1000) NULL,
	[gd] [nvarchar](1000) NULL,
	[rd] [nvarchar](1000) NULL,
	[drs] [nvarchar](1000) NULL,
	[dro] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReqIatr]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReqIatr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqIaReqIatr](
	[portfolioEcPortCcPortGReqIaReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[ld] [nvarchar](1000) NULL,
	[sd] [nvarchar](1000) NULL,
	[rld] [nvarchar](1000) NULL,
	[rsd] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqIaReq]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqIaReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqIaReq](
	[portfolioEcPortCcPortGReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[sr] [nvarchar](1000) NULL,
	[ia] [nvarchar](1000) NULL,
	[dr] [nvarchar](1000) NULL,
	[som] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqIaReqId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReqAsomtr]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReqAsomtr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReqAsomtr](
	[portfolioEcPortCcPortGReqId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[som] [nvarchar](1000) NULL,
	[sco] [nvarchar](1000) NULL,
	[spo] [nvarchar](1000) NULL,
	[sno] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGReq]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGReq](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[anov] [float] NULL,
	[som] [nvarchar](1000) NULL,
	[nlRisk] [nvarchar](1000) NULL,
	[nsRisk] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGReqId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpOtssOtLts]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpOtssOtLts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGpOtssOtLts](
	[portfolioEcPortCcPortGpOtssOtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[net] [int] NULL,
	[p] [float] NULL,
	[pl] [nvarchar](1000) NULL,
	[ts] [nvarchar](1000) NULL,
	[ctid] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpOtssOt]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpOtssOt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGpOtssOt](
	[portfolioEcPortCcPortGpId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[net] [int] NULL,
	[oqty] [nvarchar](1000) NULL,
	[p] [float] NULL,
	[mp] [nvarchar](1000) NULL,
	[mpd] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[ts] [nvarchar](1000) NULL,
	[ctid] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGpOtssOtId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpOtLts]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpOtLts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGpOtLts](
	[portfolioEcPortCcPortGpOtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[net] [int] NULL,
	[p] [float] NULL,
	[pl] [nvarchar](1000) NULL,
	[ts] [nvarchar](1000) NULL,
	[ctid] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpOt]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpOt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGpOt](
	[portfolioEcPortCcPortGpId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[net] [int] NULL,
	[oqty] [nvarchar](1000) NULL,
	[p] [float] NULL,
	[mp] [nvarchar](1000) NULL,
	[mpd] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[ts] [nvarchar](1000) NULL,
	[ctid] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGpOtId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGpAots]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGpAots]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGpAots](
	[portfolioEcPortCcPortGpId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[net] [int] NULL,
	[p] [float] NULL,
	[dva] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGp]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGp](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[long] [int] NULL,
	[short] [nvarchar](1000) NULL,
	[nl] [nvarchar](1000) NULL,
	[ns] [nvarchar](1000) NULL,
	[nlEquiv] [nvarchar](1000) NULL,
	[nsEquiv] [nvarchar](1000) NULL,
	[nlSplit] [nvarchar](1000) NULL,
	[nsSplit] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortGpId] int identity(1,1) primary key,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortGcp]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortGcp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortGcp](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[long] [int] NULL,
	[short] [nvarchar](1000) NULL,
	[iaLong] [int] NULL,
	[iaShort] [nvarchar](1000) NULL,
	[ialEquiv] [nvarchar](1000) NULL,
	[iasEquiv] [nvarchar](1000) NULL,
	[ialSplit] [nvarchar](1000) NULL,
	[iasSplit] [nvarchar](1000) NULL,
	[ieLong] [int] NULL,
	[ieShort] [int] NULL,
	[ielEquiv] [float] NULL,
	[iesEquiv] [float] NULL,
	[ielSplit] [float] NULL,
	[iesSplit] [float] NULL,
	[nl] [nvarchar](1000) NULL,
	[ns] [nvarchar](1000) NULL,
	[nlEquiv] [nvarchar](1000) NULL,
	[nsEquiv] [nvarchar](1000) NULL,
	[nlSplit] [nvarchar](1000) NULL,
	[nsSplit] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortEdp]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortEdp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortEdp](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[no] [nvarchar](1000) NULL,
	[nrps] [nvarchar](1000) NULL,
	[nrpn] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortDReq]    Script Date: 07/21/2015 15:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortDReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortDReq](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL,
	[spanReq] [float] NULL,
	[addlReq] [float] NULL,
	[anov] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPortAsset]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPortAsset]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPortAsset](
	[portfolioEcPortCcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[net] [int] NULL,
	[savings] [float] NULL,
	[pbValue] [float] NULL,
	[used] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPortCcPort]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPortCcPort]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPortCcPort](
	[portfolioEcPortId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[r] [int] NULL,
	[concScaleUp] [float] NULL DEFAULT ((0)),
	[currency] [nvarchar](1000) NULL,
	[spotChargeAdj] [float] NULL,
	[pss] [nvarchar](1000) NULL,
	[lfv] [nvarchar](1000) NULL,
	[sfv] [nvarchar](1000) NULL,
	[lov] [nvarchar](1000) NULL,
	[sov] [nvarchar](1000) NULL,
	[lovf] [nvarchar](1000) NULL,
	[sovf] [nvarchar](1000) NULL,
	[lpv] [nvarchar](1000) NULL,
	[spv] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[svp] [nvarchar](1000) NULL,
	[svpt] [nvarchar](1000) NULL,
	[op] [nvarchar](1000) NULL,
	[ap] [nvarchar](1000) NULL,
	[dva] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[lue] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[otep] [nvarchar](1000) NULL,
	[plp] [nvarchar](1000) NULL,
	[portfolioEcPortCcPortId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioEcPort]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioEcPort]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioEcPort](
	[portfolioId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ec] [nvarchar](1000) NULL,
	[lfv] [nvarchar](1000) NULL,
	[sfv] [nvarchar](1000) NULL,
	[lov] [nvarchar](1000) NULL,
	[sov] [nvarchar](1000) NULL,
	[lovf] [nvarchar](1000) NULL,
	[sovf] [nvarchar](1000) NULL,
	[lpv] [nvarchar](1000) NULL,
	[spv] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[svp] [nvarchar](1000) NULL,
	[svpt] [nvarchar](1000) NULL,
	[op] [nvarchar](1000) NULL,
	[ap] [nvarchar](1000) NULL,
	[dva] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[lue] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[otep] [nvarchar](1000) NULL,
	[plp] [nvarchar](1000) NULL,
	[portfolioEcPortId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioCurVal]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioCurVal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioCurVal](
	[portfolioId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[lfv] [nvarchar](1000) NULL,
	[sfv] [nvarchar](1000) NULL,
	[lov] [nvarchar](1000) NULL,
	[sov] [nvarchar](1000) NULL,
	[lovf] [nvarchar](1000) NULL,
	[sovf] [nvarchar](1000) NULL,
	[lpv] [nvarchar](1000) NULL,
	[spv] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[svp] [nvarchar](1000) NULL,
	[svpt] [nvarchar](1000) NULL,
	[op] [nvarchar](1000) NULL,
	[ap] [nvarchar](1000) NULL,
	[dva] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[lue] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[otep] [nvarchar](1000) NULL,
	[plp] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolioAcctSubType]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolioAcctSubType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolioAcctSubType](
	[portfolioId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[acctSubTypeCode] [nvarchar](1000) NULL,
	[value] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[portfolio]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[portfolio]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[portfolio](
	[pointInTimeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[firm] [nvarchar](1000) NULL,
	[acctId] [nvarchar](1000) NULL,
	[acctType] [nvarchar](1000) NULL,
	[isCust] [bit] NULL,
	[seg] [nvarchar](1000) NULL,
	[portfolioId] int identity(1,1) primary key,
	[isNew] [bit] NULL,
	[qib] [bit] NULL DEFAULT ((1)),
	[pclient] [nvarchar](1000) NULL,
	[equivPosType] [nvarchar](1000) NULL,
	[custPortUseLov] [int] NULL,
	[concApplies] [bit] NULL DEFAULT ((0)),
	[currency] [nvarchar](1000) NULL,
	[ledgerBal] [nvarchar](1000) NULL,
	[ote] [nvarchar](1000) NULL,
	[securities] [nvarchar](1000) NULL,
	[lue] [nvarchar](1000) NULL,
	[lfv] [nvarchar](1000) NULL,
	[sfv] [nvarchar](1000) NULL,
	[lov] [nvarchar](1000) NULL,
	[sov] [nvarchar](1000) NULL,
	[lovf] [nvarchar](1000) NULL,
	[sovf] [nvarchar](1000) NULL,
	[lpv] [nvarchar](1000) NULL,
	[spv] [nvarchar](1000) NULL,
	[sv] [nvarchar](1000) NULL,
	[svt] [nvarchar](1000) NULL,
	[svp] [nvarchar](1000) NULL,
	[svpt] [nvarchar](1000) NULL,
	[op] [nvarchar](1000) NULL,
	[ap] [nvarchar](1000) NULL,
	[dva] [nvarchar](1000) NULL,
	[pl] [nvarchar](1000) NULL,
	[otep] [nvarchar](1000) NULL,
	[plp] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pointInTime]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pointInTime]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pointInTime](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[isSetl] [bit] NULL,
	[setlQualifier] [nvarchar](1000) NULL,
	[time] [nvarchar](1000) NULL,
	[run] [nvarchar](1000) NULL,
	[pointInTimeId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsVenueDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsVenueDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsVenueDef](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[name] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsTickTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsTickTypeDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsTickTypeDef](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[name] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsGroupTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsGroupTypeDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsGroupTypeDef](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[name] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsGroupDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsGroupDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsGroupDef](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL,
	[description] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsFeeTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsFeeTypeDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsFeeTypeDef](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[name] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsCurrencyDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsCurrencyDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsCurrencyDef](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[symbol] [nvarchar](1000) NULL,
	[name] [nvarchar](1000) NULL,
	[decimalPos] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsCalDefStdWeekend]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsCalDefStdWeekend]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsCalDefStdWeekend](
	[dayCode] [nvarchar](1000) NULL,
	[DefsCalDefId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsCalDefHolidays]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsCalDefHolidays]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsCalDefHolidays](
	[dt] [nvarchar](1000) NULL,
	[DefsCalDefId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsCalDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsCalDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsCalDef](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[calId] [int] NULL,
	[calCode] [nvarchar](1000) NULL,
	[description] [nvarchar](1000) NULL,
	[DefsCalDefId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsAcctTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsAcctTypeDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsAcctTypeDef](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isCust] [bit] NULL,
	[acctType] [nvarchar](1000) NULL,
	[name] [nvarchar](1000) NULL,
	[isNetMargin] [bit] NULL,
	[priority] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DefsAcctSubTypeDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefsAcctSubTypeDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DefsAcctSubTypeDef](
	[spanFileId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[acctSubTypeCode] [nvarchar](1000) NULL,
	[dataType] [nvarchar](1000) NULL,
	[description] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgZeroCurveZeroCurveDataTenor]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgZeroCurveZeroCurveDataTenor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgZeroCurveZeroCurveDataTenor](
	[ClOrgZeroCurveZeroCurveDataId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tm] [float] NULL,
	[val] [float] NULL,
	[offset] [int] NULL,
	[logret] [float] NULL,
	[isValAnchor] [tinyint] NULL,
	[isHvarAnchor] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgZeroCurveZeroCurveData]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgZeroCurveZeroCurveData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgZeroCurveZeroCurveData](
	[ClOrgZeroCurveId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[isCurrent] [tinyint] NULL,
	[bDate] [nvarchar](1000) NULL,
	[ClOrgZeroCurveZeroCurveDataId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgZeroCurveHistFix]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgZeroCurveHistFix]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgZeroCurveHistFix](
	[ClOrgZeroCurveId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[rate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgZeroCurve]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgZeroCurve]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgZeroCurve](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[description] [nvarchar](1000) NULL,
	[ClOrgZeroCurveId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpreadSPointDef]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpreadSPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsSSpreadSPointDef](
	[ClOrgSuperSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[aggMeth] [int] NULL,
	[sRate] [float] NULL,
	[nMaxLoss] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpreadSLegRate]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpreadSLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsSSpreadSLegRate](
	[ClOrgSuperSpreadsSSpreadSLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpreadSLeg]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpreadSLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsSSpreadSLeg](
	[ClOrgSuperSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[isTarget] [bit] NULL,
	[isRequired] [bit] NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgSuperSpreadsSSpreadSLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpreadRate]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsSSpreadRate](
	[ClOrgSuperSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsSSpread]    Script Date: 07/21/2015 15:00:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsSSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsSSpread](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[isTargetReq] [bit] NULL,
	[numLegsReq] [nvarchar](1000) NULL,
	[applyFxRisk] [bit] NULL,
	[apportionRisk] [bit] NULL,
	[ClOrgSuperSpreadsSSpreadId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadVolRateRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadVolRateRate](
	[ClOrgSuperSpreadsDSpreadVolRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadVolRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadVolRate](
	[ClOrgSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgSuperSpreadsDSpreadVolRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadTLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadTLegRate](
	[ClOrgSuperSpreadsDSpreadTLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadTLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadTLeg](
	[ClOrgSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgSuperSpreadsDSpreadTLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadsRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadsRate](
	[ClOrgSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadRpLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadRpLegRate](
	[ClOrgSuperSpreadsDSpreadRpLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadRpLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadRpLeg](
	[ClOrgSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[rpNum] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[btNum] [int] NULL,
	[etNum] [nvarchar](1000) NULL,
	[ClOrgSuperSpreadsDSpreadRpLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadPmpsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadPmpsRate](
	[ClOrgSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL,
	[pmRate] [nvarchar](1000) NULL,
	[psRate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadPLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadPLegRate](
	[ClOrgSuperSpreadsDSpreadPLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpreadPLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpreadPLeg](
	[ClOrgSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgSuperSpreadsDSpreadPLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperSpreadsDSpread]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperSpreadsDSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperSpreadsDSpread](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[spreadType] [nvarchar](1000) NULL,
	[chargeMeth] [nvarchar](1000) NULL,
	[ClOrgSuperSpreadsDSpreadId] int identity(1,1) primary key,
	[ClOrgSuperSpreadsDSpreadParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRateRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRateRate](
	[ClOrgSuperInterClearSpreadsDSpreadVolRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadVolRate](
	[ClOrgSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgSuperInterClearSpreadsDSpreadVolRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadTLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadTLegRate](
	[ClOrgSuperInterClearSpreadsDSpreadTLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadTLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadTLeg](
	[ClOrgSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgSuperInterClearSpreadsDSpreadTLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLegRate](
	[ClOrgSuperInterClearSpreadsDSpreadRpLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadRpLeg](
	[ClOrgSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[rpNum] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[btNum] [int] NULL,
	[etNum] [nvarchar](1000) NULL,
	[ClOrgSuperInterClearSpreadsDSpreadRpLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadRate](
	[ClOrgSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadPmpsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadPmpsRate](
	[ClOrgSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL,
	[pmRate] [nvarchar](1000) NULL,
	[psRate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadPLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadPLegRate](
	[ClOrgSuperInterClearSpreadsDSpreadPLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpreadPLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpreadPLeg](
	[ClOrgSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgSuperInterClearSpreadsDSpreadPLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgSuperInterClearSpreadsDSpread]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgSuperInterClearSpreadsDSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgSuperInterClearSpreadsDSpread](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[spreadType] [nvarchar](1000) NULL,
	[chargeMeth] [nvarchar](1000) NULL,
	[ClOrgSuperInterClearSpreadsDSpreadId] int identity(1,1) primary key,
	[ClOrgSuperInterClearSpreadsDSpreadParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgPointDefScanPointDefVolScanDef]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefScanPointDefVolScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgPointDefScanPointDefVolScanDef](
	[ClOrgPointDefScanPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgPointDefScanPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefScanPointDefPriceScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgPointDefScanPointDefPriceScanDef](
	[ClOrgPointDefScanPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL,
	[defType] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgPointDefScanPointDef]    Script Date: 07/21/2015 15:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefScanPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgPointDefScanPointDef](
	[ClOrgPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[ClOrgPointDefScanPointDefId] int identity(1,1) primary key,
	[weight] [float] NULL,
	[pairedPoint] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgPointDefDeltaPointDefVolScanDef]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefDeltaPointDefVolScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgPointDefDeltaPointDefVolScanDef](
	[ClOrgPointDefDeltaPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgPointDefDeltaPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefDeltaPointDefPriceScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgPointDefDeltaPointDefPriceScanDef](
	[ClOrgPointDefDeltaPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL,
	[defType] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgPointDefDeltaPointDef]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDefDeltaPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgPointDefDeltaPointDef](
	[ClOrgPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[ClOrgPointDefDeltaPointDefId] int identity(1,1) primary key,
	[weight] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgPointDef]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgPointDef](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgPointDefId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgPbRateDef]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgPbRateDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgPbRateDef](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[isCust] [bit] NULL,
	[acctType] [nvarchar](1000) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpreadSPointDef]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpreadSPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsSSpreadSPointDef](
	[ClOrgInterSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[aggMeth] [int] NULL,
	[sRate] [float] NULL,
	[nMaxLoss] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpreadSLegRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpreadSLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsSSpreadSLegRate](
	[ClOrgInterSpreadsSSpreadSLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpreadSLeg]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpreadSLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsSSpreadSLeg](
	[ClOrgInterSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[isTarget] [bit] NULL,
	[isRequired] [bit] NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgInterSpreadsSSpreadSLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpreadRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsSSpreadRate](
	[ClOrgInterSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsSSpread]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsSSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsSSpread](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[isTargetReq] [bit] NULL,
	[numLegsReq] [nvarchar](1000) NULL,
	[applyFxRisk] [bit] NULL,
	[apportionRisk] [bit] NULL,
	[ClOrgInterSpreadsSSpreadId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadVolRateRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadVolRateRate](
	[ClOrgInterSpreadsDSpreadVolRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadVolRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadVolRate](
	[ClOrgInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgInterSpreadsDSpreadVolRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadTLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadTLegRate](
	[ClOrgInterSpreadsDSpreadTLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadTLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadTLeg](
	[ClOrgInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgInterSpreadsDSpreadTLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadRpLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadRpLegRate](
	[ClOrgInterSpreadsDSpreadRpLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadRpLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadRpLeg](
	[ClOrgInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[rpNum] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[btNum] [int] NULL,
	[etNum] [nvarchar](1000) NULL,
	[ClOrgInterSpreadsDSpreadRpLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadRate](
	[ClOrgInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadPmpsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadPmpsRate](
	[ClOrgInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL,
	[pmRate] [nvarchar](1000) NULL,
	[psRate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadPLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadPLegRate](
	[ClOrgInterSpreadsDSpreadPLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpreadPLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpreadPLeg](
	[ClOrgInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgInterSpreadsDSpreadPLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterSpreadsDSpread]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterSpreadsDSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterSpreadsDSpread](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[spreadType] [nvarchar](1000) NULL,
	[chargeMeth] [nvarchar](1000) NULL,
	[ClOrgInterSpreadsDSpreadId] int identity(1,1) primary key,
	[ClOrgInterSpreadsDSpreadParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterClearSpreadsHomeLegRate]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterClearSpreadsHomeLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterClearSpreadsHomeLegRate](
	[ClOrgInterClearSpreadsHomeLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterClearSpreadsHomeLeg]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterClearSpreadsHomeLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterClearSpreadsHomeLeg](
	[ClOrgInterClearSpreadsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgInterClearSpreadsHomeLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterClearSpreadsAwayLeg]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterClearSpreadsAwayLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterClearSpreadsAwayLeg](
	[ClOrgInterClearSpreadsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ec] [nvarchar](1000) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgInterClearSpreads]    Script Date: 07/21/2015 15:00:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgInterClearSpreads]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgInterClearSpreads](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[ClOrgInterClearSpreadsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetSeedTm]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetSeedTm]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgHvarMarginParamsHvarSetSeedTm](
	[tm] [float] NULL,
	[ClOrgHvarMarginParamsHvarSetSeedId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetSeed]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetSeed]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgHvarMarginParamsHvarSetSeed](
	[ClOrgHvarMarginParamsHvarSetId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[offset] [int] NULL,
	[ClOrgHvarMarginParamsHvarSetSeedId] int identity(1,1) primary key,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetHVal]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetHVal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgHvarMarginParamsHvarSetHVal](
	[hVal] [nvarchar](max) NULL,
	[ClOrgHvarMarginParamsHvarSetId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetHRet]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetHRet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgHvarMarginParamsHvarSetHRet](
	[hRet] [nvarchar](1000) NULL,
	[ClOrgHvarMarginParamsHvarSetId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSetHLogRet]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSetHLogRet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgHvarMarginParamsHvarSetHLogRet](
	[hLogRet] [nvarchar](max) NULL,
	[ClOrgHvarMarginParamsHvarSetId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsHvarSet]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsHvarSet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgHvarMarginParamsHvarSet](
	[ClOrgHvarMarginParamsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[pfCode] [nvarchar](1000) NULL,
	[curveId] [int] NULL,
	[curveType] [nvarchar](1000) NULL,
	[threshold] [int] NULL,
	[zeroCurveId] [int] NULL,
	[description] [nvarchar](1000) NULL,
	[undHvarSetId] [int] NULL,
	[lambda] [float] NULL,
	[percentile] [float] NULL,
	[floor] [float] NULL,
	[lookBack] [int] NULL,
	[lookBackData] [int] NULL,
	[useRollNum] [bit] NULL DEFAULT ((0)),
	[lag] [int] NULL,
	[ClOrgHvarMarginParamsHvarSetId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsFxHvarSetFxHvarData]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsFxHvarSetFxHvarData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgHvarMarginParamsFxHvarSetFxHvarData](
	[ClOrgHvarMarginParamsFxHvarSetId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[bDate] [nvarchar](1000) NULL,
	[logRet] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParamsFxHvarSet]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParamsFxHvarSet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgHvarMarginParamsFxHvarSet](
	[ClOrgHvarMarginParamsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[fromCur] [nvarchar](1000) NULL,
	[toCur] [nvarchar](1000) NULL,
	[description] [nvarchar](1000) NULL,
	[lambda] [float] NULL,
	[percentile] [float] NULL,
	[floor] [float] NULL,
	[lookBack] [int] NULL,
	[lookBackData] [int] NULL,
	[lag] [int] NULL,
	[seed] [float] NULL,
	[ClOrgHvarMarginParamsFxHvarSetId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgHvarMarginParams]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgHvarMarginParams]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgHvarMarginParams](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgHvarMarginParamsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfVenueTick]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfVenueTick](
	[ClOrgExchangePhyPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfVenue]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfVenue](
	[ClOrgExchangePhyPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangePhyPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfSpecsFee]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfSpecsFee](
	[ClOrgExchangePhyPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfSpecs]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfSpecs](
	[ClOrgExchangePhyPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangePhyPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyVenueTick]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfPhyVenueTick](
	[ClOrgExchangePhyPfPhyVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyVenue]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfPhyVenue](
	[ClOrgExchangePhyPfPhyId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangePhyPfPhyVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyTick]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfPhyTick](
	[ClOrgExchangePhyPfPhyId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyScanRate]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfPhyScanRate](
	[ClOrgExchangePhyPfPhyId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyRaA]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfPhyRaA](
	[a] [float] NULL,
	[ClOrgExchangePhyPfPhyRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyRa]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfPhyRa](
	[ClOrgExchangePhyPfPhyId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangePhyPfPhyRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhyAlias]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhyAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfPhyAlias](
	[ClOrgExchangePhyPfPhyId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfPhy]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfPhy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfPhy](
	[ClOrgExchangePhyPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[gbxId] [bigint] NULL,
	[ClOrgExchangePhyPfPhyId] int identity(1,1) primary key,
	[pe] [nvarchar](1000) NULL,
	[p] [float] NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[haircut] [nvarchar](1000) NULL,
	[haircutRsv] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfGroup]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfGroup](
	[ClOrgExchangePhyPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtVenueTick]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfDebtVenueTick](
	[ClOrgExchangePhyPfDebtVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtVenue]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfDebtVenue](
	[ClOrgExchangePhyPfDebtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangePhyPfDebtVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtTick]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfDebtTick](
	[ClOrgExchangePhyPfDebtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtScanRate]    Script Date: 07/21/2015 15:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfDebtScanRate](
	[ClOrgExchangePhyPfDebtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtRaA]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfDebtRaA](
	[a] [float] NULL,
	[ClOrgExchangePhyPfDebtRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtRa]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfDebtRa](
	[ClOrgExchangePhyPfDebtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangePhyPfDebtRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebtAlias]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebtAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfDebtAlias](
	[ClOrgExchangePhyPfDebtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfDebt]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfDebt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfDebt](
	[ClOrgExchangeEDebtPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[ClOrgExchangePhyPfDebtId] int identity(1,1) primary key,
	[cusip] [nvarchar](1000) NULL,
	[isin] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[gbxId] [bigint] NULL,
	[p] [float] NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL,
	[subType] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[cpnRate] [float] NULL,
	[cpnFreq] [nvarchar](1000) NULL,
	[cpnNextDate] [nvarchar](1000) NULL,
	[cpnLastDate] [nvarchar](1000) NULL,
	[accruedIntr] [float] NULL,
	[duration] [nvarchar](1000) NULL,
	[lbe] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbUndC]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfCmbUndC](
	[ClOrgExchangeCmbPfCmbId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbScanRate]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfCmbScanRate](
	[ClOrgExchangeCmbPfCmbId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbRaA]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfCmbRaA](
	[a] [float] NULL,
	[ClOrgExchangeCmbPfCmbRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbRa]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfCmbRa](
	[ClOrgExchangeCmbPfCmbId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeCmbPfCmbRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbDvad]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbDvad]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfCmbDvad](
	[ClOrgExchangeCmbPfCmbId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[dv] [nvarchar](1000) NULL,
	[dvcum] [nvarchar](1000) NULL,
	[dvs] [nvarchar](1000) NULL,
	[dvcs] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmbAlias]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmbAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfCmbAlias](
	[ClOrgExchangeCmbPfCmbId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfCmb]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfCmb]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfCmb](
	[ClOrgExchangeCmbPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[ClOrgExchangeCmbPfCmbId] int identity(1,1) primary key,
	[pe] [nvarchar](1000) NULL,
	[gbxId] [bigint] NULL,
	[p] [float] NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[t] [nvarchar](1000) NULL,
	[fdot] [nvarchar](1000) NULL,
	[ldot] [nvarchar](1000) NULL,
	[fDeliv] [nvarchar](1000) NULL,
	[lDeliv] [nvarchar](1000) NULL,
	[sprCharge] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPfAlias]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPfAlias](
	[ClOrgExchangePhyPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangePhyPf]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangePhyPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangePhyPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangePhyPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[priceQuoteCcy] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[eqPosFactor] [float] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfVenueTick]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfVenueTick](
	[ClOrgExchangeOopPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfVenue]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfVenue](
	[ClOrgExchangeOopPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeOopPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfUndPf]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfUndPf](
	[ClOrgExchangeOopPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSpecsFee]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSpecsFee](
	[ClOrgExchangeOopPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSpecs]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSpecs](
	[ClOrgExchangeOopPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeOopPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesVenueTick]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesVenueTick](
	[ClOrgExchangeOopPfSeriesVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesVenue]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesVenue](
	[ClOrgExchangeOopPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeOopPfSeriesVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesUndC]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesUndC](
	[ClOrgExchangeOopPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesTick]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesTick](
	[ClOrgExchangeOopPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesScanRate]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesScanRate](
	[ClOrgExchangeOopPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesOptRaA]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesOptRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesOptRaA](
	[a] [float] NULL,
	[ClOrgExchangeOopPfSeriesOptRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesOptRa]    Script Date: 07/21/2015 15:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesOptRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesOptRa](
	[ClOrgExchangeOopPfSeriesOptId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeOopPfSeriesOptRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesOptAlias]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesOptAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesOptAlias](
	[ClOrgExchangeOopPfSeriesOptId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesOpt]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesOpt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesOpt](
	[ClOrgExchangeOopPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[gbxId] [bigint] NULL,
	[ClOrgExchangeOopPfSeriesOptId] int identity(1,1) primary key,
	[o] [nvarchar](1000) NULL,
	[k] [nvarchar](1000) NULL,
	[p] [float] NULL,
	[pq] [nvarchar](1000) NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesIntrRate]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesIntrRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesIntrRate](
	[ClOrgExchangeOopPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[rl] [float] NULL,
	[cpm] [float] NULL,
	[tm] [float] NULL,
	[exm] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesDivRateDiv]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesDivRateDiv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesDivRateDiv](
	[ClOrgExchangeOopPfSeriesDivRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[dtm] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesDivRate]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesDivRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesDivRate](
	[ClOrgExchangeOopPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[ClOrgExchangeOopPfSeriesDivRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeriesAlias]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeriesAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeriesAlias](
	[ClOrgExchangeOopPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfSeries]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfSeries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfSeries](
	[ClOrgExchangeOopPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[ClOrgExchangeOopPfSeriesId] int identity(1,1) primary key,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[volSrc] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[t] [nvarchar](1000) NULL,
	[fdot] [nvarchar](1000) NULL,
	[ldot] [nvarchar](1000) NULL,
	[seriesSetlMeth] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[refPriceFlag] [nvarchar](1000) NULL,
	[refPrice] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfGroup]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfGroup](
	[ClOrgExchangeOopPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPfAlias]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPfAlias](
	[ClOrgExchangeOopPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOopPf]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOopPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOopPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeOopPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[exercise] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[priceQuoteCcy] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[isVariableTick] [bit] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[strikeDl] [nvarchar](1000) NULL,
	[strikeFmt] [nvarchar](1000) NULL,
	[cab] [float] NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[priceModel] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfVenueTick]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfVenueTick](
	[ClOrgExchangeOofPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfVenue]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfVenue](
	[ClOrgExchangeOofPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeOofPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfUndPf]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfUndPf](
	[ClOrgExchangeOofPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSpecsFee]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSpecsFee](
	[ClOrgExchangeOofPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSpecs]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSpecs](
	[ClOrgExchangeOofPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeOofPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesVenueTick]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesVenueTick](
	[ClOrgExchangeOofPfSeriesVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesVenue]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesVenue](
	[ClOrgExchangeOofPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeOofPfSeriesVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesUndC]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesUndC](
	[ClOrgExchangeOofPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesTick]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesTick](
	[ClOrgExchangeOofPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesScanRate]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesScanRate](
	[ClOrgExchangeOofPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesOptRaA]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesOptRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesOptRaA](
	[a] [float] NULL,
	[ClOrgExchangeOofPfSeriesOptRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesOptRa]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesOptRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesOptRa](
	[ClOrgExchangeOofPfSeriesOptId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeOofPfSeriesOptRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesOptAlias]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesOptAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesOptAlias](
	[ClOrgExchangeOofPfSeriesOptId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesOpt]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesOpt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesOpt](
	[ClOrgExchangeOofPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[gbxId] [bigint] NULL,
	[ClOrgExchangeOofPfSeriesOptId] int identity(1,1) primary key,
	[o] [nvarchar](1000) NULL,
	[k] [nvarchar](1000) NULL,
	[p] [float] NULL,
	[pq] [nvarchar](1000) NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesIntrRate]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesIntrRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesIntrRate](
	[ClOrgExchangeOofPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[rl] [float] NULL,
	[cpm] [float] NULL,
	[tm] [float] NULL,
	[exm] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesDivRateDiv]    Script Date: 07/21/2015 15:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesDivRateDiv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesDivRateDiv](
	[ClOrgExchangeOofPfSeriesDivRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[dtm] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesDivRate]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesDivRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesDivRate](
	[ClOrgExchangeOofPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[ClOrgExchangeOofPfSeriesDivRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeriesAlias]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeriesAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeriesAlias](
	[ClOrgExchangeOofPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfSeries]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfSeries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfSeries](
	[ClOrgExchangeOofPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[ClOrgExchangeOofPfSeriesId] int identity(1,1) primary key,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[volSrc] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[t] [nvarchar](1000) NULL,
	[fdot] [nvarchar](1000) NULL,
	[ldot] [nvarchar](1000) NULL,
	[seriesSetlMeth] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[refPriceFlag] [nvarchar](1000) NULL,
	[refPrice] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfGroup]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfGroup](
	[ClOrgExchangeOofPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPfAlias]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPfAlias](
	[ClOrgExchangeOofPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOofPf]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOofPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOofPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeOofPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[exercise] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[priceQuoteCcy] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[isVariableTick] [bit] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[strikeDl] [nvarchar](1000) NULL,
	[strikeFmt] [nvarchar](1000) NULL,
	[cab] [float] NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[priceModel] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfVenueTick]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfVenueTick](
	[ClOrgExchangeOoePfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfVenue]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfVenue](
	[ClOrgExchangeOoePfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeOoePfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfUndPf]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfUndPf](
	[ClOrgExchangeOoePfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSpecsFee]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSpecsFee](
	[ClOrgExchangeOoePfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSpecs]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSpecs](
	[ClOrgExchangeOoePfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeOoePfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesVenueTick]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesVenueTick](
	[ClOrgExchangeOoePfSeriesVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesVenue]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesVenue](
	[ClOrgExchangeOoePfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeOoePfSeriesVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesUndC]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesUndC](
	[ClOrgExchangeOoePfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesTick]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesTick](
	[ClOrgExchangeOoePfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesScanRate]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesScanRate](
	[ClOrgExchangeOoePfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesOptRaA]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesOptRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesOptRaA](
	[a] [float] NULL,
	[ClOrgExchangeOoePfSeriesOptRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesOptRa]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesOptRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesOptRa](
	[ClOrgExchangeOoePfSeriesOptId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeOoePfSeriesOptRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesOptAlias]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesOptAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesOptAlias](
	[ClOrgExchangeOoePfSeriesOptId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesOpt]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesOpt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesOpt](
	[ClOrgExchangeOoePfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[gbxId] [bigint] NULL,
	[ClOrgExchangeOoePfSeriesOptId] int identity(1,1) primary key,
	[o] [nvarchar](1000) NULL,
	[k] [nvarchar](1000) NULL,
	[p] [float] NULL,
	[pq] [nvarchar](1000) NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesIntrRate]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesIntrRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesIntrRate](
	[ClOrgExchangeOoePfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[rl] [float] NULL,
	[cpm] [float] NULL,
	[tm] [float] NULL,
	[exm] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesDivRateDiv]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesDivRateDiv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesDivRateDiv](
	[ClOrgExchangeOoePfSeriesDivRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[dtm] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesDivRate]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesDivRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesDivRate](
	[ClOrgExchangeOoePfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[ClOrgExchangeOoePfSeriesDivRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeriesAlias]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeriesAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeriesAlias](
	[ClOrgExchangeOoePfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfSeries]    Script Date: 07/21/2015 15:00:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfSeries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfSeries](
	[ClOrgExchangeOoePfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[ClOrgExchangeOoePfSeriesId] int identity(1,1) primary key,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[volSrc] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[t] [nvarchar](1000) NULL,
	[fdot] [nvarchar](1000) NULL,
	[ldot] [nvarchar](1000) NULL,
	[seriesSetlMeth] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[refPriceFlag] [nvarchar](1000) NULL,
	[refPrice] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfGroup]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfGroup](
	[ClOrgExchangeOoePfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePfAlias]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePfAlias](
	[ClOrgExchangeOoePfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOoePf]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOoePf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOoePf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeOoePfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[exercise] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[priceQuoteCcy] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[isVariableTick] [bit] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[strikeDl] [nvarchar](1000) NULL,
	[strikeFmt] [nvarchar](1000) NULL,
	[cab] [float] NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[priceModel] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfVenueTick]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfVenueTick](
	[ClOrgExchangeOocPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfVenue]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfVenue](
	[ClOrgExchangeOocPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeOocPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfUndPf]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfUndPf](
	[ClOrgExchangeOocPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSpecsFee]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSpecsFee](
	[ClOrgExchangeOocPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSpecs]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSpecs](
	[ClOrgExchangeOocPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeOocPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesVenueTick]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesVenueTick](
	[ClOrgExchangeOocPfSeriesVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesVenue]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesVenue](
	[ClOrgExchangeOocPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeOocPfSeriesVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesUndC]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesUndC](
	[ClOrgExchangeOocPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesTick]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesTick](
	[ClOrgExchangeOocPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesScanRate]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesScanRate](
	[ClOrgExchangeOocPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesOptRaA]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesOptRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesOptRaA](
	[a] [float] NULL,
	[ClOrgExchangeOocPfSeriesOptRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesOptRa]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesOptRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesOptRa](
	[ClOrgExchangeOocPfSeriesOptId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeOocPfSeriesOptRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesOptAlias]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesOptAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesOptAlias](
	[ClOrgExchangeOocPfSeriesOptId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesOpt]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesOpt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesOpt](
	[ClOrgExchangeOocPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[gbxId] [bigint] NULL,
	[ClOrgExchangeOocPfSeriesOptId] int identity(1,1) primary key,
	[o] [nvarchar](1000) NULL,
	[k] [nvarchar](1000) NULL,
	[p] [float] NULL,
	[pq] [nvarchar](1000) NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesIntrRate]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesIntrRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesIntrRate](
	[ClOrgExchangeOocPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[rl] [float] NULL,
	[cpm] [float] NULL,
	[tm] [float] NULL,
	[exm] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesDivRateDiv]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesDivRateDiv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesDivRateDiv](
	[ClOrgExchangeOocPfSeriesDivRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[dtm] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesDivRate]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesDivRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesDivRate](
	[ClOrgExchangeOocPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[ClOrgExchangeOocPfSeriesDivRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeriesAlias]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeriesAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeriesAlias](
	[ClOrgExchangeOocPfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfSeries]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfSeries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfSeries](
	[ClOrgExchangeOocPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[ClOrgExchangeOocPfSeriesId] int identity(1,1) primary key,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[volSrc] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[t] [nvarchar](1000) NULL,
	[fdot] [nvarchar](1000) NULL,
	[ldot] [nvarchar](1000) NULL,
	[seriesSetlMeth] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[refPriceFlag] [nvarchar](1000) NULL,
	[refPrice] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfGroup]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfGroup](
	[ClOrgExchangeOocPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPfAlias]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPfAlias](
	[ClOrgExchangeOocPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeOocPf]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeOocPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeOocPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeOocPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[exercise] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[priceQuoteCcy] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[svf] [float] NULL,
	[isVariableTick] [bit] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[strikeDl] [nvarchar](1000) NULL,
	[strikeFmt] [nvarchar](1000) NULL,
	[cab] [float] NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[priceModel] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfZeroCurveId]    Script Date: 07/21/2015 15:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfZeroCurveId]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfZeroCurveId](
	[zeroCurveId] [int] NULL,
	[ClOrgExchangeIRSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfVenueTick]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfVenueTick](
	[ClOrgExchangeIRSwapPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfVenue]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfVenue](
	[ClOrgExchangeIRSwapPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfUndPf]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfUndPf](
	[ClOrgExchangeIRSwapPf] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfSpecsFee]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfSpecsFee](
	[ClOrgExchangeIRSwapPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfSpecs]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfSpecs](
	[ClOrgExchangeIRSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapRaA]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapRaA](
	[a] [float] NULL,
	[ClOrgExchangeIRSwapPfIRSwapRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapRa]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapRa](
	[ClOrgExchangeIRSwapPfIRSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeIRSwapPfIRSwapRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCal](
	[ClOrgExchangeIRSwapPfIRSwapFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegResetDateAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCal](
	[ClOrgExchangeIRSwapPfIRSwapFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegPayAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCal](
	[ClOrgExchangeIRSwapPfIRSwapFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegMatDateAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegInitialStub]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegInitialStub]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegInitialStub](
	[ClOrgExchangeIRSwapPfIRSwapFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[firstRegPerStartDate] [nvarchar](1000) NULL,
	[rate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCalCode]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCal]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCal](
	[ClOrgExchangeIRSwapPfIRSwapFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegFixingDateCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCal](
	[ClOrgExchangeIRSwapPfIRSwapFloatLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegCalcPerAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLeg]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFloatLeg](
	[ClOrgExchangeIRSwapPfIRSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[startDate] [nvarchar](1000) NULL,
	[matDate] [nvarchar](1000) NULL,
	[matAdjBusDayConv] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFloatLegId] int identity(1,1) primary key,
	[notional] [float] NULL,
	[rollConv] [nvarchar](1000) NULL,
	[fixedRate] [float] NULL,
	[payFreq] [nvarchar](1000) NULL,
	[payRelTo] [nvarchar](1000) NULL,
	[payAdjBusDayConv] [nvarchar](1000) NULL,
	[dayCount] [nvarchar](1000) NULL,
	[indx] [nvarchar](1000) NULL,
	[indexTenor] [nvarchar](1000) NULL,
	[spread] [float] NULL,
	[calcPerAdjBusDayConv] [nvarchar](1000) NULL,
	[calcFreq] [nvarchar](1000) NULL,
	[compMethod] [nvarchar](1000) NULL,
	[fixingDateOffset] [nvarchar](1000) NULL,
	[fixingDayType] [nvarchar](1000) NULL,
	[fixingDateBusDayConv] [nvarchar](1000) NULL,
	[resetFreq] [nvarchar](1000) NULL,
	[resetRelTo] [nvarchar](1000) NULL,
	[resetDateAdjDayConv] [nvarchar](1000) NULL,
	[currentPeriodRate] [float] NULL,
	[accruedInt] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCal](
	[ClOrgExchangeIRSwapPfIRSwapFixedLeg] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegResetDateAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCal]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCal](
	[ClOrgExchangeIRSwapPfIRSwapFixedLeg] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegPayAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCalCode]    Script Date: 07/21/2015 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCal]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCal](
	[ClOrgExchangeIRSwapPfIRSwapFixedLeg] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegMatDateAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegInitialStub]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegInitialStub]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegInitialStub](
	[ClOrgExchangeIRSwapPfIRSwapFixedLeg] int null,
	[MissingElements] [nvarchar](max) NULL,
	[firstRegPerStartDate] [nvarchar](1000) NULL,
	[rate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCalCode]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCal]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCal](
	[ClOrgExchangeIRSwapPfIRSwapFixedLeg] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegFixingDateCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCalCode]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCalCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCalCode](
	[calCode] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCalId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCal]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCal](
	[ClOrgExchangeIRSwapPfIRSwapFixedLeg] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegCalcPerAdjCalId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLeg]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapFixedLeg](
	[ClOrgExchangeIRSwapPfIRSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[startDate] [nvarchar](1000) NULL,
	[matDate] [nvarchar](1000) NULL,
	[matAdjBusDayConv] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfIRSwapFixedLegId] int identity(1,1) primary key,
	[notional] [float] NULL,
	[rollConv] [nvarchar](1000) NULL,
	[fixedRate] [float] NULL,
	[payFreq] [nvarchar](1000) NULL,
	[payRelTo] [nvarchar](1000) NULL,
	[payAdjBusDayConv] [nvarchar](1000) NULL,
	[dayCount] [nvarchar](1000) NULL,
	[indx] [nvarchar](1000) NULL,
	[indexTenor] [nvarchar](1000) NULL,
	[spread] [float] NULL,
	[calcPerAdjBusDayConv] [nvarchar](1000) NULL,
	[calcFreq] [nvarchar](1000) NULL,
	[compMethod] [nvarchar](1000) NULL,
	[fixingDateOffset] [nvarchar](1000) NULL,
	[fixingDayType] [nvarchar](1000) NULL,
	[fixingDateBusDayConv] [nvarchar](1000) NULL,
	[resetFreq] [nvarchar](1000) NULL,
	[resetRelTo] [nvarchar](1000) NULL,
	[resetDateAdjDayConv] [nvarchar](1000) NULL,
	[currentPeriodRate] [float] NULL,
	[accruedInt] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapDvad]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapDvad]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapDvad](
	[ClOrgExchangeIRSwapPfIRSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[dv] [nvarchar](1000) NULL,
	[dvcum] [nvarchar](1000) NULL,
	[dvs] [nvarchar](1000) NULL,
	[dvcs] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwapAlias]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwapAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwapAlias](
	[ClOrgExchangeIRSwapPfIRSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfIRSwap]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfIRSwap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfIRSwap](
	[ClOrgExchangeIRSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[ClOrgExchangeIRSwapPfIRSwapId] int identity(1,1) primary key,
	[pe] [nvarchar](1000) NULL,
	[gbxId] [bigint] NULL,
	[p] [float] NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[t] [nvarchar](1000) NULL,
	[fdot] [nvarchar](1000) NULL,
	[ldot] [nvarchar](1000) NULL,
	[fDeliv] [nvarchar](1000) NULL,
	[lDeliv] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfGroup]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfGroup](
	[ClOrgExchangeIRSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfFloatLeg]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfFloatLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfFloatLeg](
	[ClOrgExchangeIRSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[payFreq] [nvarchar](1000) NULL,
	[calcFreq] [nvarchar](1000) NULL,
	[indx] [nvarchar](1000) NULL,
	[indexTenor] [nvarchar](1000) NULL,
	[dCurveId] [int] NULL,
	[fCurveId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfFixedLeg]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfFixedLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfFixedLeg](
	[ClOrgExchangeIRSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[currency] [nvarchar](1000) NULL,
	[payFreq] [nvarchar](1000) NULL,
	[calcFreq] [nvarchar](1000) NULL,
	[indx] [nvarchar](1000) NULL,
	[indexTenor] [nvarchar](1000) NULL,
	[dCurveId] [int] NULL,
	[fCurveId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPfAlias]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPfAlias](
	[ClOrgExchangeIRSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeIRSwapPf]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeIRSwapPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeIRSwapPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeIRSwapPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[eqPosFactor] [float] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfVenueTick]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfVenueTick](
	[ClOrgExchangeFwdPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfVenue]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfVenue](
	[ClOrgExchangeFwdPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeFwdPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfUndPf]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfUndPf](
	[ClOrgExchangeFwdPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfSpecsFee]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfSpecsFee](
	[ClOrgExchangeFwdPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfSpecs]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfSpecs](
	[ClOrgExchangeFwdPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeFwdPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfGroup]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfGroup](
	[ClOrgExchangeFwdPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdVenueTick]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdVenueTick](
	[ClOrgExchangeFwdPfFwdVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdVenue]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdVenue](
	[ClOrgExchangeFwdPfFwdId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeFwdPfFwdVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdUndC]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdUndC](
	[ClOrgExchangeFwdPfFwdId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdTick]    Script Date: 07/21/2015 15:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdTick](
	[ClOrgExchangeFwdPfFwdId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdScanRate]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdScanRate](
	[ClOrgExchangeFwdPfFwdId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdRaA]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdRaA](
	[a] [float] NULL,
	[ClOrgExchangeFwdPfFwdRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdRa]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdRa](
	[ClOrgExchangeFwdPfFwdId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeFwdPfFwdRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdIntrRate]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdIntrRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdIntrRate](
	[ClOrgExchangeFwdPfFwdId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[rl] [float] NULL,
	[cpm] [float] NULL,
	[tm] [float] NULL,
	[exm] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdDvad]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdDvad]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdDvad](
	[ClOrgExchangeFwdPfFwdId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[dv] [nvarchar](1000) NULL,
	[dvcum] [nvarchar](1000) NULL,
	[dvs] [nvarchar](1000) NULL,
	[dvcs] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwdAlias]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwdAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwdAlias](
	[ClOrgExchangeFwdPfFwdId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfFwd]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfFwd]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfFwd](
	[ClOrgExchangeFwdPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[ClOrgExchangeFwdPfFwdId] int identity(1,1) primary key,
	[pe] [nvarchar](1000) NULL,
	[gbxId] [bigint] NULL,
	[p] [float] NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[discFactor] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[t] [nvarchar](1000) NULL,
	[fdot] [nvarchar](1000) NULL,
	[ldot] [nvarchar](1000) NULL,
	[fDeliv] [nvarchar](1000) NULL,
	[lDeliv] [nvarchar](1000) NULL,
	[sprCharge] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPfAlias]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPfAlias](
	[ClOrgExchangeFwdPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFwdPf]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFwdPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFwdPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeFwdPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[priceQuoteCcy] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[eqPosFactor] [float] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfVenueTick]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfVenueTick](
	[ClOrgExchangeFutPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfVenue]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfVenue](
	[ClOrgExchangeFutPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeFutPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfUndPf]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfUndPf](
	[ClOrgExchangeFutPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfSpecsFee]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfSpecsFee](
	[ClOrgExchangeFutPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfSpecs]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfSpecs](
	[ClOrgExchangeFutPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeFutPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfGroup]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfGroup](
	[ClOrgExchangeFutPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutVenueTick]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutVenueTick](
	[ClOrgExchangeFutPfFutVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutVenue]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutVenue](
	[ClOrgExchangeFutPfFutId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeFutPfFutVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutUndC]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutUndC](
	[ClOrgExchangeFutPfFutId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutTick]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutTick](
	[ClOrgExchangeFutPfFutId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutScanRate]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutScanRate](
	[ClOrgExchangeFutPfFutId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutRaA]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutRaA](
	[a] [float] NULL,
	[ClOrgExchangeFutPfFutRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutRa]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutRa](
	[ClOrgExchangeFutPfFutId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeFutPfFutRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutIntrRate]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutIntrRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutIntrRate](
	[ClOrgExchangeFutPfFutId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[rl] [float] NULL,
	[cpm] [float] NULL,
	[tm] [float] NULL,
	[exm] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutDvad]    Script Date: 07/21/2015 15:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutDvad]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutDvad](
	[ClOrgExchangeFutPfFutId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[dv] [nvarchar](1000) NULL,
	[dvcum] [nvarchar](1000) NULL,
	[dvs] [nvarchar](1000) NULL,
	[dvcs] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFutAlias]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFutAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFutAlias](
	[ClOrgExchangeFutPfFutId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfFut]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfFut]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfFut](
	[ClOrgExchangeFutPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[ClOrgExchangeFutPfFutId] int identity(1,1) primary key,
	[pe] [nvarchar](1000) NULL,
	[gbxId] [bigint] NULL,
	[p] [float] NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[t] [nvarchar](1000) NULL,
	[fdot] [nvarchar](1000) NULL,
	[ldot] [nvarchar](1000) NULL,
	[fDeliv] [nvarchar](1000) NULL,
	[lDeliv] [nvarchar](1000) NULL,
	[sprCharge] [float] NULL,
	[earlyPIDDate] [nvarchar](8) NULL,
	[reqdPIDDate] [nvarchar](8) NULL,
	[earlyFVMDate] [nvarchar](8) NULL,
	[reqdFVMDate] [nvarchar](8) NULL,
	[marginRemovalDate] [nvarchar](8) NULL,
	[dlvMarginMethShort] [nvarchar](100) NULL,
	[dlvMarginMethLong] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPfAlias]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPfAlias](
	[ClOrgExchangeFutPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeFutPf]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeFutPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeFutPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeFutPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[priceQuoteCcy] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[eqPosFactor] [float] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL,
	[dlvMarginMeth] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfVenueTick]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfVenueTick](
	[ClOrgExchangeEquityPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfVenue]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfVenue](
	[ClOrgExchangeEquityPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeEquityPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfSpecsFee]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfSpecsFee](
	[ClOrgExchangeEquityPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfSpecs]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfSpecs](
	[ClOrgExchangeEquityPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeEquityPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfGroup]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfGroup](
	[ClOrgExchangeEquityPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityVenueTick]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquityVenueTick](
	[ClOrgExchangeEquityPfEquityVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityVenue]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquityVenue](
	[ClOrgExchangeEquityPfEquityId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeEquityPfEquityVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityTick]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquityTick](
	[ClOrgExchangeEquityPfEquityId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityScanRate]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquityScanRate](
	[ClOrgExchangeEquityPfEquityId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityRaA]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquityRaA](
	[a] [float] NULL,
	[ClOrgExchangeEquityPfEquityRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityRa]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquityRa](
	[ClOrgExchangeEquityPfEquityId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeEquityPfEquityRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityDivRate]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityDivRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquityDivRate](
	[ClOrgExchangeEquityPfEquityId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[ClOrgExchangeEquityPfEquityDivRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityDiv]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityDiv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquityDiv](
	[ClOrgExchangeEquityPfEquityDivRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[dtm] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquityAlias]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquityAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquityAlias](
	[ClOrgExchangeEquityPfEquityId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfEquity]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfEquity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfEquity](
	[ClOrgExchangeEquityPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[ClOrgExchangeEquityPfEquityId] int identity(1,1) primary key,
	[cusip] [nvarchar](1000) NULL,
	[isin] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[gbxId] [bigint] NULL,
	[p] [float] NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL,
	[subType] [nvarchar](1000) NULL,
	[haircut] [nvarchar](1000) NULL,
	[haircutRsv] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPfAlias]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPfAlias](
	[ClOrgExchangeEquityPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEquityPf]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEquityPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEquityPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeEquityPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[eqPosFactor] [float] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL,
	[country] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtVenueTick]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtVenueTick](
	[ClOrgExchangeEDebtVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtVenue]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtVenue](
	[ClOrgExchangeEDebtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeEDebtVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtUndPf]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtUndPf](
	[ClOrgExchangeEDebtPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtUndC]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtUndC](
	[ClOrgExchangeEDebtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtTick]    Script Date: 07/21/2015 15:00:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtTick](
	[ClOrgExchangeEDebtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfVenueTick]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtPfVenueTick](
	[ClOrgExchangeEDebtPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfVenue]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtPfVenue](
	[ClOrgExchangeEDebtPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeEDebtPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfSpecsFee]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtPfSpecsFee](
	[ClOrgExchangeEDebtPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfSpecs]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtPfSpecs](
	[ClOrgExchangeEDebtPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeEDebtPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfGroup]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtPfGroup](
	[ClOrgExchangeEDebtPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPfAlias]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtPfAlias](
	[ClOrgExchangeEDebtPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtPf]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeEDebtPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[eqPosFactor] [float] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL,
	[country] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebtAlias]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebtAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebtAlias](
	[ClOrgExchangeEDebtId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeEDebt]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeEDebt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeEDebt](
	[ClOrgExchangeEDebtPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[ClOrgExchangeEDebtId] int identity(1,1) primary key,
	[cusip] [nvarchar](1000) NULL,
	[isin] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[gbxId] [bigint] NULL,
	[p] [float] NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL,
	[subType] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[cpnRate] [float] NULL,
	[cpnFreq] [nvarchar](1000) NULL,
	[cpnNextDate] [nvarchar](1000) NULL,
	[cpnLastDate] [nvarchar](1000) NULL,
	[accruedIntr] [float] NULL,
	[duration] [nvarchar](1000) NULL,
	[lbe] [nvarchar](1000) NULL,
	[futEqFactor] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfUndPf]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfUndPf](
	[ClOrgExchangeCmbPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfSpecsVenueTick]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfSpecsVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfSpecsVenueTick](
	[ClOrgExchangeCmbPfSpecsVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfSpecsVenue]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfSpecsVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfSpecsVenue](
	[ClOrgExchangeCmbPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeCmbPfSpecsVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfSpecsFee]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfSpecsFee](
	[ClOrgExchangeCmbPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfSpecs]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfSpecs](
	[ClOrgExchangeCmbPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeCmbPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfGroup]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfGroup](
	[ClOrgExchangeCmbPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPfAlias]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPfAlias](
	[ClOrgExchangeCmbPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCmbPf]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCmbPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCmbPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeCmbPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[eqPosFactor] [float] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfVenueTick]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfVenueTick](
	[ClOrgExchangeCDSwapPfVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfVenue]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfVenue](
	[ClOrgExchangeCDSwapPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeCDSwapPfVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfUndPf]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfUndPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfUndPf](
	[ClOrgExchangeCDSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfSpecsFee]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfSpecsFee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfSpecsFee](
	[ClOrgExchangeCDSwapPfSpecsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfSpecs]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfSpecs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfSpecs](
	[ClOrgExchangeCDSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[listed] [nvarchar](1000) NULL,
	[aliasDesc] [nvarchar](1000) NULL,
	[unitDesc] [nvarchar](1000) NULL,
	[quoted] [nvarchar](1000) NULL,
	[priceDesc] [nvarchar](1000) NULL,
	[pointDesc] [nvarchar](1000) NULL,
	[cabDesc] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[posLimit] [nvarchar](1000) NULL,
	[setlDateRule] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL,
	[finalPriceRule] [nvarchar](1000) NULL,
	[ClOrgExchangeCDSwapPfSpecsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfGroup]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfGroup](
	[ClOrgExchangeCDSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapVenueTick]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapVenueTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapVenueTick](
	[ClOrgExchangeCDSwapPfCDSwapVenueId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapVenue]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapVenue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapVenue](
	[ClOrgExchangeCDSwapPfCDSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[hours] [nvarchar](1000) NULL,
	[listDesc] [nvarchar](1000) NULL,
	[flexDesc] [nvarchar](1000) NULL,
	[strikeDesc] [nvarchar](1000) NULL,
	[ClOrgExchangeCDSwapPfCDSwapVenueId] int identity(1,1) primary key,
	[limits] [nvarchar](1000) NULL,
	[limitsDesc] [nvarchar](1000) NULL,
	[fdotRule] [nvarchar](1000) NULL,
	[ldotRule] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapUndC]    Script Date: 07/21/2015 15:00:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapUndC](
	[ClOrgExchangeCDSwapPfCDSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapTick]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapTick]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapTick](
	[ClOrgExchangeCDSwapPfCDSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[val] [float] NULL,
	[loVal] [nvarchar](1000) NULL,
	[hiVal] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapScanRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapScanRate](
	[ClOrgExchangeCDSwapPfCDSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapRaA]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapRaA](
	[a] [float] NULL,
	[ClOrgExchangeCDSwapPfCDSwapRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapRa]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapRa](
	[ClOrgExchangeCDSwapPfCDSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgExchangeCDSwapPfCDSwapRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapIntrRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapIntrRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapIntrRate](
	[ClOrgExchangeCDSwapPfCDSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[rl] [float] NULL,
	[cpm] [float] NULL,
	[tm] [float] NULL,
	[exm] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapDvad]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapDvad]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapDvad](
	[ClOrgExchangeCDSwapPfCDSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[dv] [nvarchar](1000) NULL,
	[dvcum] [nvarchar](1000) NULL,
	[dvs] [nvarchar](1000) NULL,
	[dvcs] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwapAlias]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwapAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwapAlias](
	[ClOrgExchangeCDSwapPfCDSwapId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfCDSwap]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfCDSwap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfCDSwap](
	[ClOrgExchangeCDSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[ClOrgExchangeCDSwapPfCDSwapId] int identity(1,1) primary key,
	[pe] [nvarchar](1000) NULL,
	[coupon] [float] NULL,
	[p] [float] NULL,
	[runSpread] [float] NULL,
	[priceType] [nvarchar](1000) NULL,
	[d] [float] NULL,
	[v] [float] NULL,
	[volType] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[val] [float] NULL,
	[sc] [nvarchar](1000) NULL,
	[setlDate] [nvarchar](1000) NULL,
	[t] [nvarchar](1000) NULL,
	[fdot] [nvarchar](1000) NULL,
	[ldot] [nvarchar](1000) NULL,
	[fDeliv] [nvarchar](1000) NULL,
	[lDeliv] [nvarchar](1000) NULL,
	[sprCharge] [float] NULL,
	[positionsAllowed] [nvarchar](1000) NULL,
	[origTenor] [float] NULL,
	[otrDst] [float] NULL,
	[pv01] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPfAlias]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPfAlias]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPfAlias](
	[ClOrgExchangeCDSwapPfId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[aType] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchangeCDSwapPf]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchangeCDSwapPf]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchangeCDSwapPf](
	[ClOrgExchangeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[CDSubType] [nvarchar](1000) NULL,
	[CDSIsIG] [nvarchar](1000) NULL,
	[domain] [nvarchar](1000) NULL,
	[ClOrgExchangeCDSwapPfId] int identity(1,1) primary key,
	[name] [nvarchar](1000) NULL,
	[currency] [nvarchar](1000) NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[cvf] [float] NULL,
	[eqPosFactor] [float] NULL,
	[notionAmt] [float] NULL,
	[priceDl] [int] NULL,
	[priceFmt] [nvarchar](1000) NULL,
	[couponDl] [int] NULL,
	[runSpreadDl] [int] NULL,
	[sector] [nvarchar](1000) NULL,
	[bidAskSprd] [float] NULL,
	[pv01] [float] NULL,
	[recoveryRate] [float] NULL,
	[cdsCreditEvent] [nvarchar](1000) NULL,
	[cdsNpo] [float] NULL,
	[valueMeth] [nvarchar](1000) NULL,
	[priceMeth] [nvarchar](1000) NULL,
	[setlMeth] [nvarchar](1000) NULL,
	[useOTCRounding] [nvarchar](1000) NULL,
	[positionsAllowed] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgExchange]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgExchange]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgExchange](
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[name] [nvarchar](1000) NULL,
	[ClOrgExchangeId] int identity(1,1) primary key,
	[ClOrgId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCurConvHFactor]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCurConvHFactor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCurConvHFactor](
	[ClOrgCurConvId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[rate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCurConv]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCurConv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCurConv](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[fromCur] [nvarchar](1000) NULL,
	[toCur] [nvarchar](1000) NULL,
	[factor] [nvarchar](1000) NULL,
	[ClOrgCurConvId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCdsMarginParamsSectorDefIg]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCdsMarginParamsSectorDefIg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCdsMarginParamsSectorDefIg](
	[ClOrgCdsMarginParamsSectorDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[dst] [float] NULL,
	[dstExponent] [float] NULL,
	[dstFloor] [float] NULL,
	[capPct] [float] NULL,
	[bidAskFloor] [float] NULL,
	[concCoeficient] [float] NULL,
	[concExponent] [float] NULL,
	[concIntercept] [float] NULL,
	[concScale] [float] NULL,
	[curveShockPct] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCdsMarginParamsSectorDefHy]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCdsMarginParamsSectorDefHy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCdsMarginParamsSectorDefHy](
	[ClOrgCdsMarginParamsSectorDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[dst] [float] NULL,
	[dstExponent] [float] NULL,
	[dstFloor] [float] NULL,
	[capPct] [float] NULL,
	[bidAskFloor] [float] NULL,
	[concCoeficient] [float] NULL,
	[concExponent] [float] NULL,
	[concIntercept] [float] NULL,
	[concScale] [float] NULL,
	[curveShockPct] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCdsMarginParamsSectorDef]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCdsMarginParamsSectorDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCdsMarginParamsSectorDef](
	[ClOrgCdsMarginParamsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[sector] [nvarchar](1000) NULL,
	[ClOrgCdsMarginParamsSectorDefId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCdsMarginParams]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCdsMarginParams]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCdsMarginParams](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cdsIGHYThreshold] [float] NULL,
	[cdsIGCompressionShock] [float] NULL,
	[cdsIGCompressionShockPct] [float] NULL,
	[cdsHYCompressionShock] [float] NULL,
	[cdsHYCompressionShockPct] [float] NULL,
	[cdsIGSingleMinMarginPct] [float] NULL,
	[cdsHYSingleMinMarginPct] [float] NULL,
	[cdsIGIndexMinMarginPct] [float] NULL,
	[cdsHYIndexMinMarginPct] [float] NULL,
	[cdsIGCurveShockPct] [float] NULL,
	[cdsHYCurveShockPct] [float] NULL,
	[cdsIGLiqMarginIntercept] [float] NULL,
	[cdsHYLiqMarginIntercept] [float] NULL,
	[cdsIGLiqMarginCoefficient] [float] NULL,
	[cdsHYLiqMarginCoefficient] [float] NULL,
	[cdsIGLiqMarginExponent] [float] NULL,
	[cdsHYLiqMarginExponent] [float] NULL,
	[cdsIGLiqMarginScale] [float] NULL,
	[cdsHYLiqMarginScale] [float] NULL,
	[cdsIGLiqMarginBidAsk] [float] NULL,
	[cdsHYLiqMarginBidAsk] [float] NULL,
	[cdsIGLiqMarginDST] [float] NULL,
	[cdsHYLiqMarginDST] [float] NULL,
	[cdsIGLiqMarginOTRPV01] [float] NULL,
	[cdsHYLiqMarginOTRPV01] [float] NULL,
	[cdsDeviationPct] [float] NULL,
	[cdsSDV01Weight] [float] NULL,
	[cdsRDV01Weight] [float] NULL,
	[cdsDV01Exponent] [float] NULL,
	[cdsIGOTRBidAskCap] [float] NULL,
	[cdsHYOTRBidAskCap] [float] NULL,
	[ClOrgCdsMarginParamsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefVmRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefVmRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefVmRate](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[lrate] [nvarchar](1000) NULL,
	[lreset] [nvarchar](1000) NULL,
	[llthresh] [nvarchar](1000) NULL,
	[lhthresh] [nvarchar](1000) NULL,
	[srate] [nvarchar](1000) NULL,
	[sreset] [nvarchar](1000) NULL,
	[slthresh] [nvarchar](1000) NULL,
	[shthresh] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefSpotRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefSpotRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefSpotRate](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[pe] [nvarchar](1000) NULL,
	[sprd] [nvarchar](1000) NULL,
	[outr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefSomTierScanRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefSomTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefSomTierScanRate](
	[ClOrgCcDefSomTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefSomTierRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefSomTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefSomTierRate](
	[ClOrgCcDefSomTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefSomTier]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefSomTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefSomTier](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[ClOrgCcDefSomTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefScanTierScanRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefScanTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefScanTierScanRate](
	[ClOrgCcDefScanTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefScanTierRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefScanTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefScanTierRate](
	[ClOrgCcDefScanTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefScanTier]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefScanTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefScanTier](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[ClOrgCcDefScanTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefRateTierScanRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefRateTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefRateTierScanRate](
	[ClOrgCcDefRateTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefRateTierRate]    Script Date: 07/21/2015 15:00:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefRateTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefRateTierRate](
	[ClOrgCcDefRateTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefRateTier]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefRateTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefRateTier](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[ClOrgCcDefRateTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefScanPointDefVolScanDef]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefScanPointDefVolScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefPointDefScanPointDefVolScanDef](
	[ClOrgCcDefPointDefScanPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefScanPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefScanPointDefPriceScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefPointDefScanPointDefPriceScanDef](
	[ClOrgCcDefPointDefScanPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL,
	[defType] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefScanPointDef]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefScanPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefPointDefScanPointDef](
	[ClOrgCcDefPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[ClOrgCcDefPointDefScanPointDefId] int identity(1,1) primary key,
	[weight] [float] NULL,
	[pairedPoint] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefDeltaPointDefVolScanDef]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefDeltaPointDefVolScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefPointDefDeltaPointDefVolScanDef](
	[ClOrgCcDefPointDefDeltaPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefDeltaPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefDeltaPointDefPriceScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefPointDefDeltaPointDefPriceScanDef](
	[ClOrgCcDefPointDefDeltaPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL,
	[defType] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDefDeltaPointDef]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDefDeltaPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefPointDefDeltaPointDef](
	[ClOrgCcDefPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[ClOrgCcDefPointDefDeltaPointDefId] int identity(1,1) primary key,
	[weight] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefPointDef]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefPointDef](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[ClOrgCcDefPointDefId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefPfLink]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefPfLink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefPfLink](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[sc] [nvarchar](1000) NULL,
	[cmbMeth] [nvarchar](1000) NULL,
	[applyBasisRisk] [bit] NULL,
	[arrayPrecision] [int] NULL,
	[oopDeltaMeth] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefLiqRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefLiqRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefLiqRate](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[specificRate] [nvarchar](1000) NULL,
	[genericRate] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefIntrRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefIntrRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefIntrRate](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[rl] [float] NULL,
	[cpm] [float] NULL,
	[tm] [float] NULL,
	[exm] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefIntraTierScanRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefIntraTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefIntraTierScanRate](
	[ClOrgCcDefIntraTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefIntraTierRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefIntraTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefIntraTierRate](
	[ClOrgCcDefIntraTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefIntraTier]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefIntraTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefIntraTier](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[ClOrgCcDefIntraTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefInterTierScanRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefInterTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefInterTierScanRate](
	[ClOrgCcDefInterTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefInterTierRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefInterTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefInterTierRate](
	[ClOrgCcDefInterTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefInterTier]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefInterTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefInterTier](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[ClOrgCcDefInterTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefHvarSetIds]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefHvarSetIds]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefHvarSetIds](
	[hvarSetId] [int] NULL,
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefGroup]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefGroup](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefFxHvarSetIds]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefFxHvarSetIds]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefFxHvarSetIds](
	[fxHvarSetId] [int] NULL,
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadVolRateRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadVolRateRate](
	[ClOrgCcDefDSpreadVolRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadVolRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadVolRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadVolRate](
	[ClOrgCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ClOrgCcDefDSpreadVolRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadTLegRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadTLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadTLegRate](
	[ClOrgCcDefDSpreadTLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadTLeg]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadTLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadTLeg](
	[ClOrgCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgCcDefDSpreadTLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadRpLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadRpLegRate](
	[ClOrgCcDefDSpreadRpLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadRpLeg]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadRpLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadRpLeg](
	[ClOrgCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[rpNum] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[btNum] [int] NULL,
	[etNum] [nvarchar](1000) NULL,
	[ClOrgCcDefDSpreadRpLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadRate](
	[ClOrgCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadPmpsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadPmpsRate](
	[ClOrgCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL,
	[pmRate] [nvarchar](1000) NULL,
	[psRate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadPLegRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadPLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadPLegRate](
	[ClOrgCcDefDSpreadPLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpreadPLeg]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpreadPLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpreadPLeg](
	[ClOrgCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[ClOrgCcDefDSpreadPLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefDSpread]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefDSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefDSpread](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[spreadType] [nvarchar](1000) NULL,
	[chargeMeth] [nvarchar](1000) NULL,
	[ClOrgCcDefDSpreadId] int identity(1,1) primary key,
	[ClOrgCcDefDSpreadParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefConcAdjRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefConcAdjRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefConcAdjRate](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[loMarg] [float] NULL,
	[hiMarg] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefCdsRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefCdsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefCdsRate](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[cdsSystematicShock] [float] NULL,
	[cdsSystematicShockPct] [float] NULL,
	[cdsSectorShock] [float] NULL,
	[cdsSectorShockPct] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefBasisRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefBasisRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefBasisRate](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDefAdjRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDefAdjRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDefAdjRate](
	[ClOrgCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[baseR] [nvarchar](1000) NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrgCcDef]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrgCcDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrgCcDef](
	[ClOrgId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[concScaleUp] [float] NULL DEFAULT ((0)),
	[name] [nvarchar](1000) NULL,
	[ClOrgCcDefId] int identity(1,1) primary key,
	[currency] [nvarchar](1000) NULL,
	[riskExponent] [int] NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[capAnov] [bit] NULL,
	[procMeth] [nvarchar](1000) NULL,
	[wfprMeth] [nvarchar](1000) NULL,
	[spotMeth] [nvarchar](1000) NULL,
	[somMeth] [nvarchar](1000) NULL,
	[cmbMeth] [nvarchar](1000) NULL,
	[marginMeth] [nvarchar](1000) NULL,
	[custUseLov] [bit] NULL,
	[useLovPct] [nvarchar](1000) NULL,
	[vmClass] [nvarchar](1000) NULL,
	[isCDSScanRisk] [bit] NULL,
	[limitSubAccountOffset] [bit] NULL,
	[binaryArrays] [bit] NULL,
	[limitArraysTo16Points] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ClOrg]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClOrg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClOrg](
	[ClOrgId] int identity(1,1) primary key,
	[pointInTimeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ec] [nvarchar](1000) NULL,
	[name] [nvarchar](1000) NULL,
	[isContractScale] [bit] NULL,
	[isNetMargin] [bit] NULL,
	[finalizeMeth] [nvarchar](1000) NULL,
	[oopDeltaMeth] [nvarchar](1000) NULL,
	[capAnov] [bit] NULL,
	[minIntExDeltaPct] [float] NULL,
	[lookAheadYears] [nvarchar](1000) NULL,
	[lookAheadDays] [nvarchar](1000) NULL,
	[daysPerYear] [int] NULL,
	[custUseLov] [bit] NULL,
	[useLovPct] [nvarchar](1000) NULL,
	[limitSubAccountOffset] [bit] NULL,
	[capRiskArray] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpreadSPointDef]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpreadSPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsSSpreadSPointDef](
	[BusFuncSuperSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[aggMeth] [int] NULL,
	[sRate] [float] NULL,
	[nMaxLoss] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpreadSLegRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpreadSLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsSSpreadSLegRate](
	[BusFuncSuperSpreadsSSpreadSLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpreadSLeg]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpreadSLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsSSpreadSLeg](
	[BusFuncSuperSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[isTarget] [bit] NULL,
	[isRequired] [bit] NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncSuperSpreadsSSpreadSLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpreadRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsSSpreadRate](
	[BusFuncSuperSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsSSpread]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsSSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsSSpread](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[isTargetReq] [bit] NULL,
	[numLegsReq] [nvarchar](1000) NULL,
	[applyFxRisk] [bit] NULL,
	[apportionRisk] [bit] NULL,
	[BusFuncSuperSpreadsSSpreadId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadVolRateRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadVolRateRate](
	[BusFuncSuperSpreadsDSpreadVolRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadVolRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadVolRate](
	[BusFuncSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[BusFuncSuperSpreadsDSpreadVolRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadTLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadTLegRate](
	[BusFuncSuperSpreadsDSpreadTLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadTLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadTLeg](
	[BusFuncSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncSuperSpreadsDSpreadTLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadsRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadsRate](
	[BusFuncSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadRpLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadRpLegRate](
	[BusFuncSuperSpreadsDSpreadRpLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadRpLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadRpLeg](
	[BusFuncSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[rpNum] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[btNum] [int] NULL,
	[etNum] [nvarchar](1000) NULL,
	[BusFuncSuperSpreadsDSpreadRpLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadPmpsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadPmpsRate](
	[BusFuncSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL,
	[pmRate] [nvarchar](1000) NULL,
	[psRate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadPLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadPLegRate](
	[BusFuncSuperSpreadsDSpreadPLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpreadPLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpreadPLeg](
	[BusFuncSuperSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncSuperSpreadsDSpreadPLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperSpreadsDSpread]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperSpreadsDSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperSpreadsDSpread](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[spreadType] [nvarchar](1000) NULL,
	[chargeMeth] [nvarchar](1000) NULL,
	[BusFuncSuperSpreadsDSpreadId] int identity(1,1) primary key,
	[BusFuncSuperSpreadsDSpreadParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRateRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRateRate](
	[BusFuncSuperInterClearSpreadsDSpreadVolRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadVolRate](
	[BusFuncSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[BusFuncSuperInterClearSpreadsDSpreadVolRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadTLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadTLegRate](
	[BusFuncSuperInterClearSpreadsDSpreadTLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadTLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadTLeg](
	[BusFuncSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncSuperInterClearSpreadsDSpreadTLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLegRate](
	[BusFuncSuperInterClearSpreadsDSpreadRpLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadRpLeg](
	[BusFuncSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[rpNum] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[btNum] [int] NULL,
	[etNum] [nvarchar](1000) NULL,
	[BusFuncSuperInterClearSpreadsDSpreadRpLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadRate]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadRate](
	[BusFuncSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadPmpsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadPmpsRate](
	[BusFuncSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL,
	[pmRate] [nvarchar](1000) NULL,
	[psRate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadPLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadPLegRate](
	[BusFuncSuperInterClearSpreadsDSpreadPLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpreadPLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpreadPLeg](
	[BusFuncSuperInterClearSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncSuperInterClearSpreadsDSpreadPLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncSuperInterClearSpreadsDSpread]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncSuperInterClearSpreadsDSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncSuperInterClearSpreadsDSpread](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[spreadType] [nvarchar](1000) NULL,
	[chargeMeth] [nvarchar](1000) NULL,
	[BusFuncSuperInterClearSpreadsDSpreadId] int identity(1,1) primary key,
	[BusFuncSuperInterClearSpreadsDSpreadParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncPointDefScanPointDefVolScanDef]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefScanPointDefVolScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncPointDefScanPointDefVolScanDef](
	[BusFuncPointDefScanPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncPointDefScanPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefScanPointDefPriceScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncPointDefScanPointDefPriceScanDef](
	[BusFuncPointDefScanPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL,
	[defType] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncPointDefScanPointDef]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefScanPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncPointDefScanPointDef](
	[BusFuncPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[BusFuncPointDefScanPointDefId] int identity(1,1) primary key,
	[weight] [float] NULL,
	[pairedPoint] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncPointDefDeltaPointDefVolScanDef]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefDeltaPointDefVolScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncPointDefDeltaPointDefVolScanDef](
	[BusFuncPointDefDeltaPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncPointDefDeltaPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefDeltaPointDefPriceScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncPointDefDeltaPointDefPriceScanDef](
	[BusFuncPointDefDeltaPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL,
	[defType] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncPointDefDeltaPointDef]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDefDeltaPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncPointDefDeltaPointDef](
	[BusFuncPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[BusFuncPointDefDeltaPointDefId] int identity(1,1) primary key,
	[weight] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncPointDef]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncPointDef](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[BusFuncPointDefId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncPbRateDef]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncPbRateDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncPbRateDef](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[isCust] [bit] NULL,
	[acctType] [nvarchar](1000) NULL,
	[isM] [bit] NULL,
	[pbc] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpreadSPointDef]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpreadSPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsSSpreadSPointDef](
	[BusFuncInterSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[aggMeth] [int] NULL,
	[sRate] [float] NULL,
	[nMaxLoss] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpreadSLegRate]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpreadSLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsSSpreadSLegRate](
	[BusFuncInterSpreadsSSpreadSLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpreadSLeg]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpreadSLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsSSpreadSLeg](
	[BusFuncInterSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[isTarget] [bit] NULL,
	[isRequired] [bit] NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncInterSpreadsSSpreadSLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpreadRate]    Script Date: 07/21/2015 15:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsSSpreadRate](
	[BusFuncInterSpreadsSSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsSSpread]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsSSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsSSpread](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[isTargetReq] [bit] NULL,
	[numLegsReq] [nvarchar](1000) NULL,
	[applyFxRisk] [bit] NULL,
	[apportionRisk] [bit] NULL,
	[BusFuncInterSpreadsSSpreadId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadVolRateRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadVolRateRate](
	[BusFuncInterSpreadsDSpreadVolRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadVolRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadVolRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadVolRate](
	[BusFuncInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[BusFuncInterSpreadsDSpreadVolRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadTLegRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadTLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadTLegRate](
	[BusFuncInterSpreadsDSpreadTLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadTLeg]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadTLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadTLeg](
	[BusFuncInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncInterSpreadsDSpreadTLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadRpLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadRpLegRate](
	[BusFuncInterSpreadsDSpreadRpLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadRpLeg]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadRpLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadRpLeg](
	[BusFuncInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[rpNum] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[btNum] [int] NULL,
	[etNum] [nvarchar](1000) NULL,
	[BusFuncInterSpreadsDSpreadRpLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadRate](
	[BusFuncInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadPmpsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadPmpsRate](
	[BusFuncInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL,
	[pmRate] [nvarchar](1000) NULL,
	[psRate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadPLegRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadPLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadPLegRate](
	[BusFuncInterSpreadsDSpreadPLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpreadPLeg]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpreadPLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpreadPLeg](
	[BusFuncInterSpreadsDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncInterSpreadsDSpreadPLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterSpreadsDSpread]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterSpreadsDSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterSpreadsDSpread](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[spreadType] [nvarchar](1000) NULL,
	[chargeMeth] [nvarchar](1000) NULL,
	[BusFuncInterSpreadsDSpreadId] int identity(1,1) primary key,
	[BusFuncInterSpreadsDSpreadParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterClearSpreadsHomeLegRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterClearSpreadsHomeLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterClearSpreadsHomeLegRate](
	[BusFuncInterClearSpreadsHomeLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterClearSpreadsHomeLeg]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterClearSpreadsHomeLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterClearSpreadsHomeLeg](
	[BusFuncInterClearSpreadsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncInterClearSpreadsHomeLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterClearSpreadsAwayLeg]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterClearSpreadsAwayLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterClearSpreadsAwayLeg](
	[BusFuncInterClearSpreadsId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ec] [nvarchar](1000) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncInterClearSpreads]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncInterClearSpreads]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncInterClearSpreads](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[BusFuncInterClearSpreadsId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCurConvHFactor]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCurConvHFactor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCurConvHFactor](
	[BusFuncCurConvId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[date] [nvarchar](1000) NULL,
	[rate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCurConv]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCurConv]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCurConv](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[fromCur] [nvarchar](1000) NULL,
	[toCur] [nvarchar](1000) NULL,
	[factor] [nvarchar](1000) NULL,
	[BusFuncCurConvId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesUndC]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesUndC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesUndC](
	[BusFuncCoLinkExchLinkBfPfLinkBfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[cId] [int] NULL,
	[s] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[legPriceFlag] [nvarchar](1000) NULL,
	[legPrice] [float] NULL,
	[type] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesScanRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesScanRate](
	[BusFuncCoLinkExchLinkBfPfLinkBfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCScanRate]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCScanRate](
	[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRaA]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRaA](
	[a] [float] NULL,
	[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRa]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRa](
	[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfC]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfC](
	[BusFuncCoLinkExchLinkBfPfLinkBfSeriesId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[BusFuncCoLinkExchLinkBfPfLinkBfSeriesBfCId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeries]    Script Date: 07/21/2015 15:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfSeries](
	[BusFuncCoLinkExchLinkBfPfLinkId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pe] [nvarchar](1000) NULL,
	[BusFuncCoLinkExchLinkBfPfLinkBfSeriesId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCScanRate]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCScanRate](
	[BusFuncCoLinkExchLinkBfPfLinkBfCId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRaA]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRaA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRaA](
	[a] [float] NULL,
	[BusFuncCoLinkExchLinkBfPfLinkBfCRaId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRa]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfCRa](
	[BusFuncCoLinkExchLinkBfPfLinkBfCId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[BusFuncCoLinkExchLinkBfPfLinkBfCRaId] int identity(1,1) primary key,
	[d] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfC]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLinkBfC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLinkBfC](
	[BusFuncCoLinkExchLinkBfPfLinkId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cId] [int] NULL,
	[BusFuncCoLinkExchLinkBfPfLinkBfCId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLinkBfPfLink]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLinkBfPfLink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLinkBfPfLink](
	[BusFuncCoLinkExchLinkId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[pfAlias] [nvarchar](1000) NULL,
	[BusFuncCoLinkExchLinkBfPfLinkId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLinkExchLink]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLinkExchLink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLinkExchLink](
	[BusFuncCoLinkId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[exchAlias] [nvarchar](1000) NULL,
	[BusFuncCoLinkExchLinkId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCoLink]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCoLink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCoLink](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[ec] [nvarchar](1000) NULL,
	[coAlias] [nvarchar](1000) NULL,
	[BusFuncCoLinkId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefVmRate]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefVmRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefVmRate](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[lrate] [nvarchar](1000) NULL,
	[lreset] [nvarchar](1000) NULL,
	[llthresh] [nvarchar](1000) NULL,
	[lhthresh] [nvarchar](1000) NULL,
	[srate] [nvarchar](1000) NULL,
	[sreset] [nvarchar](1000) NULL,
	[slthresh] [nvarchar](1000) NULL,
	[shthresh] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefSpotRate]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefSpotRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefSpotRate](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[pe] [nvarchar](1000) NULL,
	[sprd] [nvarchar](1000) NULL,
	[outr] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefSomTierScanRate]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefSomTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefSomTierScanRate](
	[BusFuncCcDefSomTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefSomTierRate]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefSomTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefSomTierRate](
	[BusFuncCcDefSomTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefSomTier]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefSomTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefSomTier](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[BusFuncCcDefSomTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefScanTierScanRate]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefScanTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefScanTierScanRate](
	[BusFuncCcDefScanTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefScanTierRate]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefScanTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefScanTierRate](
	[BusFuncCcDefScanTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefScanTier]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefScanTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefScanTier](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[BusFuncCcDefScanTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefRateTierScanRate]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefRateTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefRateTierScanRate](
	[BusFuncCcDefRateTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefRateTierRate]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefRateTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefRateTierRate](
	[BusFuncCcDefRateTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefRateTier]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefRateTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefRateTier](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[BusFuncCcDefRateTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefScanPointDefVolScanDef]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefScanPointDefVolScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefPointDefScanPointDefVolScanDef](
	[BusFuncCcDefPointDefScanPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefScanPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefScanPointDefPriceScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefPointDefScanPointDefPriceScanDef](
	[BusFuncCcDefPointDefScanPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL,
	[defType] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefScanPointDef]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefScanPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefPointDefScanPointDef](
	[BusFuncCcDefPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[BusFuncCcDefPointDefScanPointDefId] int identity(1,1) primary key,
	[weight] [float] NULL,
	[pairedPoint] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefDeltaPointDefVolScanDef]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefDeltaPointDefVolScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefPointDefDeltaPointDefVolScanDef](
	[BusFuncCcDefPointDefDeltaPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefDeltaPointDefPriceScanDef]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefDeltaPointDefPriceScanDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefPointDefDeltaPointDefPriceScanDef](
	[BusFuncCcDefPointDefDeltaPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[mult] [nvarchar](1000) NULL,
	[numerator] [nvarchar](1000) NULL,
	[denominator] [nvarchar](1000) NULL,
	[defType] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDefDeltaPointDef]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDefDeltaPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefPointDefDeltaPointDef](
	[BusFuncCcDefPointDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[point] [int] NULL,
	[BusFuncCcDefPointDefDeltaPointDefId] int identity(1,1) primary key,
	[weight] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefPointDef]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPointDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefPointDef](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[BusFuncCcDefPointDefId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefPfLink]    Script Date: 07/21/2015 15:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefPfLink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefPfLink](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[exch] [nvarchar](1000) NULL,
	[pfId] [int] NULL,
	[pfCode] [nvarchar](1000) NULL,
	[pfType] [nvarchar](1000) NULL,
	[sc] [nvarchar](1000) NULL,
	[cmbMeth] [nvarchar](1000) NULL,
	[applyBasisRisk] [bit] NULL,
	[arrayPrecision] [int] NULL,
	[oopDeltaMeth] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefLiqRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefLiqRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefLiqRate](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[specificRate] [nvarchar](1000) NULL,
	[genericRate] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefIntrRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefIntrRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefIntrRate](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[rl] [float] NULL,
	[cpm] [float] NULL,
	[tm] [float] NULL,
	[exm] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefIntraTierScanRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefIntraTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefIntraTierScanRate](
	[BusFuncCcDefIntraTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefIntraTierRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefIntraTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefIntraTierRate](
	[BusFuncCcDefIntraTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefIntraTier]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefIntraTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefIntraTier](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[BusFuncCcDefIntraTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefInterTierScanRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefInterTierScanRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefInterTierScanRate](
	[BusFuncCcDefInterTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[priceScan] [float] NULL,
	[priceScanPct] [float] NULL,
	[volScan] [float] NULL,
	[volScanPct] [float] NULL,
	[priceScanDown] [float] NULL,
	[priceScanDownPct] [float] NULL,
	[volScanDown] [float] NULL,
	[volScanDownPct] [float] NULL,
	[quoteInOptTerms] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefInterTierRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefInterTierRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefInterTierRate](
	[BusFuncCcDefInterTierId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefInterTier]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefInterTier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefInterTier](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[tn] [nvarchar](1000) NULL,
	[sPe] [nvarchar](1000) NULL,
	[ePe] [nvarchar](1000) NULL,
	[tne] [nvarchar](1000) NULL,
	[tbn] [nvarchar](1000) NULL,
	[btn] [nvarchar](1000) NULL,
	[brk] [nvarchar](1000) NULL,
	[BusFuncCcDefInterTierId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefHvarSetIds]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefHvarSetIds]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefHvarSetIds](
	[hvarSetId] [int] NULL,
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefGroup]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefGroup](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[id] [nvarchar](1000) NULL,
	[aVal] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefFxHvarSetIds]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefFxHvarSetIds]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefFxHvarSetIds](
	[fxHvarSetId] [int] NULL,
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadVolRateRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadVolRateRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadVolRateRate](
	[BusFuncCcDefDSpreadVolRateId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadVolRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadVolRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadVolRate](
	[BusFuncCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[BusFuncCcDefDSpreadVolRateId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadTLegRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadTLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadTLegRate](
	[BusFuncCcDefDSpreadTLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadTLeg]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadTLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadTLeg](
	[BusFuncCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[tn] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncCcDefDSpreadTLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadRpLegRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadRpLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadRpLegRate](
	[BusFuncCcDefDSpreadRpLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadRpLeg]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadRpLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadRpLeg](
	[BusFuncCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[rpNum] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[btNum] [int] NULL,
	[etNum] [nvarchar](1000) NULL,
	[BusFuncCcDefDSpreadRpLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadRate](
	[BusFuncCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadPmpsRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadPmpsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadPmpsRate](
	[BusFuncCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL,
	[pmRate] [nvarchar](1000) NULL,
	[psRate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadPLegRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadPLegRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadPLegRate](
	[BusFuncCcDefDSpreadPLegId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpreadPLeg]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpreadPLeg]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpreadPLeg](
	[BusFuncCcDefDSpreadId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[pe] [nvarchar](1000) NULL,
	[rs] [nvarchar](1000) NULL,
	[i] [nvarchar](1000) NULL,
	[BusFuncCcDefDSpreadPLegId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefDSpread]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefDSpread]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefDSpread](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[spread] [nvarchar](1000) NULL,
	[spreadType] [nvarchar](1000) NULL,
	[chargeMeth] [nvarchar](1000) NULL,
	[BusFuncCcDefDSpreadId] int identity(1,1) primary key,
	[BusFuncCcDefDSpreadParentId] int null,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefConcAdjRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefConcAdjRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefConcAdjRate](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[val] [float] NULL,
	[loMarg] [float] NULL,
	[hiMarg] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefCdsRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefCdsRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefCdsRate](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[cdsSystematicShock] [float] NULL,
	[cdsSystematicShockPct] [float] NULL,
	[cdsSectorShock] [float] NULL,
	[cdsSectorShockPct] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefBasisRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefBasisRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefBasisRate](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDefAdjRate]    Script Date: 07/21/2015 15:00:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDefAdjRate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDefAdjRate](
	[BusFuncCcDefId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[r] [int] NULL,
	[baseR] [nvarchar](1000) NULL,
	[val] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFuncCcDef]    Script Date: 07/21/2015 15:00:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFuncCcDef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFuncCcDef](
	[BusFuncId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[cc] [nvarchar](1000) NULL,
	[concScaleUp] [float] NULL DEFAULT ((0)),
	[name] [nvarchar](1000) NULL,
	[BusFuncCcDefId] int identity(1,1) primary key,
	[currency] [nvarchar](1000) NULL,
	[riskExponent] [int] NULL,
	[contractSize] [nvarchar](1000) NULL,
	[uomQty] [nvarchar](1000) NULL,
	[uom] [nvarchar](1000) NULL,
	[capAnov] [bit] NULL,
	[procMeth] [nvarchar](1000) NULL,
	[wfprMeth] [nvarchar](1000) NULL,
	[spotMeth] [nvarchar](1000) NULL,
	[somMeth] [nvarchar](1000) NULL,
	[cmbMeth] [nvarchar](1000) NULL,
	[marginMeth] [nvarchar](1000) NULL,
	[custUseLov] [bit] NULL,
	[useLovPct] [nvarchar](1000) NULL,
	[vmClass] [nvarchar](1000) NULL,
	[isCDSScanRisk] [bit] NULL,
	[limitSubAccountOffset] [bit] NULL,
	[binaryArrays] [bit] NULL,
	[limitArraysTo16Points] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusFunc]    Script Date: 07/21/2015 15:00:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusFunc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusFunc](
	[pointInTimeId] int null,
	[MissingElements] [nvarchar](max) NULL,
	[busFuncType] [nvarchar](1000) NULL,
	[ec] [nvarchar](1000) NULL,
	[name] [nvarchar](1000) NULL,
	[isContractScale] [bit] NULL,
	[isNetMargin] [bit] NULL,
	[finalizeMeth] [nvarchar](1000) NULL,
	[oopDeltaMeth] [nvarchar](1000) NULL,
	[capAnov] [bit] NULL,
	[lookAheadYears] [nvarchar](1000) NULL,
	[lookAheadDays] [nvarchar](1000) NULL,
	[daysPerYear] [int] NULL,
	[custUseLov] [bit] NULL,
	[useLovPct] [nvarchar](1000) NULL,
	[limitSubAccountOffset] [bit] NULL,
	[capRiskArray] [nvarchar](1000) NULL,
	[BusFuncId] int identity(1,1) primary key,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
