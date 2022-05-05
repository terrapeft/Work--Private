begin try

    begin transaction

	update [BackOffice].[Customer].[Country]
	set IsActive = 1,
		Country = 'China - Chinese Taipei'
	where Country = 'Taiwan'

	update [BackOffice].[Customer].[Country]
	set Country  = 'China - Mainland'
	where Country = 'China'

	update [BackOffice].[Customer].[Country]
	set Country  = 'China - Hong Kong SAR'
	where Country = 'Hong Kong SAR (HKSAR)'

	update [BackOffice].[Customer].[Country]
	set Country  = 'China - Macau SAR'
	where Country = 'Macau SAR (MSAR)'

	----------------------- 

	update [BackOffice].[dbo].[Countries]
	set cName  = 'China - Mainland'
	where cName = 'China'

	update [BackOffice].[dbo].[Countries]
	set cName =  'China - Hong Kong SAR'
	where cName = 'Hong Kong SAR (HKSAR)'

	update [BackOffice].[dbo].[Countries]
	set cName =  'China - Macau SAR'
	where cName = 'Macau SAR (MSAR)'

	update [BackOffice].[dbo].[Countries]
	set cName =  'China - Chinese Taipei'
	where cName = 'Taiwan'
    
	commit transaction;

end try

begin catch
    declare @ERROR nvarchar(1000)
    select @ERROR = error_message()
    print @ERROR
    select ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage

    if @@trancount > 0
        rollback transaction;
end catch;