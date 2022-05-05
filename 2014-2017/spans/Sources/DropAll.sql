use [spans];
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PointDefScanPoint]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[PointDefScanPoint];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PointDefDeltaPoint]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[PointDefDeltaPoint];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BFPFLinkageMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[BFPFLinkageMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMAMasterRounding]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[XMAMasterRounding];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClearingOrgMasterRounding]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[ClearingOrgMasterRounding];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductFamilyMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[ProductFamilyMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PointDef]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[PointDef];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BFExchLinkageMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[BFExchLinkageMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BFCOLinkageMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[BFCOLinkageMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExchangeMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[ExchangeMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeltaPoint]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[DeltaPoint];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScanPoint]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[ScanPoint];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rounding]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Rounding];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AccountTypeMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[AccountTypeMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SegTypeMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[SegTypeMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CurrencyMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[CurrencyMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PBClassDefMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[PBClassDefMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClearingOrgMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[ClearingOrgMaster];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMAMaster]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[XMAMaster];
END
GO

use [spans];
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OofSpecsVenue]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OofSpecsVenue];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FwdSpecsVenue]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[FwdSpecsVenue];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FutSpecsVenue]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[FutSpecsVenue];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OofSpecs]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OofSpecs];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FwdSpecs]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[FwdSpecs];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FutSpecs]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[FutSpecs];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OofPf]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[OofPf];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FwdPf]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[FwdPf];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FutPf]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[FutPf];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Exchange]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Exchange];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Venue]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Venue];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClearingOrg]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[ClearingOrg];
END
GO

use [spans];
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Contract]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Contract];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Product];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductTypes]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[ProductTypes];
END
GO

use [spans];
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tier]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Tier];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TierProduct]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[TierProduct];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rates]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Rates];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginProduct]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginProduct];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BFCC]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[BFCC];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tiers]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Tiers];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VolSomRates]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[VolSomRates];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductFamily]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[ProductFamily];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Groups]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Groups];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BFCCProductFamily]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[BFCCProductFamily];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MarginProductProductFamily]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[MarginProductProductFamily];
END
GO