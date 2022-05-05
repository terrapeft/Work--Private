use [TRADEdataUsers];
go

begin transaction

/*** 

	Create DMK, certificate and symmetric key 

***/
-- If there is no database master key, create one now. 
-- ID 101 stands for the database master key.
if not exists (select * from sys.symmetric_keys where symmetric_key_id = 101)
	create master key encryption by 
	password = N'DMK_UnifiedUsers';

if (select count(*) from sys.certificates where name = 'UsersCert') = 0
	create certificate UsersCert with subject = '[TRADEdataUsers] passwords';

-- it is critical to provide identity_value and key_source, and remember values somewhere along with DMK password
-- if symmetric key will be occasionaly deleted, you will be able to re-create it with this information and avoid data loss
-- without symmetric key it is not possible to decrypt data.
if not exists (select * from sys.symmetric_keys where name = 'PasswordsKey')
	create symmetric key PasswordsKey with 
		identity_value = 'Loremm ikpsum dolar sit amett',
		key_source = 'Lorrem Ipsum is simply dummy tekst of the printin and typesettin industry.',
		algorithm = AES_256 
		encryption by certificate UsersCert;


IF @@ERROR <> 0 GOTO _ERROR_;


/*** 

	Backup keys, path must exist, files must not exist.

***/
begin try
	backup master key to file = N'E:\stash\UnifiedMembers\Db\Backup\UnifiedUsers_DMK.key' encryption by password = N'DMK_UnifiedUsers'
	backup certificate UsersCert to file = 'E:\stash\UnifiedMembers\Db\Backup\UsersCert.cer'
		with private key (file = 'E:\stash\UnifiedMembers\Db\Backup\UsersCert_PrivateKey.key', encryption by password = N'DMK_UnifiedUsers');
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


-- open key for encryption
open symmetric key PasswordsKey decryption by certificate UsersCert;

-- encrypt sensitive data
update Users
set [password] = dbo.EncryptPassword('123', UserId);


IF @@ERROR <> 0 GOTO _ERROR_;


print 'Script completed without fatal errors.';

IF @@ERROR = 0 GOTO _END_;

_ERROR_:
print 'Interrupted on error';
rollback

_END_:

commit