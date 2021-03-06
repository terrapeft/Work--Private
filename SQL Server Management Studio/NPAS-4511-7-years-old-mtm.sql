declare @inThePast datetime = DATEADD(yy, -7, GETUTCDATE())

/*

1.	Get users who had logged on more than 7 years ago

	Looks like the [LastLogonDateTime] is correctly updated for users and it corresponds information in 
	[dbo].[PersitentLogon] (differs on milliseconds)

	Tables [Logon].[Cookie], [Logon].[CookieUserLogin], [Logon].[SubscriptionLogon] are empty.

2.	Subscriptions and trials; 
	kept in one table, differs by the SubscriptionTypeId field value.
	Currently all types of subscriptions are taken into account:

	SubscriptionTypeId	SubscriptionType	SubscriptionTypeDescription
	--------------------------------------------------------------------------
	1					Registration		Registration to the product only
	2					Trial				Trial access to the product
	3					Subscription		Subscription access to the product
	5					Book				Access to the book product
	6					CAP Donor			CAP Donor Subscription

	Gives the same count, when limited to ids 2 and 3.

*/

/*
select count(*)
from [BackOffice].[Logon].[UserSummary]
where LastLogonDateTime < @inThePast
*/

/* 
	Take users who logged in longer than 7 years ago
*/
select count(*) from (
select 
	usr.userid, 
	sub.MostRecentDateTime as 'DateTime', 
	LastLogonDateTime 
from [BackOffice].[Logon].[UserSummary] usr 
left join (
	/* find recent subscriptions */
	select UserId, max(SubscriptionEndDateTime) as MostRecentDateTime
	from [BackOffice].[Logon].[SubscriptionUser] su
	join [BackOffice].[Orders].[Subscription] s on su.SubscriptionId = s.SubscriptionId
	group by UserId
	having max(SubscriptionEndDateTime) < @inThePast
) sub on usr.UserId = sub.UserId
where 
--sub.UserId is null -- exclude those who has recent subscriptions
--and	
usr.LastLogonDateTime < @inThePast

union 

/* 
	Take users who logged in longer than 7 years ago
*/
select 
	usr.userid, 
	orders.MostRecentDateTime as 'DateTime',
	LastLogonDateTime
from [BackOffice].[Logon].[UserSummary] usr
left join (
	/* find recent Orders */
	select UserId, max(OrderDateTime) as MostRecentDateTime
	from [BackOffice].[Customer].[UserContactAddress] bu 
	join [BackOffice].[Orders].[Orders] o on o.BillingUserContactAddressId = bu.AddressId
	group by UserId
	having max(OrderDateTime) < @inThePast
) orders on orders.UserId = usr.UserId
where 
--orders.UserId is null -- exclude users with recent orders
--and	
usr.LastLogonDateTime < @inThePast

) f