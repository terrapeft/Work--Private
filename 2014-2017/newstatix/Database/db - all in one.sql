USE [Statix]
GO

/****** Object:  User [IIS APPPOOL\Statix]    Script Date: 05/14/2015 17:08:28 ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'IIS APPPOOL\Statix')
CREATE USER [IIS APPPOOL\Statix] FOR LOGIN [IIS APPPOOL\Statix]
GO
/****** Object:  Schema [IIS APPPOOL\Statix]    Script Date: 05/14/2015 17:08:28 ******/
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'IIS APPPOOL\Statix')
EXEC sys.sp_executesql N'CREATE SCHEMA [IIS APPPOOL\Statix] AUTHORIZATION [IIS APPPOOL\Statix]'
GO

/****** Object:  User [IIS APPPOOL\TradeDataAppPool]    Script Date: 03/05/2015 16:52:18 ******/
IF NOT EXISTS 
    (SELECT name  
     FROM master.sys.server_principals
     WHERE name = 'IIS APPPOOL\Statix')
BEGIN
    CREATE LOGIN [IIS APPPOOL\StatixAppPool] FROM WINDOWS;
END
GO

EXEC sp_addrolemember N'db_owner', N'IIS APPPOOL\Statix'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Resources]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].[Resources];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceConfiguration]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].[ServiceConfiguration];
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResourceType]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].[ResourceType];
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Audits]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].[Audits];
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Actions]') AND type in (N'U'))
BEGIN
drop TABLE [Statix].[dbo].[Actions];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteIPAddress]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].SiteIPAddress;
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteReferrer]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].SiteReferrer;
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserIPAddress]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].UserIPAddress;
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sites]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].[Sites];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Referrers]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].Referrers;
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IPAddresses]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].IPAddresses;
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Countries]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].Countries;
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].[Users];
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRoles]') AND type in (N'U'))
BEGIN
DROP TABLE [Statix].[dbo].[UserRoles];
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FilteredContractTypes]') AND type in (N'U'))
DROP TABLE [dbo].[FilteredContractTypes]
GO


/****** Object:  Table [dbo].[ELMAH_Error]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_Error]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ELMAH_Error](
	[ErrorId] [uniqueidentifier] NOT NULL,
	[Application] [nvarchar](60) NOT NULL,
	[Host] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](250) NOT NULL,
	[Source] [nvarchar](60) NOT NULL,
	[Message] [nvarchar](500) NOT NULL,
	[User] [nvarchar](50) NOT NULL,
	[StatusCode] [int] NOT NULL,
	[TimeUtc] [datetime] NOT NULL,
	[Sequence] [int] IDENTITY(1,1) NOT NULL,
	[AllXml] [ntext] NOT NULL,
 CONSTRAINT [PK_ELMAH_Error] PRIMARY KEY NONCLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_Error]') AND name = N'IX_ELMAH_Error_App_Time_Seq')
CREATE NONCLUSTERED INDEX [IX_ELMAH_Error_App_Time_Seq] ON [dbo].[ELMAH_Error] 
(
	[Application] ASC,
	[TimeUtc] DESC,
	[Sequence] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  UserDefinedTableType [dbo].[DeletedIDs]    Script Date: 05/14/2015 17:08:28 ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'DeletedIDs' AND ss.name = N'dbo')
CREATE TYPE [dbo].[DeletedIDs] AS TABLE(
	[Id] [nvarchar](36) NULL
)
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Countries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[Code] [nvarchar](2) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__Countrie__3214EC072645B050] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Countries] ON
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (1, N'Afghanistan', N'AF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (2, N'Albania', N'AL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (3, N'Algeria', N'DZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (4, N'American Samoa', N'AS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (5, N'Andorra', N'AD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (6, N'Angola', N'AO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (7, N'Anguilla', N'AI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (8, N'Antarctica', N'AQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (9, N'Antigua and Barbuda', N'AG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (10, N'Argentina', N'AR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (11, N'Armenia', N'AM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (12, N'Aruba', N'AW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (13, N'Australia', N'AU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (14, N'Austria', N'AT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (15, N'Azerbaijan', N'AZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (16, N'Bahamas', N'BS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (17, N'Bahrain', N'BH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (18, N'Bangladesh', N'BD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (19, N'Barbados', N'BB', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (20, N'Belarus', N'BY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (21, N'Belgium', N'BE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (22, N'Belize', N'BZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (23, N'Benin', N'BJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (24, N'Bermuda', N'BM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (25, N'Bhutan', N'BT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (26, N'Bolivia', N'BO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (27, N'Bosnia and Herzegovina', N'BA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (28, N'Botswana', N'BW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (29, N'Bouvet Island', N'BV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (30, N'Brazil', N'BR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (31, N'British Antarctic Territory', N'BQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (32, N'British Indian Ocean Territory', N'IO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (33, N'British Virgin Islands', N'VG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (34, N'Brunei', N'BN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (35, N'Bulgaria', N'BG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (36, N'Burkina Faso', N'BF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (37, N'Burundi', N'BI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (38, N'Cambodia', N'KH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (39, N'Cameroon', N'CM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (40, N'Canada', N'CA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (41, N'Canton and Enderbury Islands', N'CT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (42, N'Cape Verde', N'CV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (43, N'Cayman Islands', N'KY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (44, N'Central African Republic', N'CF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (45, N'Chad', N'TD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (46, N'Chile', N'CL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (47, N'China', N'CN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (48, N'Christmas Island', N'CX', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (49, N'Cocos [Keeling] Islands', N'CC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (50, N'Colombia', N'CO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (51, N'Comoros', N'KM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (52, N'Congo - Brazzaville', N'CG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (53, N'Congo - Kinshasa', N'CD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (54, N'Cook Islands', N'CK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (55, N'Costa Rica', N'CR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (56, N'Croatia', N'HR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (57, N'Cuba', N'CU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (58, N'Cyprus', N'CY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (59, N'Czech Republic', N'CZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (60, N'Cote d’Ivoire', N'CI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (61, N'Denmark', N'DK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (62, N'Djibouti', N'DJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (63, N'Dominica', N'DM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (64, N'Dominican Republic', N'DO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (65, N'Dronning Maud Land', N'NQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (66, N'East Germany', N'DD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (67, N'Ecuador', N'EC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (68, N'Egypt', N'EG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (69, N'El Salvador', N'SV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (70, N'Equatorial Guinea', N'GQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (71, N'Eritrea', N'ER', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (72, N'Estonia', N'EE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (73, N'Ethiopia', N'ET', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (74, N'Falkland Islands', N'FK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (75, N'Faroe Islands', N'FO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (76, N'Fiji', N'FJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (77, N'Finland', N'FI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (78, N'France', N'FR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (79, N'French Guiana', N'GF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (80, N'French Polynesia', N'PF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (81, N'French Southern Territories', N'TF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (82, N'French Southern and Antarctic Territories', N'FQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (83, N'Gabon', N'GA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (84, N'Gambia', N'GM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (85, N'Georgia', N'GE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (86, N'Germany', N'DE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (87, N'Ghana', N'GH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (88, N'Gibraltar', N'GI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (89, N'Greece', N'GR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (90, N'Greenland', N'GL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (91, N'Grenada', N'GD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (92, N'Guadeloupe', N'GP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (93, N'Guam', N'GU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (94, N'Guatemala', N'GT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (95, N'Guernsey', N'GG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (96, N'Guinea', N'GN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (97, N'Guinea-Bissau', N'GW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (98, N'Guyana', N'GY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (99, N'Haiti', N'HT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (100, N'Heard Island and McDonald Islands', N'HM', 0)
GO
print 'Processed 100 total records'
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (101, N'Honduras', N'HN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (102, N'Hong Kong SAR China', N'HK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (103, N'Hungary', N'HU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (104, N'Iceland', N'IS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (105, N'India', N'IN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (106, N'Indonesia', N'ID', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (107, N'Iran', N'IR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (108, N'Iraq', N'IQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (109, N'Ireland', N'IE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (110, N'Isle of Man', N'IM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (111, N'Israel', N'IL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (112, N'Italy', N'IT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (113, N'Jamaica', N'JM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (114, N'Japan', N'JP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (115, N'Jersey', N'JE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (116, N'Johnston Island', N'JT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (117, N'Jordan', N'JO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (118, N'Kazakhstan', N'KZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (119, N'Kenya', N'KE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (120, N'Kiribati', N'KI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (121, N'Kuwait', N'KW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (122, N'Kyrgyzstan', N'KG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (123, N'Laos', N'LA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (124, N'Latvia', N'LV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (125, N'Lebanon', N'LB', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (126, N'Lesotho', N'LS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (127, N'Liberia', N'LR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (128, N'Libya', N'LY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (129, N'Liechtenstein', N'LI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (130, N'Lithuania', N'LT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (131, N'Luxembourg', N'LU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (132, N'Macau SAR China', N'MO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (133, N'Macedonia', N'MK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (134, N'Madagascar', N'MG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (135, N'Malawi', N'MW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (136, N'Malaysia', N'MY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (137, N'Maldives', N'MV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (138, N'Mali', N'ML', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (139, N'Malta', N'MT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (140, N'Marshall Islands', N'MH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (141, N'Martinique', N'MQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (142, N'Mauritania', N'MR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (143, N'Mauritius', N'MU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (144, N'Mayotte', N'YT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (145, N'Metropolitan France', N'FX', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (146, N'Mexico', N'MX', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (147, N'Micronesia', N'FM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (148, N'Midway Islands', N'MI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (149, N'Moldova', N'MD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (150, N'Monaco', N'MC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (151, N'Mongolia', N'MN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (152, N'Montenegro', N'ME', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (153, N'Montserrat', N'MS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (154, N'Morocco', N'MA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (155, N'Mozambique', N'MZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (156, N'Myanmar [Burma]', N'MM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (157, N'Namibia', N'NA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (158, N'Nauru', N'NR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (159, N'Nepal', N'NP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (160, N'Netherlands', N'NL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (161, N'Netherlands Antilles', N'AN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (162, N'Neutral Zone', N'NT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (163, N'New Caledonia', N'NC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (164, N'New Zealand', N'NZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (165, N'Nicaragua', N'NI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (166, N'Niger', N'NE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (167, N'Nigeria', N'NG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (168, N'Niue', N'NU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (169, N'Norfolk Island', N'NF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (170, N'North Korea', N'KP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (171, N'North Vietnam', N'VD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (172, N'Northern Mariana Islands', N'MP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (173, N'Norway', N'NO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (174, N'Oman', N'OM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (175, N'Pacific Islands Trust Territory', N'PC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (176, N'Pakistan', N'PK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (177, N'Palau', N'PW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (178, N'Palestinian Territories', N'PS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (179, N'Panama', N'PA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (180, N'Panama Canal Zone', N'PZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (181, N'Papua New Guinea', N'PG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (182, N'Paraguay', N'PY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (183, N'People''s Democratic Republic of Yemen', N'YD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (184, N'Peru', N'PE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (185, N'Philippines', N'PH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (186, N'Pitcairn Islands', N'PN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (187, N'Poland', N'PL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (188, N'Portugal', N'PT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (189, N'Puerto Rico', N'PR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (190, N'Qatar', N'QA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (191, N'Romania', N'RO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (192, N'Russia', N'RU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (193, N'Rwanda', N'RW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (194, N'Reunion', N'RE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (195, N'Saint Barthelemy', N'BL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (196, N'Saint Helena', N'SH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (197, N'Saint Kitts and Nevis', N'KN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (198, N'Saint Lucia', N'LC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (199, N'Saint Martin', N'MF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (200, N'Saint Pierre and Miquelon', N'PM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (201, N'Saint Vincent and the Grenadines', N'VC', 0)
GO
print 'Processed 200 total records'
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (202, N'Samoa', N'WS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (203, N'San Marino', N'SM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (204, N'Saudi Arabia', N'SA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (205, N'Senegal', N'SN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (206, N'Serbia', N'RS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (207, N'Serbia and Montenegro', N'CS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (208, N'Seychelles', N'SC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (209, N'Sierra Leone', N'SL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (210, N'Singapore', N'SG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (211, N'Slovakia', N'SK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (212, N'Slovenia', N'SI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (213, N'Solomon Islands', N'SB', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (214, N'Somalia', N'SO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (215, N'South Africa', N'ZA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (216, N'South Georgia and the South Sandwich Islands', N'GS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (217, N'South Korea', N'KR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (218, N'Spain', N'ES', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (219, N'Sri Lanka', N'LK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (220, N'Sudan', N'SD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (221, N'Suriname', N'SR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (222, N'Svalbard and Jan Mayen', N'SJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (223, N'Swaziland', N'SZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (224, N'Sweden', N'SE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (225, N'Switzerland', N'CH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (226, N'Syria', N'SY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (227, N'Sao Tome and Principe', N'ST', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (228, N'Taiwan', N'TW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (229, N'Tajikistan', N'TJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (230, N'Tanzania', N'TZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (231, N'Thailand', N'TH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (232, N'Timor-Leste', N'TL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (233, N'Togo', N'TG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (234, N'Tokelau', N'TK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (235, N'Tonga', N'TO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (236, N'Trinidad and Tobago', N'TT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (237, N'Tunisia', N'TN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (238, N'Turkey', N'TR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (239, N'Turkmenistan', N'TM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (240, N'Turks and Caicos Islands', N'TC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (241, N'Tuvalu', N'TV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (242, N'U.S. Minor Outlying Islands', N'UM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (243, N'U.S. Miscellaneous Pacific Islands', N'PU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (244, N'U.S. Virgin Islands', N'VI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (245, N'Uganda', N'UG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (246, N'Ukraine', N'UA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (247, N'Union of Soviet Socialist Republics', N'SU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (248, N'United Arab Emirates', N'AE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (249, N'United Kingdom', N'GB', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (250, N'United States', N'US', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (251, N'Unknown or Invalid Region', N'ZZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (252, N'Uruguay', N'UY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (253, N'Uzbekistan', N'UZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (254, N'Vanuatu', N'VU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (255, N'Vatican City', N'VA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (256, N'Venezuela', N'VE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (257, N'Vietnam', N'VN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (258, N'Wake Island', N'WK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (259, N'Wallis and Futuna', N'WF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (260, N'Western Sahara', N'EH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (261, N'Yemen', N'YE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (262, N'Zambia', N'ZM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (263, N'Zimbabwe', N'ZW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (264, N'Aland Islands', N'AX', 0)
SET IDENTITY_INSERT [dbo].[Countries] OFF
/****** Object:  StoredProcedure [dbo].[ELMAH_LogError]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_LogError]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ELMAH_LogError]
(
    @ErrorId UNIQUEIDENTIFIER,
    @Application NVARCHAR(60),
    @Host NVARCHAR(30),
    @Type NVARCHAR(100),
    @Source NVARCHAR(60),
    @Message NVARCHAR(500),
    @User NVARCHAR(50),
    @AllXml NTEXT,
    @StatusCode INT,
    @TimeUtc DATETIME
)
AS

    SET NOCOUNT ON

    INSERT
    INTO
        [ELMAH_Error]
        (
            [ErrorId],
            [Application],
            [Host],
            [Type],
            [Source],
            [Message],
            [User],
            [AllXml],
            [StatusCode],
            [TimeUtc]
        )
    VALUES
        (
            @ErrorId,
            @Application,
            @Host,
            @Type,
            @Source,
            @Message,
            @User,
            @AllXml,
            @StatusCode,
            @TimeUtc
        )

' 
END
GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorXml]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_GetErrorXml]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ELMAH_GetErrorXml]
(
    @Application NVARCHAR(60),
    @ErrorId UNIQUEIDENTIFIER
)
AS

    SET NOCOUNT ON

    SELECT 
        [AllXml]
    FROM 
        [ELMAH_Error]
    WHERE
        [ErrorId] = @ErrorId
    AND
        [Application] = @Application

' 
END
GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorsXml]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_GetErrorsXml]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ELMAH_GetErrorsXml]
(
    @Application NVARCHAR(60),
    @ExceptionType NVARCHAR(100) = NULL,
    @IncludeExceptionByType BIT = 1,
    @PageIndex INT = 0,
    @PageSize INT = 15,
    @TotalCount INT OUTPUT
)
AS 

    SET NOCOUNT ON

    DECLARE @FirstTimeUTC DATETIME
    DECLARE @FirstSequence INT
    DECLARE @StartRow INT
    DECLARE @StartRowIndex INT
	
	DECLARE @showException BIT = 0, @hideException BIT = 0, @goFurther BIT = 0
	
	IF (@ExceptionType IS NOT NULL AND @ExceptionType <> '''') AND @IncludeExceptionByType = 1
	BEGIN
		SET @showException = 1;
		SET @hideException = 0;
	END
	ELSE IF (@ExceptionType IS NOT NULL AND @ExceptionType <> '''') AND @IncludeExceptionByType = 0
	BEGIN
		SET @showException = 0;
		SET @hideException = 1;
	END

	IF @showException <> 0 OR @hideException <> 0
		SET @goFurther = 1;

    SELECT 
        @TotalCount = COUNT(1) 
    FROM 
        [ELMAH_Error]
    WHERE 
        [Application] = @Application
        AND (@goFurther = 0 OR ((@showException = 1 AND [Type] LIKE @ExceptionType + ''%'') OR (@hideException = 1 AND [Type] NOT LIKE @ExceptionType + ''%'')))

    -- Get the ID of the first error for the requested page

    SET @StartRowIndex = @PageIndex * @PageSize + 1

    IF @StartRowIndex <= @TotalCount
    BEGIN

        SET ROWCOUNT @StartRowIndex

        SELECT  
            @FirstTimeUTC = [TimeUtc],
            @FirstSequence = [Sequence]
        FROM 
            [ELMAH_Error]
        WHERE   
            [Application] = @Application
		AND 
			(@goFurther = 0 OR ((@showException = 1 AND [Type] LIKE @ExceptionType + ''%'') OR (@hideException = 1 AND [Type] NOT LIKE @ExceptionType + ''%'')))
        ORDER BY 
            [TimeUtc] DESC, 
            [Sequence] DESC

    END
    ELSE
    BEGIN

        SET @PageSize = 0

    END

    -- Now set the row count to the requested page size and get
    -- all records below it for the pertaining application.

    SET ROWCOUNT @PageSize

    SELECT 
        errorId     = [ErrorId], 
        application = [Application],
        host        = [Host], 
        type        = [Type],
        source      = [Source],
        message     = [Message],
        [user]      = [User],
        statusCode  = [StatusCode], 
        time        = CONVERT(VARCHAR(50), [TimeUtc], 126) + ''Z''
    FROM 
        [ELMAH_Error] error
    WHERE
        [Application] = @Application
	AND 
		(@goFurther = 0 OR ((@showException = 1 AND [Type] LIKE @ExceptionType + ''%'') OR (@hideException = 1 AND [Type] NOT LIKE @ExceptionType + ''%'')))
    AND
        [TimeUtc] <= @FirstTimeUTC
    AND 
        [Sequence] <= @FirstSequence
    ORDER BY
        [TimeUtc] DESC, 
        [Sequence] DESC
    FOR
        XML AUTO

' 
END
GO
/****** Object:  StoredProcedure [dbo].[spInsteadOfDeleteTrigger]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spInsteadOfDeleteTrigger]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/****** Object:  StoredProcedure [dbo].[spInsteadOfDeleteTrigger]    Script Date: 05/05/2015 17:22:00 ******/
CREATE procedure [dbo].[spInsteadOfDeleteTrigger] (@ids DeletedIDs readonly, @tableName nvarchar(128))
as
declare @sql nvarchar(max)

begin
	set @sql = ''update '' + @tableName + '' set IsDeleted = 1 where Id in ('';
	
	-- concatenate ids of deleted entities
	select @sql += left(Id, len(Id) - 1)
		from (
			select '''''''' + cast(Id as nvarchar(10)) + '''''', ''
			from @ids
			for xml path ('''')
		  ) c (Id)
	set @sql += '')''
		    
	exec sp_executesql @sql;
end
' 
END
GO
/****** Object:  Table [dbo].[Sites]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sites]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Sites](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Sites] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Sites] ON
INSERT [dbo].[Sites] ([Id], [Name], [IsDeleted]) VALUES (1, N'General', 0)
INSERT [dbo].[Sites] ([Id], [Name], [IsDeleted]) VALUES (2, N'BNP Paribas', 0)
INSERT [dbo].[Sites] ([Id], [Name], [IsDeleted]) VALUES (3, N'Newedge', 0)
SET IDENTITY_INSERT [dbo].[Sites] OFF
/****** Object:  Table [dbo].[UserRoles]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](15) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON
INSERT [dbo].[UserRoles] ([Id], [Name], [IsDeleted]) VALUES (1, N'Admin', 0)
INSERT [dbo].[UserRoles] ([Id], [Name], [IsDeleted]) VALUES (2, N'User', 0)
INSERT [dbo].[UserRoles] ([Id], [Name], [IsDeleted]) VALUES (3, N'ResourceEditor', 0)
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
/****** Object:  Table [dbo].[Referrers]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Referrers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Referrers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Referrer] [nvarchar](1024) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Referrers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Referrers] ON
INSERT [dbo].[Referrers] ([Id], [Referrer], [IsDeleted]) VALUES (1, N'bp2s', 1)
INSERT [dbo].[Referrers] ([Id], [Referrer], [IsDeleted]) VALUES (2, N'bnpparibas.com', 0)
INSERT [dbo].[Referrers] ([Id], [Referrer], [IsDeleted]) VALUES (3, N'is.echonet', 0)
SET IDENTITY_INSERT [dbo].[Referrers] OFF
/****** Object:  Table [dbo].[IPAddresses]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IPAddresses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IPAddresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IPAddress] [nvarchar](45) NOT NULL,
	[IsAllowed] [bit] NOT NULL,
	[IsAdminIp] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[GeoLocationCountryId] [int] NULL,
 CONSTRAINT [PK_IPAddresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_IPAddresses] UNIQUE NONCLUSTERED 
(
	[IPAddress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[IPAddresses] ON
INSERT [dbo].[IPAddresses] ([Id], [IPAddress], [IsAllowed], [IsAdminIp], [IsDeleted], [GeoLocationCountryId]) VALUES (1, N'127.0.0.1', 1, 1, 0, NULL)
INSERT [dbo].[IPAddresses] ([Id], [IPAddress], [IsAllowed], [IsAdminIp], [IsDeleted], [GeoLocationCountryId]) VALUES (2, N'212.119.177.5', 1, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[IPAddresses] OFF
/****** Object:  Table [dbo].[Actions]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Actions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Actions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_AuditActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_AuditActions_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Actions] ON
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (1, N'Create', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (2, N'Update', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (3, N'Delete', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (4, N'Log in', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (5, N'Concurrent log off', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (6, N'Forbidden IP Address', 0)
SET IDENTITY_INSERT [dbo].[Actions] OFF
/****** Object:  Table [dbo].[ResourceType]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResourceType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ResourceType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ResourceType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_ResourceType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[ResourceType] ON
INSERT [dbo].[ResourceType] ([Id], [Name], [Description], [IsDeleted]) VALUES (1, N'String', NULL, 0)
INSERT [dbo].[ResourceType] ([Id], [Name], [Description], [IsDeleted]) VALUES (2, N'Int', NULL, 0)
INSERT [dbo].[ResourceType] ([Id], [Name], [Description], [IsDeleted]) VALUES (3, N'String List', N'Content is splitted by a number of delimiters: new line, comma, whitespace, tab', 0)
INSERT [dbo].[ResourceType] ([Id], [Name], [Description], [IsDeleted]) VALUES (4, N'Integer List', N'Same as for String List but value is converted to integer', 0)
INSERT [dbo].[ResourceType] ([Id], [Name], [Description], [IsDeleted]) VALUES (5, N'Boolean', NULL, 0)
INSERT [dbo].[ResourceType] ([Id], [Name], [Description], [IsDeleted]) VALUES (6, N'String Strict List', N'Unlike the String List, the new line is the only delimiter here.', 0)
SET IDENTITY_INSERT [dbo].[ResourceType] OFF
/****** Object:  Table [dbo].[Resources]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Resources]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Resources](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Value] [nvarchar](max) NULL,
	[Description] [nvarchar](1500) NULL,
	[IsDeleted] [bit] NOT NULL,
	[ResourceTypeId] [int] NOT NULL,
	[GroupName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Resources] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_Resources_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Resources] ON
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (1, N'Dataset Is Null Or Empty', N'Data set is null or contains no tables.', N'When user requests some data from the service and returned DataSet has no tables, this message will occur. In current implementation most likely this message won''t ever occur.', 0, 1, N'API Response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (2, N'Dataset No Tables', N'No results.', N'When ther? are no results to return for user''s request, this message is provided.', 0, 1, N'API Response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (3, N'Email Account Locked Body', N'Your account has been locked because the number of consecutive log-in failures exceeded the maximum allowed.', N'Notification email body.', 0, 1, N'User lock notification')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (4, N'Email Account Locked Subject', N'Your TradeData account has been locked.', N'Notification email subject.', 0, 1, N'User lock notification')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (5, N'Error 401 No Credentials', N'Username and password are required, please specify "u" and "p" parameters.', N'User may see this message in response for his request.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (6, N'Error 403 Restricted IP', N'Your IP address is not recognized.', N'Occurs when clients IP is not in allowed list.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (7, N'Error 500', N'An internal server error occurred, please contact administrator.', N'When some fault is occured in the service, this message will be sent to the client. Usage Stats will contain some information about the error and Error log will contain technical details.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (8, N'Error 401 Incorrect Credentials', N'Wrong username or password.', NULL, 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (9, N'Unique Constraint Violation Error', N'Value already exists in database. Note that it could be a deleted record.', N'Occurs in Admin UI on attempt to save a duplicate, like username.', 0, 1, N'Admin UI')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (10, N'Error 400 No Keyword', N'Search keyword was not specified.', N'Search keyword was not specified for Search request.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (11, N'Restricted Content Type', N'The file you''ve tried to upload is not allowed.
The supported content type is: {0}.', N'Error message displayed when the banner is uploaded of type other then PNG.

Placeholder stands for allowed content type, which is taken from the Service Configuration table, the Allowed Content Type parameter.', 0, 1, N'Upload')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (12, N'Link Is Not Available', N'n/a', N'For example the Exchanges page, the Memeber column, if there is no link, this value is used.', 0, 1, N'General')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (13, N'Name Field Empty', N'<li>Name field is empty</li>', NULL, 0, 1, N'Registration Form Validation')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (14, N'Email Field Empty', N'<li>Email field is empty</li>', NULL, 0, 1, N'Registration Form Validation')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (15, N'Invalid Email', N'<li>Email is not valid</li>', NULL, 0, 1, N'Registration Form Validation')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (16, N'Reg Email Recipient', N'vitaly.chupaev@arcadia.spb.ru', NULL, 0, 1, N'Registration Email')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (17, N'Reg Email Subject', N'Registration request: {0}, {1}.', N'{0} stands for user name,
{1} stands for email', 0, 1, N'Registration Email')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (18, N'Reg Email Body', N'Automatic email, please do not reply.

User {0}, {1}, has asked for an account.', N'{0} stands for user name,
{1} stands for email', 0, 1, N'Registration Email')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (19, N'Reg Email Sender', N'noreply@fowtradedata.com', NULL, 0, 1, N'Registration Email')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (20, N'Reg Email Confirmation Message', N'<br>
Your request has been sent.
Our Account Manager will contact you as soon as possible.
<br>
<br>
You can also contact your Account Manager by email <a href="mailto:sales@fowtradedata.com">sales@fowtradedata.com</a> or call us on  +44 (0)1277 633777&nbsp;<br>
<br>
<br>', N'Message is shown on the page after user has submitted his data.', 0, 1, N'Registration Email')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (21, N'Reg Email Error Message', N'<br>
While sending your requests an error has ocurred:<br><b>
{0}</b>
<br>
<br>
You can contact your Account Manager by email <a href="mailto:sales@fowtradedata.com">sales@fowtradedata.com</a> or call us on  +44 (0)1277 633777&nbsp;<br>
<br>
<br>', N'{0} stands for error message', 0, 1, N'Registration Email')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (22, N'Stub Cookie', N' <h2>COOKIES </h2>
        <p>
            This page explains what cookies are, how we use them on the websites of the Euromoney Institutional Investor PLC group and your options for controlling    them.   
                <br>
            <br>
            Please note:
        </p>
        <p>Not all the cookies listed here will necessarily be used on each website</p>
        <p>We will display our triangular red cookie prompt once when you visit each of our sites</p>
        <p>If you send us a request in relation to activity logging on our websites as explained in the table below, this will apply to your use of all our sites so    you only need to make one request.</p>
        <p><b>What are cookies? </b></p>
        <p>Cookies are pieces of information which include a unique reference code that a website transfers to your device to store and sometimes track information    about you. A number of cookies we use last only for the duration of your web session (“session cookies”) and expire when you close your browser. Other    cookies are used, for example, to remember you when you return to the site and will last for longer (“persistent cookies”). Cookies cannot be used to run    programs or deliver viruses to your computer. They are uniquely assigned to your device and are sent back to the originating website on each subsequent    visit (if they last longer than a web session) or to another website that recognises that cookie.</p>
        <p>Some of the cookies used by our sites are set by us, and some are set by third parties who are delivering services (such as interest based advertising and    web analytics) on our behalf.</p>
        <p><b>What do we use cookies for? </b></p>
        <p>
            Some cookies are essential to enable you to move around the website and use its features, such as accessing secure areas of the website or areas with    paid-for content. Without these cookies, services you have asked for, like shopping baskets, cannot be provided. Because such cookies are essential for    using a site, these cookies cannot be turned off without severely affecting your use of the website.   
                <br>
            <br>
            Other cookies perform various functions, as the table below explains, together with your options for controlling them.
        </p>
        <p>Some cookies may also be controlled by using your web browser settings. Most web browsers automatically accept cookies but, if you prefer, you can change    your browser to prevent that or to notify you each time a cookie is set.</p>
        <p>You can also learn more about cookies in general by visiting    <a href="http://www.allaboutcookies.org/" target="_blank"><b>www.allaboutcookies.org </b></a>which includes additional useful information on    cookies and how to block cookies using different types of browser.</p>
        <p>For more general information about online behavioural (interest based) advertising and how it uses cookies, you may wish to visit    <a href="http://www.youronlinechoices.com/"><b>www.youronlinechoices.com</b></a></p>
        <p><b>Our cookies and your options: </b></p>
        <table style="border: 1px solid rgb(0, 0, 0); font-size: 10px;" border="1" cellspacing="2" cellpadding="3" width="100%">
            <tbody>
                <tr>
                    <td width="179" valign="top">
                        <br>
                        Type of    cookie </td>
                    <td width="186" valign="top">
                        <p>Example </p>
                    </td>
                    <td width="179" valign="top">
                        <p>What it    does </p>
                    </td>
                    <td width="226" valign="top">
                        <p>Your    options </p>
                    </td>
                </tr>
                <tr>
                    <td width="179" valign="top">
                        <p>Performance </p>
                    </td>
                    <td width="186" valign="top">
                        <p>
                            BIGipServereuro
                                <br>
                            <br>
                            moneyfxnews-pool
                        </p>
                    </td>
                    <td width="179" valign="top">
                        <p>These    cookies allow us to manage the technical performance of the website such as    load balancing to ensure that the site is available to all users </p>
                    </td>
                    <td width="226" valign="top">
                        <p>You may    set your browser to reject these cookies but this is likely to affect your    use of the site </p>
                    </td>
                </tr>
                <tr>
                    <td width="179" valign="top">
                        <p>Functionality </p>
                    </td>
                    <td width="186" valign="top">
                        <p>ISDefaultCurrency </p>
                    </td>
                    <td width="179" valign="top">
                        <p>These    cookies remember choices you make to improve your experience. For example,    they allow the website to remember selections such as language, currency,    region or changes to text size and to remember you on return visits. They may    also be used, for example, to remember the point you have reached in a survey    so that you can return to it later. </p>
                    </td>
                    <td width="226" valign="top">
                        <p>
                            By    choosing an option such as remember me, text size or participating in a    survey or similar services that necessitate the use of a cookie, you will be    indicating your consent to that cookie.
                                <br>
                            You may set your browser to reject these cookies but this is likely to affect    your use of the site.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td width="179" valign="top">
                        <p>Activity    logging - websites </p>
                    </td>
                    <td width="186" valign="top">
                        <p>ASP.NET_sessionId </p>
                    </td>
                    <td width="179" valign="top">
                        <p>
                            This    cookie is essential to authorise your access to content and services that are    not publicly available including paid-for content.
                                <br>
                            <br>
                            If you are a registered user, trialist or subscriber, when you log on, this    places a cookie on your machine.
                                <br>
                            <br>
                            Once you are logged on, we use this cookie to monitor your activity on our    websites, for example, which articles you read. This is for the following    purposes:
                                <br>
                            We    need to ensure compliance with your user license and adherence to our terms    and conditions as part of your trial or subscription. (Our terms and    conditions are published on our websites and can be accessed by a link in the    footer of each page)
                                <br>
                            For    customer service purposes to provide users with a tailored service and to    develop products and services reflecting our users’ needs
                        </p>
                    </td>
                    <td width="226" valign="top">
                        <p>
                            If you    would prefer us not to use your activity log for customer service purposes,    you can request that we anonymise it for these uses. This will affect our    ability to understand your requirements and personalise your browsing    experience in the future.
                                <br>
                            <br>
                            <br>
                            To request anonymisation please email us at <a href="mailto:cookies@euromoneyplc.com?subject=cookie%20tracking&amp;body=email%20address%20(you%20use%20to%20log%20in):%20%0AFirst%20name:%20%0AFamily%20name:%20%0ACompany:%20%0ASite/Product:%20">cookies@euromoneyplc.com </a>
                            <br>
                            <br>
                            Please include the following details:
                                <br>
                            Your    user name that you use to access our website(s) – this will be an email    address
                                <br>
                            Your    name
                                <br>
                            Your    company name
                                <br>
                            The    Euromoney website(s) you use
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
        <p>Third  party cookies: </p>
        <table style="border: 1px solid rgb(0, 0, 0); font-size: 10px;" border="1" cellspacing="2" cellpadding="3" width="100%">
            <tbody>
                <tr>
                    <td width="198" valign="top">
                        <br>
                        Third    party </td>
                    <td width="189" valign="top">
                        <p>What it    does </p>
                    </td>
                    <td width="384" valign="top">
                        <p>Where    to go for further information on these cookies including turning them off </p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>AdSense </p>
                    </td>
                    <td width="189" valign="top">
                        <p>Google    AdSense is a program run by Google that allows publishers in the Google    Network of content sites to serve automatic text, image, video, or    interactive media advertisements that are targeted to site content and    audience. </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="http://www.google.com/settings/ads">http://www.google.com/settings/ads</a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>ClickTale </p>
                    </td>
                    <td width="189" valign="top">
                        <p>
                            ClickTale    is a web analytics service. Records of individual browsing sessions are    translated into information that helps website designers
                                <br>
                            make    websites easier to use and simpler to navigate.
                        </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="http://www.clicktale.net/disable.html">http://www.clicktale.net/disable.html</a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>ComScore </p>
                    </td>
                    <td width="189" valign="top">
                        <p>ComScore    is a web market research, analytics and measurement provider.    ScorecardResearch conducts research by collecting Internet web browsing data    and then uses that data to help show how people use the Internet, what they    like about it, and what they don’t. Surveys and web tags used do not collect    personal information. </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="http://www.scorecardresearch.com/privacy.aspx">http://www.scorecardresearch.com/privacy.aspx</a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>DoubleClick    / DFP (Double-Click for Publishers)/DART </p>
                    </td>
                    <td width="189" valign="top">
                        <p>DoubleClick    is a service provided by Google. Its cookies are used to serve advertising    relevant to users’ interests and measure the effectiveness of online    marketing campaigns for our sites. </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="http://www.google.com/policies/privacy/ads/" target="_blank">http://www.google.com/policies/privacy/ads/ </a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>Google    Adwords </p>
                    </td>
                    <td width="189" valign="top">
                        <p>Displays    advertisements prompted by search terms entered into the Google search box.    We use Google Adwords to display advertisements about our products and    services. </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="https://support.google.com/ads/answer/2662922?hl=en">https://support.google.com/ads/answer/2662922?hl=en</a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>Google    Analytics </p>
                    </td>
                    <td width="189" valign="top">
                        <p>
                            Google    Analytics is a web analytics tool that helps us to understand how our users    engage with our websites and so allows us to better tailor our websites to    our users’ needs.
                                <br>
                            <br>
                            The tool uses a cookie in order to evaluate use of content and compile    reports for us on activity on our websites and Apps.
                        </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="https://tools.google.com/dlpage/gaoptout" target="_blank">https://tools.google.com/dlpage/gaoptout </a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>Google    Analytics – Advertiser Features </p>
                    </td>
                    <td width="189" valign="top">
                        <p>
                            Some of    our sites may use these Features including Demographics and Interest Reports.<br>
                            Where    these Features are enabled, Google Analytics will collect data about our website    traffic via <a href="https://www.google.com/policies/privacy/key-terms/#toc-terms-cookie" target="_blank">Google advertising cookies</a> and <a href="https://www.google.com/policies/privacy/key-terms/#toc-terms-identifier" target="_blank">anonymous identifiers</a>*, in    addition to data collected through the standard Google Analytics    implementation.<br>
                            The    Demographics and Interest Reports will not contain personally identifiable    data but they may pull in browsing data from these additional sources.<br>
                            (*An anonymous identifier is a    random string of characters that is used for the same purposes as a cookie on    platforms, including certain mobile devices, where cookie technology is not    available.)
                        </p>
                    </td>
                    <td width="384" valign="top">
                        <p>
                            To opt    out of Google Analytics please follow this link: <a href="https://tools.google.com/dlpage/gaoptout/">https://tools.google.com/dlpage/gaoptout/</a><br>
                            To check your Google ads settings and opt out of Google Ads,    please follow this link:<br>
                            <a href="http://www.google.com/settings/ads">http://www.google.com/settings/ads</a>
                        </p>
                        <p>
                            To    prevent anonymous identifiers* being used for Google Analytics/Ads purposes    on your mobile device:<br>
                            Android
                        </p>
                        <ol start="1" type="1">
                            <li>Open the Google Settings app on your         device</li>
                            <li>Select Ads</li>
                        </ol>
                        <p>
                            iOS<br>
                            Devices with iOS 6 and above use Apple’s Advertising Identifier. To    learn more about limiting ad tracking using this identifier, visit the    Settings menu on your device.
                        </p>
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>Lotame </p>
                    </td>
                    <td width="189" valign="top">
                        <p>Lotame    is a third party service for serving third party online advertising across    online and mobile platforms. It uses a cookie to record online behaviour in    order to show relevant advertising. </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="http://www.lotame.com/opt-out-preference-manager" target="_blank">http://www.lotame.com/opt-out-preference-manager </a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>Nielsen    Standard </p>
                    </td>
                    <td width="189" valign="top">
                        <p>Nielsen    Standard provides online audience measurement and analysis services </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="http://www.nielsen-online.com/corp.jsp?section=leg_prs&amp;nav=1">http://www.nielsen-online.com/corp.jsp?section=leg_prs&amp;nav=1 </a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>Optimizely </p>
                    </td>
                    <td width="189" valign="top">
                        <p>Optimizely    provides a range of website analytics services that enable us to better    understand how our websites are used. </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="https://www.optimizely.com/opt_out">https://www.optimizely.com/opt_out</a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>Quantcast </p>
                    </td>
                    <td width="189" valign="top">
                        <p>Quantcast    is an audience measurement and real-time advertising tool </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="https://www.quantcast.com/opt-out/">https://www.quantcast.com/opt-out/</a></p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>Qubit </p>
                    </td>
                    <td width="189" valign="top">
                        <p>Qubit    provides website optimisation and analytics services. </p>
                    </td>
                    <td width="384" valign="top">
                        <p>Qubit    does not track users across domains and therefore do not provide a universal    opt out. Please use your browser settings to block or delete the Qubit cookie </p>
                    </td>
                </tr>
                <tr>
                    <td width="198" valign="top">
                        <p>Webtrends </p>
                    </td>
                    <td width="189" valign="top">
                        <p>
                            Webtrends    is a web analytics tool that performs similar functions to Google Analytics    in helping us to understand how our users engage with our websites. If you    have not logged in and are browsing anonymously, if you subsequently register    or are already registered on our web site(s), your online actions on our    websites may retrospectively be linked to your user details, and therefore    ascribed to you. This is done using information stored in the Webtrends    cookies and captured in pixel files unless you have deleted the Webtrends    cookie or registered an opt out with Webtrends. This information provides us    with a full picture of how our customers interact with our sites to better    understand their interests in order to tailor our services and products.
                                <br>
                            You may    opt out of the Webtrends cookie by clicking the link in the next column.
                        </p>
                    </td>
                    <td width="384" valign="top">
                        <p><a href="http://kb.webtrends.com/articles/Information/Opting-out-of-Tracking-Cookies-1365447872915" target="_blank">http://kb.webtrends.com/articles/Information/Opting-out-of-Tracking-Cookies-1365447872915 </a></p>
                    </td>
                </tr>
            </tbody>
        </table>
<br>
        <p>If you  would like further information or guidance on cookies, please contact us at <a href="mailto:cookies@euromoneyplc.com">cookies@euromoneyplc.com&nbsp;</a></p>
        <p></p>
        <p></p>
        <p></p>
        <p></p>
        <p></p>', N'Cookies.html page content.', 0, 1, N'Stubs')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (23, N'Stub Privacy Policy', N'        <img src="App_Themes/General/Images/logo.png">
        <h1>Privacy Policy</h1>
        <p><strong>Our Privacy Commitments</strong></p>
        <p>Euromoney Institutional  Investor plc and Institutional Investor Inc. (together "we") respect  the privacy of every person who visits, registers with or subscribes to our  websites and online publications ("you"), and is committed to ensuring  a safe online experience.</p>
        <p>This Privacy Statement  outlines the information we may collect about you in relation to your use of  our websites and related publications and services ("personal data")  and how we may use that personal data.Â   It also outlines the methods by which we and our service providers may  monitor your online behaviour in order to deliver customised advertisements and  marketing materials and other tailored services. This Privacy Statement also  tells you how you can verify the accuracy of your personal data and how you can  request that we delete or update it.</p>
        <p>This Privacy Statement applies  to all websites operated by us (as indicated on the relevant website) ("<strong>Sites</strong>"). For the purpose of this  Privacy Statement "group company" shall mean Euromoney Institutional  Investor plc and any of its subsidiary companies, including, without  limitation, Institutional Investor Inc. Please note that the Sites may contain links to external sites and may  contain advertisements for, and/or the opportunity for you to purchase products  or services from third parties. This privacy statement does not cover the  activities of such third parties, and you should consult those third party  sites'' privacy policies for information on how your data is used by them.</p>
        <p>By accessing and using the  Sites you are agreeing to the terms of this Privacy Statement.</p>
        <p><strong>Information about us</strong></p>
        <p>Our principal business  activities are: </p>
        <ul>
            <li>Business-to-Business Financial  Publishing. Â We provide a range of products and services focused on  international finance, metals, commodities, telecoms and emerging markets  including magazines, newsletters, electronic information and data </li>
            <li>Organisers of Seminars,  Conferences, Training Courses and Exhibitions for the financial markets  industry </li>
        </ul>
        <p>Euromoney Institutional  Investor plc Company Address:</p>
        <p>
            Nestor  House,<br>
            Playhouse Yard,<br>
            London EC4V 5EX<br>
            United Kingdom
        </p>
        <p>
            Institutional Investor, Inc.  Company Address:<br>
            <br>
            225  Park Ave. South,
            <br>
            New York,
            <br>
            NY 10003,
            <br>
            USA
            <br>
            <br>
            <strong>Name of the Data Controller</strong>
        </p>
        <p>The Data Controllers are  Euromoney Institutional Investor plc and Institutional Investor Inc.</p>
        <p>Euromoney Institutional  Investor plc is subject to the UK Data Protection Act 1998 and is registered in  the UK with the Information Commissioner''s Office.</p>
        <p><strong>Collection of Personal Data </strong></p>
        <p>Our primary goal in collecting  personal data from you is to give you an enjoyable customised experience whilst  allowing us to provide services and features that most likely meet your needs.</p>
        <p>We collect certain personal  data from you, which you give to us when using our Sites and/or registering or  subscribing for our products and services.Â   However, we also give you the option to access our Sites'' home pages  without subscribing or registering or disclosing your personal data.</p>
        <p>We also collect certain  personal data from other group companies to whom you have given information  through their websites (including, by way of example, Euromoney Institutional  Investor plc and Institutional Investor Inc, in accordance with the purposes  listed below).</p>
        <p>We do not collect information  about our Site visitors, registered users or subscribers from other sources,  such as public records or bodies, or private organisations.</p>
        <p>
            Please note that we do not  intend to collect any personal data from children under thirteen years of age  and no child under thirteen should submit any personal data to any of the  Sites. Should we discover that any such personal data has been delivered to any  of the Sites, we will remove that information as soon as possible.
            <br>
            <br>
            <strong>Types of Personal Data Held and its Use</strong>
        </p>
        <ol>
            <li><strong>Customer  Services and Administration</strong></li>
            <p>At some  Sites, Euromoney collects personal data such as your name, job title, work  and/or home address, and telephone number and email address in order to  register you for access to certain content and subscriptions. This information  may be supplemented with demographic information from your use of our Sites  such as your postal area, age, gender, purchasing preferences and interests.</p>
            <p>At  other Sites, Euromoney may only collect broad demographic information for  aggregate use.</p>
            <p>This  information is used to administer and deliver to you the products and/or  services you have requested, to operate our Sites efficiently and improve our  service to you, and to retain records of our business transactions and communications. By using the Sites and submitting personal  information through the registration process you are agreeing that we may  collect, hold, process and use your information (including personal  information) for the purpose of providing you with the Site services and  developing our business, which shall include (without limitation) the purposes  described below in paragraphs 2 and 3. </p>
            <li><strong>Monitoring  use of our Sites</strong></li>
            <p>Where,  as part of our Site services, we enable you to post information or materials on  our Site, we may access and monitor any information which you upload or input,  including in any password-protected sections.Â Â   We also monitor and/or record the different Sites you visit and actions  taken on those Sites, e.g.&nbsp;content viewed or searched for.Â  If you are a registered user (e.g. a  subscriber or taking a trial), when you log on, this places a cookie on your  machine.Â  This enables your access to  content and services that are not publicly available.Â  Once you are logged on, the actions you take  â€“ for example, viewing an article â€“ will be recorded.Â  We may use technology or a service provider to  do this for us This information may be used  for one or more of the following purposes:</p>
            <ul>
                <li>to fulfil our obligations to you;</li>
                <li>to improve the efficiency, quality and design of our Sites and services;</li>
                <li>to see which articles, features and services are most read and used </li>
                <li>to track compliance with our terms and conditions of use, e.g. to ensure  that you are acting within the scope of your user licence; </li>
                <li>for marketing purposes (subject to your rights to opt-in and opt-out of  receiving certain marketing communications) â€“ see paragraph 3 below;</li>
                <li>for advertising purposes, although the information used for these purposes  does not identify you personally.Â  Please  see paragraph 5 below for more details; </li>
                <li>to protect or comply with our legal rights and obligations; and</li>
                <li>to enable our journalists to contact and interact with you online in  connection with any content you may post to our Sites. </li>
            </ul>
            <br>
            <li><strong>Marketing</strong>:</li>
            <p>
                Some of  your personal data collected under paragraphs 1 and 2 above may be used by us  and/or our other group companies and third party service providers to contact  you by email, fax, telephone and/or post for sending information or promotional  material on our products and/or services and/or those of our other group  companies.
                <br>
                We give  you the opportunity to opt-out of receiving marketing communications and will  in certain circumstances need to obtain your consent before sending such  communications to you.Â  Further detail  can be found on the applicable Site and in each marketing communication sent by  us, our group companies or service providers.Â   See also â€œConsents and opt-outsâ€ section below.
            </p>
            <li><strong>Trading in Personal  Data</strong>:</li>
            <p>Some of  your personal data may be collected and processed with the intention of selling  it to other organisations, but this will not be done unless you have given your  consent (separately to this privacy statement). </p>
            <li><strong>Cookies and interest based advertising</strong></li>
            <p><strong>5.1 Cookies</strong></p>
            <p>All our  Sites use â€œcookiesâ€. </p>
            <p>A  cookie is a text file placed on your hard drive by a web page server. Cookies  cannot be used to run programs or deliver viruses to your computer. They are  uniquely assigned to you and can only be read by a Web server in the domain  that issued the cookie.Â  As mentioned  above, cookies can be used to track behaviour on our Sites, building online  profiles of our customers.</p>
            <p>Cookies  are either used only during your session (â€œtemporaryâ€ or â€œsession stateâ€  cookies) or stored on your computerâ€™s hard drive (â€œpermanentâ€ cookies). </p>
            <p>Temporary  cookies are a mechanism for maintaining continuity between pages during your  visit. These cookies are maintained in your browserâ€™s active memory and are  terminated at the conclusion of the Site visit. Permanent cookies are used to  recall on subsequent visits your login information and your agreement to our  terms and conditions.</p>
            <p>Cookies  are integral to the functioning of all the Sites. By using your browserâ€™s  options to block cookies you will effectively prohibit effective use of the  Sites. If you still wish to control the operation of cookies, then  functionality is available through your browser. Generally you have the options  to accept all cookies, to be notified when a cookie is issued or reject all  cookies. Please consult your browsers help system for information on how to  block cookies.Â  If you are within a  corporate environment your systems administrator may have set the preferences  for you, in which case their assistance in changing the settings will be  required.</p>
            <p><strong>5.2 Interest based advertising</strong></p>
            <p>Interest based advertisements on our site are provided  by our advertising partner (<a href="http://www.google.com/doubleclick/">DoubleClick by Google</a>).  Our advertising partner will serve ads that it believes are most likely to be  of interest to you, based on certain information about your visit to this and  other Sites.Â  This information is  collected and used, without reference to other data which could identify you in  the real world, in that it does not include your name, street address, email  address or telephone number.</p>
            <p>Please note that, to collect this information for  advertising purposes, our advertising provider may need to place a cookie (a  small text file) on your computer.Â  You  have the right to exercise control over the way we collect and use information  about your online activities in this way and you are entitled to opt-out of  receiving this type of interest based advertising.</p>
            <p>For more information about how cookies and this type of  interest based advertising work and how to disable them, you can also visit <a href="http://www.youronlinechoices.co.uk">www.youronlinechoices.co.uk</a> for more information. You can also refer to the <a href="http://www.google.com/intl/en/privacy/privacy-policy.html">privacy policy</a> of  DoubleClick by Google if you do not wish to receive interest based advertising  on other sites served by their system.&nbsp; DoubleClick can serve an "opt out" cookie to your device.  Please note that the effectiveness of any opt-out for interest based  advertising may be impacted by deleting all cookies on your browser.</p>
        </ol>
        <p>Any other purposes for which  Euromoney wishes to use your personal data will be notified to you and your  personal data will not be used for any such purpose without obtaining your  prior consent.</p>
        <p><strong>Consents and opt-outs</strong></p>
        <p>You can give your consent to  or opt out of particular uses of your data as indicated above by: </p>
        <ul>
            <li>Indicating in a box at the point on the relevant Site where personal data  is collected; </li>
            <li>Informing us by <a href="mailto:dataprotectionofficer@euromoneyplc.com">email</a>, post or phone; or</li>
            <li>Updating your preferences on the applicable Site; or</li>
            <li>For behavioural advertising,  see link in paragraph 5 above.</li>
        </ul>
        <p>You can also use your browser''s options to control  the operation of cookies (please see section 5 above for more details).</p>
        <p><strong>Disclosures</strong></p>
        <p>Information collected at one  Site may be shared between Euromoney Institutional Investor plc,  InstitutionalÂ  Investor Inc. and other  group companies for the purposes listed above.</p>
        <p>Your personal data may also be  sold to other companies in the form of lists and directories, but only after  permission from you in accordance with the provisions above.</p>
        <p>We may also disclose your  personal data to other third parties, including, without limitation,  professional advisers, or governmental or State institutions or regulatory  authorities, where necessary in order to exercise or defend legal rights or  where required by law.</p>
        <p>We may transfer, sell or  assign any of the information described in this policy to third parties as a  result of a sale, merger, consolidation, change of control, transfer of assets  or reorganisation of our business.</p>
        <p><strong>Public forums, message boards and blogs</strong></p>
        <p>Some of our Sites make message  boards, blogs or other facilities for user generated content available and  users can participate in these facilities.Â   Any information that is disclosed in these areas becomes public  information and you should always be careful when deciding to disclose your  personal information.</p>
        <p><strong>Transfers outside the EEA</strong></p>
        <p>Services on the Internet are  accessible globally so collection and transmission of personal data is not  always limited to one country. Euromoney Institutional Investor plc may  transfer your personal data, for the purposes listed above, to other group  companies, service providers or other third parties which may be located in  countries outside the European Economic Area, whose laws may not give the level  of protection to personal data as within the UK. This will include transfers to  Institutional Investor Inc. in the US (and Institutional Investor Inc. will  collect some data directly from you, in relation to the Sites which it operates)  and to third parties who provide us with email and marketing services.Â  Where we conduct any transfers we will take  all steps reasonably necessary to ensure that your data is treated securely and  in accordance with this Privacy Statement.</p>
        <p><strong>Confidentiality and Security of Your Personal Data</strong></p>
        <p>We are committed to keeping  the data you provide us secure and will take reasonable precautions to protect  your personal data from loss, misuse or alteration.</p>
        <p>The transmission of  information via the internet is not completely secure. Although we will do our  best to protect your personal data, we cannot guarantee the security of your  data transmitted to our site; any transmission is at your own risk. Once we  have received your information, we will use strict procedures and security  features described above to try to prevent unauthorised access.</p>
        <p>We have implemented  information security policies, rules and technical measures to protect the  personal data that we have under our control from: </p>
        <ul>
            <li>unauthorised access</li>
            <li>improper use or disclosure </li>
            <li>unauthorised modification </li>
            <li>unlawful destruction or accidental loss </li>
        </ul>
        <p>All our employees, contractors  and data processors (i.e. those who process your personal data on our behalf,  for the purposes listed above), who have access to, and are associated with the  processing of your personal data, are obliged to keep the information  confidential and not use it for any other purpose than to carry out the  services they are performing for us.</p>
        <p>We also give you the option of  using a secure transmission method to send us personal data identifiers, such  as credit card details and bank account number.</p>
        <p><strong>How to Access, Update and Erase your Personal Information</strong></p>
        <p>If you wish to know whether we are keeping personal data about you, or if  you have an enquiry about our privacy policy or your personal data held by us,  in relation to any of the Sites, you can contact the Data Protection Officer  via: </p>
        <ul>
            <li>Postal mail to this address: Data Protection Officer, Euromoney  Institutional Investor plc, Nestor House, Playhouse Yard, London EC4V 5EX, UK</li>
            <li>Telephone: +44 (0)20 7779 8600<strong> </strong></li>
            <li>Email: <a href="mailto:dataprotectionofficer@euromoneyplc.com" title="mailto:dataprotectionofficer@euromoneyplc.com"><strong>dataprotectionofficer@euromoneyplc.com</strong></a></li>
        </ul>
        <p>Upon request, we will provide you  with a readable copy of the personal data which we keep about you. We may  require proof of your identity and may charge a small fee (not exceeding the  statutory maximum fee that can be charged) to cover administration and postage.</p>
        <p>Euromoney allows you to  challenge the data that we hold about you and, where appropriate in accordance  with applicable laws, you may have your personal information: </p>
        <ul>
            <li>erased </li>
            <li>rectified or amended </li>
            <li>completed </li>
        </ul>
        <p><strong>Changes to this Privacy  Statement</strong></p>
        <p>We will occasionally update  this Privacy Statement to reflect new legislation or industry practice, group  company changes and customer feedback. We encourage you to review this Privacy  Statement periodically to be informed of how we are protecting your personal  data.</p>
', N'Policy.html page content.', 0, 1, N'Stubs')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (24, N'Stub Contact Us', N'<h1>Contact Us</h1>
        <table border="0" class="statix-contacts">
            <tbody>
                <tr style="height: 40px;" align="left" valign="middle">
                    <td colspan="2"><span style="color: #808080; font-size: small;"><strong>Contact Information</strong></span></td>
                </tr>
                <tr style="height: 20px;" align="left" valign="middle">
                    <td colspan="2"><span style="font-size: x-small;"><strong><span style="color: #808080;">Data Centre</span> </strong></span></td>
                </tr>
                <tr valign="top">
                    <td>
                        <img title="Address" src="/Content/Images/address.png" alt="Address" width="16" height="16"></td>
                    <td style="width: 455px;"><strong>FOWTradedata</strong><br>
                        Squires House<br>
                        High Street<br>
                        Billericay<br>
                        Essex<br>
                        CM12 9AS</td>
                </tr>
                <tr>
                    <td>
                        <img title="Phone" src="/Content/Images/phone.png" alt="Phone" width="16" height="16"></td>
                    <td style="width: 455px;">+44 (0)1277633777</td>
                </tr>
                <tr>
                    <td>
                        <img title="Fax" src="/Content/Images/fax.png" alt="Fax" width="16" height="16"></td>
                    <td style="width: 455px;">+44 (0)1277633988</td>
                </tr>
                <tr style="height: 20px;" align="left" valign="middle" >
                    <td colspan="2"><br><span style="font-size: x-small;"><strong><span style="color: #808080;">London&nbsp;Office</span> </strong></span></td>
                </tr>
                <tr valign="top">
                    <td>
                        <img title="Address" src="/Content/Images/address.png" alt="Address" width="16" height="16"></td>
                    <td style="width: 455px;">6 Nestor House<br>
                        Playhouse Yard<br>
                        London<br>
                        Essex<br>
                        EC4V 5EX</td>
                </tr>
                <tr>
                    <td>
                        <img title="Phone" src="/Content/Images/phone.png" alt="Phone" width="16" height="16"></td>
                    <td style="width: 455px;">+44 (0)2077798461</td>
                </tr>
                <tr>
                    <td>
                        <img title="Phone" src="/Content/Images/phone.png" alt="Fax" width="16" height="16"></td>
                    <td style="width: 455px;">+44 (0)2077798462</td>
                </tr>
                <tr>
                    <td>
                        <img title="Email" src="/Content/Images/email.png" alt="Email" width="16" height="16"></td>
                    <td style="width: 455px;"><a href="mailto:sales@fowtradedata.com">sales@fowtradedata.com</a></td>
                </tr>
                <tr>
                    <td>
                        <img title="Email" src="/Content/Images/email.png" alt="Email" width="16" height="16"></td>
                    <td style="width: 455px;"><a href="mailto:support@fowtradedata.com">support@fowtradedata.com</a></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td style="width: 455px;"><br><strong>Business Hours:</strong> Monday to Friday (09:00 - 17:00) (GMT)</td>
                </tr>
            </tbody>
        </table>', N'Contacts page content', 0, 1, N'Stubs')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (25, N'Stub Default Page', N'<h1>Statix</h1>
        <table>
            <tbody>
                <tr style="HEIGHT: 30px" valign="top" align="left" _mce_style="height: 30px;">
                    <td align="left"><strong><span style="COLOR: #888888; FONT-SIZE: small; color: #888888; font-size: small;">What is Statix?&nbsp;</span></strong></td>
                </tr>
                <tr>
                    <td align="left" >
                        <p>
                            The online Statix service enables quick access to detailed global information and easy to read global trading calendars on futures and options contracts, to help improve the efficiency of front and back office operations, without the full cost and risk of maintaining a specialist in-house system. This service&nbsp;helps reduce costs of failed trades, over one third of which are attributed to poor reference data.
                            <br>
                            <br>
                            The content-rich service includes exchange information, holidays, trading sessions, exchange members, contract specifications, trading cycles, first and last trading dates, expiry dates, trading volumes and time zones covering over&nbsp;90 derivatives exchanges worldwide.
                            <br>
                            <br>
                            Features include:
                        </p>
                        <ul>
                            <li>Data from over&nbsp;90 derivatives exchanges </li>
                            <li>Exchange information </li>
                            <li>Exchange member details on over 13,000 exchange members </li>
                            <li>Contract specifications for over 30,000 contracts </li>
                            <li>Trading date calendars&nbsp;</li>
                            <li>Historical volume data </li>
                            <li>Exchange holiday dates</li>
                        </ul>
                        <p><strong>To request additional information, please contact our sales department. They will be happy to help you.</strong></p>
                    </td>
                </tr>
            </tbody>
        </table>
        <table border="0" class="statix-contacts">
            <tbody>
                <tr style="height: 40px;" align="left" valign="middle">
                    <td colspan="2"><span style="color: #808080; font-size: small;"><strong>Contact</strong></span></td>
                </tr>
                <tr>
                    <td>
                        <img title="Phone" src="/Content/Images/phone.png" alt="Phone" width="16" height="16"></td>
                    <td style="width: 455px;">+44 (0)1277633777</td>
                </tr>
                <tr>
                    <td>
                        <img title="Fax" src="/Content/Images/fax.png" alt="Fax" width="16" height="16"></td>
                    <td style="width: 455px;">+44 (0)1277633988</td>
                </tr>
                <tr>
                    <td>
                        <img title="Email" src="/Content/Images/email.png" alt="Email" width="16" height="16"></td>
                    <td style="width: 455px;"><a href="mailto:sales@fowtradedata.com">sales@fowtradedata.com</a></td>
                </tr>
            </tbody>
        </table>', N'Default page content (Home button)', 0, 1, N'Stubs')
SET IDENTITY_INSERT [dbo].[Resources] OFF
/****** Object:  Trigger [tr_iod_Referrers]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_Referrers]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_Referrers] on [dbo].[Referrers]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''Referrers''
end
'
GO
/****** Object:  Trigger [tr_iod_IPAddresses]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_IPAddresses]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_IPAddresses] on [dbo].[IPAddresses]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''IPAddresses''
end
'
GO
/****** Object:  Trigger [tr_iod_Actions]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_Actions]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_Actions] on [dbo].[Actions]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''Actions''
end
'
GO
/****** Object:  Table [dbo].[Users]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NULL,
	[Username] [varchar](30) NULL,
	[Email] [varchar](50) NULL,
	[Password] [nvarchar](128) NOT NULL,
	[Salt] [nvarchar](128) NOT NULL,
	[EffectiveDate] [datetime] NULL,
	[ExpiresDate] [datetime] NULL,
	[Notes] [varchar](max) NULL,
	[IsSuspended] [bit] NOT NULL,
	[FailedLoginAttemptsCnt] [smallint] NOT NULL,
	[LastFailedAttempt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
	[SessionId] [uniqueidentifier] NULL,
	[RoleId] [int] NOT NULL,
	[SecureByIp] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_Username] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'IX_StatixAppUsers_userEffectiveDate')
CREATE NONCLUSTERED INDEX [IX_StatixAppUsers_userEffectiveDate] ON [dbo].[Users] 
(
	[EffectiveDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'IX_StatixAppUsers_userExpiresDate')
CREATE NONCLUSTERED INDEX [IX_StatixAppUsers_userExpiresDate] ON [dbo].[Users] 
(
	[ExpiresDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'IX_StatixAppUsers_userID')
CREATE NONCLUSTERED INDEX [IX_StatixAppUsers_userID] ON [dbo].[Users] 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([Id], [CompanyId], [Username], [Email], [Password], [Salt], [EffectiveDate], [ExpiresDate], [Notes], [IsSuspended], [FailedLoginAttemptsCnt], [LastFailedAttempt], [IsDeleted], [SessionId], [RoleId], [SecureByIp]) VALUES (0, 0, N'unknown', N'fake@no-spam.ws', N'VE1/Amtuh3yYsAak2P3wNbHiuBS6splru0RWplmUICc=', N'FhZw1+fmSRwC3U1KCsISJRVK736UpWdy6setVF3Om/Y=', CAST(0x00008F33009450C0 AS DateTime), CAST(0x00008F42009450C0 AS DateTime), N'This user is used to log anonymus exceptions like unknown IP address.', 1, 0, NULL, 0, NULL, 1, 0)
INSERT [dbo].[Users] ([Id], [CompanyId], [Username], [Email], [Password], [Salt], [EffectiveDate], [ExpiresDate], [Notes], [IsSuspended], [FailedLoginAttemptsCnt], [LastFailedAttempt], [IsDeleted], [SessionId], [RoleId], [SecureByIp]) VALUES (1, 0, N'scoughlan', N'SCoughlan@fowtradedata.com', N'lh8mo4hploEsSqYr/JVLNXGXTRW6kASIbSCtLL/PkqI=', N'4fjVYqPA1MuJFqVG9+mt5T85r2SUqm9SJ37oRio6DrA=', CAST(0x0000A607009450C0 AS DateTime), CAST(0x0000A616009450C0 AS DateTime), NULL, 0, 0, NULL, 0, N'5606c9d3-904f-4248-80bf-09e9034cf84e', 1, 0)
INSERT [dbo].[Users] ([Id], [CompanyId], [Username], [Email], [Password], [Salt], [EffectiveDate], [ExpiresDate], [Notes], [IsSuspended], [FailedLoginAttemptsCnt], [LastFailedAttempt], [IsDeleted], [SessionId], [RoleId], [SecureByIp]) VALUES (2, 0, N'vchupaev', N'vitaly.chupaev@arcadia.spb.ru', N'ZnkRgbR83rqJPXgfCfb6LOYih1xOcXBB1NqTnBd9mi4=', N'jcUyOebmmdpbgqL2mcLW364dj86YgeHz8UnHv8Aj7yk=', CAST(0x0000A607009450C0 AS DateTime), CAST(0x0000A616009450C0 AS DateTime), NULL, 0, 0, CAST(0x0000A47900E5C0D2 AS DateTime), 0, N'4943cf13-0746-472c-8aa8-4f87991a8fc5', 3, 0)
INSERT [dbo].[Users] ([Id], [CompanyId], [Username], [Email], [Password], [Salt], [EffectiveDate], [ExpiresDate], [Notes], [IsSuspended], [FailedLoginAttemptsCnt], [LastFailedAttempt], [IsDeleted], [SessionId], [RoleId], [SecureByIp]) VALUES (4, NULL, N'a1', N'a1', N'B0m5AMLNfeeJZUE8VGZX/OX1MLi7yDWhKuhEgiHTjhA=', N'edcTiFkPhR7dGZG5xiYY/XGTuVuP/a5PdOd8lzdyi8s=', CAST(0x0000A4AB00000000 AS DateTime), CAST(0x0000A4C300000000 AS DateTime), N'a', 1, 0, NULL, 1, NULL, 2, 0)
INSERT [dbo].[Users] ([Id], [CompanyId], [Username], [Email], [Password], [Salt], [EffectiveDate], [ExpiresDate], [Notes], [IsSuspended], [FailedLoginAttemptsCnt], [LastFailedAttempt], [IsDeleted], [SessionId], [RoleId], [SecureByIp]) VALUES (5, NULL, N'a2', N'a2', N'CggUFlHfl8MLyGPoieKcx8uLLxPmewluJtM8C8oiewM=', N'ONljX4iSsT1nZP5U0xgaKvDBilVywZp5wbfCypPrqc8=', CAST(0x0000A49E00000000 AS DateTime), CAST(0x0000A49F00000000 AS DateTime), NULL, 0, 0, NULL, 1, NULL, 2, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Trigger [tr_iod_ResourceType]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_ResourceType]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_ResourceType] on [dbo].[ResourceType]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''ResourceType''
end
'
GO
/****** Object:  Trigger [tr_iod_UserRoles]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_UserRoles]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_UserRoles] on [dbo].[UserRoles]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''UserRoles''
end
'
GO
/****** Object:  Trigger [tr_iod_Sites]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_Sites]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_Sites] on [dbo].[Sites]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''Sites''
end
'
GO
/****** Object:  Table [dbo].[SiteReferrer]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteReferrer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SiteReferrer](
	[SiteId] [int] NOT NULL,
	[ReferrerId] [int] NOT NULL,
 CONSTRAINT [PK_SiteReferrer] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[ReferrerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[SiteReferrer] ([SiteId], [ReferrerId]) VALUES (2, 2)
INSERT [dbo].[SiteReferrer] ([SiteId], [ReferrerId]) VALUES (2, 3)
/****** Object:  Table [dbo].[SiteIPAddress]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SiteIPAddress]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SiteIPAddress](
	[SiteId] [int] NOT NULL,
	[IPAddressId] [int] NOT NULL,
 CONSTRAINT [PK_SiteIpAddress] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[IPAddressId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ServiceConfiguration]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceConfiguration]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceConfiguration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Value] [nvarchar](max) NULL,
	[Description] [nvarchar](1500) NULL,
	[IsDeleted] [bit] NOT NULL,
	[ResourceTypeId] [int] NOT NULL,
	[GroupName] [nvarchar](100) NULL,
 CONSTRAINT [PK_ServiceConfiguration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_ServiceConfiguration_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[ServiceConfiguration] ON
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (1, N'Smtp Sender', N'noreply@fowtradedata.com', N'Is used in the FROM field.', 0, 1, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (2, N'Enable SSL', N'False', N'This option should be set to True if TLS is enabled.', 0, 5, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (3, N'Smtp Host', N'smtp.fowtradedata.com', NULL, 0, 1, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (4, N'Smtp Port', N'25', NULL, 0, 2, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (5, N'Smtp Recipients', N'SCoughlan@fowtradedata.com', N'Email(s) of person(s) in charge to receive notifications from the system.', 0, 1, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (6, N'IP Lookup URL', N'http://www.geoplugin.net/json.gp?ip={0}', N'URL of the web service which provides geolocation details about requested IP.
The expected output is:

{
  "geoplugin_countryName":"Spain",
  "geoplugin_continentCode":"EU"
}

It may contain more properties, but only these two are required.', 0, 1, N'Common')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (7, N'Max Login Attempts', N'3', N'Number of failed attempts before a user is got locked', 0, 2, N'Common')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (8, N'Error 500 Contact Person', N'vitaly.chupaev@arcadia.spb.ru', N'This email is used on Error.aspx page in suggestion to contact administrator.', 0, 1, N'Common')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (9, N'Search Results Page Size', N'10', N'In UI - how many results to return from service and show on page.
In Service - how many results to return for request without specified Page Size parameter (ps).
', 0, 2, N'Customer UI')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (10, N'New Line', N'<br>', N'Used in several places, when html output should have a new line.', 0, 1, N'Class Output Format')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (11, N'Original To New Template', N'<b>{0}:</b> <span style="color: grey">{1}</span> ? <span style="color: black">{2}</span><br>', N'Update template for Audit Parameter to format output before showing in the grid.

{0} is for parameter name
{1} is for original value
{2} is for new value', 0, 1, N'Class Output Format')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (12, N'Key Value Template', N'<b>{0}</b>: {1}<br>', N'Template for different purposes, when a key-value pair should be formatted for output.

{0} is for parameter name
{1} is for parameter value', 0, 1, N'Class Output Format')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (13, N'Default Page', N'/Users/List.aspx', N'Page to open on start of Admin UI', 0, 1, N'Load')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (14, N'Banner Path', N'/Themes/{0}/Images/logo.png?{1}', N'The full name of the uploading banner.
The first placeholder is for the Theme name,
the second is for time, to force image to be refreshed by browser after upload (this only affects the Admin UI).', 0, 1, N'Upload')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (15, N'Allowed Content Type', N'image/png', N'Content type of a file allowed for upload.', 0, 1, N'Upload')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (16, N'BNP Paribas Marker', N'bp2s', N'The URL is tested to contain the specified value, case insensitive.', 0, 1, N'Themes')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (17, N'Newedge Marker', N'newedge', N'The URL is tested to contain the specified value, case insensitive.', 0, 1, N'Themes')
SET IDENTITY_INSERT [dbo].[ServiceConfiguration] OFF
/****** Object:  Table [dbo].[Audits]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Audits]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Audits](
	[Id] [uniqueidentifier] NOT NULL,
	[IpAddr] [nvarchar](45) NULL,
	[TableName] [nvarchar](100) NULL,
	[Values] [nvarchar](max) NULL,
	[ActionId] [int] NOT NULL,
	[RecordDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Audit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'c5cc29ba-e6f5-43ae-acab-03bb2de457ea', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/Login.aspx?ReturnUrl=%2fUsers%2fList.aspx","n":""}]', 6, CAST(0x0000A49700F6CDE9 AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'0e8f8717-3cc3-4730-b0bb-07b9f6aabd69', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A4960100D82D AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'f3592d0e-e319-4ddd-859d-1622af394fcb', N'127.0.0.1', N'Sites', N'[{"p":"Id","o":"","n":"3"},{"p":"Name","o":"","n":"Newedge"}]', 1, CAST(0x0000A49700CFA731 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'1bd56bd0-b2aa-44f7-92d5-168398cd8094', N'127.0.0.1', N'Referrers', N'[{"p":"Id","o":"","n":"1"},{"p":"Value","o":"","n":"bp2s"}]', 1, CAST(0x0000A49700D02A67 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'c1af3f31-f9c5-418c-908f-1c58f536d7e0', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A496010357FD AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'ef4b1df4-3089-4326-9049-1fff571711b4', N'127.0.0.1', N'ServiceConfigurations', N'[{"p":"Id","o":"","n":"16"},{"p":"Name","o":"","n":"BNP Paribas Referrer"},{"p":"Value","o":"","n":"bnpparibas.com"},{"p":"Description","o":"","n":"The Referrer URL is tested to contain the specified value, case is ignored."},{"p":"ResourceTypeId","o":"","n":"1"},{"p":"GroupName","o":"","n":"Themes"}]', 1, CAST(0x0000A49200CFB7CF AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'73960d3e-20bc-4de5-a96f-2dc67d4c83f3', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/","n":""}]', 6, CAST(0x0000A49800EC941E AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'cd64fcd4-f907-4a2f-8594-36357f4a3329', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/","n":""}]', 6, CAST(0x0000A49700F3E1EC AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'63022429-59a4-4e79-8dda-48b1669ad293', N'127.0.0.1', N'Referrers', N'[{"p":"Id","o":"1","n":""}]', 3, CAST(0x0000A4970114B9C5 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'1c9b5069-c177-4a08-9923-49298cfcb940', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A49200D8F7F7 AS DateTime), 1, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'41af20f8-518e-4e7f-a623-497c0c263fc7', N'127.0.0.1', N'Referrers', N'[{"p":"Id","o":"","n":"2"},{"p":"Value","o":"","n":"bnpparibas.com"}]', 1, CAST(0x0000A4970114C617 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'e8420e22-3b0f-4b5e-8996-4cd9c3093a7f', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A49601006179 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'9aeba608-dbbf-4c66-a0e1-50ecb764a27c', N'127.0.0.1', N'ServiceConfigurations', N'[{"p":"Id","o":"","n":"17"},{"p":"Name","o":"","n":"Newedge Referrer"},{"p":"Value","o":"","n":"is.echo.net"},{"p":"Description","o":"","n":"The Referrer URL is tested to contain the specified value, case insensitive."},{"p":"ResourceTypeId","o":"","n":"1"},{"p":"GroupName","o":"","n":"Themes"}]', 1, CAST(0x0000A49200D019AC AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'8678c4e0-6077-4ae2-83ae-56deed3c9f09', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A49600F58C5B AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'1d6a1485-f93c-4523-a927-61e583657590', N'127.0.0.1', N'Users', N'[{"p":"Id","o":"2","n":""},{"p":"RoleId","o":"3","n":"1"}]', 2, CAST(0x0000A4960100D343 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'1c904eb6-8947-4b2a-8ea4-633ca5d7c106', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A496010AE366 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'd40975ce-c708-424c-8a60-64a0104d1433', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/Login.aspx?ReturnUrl=%2fUsers%2fList.aspx","n":""}]', 6, CAST(0x0000A49700F7AB9C AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'5a6f730f-a9c8-48a7-a359-6ad4587cd6aa', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/Login.aspx","n":""}]', 6, CAST(0x0000A49700F9B436 AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'8d0f3b61-7e75-42e8-8c2d-74dd87b82eaa', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A49200E5A744 AS DateTime), 1, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'7eb52c89-f6a8-40b5-81d0-753ef00d40ce', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/Login.aspx","n":""}]', 6, CAST(0x0000A49700F9C722 AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'6a4ced67-c6f2-4a60-977e-76fe2f9bd099', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/","n":""}]', 6, CAST(0x0000A49800ED31F1 AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'7c0bb04c-646d-4279-b549-7d805ccb09a6', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A49200EC5783 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'5bda37aa-30f3-4121-b9c7-7e66c202d34f', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/","n":""}]', 6, CAST(0x0000A49800EC9FC0 AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'd2bde0d2-1034-421b-bf5d-8784f4211026', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/exchanges","n":""}]', 6, CAST(0x0000A49700F648B1 AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'd37dca25-587a-4786-a577-94aee66c1bdf', N'127.0.0.1', N'Sites', N'[{"p":"Id","o":"","n":"1"},{"p":"Name","o":"","n":"General"}]', 1, CAST(0x0000A49700CF8DC4 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'5ad10362-3915-4b9a-a6b8-9782bc829735', N'127.0.0.1', N'Users', N'[{"p":"Id","o":"4","n":""},{"p":"IsSuspended","o":"False","n":""},{"p":"FailedLoginAttemptsCnt","o":"0","n":""},{"p":"RoleId","o":"2","n":""},{"p":"SecureByIp","o":"False","n":""}]', 3, CAST(0x0000A497011205F5 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'0df077a1-8f66-44a8-8030-97f89065c50b', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A496010B28F7 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'41a7791b-aacd-4115-bff3-9b78217647c5', N'127.0.0.1', N'Users', N'[{"p":"Id","o":"2","n":""},{"p":"RoleId","o":"1","n":"3"}]', 2, CAST(0x0000A49700D056EC AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'9454d648-ccd5-4554-b298-9c15757f7f45', N'127.0.0.1', N'ServiceConfigurations', N'[{"p":"Id","o":"16","n":""},{"p":"Description","o":"The Referrer URL is tested to contain the specified value, case is ignored.","n":"The Referrer URL is tested to contain the specified value, case insensitive."}]', 2, CAST(0x0000A49200D02ADF AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'b903cd57-f7ed-43a9-b3ad-9e5a480c1310', N'127.0.0.1', N'Users', N'[{"p":"Id","o":"","n":"4"},{"p":"Username","o":"","n":"a1"},{"p":"Email","o":"","n":"a1"},{"p":"Password","o":"","n":"B0m5AMLNfeeJZUE8VGZX/OX1MLi7yDWhKuhEgiHTjhA="},{"p":"Salt","o":"","n":"edcTiFkPhR7dGZG5xiYY/XGTuVuP/a5PdOd8lzdyi8s="},{"p":"EffectiveDate","o":"","n":"6/2/2015 12:00:00 AM"},{"p":"ExpiresDate","o":"","n":"6/26/2015 12:00:00 AM"},{"p":"Notes","o":"","n":"a"},{"p":"IsSuspended","o":"","n":"True"},{"p":"FailedLoginAttemptsCnt","o":"","n":"0"},{"p":"RoleId","o":"","n":"2"}]', 1, CAST(0x0000A4960104D37B AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'f7d090dc-141c-48f4-ab3f-a0384372bd7f', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A49200D94D3C AS DateTime), 1, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'a4938c73-6e9a-4540-98d5-ac0c3d3fc6c8', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A49600C06F38 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'f34eade3-9c1c-4319-ad34-acdf6fd91933', N'127.0.0.1', N'Users', N'[{"p":"Id","o":"","n":"5"},{"p":"Username","o":"","n":"a2"},{"p":"Email","o":"","n":"a2"},{"p":"Password","o":"","n":"CggUFlHfl8MLyGPoieKcx8uLLxPmewluJtM8C8oiewM="},{"p":"Salt","o":"","n":"ONljX4iSsT1nZP5U0xgaKvDBilVywZp5wbfCypPrqc8="},{"p":"EffectiveDate","o":"","n":"5/20/2015 12:00:00 AM"},{"p":"ExpiresDate","o":"","n":"5/21/2015 12:00:00 AM"},{"p":"IsSuspended","o":"","n":"False"},{"p":"FailedLoginAttemptsCnt","o":"","n":"0"},{"p":"RoleId","o":"","n":"2"},{"p":"SecureByIp","o":"","n":"False"}]', 1, CAST(0x0000A4970111FB2A AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'9922d569-4f90-443d-8d9a-add1205d97e8', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/Login.aspx?ReturnUrl=%2fUsers%2fList.aspx","n":""}]', 6, CAST(0x0000A49700F70095 AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'163f6b30-a53d-4947-9585-b2ee027ddedf', N'127.0.0.1', N'Users', N'[{"p":"Id","o":"1","n":""},{"p":"SecureByIp","o":"True","n":"False"}]', 2, CAST(0x0000A4970111CBB4 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'8b830df3-5b90-4173-83fd-c336ad1909a9', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A497011120F0 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'da60580f-61ce-40e8-9809-cf174474f4b6', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A496010B3C04 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'82f4f8b6-79e6-4e83-b980-d36fc447521c', N'212.119.177.5', NULL, NULL, 5, CAST(0x0000A48F01299AFF AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'a0d26faa-5c6c-4d94-9365-d842733a85e6', N'127.0.0.1', NULL, N'[{"p":"Requested URL","o":"/Login.aspx?ReturnUrl=%2fUsers%2fList.aspx","n":""}]', 6, CAST(0x0000A49700F6A994 AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'79c7039f-fee5-4f15-9a19-df39f8c81b5c', N'212.119.177.5', NULL, NULL, 4, CAST(0x0000A48F0129A161 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'371bd327-d0fd-472c-96d2-e3680b7899e8', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A4970115A42B AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'8438740b-9602-4405-a1dd-e5e675ca65ad', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A49701069474 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'fd400d09-dc6d-4eeb-99aa-e62c164151eb', N'127.0.0.1', N'Referrers', N'[{"p":"Id","o":"","n":"3"},{"p":"Value","o":"","n":"is.echonet"}]', 1, CAST(0x0000A4970114D383 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'fc67aa39-9ca0-4d50-be47-e67c3b7f664c', N'127.0.0.1', NULL, NULL, 4, CAST(0x0000A496010AF0FF AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'f943978e-d1a8-4ec9-860e-ef1c9ee5fdb3', N'127.0.0.1', N'Sites', N'[{"p":"Id","o":"","n":"2"},{"p":"Name","o":"","n":"BNP Paribas"}]', 1, CAST(0x0000A49700CF9E2D AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'c5f87776-4e3c-44f8-93ed-f196f6edab9d', N'127.0.0.1', NULL, NULL, 5, CAST(0x0000A49701152149 AS DateTime), 0, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'c47402fa-0708-4252-9c90-f521dd9aa20b', N'127.0.0.1', N'Users', N'[{"p":"Id","o":"5","n":""},{"p":"IsSuspended","o":"False","n":""},{"p":"FailedLoginAttemptsCnt","o":"0","n":""},{"p":"RoleId","o":"2","n":""},{"p":"SecureByIp","o":"False","n":""}]', 3, CAST(0x0000A49701120201 AS DateTime), 2, 0)
INSERT [dbo].[Audits] ([Id], [IpAddr], [TableName], [Values], [ActionId], [RecordDate], [UserId], [IsDeleted]) VALUES (N'9610c4f3-1dec-4f4a-a201-f6b49447babe', N'127.0.0.1', N'Users', N'[{"p":"Id","o":"1","n":""},{"p":"SecureByIp","o":"False","n":"True"}]', 2, CAST(0x0000A4970111BF7E AS DateTime), 2, 0)
/****** Object:  Table [dbo].[UserIPAddress]    Script Date: 05/14/2015 17:08:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserIPAddress]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserIPAddress](
	[UserId] [int] NOT NULL,
	[IPAdderessId] [int] NOT NULL,
 CONSTRAINT [PK_UserIPAddress] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[IPAdderessId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[UserIPAddress] ([UserId], [IPAdderessId]) VALUES (1, 1)
INSERT [dbo].[UserIPAddress] ([UserId], [IPAdderessId]) VALUES (2, 1)


/****** Object:  Table [dbo].[FilteredContractTypes]    Script Date: 05/15/2015 14:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FilteredContractTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FilteredContractTypes](
	[ContractTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ContractType] [char](1) NOT NULL,
	[Description] [varchar](50) NULL,
	[SFAInstrumentType] [char](1) NULL,
	[SFADescription] [varchar](50) NULL,
 CONSTRAINT [PK_FilteredContractTypes] PRIMARY KEY NONCLUSTERED 
(
	[ContractType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[FilteredContractTypes] ON
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (1, N'A', N'Agricultural', N'M', N'Commodities')
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (2, N'S', N'Soft', N'M', N'Commodities')
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (3, N'M', N'Metal', N'M', N'Commodities')
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (4, N'E', N'Energy', N'M', N'Commodities')
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (5, N'B', N'Interest Rate - Long Term', N'B', N'Interest Rate - Long Term')
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (6, N'R', N'Interest Rate - Short Term', N'R', N'Interest Rate - Short Term')
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (7, N'X', N'Index', N'I', N'Index')
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (8, N'C', N'Currency', N'U', N'Currency')
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (9, N'O', N'Other', N'O', N'Other')
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (11, N'T', N'Total Exchange', NULL, NULL)
INSERT [dbo].[FilteredContractTypes] ([ContractTypeID], [ContractType], [Description], [SFAInstrumentType], [SFADescription]) VALUES (12, N'Q', N'Equity', N'A', N'Equity')
SET IDENTITY_INSERT [dbo].[FilteredContractTypes] OFF



/****** Object:  Trigger [tr_iod_Users]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_Users]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_Users] on [dbo].[Users]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''Users''
end
'
GO
/****** Object:  Trigger [tr_iod_ServiceConfiguration]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_ServiceConfiguration]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_ServiceConfiguration] on [dbo].[ServiceConfiguration]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''ServiceConfiguration''
end
'
GO
/****** Object:  Trigger [tr_iod_Resources]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_Resources]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_Resources] on [dbo].[Resources]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''Resources''
end
'
GO
/****** Object:  StoredProcedure [dbo].[spJobExpireUsers]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spJobExpireUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create procedure [dbo].[spJobExpireUsers]
as
begin
	update	users 
	set		IsSuspended = 1
	where	cast (ExpiresDate as date) < cast (getdate() as date) 
	and		IsSuspended = 0
end

' 
END
GO
/****** Object:  Trigger [tr_iod_Audits]    Script Date: 05/14/2015 17:08:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_iod_Audits]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[tr_iod_Audits] on [dbo].[Audits]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = ''Audits''
end
'
GO
/****** Object:  Default [DF__Actions__IsDelet__62E1E074]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Actions__IsDelet__62E1E074]') AND parent_object_id = OBJECT_ID(N'[dbo].[Actions]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Actions__IsDelet__62E1E074]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Actions] ADD  DEFAULT ((0)) FOR [IsDeleted]
END


End
GO
/****** Object:  Default [DF__Audits__Id__65BE4D1F]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Audits__Id__65BE4D1F]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audits]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Audits__Id__65BE4D1F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Audits] ADD  DEFAULT (newid()) FOR [Id]
END


End
GO
/****** Object:  Default [DF__Audits__IsDelete__66B27158]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Audits__IsDelete__66B27158]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audits]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Audits__IsDelete__66B27158]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Audits] ADD  DEFAULT ((1)) FOR [IsDeleted]
END


End
GO
/****** Object:  Default [DF_ELMAH_Error_ErrorId]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ELMAH_Error_ErrorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[ELMAH_Error]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ELMAH_Error_ErrorId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ELMAH_Error] ADD  CONSTRAINT [DF_ELMAH_Error_ErrorId]  DEFAULT (newid()) FOR [ErrorId]
END


End
GO
/****** Object:  Default [DF__IPAddress__IsAll__6C6B4AAE]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__IPAddress__IsAll__6C6B4AAE]') AND parent_object_id = OBJECT_ID(N'[dbo].[IPAddresses]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__IPAddress__IsAll__6C6B4AAE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IPAddresses] ADD  CONSTRAINT [DF__IPAddress__IsAll__6C6B4AAE]  DEFAULT ((0)) FOR [IsAllowed]
END


End
GO
/****** Object:  Default [DF_IPAddresses_IsAdminIp]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_IPAddresses_IsAdminIp]') AND parent_object_id = OBJECT_ID(N'[dbo].[IPAddresses]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_IPAddresses_IsAdminIp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IPAddresses] ADD  CONSTRAINT [DF_IPAddresses_IsAdminIp]  DEFAULT ((0)) FOR [IsAdminIp]
END


End
GO
/****** Object:  Default [DF__IPAddress__IsDel__6D5F6EE7]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__IPAddress__IsDel__6D5F6EE7]') AND parent_object_id = OBJECT_ID(N'[dbo].[IPAddresses]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__IPAddress__IsDel__6D5F6EE7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[IPAddresses] ADD  CONSTRAINT [DF__IPAddress__IsDel__6D5F6EE7]  DEFAULT ((0)) FOR [IsDeleted]
END


End
GO
/****** Object:  Default [DF_Referrers_IsDeleted]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Referrers_IsDeleted]') AND parent_object_id = OBJECT_ID(N'[dbo].[Referrers]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Referrers_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Referrers] ADD  CONSTRAINT [DF_Referrers_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
END


End
GO
/****** Object:  Default [DF_ResourceType_IsDeleted]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ResourceType_IsDeleted]') AND parent_object_id = OBJECT_ID(N'[dbo].[ResourceType]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ResourceType_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ResourceType] ADD  CONSTRAINT [DF_ResourceType_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
END


End
GO
/****** Object:  Default [DF_Sites_IsDeleted]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Sites_IsDeleted]') AND parent_object_id = OBJECT_ID(N'[dbo].[Sites]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Sites_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Sites] ADD  CONSTRAINT [DF_Sites_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
END


End
GO
/****** Object:  Default [DF__UserRoles__IsDel__57702DC8]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__UserRoles__IsDel__57702DC8]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRoles]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__UserRoles__IsDel__57702DC8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserRoles] ADD  DEFAULT ((0)) FOR [IsDeleted]
END


End
GO
/****** Object:  Default [DF_Users_IsSuspended]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Users_IsSuspended]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Users_IsSuspended]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsSuspended]  DEFAULT ((0)) FOR [IsSuspended]
END


End
GO
/****** Object:  Default [DF__Users__FailedLog__5C34E2E5]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Users__FailedLog__5C34E2E5]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Users__FailedLog__5C34E2E5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__FailedLog__5C34E2E5]  DEFAULT ((0)) FOR [FailedLoginAttemptsCnt]
END


End
GO
/****** Object:  Default [DF__Users__IsDeleted__5D29071E]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Users__IsDeleted__5D29071E]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Users__IsDeleted__5D29071E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__IsDeleted__5D29071E]  DEFAULT ((0)) FOR [IsDeleted]
END


End
GO
/****** Object:  Default [DF__Users__RoleId__5E1D2B57]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__Users__RoleId__5E1D2B57]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Users__RoleId__5E1D2B57]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__RoleId__5E1D2B57]  DEFAULT ((2)) FOR [RoleId]
END


End
GO
/****** Object:  Default [DF_Users_SecureByIp]    Script Date: 05/14/2015 17:08:27 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Users_SecureByIp]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Users_SecureByIp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_SecureByIp]  DEFAULT ((0)) FOR [SecureByIp]
END


End
GO
/****** Object:  ForeignKey [FK_Audit_AuditActions]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Audit_AuditActions]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audits]'))
ALTER TABLE [dbo].[Audits]  WITH CHECK ADD  CONSTRAINT [FK_Audit_AuditActions] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Audit_AuditActions]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audits]'))
ALTER TABLE [dbo].[Audits] CHECK CONSTRAINT [FK_Audit_AuditActions]
GO
/****** Object:  ForeignKey [FK_Audit_Users]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Audit_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audits]'))
ALTER TABLE [dbo].[Audits]  WITH CHECK ADD  CONSTRAINT [FK_Audit_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Audit_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[Audits]'))
ALTER TABLE [dbo].[Audits] CHECK CONSTRAINT [FK_Audit_Users]
GO
/****** Object:  ForeignKey [FK_IPAddresses_Countries]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IPAddresses_Countries]') AND parent_object_id = OBJECT_ID(N'[dbo].[IPAddresses]'))
ALTER TABLE [dbo].[IPAddresses]  WITH CHECK ADD  CONSTRAINT [FK_IPAddresses_Countries] FOREIGN KEY([GeoLocationCountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IPAddresses_Countries]') AND parent_object_id = OBJECT_ID(N'[dbo].[IPAddresses]'))
ALTER TABLE [dbo].[IPAddresses] CHECK CONSTRAINT [FK_IPAddresses_Countries]
GO
/****** Object:  ForeignKey [FK_Resources_ResourceType]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Resources_ResourceType]') AND parent_object_id = OBJECT_ID(N'[dbo].[Resources]'))
ALTER TABLE [dbo].[Resources]  WITH CHECK ADD  CONSTRAINT [FK_Resources_ResourceType] FOREIGN KEY([ResourceTypeId])
REFERENCES [dbo].[ResourceType] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Resources_ResourceType]') AND parent_object_id = OBJECT_ID(N'[dbo].[Resources]'))
ALTER TABLE [dbo].[Resources] CHECK CONSTRAINT [FK_Resources_ResourceType]
GO
/****** Object:  ForeignKey [FK_ServiceConfiguration_ResourceType]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ServiceConfiguration_ResourceType]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceConfiguration]'))
ALTER TABLE [dbo].[ServiceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_ServiceConfiguration_ResourceType] FOREIGN KEY([ResourceTypeId])
REFERENCES [dbo].[ResourceType] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ServiceConfiguration_ResourceType]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceConfiguration]'))
ALTER TABLE [dbo].[ServiceConfiguration] CHECK CONSTRAINT [FK_ServiceConfiguration_ResourceType]
GO
/****** Object:  ForeignKey [FK_SiteIPAddress_IPAddresses]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteIPAddress_IPAddresses]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteIPAddress]'))
ALTER TABLE [dbo].[SiteIPAddress]  WITH CHECK ADD  CONSTRAINT [FK_SiteIPAddress_IPAddresses] FOREIGN KEY([IPAddressId])
REFERENCES [dbo].[IPAddresses] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteIPAddress_IPAddresses]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteIPAddress]'))
ALTER TABLE [dbo].[SiteIPAddress] CHECK CONSTRAINT [FK_SiteIPAddress_IPAddresses]
GO
/****** Object:  ForeignKey [FK_SiteIPAddress_Sites]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteIPAddress_Sites]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteIPAddress]'))
ALTER TABLE [dbo].[SiteIPAddress]  WITH CHECK ADD  CONSTRAINT [FK_SiteIPAddress_Sites] FOREIGN KEY([SiteId])
REFERENCES [dbo].[Sites] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteIPAddress_Sites]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteIPAddress]'))
ALTER TABLE [dbo].[SiteIPAddress] CHECK CONSTRAINT [FK_SiteIPAddress_Sites]
GO
/****** Object:  ForeignKey [FK_SiteReferrer_Referrers]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteReferrer_Referrers]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteReferrer]'))
ALTER TABLE [dbo].[SiteReferrer]  WITH CHECK ADD  CONSTRAINT [FK_SiteReferrer_Referrers] FOREIGN KEY([ReferrerId])
REFERENCES [dbo].[Referrers] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteReferrer_Referrers]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteReferrer]'))
ALTER TABLE [dbo].[SiteReferrer] CHECK CONSTRAINT [FK_SiteReferrer_Referrers]
GO
/****** Object:  ForeignKey [FK_SiteReferrer_Sites]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteReferrer_Sites]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteReferrer]'))
ALTER TABLE [dbo].[SiteReferrer]  WITH CHECK ADD  CONSTRAINT [FK_SiteReferrer_Sites] FOREIGN KEY([SiteId])
REFERENCES [dbo].[Sites] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SiteReferrer_Sites]') AND parent_object_id = OBJECT_ID(N'[dbo].[SiteReferrer]'))
ALTER TABLE [dbo].[SiteReferrer] CHECK CONSTRAINT [FK_SiteReferrer_Sites]
GO
/****** Object:  ForeignKey [FK_UserIPAddress_IPAddresses]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserIPAddress_IPAddresses]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserIPAddress]'))
ALTER TABLE [dbo].[UserIPAddress]  WITH CHECK ADD  CONSTRAINT [FK_UserIPAddress_IPAddresses] FOREIGN KEY([IPAdderessId])
REFERENCES [dbo].[IPAddresses] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserIPAddress_IPAddresses]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserIPAddress]'))
ALTER TABLE [dbo].[UserIPAddress] CHECK CONSTRAINT [FK_UserIPAddress_IPAddresses]
GO
/****** Object:  ForeignKey [FK_UserIPAddress_Users]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserIPAddress_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserIPAddress]'))
ALTER TABLE [dbo].[UserIPAddress]  WITH CHECK ADD  CONSTRAINT [FK_UserIPAddress_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserIPAddress_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserIPAddress]'))
ALTER TABLE [dbo].[UserIPAddress] CHECK CONSTRAINT [FK_UserIPAddress_Users]
GO
/****** Object:  ForeignKey [FK_Users_UserRoles]    Script Date: 05/14/2015 17:08:27 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Users_UserRoles]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[UserRoles] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Users_UserRoles]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserRoles]
GO


