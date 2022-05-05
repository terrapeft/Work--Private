use [UmbracoMembers];
go


/*** 

	Create DMK, certificate and symmetric key 

***/
-- If there is no database master key, create one now. 
-- ID 101 stands for the database master key.
if not exists (select * from sys.symmetric_keys where symmetric_key_id = 101)
	create master key encryption by 
	password = N'DMK_UM2015';

if (select count(*) from sys.certificates where name = 'UMCertificate') = 0
	create certificate UMCertificate with subject = '[UmbracoMembers] passwords';

-- it is critical to provide identity_value and key_source, and remember values somewhere along with DMK password
-- if symmetric key will be occasionaly deleted, you will be able to re-create it with this information and avoid data loss
-- without symmetric key it is not possible to decrypt data.
if not exists (select * from sys.symmetric_keys where name = 'PasswordsKey')
	create symmetric key PasswordsKey with 
		identity_value = 'Lorem ipsum dolor sit amet',
		key_source = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
		algorithm = AES_256 
		encryption by certificate UMCertificate;


IF @@ERROR <> 0 GOTO _ERROR_;



/*** 

	Backup keys, path must exist, files must not exist.

***/
begin try
	backup master key to file = N'e:\stash\UmbracoMembers_DMK.key' encryption by password = N'DMK_UM2015'
	backup certificate UMCertificate to file = 'e:\stash\UMCertificate.cer'
		with private key (file = 'e:\stash\UMCertificate_PrivateKey.key', encryption by password = N'DMK_UM2015');
end try
begin catch
	print 'Failed to backup one or more keys with error: ';
	SELECT
		ERROR_NUMBER() AS ErrorNumber
		,ERROR_SEVERITY() AS ErrorSeverity
		,ERROR_STATE() AS ErrorState
		,ERROR_PROCEDURE() AS ErrorProcedure
		,ERROR_LINE() AS ErrorLine
		,ERROR_MESSAGE() AS ErrorMessage;	
end catch


/*** 
	
	Create spUpdateDmkOnRestoreOnNewInstance
	
***/
if not exists (select * from sys.objects where object_id = object_id(N'[dbo].[spUpdateDMKOnRestoreOnNewInstance]') AND type in (N'P', N'PC'))
begin
exec dbo.sp_executesql @statement = N'
/***
	The IT database uses encryption for sensitive data, like passwords.
	It uses the symmetric key encrypted with certificate.
	Certificate is protected by database master key (DMK).
	DMK is protected by the SQL Server instance specific service master key (SMK).
	Once you restore the database on the new instance (e.g. from dev to prod), the new SMK doesn''t match.
	To be able to use the symmetric key for decryption, you need to open DMK with a password, which was used to create it
	and re-encrypt it with the new SMK.
***/
create procedure [dbo].[spUpdateDMKOnRestoreOnNewInstance]
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
end



/****** Object:  UserDefinedFunction [dbo].[DecryptPassword]    Script Date: 12/11/2015 15:26:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DecryptPassword]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[DecryptPassword]

/****** Object:  UserDefinedFunction [dbo].[EncryptPassword]    Script Date: 12/11/2015 15:26:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EncryptPassword]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[EncryptPassword]

/****** Object:  StoredProcedure [dbo].[spClosePasswordsKey]    Script Date: 12/11/2015 15:26:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spClosePasswordsKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spClosePasswordsKey]

/****** Object:  StoredProcedure [dbo].[spOpenPasswordsKey]    Script Date: 12/11/2015 15:26:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spOpenPasswordsKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spOpenPasswordsKey]

/****** Object:  StoredProcedure [dbo].[spOpenPasswordsKey]    Script Date: 12/11/2015 15:26:36 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spOpenPasswordsKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spOpenPasswordsKey] asbegin	OPEN SYMMETRIC KEY PasswordsKey DECRYPTION BY CERTIFICATE UMCertificate;end' 
END

/****** Object:  StoredProcedure [dbo].[spClosePasswordsKey]    Script Date: 12/11/2015 15:26:36 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spClosePasswordsKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[spClosePasswordsKey] asbegin	CLOSE SYMMETRIC KEY PasswordsKey;end' 
END

/****** Object:  UserDefinedFunction [dbo].[EncryptPassword]    Script Date: 12/11/2015 15:26:36 ******/
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

	-- function doesn''t allow to open the key directly, so calling the stored procedure for that
	exec spOpenPasswordsKey;

	set @result = EncryptByKey(Key_GUID(''PasswordsKey''), @password, 1, HashBytes(''SHA1'', CONVERT(varbinary, @id)))
	exec spClosePasswordsKey;
	return @result;
end' 
END

/****** Object:  UserDefinedFunction [dbo].[DecryptPassword]    Script Date: 12/11/2015 15:26:36 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DecryptPassword]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'/*
	@password stands for varbinary string, which is to be decrypted with PasswordsKey symmetric key,
	@id stands for some value, commonly the primary key value of the row the password stored in, and used as a parameter of DecryptByKey function - @authenticator.
*/
create function [dbo].[DecryptPassword]
(
	@password varbinary(300),
	@id int
)
returns nvarchar(100)
as
begin
	declare @result nvarchar(100);

	-- function doesn''t allow to open the key directly, so calling the stored procedure for that
	exec spOpenPasswordsKey;

	set @result = CAST(DecryptByKey(@password, 1, HashBytes(''SHA1'', CONVERT(varbinary, @id))) as varchar)
	exec spClosePasswordsKey;
	return @result;
end
' 
END

print 'Script completed without fatal errors.';

IF @@ERROR = 0 GOTO _END_;


_ERROR_:
print 'Interrupted on error';


_END_:


exec dbo.spInsertMember 1, 'Vitaly', 'V', 'Chupaev', 'vchupaev2', 'zigzag'


/*

exec spPWDSelect null
exec spFTPDropServerSelect null
exec spPWDDetailSelect null, 5


use master;
select * from sys.symmetric_keys
 
select name
from sys.databases
where is_master_key_encrypted_by_server = 1
 

*/