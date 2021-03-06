use {DB_NAME};

/*** 

	Create DMK, certificate and symmetric key 

***/
if not exists (select * from sys.symmetric_keys where symmetric_key_id = 101)
	create master key encryption by 
	password = N'{DMK_PASSWORD}';

if (select count(*) from sys.certificates where name = 'UsersCert') = 0
	create certificate UsersCert with subject = '{DB_NAME} passwords';

-- it is critical to provide identity_value and key_source, and remember values somewhere along with DMK password;
-- if symmetric key will be occasionaly deleted, you will be able to re-create it with this information and avoid data loss;
-- without symmetric key it is not possible to decrypt data.
if not exists (select * from sys.symmetric_keys where name = 'PasswordsKey')
	create symmetric key PasswordsKey with 
		identity_value = '{SK_IDENTITY}',
		key_source = '{SK_SOURCE}',
		algorithm = AES_256 
		encryption by certificate UsersCert;

-- set default password and encrypt the column;
-- open key for encryption
open symmetric key PasswordsKey decryption by certificate UsersCert;

-- encrypt sensitive data
update Users set password = dbo.EncryptPassword('{DEFAULT_PASSWORD}', UserId);
--update Users set password = dbo.EncryptPassword([Password], UserId);

/***

    Configure backup

***/
declare 
	@advOptions sql_variant,
	@cmdShell sql_variant,
	@backupDir nvarchar(2048) = '{BACKUP_FOLDER}';

-- skip backup if path is not provided
if (@backupDir is null or @backupDir = '')
	GOTO END_OF_SCRIPT;

-- keep current configuration	
set @advOptions = (select value from sys.configurations where name = 'show advanced options')
set @cmdShell = (select value from sys.configurations where name = 'xp_cmdshell')

-- enable options if necessary
if @advOptions = 0
begin
	exec master.dbo.sp_configure 'show advanced options', 1;
	reconfigure;
end

if @cmdShell = 0
begin
	exec master.dbo.sp_configure 'xp_cmdshell', 1;
	reconfigure;
end

-- create backup folder with datetime to ensure uniqueness
declare @cmd nvarchar(2048), @datetime nvarchar(128);
set @datetime = convert(nvarchar(MAX), GETDATE(), 112) + ' ' + replace(convert(nvarchar(MAX), GETDATE(), 108), ':', '')
set @backupDir = @backupDir + ' (' + @datetime + ')';
set @cmd = 'md "' + @backupDir + '"';
exec master.dbo.xp_cmdshell @cmd;

-- store password and other text data
set @cmd = ' @echo The password for Database Master Key and backed up keys and certificate: {DMK_PASSWORD} > "' + @backupDir +  '\StatixBackup.txt"'; exec xp_cmdshell @cmd;
set @cmd = ' @echo The symmetric key ''PasswordsKey'' identity value: {SK_IDENTITY} >> "' + @backupDir +  '\StatixBackup.txt"'; exec xp_cmdshell @cmd;
set @cmd = ' @echo The symmetric key ''PasswordsKey'' source: {SK_SOURCE} >> "' + @backupDir +  '\StatixBackup.txt"'; exec xp_cmdshell @cmd;
set @cmd = ' @echo The built-in users'' default password: {DEFAULT_PASSWORD} >> "' + @backupDir +  '\StatixBackup.txt"'; exec xp_cmdshell @cmd;

-- restore options if necessary
if @cmdShell = 0
begin
	exec master.dbo.sp_configure 'xp_cmdshell', 0;
	reconfigure;
end

if @advOptions = 0
begin
	exec master.dbo.sp_configure 'show advanced options', 0;
	reconfigure;
end

/***

    Do backup

***/
declare 
	@backupDmk nvarchar(2048),
	@backupCert nvarchar(2048)
	
set @backupDmk = 'use {DB_NAME}; backup master key to file = ''' + @backupDir + '\UnifiedUsers_DMK.key'' encryption by password = N''{DMK_PASSWORD}'''
set @backupCert = 'use {DB_NAME}; backup certificate UsersCert to file = ''' + @backupDir + '\UsersCert.cer'' with private key (file = ''' + @backupDir + '\UsersCert_PrivateKey.key'', encryption by password = N''{DMK_PASSWORD}'')';

exec master.dbo.sp_executesql @backupDmk;
exec master.dbo.sp_executesql @backupCert;

END_OF_SCRIPT: