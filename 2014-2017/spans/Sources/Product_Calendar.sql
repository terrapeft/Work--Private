use [spans];
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Calendar_Contract]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Calendar_Contract];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Calendar_Product]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Calendar_Product];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Calendar_ProductTypes]') AND type in (N'U')) 
BEGIN 
DROP TABLE [dbo].[Calendar_ProductTypes];
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Calendar_Created]') AND type in (N'U')) 
BEGIN 
CREATE TABLE [dbo].[Calendar_Created](
	[spanFile] [nvarchar](50) NULL,
	[created] [nvarchar](50) NULL,
	[lastUpdated] [datetime] default sysutcdatetime() NOT NULL
) ON [PRIMARY]
END
GO

CREATE TABLE [dbo].[Calendar_Contract] ( 
[Id] [int] identity(1, 1) NOT NULL,
[ProductId] [int] NOT NULL,
[Contract_Name] [nvarchar] (1024) NOT NULL,
[Contract_Product_Code] [nvarchar] (1024) NOT NULL,
[Exp_Contract_Code] [nvarchar] (1024) NOT NULL,
[ITC_Code] [nvarchar] (1024) NULL,
[Contract_Code] [nvarchar] (1024) NOT NULL,
[Option_Type] [nvarchar] (1024) NULL,
[FTD] [nvarchar] (1024) NOT NULL,
[LTD] [nvarchar] (1024) NOT NULL,
[SD] [nvarchar] (1024) NOT NULL,
[DD] [nvarchar] (1024) NOT NULL,
[IID] [nvarchar] (1024) NULL,
[FID] [nvarchar] (1024) NULL,
[FND] [nvarchar] (1024) NULL,
[FDD] [nvarchar] (1024) NULL,
[LPD] [nvarchar] (1024) NULL,
[LID] [nvarchar] (1024) NULL,
[LND] [nvarchar] (1024) NULL,
[LDD] [nvarchar] (1024) NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_Contract] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[Calendar_Product] ( 
[Id] [int] identity(1, 1) NOT NULL,
[ProductTypeId] [int] NOT NULL,
[Exchange] [nvarchar] (1024) NOT NULL,
[Commodity_Name] [nvarchar] (1024) NOT NULL,
[Commodity_Code] [nvarchar] (1024) NOT NULL,
[ProductTypeCode] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


CREATE TABLE [dbo].[Calendar_ProductTypes] ( 
[Id] [int] identity(1, 1) NOT NULL,
[ProductType] [nvarchar] (1024) NOT NULL,
[MissingElements] [xml] NULL
, CONSTRAINT [PK_ProductTypes] PRIMARY KEY CLUSTERED ([Id] ASC))
GO


ALTER TABLE [dbo].[Calendar_Product] WITH CHECK ADD CONSTRAINT [FK_ProductTypes_Product] FOREIGN KEY([ProductTypeId]) 
REFERENCES [dbo].[Calendar_ProductTypes] ([Id]) 
GO
ALTER TABLE [dbo].[Calendar_Contract] WITH CHECK ADD CONSTRAINT [FK_Product_Contract] FOREIGN KEY([ProductId]) 
REFERENCES [dbo].[Calendar_Product] ([Id]) 
GO


 -- !!!!!!!!!!!!!! Run this script manually for the Spans database.Data has been uploaded.