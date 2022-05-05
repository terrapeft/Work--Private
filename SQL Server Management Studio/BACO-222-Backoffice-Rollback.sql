begin try

    begin transaction

	update [BackOffice].[Customer].[Country]
	set IsActive = 1
	where Country = 'Taiwan'

	update [BackOffice].[Customer].[Country]
	set Country = 'Hong Kong'
	where Country = 'Hong Kong SAR (HKSAR)'

	update [BackOffice].[Customer].[Country]
	set Country = 'Macao'
	where Country = 'Macau SAR (MSAR)'

	update [BackOffice].[dbo].[Countries]
	set cName = 'Hong Kong'
	where cName = 'Hong Kong SAR (HKSAR)'

	update [BackOffice].[dbo].[Countries]
	set cName = 'Macau'
	where cName = 'Macau SAR (MSAR)'
    
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