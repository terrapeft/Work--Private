USE [TRADEdataUsers]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Companies_Countries]') AND parent_object_id = OBJECT_ID(N'[dbo].[Companies]'))
ALTER TABLE [dbo].[Companies] DROP CONSTRAINT [FK_Companies_Countries]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_History_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[History]'))
ALTER TABLE [dbo].[History] DROP CONSTRAINT [FK_History_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Permissions]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [FK_RolePermission_Permissions]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [FK_RolePermission_Roles]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_UserRole_Roles]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_UserRole_Users]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Users_Companies]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_Users_Companies]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAuthenticateUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAuthenticateUser]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserRoleDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spUserRoleDelete]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserRoleInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spUserRoleInsert]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwHistory]'))
DROP VIEW [dbo].[vwHistory]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwUserRole]'))
DROP VIEW [dbo].[vwUserRole]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwUsers]'))
DROP VIEW [dbo].[vwUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spUserUpdate]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_UserRole_Roles]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_UserRole_Users]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRole]') AND type in (N'U'))
DROP TABLE [dbo].[UserRole]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAuthorizeUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spAuthorizeUser]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_History_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[History]'))
ALTER TABLE [dbo].[History] DROP CONSTRAINT [FK_History_Users]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_History_TimestampUtc]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[History] DROP CONSTRAINT [DF_History_TimestampUtc]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[History]') AND type in (N'U'))
DROP TABLE [dbo].[History]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spUserDelete]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spUserInsert]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRolePermissionDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRolePermissionDelete]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRolePermissionInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRolePermissionInsert]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCompanyDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spCompanyDelete]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCompanyInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spCompanyInsert]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCompanyUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spCompanyUpdate]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Users_Companies]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_Users_Companies]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Users_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [DF_Users_IsDeleted]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
DROP TABLE [dbo].[Users]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCompanies]'))
DROP VIEW [dbo].[vwCompanies]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwRolePermission]'))
DROP VIEW [dbo].[vwRolePermission]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwRoles]'))
DROP VIEW [dbo].[vwRoles]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwPermissions]'))
DROP VIEW [dbo].[vwPermissions]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCountries]'))
DROP VIEW [dbo].[vwCountries]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRoleUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRoleUpdate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRoleDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRoleDelete]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRoleInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spRoleInsert]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Permissions]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [FK_RolePermission_Permissions]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission] DROP CONSTRAINT [FK_RolePermission_Roles]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RolePermission]') AND type in (N'U'))
DROP TABLE [dbo].[RolePermission]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Companies_Countries]') AND parent_object_id = OBJECT_ID(N'[dbo].[Companies]'))
ALTER TABLE [dbo].[Companies] DROP CONSTRAINT [FK_Companies_Countries]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Companies_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Companies] DROP CONSTRAINT [DF_Companies_IsDeleted]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Companies]') AND type in (N'U'))
DROP TABLE [dbo].[Companies]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Countries_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Countries] DROP CONSTRAINT [DF_Countries_IsDeleted]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Countries]') AND type in (N'U'))
DROP TABLE [dbo].[Countries]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Roles_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Roles] DROP CONSTRAINT [DF_Roles_IsDeleted]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
DROP TABLE [dbo].[Roles]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_GetErrorsXml]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ELMAH_GetErrorsXml]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_GetErrorXml]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ELMAH_GetErrorXml]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_LogError]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ELMAH_LogError]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Permissions_IsDeleted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Permissions] DROP CONSTRAINT [DF_Permissions_IsDeleted]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Permissions]') AND type in (N'U'))
DROP TABLE [dbo].[Permissions]
GO
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwElmahError]'))
DROP VIEW [dbo].[vwElmahError]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateDMKOnRestoreOnNewInstance]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateDMKOnRestoreOnNewInstance]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncryptPassword]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[EncryptPassword]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spOpenPasswordsKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spOpenPasswordsKey]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spClosePasswordsKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spClosePasswordsKey]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DecryptPassword]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[DecryptPassword]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ELMAH_Error_ErrorId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ELMAH_Error] DROP CONSTRAINT [DF_ELMAH_Error_ErrorId]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_Error]') AND type in (N'U'))
DROP TABLE [dbo].[ELMAH_Error]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[1_Create_AUDIT_Table]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[1_Create_AUDIT_Table]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeDMKPassword]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ChangeDMKPassword]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeDMKPassword]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/***
	The IT database uses encryption for sensitive data, like passwords.
	It uses the symmetric key encrypted with certificate.
	Certificate is protected by database master key (DMK).
	DMK is protected by the SQL Server instance specific service master key (SMK).
	Once you restore the database on the new instance (e.g. from dev to prod), the new SMK doesn''t match.
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
	''open master key decryption by password = '''''' + @oldPassword + '''''';
	 alter master key add encryption by password = '''''' + @newPassword + '''''';
	 alter master key drop encryption by password = '''''' + @oldPassword + '''''';
	 close master key;''
exec sp_executesql @sql

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[1_Create_AUDIT_Table]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[1_Create_AUDIT_Table]
@TableName as varchar(100)
AS
BEGIN

DECLARE @AuditTableName as varchar(100) 
SET	@AuditTableName = ''AUDIT_'' + @TableName

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
					SET @SQLSTR = ''''
					SET @CUR=1
					SELECT @MAX = MAX(ID) FROM @MEMTABLE

					-- LOOP EVERY FIELD
					WHILE @CUR <= @MAX
					BEGIN
						-- GET VALUES FROM THE MEMTABLE	
						SELECT @CURCOL = COLUMNAME,@COLTYPE = TYPENAME FROM @MEMTABLE WHERE ID = @CUR
						IF @COLTYPE = ''INT'' OR @COLTYPE = ''BIGINT'' OR @COLTYPE=''UNIQUEIDENTIFIER''
							-- DO NOT COPY INT/BIGINT/UNIQUEIDENTIFIER, IDENTITY OR A ROWGUIDCOLUMN FIELDS 
							SET @SQLSTR = @SQLSTR + '' CAST(''+@CURCOL + '' AS ''+@COLTYPE+'') AS ['' + @CURCOL +''] ''
						ELSE
							-- OTHERWISE FIELD DO NOTHING JUST COPY IT AS IT IS
							SET @SQLSTR = @SQLSTR + '' ''+@CURCOL + '' AS ['' + @CURCOL +''] ''
						IF @CUR <= @MAX - 1 SET @SQLSTR=@SQLSTR + '',''
						SET @CUR = @CUR + 1
					END
					
					SET @SQLSTR = @SQLSTR
					-- SET UP THE SELECT FOR CREATING THE AUDIT TABLE
					SET @SQLSTR = ''SELECT TOP 0 '' + @SQLSTR + '' INTO [DBO].[''+ @AuditTableName +''] FROM ['' + @TableName +'']''
					EXEC(@SQLSTR)							
					
					-- ***************ADD THE AUDIT FIELDS************************
									
					--ADD TRG_ACTION COLUMN TO AUDIT TABLE
					SET @SQLSTR = ''ALTER TABLE ''+ @AuditTableName + '' ADD [TRG_ACTION] VARCHAR(6) NULL''
					EXEC(@SQLSTR)	

					--SET DEFAULT VALUE FOR TRG_DATE
					SET @SQLSTR = ''ALTER TABLE ''+ @AuditTableName + '' ADD [TRG_DATE] DATETIME NULL DEFAULT GETDATE()''
					EXEC(@SQLSTR)	
					-- ************************************************************			

					--****************************CREATE INDEXES ON AUDIT TABLE*******************
										
					SET @SQLSTR = ''CREATE NONCLUSTERED INDEX '' +  @AuditTableName  + ''_TRG_ACTION_Index ON '' + @AuditTableName + ''(TRG_ACTION)''
					EXEC(@SQLSTR)
					
					SET @SQLSTR = ''CREATE NONCLUSTERED INDEX '' +  @AuditTableName  + ''_TRG_DATE_Index ON '' + @AuditTableName + ''(TRG_DATE)''
					EXEC(@SQLSTR)
					--*****************************************************************************							
				END
	END
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ELMAH_Error]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ELMAH_Error](
	[ErrorId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ELMAH_Error_ErrorId]  DEFAULT (newid()),
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DecryptPassword]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'/*
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
	function doesn''t allow to open the key directly, 
	so execute the line below before calling this function:
	
	open symmetric key PasswordsKey decryption by certificate ITCertificate;
*/
	set @result = CAST(DecryptByKey(@password, 1, HashBytes(''SHA1'', CONVERT(varbinary, @id))) as nvarchar)
	return @result;
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spClosePasswordsKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spClosePasswordsKey] asbegin	CLOSE SYMMETRIC KEY PasswordsKey;end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spOpenPasswordsKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spOpenPasswordsKey] asbegin	OPEN SYMMETRIC KEY PasswordsKey DECRYPTION BY CERTIFICATE UMCertificate;end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncryptPassword]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'/*
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
	function doesn''t allow to open the key directly, 
	so execute the line below before calling this function:
	
	open symmetric key PasswordsKey decryption by certificate ITCertificate;
*/

	set @result = EncryptByKey(Key_GUID(''PasswordsKey''), cast(@password as nvarchar(100)), 1, HashBytes(''SHA1'', CONVERT(varbinary, @id)))
	return @result;
end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateDMKOnRestoreOnNewInstance]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
/***
	The IT database uses encryption for sensitive data, like passwords.
	It uses the symmetric key encrypted with certificate.
	Certificate is protected by database master key (DMK).
	DMK is protected by the SQL Server instance specific service master key (SMK).
	Once you restore the database on the new instance (e.g. from dev to prod), the new SMK doesn''t match.
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
	''open master key decryption by password = '''''' + @password + '''''';
	 alter master key add encryption by service master key;
	 close master key;''
exec sp_executesql @sql

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwElmahError]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwElmahError]
AS
SELECT     Host, Type, Message, [User], StatusCode, TimeUtc, Sequence
FROM         dbo.ELMAH_Error
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vwElmahError', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[8] 3) )"
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwElmahError'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vwElmahError', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwElmahError'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Permissions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Permissions](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[PermissionName] [varchar](50) NOT NULL,
	[PermissionDescription] [varchar](500) NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Permissions_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Permissions] ON
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionDescription], [IsDeleted]) VALUES (1, N'Statix_TDAPI', N'Allows to select data from the Statix database via TDAPI', 0)
SET IDENTITY_INSERT [dbo].[Permissions] OFF
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[RoleDescription] [varchar](500) NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Roles_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_RoleName] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription], [IsDeleted]) VALUES (1, N'Statix Users', N'', 0)
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Countries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[Code] [nvarchar](2) NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Countries_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Countries] ON
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (1, N'Afghanistan', N'AF', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (2, N'Albania', N'AL', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (3, N'Algeria', N'DZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (4, N'American Samoa', N'AS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (5, N'Andorra', N'AD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (6, N'Angola', N'AO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (7, N'Anguilla', N'AI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (8, N'Antarctica', N'AQ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (9, N'Antigua and Barbuda', N'AG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (10, N'Argentina', N'AR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (11, N'Armenia', N'AM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (12, N'Aruba', N'AW', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (13, N'Australia', N'AU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (14, N'Austria', N'AT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (15, N'Azerbaijan', N'AZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (16, N'Bahamas', N'BS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (17, N'Bahrain', N'BH', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (18, N'Bangladesh', N'BD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (19, N'Barbados', N'BB', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (20, N'Belarus', N'BY', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (21, N'Belgium', N'BE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (22, N'Belize', N'BZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (23, N'Benin', N'BJ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (24, N'Bermuda', N'BM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (25, N'Bhutan', N'BT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (26, N'Bolivia', N'BO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (27, N'Bosnia and Herzegovina', N'BA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (28, N'Botswana', N'BW', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (29, N'Bouvet Island', N'BV', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (30, N'Brazil', N'BR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (31, N'British Antarctic Territory', N'BQ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (32, N'British Indian Ocean Territory', N'IO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (33, N'British Virgin Islands', N'VG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (34, N'Brunei', N'BN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (35, N'Bulgaria', N'BG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (36, N'Burkina Faso', N'BF', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (37, N'Burundi', N'BI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (38, N'Cambodia', N'KH', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (39, N'Cameroon', N'CM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (40, N'Canada', N'CA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (41, N'Canton and Enderbury Islands', N'CT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (42, N'Cape Verde', N'CV', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (43, N'Cayman Islands', N'KY', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (44, N'Central African Republic', N'CF', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (45, N'Chad', N'TD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (46, N'Chile', N'CL', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (47, N'China', N'CN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (48, N'Christmas Island', N'CX', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (49, N'Cocos [Keeling] Islands', N'CC', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (50, N'Colombia', N'CO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (51, N'Comoros', N'KM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (52, N'Congo - Brazzaville', N'CG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (53, N'Congo - Kinshasa', N'CD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (54, N'Cook Islands', N'CK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (55, N'Costa Rica', N'CR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (56, N'Croatia', N'HR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (57, N'Cuba', N'CU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (58, N'Cyprus', N'CY', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (59, N'Czech Republic', N'CZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (60, N'Cote d’Ivoire', N'CI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (61, N'Denmark', N'DK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (62, N'Djibouti', N'DJ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (63, N'Dominica', N'DM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (64, N'Dominican Republic', N'DO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (65, N'Dronning Maud Land', N'NQ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (66, N'East Germany', N'DD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (67, N'Ecuador', N'EC', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (68, N'Egypt', N'EG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (69, N'El Salvador', N'SV', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (70, N'Equatorial Guinea', N'GQ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (71, N'Eritrea', N'ER', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (72, N'Estonia', N'EE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (73, N'Ethiopia', N'ET', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (74, N'Falkland Islands', N'FK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (75, N'Faroe Islands', N'FO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (76, N'Fiji', N'FJ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (77, N'Finland', N'FI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (78, N'France', N'FR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (79, N'French Guiana', N'GF', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (80, N'French Polynesia', N'PF', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (81, N'French Southern Territories', N'TF', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (82, N'French Southern and Antarctic Territories', N'FQ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (83, N'Gabon', N'GA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (84, N'Gambia', N'GM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (85, N'Georgia', N'GE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (86, N'Germany', N'DE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (87, N'Ghana', N'GH', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (88, N'Gibraltar', N'GI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (89, N'Greece', N'GR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (90, N'Greenland', N'GL', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (91, N'Grenada', N'GD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (92, N'Guadeloupe', N'GP', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (93, N'Guam', N'GU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (94, N'Guatemala', N'GT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (95, N'Guernsey', N'GG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (96, N'Guinea', N'GN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (97, N'Guinea-Bissau', N'GW', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (98, N'Guyana', N'GY', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (99, N'Haiti', N'HT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (100, N'Heard Island and McDonald Islands', N'HM', 0)
GO
print 'Processed 100 total records'
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (101, N'Honduras', N'HN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (102, N'Hong Kong SAR China', N'HK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (103, N'Hungary', N'HU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (104, N'Iceland', N'IS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (105, N'India', N'IN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (106, N'Indonesia', N'ID', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (107, N'Iran', N'IR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (108, N'Iraq', N'IQ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (109, N'Ireland', N'IE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (110, N'Isle of Man', N'IM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (111, N'Israel', N'IL', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (112, N'Italy', N'IT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (113, N'Jamaica', N'JM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (114, N'Japan', N'JP', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (115, N'Jersey', N'JE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (116, N'Johnston Island', N'JT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (117, N'Jordan', N'JO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (118, N'Kazakhstan', N'KZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (119, N'Kenya', N'KE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (120, N'Kiribati', N'KI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (121, N'Kuwait', N'KW', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (122, N'Kyrgyzstan', N'KG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (123, N'Laos', N'LA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (124, N'Latvia', N'LV', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (125, N'Lebanon', N'LB', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (126, N'Lesotho', N'LS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (127, N'Liberia', N'LR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (128, N'Libya', N'LY', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (129, N'Liechtenstein', N'LI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (130, N'Lithuania', N'LT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (131, N'Luxembourg', N'LU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (132, N'Macau SAR China', N'MO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (133, N'Macedonia', N'MK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (134, N'Madagascar', N'MG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (135, N'Malawi', N'MW', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (136, N'Malaysia', N'MY', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (137, N'Maldives', N'MV', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (138, N'Mali', N'ML', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (139, N'Malta', N'MT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (140, N'Marshall Islands', N'MH', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (141, N'Martinique', N'MQ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (142, N'Mauritania', N'MR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (143, N'Mauritius', N'MU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (144, N'Mayotte', N'YT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (145, N'Metropolitan France', N'FX', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (146, N'Mexico', N'MX', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (147, N'Micronesia', N'FM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (148, N'Midway Islands', N'MI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (149, N'Moldova', N'MD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (150, N'Monaco', N'MC', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (151, N'Mongolia', N'MN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (152, N'Montenegro', N'ME', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (153, N'Montserrat', N'MS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (154, N'Morocco', N'MA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (155, N'Mozambique', N'MZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (156, N'Myanmar [Burma]', N'MM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (157, N'Namibia', N'NA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (158, N'Nauru', N'NR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (159, N'Nepal', N'NP', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (160, N'Netherlands', N'NL', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (161, N'Netherlands Antilles', N'AN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (162, N'Neutral Zone', N'NT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (163, N'New Caledonia', N'NC', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (164, N'New Zealand', N'NZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (165, N'Nicaragua', N'NI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (166, N'Niger', N'NE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (167, N'Nigeria', N'NG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (168, N'Niue', N'NU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (169, N'Norfolk Island', N'NF', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (170, N'North Korea', N'KP', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (171, N'North Vietnam', N'VD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (172, N'Northern Mariana Islands', N'MP', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (173, N'Norway', N'NO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (174, N'Oman', N'OM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (175, N'Pacific Islands Trust Territory', N'PC', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (176, N'Pakistan', N'PK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (177, N'Palau', N'PW', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (178, N'Palestinian Territories', N'PS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (179, N'Panama', N'PA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (180, N'Panama Canal Zone', N'PZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (181, N'Papua New Guinea', N'PG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (182, N'Paraguay', N'PY', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (183, N'People''s Democratic Republic of Yemen', N'YD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (184, N'Peru', N'PE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (185, N'Philippines', N'PH', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (186, N'Pitcairn Islands', N'PN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (187, N'Poland', N'PL', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (188, N'Portugal', N'PT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (189, N'Puerto Rico', N'PR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (190, N'Qatar', N'QA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (191, N'Romania', N'RO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (192, N'Russia', N'RU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (193, N'Rwanda', N'RW', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (194, N'Reunion', N'RE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (195, N'Saint Barthelemy', N'BL', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (196, N'Saint Helena', N'SH', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (197, N'Saint Kitts and Nevis', N'KN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (198, N'Saint Lucia', N'LC', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (199, N'Saint Martin', N'MF', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (200, N'Saint Pierre and Miquelon', N'PM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (201, N'Saint Vincent and the Grenadines', N'VC', 0)
GO
print 'Processed 200 total records'
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (202, N'Samoa', N'WS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (203, N'San Marino', N'SM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (204, N'Saudi Arabia', N'SA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (205, N'Senegal', N'SN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (206, N'Serbia', N'RS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (207, N'Serbia and Montenegro', N'CS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (208, N'Seychelles', N'SC', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (209, N'Sierra Leone', N'SL', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (210, N'Singapore', N'SG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (211, N'Slovakia', N'SK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (212, N'Slovenia', N'SI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (213, N'Solomon Islands', N'SB', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (214, N'Somalia', N'SO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (215, N'South Africa', N'ZA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (216, N'South Georgia and the South Sandwich Islands', N'GS', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (217, N'South Korea', N'KR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (218, N'Spain', N'ES', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (219, N'Sri Lanka', N'LK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (220, N'Sudan', N'SD', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (221, N'Suriname', N'SR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (222, N'Svalbard and Jan Mayen', N'SJ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (223, N'Swaziland', N'SZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (224, N'Sweden', N'SE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (225, N'Switzerland', N'CH', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (226, N'Syria', N'SY', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (227, N'Sao Tome and Principe', N'ST', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (228, N'Taiwan', N'TW', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (229, N'Tajikistan', N'TJ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (230, N'Tanzania', N'TZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (231, N'Thailand', N'TH', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (232, N'Timor-Leste', N'TL', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (233, N'Togo', N'TG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (234, N'Tokelau', N'TK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (235, N'Tonga', N'TO', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (236, N'Trinidad and Tobago', N'TT', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (237, N'Tunisia', N'TN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (238, N'Turkey', N'TR', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (239, N'Turkmenistan', N'TM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (240, N'Turks and Caicos Islands', N'TC', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (241, N'Tuvalu', N'TV', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (242, N'U.S. Minor Outlying Islands', N'UM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (243, N'U.S. Miscellaneous Pacific Islands', N'PU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (244, N'U.S. Virgin Islands', N'VI', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (245, N'Uganda', N'UG', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (246, N'Ukraine', N'UA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (247, N'Union of Soviet Socialist Republics', N'SU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (248, N'United Arab Emirates', N'AE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (249, N'United Kingdom', N'GB', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (250, N'United States', N'US', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (251, N'Unknown or Invalid Region', N'ZZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (252, N'Uruguay', N'UY', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (253, N'Uzbekistan', N'UZ', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (254, N'Vanuatu', N'VU', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (255, N'Vatican City', N'VA', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (256, N'Venezuela', N'VE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (257, N'Vietnam', N'VN', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (258, N'Wake Island', N'WK', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (259, N'Wallis and Futuna', N'WF', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (260, N'Western Sahara', N'EH', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (261, N'Yemen', N'YE', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (262, N'Zambia', N'ZM', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (263, N'Zimbabwe', N'ZW', 0)
INSERT [dbo].[Countries] ([CountryId], [Name], [Code], [IsDeleted]) VALUES (264, N'Aland Islands', N'AX', 0)
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Companies]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Companies](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](500) NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Fax] [nvarchar](50) NULL,
	[CountryId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Companies_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_CompanyPhone] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[Companies] ON
INSERT [dbo].[Companies] ([CompanyId], [Name], [Address], [Phone], [Fax], [CountryId], [IsDeleted]) VALUES (1, N'TradeData', N'81 High St, Billericay, Essex CM12 9AS, United Kingdom', N'441277633777', N'441277633777', 249, 0)
INSERT [dbo].[Companies] ([CompanyId], [Name], [Address], [Phone], [Fax], [CountryId], [IsDeleted]) VALUES (2, N'Arcadia', N'28 korp 2, Bolshoy Sampsonievskiy prospect, Saint-Petersburg, Russia', N'78126105955', N'', 191, 0)
SET IDENTITY_INSERT [dbo].[Companies] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RolePermission]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RolePermission](
	[RoleId] [int] NOT NULL,
	[PermissionId] [int] NOT NULL
) ON [PRIMARY]
END
GO
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (1, 1)
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRoleInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[spRoleInsert]
	@roleName nvarchar(50),
	@roleDescription nvarchar(500)
as

begin

	declare @rId int
	set @rId = (select RoleId from Roles where roleName = @roleName)
	
	if @rId is not null
		update Roles set 
			IsDeleted = 0, 
			RoleName = ''***RESTORED*** '' + RoleName 
		where RoleId = @rId
	else
		insert into Roles (RoleName, RoleDescription)
		values (@roleName, @roleDescription)
		
end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRoleDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spRoleDelete]
	@roleId int
as

begin

	update Roles set IsDeleted = 1 where RoleId = @roleId;

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRoleUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[spRoleUpdate]
	@roleId int,
	@roleName nvarchar(50),
	@roleDescription nvarchar(500)
as
begin

	update Roles set
		RoleName = ISNULL(@roleName,RoleName),
		RoleDescription = ISNULL(@roleDescription,RoleDescription)
	where RoleId = @roleId

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCountries]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwCountries]
AS
SELECT     CountryId, Name, Code
FROM         dbo.Countries
WHERE     (IsDeleted = 0)
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vwCountries', NULL,NULL))
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
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vwCountries', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCountries'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwPermissions]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwPermissions]
AS
SELECT     PermissionId, PermissionName, PermissionDescription
FROM         dbo.Permissions
WHERE     (IsDeleted = 0)
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vwPermissions', NULL,NULL))
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
               Bottom = 126
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
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vwPermissions', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwPermissions'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TRG_Roles]'))
EXEC dbo.sp_executesql @statement = N'create      TRIGGER [dbo].[TRG_Roles]
ON [dbo].[Roles]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] ''Roles''


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = ''UPDATE''
		IF @INS = 1 AND @DEL = 0 SET @ACT = ''INSERT''
		IF @DEL = 1 AND @INS = 0 SET @ACT = ''DELETE''

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = ''INSERT'' INSERT [DBO].[AUDIT_Roles] SELECT *,''INSERT'' ,GETDATE() FROM INSERTED
		IF @ACT = ''DELETE'' INSERT [DBO].[AUDIT_Roles] SELECT *,''DELETE'' ,GETDATE() FROM DELETED
		IF @ACT = ''UPDATE'' INSERT [DBO].[AUDIT_Roles] SELECT *,''UPDATE'' ,GETDATE() FROM INSERTED
END
'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TRG_Permissions]'))
EXEC dbo.sp_executesql @statement = N'create      TRIGGER [dbo].[TRG_Permissions]
ON [dbo].[Permissions]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] ''Permissions''


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = ''UPDATE''
		IF @INS = 1 AND @DEL = 0 SET @ACT = ''INSERT''
		IF @DEL = 1 AND @INS = 0 SET @ACT = ''DELETE''

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = ''INSERT'' INSERT [DBO].[AUDIT_Permissions] SELECT *,''INSERT'' ,GETDATE() FROM INSERTED
		IF @ACT = ''DELETE'' INSERT [DBO].[AUDIT_Permissions] SELECT *,''DELETE'' ,GETDATE() FROM DELETED
		IF @ACT = ''UPDATE'' INSERT [DBO].[AUDIT_Permissions] SELECT *,''UPDATE'' ,GETDATE() FROM INSERTED
END


'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TRG_Countries]'))
EXEC dbo.sp_executesql @statement = N'create      TRIGGER [dbo].[TRG_Countries]
ON [dbo].[Countries]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] ''Countries''


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = ''UPDATE''
		IF @INS = 1 AND @DEL = 0 SET @ACT = ''INSERT''
		IF @DEL = 1 AND @INS = 0 SET @ACT = ''DELETE''

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = ''INSERT'' INSERT [DBO].[AUDIT_Countries] SELECT *,''INSERT'' ,GETDATE() FROM INSERTED
		IF @ACT = ''DELETE'' INSERT [DBO].[AUDIT_Countries] SELECT *,''DELETE'' ,GETDATE() FROM DELETED
		IF @ACT = ''UPDATE'' INSERT [DBO].[AUDIT_Countries] SELECT *,''UPDATE'' ,GETDATE() FROM INSERTED
END


'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwRoles]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwRoles]
AS
SELECT     RoleId, RoleName, RoleDescription
FROM         dbo.Roles
WHERE     (IsDeleted = 0)
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vwRoles', NULL,NULL))
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
               Bottom = 174
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
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vwRoles', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwRoles'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwRolePermission]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwRolePermission]
AS
SELECT     dbo.RolePermission.RoleId, dbo.Roles.RoleName, dbo.RolePermission.PermissionId, dbo.Permissions.PermissionName
FROM         dbo.Permissions INNER JOIN
                      dbo.RolePermission ON dbo.Permissions.PermissionId = dbo.RolePermission.PermissionId INNER JOIN
                      dbo.Roles ON dbo.RolePermission.RoleId = dbo.Roles.RoleId
WHERE     (dbo.Roles.IsDeleted = 0) AND (dbo.Permissions.IsDeleted = 0)
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vwRolePermission', NULL,NULL))
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
               Bottom = 134
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
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vwRolePermission', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwRolePermission'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TRG_Companies]'))
EXEC dbo.sp_executesql @statement = N'create      TRIGGER [dbo].[TRG_Companies]
ON [dbo].[Companies]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] ''Companies''


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = ''UPDATE''
		IF @INS = 1 AND @DEL = 0 SET @ACT = ''INSERT''
		IF @DEL = 1 AND @INS = 0 SET @ACT = ''DELETE''

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = ''INSERT'' INSERT [DBO].[AUDIT_Companies] SELECT *,''INSERT'' ,GETDATE() FROM INSERTED
		IF @ACT = ''DELETE'' INSERT [DBO].[AUDIT_Companies] SELECT *,''DELETE'' ,GETDATE() FROM DELETED
		IF @ACT = ''UPDATE'' INSERT [DBO].[AUDIT_Companies] SELECT *,''UPDATE'' ,GETDATE() FROM INSERTED
END
'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwCompanies]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwCompanies]
AS
SELECT     dbo.Companies.CompanyId, dbo.Companies.Name, dbo.Companies.Address, dbo.Companies.Phone, dbo.Companies.Fax, dbo.Companies.CountryId, dbo.Countries.Name AS Country
FROM         dbo.Companies INNER JOIN
                      dbo.Countries ON dbo.Companies.CountryId = dbo.Countries.CountryId
WHERE     (dbo.Companies.IsDeleted = 0)
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vwCompanies', NULL,NULL))
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
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vwCompanies', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCompanies'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[Firstname] [nvarchar](100) NOT NULL,
	[Lastname] [nvarchar](100) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [varbinary](300) NULL,
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Users_IsDeleted]  DEFAULT ((0)),
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Members] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([UserId], [CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted]) VALUES (2, 2, N'Vitaly', N'Chupaev', N'vchupaev@mail.ru', 0x00975D6C09556138F8D96691CFB6F454010000002156C2A30CB1FE11861476D5049765893F87AA667EE6D659A5B8FCAE554F73F363563DD0257429B564655FF6F3D816CC93487769AA6648FCD8B53DDB4570C6D0, 0)
INSERT [dbo].[Users] ([UserId], [CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted]) VALUES (3, 1, N'Simon', N'Coughlan', N'scoughlan@mail.uk', 0x00975D6C09556138F8D96691CFB6F45401000000241A511AE2D49080C6D7B3167F60648DE2EEA3D5F59707FB9EB6CF35D3B17EDFD3379851A9EC3E180EFA528441F7663925545D936B837B4249C394EA48818EA0, 0)
INSERT [dbo].[Users] ([UserId], [CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted]) VALUES (4, 1, N'BNP', N'Anonymous', N'bnp_anonymous', 0x00975D6C09556138F8D96691CFB6F45401000000CA5CC0C1FB46A2EC761177A4A39751A495389EBD5016C15E567897EDC9333D41274EF1DEAE367B7ABEE0A79374EEDF947D9917B43500F5EA0476940E00194083, 0)
INSERT [dbo].[Users] ([UserId], [CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted]) VALUES (5, 1, N'Newedge', N'Anonymous', N'newedge_anonymous', 0x00975D6C09556138F8D96691CFB6F454010000001ECA74CDADB657655AAA6A650B8D66BFC8E76B3694336DBAFF173BCC1CEE99ED4A8C479E0A0535A83CBCA94368BDD02CE21BEBCB9B7B5C1A87EDBFA9716591B1, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCompanyUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[spCompanyUpdate]
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

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCompanyInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[spCompanyInsert]
	@name nvarchar(100),
	@phone nvarchar(50),
	@fax nvarchar(50),
	@address nvarchar(500),
	@countryId int
as

begin

	declare @сId int
	set @сId = (select CompanyId from Companies where Phone = @phone)
	
	if @сId is not null
		update Companies set 
			IsDeleted = 0, 
			Name = ''***RESTORED*** '' + Name 
		where CompanyId = @сId
	else
		insert into Companies (Name, Address, Phone, Fax, CountryId)
		values (@name, @address, @phone, @fax, @countryId)
		
end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCompanyDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[spCompanyDelete]
	@companyId int
as

begin

	update Companies set IsDeleted = 1 where CompanyId = @companyId

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRolePermissionInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spRolePermissionInsert]
	@permissionId int,
	@roleId int
as

begin

	insert into RolePermission (PermissionId, RoleId)
	values (@permissionId, @roleId)

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spRolePermissionDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spRolePermissionDelete]
	@permissionId int,
	@roleId int
as

begin

	delete from RolePermission
	where PermissionId = @permissionId and RoleId = @roleId

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[spUserInsert]
	@companyId int,
	@firstName nvarchar(100),
	@lastName nvarchar(100),
	@userName nvarchar(50),
	@password nvarchar(100)
as

begin
	begin try
		begin tran myTran
		
		declare @uId int
		set @uId = (select UserId from Users where Username = @userName)
	
		if @uId is not null
			update Users set IsDeleted = 0, Username = ''***RESTORED*** '' + Username where UserId = @uId
		else
		begin
			exec spOpenPasswordsKey;

			declare @mid table (Id int);
			declare @userId int;

			insert into Users (CompanyId, Firstname, Lastname, Username)
			output inserted.UserId into @mid
			values (@companyId, @firstName, @lastName, @userName)

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
end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[spUserDelete]
	@userId int
as

begin

	update Users set IsDeleted = 1 where UserId = @userId;

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[History]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[History](
	[HistoryId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Username] [nvarchar](50) NULL,
	[TimestampUtc] [datetime] NOT NULL CONSTRAINT [DF_History_TimestampUtc]  DEFAULT (getutcdate()),
	[Action] [nvarchar](50) NOT NULL,
	[Message] [nvarchar](max) NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[HistoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAuthorizeUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spAuthorizeUser]
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
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserRole](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL
) ON [PRIMARY]
END
GO
INSERT [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 1)
INSERT [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 1)
INSERT [dbo].[UserRole] ([UserId], [RoleId]) VALUES (4, 1)
INSERT [dbo].[UserRole] ([UserId], [RoleId]) VALUES (5, 1)
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE procedure [dbo].[spUserUpdate]
	@userId int,
	@companyId int = null,
	@firstName nvarchar(100) = null,
	@lastName nvarchar(100) = null,
	@userName nvarchar(50) = null,
	@password nvarchar(100) = null
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
		Firstname = ISNULL(@firstName,Firstname),
		Lastname = ISNULL(@lastName,Lastname),
		Username = ISNULL(@userName,Username),
		[Password] = ISNULL(@pwdEncrypted,[Password])
	where UserId = @userId

	exec spClosePasswordsKey;

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[TRG_Users]'))
EXEC dbo.sp_executesql @statement = N'create      TRIGGER [dbo].[TRG_Users]
ON [dbo].[Users]
FOR DELETE,INSERT,UPDATE
AS
BEGIN

		--Check to See if Audit Table Exists. If Not then Create
		EXECUTE [dbo].[1_Create_AUDIT_Table] ''Users''


		DECLARE @ACT CHAR(6)
		DECLARE @DEL BIT
		DECLARE @INS BIT 
		DECLARE @SQLSTRING VARCHAR(2000)

		SET @DEL = 0
		SET @INS = 0

		IF EXISTS (SELECT TOP 1 1 FROM DELETED) SET @DEL=1
		IF EXISTS (SELECT TOP 1 1 FROM INSERTED) SET @INS = 1 

		IF @INS = 1 AND @DEL = 1 SET @ACT = ''UPDATE''
		IF @INS = 1 AND @DEL = 0 SET @ACT = ''INSERT''
		IF @DEL = 1 AND @INS = 0 SET @ACT = ''DELETE''

		IF @INS = 0 AND @DEL = 0 RETURN

		IF @ACT = ''INSERT'' INSERT [DBO].[AUDIT_Users] SELECT *,''INSERT'' ,GETDATE() FROM INSERTED
		IF @ACT = ''DELETE'' INSERT [DBO].[AUDIT_Users] SELECT *,''DELETE'' ,GETDATE() FROM DELETED
		IF @ACT = ''UPDATE'' INSERT [DBO].[AUDIT_Users] SELECT *,''UPDATE'' ,GETDATE() FROM INSERTED
END
'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwUsers]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwUsers]
AS
SELECT     dbo.Users.UserId, dbo.Users.CompanyId, dbo.Companies.Name AS Company, dbo.Users.Firstname, dbo.Users.Lastname, dbo.Users.Username, dbo.DecryptPassword(dbo.Users.Password, 
                      dbo.Users.UserId) AS Password, dbo.Users.Firstname + '' '' + dbo.Users.Lastname + '' ('' + dbo.Users.Username + '')'' AS Fullname
FROM         dbo.Companies INNER JOIN
                      dbo.Users ON dbo.Companies.CompanyId = dbo.Users.CompanyId
WHERE     (dbo.Users.IsDeleted = 0)
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vwUsers', NULL,NULL))
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
               Top = 105
               Left = 318
               Bottom = 270
               Right = 478
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
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vwUsers', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUsers'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwUserRole]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwUserRole]
AS
SELECT     dbo.Roles.RoleId, dbo.Roles.RoleName, dbo.vwUsers.UserId, dbo.vwUsers.Fullname
FROM         dbo.Roles INNER JOIN
                      dbo.UserRole ON dbo.Roles.RoleId = dbo.UserRole.RoleId INNER JOIN
                      dbo.vwUsers ON dbo.UserRole.UserId = dbo.vwUsers.UserId
WHERE     (dbo.Roles.IsDeleted = 0)
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vwUserRole', NULL,NULL))
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
               Bottom = 151
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
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vwUserRole', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwUserRole'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwHistory]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwHistory]
AS
SELECT     dbo.Companies.Name, dbo.Users.Firstname, dbo.Users.Lastname, dbo.History.Username, dbo.History.Action, dbo.History.TimestampUtc, dbo.History.Message
FROM         dbo.Companies INNER JOIN
                      dbo.Users ON dbo.Companies.CompanyId = dbo.Users.CompanyId RIGHT OUTER JOIN
                      dbo.History ON dbo.Users.UserId = dbo.History.UserId
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vwHistory', NULL,NULL))
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
         Begin Table = "Members"
            Begin Extent = 
               Top = 23
               Left = 359
               Bottom = 252
               Right = 519
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
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vwHistory', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwHistory'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserRoleInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spUserRoleInsert]
	@userId int,
	@roleId int
as

begin

	insert into UserRole (UserId, RoleId)
	values (@userId, @roleId)

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUserRoleDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spUserRoleDelete]
	@userId int,
	@roleId int
as

begin

	delete from UserRole
	where UserId = @userId and RoleId = @roleId

end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAuthenticateUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
	@password stands for varbinary string, which is to be decrypted with PasswordsKey symmetric key,
	@id stands for some value, commonly the primary key value of the row the password stored in, and used as a parameter of DecryptByKey function - @authenticator.
*/
CREATE procedure [dbo].[spAuthenticateUser]
(
	@username varchar(50),
	@password varchar(50),
	@userId int OUT
)
as
begin
	-- open key to decrypt password
	OPEN SYMMETRIC KEY PasswordsKey DECRYPTION BY CERTIFICATE UMCertificate;
	
	set @userId = (
		select top 1 userId 
		from vwUsers 
		where username = @username 
			and [password] = @password COLLATE SQL_Latin1_General_CP1_CS_AS -- case sensitive comaprison for password
	)
			
	-- close key			
	CLOSE SYMMETRIC KEY PasswordsKey;	
end
' 
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Companies_Countries]') AND parent_object_id = OBJECT_ID(N'[dbo].[Companies]'))
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Companies_Countries]') AND parent_object_id = OBJECT_ID(N'[dbo].[Companies]'))
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_Countries]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_History_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[History]'))
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_History_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[History]'))
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Permissions]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_RolePermission_Permissions] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[Permissions] ([PermissionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Permissions]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Permissions]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_RolePermission_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_RolePermission_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[RolePermission]'))
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Roles]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Roles]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Roles]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Users]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Users]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Users_Companies]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Companies] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([CompanyId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Users_Companies]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Companies]
GO
