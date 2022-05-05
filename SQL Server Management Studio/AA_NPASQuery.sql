use backoffice_backup


/*

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


/*

select distinct u.userid
into #sut
from [BackOffice].[Logon].[UserSummary] usr 
join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
join [Backoffice].[Customer].[UserContactAddress] uca on u.userid = uca.userid
join [Backoffice].[Customer].[Contact] c on uca.ContactId = c.ContactId
where (c.Surname like 'Replaced in terms%' or c.Forenames like 'Replaced in terms%' or c.Initials like 'GDPR')
and u.UserTypeId <> 11

*/


;with inactive_users (userid)
as (
	/*
		Select users
	*/
	select usr.userid
	from [Logon].[UserSummary] usr 
	join [Logon].[Users] u on usr.UserId = u.UserId
	join [Customer].[UserContactAddress] uca on u.userid = uca.userid
	where isnull(usr.LastLogonDateTime, datefromparts(1970, 1, 1)) < dateadd(yy, -7, getutcdate())
	--and isnull(usr.DateTimeCreated, datefromparts(1970, 1, 1)) < dateadd(yy, -7, getutcdate())
	--and u.UserName not like ('%@euromoneyplc.com') and u.UserName not like ('%@arcadia.spb.ru')
	and u.UserTypeId not in (11)

	except

	/* 
		Exclude users with recent subscriptions of any type
	*/
	select distinct usr.userid
	from [Logon].[UserSummary] usr
	join [Logon].[Users] u on usr.UserId = u.UserId
	join (
		select UserId, max(SubscriptionEndDateTime) as SubscriptionEndDateTime
		from [Logon].[SubscriptionUser] su
		join [Orders].[Subscription] s on su.SubscriptionId = s.SubscriptionId
		group by UserId
		having max(SubscriptionEndDateTime) >= dateadd(yy, -7, getutcdate()) or max(SubscriptionEndDateTime) is null
	) subs on usr.UserId = subs.UserId
	where isnull(usr.LastLogonDateTime, datefromparts(1970, 1, 1)) < dateadd(yy, -7, getutcdate())
	and u.UserTypeId not in (11)

	except

	/* 
		Exclude users with recent orders
	*/
	select usr.userid
	from [Logon].[UserSummary] usr
	join [Logon].[Users] u on usr.UserId = u.UserId
	join (
		select UserId, max(OrderDateTime) as MostRecentDateTime
		from [Customer].[UserContactAddress] ca 
		join [Orders].[Orders] o on o.BillingUserContactAddressId = ca.AddressId
		group by UserId
		having max(OrderDateTime) >= dateadd(yy, -7, getutcdate()) or max(OrderDateTime) is null
	) orders on orders.UserId = usr.UserId
	where isnull(usr.LastLogonDateTime, datefromparts(1970, 1, 1)) < dateadd(yy, -7, getutcdate())
	and u.UserTypeId not in (11)
)

insert into #OldUsers
select userid
from inactive_users
*/

select distinct u.userid, c.contactid, *
from	[BackOffice].[Customer].[Contact] c
join	[BackOffice].[Customer].[UserContactAddress] u on u.ContactId = c.ContactId
join	[Backoffice].[Customer].[ActiveUserContactAddress] auca 
join	#OldUsers utc on u.UserId = utc.userid
join	#sut s on u.UserId = s.userid
order by u.userid, c.contactid
/*
select count(*)
from	[BackOffice].[Customer].[EmailAddress] ead 
join	[BackOffice].[Customer].[UserContactAddress] u on u.EmailAddressId = ead.EmailAddressId
join	#UsersToCheck utc on u.UserId = utc.userid
where u.userid in (23826)
*/
