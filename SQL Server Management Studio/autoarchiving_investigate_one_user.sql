/*
*
* Investigating on example of pratikray@hsbc.com.sg
*
*/


-- expired users for next run on PROD
/*

drop table if exists ##expired
declare @deleteBefore datetime = dateadd(yy, -7, getutcdate())

select u.uid
into ##expired
from NewCentralUsers.[dbo].[UserDetails] U
	left join (
		select [S].[sUID], max([uvLastAccess]) as LastUserVisit
		from NewCentralUsers.[dbo].[UserVisits] UV
		join NewCentralUsers.[dbo].[Subscriptions] S
		on [UV].[uvSID] = [S].[sID]
		group by S.[sUID]
	) [UV] on [UV].[sUID] = U.[uID]
	left join (
		select UL.ulSID, max([ulDateTime]) as LastLoggedIn
		from NewCentralUsers.[dbo].[UserLogin] UL
		group by UL.ulSID
	) [IUL] on [IUL].[ulSID] = U.[uID]
	left join (
		select [sUID], max(sExpiryDate) as LastSubscriptionExpiryDate
		from NewCentralUsers.[dbo].[Subscriptions]
		group by [sUID]
	) [IS] on [IS].[sUID] = U.[uID]
	left join (
		select [sUID], max(sTrialExpiryDate) as LastTrialExpiryDate
		from NewCentralUsers.[dbo].[Subscriptions]
		group by [sUID]
	) [IT] on [IT].[sUID] = U.[uID]
	left join
	(
		select O.oUID, max(O.oOrderDate) as LastOrderDate
		from NewCentralUsers.[dbo].[Orders] O
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
	and coalesce
	(
		[IUL].LastLoggedIn,
		[UV].LastUserVisit,
		[IS].LastSubscriptionExpiryDate,
		[IT].LastTrialExpiryDate,
		[IO].LastOrderDate
	) IS not null
	and U.[uUsername] IS not null


select s.*, d.*
from ##expired e
join BackOffice.logon.usersummary s on e.uid = s.userid
join NewCentralUsers.dbo.userdetails d on s.userid = d.uid
order by datetimeupdated 

*/

-- "random"

-- users in NCU
declare @users table (uid int)

declare @take int = 1
declare @skip int = 0

-- get few users from deletion list who have pending records in a queue
insert into @users
select distinct e.uid
from ##expired e 
join [BackOffice].[Interim].[SubscriptionUser_Stage] ss on e.uid = userid
order by e.uid
offset (@skip) rows 
fetch next (@take) rows only

SELECT *
FROM [NewCentralUsers].[dbo].[Subscriptions] s
join [BackOffice].[Interim].[SubscriptionUser_Stage] ss on suid=userid
where suid in (select uid from @users)

-- users in BO
SELECT *
FROM [BackOffice].[Logon].[SubscriptionUser] s
join [BackOffice].[Interim].[SubscriptionUser_Stage] ss on s.userid=ss.userid
where s.userid in (select uid from @users)

-- sync queue
SELECT *
FROM [BackOffice].[Interim].[SubscriptionUser_Stage]
where userid in (select uid from @users)


-- specific user ids
/*
-- users in NCU
SELECT *
FROM [NewCentralUsers].[dbo].[Subscriptions]
where suid = 2384505

-- users in BO
SELECT *
FROM [BackOffice].[Logon].[SubscriptionUser]
where userid = 2384505

-- sync queue
SELECT *
FROM [BackOffice].[Interim].[SubscriptionUser_Stage]
where userid = 2384505

-- size of the queue
SELECT count(*) as [Interim Subscriptions in a Queue]
FROM [BackOffice].[Interim].[SubscriptionUser_Stage]

-- nothing goes out
SELECT top 10000 * 
FROM [BackOffice].[Interim].[SubscriptionUser_Stage]
order by DateTimeCreated desc

*/


