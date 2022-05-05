begin try

    begin transaction

	update [BackOffice].[Customer].[Country]
	set Country  = 'China - Hong Kong (SAR)'
	where Country = 'China - Hong Kong SAR'

	update [BackOffice].[Customer].[Country]
	set Country  = 'China - Macau (SAR)'
	where Country = 'China - Macau SAR'

	----------------------- 

	update [BackOffice].[dbo].[Countries]
	set cName =  'China - Hong Kong (SAR)'
	where cName = 'China - Hong Kong SAR'

	update [BackOffice].[dbo].[Countries]
	set cName =  'China - Macau (SAR)'
	where cName = 'China - Macau SAR'

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