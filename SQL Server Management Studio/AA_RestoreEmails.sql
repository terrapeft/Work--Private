
declare @userid int, @usertypeid int,  @emailaddressid int, @emailaddressid_backup int, @count int, @updated int = 0, @skipped int = 0
declare @emailaddress nvarchar(2014), @emailaddress_backup nvarchar(1024)

declare mycursor cursor
for
select distinct u.userid, u.usertypeid, ead.emailaddress, ead_b.emailaddress, ead.emailaddressid, ead_b.emailaddressid
from [BackOffice].[Logon].[UserSummary] usr 
join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
join [Backoffice].[Customer].[UserContactAddress] uca on u.userid = uca.userid
join [Backoffice].[Customer].[EmailAddress] ead on uca.EmailAddressId = ead.EmailAddressId
join [Backoffice_Backup].[Customer].[EmailAddress] ead_b on ead.EmailAddressId = ead_b.EmailAddressId
where ead.emailaddress like 'Replaced in terms%'
and u.UserTypeId <> 11

open mycursor
fetch next from mycursor into @userid, @usertypeid, @emailaddress, @emailaddress_backup, @emailaddressid, @emailaddressid_backup
while @@FETCH_STATUS = 0
begin


if exists (
	select distinct a.emailaddressid, a_b.EmailAddress
	from backoffice.customer.emailaddress a
	join backoffice.customer.usercontactaddress uca on a.emailaddressid = uca.emailaddressid
	join backoffice.logon.users u on uca.userid = u.userid
	left join [Backoffice_Backup].[Customer].[EmailAddress] a_b on a.EmailAddressId = a_b.EmailAddressId
	where u.userid = @userid 
	and a_b.emailaddress is null
)
begin
	set @skipped = @skipped + 1
	print cast(@skipped as nvarchar(12)) + '. Duplicate found for UserId '+ cast(@userid as nvarchar(12)) + ' ''' + @emailaddress + ''' <-> ''' + @emailaddress_backup + ''''
end
	else
begin
	begin try
		begin tran
		set @updated = @updated + 1
		-- update emails
		update [Backoffice].[Customer].[EmailAddress]
		set  emailaddress = @emailaddress_backup
		where emailaddressid = @emailaddressid

		print cast(@updated as nvarchar(12)) + '. Update performed for UserId '+ cast(@userid as nvarchar(12)) + ' ''' + @emailaddress + ''' <-> ''' + @emailaddress_backup + ''''

		commit
	end try
	begin catch
		if @@trancount > 0
			rollback;
		throw
	end catch
end

fetch next from mycursor into @userid, @usertypeid, @emailaddress, @emailaddress_backup, @emailaddressid, @emailaddressid_backup
end

print 'Updated: ' + cast(@updated as nvarchar(12)) + ', skipped: ' + cast(@skipped as nvarchar(12))

close mycursor
deallocate mycursor


