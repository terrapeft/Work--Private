use BackOffice
go


create or alter procedure [dbo].[BO_sp_AutoArchiving]
	@selectByN int = 500,
	@deleteForYears int = 7
as
set nocount on

declare @startedAt datetime = getutcdate()
declare @inThePast datetime = dateadd(yy, -@deleteForYears, getutcdate())
declare @gdprReplacement varchar(40) = N'Replaced in terms of the GDPR compliance'; -- replication triggers rely on this value for already changed users, contacts and emails.
declare @gdprReplacementShort varchar(4) = N'GDPR';
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
		GO
	*/
	

	/*
		Interim
	*/

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) Backoffice.Interim.Addresses
			from	Backoffice.Interim.Addresses t
			join	#UsersToCheck utc on t.auid = utc.userid
			select @deleteCount = @@rowcount
			-- print 'Backoffice.Interim.Addresses: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) Backoffice.Interim.AddressUCAMap
			from	Backoffice.Interim.AddressUCAMap t
			join	#UsersToCheck utc on t.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print 'Backoffice.Interim.AddressUCAMap: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) Backoffice.Interim.RejectedContactPref
			from	Backoffice.Interim.RejectedContactPref t
			join	#UsersToCheck utc on t.uid = utc.userid
			select @deleteCount = @@rowcount
			-- print 'Backoffice.Interim.RejectedContactPref: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) Backoffice.Interim.RejectedUserAddress
			from	Backoffice.Interim.RejectedUserAddress t
			join	#UsersToCheck utc on t.uid = utc.userid
			select @deleteCount = @@rowcount
			-- print 'Backoffice.Interim.RejectedUserAddress: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) Backoffice.Interim.RejectedUsers
			from	Backoffice.Interim.RejectedUsers t
			join	#UsersToCheck utc on t.uid = utc.userid
			select @deleteCount = @@rowcount
			-- print 'Backoffice.Interim.RejectedUsers: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) Backoffice.Interim.UserDetails
			from	Backoffice.Interim.UserDetails t
			join	#UsersToCheck utc on t.uid = utc.userid
			select @deleteCount = @@rowcount
			-- print 'Backoffice.Interim.UserDetails: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) Backoffice.Interim.UserDetails_Stage
			from	Backoffice.Interim.UserDetails_Stage t
			join	#UsersToCheck utc on t.uid = utc.userid
			select @deleteCount = @@rowcount
			-- print 'Backoffice.Interim.UserDetails_Stage: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'



	/*
		Data tables
	*/
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Orders].[SubscriptionUserRegistrantType]
			from	[BackOffice].[Orders].[SubscriptionUserRegistrantType] rt 
			join	[BackOffice].[Logon].[SubscriptionUser] u on rt.SubscriptionUserId = u.SubscriptionUserId
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[SubscriptionUserRegistrantType]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top(4500) [BackOffice].[Logon].[SubscriptionUserExcluded]
			from	[BackOffice].[Logon].[SubscriptionUserExcluded] ue 
			join	[BackOffice].[Logon].[SubscriptionUser] u on ue.SubscriptionUserId = u.SubscriptionUserId
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[SubscriptionUserExcluded]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'



	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top(4500) [BackOffice].[Logon].[SubscriptionUserImportedFromQss]
			from	[BackOffice].[Logon].[SubscriptionUserImportedFromQss] qss 
			join	[BackOffice].[Logon].[SubscriptionUser] u on qss.SubscriptionUserId = u.SubscriptionUserId
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[SubscriptionUserImportedFromQss]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top(4500) [BackOffice].[Customer].[UserContactAddressPhoneNumber]
			from	[BackOffice].[Customer].[UserContactAddressPhoneNumber] ph
			join	[BackOffice].[Customer].[UserContactAddress] ad on ph.UserContactAddressId = ad.UserContactAddressId
			join	#UsersToCheck utc on ad.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[UserContactAddressPhoneNumber]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top(4500) [BackOffice].[Logon].[UserDefaultCommunication]
			from	[BackOffice].[Logon].[UserDefaultCommunication] udc 
			join	[BackOffice].[Customer].[UserContactAddress] ad on udc.UserId = ad.UserId
			join	[BackOffice].[Customer].[ActiveUserContactAddress] aca on aca.UserContactAddressId = ad.UserContactAddressId
			join	#UsersToCheck utc on udc.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[UserDefaultCommunication]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete 	[BackOffice].[Customer].[ActiveUserContactAddress]
			from	[BackOffice].[Customer].[ActiveUserContactAddress] aca 
			join	[BackOffice].[Customer].[UserContactAddress] ad on aca.UserContactAddressId = ad.UserContactAddressId
			left join [BackOffice].[Logon].[UserDefaultCommunication] udc on aca.ActiveUserContactAddressId = udc.ActiveUserContactAddressId
			join	#UsersToCheck utc on ad.userid = utc.userid
			where udc.ActiveUserContactAddressId is null
			select @deleteCount = @@rowcount
			-- print '[ActiveUserContactAddress]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top(4500) [BackOffice].[Orders].[CreditCardPayment]
			from	[BackOffice].[Orders].[CreditCardPayment] cp
			join	[BackOffice].[Orders].[CreditCard] cc on cp.CreditCardId = cc.CreditCardId
			join	[BackOffice].[Customer].[UserContactAddress] u on u.UserContactAddressId = cc.UserContactAddressId
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[CreditCard]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top(4500) [BackOffice].[Orders].[CreditCard]
			from	[BackOffice].[Orders].[CreditCard] cc 
			join	[BackOffice].[Customer].[UserContactAddress] u on u.UserContactAddressId = cc.UserContactAddressId
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[CreditCard]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[FeedManager].[RejectedQSSOrderUserContactAddress]
			from	[BackOffice].[FeedManager].[RejectedQSSOrderUserContactAddress] fm 
			join	[BackOffice].[Customer].[UserContactAddress] u on u.UserContactAddressId = fm.UserContactAddressId
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[RejectedQSSOrderUserContactAddress]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	-- [Customer]
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [Backoffice].[Customer].[UserContactPreferences]
			from	[Backoffice].[Customer].[UserContactPreferences] u
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[UserContactPreferences]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Customer].[SiteRegistered]
			from	[BackOffice].[Customer].[SiteRegistered] u
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[SiteRegistered]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Customer].[UserProductDownloads]
			from	[BackOffice].[Customer].[UserProductDownloads] u
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[UserProductDownloads]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	-- [Eden]

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Eden].[UserDemographic]
			from	[BackOffice].[Eden].[UserDemographic] u
			join	#UsersToCheck utc on u.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[UserDemographic]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Eden].[SiteDemographicAnswer]
			from	[BackOffice].[Eden].[SiteDemographicAnswer] a 
			join	[BackOffice].[Eden].[UserDemographic] ud on a.SiteDemographicAnswerId = ud.SiteDemographicAnswerId
			join	#UsersToCheck utc on ud.userid = utc.userid
			select @deleteCount = @@rowcount
			-- print '[SiteDemographicAnswer]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	-- [Audit]

	-- CreatorUserId is not an FK
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[AuditColumn]
			from	[BackOffice].[Audit].[AuditColumn]
			join	#UsersToCheck utc on CreatorUserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[UserDemographic]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	-- CreatorUserId is a FK
	-- UserId is not a FK
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) 	[BackOffice].[Audit].[ClientTaxNumber]
			from	[BackOffice].[Audit].[ClientTaxNumber] t
			join	#UsersToCheck utc on t.UserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[BackOffice].[Audit].[ClientTaxNumber] by UserId: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) 	[BackOffice].[Audit].[ClientTaxNumber]
			from	[BackOffice].[Audit].[ClientTaxNumber] t
			join	#UsersToCheck utc on t.CreatorUserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[BackOffice].[Audit].[ClientTaxNumber] by CreatorUserId: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	-- CreatorUserId is not a FK
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[OrderDetail]
			from	[BackOffice].[Audit].[OrderDetail]
			join	#UsersToCheck utc on CreatorUserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[OrderDetail]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	-- CreatorUserId is not a FK
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[Orders]
			from	[BackOffice].[Audit].[Orders]
			join	#UsersToCheck utc on CreatorUserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[Orders]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[PasswordReset]
			from	[BackOffice].[Audit].[PasswordReset] p
			join	#UsersToCheck utc on p.UserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[PasswordReset]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	-- UserId is not a FK
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[PIQUserAnswer]
			from	[BackOffice].[Audit].[PIQUserAnswer] p
			join	#UsersToCheck utc on p.UserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[PIQUserAnswer]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	-- UserId is not a FK
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[Subscription]
			from	[BackOffice].[Audit].[Subscription]
			join	#UsersToCheck utc on CreatorUserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[Subscription]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[SubscriptionUser]
			from	[BackOffice].[Audit].[SubscriptionUser] p
			join	#UsersToCheck utc on p.UserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[SubscriptionUser]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	-- SubscriptionUserId is not a FK
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[SubscriptionUserExcluded]
			from	[BackOffice].[Audit].[SubscriptionUserExcluded]
			join	#UsersToCheck utc on SubscriptionUserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[SubscriptionUserExcluded]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	-- SubscriptionUserId is not a FK
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[SubscriptionUserOption]
			from	[BackOffice].[Audit].[SubscriptionUserOption]
			join	#UsersToCheck utc on SubscriptionUserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[SubscriptionUserOption]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[UserContactPreferences]
			from	[BackOffice].[Audit].[UserContactPreferences] u
			join	#UsersToCheck utc on u.UserId = utc.UserId 
			select @deleteCount = @@rowcount
			-- print '[BackOffice].[Audit].[UserContactPreferences] by UserId: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[UserContactPreferences]
			from	[BackOffice].[Audit].[UserContactPreferences] u
			join	#UsersToCheck utc on u.CreatorUserId = utc.UserId 
			select @deleteCount = @@rowcount
			-- print '[BackOffice].[Audit].[UserContactPreferences] by CreatorUserId: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'
	

	-- UserId is not a foreign key
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[Users]
			from	[BackOffice].[Audit].[Users] u
			join	#UsersToCheck utc on u.UserId = utc.UserId 
			select @deleteCount = @@rowcount
			-- print '[BackOffice].[Audit].[Users] by UserId: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	-- UserId is not a foreign key
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Audit].[Users]
			from	[BackOffice].[Audit].[Users] u
			join	#UsersToCheck utc on u.CreatorUserId = utc.UserId
			select @deleteCount = @@rowcount
			-- print '[BackOffice].[Audit].[Users] by CustomerUserId: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

	--	Delete user subscriptions (depends on Audit.PasswordReset)
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) [BackOffice].[Logon].[SubscriptionUser]
			from	[BackOffice].[Logon].[SubscriptionUser] u
			join	#UsersToCheck utc on u.UserId = utc.userid
			select @deleteCount = @@rowcount
			-- print '[Users]: ' + cast (@deleteCount as varchar(10))
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'

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

		update	BackOffice.Customer.UserContactAddress set
				ContactId = @gdprContactId,
				EmailAddressId = @gdprEmailAddressId,
				JobTitleId = 0, -- 'UNKNOWN'
				AddressId = 0, -- '0	AddressLine1	AddressLine2	AddressLine3	City	Postcode	0	Province	0'
				CompanyId = 0, -- 'UNKNOWN'
				DateTimeCreated = getdate(),
				--CreatorUserId = null, -- there is a check constraint, which doesn't allow to have both these users set to null
				--CreatorCultUserId = null,
				ReasonId = 0 -- 'none'
		from	BackOffice.Customer.UserContactAddress u
		join	#UsersToCheck utc on u.UserId = utc.userid

/************************************************/			
		-- print 'Update, [Contact]: ' + cast (@deleteCount as varchar(10))
		commit
	end try
	begin catch
		if @@trancount > 0
			rollback
		-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
		insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage])
		values (@logRecordId, error_line(), error_message())
		;throw
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
		commit
	end try
	begin catch
		if @@trancount > 0
			rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
		insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage])
		values (@logRecordId, error_line(), error_message())
		;throw
		end catch
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'


	set @startTime = getdate()
	set @deleteCount = 0
	begin try
		begin transaction
		update	BackOffice.Logon.UserSummary set 
				FirstLoggedOnDateTime = null,
				LastLogonDateTime = null,
				LogonCount = 0,
				CreatorApplicationId = 0,
				CreatorUserId = null,
				CreatorCultUserId = null,
				DateTimeCreated = getdate(),
				UpdateApplicationId = null,
				UpdateUserId = null,
				UpdateCultUserId = null,
				DateTimeUpdated = null,
				ReasonId = null,
				RegisteredViaSiteId = null
		from	BackOffice.Logon.UserSummary u
		join	#UsersToCheck utc on u.UserId = utc.userid
			
		select @deleteCount = @@rowcount
		-- print 'Update, UserContactAddress: ' + cast (@deleteCount as varchar(10))
		commit
	end try
	begin catch
		if @@trancount > 0
			rollback
			set @deleteCount = 0
			-- print 'Error on line ' + cast(error_line() as varchar(10)) + ', ' + error_message()
		insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage])
		values (@logRecordId, error_line(), error_message())
		;throw
	end catch
	-- print 'Took ' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + ' seconds.'
	
	WAYOUT:

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




