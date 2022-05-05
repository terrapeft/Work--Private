USE [NewCentralUsers]

BEGIN TRY
	BEGIN TRANSACTION

	--  1. Rollback existing EDEN codes
		update [NewCentralUsers].[dbo].[EdenCode]
		set edcName = 'Corporate Finance'
		where edcCode = '1560'

	--  2. Delete group-code mappings
		delete from [NewCentralUsers].[dbo].[EdenGroupCodes]
		where egcCodeId IN (select edcCodeID from [NewCentralUsers].[dbo].[EdenCode] 
		where edccode in ( '1560', '1561', '1562', '1563', '1564', '1565', 
				'6732', '6733', '6734', '6735', '6736', '6737', '6738', '6739', '6740', '6741', '6742', '6743',
				'9614', '9615', '9616', '9617', '9618', '9619', '9620', '9621', '9622', '9623', '9624', '9625'))

	--  3. Delete eden codes
		delete from [NewCentralUsers].[dbo].[EdenCode] 
		where edccode in ( '1561', '1562', '1563', '1564', '1565', 
				'6732', '6733', '6734', '6735', '6736', '6737', '6738', '6739', '6740', '6741', '6742', '6743',
				'9614', '9615', '9616', '9617', '9618', '9619', '9620', '9621', '9622', '9623', '9624', '9625')

	-- 4. Delete Job Function group
	    delete from [NewCentralUsers].[dbo].[EdenGroup] 
		where edgPublicationID = 5027 and edgText = 'Job Function'

	COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	DECLARE @error NVARCHAR(1000)
	SELECT @error = ERROR_MESSAGE()
	PRINT @error
	SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage

	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
END CATCH;