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
	begin try
		begin transaction
/************************************************/
		declare 
			@gdprContactId int,
			@gdprEmailAddressId int
		if not exists (select 1 from customer.contact where forenames = 'GDPR Replacement' and surname = 'GDPR Replacement' and titleid = 0 and genderid = 0 and initials is null)
			insert into Customer.Contact (TitleId, Forenames, Surname, Initials, GenderId)
			values (0, 'GDPR Replacement', 'GDPR Replacement', null, 0)

		select @gdprContactId = ContactId 
		from customer.contact 
		where forenames = 'GDPR Replacement' 
		and surname = 'GDPR Replacement' 
		and titleid = 0 
		and genderid = 0 
		and initials is null

		if not exists (select 1 from customer.emailaddress where emailaddress = 'GDPR Replacement')
			insert into Customer.emailaddress (emailaddress)
			values ('GDPR Replacement')

		select @gdprEmailAddressId = emailaddressid
		from Customer.EmailAddress
		where emailaddress = 'GDPR Replacement' 

		update [BackOffice].[Customer].[UserContactAddress]
			set ContactId = @gdprContactId,
				EmailAddressId = @gdprEmailAddressId,
				ParentUserContactAddressId = null,
				AddressId = 0,
				CompanyId = 0,
				ApplicationId = 0,
				JobTitleId = 0
		from [BackOffice].[Customer].[UserContactAddress] u
		join #UsersToCheck utc on u.UserId = utc.UserId


/************************************************/			
		--select @deleteCount = @@rowcount
		-- print 'Update, [Contact]: ' + cast (@deleteCount as varchar(10))
		rollback
	end try
	begin catch
		if @@trancount > 0
			rollback
		;throw
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


