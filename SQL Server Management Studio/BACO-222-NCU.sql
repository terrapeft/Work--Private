begin try
   
	begin transaction

	update [NewCentralUsers].[dbo].[Countries]
	set cVisibleInHop2 = 1,
		cName = 'China - Chinese Taipei'
	where cName = 'Taiwan'

	update [NewCentralUsers].[dbo].[Countries]
	set cName  = 'China - Mainland'
	where cName = 'China'

	update [NewCentralUsers].[dbo].[Countries]
	set cName =  'China - Hong Kong SAR'
	where cName = 'Hong Kong SAR (HKSAR)'

	update [NewCentralUsers].[dbo].[Countries]
	set cName =  'China - Macau SAR'
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

/*

select *
from [BackOffice].[dbo].[Countries]
where cid in (3, 210, 13, 145, 23)
order by cname

select *
from [BackOffice].[Customer].[Country]
where countryid in (98, 129, 215, 45)
order by country

select * 
from [NewCentralUsers].[dbo].[Countries]
where cid in (3, 210, 13, 145, 23)
order by cname

*/