begin try
   
	begin transaction

	update [NewCentralUsers].[dbo].[Countries]
	set cVisibleInHop2 = 1
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