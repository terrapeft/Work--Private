use BackOffice
go


declare @selectByN int = 500
declare @deleteForYears int = 7


declare @startedAt datetime = getutcdate()
declare @inThePast datetime = dateadd(yy, -7, getutcdate())
declare @gdprReplacement varchar(80) = N'testing gdpr.'; -- replication triggers rely on this value for already changed users, contacts and emails.
declare @gdprReplacementShort varchar(4) = N'tsts';
declare @logRecordId int

declare @startTime datetime = getdate()

drop table if exists #UsersToCheck;
drop table if exists #OldUsers;

create table #UsersToCheck
(
	UserID int not null primary key
);

create table #OldUsers
(
	UserID int not null primary key
);

;with inactive_users (userid)
as (
	/*
		Select users
	*/
	select usr.userid
	from [BackOffice].[Logon].[UserSummary] usr 
	join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
	join [Backoffice].[Customer].[UserContactAddress] uca on u.userid = uca.userid
	where isnull(usr.LastLogonDateTime, datefromparts(1970, 1, 1)) < @inThePast
	and isnull(usr.DateTimeCreated, datefromparts(1970, 1, 1)) < @inThePast
	and u.UserName not like ('%@euromoneyplc.com') and u.UserName not like ('%@arcadia.spb.ru')
	and u.UserTypeId not in (1,2,3,4,11)

/*
	UserTypeId	UserType		UserTypeDescription
	---------------------------------------------------------------------------------------------------
	0			Standard		Standard user
	1			Internal		A user that is not one or more of the other user types
	2			Test			Test user that was created to test one or more elements of the system
	3			Service			Service account user; the user is used to bulk load data into the system.
	4			Test Service	Test service account; this is used to test the bulk data load process under which all new and amended users will be test users
	5			UKDirect	
	6			UKDonor	
	7			UKAgent	
	8			OverseasDirect	
	9			OverseasDonor
	10			OverseasAgent
	11			No Longer User
	12			CntrldCirculation
	13			Frees
*/



	except

	/* 
		Exclude users with recent subscriptions of any type
	*/
	select distinct usr.userid
	from [BackOffice].[Logon].[UserSummary] usr
	join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
	join (
		select UserId, max(SubscriptionEndDateTime) as SubscriptionEndDateTime
		from [BackOffice].[Logon].[SubscriptionUser] su
		join [BackOffice].[Orders].[Subscription] s on su.SubscriptionId = s.SubscriptionId
		group by UserId
		having max(SubscriptionEndDateTime) >= @inThePast or max(SubscriptionEndDateTime) is null
	) subs on usr.UserId = subs.UserId
	where isnull(usr.LastLogonDateTime, datefromparts(1970, 1, 1)) < @inThePast
	and u.UserTypeId not in (1,2,3,4,11)

	except

	/* 
		Exclude users with recent orders
	*/
	select usr.userid
	from [BackOffice].[Logon].[UserSummary] usr
	join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
	join (
		select UserId, max(OrderDateTime) as MostRecentDateTime
		from [BackOffice].[Customer].[UserContactAddress] ca 
		join [BackOffice].[Orders].[Orders] o on o.BillingUserContactAddressId = ca.AddressId
		group by UserId
		having max(OrderDateTime) >= @inThePast or max(OrderDateTime) is null
	) orders on orders.UserId = usr.UserId
	where isnull(usr.LastLogonDateTime, datefromparts(1970, 1, 1)) < @inThePast
	and u.UserTypeId not in (1,2,3,4,11)
)

insert into #OldUsers
select userid
from inactive_users


/*
	Take first set of users
*/
insert #UsersToCheck 
select top(@selectByN) userid
from #OldUsers

declare @usersCount int, @thereAreSomeMoreUsers int, @step int = 0, @steps int, @progress int, @stepValue int
set @usersCount = (select count(*) from #OldUsers)
set @steps = ceiling(cast(@usersCount as float)/@selectByN)
set @stepValue = iif(@steps = 0, 0, ceiling(100/@steps)) 

set @thereAreSomeMoreUsers = @usersCount

-- Add parent log record
insert into [NewCentralUsers].[dbo].[AutoArchiving_Log] (alStartedAtUtc, alUsersCount, alLastUpdatedAtUtc, alDatabaseId) 
values (@startedAt, @usersCount, getutcdate(), 2)
set @logRecordId = @@identity
-- print 'Log record Id: ' + cast(@logRecordId as varchar(10))
-- print 'Initialization took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

declare @lapTime datetime

/*
	Iterate through the inactive users
*/
while @thereAreSomeMoreUsers > 0
begin /* MAIN */
	
	set @lapTime = getdate()
	
	-- current step
	set @step = @step + 1
	set @progress = ceiling((@step*100)/@steps) - @stepValue

	-- print 'Lap ' + cast(@step as varchar(10)) + ' of ' + cast(@steps as varchar(10))

	declare @hasErrors bit
	set @hasErrors = (select top 1 1 from [NewCentralUsers].[dbo].[AutoArchiving_Errors] where aeAlId = @logRecordId)

	update [NewCentralUsers].[dbo].[AutoArchiving_Log]
	set [alProgressPercent] = @progress,
		[alLastUpdatedAtUtc] = getutcdate(),
		[alhasErrors] = @hasErrors
	where alId = @logRecordId

	declare @deleteCount int


	/*
		Updates
	*/
	set @startTime = getdate()
	set @deleteCount = 0
	begin try
		begin transaction
/************************************************/

		-- thirty times faster with temp tables, then the same logic without them
		drop table if exists #all_contacts
		drop table if exists #filtered_contacts

		-- step 1, select * contacts for expired users
		select distinct c.contactid
		into #all_contacts
		from [BackOffice].[Customer].[Contact] c
		join [BackOffice].[Customer].[UserContactAddress] u on u.ContactId = c.ContactId
		join #UsersToCheck utc on u.UserId = utc.UserId

		-- step 2, select contacts which are not shared between users
		select c.ContactId
		into #filtered_contacts
		from [BackOffice].[Customer].[Contact] c
		join [BackOffice].[Customer].[UserContactAddress] u on u.ContactId = c.ContactId
		join #all_contacts ac on c.ContactId = ac.ContactId
		group by c.ContactId
		having count(distinct u.UserId) = 1

		update	[BackOffice].[Customer].[Contact] set
				Forenames = @gdprReplacement + cast(newid() as char(36)),
				Surname = @gdprReplacement,
				Initials = @gdprReplacementShort,
				GenderId = 0 -- 'UNKNOWN'
		from	[BackOffice].[Customer].[Contact] c
		join	#filtered_contacts fc on c.ContactId = c.ContactId


/************************************************/			
		select @deleteCount = @@rowcount
		-- print 'Update, [Contact]: ' + cast (@deleteCount as varchar(10))
		rollback
	end try
	begin catch
		if @@trancount > 0
			rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
		insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage])
		values (@logRecordId, error_line(), error_message())
		-- ;throw
		end catch
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 0
	begin try
		begin transaction

/************************************************/

		-- thirty times faster with temp tables, then the same logic without them
		drop table if exists #all_emails
		drop table if exists #filtered_emails

		-- step 1, select * emails for expired users
		select distinct ead.emailaddressId
		into #all_emails
		from	[BackOffice].[Customer].[EmailAddress] ead 
		join	[BackOffice].[Customer].[UserContactAddress] u on u.EmailAddressId = ead.EmailAddressId
		join #UsersToCheck utc on u.UserId = utc.UserId

		-- check if email is shared by one user
		select ead.emailaddressId
		into #filtered_emails
		from	[BackOffice].[Customer].[EmailAddress] ead 
		join	[BackOffice].[Customer].[UserContactAddress] u on u.EmailAddressId = ead.EmailAddressId
		join #all_emails ae on ead.emailaddressId = ae.emailaddressId
		group by ead.emailaddressId
		having count(distinct u.UserId) = 1

		update	[BackOffice].[Customer].[EmailAddress] set 
				EmailAddress = @gdprReplacement + cast(newid() as char(36)) 
		from	[BackOffice].[Customer].[EmailAddress] ead 
		join	#filtered_emails fe on ead.emailaddressId = fe.emailaddressid


/************************************************/			
		select @deleteCount = @@rowcount
		-- print 'Update, [EmailAddress]: ' + cast (@deleteCount as varchar(10))
		rollback
	end try
	begin catch
		if @@trancount > 0
			rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
		insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage])
		values (@logRecordId, error_line(), error_message())
		-- ;throw
		end catch
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 0
	begin try
		begin transaction

		update	BackOffice.Logon.Users	set 
				UserName = @gdprReplacement + cast(newid() as char(36)),
				EncryptPassword = right(cast(newid() as char(36)), 25),
				IsLockedOut = 1,
				UserTypeId = 11 -- 'No Longer User'
		from	BackOffice.Logon.Users u
		join	#UsersToCheck utc on u.UserId = utc.userid
			
		select @deleteCount = @@rowcount
		-- print 'Update, Users: ' + cast (@deleteCount as varchar(10))
		rollback
	end try
	begin catch
		if @@trancount > 0
			rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
		insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage])
		values (@logRecordId, error_line(), error_message())
		-- ;throw
		end catch
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'






	delete tu from #OldUsers tu join #UsersToCheck ch on tu.UserID = ch.UserID
	delete from #UsersToCheck

	insert #UsersToCheck select top(@selectByN) userid from #OldUsers
	set @thereAreSomeMoreUsers = @@rowcount

	declare @left int
	set @left = (select count(*) from #OldUsers)
	-- print '************************************************************************'
	-- print 'Lap time: ' + cast(datediff(ss, @lapTime, getdate()) as varchar(10)) + ' seconds, records left: ' + cast(@left as varchar(10))
	
end /* MAIN */

update [NewCentralUsers].[dbo].[AutoArchiving_Log]
set [alFinishedAtUtc] = getutcdate(),
	[alLastUpdatedAtUtc] = getutcdate(),
	[alProgressPercent] = 100
where alId = @logRecordId

drop table if exists #UsersToCheck;
drop table if exists #OldUsers;




