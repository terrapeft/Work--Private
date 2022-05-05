use backoffice


drop table if exists #Customer

CREATE TABLE #Customer(
	[ContactId] [int],
	[TitleId] [tinyint] NOT NULL,
	[Forenames] [nvarchar](150) NOT NULL,
	[Surname] [nvarchar](100) NOT NULL,
	[Initials] [nvarchar](20) NULL,
	[GenderId] [tinyint] NOT NULL,
 CONSTRAINT [PK_Contactt] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
),
 CONSTRAINT [AK_Contact_K3K4K5K2K6t] UNIQUE NONCLUSTERED 
(
	[Forenames] ASC,
	[Surname] ASC,
	[Initials] ASC,
	[GenderId] ASC,
	[TitleId] ASC
)
) ON [PRIMARY]

insert into #Customer 
select Contactid, Titleid, forenames, surname, initials, genderid
from backoffice.customer.contact

declare @userid int, @ContactId int, @ContactId_backup int, @count int, @updated int = 0, @skipped int = 0,
@genderid_backup int, @titleid_backup int
declare @surname nvarchar(2014), @surname_backup nvarchar(1024)
declare @forenames nvarchar(2014), @forenames_backup nvarchar(1024)
declare @Initials nvarchar(2014), @Initials_backup nvarchar(1024)

declare mycursor cursor
for
select distinct u.userid, c.surname, c_b.surname, c.forenames, c_b.forenames, c.Initials, c_b.Initials, c.ContactId, c_b.ContactId, c_b.GenderId, c_b.TitleId
from [BackOffice].[Logon].[UserSummary] usr 
join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
join [Backoffice].[Customer].[UserContactAddress] uca on u.userid = uca.userid
join [Backoffice].[Customer].[Contact] c on uca.ContactId = c.ContactId
join [Backoffice_Backup].[Customer].[Contact] c_b on c.ContactId = c_b.ContactId
where (c.Surname like 'Replaced in terms%' or c.Forenames like 'Replaced in terms%' or c.Initials like 'GDPR')
and u.UserTypeId <> 11

open mycursor
fetch next from mycursor into @userid, @surname, @surname_backup, @forenames, @forenames_backup, @Initials, 
@Initials_backup, @ContactId, @ContactId_backup, @genderid_backup, @titleid_backup
while @@FETCH_STATUS = 0
begin
	begin try
	
		begin tran
			set @updated = @updated + 1

			update #Customer
			set  Surname = @surname_backup,
				 Forenames = @forenames_backup,
				 Initials = @Initials_backup,
				 TitleId = @titleid_backup,
				 GenderId = @genderid_backup
			where contactId = @ContactId_backup

			print cast(@updated as nvarchar(12)) 
			+ '. Update performed for UserId '+ cast(@userid as nvarchar(12))  
			+ ' ''' + isnull(@forenames, '') + ' ' + isnull(@surname, '') + ' ' + isnull(@Initials, '')
			+ ''' <-> ''' + cast(@ContactId as varchar(12)) + ' ' +  isnull(@forenames_backup, '') + ' ' + isnull(@surname_backup, '') + ' ' + isnull(@Initials_backup, '')  
			+ cast(@genderid_backup as varchar(12)) + ' ' + cast(@titleid_backup as varchar(12)) + ''''

		commit
	end try
	begin catch
		if @@trancount > 0
			rollback;
	set @skipped = @skipped + 1

	print error_message()

	print cast(@skipped as nvarchar(12)) + '. Duplicate found for UserId '+ cast(@userid as nvarchar(12)) 
	+ ' ''' + isnull(@forenames, '') + ' ' + isnull(@surname, '') + ' ' + isnull(@Initials, '')
	+ ''' <-> ''' + cast(@ContactId as varchar(12)) + ' ' +  isnull(@forenames_backup, '') + ' ' + isnull(@surname_backup, '') + ' ' + isnull(@Initials_backup, '')  
	+ cast(@genderid_backup as varchar(12)) + ' ' + cast(@titleid_backup as varchar(12)) + ''''

	end catch


--end


fetch next from mycursor into @userid, @surname, @surname_backup, @forenames, @forenames_backup, @Initials, @Initials_backup, 
@ContactId, @ContactId_backup, @genderid_backup, @titleid_backup
end

print 'Updated: ' + cast(@updated as nvarchar(12)) + ', skipped: ' + cast(@skipped as nvarchar(12))

close mycursor
deallocate mycursor

