USE [master]
GO

IF db_id('{DB_NAME}') IS NOT NULL
BEGIN
	ALTER DATABASE [{DB_NAME}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE [{DB_NAME}];
END;
GO

/****** Object:  Database [{DB_NAME}]    Script Date: 03/05/2015 16:52:18 ******/
CREATE DATABASE [{DB_NAME}] ON  PRIMARY 
( NAME = N'{DB_NAME}', FILENAME = N'{DB_FILENAME}' , SIZE = 47808KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'{DB_NAME}_log', FILENAME = N'{DB_LOGNAME}' , SIZE = 118016KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [{DB_NAME}] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [{DB_NAME}].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [{DB_NAME}] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [{DB_NAME}] SET ANSI_NULLS OFF
GO
ALTER DATABASE [{DB_NAME}] SET ANSI_PADDING OFF
GO
ALTER DATABASE [{DB_NAME}] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [{DB_NAME}] SET ARITHABORT OFF
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [{DB_NAME}] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [{DB_NAME}] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [{DB_NAME}] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [{DB_NAME}] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [{DB_NAME}] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [{DB_NAME}] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [{DB_NAME}] SET  DISABLE_BROKER
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [{DB_NAME}] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [{DB_NAME}] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [{DB_NAME}] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [{DB_NAME}] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [{DB_NAME}] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [{DB_NAME}] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [{DB_NAME}] SET  READ_WRITE
GO
ALTER DATABASE [{DB_NAME}] SET RECOVERY FULL
GO
ALTER DATABASE [{DB_NAME}] SET  MULTI_USER
GO
ALTER DATABASE [{DB_NAME}] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [{DB_NAME}] SET DB_CHAINING OFF
GO

USE [{DB_NAME}]
GO

/****** Object:  Table [dbo].[ELMAH_Error]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
CREATE NONCLUSTERED INDEX [IX_ELMAH_Error_App_Time_Seq] ON [dbo].[ELMAH_Error] 
(
	[Application] ASC,
	[TimeUtc] DESC,
	[Sequence] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[DecryptPassword]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	@password stands for varbinary string, which is to be decrypted with PasswordsKey symmetric key,
	@id stands for some value, commonly the primary key value of the row the password stored in, and used as a parameter of DecryptByKey function - @authenticator.
*/
CREATE function [dbo].[DecryptPassword]
(
	@password varbinary(300),
	@id int
)
returns nvarchar(100)
as
begin
	declare @result nvarchar(100);

/*
	function doesn't allow to open the key directly, 
	so execute the line below before calling this function:
	
	open symmetric key PasswordsKey decryption by certificate UsersCert;
*/
	set @result = CAST(DecryptByKey(@password, 1, HashBytes('SHA1', CONVERT(varbinary, @id))) as nvarchar)
	return @result;
end
GO
/****** Object:  UserDefinedTableType [dbo].[NumberList]    Script Date: 09/30/2016 14:10:53 ******/
CREATE TYPE [dbo].[NumberList] AS TABLE(
	[number] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fnIPtoBigInt]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnIPtoBigInt]
(
    @Ipaddress NVARCHAR(15) -- should be in the form '123.123.123.123'
)
RETURNS BIGINT
AS
BEGIN
 DECLARE @part1 AS NVARCHAR(3) 
 DECLARE @part2 AS NVARCHAR(3) 
 DECLARE @part3 AS NVARCHAR(3)
 DECLARE @part4 AS NVARCHAR(3)

 SELECT @part1 = LEFT(@Ipaddress, CHARINDEX('.',@Ipaddress) - 1)
 SELECT @Ipaddress = SUBSTRING(@Ipaddress, LEN(@part1) + 2, 15)
 SELECT @part2 = LEFT(@Ipaddress, CHARINDEX('.',@Ipaddress) - 1)
 SELECT @Ipaddress = SUBSTRING(@Ipaddress, LEN(@part2) + 2, 15)
 SELECT @part3 = LEFT(@Ipaddress, CHARINDEX('.',@Ipaddress) - 1)
 SELECT @part4 = SUBSTRING(@Ipaddress, LEN(@part3) + 2, 15)

 DECLARE @ipAsBigInt AS BIGINT
 SELECT @ipAsBigInt =
    (16777216 * (CAST(@part1 AS BIGINT)))
    + (65536 * (CAST(@part2 AS BIGINT)))
    + (256 * (CAST(@part3 AS BIGINT)))
    + (CAST(@part4 AS BIGINT))

 RETURN @ipAsBigInt

END
GO
/****** Object:  Table [dbo].[FailedAttemptsUsers]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailedAttemptsUsers](
	[Username] [nvarchar](50) NOT NULL,
	[IpAddress] [nvarchar](18) NOT NULL,
	[FailedAttemptsCnt] [int] NULL,
	[LastAttempt] [datetime] NULL,
 CONSTRAINT [PK_FailedAttemptsUsers] PRIMARY KEY CLUSTERED 
(
	[Username] ASC,
	[IpAddress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[EncryptPassword]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	@password stands for plain text password, which is to be encrypted with PasswordsKey symmetric key,
	@id stands for some value, commonly the primary key value of the row the password stored in, and used as a parameter of EncryptByKey function - @authenticator.
*/
CREATE function [dbo].[EncryptPassword]
(
	@password nvarchar(100),
	@id int
)
returns varbinary(300)
as
begin
	declare @result varbinary(300);

/*
	function doesn't allow to open the key directly, 
	so execute the line below before calling this function:
	
	open symmetric key PasswordsKey decryption by certificate UsersCert;
*/

	set @result = EncryptByKey(Key_GUID('PasswordsKey'), cast(@password as nvarchar(100)), 1, HashBytes('SHA1', CONVERT(varbinary, @id)))
	return @result;
end
GO


create procedure spSyncUsers
as
begin
	begin try
		begin tran myTran

		declare @outputTbl table (ID int);

		-- working with encryption
		exec spOpenPasswordsKey;

		-- insert new users, skip password this time
		insert into Users (CompanyId, firstname, lastname, username, accountExpirationDate, ExportedCompanyId)
		output INSERTED.UserId INTO @outputTbl(ID)
		select 3, u.Firstname, u.Lastname, u.Username, u.AccountExpirationDate, u.CompanyId
		from Users.dbo.Users u left join Users tdu on u.Username = tdu.Username
		where AllowSync = 1 and syncpassword is not null and tdu.Username is null and u.IsActive = 1 and u.IsDeleted = 0

		-- update existed users with encrypted password, userId is required for encryption
		update tdu 
		set [password] = dbo.EncryptPassword(u.syncpassword, UserId),
            tdu.ExportedCompanyId = u.CompanyId,
            tdu.firstname = u.firstname,
            tdu.lastname = u.lastname,
            tdu.AccountExpirationDate = u.AccountExpirationDate
		from Users.dbo.Users u join Users tdu on u.Username = tdu.Username
		where AllowSync = 1 and syncpassword is not null and u.IsActive = 1 and u.IsDeleted = 0

		-- clean passwords
		update u
		set syncpassword = null
		from Users.dbo.Users u join Users tdu on u.Username = tdu.Username
		where syncpassword is not null

		declare @roleId int = (select roleId from Roles where RoleName = 'Statix Users')
		-- assign statix role
		insert into UserRole (UserId, RoleId) 
		select id, @roleId from @outputTbl
		commit tran myTran;
	end try
	begin catch
		rollback tran myTran;
		select 
			ERROR_NUMBER() AS ErrorNumber
		   ,ERROR_MESSAGE() AS ErrorMessage;
	end catch	
end


/****** Object:  StoredProcedure [dbo].[1_Create_AUDIT_Table]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[1_Create_AUDIT_Table]
@TableName as varchar(100)
AS
BEGIN

DECLARE @AuditTableName as varchar(100) 
SET	@AuditTableName = 'AUDIT_' + @TableName

	--CHECK IF SOURCE TABLE EXISTS
	IF (SELECT COUNT(*) FROM INFORMATION_SCHEMA.Columns WHERE TABLE_NAME = @TableName) >0
	BEGIN
		--CHECK IF AUDIT TABLE DOES NOT EXIST
		 IF (SELECT COUNT(*) FROM INFORMATION_SCHEMA.Columns WHERE TABLE_NAME = @AuditTableName) =0
			BEGIN
				DECLARE @ACT CHAR(6)
				DECLARE @DEL BIT
				DECLARE @INS BIT 
				DECLARE @SQLSTRING VARCHAR(4000)

			
					-- CREATE A TEMP TABLE CONTAINING THE FIELDS AND TYPES OF THE TABLE
					DECLARE @MEMTABLE TABLE
					( 
						ID INT IDENTITY
						,COLUMNAME SYSNAME
						,TYPENAME VARCHAR(20)
					 )
					 				
					-- INSERT THE COLUMNAMES AND THE DATATYPES
					INSERT @MEMTABLE 
						(COLUMNAME,TYPENAME) 
						SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.Columns 
						WHERE TABLE_NAME =  @TableName
						ORDER BY ORDINAL_POSITION	
					

					DECLARE @CUR INTEGER
					DECLARE @MAX INTEGER
					DECLARE @SQLSTR AS VARCHAR(8000)
					DECLARE @CURCOL SYSNAME
					DECLARE @COLTYPE AS VARCHAR(10)

					-- SETUP VARIABLES
					SET @SQLSTR = ''
					SET @CUR=1
					SELECT @MAX = MAX(ID) FROM @MEMTABLE

					-- LOOP EVERY FIELD
					WHILE @CUR <= @MAX
					BEGIN
						-- GET VALUES FROM THE MEMTABLE	
						SELECT @CURCOL = COLUMNAME,@COLTYPE = TYPENAME FROM @MEMTABLE WHERE ID = @CUR
						IF @COLTYPE = 'INT' OR @COLTYPE = 'BIGINT' OR @COLTYPE='UNIQUEIDENTIFIER'
							-- DO NOT COPY INT/BIGINT/UNIQUEIDENTIFIER, IDENTITY OR A ROWGUIDCOLUMN FIELDS 
							SET @SQLSTR = @SQLSTR + ' CAST('+@CURCOL + ' AS '+@COLTYPE+') AS [' + @CURCOL +'] '
						ELSE
							-- OTHERWISE FIELD DO NOTHING JUST COPY IT AS IT IS
							SET @SQLSTR = @SQLSTR + ' '+@CURCOL + ' AS [' + @CURCOL +'] '
						IF @CUR <= @MAX - 1 SET @SQLSTR=@SQLSTR + ','
						SET @CUR = @CUR + 1
					END
					
					SET @SQLSTR = @SQLSTR
					-- SET UP THE SELECT FOR CREATING THE AUDIT TABLE
					SET @SQLSTR = 'SELECT TOP 0 ' + @SQLSTR + ' INTO [DBO].['+ @AuditTableName +'] FROM [' + @TableName +']'
					EXEC(@SQLSTR)							
					
					-- ***************ADD THE AUDIT FIELDS************************
									
					--ADD TRG_ACTION COLUMN TO AUDIT TABLE
					SET @SQLSTR = 'ALTER TABLE '+ @AuditTableName + ' ADD [TRG_ACTION] VARCHAR(6) NULL'
					EXEC(@SQLSTR)	

					--SET DEFAULT VALUE FOR TRG_DATE
					SET @SQLSTR = 'ALTER TABLE '+ @AuditTableName + ' ADD [TRG_DATE] DATETIME NULL DEFAULT GETDATE()'
					EXEC(@SQLSTR)	
					-- ************************************************************			

					--****************************CREATE INDEXES ON AUDIT TABLE*******************
										
					SET @SQLSTR = 'CREATE NONCLUSTERED INDEX ' +  @AuditTableName  + '_TRG_ACTION_Index ON ' + @AuditTableName + '(TRG_ACTION)'
					EXEC(@SQLSTR)
					
					SET @SQLSTR = 'CREATE NONCLUSTERED INDEX ' +  @AuditTableName  + '_TRG_DATE_Index ON ' + @AuditTableName + '(TRG_DATE)'
					EXEC(@SQLSTR)
					--*****************************************************************************							
				END
	END
END
GO
/****** Object:  StoredProcedure [dbo].[ChangeDMKPassword]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***
	The IT database uses encryption for sensitive data, like passwords.
	It uses the symmetric key encrypted with certificate.
	Certificate is protected by database master key (DMK).
	DMK is protected by the SQL Server instance specific service master key (SMK).
	Once you restore the database on the new instance (e.g. from dev to prod), the new SMK doesn't match.
	To be able to use the symmetric key for decryption, you need to open DMK with a password, which was used to create it
	and re-encrypt it with the new SMK.
***/
CREATE procedure [dbo].[ChangeDMKPassword]
 @oldPassword nvarchar(100),
 @newPassword nvarchar(100)
as
begin

/***
	Dynamic SQL is required, because password cannot be set from variable - it must be a constant.
***/
declare @sql nvarchar(1024) = 
	'open master key decryption by password = ''' + @oldPassword + ''';
	 alter master key add encryption by password = ''' + @newPassword + ''';
	 alter master key drop encryption by password = ''' + @oldPassword + ''';
	 close master key;'
exec sp_executesql @sql

end
GO
/****** Object:  UserDefinedTableType [dbo].[StringList]    Script Date: 09/30/2016 14:10:53 ******/
CREATE TYPE [dbo].[StringList] AS TABLE(
	[string] [nvarchar](max) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[spOpenPasswordsKey]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spOpenPasswordsKey] asbegin	OPEN SYMMETRIC KEY PasswordsKey DECRYPTION BY CERTIFICATE UsersCert;end
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]
    (
        @List NVARCHAR(MAX),
        @Delim VARCHAR(255)
    )
    RETURNS TABLE
    AS
        RETURN ( SELECT [Value] FROM 
          ( 
            SELECT 
              [Value] = LTRIM(RTRIM(SUBSTRING(@List, [Number],
              CHARINDEX(@Delim, @List + @Delim, [Number]) - [Number])))
            FROM (SELECT Number = ROW_NUMBER() OVER (ORDER BY name)
              FROM sys.all_objects) AS x
              WHERE Number <= LEN(@List)
              AND SUBSTRING(@Delim + @List, [Number], LEN(@Delim)) = @Delim
          ) AS y
        );
GO
/****** Object:  StoredProcedure [dbo].[spClosePasswordsKey]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spClosePasswordsKey] asbegin	CLOSE SYMMETRIC KEY PasswordsKey;end
GO
/****** Object:  UserDefinedFunction [dbo].[fnSubnetBitstoBigInt]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnSubnetBitstoBigInt]
(
    @SubnetBits TINYINT -- max = 32
)
RETURNS BIGINT
AS
BEGIN

 DECLARE @multiplier AS BIGINT = 2147483648
 DECLARE @ipAsBigInt AS BIGINT = 0
 DECLARE @bitIndex TINYINT = 1
 WHILE @bitIndex <= @SubnetBits
 BEGIN
    SELECT @ipAsBigInt = @ipAsBigInt + @multiplier
    SELECT @multiplier = @multiplier / 2
    SELECT @bitIndex = @bitIndex + 1
 END

 RETURN @ipAsBigInt

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateDMKOnRestoreOnNewInstance]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***
	The IT database uses encryption for sensitive data, like passwords.
	It uses the symmetric key encrypted with certificate.
	Certificate is protected by database master key (DMK).
	DMK is protected by the SQL Server instance specific service master key (SMK).
	Once you restore the database on the new instance (e.g. from dev to prod), the new SMK doesn't match.
	To be able to use the symmetric key for decryption, you need to open DMK with a password, which was used to create it
	and re-encrypt it with the new SMK.
***/
create procedure [dbo].[UpdateDMKOnRestoreOnNewInstance]
 @password nvarchar(100)
as
begin

/***
	Dynamic SQL is required, because password cannot be set from variable - it must be a constant.
***/
declare @sql nvarchar(1024) = 
	'open master key decryption by password = ''' + @password + ''';
	 alter master key add encryption by service master key;
	 close master key;'
exec sp_executesql @sql

end
GO
/****** Object:  View [dbo].[vwElmahError]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwElmahError]
AS
SELECT     Host, Type, Message, [User], StatusCode, TimeUtc, Sequence, Application AS ApplicationCode
FROM         dbo.ELMAH_Error
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[30] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ELMAH_Error"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 259
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2940
         Width = 3675
         Width = 2940
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1380
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwElmahError'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwElmahError'
GO
/****** Object:  UserDefinedFunction [dbo].[fnIsIpaddressInSubnetShortHand]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnIsIpaddressInSubnetShortHand]
(
    @network NVARCHAR(18), -- 'eg: '192.168.0.0/24'
    @testAddress NVARCHAR(15) -- 'eg: '192.168.0.1'
)
RETURNS BIT AS
BEGIN
	IF CHARINDEX('/', @network) = 0
	BEGIN
		RETURN CASE WHEN @network = @testAddress THEN 1 ELSE 0 END
	END
	
    DECLARE @networkAddress NVARCHAR(15)
    DECLARE @subnetBits TINYINT

    SELECT @networkAddress = LEFT(@network, CHARINDEX('/', @network) - 1)
    SELECT @subnetBits = CAST(SUBSTRING(@network, LEN(@networkAddress) + 2, 2) AS TINYINT)

    RETURN CASE WHEN (dbo.fnIPtoBigInt(@networkAddress) & dbo.fnSubnetBitstoBigInt(@subnetBits)) 
        = (dbo.fnIPtoBigInt(@testAddress) & dbo.fnSubnetBitstoBigInt(@subnetBits)) 
    THEN 1 ELSE 0 END
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnIsIpaddressInSubnet]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnIsIpaddressInSubnet]
(
    @networkAddress NVARCHAR(15), -- 'eg: '192.168.0.0'
    @subnetMask NVARCHAR(15), -- 'eg: '255.255.255.0' for '/24'
    @testAddress NVARCHAR(15) -- 'eg: '192.168.0.1'
)
RETURNS BIT AS
BEGIN
    RETURN CASE WHEN (dbo.fnIPtoBigInt(@networkAddress) & dbo.fnIPtoBigInt(@subnetMask)) 
        = (dbo.fnIPtoBigInt(@testAddress) & dbo.fnIPtoBigInt(@subnetMask)) 
    THEN 1 ELSE 0 END
END
GO
/****** Object:  StoredProcedure [dbo].[spResetSessionId]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spResetSessionId]
	@username varchar(100)
as
begin
	exec [Users].dbo.spResetSessionId @username = @username
end
GO
/****** Object:  StoredProcedure [dbo].[spSetSessionExpired]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spSetSessionExpired]
	@username varchar(100)
as
begin
	exec [Users].dbo.spSetSessionExpired @username = @username
end
GO
/****** Object:  Table [dbo].[Referrers]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Referrers](
	[ReferrerId] [int] IDENTITY(1,1) NOT NULL,
	[Referrer] [nvarchar](256) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastChange] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Referrers] PRIMARY KEY CLUSTERED 
(
	[ReferrerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_Referrers] UNIQUE NONCLUSTERED 
(
	[Referrer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationName] [nvarchar](50) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastChange] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ELMAH_LogError]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorXml]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorsXml]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	
	IF (@ExceptionType IS NOT NULL AND @ExceptionType <> '') AND @IncludeExceptionByType = 1
	BEGIN
		SET @showException = 1;
		SET @hideException = 0;
	END
	ELSE IF (@ExceptionType IS NOT NULL AND @ExceptionType <> '') AND @IncludeExceptionByType = 0
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
        AND (@goFurther = 0 OR ((@showException = 1 AND [Type] LIKE @ExceptionType + '%') OR (@hideException = 1 AND [Type] NOT LIKE @ExceptionType + '%')))

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
			(@goFurther = 0 OR ((@showException = 1 AND [Type] LIKE @ExceptionType + '%') OR (@hideException = 1 AND [Type] NOT LIKE @ExceptionType + '%')))
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
        time        = CONVERT(VARCHAR(50), [TimeUtc], 126) + 'Z'
    FROM 
        [ELMAH_Error] error
    WHERE
        [Application] = @Application
	AND 
		(@goFurther = 0 OR ((@showException = 1 AND [Type] LIKE @ExceptionType + '%') OR (@hideException = 1 AND [Type] NOT LIKE @ExceptionType + '%')))
    AND
        [TimeUtc] <= @FirstTimeUTC
    AND 
        [Sequence] <= @FirstSequence
    ORDER BY
        [TimeUtc] DESC, 
        [Sequence] DESC
    FOR
        XML AUTO
GO
/****** Object:  Table [dbo].[IPAddresses]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IPAddresses](
	[IPAddressId] [int] IDENTITY(1,1) NOT NULL,
	[IPAddress] [nvarchar](45) NOT NULL,
	[IsAdminIp] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[GeoLocationCountryId] [int] NULL,
	[LastChange] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_IPAddresses] PRIMARY KEY CLUSTERED 
(
	[IPAddressId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [UK_IPAddresses] UNIQUE NONCLUSTERED 
(
	[IPAddress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[Code] [nvarchar](2) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastChange] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Companies](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](500) NULL,
	[Phone] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[CountryId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastChange] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Permissions](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[PermissionName] [varchar](50) NOT NULL,
	[PermissionDescription] [varchar](500) NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastChange] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NOT NULL,
	[ApplicationId] [int] NOT NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[RoleDescription] [varchar](500) NULL,
	[IsDeleted] [bit] NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[LastChange] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_RoleName] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[spAdminReferrerUpdate]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminReferrerUpdate]
	@referrerId int,
	@referrer nvarchar(45)
as
begin
	update Referrers set
		Referrer = ISNULL(@referrer,Referrer)
	where ReferrerId = @referrerId
end
GO
/****** Object:  StoredProcedure [dbo].[spAdminReferrerInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminReferrerInsert]
	@referrer dbo.StringList readonly
as
begin
	declare @ref nvarchar(45)
	declare @ReferrerId int
	
	declare ref_cursor cursor for
	select string from @referrer
	open ref_cursor
	fetch next from ref_cursor into @ref

	while @@FETCH_STATUS = 0
	begin
		set @ReferrerId = (select ReferrerId from Referrers where Referrer = @ref)
		
		if @ReferrerId is not null
			update Referrers set
				IsDeleted = 0
			where ReferrerId = @ReferrerId
		else
			insert into Referrers (Referrer) values (@ref)
			
		fetch next from ref_cursor into @ref
	end
	
	close ref_cursor   
	deallocate ref_cursor
end
GO
/****** Object:  StoredProcedure [dbo].[spAdminReferrerDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminReferrerDelete]
	@referrerId int
as

begin

	update Referrers
	set IsDeleted = 1
	where ReferrerId = @referrerId

end
GO
/****** Object:  StoredProcedure [dbo].[spAdminIPAddressUpdate]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminIPAddressUpdate]
	@ipAddressId int,
	@ipAddress nvarchar(45)
as
begin
	update IPAddresses set
		IPAddress = ISNULL(@ipAddress,IPAddress)
	where IPAddressId = @ipAddressId
end
GO
/****** Object:  StoredProcedure [dbo].[spAdminIPAddressInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminIPAddressInsert]
	@ipAddress dbo.StringList readonly
as
begin
	declare @ip nvarchar(45)
	declare @ipAddressId int
	
	declare ip_cursor cursor for
	select string from @ipAddress
	open ip_cursor
	fetch next from ip_cursor into @ip

	while @@FETCH_STATUS = 0
	begin
		set @ipAddressId = (select IPAddressId from IPAddresses where IPAddress = @ip)
		
		if @ipAddressId is not null
			update IPAddresses set
				IsDeleted = 0
			where IPAddressId = @ipAddressId
		else
			insert into IPAddresses (IPAddress) values (@ip)
			
		fetch next from ip_cursor into @ip
	end
	
	close ip_cursor   
	deallocate ip_cursor
end
GO
/****** Object:  StoredProcedure [dbo].[spAdminIPAddressDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spAdminIPAddressDelete]
	@ipAddressId int
as

begin

	update IPAddresses
	set IsDeleted = 1
	where IPAddressId = @ipAddressId

end
GO
/****** Object:  Table [dbo].[Sites]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sites](
	[SiteId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Host] [nvarchar](50) NOT NULL,
	[ShadowUser] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
	[LastChange] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[RequireReferrerCheck] [bit] NOT NULL,
 CONSTRAINT [PK_Sites] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Sites] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vwCountries]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCountries]
AS
SELECT     CountryId, Name, Code
FROM         dbo.Countries
WHERE     (IsDeleted = 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Countries"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCountries'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCountries'
GO
/****** Object:  Trigger [TRG_Applications]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create      TRIGGER [dbo].[TRG_Applications]
ON [dbo].[Applications]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] 'Applications'


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = 'UPDATE'
		IF @INS = 1 AND @DEL = 0 SET @ACT = 'INSERT'
		IF @DEL = 1 AND @INS = 0 SET @ACT = 'DELETE'

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = 'INSERT' INSERT [DBO].[AUDIT_Applications] SELECT *,'INSERT' ,GETDATE() FROM INSERTED
		IF @ACT = 'DELETE' INSERT [DBO].[AUDIT_Applications] SELECT *,'DELETE' ,GETDATE() FROM DELETED
		IF @ACT = 'UPDATE' INSERT [DBO].[AUDIT_Applications] SELECT *,'UPDATE' ,GETDATE() FROM INSERTED
END
GO
/****** Object:  Trigger [TRG_IPAddresses]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[TRG_IPAddresses] on [dbo].[IPAddresses]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] 'IPAddresses'


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = 'UPDATE'
		IF @INS = 1 AND @DEL = 0 SET @ACT = 'INSERT'
		IF @DEL = 1 AND @INS = 0 SET @ACT = 'DELETE'

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = 'INSERT' INSERT [DBO].[AUDIT_IPAddresses] SELECT *,'INSERT' ,GETDATE() FROM INSERTED
		IF @ACT = 'DELETE' INSERT [DBO].[AUDIT_IPAddresses] SELECT *,'DELETE' ,GETDATE() FROM DELETED
		IF @ACT = 'UPDATE' INSERT [DBO].[AUDIT_IPAddresses] SELECT *,'UPDATE' ,GETDATE() FROM INSERTED
END
GO
/****** Object:  Trigger [TRG_Countries]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create      TRIGGER [dbo].[TRG_Countries]
ON [dbo].[Countries]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] 'Countries'


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = 'UPDATE'
		IF @INS = 1 AND @DEL = 0 SET @ACT = 'INSERT'
		IF @DEL = 1 AND @INS = 0 SET @ACT = 'DELETE'

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = 'INSERT' INSERT [DBO].[AUDIT_Countries] SELECT *,'INSERT' ,GETDATE() FROM INSERTED
		IF @ACT = 'DELETE' INSERT [DBO].[AUDIT_Countries] SELECT *,'DELETE' ,GETDATE() FROM DELETED
		IF @ACT = 'UPDATE' INSERT [DBO].[AUDIT_Countries] SELECT *,'UPDATE' ,GETDATE() FROM INSERTED
END
GO
/****** Object:  Trigger [TRG_Referrers]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[TRG_Referrers] on [dbo].[Referrers]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] 'Referrers'


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = 'UPDATE'
		IF @INS = 1 AND @DEL = 0 SET @ACT = 'INSERT'
		IF @DEL = 1 AND @INS = 0 SET @ACT = 'DELETE'

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = 'INSERT' INSERT [DBO].[AUDIT_Referrers] SELECT *,'INSERT' ,GETDATE() FROM INSERTED
		IF @ACT = 'DELETE' INSERT [DBO].[AUDIT_Referrers] SELECT *,'DELETE' ,GETDATE() FROM DELETED
		IF @ACT = 'UPDATE' INSERT [DBO].[AUDIT_Referrers] SELECT *,'UPDATE' ,GETDATE() FROM INSERTED
END
GO
/****** Object:  View [dbo].[vwIPAddresses]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwIPAddresses]
AS
SELECT     dbo.IPAddresses.IPAddressId, dbo.IPAddresses.IPAddress, dbo.IPAddresses.IsAdminIp, dbo.IPAddresses.GeoLocationCountryId, dbo.Countries.Name AS Country
FROM         dbo.Countries RIGHT OUTER JOIN
                      dbo.IPAddresses ON dbo.Countries.CountryId = dbo.IPAddresses.GeoLocationCountryId
WHERE     (dbo.IPAddresses.IsDeleted = 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Countries"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 200
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "IPAddresses"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 201
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2205
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwIPAddresses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwIPAddresses'
GO
/****** Object:  View [dbo].[vwReferrers]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwReferrers]
AS
SELECT     ReferrerId, Referrer, IsDeleted
FROM         dbo.Referrers
WHERE     (IsDeleted = 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Referrers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 246
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwReferrers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwReferrers'
GO
/****** Object:  View [dbo].[vwRoles]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwRoles]
AS
SELECT     RoleId, RoleName, RoleDescription, ApplicationId
FROM         dbo.Roles
WHERE     (IsDeleted = 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Roles"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 223
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1560
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwRoles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwRoles'
GO
/****** Object:  View [dbo].[vwSites]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSites]
AS
SELECT     SiteId, Name, Host, ShadowUser, ApplicationId, RequireReferrerCheck
FROM         dbo.Sites
WHERE     (IsDeleted = 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Sites"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 270
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSites'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSites'
GO
/****** Object:  View [dbo].[vwPermissions]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwPermissions]
AS
SELECT     PermissionId, PermissionName, PermissionDescription, ApplicationId
FROM         dbo.Permissions
WHERE     (IsDeleted = 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Permissions"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 203
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwPermissions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwPermissions'
GO
/****** Object:  Trigger [TRG_Sites]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[TRG_Sites] on [dbo].[Sites]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] 'Sites'


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = 'UPDATE'
		IF @INS = 1 AND @DEL = 0 SET @ACT = 'INSERT'
		IF @DEL = 1 AND @INS = 0 SET @ACT = 'DELETE'

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = 'INSERT' INSERT [DBO].[AUDIT_Sites] SELECT *,'INSERT' ,GETDATE() FROM INSERTED
		IF @ACT = 'DELETE' INSERT [DBO].[AUDIT_Sites] SELECT *,'DELETE' ,GETDATE() FROM DELETED
		IF @ACT = 'UPDATE' INSERT [DBO].[AUDIT_Sites] SELECT *,'UPDATE' ,GETDATE() FROM INSERTED
END
GO
/****** Object:  Trigger [TRG_Roles]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create      TRIGGER [dbo].[TRG_Roles]
ON [dbo].[Roles]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] 'Roles'


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = 'UPDATE'
		IF @INS = 1 AND @DEL = 0 SET @ACT = 'INSERT'
		IF @DEL = 1 AND @INS = 0 SET @ACT = 'DELETE'

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = 'INSERT' INSERT [DBO].[AUDIT_Roles] SELECT *,'INSERT' ,GETDATE() FROM INSERTED
		IF @ACT = 'DELETE' INSERT [DBO].[AUDIT_Roles] SELECT *,'DELETE' ,GETDATE() FROM DELETED
		IF @ACT = 'UPDATE' INSERT [DBO].[AUDIT_Roles] SELECT *,'UPDATE' ,GETDATE() FROM INSERTED
END
GO
/****** Object:  Trigger [TRG_Permissions]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create      TRIGGER [dbo].[TRG_Permissions]
ON [dbo].[Permissions]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] 'Permissions'


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = 'UPDATE'
		IF @INS = 1 AND @DEL = 0 SET @ACT = 'INSERT'
		IF @DEL = 1 AND @INS = 0 SET @ACT = 'DELETE'

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = 'INSERT' INSERT [DBO].[AUDIT_Permissions] SELECT *,'INSERT' ,GETDATE() FROM INSERTED
		IF @ACT = 'DELETE' INSERT [DBO].[AUDIT_Permissions] SELECT *,'DELETE' ,GETDATE() FROM DELETED
		IF @ACT = 'UPDATE' INSERT [DBO].[AUDIT_Permissions] SELECT *,'UPDATE' ,GETDATE() FROM INSERTED
END
GO
/****** Object:  Trigger [TRG_Companies]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create      TRIGGER [dbo].[TRG_Companies]
ON [dbo].[Companies]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] 'Companies'


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = 'UPDATE'
		IF @INS = 1 AND @DEL = 0 SET @ACT = 'INSERT'
		IF @DEL = 1 AND @INS = 0 SET @ACT = 'DELETE'

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = 'INSERT' INSERT [DBO].[AUDIT_Companies] SELECT *,'INSERT' ,GETDATE() FROM INSERTED
		IF @ACT = 'DELETE' INSERT [DBO].[AUDIT_Companies] SELECT *,'DELETE' ,GETDATE() FROM DELETED
		IF @ACT = 'UPDATE' INSERT [DBO].[AUDIT_Companies] SELECT *,'UPDATE' ,GETDATE() FROM INSERTED
END
GO
/****** Object:  View [dbo].[vwCompanies]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCompanies]
AS
SELECT     dbo.Companies.CompanyId, dbo.Companies.Name, dbo.Companies.Address, dbo.Companies.Phone, dbo.Companies.Fax, dbo.Companies.CountryId, dbo.Countries.Name AS Country
FROM         dbo.Companies INNER JOIN
                      dbo.Countries ON dbo.Companies.CountryId = dbo.Countries.CountryId
WHERE     (dbo.Companies.IsDeleted = 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Companies"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 227
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Countries"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 174
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCompanies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCompanies'
GO
/****** Object:  Table [dbo].[Users]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[Firstname] [nvarchar](100) NULL,
	[Lastname] [nvarchar](100) NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [varbinary](300) NULL,
	[IsDeleted] [bit] NOT NULL,
	[SessionId] [uniqueidentifier] NULL,
	[FailedAttemptsCnt] [int] NULL,
	[LastAttempt] [datetime] NULL,
	[LastChange] [datetime] NOT NULL,
	[ChangedBy] [varchar](50) NOT NULL,
	[AccountExpirationDate] [datetime] NULL,
    [ExportedCompanyId] [int] NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Members] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SiteReferrer]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteReferrer](
	[SiteId] [int] NOT NULL,
	[ReferrerId] [int] NOT NULL,
 CONSTRAINT [PK_SiteReferrer] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[ReferrerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SiteIPAddress]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteIPAddress](
	[SiteId] [int] NOT NULL,
	[IPAddressId] [int] NOT NULL,
 CONSTRAINT [PK_SiteIpAddress] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[IPAddressId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermission]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermission](
	[RoleId] [int] NOT NULL,
	[PermissionId] [int] NOT NULL,
 CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spRoleUpdate]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spRoleUpdate]
	@roleId int,
	@roleName nvarchar(50),
	@appId int,
	@roleDescription nvarchar(500)
as
begin

	update Roles set
		RoleName = ISNULL(@roleName,RoleName),
		ApplicationId = ISNULL(@appId,ApplicationId),
		RoleDescription = ISNULL(@roleDescription,RoleDescription)
	where RoleId = @roleId

end
GO
/****** Object:  StoredProcedure [dbo].[spRoleInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spRoleInsert]
	@roleName nvarchar(50),
	@appId int,
	@roleDescription nvarchar(500)
as

begin

	declare @rId int
	set @rId = (select RoleId from Roles where roleName = @roleName)
	
	if @rId is not null
		update Roles set 
			IsDeleted = 0
		where RoleId = @rId
	else
		insert into Roles (RoleName, RoleDescription, ApplicationId)
		values (@roleName, @roleDescription, @appId)
		
end
GO
/****** Object:  StoredProcedure [dbo].[spRoleDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spRoleDelete]
	@roleId int
as

begin

	update Roles set IsDeleted = 1 where RoleId = @roleId;

end
GO
/****** Object:  StoredProcedure [dbo].[spCompanyUpdate]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spCompanyUpdate]
	@companyId int,
	@name nvarchar(100) = null,
	@phone nvarchar(50),
	@fax nvarchar(50),
	@address nvarchar(500),
	@countryId int
as
begin

	update Companies set
		Name = ISNULL(@name,Name),
		Address = ISNULL(@address,Address),
		Phone = ISNULL(@phone,Phone),
		Fax = ISNULL(@fax,Fax),
		CountryId = ISNULL(@countryId,CountryId)
	where CompanyId = @companyId

end
GO
/****** Object:  StoredProcedure [dbo].[spCompanyInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spCompanyInsert]
	@name nvarchar(100),
	@phone nvarchar(50) = null,
	@fax nvarchar(50) = null,
	@address nvarchar(500) = null,
	@countryId int
as

begin

	declare @сId int
	set @сId = (select CompanyId from Companies where Phone = @phone)
	
	if @сId is not null
		update Companies set 
			IsDeleted = 0
		where CompanyId = @сId
	else
		insert into Companies (Name, Address, Phone, Fax, CountryId)
		values (@name, @address, @phone, @fax, @countryId)
		
end
GO
/****** Object:  StoredProcedure [dbo].[spCompanyDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spCompanyDelete]
	@companyId int
as

begin

	update Companies set IsDeleted = 1 where CompanyId = @companyId

end
GO
/****** Object:  StoredProcedure [dbo].[spAdminSiteUpdate]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminSiteUpdate]
	@siteId int,
	@name nvarchar(50),
	@appId int,
	@host nvarchar(50) = null,
	@shadowUser nvarchar(50) = null,
	@requireReferrerCheck bit = 0
as

begin

	update Sites set
		name = ISNULL(@name,name),
		host = ISNULL(@host,host),
		ApplicationId = ISNULL(@appId,ApplicationId),
		shadowUser = ISNULL(@shadowUser,shadowUser),
		RequireReferrerCheck = ISNULL(@requireReferrerCheck,RequireReferrerCheck)
	where SiteId = @siteId

end
GO
/****** Object:  StoredProcedure [dbo].[spAdminSiteInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminSiteInsert]
	@name nvarchar(50),
	@appId int,
	@host nvarchar(50) = null,
	@shadowUser nvarchar(50) = null,
	@requireReferrerCheck bit = 0
as

begin
	
	declare @siteId int
	set @siteId = (select SiteId from Sites where Name = @name)
	
	if @siteId is not null
		update Sites set 
			IsDeleted = 0
		where SiteId = @siteId
	else
		insert into Sites (Name, Host, ShadowUser, ApplicationId, RequireReferrerCheck) values (@name, @host, @shadowUser, @appId, @requireReferrerCheck)

end
GO
/****** Object:  StoredProcedure [dbo].[spAdminSiteDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminSiteDelete]
	@siteId int
as

begin

	update Sites set IsDeleted = 1 where SiteId = @siteId

end
GO
/****** Object:  Table [dbo].[History]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[HistoryId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Username] [nvarchar](50) NULL,
	[TimestampUtc] [datetime] NOT NULL,
	[Action] [nvarchar](50) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[ApplicationId] [int] NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[HistoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spAdminSiteAddressInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminSiteAddressInsert]
	@siteId int,
	@ipAddressesIds dbo.NumberList readonly
as

begin
	delete from SiteIPAddress
	where SiteId = @siteId

	insert into SiteIPAddress (SiteId, IPAddressId)
	select @siteId, number
	from @ipAddressesIds
end
GO
/****** Object:  StoredProcedure [dbo].[spAdminSiteAddressDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spAdminSiteAddressDelete]
	@siteId int,
	@ipAddressId int
as

begin

	delete from SiteIPAddress
	where SiteId = @siteId and IPAddressId = @ipAddressId

end
GO
/****** Object:  StoredProcedure [dbo].[spAdminSiteReferrerInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spAdminSiteReferrerInsert]
	@siteId int,
	@referrerIds dbo.NumberList readonly
as

begin
	delete from SiteReferrer
	where SiteId = @siteId

	insert into SiteReferrer (SiteId, ReferrerId)
	select @siteId, number
	from @referrerIds
end
GO
/****** Object:  StoredProcedure [dbo].[spAdminSiteReferrerDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spAdminSiteReferrerDelete]
	@siteId int,
	@referrerId int
as

begin

	delete from SiteReferrer
	where SiteId = @siteId and ReferrerId = @referrerId

end
GO
/****** Object:  StoredProcedure [dbo].[spAuthorizeUser]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spAuthorizeUser]
(
	@username varchar(50),
	@applicationId varchar(50),
	@isAllowed bit OUT
)
as
begin
	set @isAllowed = (
		select count(*) userId 
		from Users u, UserApplication a
		where u.UserId = a.UserId
			and u.username = @username 
			and a.ApplicationId = @applicationId
	)
end
GO
/****** Object:  StoredProcedure [dbo].[spIsAllowedIpAddress]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spIsAllowedIpAddress]
(
	@ipAddress varchar(45),
	@siteId int,
	@isAdminIp bit,
	@isValid bit OUT
)
as
begin
	if (select
		case 
			when @isAdminIp = 1 then
				(select count (*)
					from [IPAddresses] a join [SiteIPAddress] s on a.IPAddressId = s.IPAddressId
					where s.SiteId = @siteId and a.IsDeleted = 0 and IsAdminIp = @isAdminIp 
					and dbo.fnIsIpaddressInSubnetShortHand(IPAddress, @ipAddress) = 1)
			else
				(select count (*)
					from [IPAddresses] a join [SiteIPAddress] s on a.IPAddressId = s.IPAddressId
					where s.SiteId = @siteId and a.IsDeleted = 0
					and dbo.fnIsIpaddressInSubnetShortHand(IPAddress, @ipAddress) = 1)
		end) > 0

		set @isValid = 1
	else 
		set @isValid = 0
end
GO
/****** Object:  StoredProcedure [dbo].[spRolePermissionInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spRolePermissionInsert]
	@permissionId int,
	@roleId int
as

begin

	insert into RolePermission (PermissionId, RoleId)
	values (@permissionId, @roleId)

end
GO
/****** Object:  StoredProcedure [dbo].[spRolePermissionDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spRolePermissionDelete]
	@permissionId int,
	@roleId int
as

begin

	delete from RolePermission
	where PermissionId = @permissionId and RoleId = @roleId

end
GO
/****** Object:  StoredProcedure [dbo].[spUserUpdate]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spUserUpdate]
	@userId int,
	@companyId int = null,
	@firstName nvarchar(100) = null,
	@lastName nvarchar(100) = null,
	@userName nvarchar(50) = null,
	@password nvarchar(100) = null,
	@accountExpirationDate datetime = null,
	@exportedCompanyId int = null
as

begin

	exec spOpenPasswordsKey;
	
	declare @pwdEncrypted varbinary(300) = null

	if @password is not null
	begin
		set @pwdEncrypted = dbo.EncryptPassword(@password, @userId);
	end

	update Users set
		CompanyId = ISNULL(@companyId,CompanyId),
		ExportedCompanyId = ISNULL(@exportedCompanyId,ExportedCompanyId),
		Firstname = ISNULL(@firstName,Firstname),
		Lastname = ISNULL(@lastName,Lastname),
		Username = ISNULL(@userName,Username),
		AccountExpirationDate = ISNULL(@AccountExpirationDate,AccountExpirationDate),
		[Password] = ISNULL(@pwdEncrypted,[Password])
	where UserId = @userId

	exec spClosePasswordsKey;

end
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[spUserDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spUserDelete]
	@userId int
as

begin

	update Users set IsDeleted = 1 where UserId = @userId;

end
GO
/****** Object:  StoredProcedure [dbo].[spUserInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spUserInsert]
	@companyId int,
	@firstName nvarchar(100) = null,
	@lastName nvarchar(100) = null,
	@userName nvarchar(50),
	@password nvarchar(100),
	@accountExpirationDate datetime = null,
	@exportedCompanyId int = null
as

begin
	begin try
		begin tran myTran
		
		declare @uId int
		set @uId = (select UserId from Users where Username = @userName)
	
		if @uId is not null
			update Users set IsDeleted = 0 where UserId = @uId
		else
		begin
			exec spOpenPasswordsKey;

			declare @mid table (Id int);
			declare @userId int;

			insert into Users (CompanyId, Firstname, Lastname, Username, AccountExpirationDate, ExportedCompanyId)
			output inserted.UserId into @mid
			values (@companyId, @firstName, @lastName, @userName, @accountExpirationDate, @exportedCompanyId)

			set @userId = (select top 1 Id from @mid)
			update Users set Password = dbo.EncryptPassword(@password, @userId)
			where UserId = @userId

			exec spClosePasswordsKey;
		end
		commit tran myTran;
	end try
	begin catch
		rollback tran myTran;
		select 
			ERROR_NUMBER() AS ErrorNumber
		   ,ERROR_MESSAGE() AS ErrorMessage;
	end catch	
end
GO
/****** Object:  Trigger [TRG_Users]    Script Date: 09/30/2016 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create      TRIGGER [dbo].[TRG_Users]
ON [dbo].[Users]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] 'Users'


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = 'UPDATE'
		IF @INS = 1 AND @DEL = 0 SET @ACT = 'INSERT'
		IF @DEL = 1 AND @INS = 0 SET @ACT = 'DELETE'

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = 'INSERT' INSERT [DBO].[AUDIT_Users] SELECT *,'INSERT' ,GETDATE() FROM INSERTED
		IF @ACT = 'DELETE' INSERT [DBO].[AUDIT_Users] SELECT *,'DELETE' ,GETDATE() FROM DELETED
		IF @ACT = 'UPDATE' INSERT [DBO].[AUDIT_Users] SELECT *,'UPDATE' ,GETDATE() FROM INSERTED
END
GO
/****** Object:  View [dbo].[vwSiteReferrer]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSiteReferrer]
AS
SELECT     dbo.SiteReferrer.SiteId, dbo.SiteReferrer.ReferrerId, dbo.Referrers.Referrer, dbo.Sites.Name, dbo.Sites.ApplicationId
FROM         dbo.Referrers INNER JOIN
                      dbo.SiteReferrer ON dbo.Referrers.ReferrerId = dbo.SiteReferrer.ReferrerId INNER JOIN
                      dbo.Sites ON dbo.SiteReferrer.SiteId = dbo.Sites.SiteId
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Referrers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 215
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SiteReferrer"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 136
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Sites"
            Begin Extent = 
               Top = 6
               Left = 434
               Bottom = 201
               Right = 594
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSiteReferrer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSiteReferrer'
GO
/****** Object:  View [dbo].[vwSiteIPAddress]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSiteIPAddress]
AS
SELECT     dbo.SiteIPAddress.SiteId, dbo.Sites.Name, dbo.SiteIPAddress.IPAddressId, dbo.IPAddresses.IPAddress, dbo.Sites.ApplicationId
FROM         dbo.IPAddresses INNER JOIN
                      dbo.SiteIPAddress ON dbo.IPAddresses.IPAddressId = dbo.SiteIPAddress.IPAddressId INNER JOIN
                      dbo.Sites ON dbo.SiteIPAddress.SiteId = dbo.Sites.SiteId
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "IPAddresses"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 202
               Right = 235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SiteIPAddress"
            Begin Extent = 
               Top = 6
               Left = 273
               Bottom = 96
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Sites"
            Begin Extent = 
               Top = 6
               Left = 471
               Bottom = 214
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSiteIPAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSiteIPAddress'
GO
/****** Object:  View [dbo].[vwRolePermission]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwRolePermission]
AS
SELECT     dbo.RolePermission.RoleId, dbo.Roles.RoleName, dbo.RolePermission.PermissionId, dbo.Permissions.PermissionName, dbo.Roles.ApplicationId
FROM         dbo.Permissions INNER JOIN
                      dbo.RolePermission ON dbo.Permissions.PermissionId = dbo.RolePermission.PermissionId INNER JOIN
                      dbo.Roles ON dbo.RolePermission.RoleId = dbo.Roles.RoleId
WHERE     (dbo.Roles.IsDeleted = 0) AND (dbo.Permissions.IsDeleted = 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Permissions"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 156
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RolePermission"
            Begin Extent = 
               Top = 6
               Left = 268
               Bottom = 128
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Roles"
            Begin Extent = 
               Top = 6
               Left = 466
               Bottom = 198
               Right = 629
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwRolePermission'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwRolePermission'
GO
/****** Object:  View [dbo].[vwUsers]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwUsers]
AS
SELECT     dbo.Users.UserId, dbo.Users.CompanyId, dbo.Companies.Name AS Company, dbo.Users.Firstname, dbo.Users.Lastname, dbo.Users.Username, dbo.DecryptPassword(dbo.Users.Password, 
                      dbo.Users.UserId) AS Password, dbo.Users.Firstname + ' ' + dbo.Users.Lastname + ' (' + dbo.Users.Username + ')' AS Fullname, dbo.Users.AccountExpirationDate, 
                      dbo.Users.ExportedCompanyId
FROM         dbo.Companies INNER JOIN
                      dbo.Users ON dbo.Companies.CompanyId = dbo.Users.CompanyId
WHERE     (dbo.Users.IsDeleted = 0)

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[35] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Companies"
            Begin Extent = 
               Top = 55
               Left = 324
               Bottom = 220
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 241
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3375
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5835
         Alias = 1155
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUsers'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUsers'
GO
/****** Object:  View [dbo].[vwUserRole]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwUserRole]
AS
SELECT     dbo.Roles.RoleId, dbo.Roles.RoleName, dbo.vwUsers.UserId, dbo.vwUsers.Fullname, dbo.Roles.ApplicationId
FROM         dbo.Roles INNER JOIN
                      dbo.UserRole ON dbo.Roles.RoleId = dbo.UserRole.RoleId INNER JOIN
                      dbo.vwUsers ON dbo.UserRole.UserId = dbo.vwUsers.UserId
WHERE     (dbo.Roles.IsDeleted = 0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Roles"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 234
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UserRole"
            Begin Extent = 
               Top = 108
               Left = 279
               Bottom = 198
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwUsers"
            Begin Extent = 
               Top = 6
               Left = 486
               Bottom = 237
               Right = 646
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUserRole'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUserRole'
GO
/****** Object:  View [dbo].[vwHistory]    Script Date: 09/30/2016 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwHistory]
AS
SELECT     dbo.Companies.Name, dbo.Users.Firstname, dbo.Users.Lastname, dbo.History.Username, dbo.History.Action, dbo.History.TimestampUtc, dbo.History.Message, dbo.History.ApplicationId
FROM         dbo.Companies INNER JOIN
                      dbo.Users ON dbo.Companies.CompanyId = dbo.Users.CompanyId RIGHT OUTER JOIN
                      dbo.History ON dbo.Users.UserId = dbo.History.UserId
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Companies"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 214
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 257
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "History"
            Begin Extent = 
               Top = 44
               Left = 731
               Bottom = 233
               Right = 891
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwHistory'
GO
/****** Object:  StoredProcedure [dbo].[spUserDetails]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spUserDetails]
	@username nvarchar(50)
as
begin
	exec spOpenPasswordsKey;
	select * from vwUsers where Username = @username
end
GO
/****** Object:  StoredProcedure [dbo].[spUserRoleInsert]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spUserRoleInsert]
	@userId int,
	@roleId int
as

begin

	insert into UserRole (UserId, RoleId)
	values (@userId, @roleId)

end
GO
/****** Object:  StoredProcedure [dbo].[spUserRoleDelete]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spUserRoleDelete]
	@userId int,
	@roleId int
as

begin

	delete from UserRole
	where UserId = @userId and RoleId = @roleId

end
GO
/****** Object:  StoredProcedure [dbo].[spAuthenticateUser]    Script Date: 09/30/2016 14:10:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	@password stands for varbinary string, which is to be decrypted with PasswordsKey symmetric key,
	@id stands for some value, commonly the primary key value of the row the password stored in, and used as a parameter of DecryptByKey function - @authenticator.
*/
CREATE procedure [dbo].[spAuthenticateUser]
(
	@username varchar(50),
	@password varchar(50),
	@checkIp bit,
	@ipAddress varchar(45),
	@host varchar(128),
	@userId int OUT,
	@isValid bit OUT,
	@retVal int OUT
)
as
begin
	set @isValid = 1;
	
	if @checkIp = 0 goto AUTH;
	
	declare @siteId int;
	set @siteId = (
		select SiteId 
		from [Sites] 
		where Host = @host COLLATE SQL_Latin1_General_CP1_CS_AS);
	
	if (@siteId is null)
	begin
		set @isValid = 0
		set @retVal = -1; -- invalid host
		return;
	end

	if exists (
		select dbo.fnIsIpaddressInSubnetShortHand(IPAddress, @ipAddress)
		from (
			-- select allowed ip ranges for the particular site
			select IPAddress 
			from [IPAddresses] a join [SiteIPAddress] s on a.IPAddressId = s.IPAddressId
			where s.SiteId = @siteId and a.IsDeleted = 0) ranges
		where dbo.fnIsIpaddressInSubnetShortHand(IPAddress, @ipAddress) = 1)

		set @isValid = 1
	else 
	begin
		set @retVal = -2; -- invalid IP
		set @isValid = 0
	end

	AUTH:
	
	set @userId = (
		select top 1 userId 
		from vwUsers 
		where username = @username
	)

	-- open key to decrypt password
	OPEN SYMMETRIC KEY PasswordsKey DECRYPTION BY CERTIFICATE UsersCert;
	
	if @userId is not null
	begin
		if @isValid <> 0
			select 
				@isValid = case [password] when @password COLLATE SQL_Latin1_General_CP1_CS_AS then 1 else 0 end,
				@retVal = case @isValid when 1 then 0 else -4 end -- invalid password
			from vwUsers 
			where UserId = @userId
		
		if @isValid = 0
			update Users set 
				FailedAttemptsCnt = isnull(FailedAttemptsCnt, 0) + 1,
				LastAttempt = getdate()
			where UserId = @userId
	end	
	else 
	begin
		set @retVal = -3; -- invalid username
		set @isValid = 0
	end
	
	-- close key			
	CLOSE SYMMETRIC KEY PasswordsKey;	
end
GO
/****** Object:  Default [DF_Applications_IsDeleted]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Applications_LastChange]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_LastChange]  DEFAULT (getdate()) FOR [LastChange]
GO
/****** Object:  Default [DF_Applications_ChangedBy]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_ChangedBy]  DEFAULT (suser_name()) FOR [ChangedBy]
GO
/****** Object:  Default [DF_Companies_IsDeleted]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF_Companies_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF__Companies__LastC__656C112C]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF__Companies__LastC__656C112C]  DEFAULT (getdate()) FOR [LastChange]
GO
/****** Object:  Default [DF__Companies__Chang__66603565]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF__Companies__Chang__66603565]  DEFAULT (suser_name()) FOR [ChangedBy]
GO
/****** Object:  Default [DF_Countries_IsDeleted]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Countries] ADD  CONSTRAINT [DF_Countries_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF__Countries__LastC__68487DD7]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Countries] ADD  DEFAULT (getdate()) FOR [LastChange]
GO
/****** Object:  Default [DF__Countries__Chang__693CA210]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Countries] ADD  DEFAULT (suser_name()) FOR [ChangedBy]
GO
/****** Object:  Default [DF_ELMAH_Error_ErrorId]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[ELMAH_Error] ADD  CONSTRAINT [DF_ELMAH_Error_ErrorId]  DEFAULT (newid()) FOR [ErrorId]
GO
/****** Object:  Default [DF_History_TimestampUtc]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[History] ADD  CONSTRAINT [DF_History_TimestampUtc]  DEFAULT (getutcdate()) FOR [TimestampUtc]
GO
/****** Object:  Default [DF_IPAddresses_IsAdminIp]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[IPAddresses] ADD  CONSTRAINT [DF_IPAddresses_IsAdminIp]  DEFAULT ((0)) FOR [IsAdminIp]
GO
/****** Object:  Default [DF__IPAddress__IsDel__6D5F6EE7]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[IPAddresses] ADD  CONSTRAINT [DF__IPAddress__IsDel__6D5F6EE7]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF__IPAddress__LastC__6E01572D]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[IPAddresses] ADD  DEFAULT (getdate()) FOR [LastChange]
GO
/****** Object:  Default [DF__IPAddress__Chang__6EF57B66]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[IPAddresses] ADD  DEFAULT (suser_name()) FOR [ChangedBy]
GO
/****** Object:  Default [DF_Permissions_IsDeleted]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF_Permissions_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF__Permissio__LastC__40F9A68C]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF__Permissio__LastC__40F9A68C]  DEFAULT (getdate()) FOR [LastChange]
GO
/****** Object:  Default [DF__Permissio__Chang__41EDCAC5]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF__Permissio__Chang__41EDCAC5]  DEFAULT (suser_name()) FOR [ChangedBy]
GO
/****** Object:  Default [DF__Referrer__IsDel__6D5F6EE7]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Referrers] ADD  CONSTRAINT [DF__Referrer__IsDel__6D5F6EE7]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF__Referrers__LastC__73BA3083]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Referrers] ADD  DEFAULT (getdate()) FOR [LastChange]
GO
/****** Object:  Default [DF__Referrers__Chang__74AE54BC]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Referrers] ADD  DEFAULT (suser_name()) FOR [ChangedBy]
GO
/****** Object:  Default [DF_Roles_IsDeleted]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Roles_LastChange]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_LastChange]  DEFAULT (getdate()) FOR [LastChange]
GO
/****** Object:  Default [DF_Roles_ChangedBy]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_ChangedBy]  DEFAULT (suser_name()) FOR [ChangedBy]
GO
/****** Object:  Default [DF_Sites_IsDeleted]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Sites] ADD  CONSTRAINT [DF_Sites_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF__Sites__LastChang__42E1EEFE]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Sites] ADD  CONSTRAINT [DF__Sites__LastChang__42E1EEFE]  DEFAULT (getdate()) FOR [LastChange]
GO
/****** Object:  Default [DF__Sites__ChangedBy__43D61337]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Sites] ADD  CONSTRAINT [DF__Sites__ChangedBy__43D61337]  DEFAULT (suser_name()) FOR [ChangedBy]
GO
/****** Object:  Default [DF_Sites_CheckReferrer]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Sites] ADD  CONSTRAINT [DF_Sites_CheckReferrer]  DEFAULT ((0)) FOR [RequireReferrerCheck]
GO
/****** Object:  Default [DF_Users_IsDeleted]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF__Users__LastChang__7D439ABD]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__LastChang__7D439ABD]  DEFAULT (getdate()) FOR [LastChange]
GO
/****** Object:  Default [DF__Users__ChangedBy__7E37BEF6]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__ChangedBy__7E37BEF6]  DEFAULT (suser_name()) FOR [ChangedBy]
GO
/****** Object:  ForeignKey [FK_Companies_Countries]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_Countries]
GO
/****** Object:  ForeignKey [FK_History_Applications]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Applications] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Applications]
GO
/****** Object:  ForeignKey [FK_History_Users]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Users]
GO
/****** Object:  ForeignKey [FK_Permissions_Applications]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_Applications] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_Applications]
GO
/****** Object:  ForeignKey [FK_RolePermission_Permissions]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_RolePermission_Permissions] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[Permissions] ([PermissionId])
GO
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Permissions]
GO
/****** Object:  ForeignKey [FK_RolePermission_Roles]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_RolePermission_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Roles]
GO
/****** Object:  ForeignKey [FK_Roles_Applications]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [FK_Roles_Applications] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [FK_Roles_Applications]
GO
/****** Object:  ForeignKey [FK_SiteIPAddress_IPAddresses]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[SiteIPAddress]  WITH CHECK ADD  CONSTRAINT [FK_SiteIPAddress_IPAddresses] FOREIGN KEY([IPAddressId])
REFERENCES [dbo].[IPAddresses] ([IPAddressId])
GO
ALTER TABLE [dbo].[SiteIPAddress] CHECK CONSTRAINT [FK_SiteIPAddress_IPAddresses]
GO
/****** Object:  ForeignKey [FK_SiteIPAddress_Sites]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[SiteIPAddress]  WITH CHECK ADD  CONSTRAINT [FK_SiteIPAddress_Sites] FOREIGN KEY([SiteId])
REFERENCES [dbo].[Sites] ([SiteId])
GO
ALTER TABLE [dbo].[SiteIPAddress] CHECK CONSTRAINT [FK_SiteIPAddress_Sites]
GO
/****** Object:  ForeignKey [FK_SiteReferrer_Referrers]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[SiteReferrer]  WITH CHECK ADD  CONSTRAINT [FK_SiteReferrer_Referrers] FOREIGN KEY([ReferrerId])
REFERENCES [dbo].[Referrers] ([ReferrerId])
GO
ALTER TABLE [dbo].[SiteReferrer] CHECK CONSTRAINT [FK_SiteReferrer_Referrers]
GO
/****** Object:  ForeignKey [FK_SiteReferrer_Sites]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[SiteReferrer]  WITH CHECK ADD  CONSTRAINT [FK_SiteReferrer_Sites] FOREIGN KEY([SiteId])
REFERENCES [dbo].[Sites] ([SiteId])
GO
ALTER TABLE [dbo].[SiteReferrer] CHECK CONSTRAINT [FK_SiteReferrer_Sites]
GO
/****** Object:  ForeignKey [FK_Sites_Applications]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [FK_Sites_Applications] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [FK_Sites_Applications]
GO
/****** Object:  ForeignKey [FK_UserRole_Roles]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Roles]
GO
/****** Object:  ForeignKey [FK_UserRole_Users]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Users]
GO
/****** Object:  ForeignKey [FK_Users_Companies]    Script Date: 09/30/2016 14:10:50 ******/
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Companies] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([CompanyId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Companies]
GO
