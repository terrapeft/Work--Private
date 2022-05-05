-- get difference between all active BO users against all NCU active users

/*

drop table if exists ##inactive_users_nbo
drop table if exists ##inactive_users_ncu

declare @inThePast datetime = DATEADD(yy, -7, GETUTCDATE())
declare @deleteBefore datetime = dateadd(yy, -7, getutcdate())

;with inactive_users (userid)
as (
	/*
		Select users
	*/
	select usr.userid
	from [BackOffice].[Logon].[UserSummary] usr 
	join [BackOffice].[Logon].[SubscriptionUser] s on usr.UserId = s.UserId
	where usr.LastLogonDateTime < @inThePast

	except

	/* 
		Exclude users with recent subscriptions of any type
	*/
	select distinct usr.userid
	from [BackOffice].[Logon].[UserSummary] usr
	join (
		select UserId, max(SubscriptionEndDateTime) as SubscriptionEndDateTime
		from [BackOffice].[Logon].[SubscriptionUser] su
		join [BackOffice].[Orders].[Subscription] s on su.SubscriptionId = s.SubscriptionId
		group by UserId
		having max(SubscriptionEndDateTime) >= @inThePast
	) subs on usr.UserId = subs.UserId
	where	usr.LastLogonDateTime < @inThePast

	except

	/* 
		Exclude users with recent orders
	*/
	select usr.userid
	from [BackOffice].[Logon].[UserSummary] usr
	join (
		select UserId, max(OrderDateTime) as MostRecentDateTime
		from [BackOffice].[Customer].[UserContactAddress] ca 
		join [BackOffice].[Orders].[Orders] o on o.BillingUserContactAddressId = ca.AddressId
		group by UserId
		having max(OrderDateTime) >= @inThePast
) orders on orders.UserId = usr.UserId
where usr.LastLogonDateTime < @inThePast)
select userid
into ##inactive_users_nbo
from inactive_users



select U.[uID], U.[uUsername]
into ##inactive_users_ncu
from newcentralusers.[dbo].[UserDetails] U
	left join (
		select [S].[sUID], max([uvLastAccess]) as LastUserVisit
		from newcentralusers.[dbo].[UserVisits] UV
		join newcentralusers.[dbo].[Subscriptions] S
		on [UV].[uvSID] = [S].[sID]
		group by S.[sUID]
	) [UV] on [UV].[sUID] = U.[uID]
	left join (
		select UL.ulSID, max([ulDateTime]) as LastLoggedIn
		from newcentralusers.[dbo].[UserLogin] UL
		group by UL.ulSID
	) [IUL] on [IUL].[ulSID] = U.[uID]
	left join (
		select [sUID], max(sExpiryDate) as LastSubscriptionExpiryDate
		from newcentralusers.[dbo].[Subscriptions]
		group by [sUID]
	) [IS] on [IS].[sUID] = U.[uID]
	left join (
		select [sUID], max(sTrialExpiryDate) as LastTrialExpiryDate
		from newcentralusers.[dbo].[Subscriptions]
		group by [sUID]
	) [IT] on [IT].[sUID] = U.[uID]
	left join
	(
		select O.oUID, max(O.oOrderDate) as LastOrderDate
		from newcentralusers.[dbo].[Orders] O
		group by O.oUID
	) [IO] on [IO].oUID = U.[uID]
where
	(
		[IUL].LastLoggedIn is null -- No logins recorded
		or
		[IUL].LastLoggedIn < @deleteBefore -- Last login is more than 7 years ago
	)
	and
	(
		[UV].LastUserVisit is null -- No user visits recorded
		or
		[UV].LastUserVisit < @deleteBefore -- Last user visit is more than 7 years ago
	)
	and
	(
		[IS].LastSubscriptionExpiryDate is null -- No subscriptions with expiry date recorded
		or
		[IS].LastSubscriptionExpiryDate < @deleteBefore -- Last subscription expired more than 7 years ago
	)
	and
	(
		[IT].LastTrialExpiryDate is null -- No trials with expiry date recorded
		or
		[IT].LastTrialExpiryDate < @deleteBefore -- Last trial expired more than 7 years ago
	)
	and
	(
		[IO].LastOrderDate is null -- No orders recorded
		or
		[IO].LastOrderDate < @deleteBefore -- Last order is more than 7 years ago
	)
	and
	(
		U.uCreationDate < @deleteBefore
		and 
		U.uUpdateDate < @deleteBefore
	)
	and coalesce
	(
		[IUL].LastLoggedIn,
		[UV].LastUserVisit,
		[IS].LastSubscriptionExpiryDate,
		[IT].LastTrialExpiryDate,
		[IO].LastOrderDate
	) IS not null
	and U.[uUsername] IS not null

*/

/*
select count(*)
from ##inactive_users_nbo o join ##inactive_users_ncu u on o.userid = u.uid
*/

;with unique_ncu_inactive_users as
(
	select *
	from ##inactive_users_nbo o 
	right join ##inactive_users_ncu u on o.userid = u.uid
	where o.userid is null
) 

select 
	u.uusername as UserName, 
	uCreationDate as [NCU-CreationDate], 
	uupdatedate as [NCU-UpdateDate], 
	LastLogonDateTime as [NBO-LastLogonDateTime], 
	datetimecreated as [NBO-DateTimeCreated], 
	DateTimeUpdated as [NBO-DateTimeUpdated],
	subs.SubscriptionEndDateTime
	--orders.MostRecentDateTime
from unique_ncu_inactive_users ncu
join BackOffice.Logon.UserSummary s on ncu.uid = s.UserId
join NewCentralUsers.dbo.UserDetails u on ncu.uid = u.uid
left outer join (
	select UserId, max(SubscriptionEndDateTime) as SubscriptionEndDateTime
	from [BackOffice].[Logon].[SubscriptionUser] su
	join [BackOffice].[Orders].[Subscription] s on su.SubscriptionId = s.SubscriptionId
	group by UserId
) subs on s.UserId = subs.UserId
--left outer join (
--	select UserId, max(OrderDateTime) as MostRecentDateTime
--	from [BackOffice].[Customer].[UserContactAddress] ca 
--	join [BackOffice].[Orders].[Orders] o on o.BillingUserContactAddressId = ca.AddressId
--	group by UserId
--) orders on orders.UserId = s.UserId

order by 
	DateTimeUpdated desc
	--LastLogonDateTime desc,
	--uupdatedate desc

/*
select *
from NewCentralUsers.dbo.UserDetails 
where uusername = 'cherrytu@gmail.com'

select *
from ##inactive_users_nbo b
join BackOffice.Logon.UserS s on b.userid = s.UserId
where username = 'indraneel.karlekar@ingclarion.com'

*/