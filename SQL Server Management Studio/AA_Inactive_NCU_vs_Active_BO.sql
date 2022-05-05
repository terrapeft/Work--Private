/*
	For NCU inactive users which are active in BO, 
	shows all dates influencing on the decicions	

*/


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
	where isnull(usr.LastLogonDateTime, datefromparts(1970, 1, 1)) < @inThePast

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
		having max(SubscriptionEndDateTime) >= @inThePast or max(SubscriptionEndDateTime) is null
	) subs on usr.UserId = subs.UserId
	where isnull(usr.LastLogonDateTime, datefromparts(1970, 1, 1)) < @inThePast

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
		having max(OrderDateTime) >= @inThePast or max(OrderDateTime) is null
) orders on orders.UserId = usr.UserId
where isnull(usr.LastLogonDateTime, datefromparts(1970, 1, 1)) < @inThePast)

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
	--and
	--(
	--	U.uCreationDate < @deleteBefore
	--	and 
	--	U.uUpdateDate < @deleteBefore
	--)
	and coalesce
	(
		[IUL].LastLoggedIn,
		[UV].LastUserVisit,
		[IS].LastSubscriptionExpiryDate,
		[IT].LastTrialExpiryDate,
		[IO].LastOrderDate
	) IS not null
	and U.[uUsername] IS not null


/*

select count(*) from ##inactive_users_ncu
select count(*) from ##inactive_users_nbo

select count(*)
from ##inactive_users_nbo o join ##inactive_users_ncu u on o.userid = u.uid


*/

;with unique_ncu_inactive_users as
(
	select *
	--select count(*)
	from ##inactive_users_nbo o 
	right join ##inactive_users_ncu u on o.userid = u.uid
	where o.userid is null
) 

select top 1000
	u.uid,
	u.uusername as UserName, 
	--uCreationDate as [NCU-CreationDate], 
	--uupdatedate as [NCU-UpdateDate], 
	iul.LastLoggedIn as [NCU-LastLoggedIn],
	dateadd(yy, 7, iul.LastLoggedIn) as [NCU-ExpiredAt],
	LastSubscriptionExpiryDate as [NCU-LastSubscriptionExpiryDate],
	LastTrialExpiryDate as [NCU-LastTrialExpiryDate],
	LastOrderDate as [NCU-LastOrderDate],
	LastLogonDateTime as [NBO-LastLogonDateTime], 
	--datetimecreated as [NBO-DateTimeCreated], 
	--DateTimeUpdated as [NBO-DateTimeUpdated],
	subs.SubscriptionEndDateTime as [NBO-Subs-SubscriptionEndDateTime],
	orders.MostRecentDateTime as [NBO-Orders-MostRecentDateTime]
from unique_ncu_inactive_users ncu
join BackOffice.Logon.UserSummary s on ncu.uid = s.UserId
join backoffice.logon.users us on s.userid = us.userid
join NewCentralUsers.dbo.UserDetails u on ncu.uid = u.uid
left outer join (
		select UL.ulSID, max([ulDateTime]) as LastLoggedIn
		from newcentralusers.[dbo].[UserLogin] UL
		group by UL.ulSID
) [IUL] on [IUL].[ulSID] = ncu.uid
left outer join (
		select [sUID], max(sExpiryDate) as LastSubscriptionExpiryDate
		from newcentralusers.[dbo].[Subscriptions]
		group by [sUID]
	) [IS] on [IS].[sUID] = ncu.[uID]
left outer join (
		select [sUID], max(sTrialExpiryDate) as LastTrialExpiryDate
		from newcentralusers.[dbo].[Subscriptions]
		group by [sUID]
	) [IT] on [IT].[sUID] = ncu.[uID]
left outer join	(
		select O.oUID, max(O.oOrderDate) as LastOrderDate
		from newcentralusers.[dbo].[Orders] O
		group by O.oUID
	) [IO] on [IO].oUID = ncu.[uID]
left outer join (
	select UserId, max(SubscriptionEndDateTime) as SubscriptionEndDateTime
	from [BackOffice].[Logon].[SubscriptionUser] su
	join [BackOffice].[Orders].[Subscription] s on su.SubscriptionId = s.SubscriptionId
	group by UserId
) subs on subs.UserId = ncu.uid
left outer join (
	select UserId, max(OrderDateTime) as MostRecentDateTime
	from [BackOffice].[Customer].[UserContactAddress] ca 
	join [BackOffice].[Orders].[Orders] o on o.BillingUserContactAddressId = ca.AddressId
	group by UserId
) orders on orders.UserId = ncu.uid
order by orders.MostRecentDateTime desc
	--iul.LastLoggedIn desc
