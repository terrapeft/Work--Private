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

	The chain:
	The User depends on UserContactAddress, the UserContactAddress depends on the Orders, 
	the Orders depends on the OrderDetail, the OrderDetail depends on the Subscription,
	the Subscription depends on the SubscriptionUser, which contains multiple users for one Subscription.
	We can delete the SubscriptionUser record, but cannot delete the Subscription, 
	because there are other SubscriptionUser records for other users.
	We cannot delete User, bacause its ID also is used in the UserContactAddress, and so on.



	- Cannot delete Orders.OrderDetail, because Orders.Subscription has OrderDetailId FK and requires Orders.Subscription to be deleted.
	- Cannot delete Orders.Subscription because it has many-to-many relationship with Users.
	- Cannot delete Customer.UserContactAddress - the Orders.Orders has BillingUserContactAddressId FK
	- Cannot delete Customer.Contact because it depends on Customer.UserContactAddress

	- No need to join UserSummary with UsercontactAddreess in order to skip group emails as groups are not somewhere in users

*/


/*

	Analayzing...

*/
/*
-- user groups by email
select count(*)
from [BackOffice].[Customer].[EmailAddress] ea
join Logon.UserGroupEmailAddress ue on ea.EmailAddressId = ue.EmailAddressId
join Logon.UserGroup g on ue.UserGroupId = g.UserGroupId
where EmailAddress = 'FeedProcessor@euromoneydigital.com'

-- user group email doesn't present in users
select count(distinct userid)
from [BackOffice].[Customer].[EmailAddress] ea
join Customer.UserContactAddress ca on ea.EmailAddressId = ca.EmailAddressId
where EmailAddress = 'FeedProcessor@euromoneydigital.com'

-- one email for many users
select EmailAddressId, count(distinct userid)
from Customer.UserContactAddress
group by EmailAddressId
having count(distinct userid) > 1

-- one user with many emails
select userid, count(distinct EmailAddressId)
from Customer.UserContactAddress
group by userid
having count(distinct EmailAddressId) > 1

select distinct *
from Customer.UserContactAddress ad
join Logon.UserSummary s on ad.UserId = s.UserId
join Customer.EmailAddress e on ad.EmailAddressId = e.EmailAddressId
where e.EmailAddressId = 9832687



-- 1 user - many subscriptions
-- 1 subscription - many users (8221315)
select SubscriptionId, count(userId)
from Logon.SubscriptionUser
group by SubscriptionId
having count(userid) > 1

*/


/* 
	Take users with last login 7 years ago or earlier
*/

declare @inThePast datetime = DATEADD(yy, -7, GETUTCDATE())
declare @gdprReplacement varchar(40) = N'Replaced in terms of the GDPR compliance. ';
declare @gdprReplacementShort varchar(4) = N'GDPR';

--declare @subscriptions_to_delete table (SubscriptionId int);

with inactive_users (userid)
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

select top 10000 userid
into #inactive_users
from inactive_users


/*
	GO
*/

delete	[BackOffice].[Orders].[SubscriptionUserRegistrantType]
from	[BackOffice].[Orders].[SubscriptionUserRegistrantType] rt 
join	[BackOffice].[Logon].[SubscriptionUser] u on rt.SubscriptionUserId = u.SubscriptionUserId
where	u.UserId in (select * from #inactive_users)

delete	[BackOffice].[Logon].[SubscriptionUserExcluded]
from	[BackOffice].[Logon].[SubscriptionUserExcluded] ue 
join	[BackOffice].[Logon].[SubscriptionUser] u on ue.SubscriptionUserId = u.SubscriptionUserId
where	u.UserId in (select * from #inactive_users)

delete	[BackOffice].[Logon].[SubscriptionUserImportedFromQss]
from	[BackOffice].[Logon].[SubscriptionUserImportedFromQss] qss 
join	[BackOffice].[Logon].[SubscriptionUser] u on qss.SubscriptionUserId = u.SubscriptionUserId
where	u.UserId in (select * from #inactive_users)

delete	[BackOffice].[Customer].[UserContactAddressPhoneNumber]
from	[BackOffice].[Customer].[UserContactAddressPhoneNumber] ph
join	[BackOffice].[Customer].[UserContactAddress] ad on ph.UserContactAddressId = ad.UserContactAddressId
where	ad.UserId in (select * from #inactive_users)

delete	[BackOffice].[Logon].[UserDefaultCommunication]
from	[BackOffice].[Logon].[UserDefaultCommunication] udc 
join	[BackOffice].[Customer].[UserContactAddress] ad on udc.UserId = ad.UserId
where	udc.UserId in (select * from #inactive_users)

delete	[BackOffice].[Customer].[ActiveUserContactAddress]
from	[BackOffice].[Customer].[ActiveUserContactAddress] aca 
join	[BackOffice].[Customer].[UserContactAddress] ad on aca.UserContactAddressId = ad.UserContactAddressId
where	ad.UserId in (select * from #inactive_users)

delete	[BackOffice].[Orders].[CreditCard]
from	[BackOffice].[Orders].[CreditCard] cc 
join	[BackOffice].[Customer].[UserContactAddress] u on u.UserContactAddressId = cc.UserContactAddressId
where	UserId in (select * from #inactive_users)

delete	[BackOffice].[FeedManager].[RejectedQSSOrderUserContactAddress]
from	[BackOffice].[FeedManager].[RejectedQSSOrderUserContactAddress] fm 
join	[BackOffice].[Customer].[UserContactAddress] u on u.UserContactAddressId = fm.UserContactAddressId
where	UserId in (select * from #inactive_users)


-- [Customer]
delete 
from	[Backoffice].[Customer].[UserContactPreferences]
where	UserId in (select * from #inactive_users)

delete 
from	[BackOffice].[Customer].[SiteRegistered] 
where	UserId in (select * from #inactive_users)

delete 
from	[BackOffice].[Customer].[UserProductDownloads] 
where	UserId in (select * from #inactive_users)


-- [Eden]

delete 
from	[BackOffice].[Eden].[UserDemographic] 
where	UserId in (select * from #inactive_users)

delete	[BackOffice].[Eden].[SiteDemographicAnswer]
from	[BackOffice].[Eden].[SiteDemographicAnswer] a 
join	[BackOffice].[Eden].[UserDemographic] ud on a.SiteDemographicAnswerId = ud.SiteDemographicAnswerId
where	UserId in (select * from #inactive_users)


-- [Audit]

-- CreatorUserId is not an FK
delete 
from	[BackOffice].[Audit].[AuditColumn]
where	CreatorUserId in (select * from #inactive_users)

-- CreatorUserId is a FK
-- UserId is not a FK
delete 
from	[BackOffice].[Audit].[ClientTaxNumber]
where	CreatorUserId in (select * from #inactive_users)
or		UserId in (select * from #inactive_users)

-- CreatorUserId is not a FK
delete 
from	[BackOffice].[Audit].[OrderDetail]
where	CreatorUserId in (select * from #inactive_users)

delete 
from	[BackOffice].[Audit].[Orders]
where	CreatorUserId in (select * from #inactive_users)

delete 
from	[BackOffice].[Audit].[PasswordReset]
where	UserId in (select * from #inactive_users)

-- UserId is not a FK
delete 
from	[BackOffice].[Audit].[PIQUserAnswer]
where	UserId in (select * from #inactive_users)

delete 
from	[BackOffice].[Audit].[Subscription]
where	CreatorUserId in (select * from #inactive_users)

-- UserId is not a FK
delete 
from	[BackOffice].[Audit].[SubscriptionUser]
where	UserId in (select * from #inactive_users)

-- SubscriptionUserId is not a FK
delete 
from	[BackOffice].[Audit].[SubscriptionUserExcluded]
where	SubscriptionUserId in (select * from #inactive_users)

-- SubscriptionUserId is not a FK
delete 
from	[BackOffice].[Audit].[SubscriptionUserOption]
where	SubscriptionUserId in (select * from #inactive_users)

delete 
from	[BackOffice].[Audit].[UserContactPreferences]
where	UserId in (select * from #inactive_users) 
or		CreatorUserId in (select * from #inactive_users)

-- UserId is not a foreign key
delete 
from	[BackOffice].[Audit].[Users]
where	UserId in (select * from #inactive_users)
or		CreatorUserId in (select * from #inactive_users)

--	Delete user subscriptions (depends on Audit.PasswordReset)
delete 
from	[BackOffice].[Logon].[SubscriptionUser]
--output	Deleted.SubscriptionId into @subscriptions_to_delete
where	UserId in (select * from #inactive_users)

update	[BackOffice].[Customer].[Contact] set
		Forenames = @gdprReplacement + cast(newid() as char(36)),
		Surname = @gdprReplacement,
		Initials = @gdprReplacementShort,
		GenderId = 0 -- 'UNKNOWN'
from	[BackOffice].[Customer].[Contact] c
join	[BackOffice].[Customer].[UserContactAddress] u on u.ContactId = c.ContactId
where	UserId in (select * from #inactive_users)

update	[BackOffice].[Customer].[EmailAddress] set 
		EmailAddress = @gdprReplacement + cast(newid() as char(36)) 
from	[BackOffice].[Customer].[EmailAddress] ead 
join	[BackOffice].[Customer].[UserContactAddress] u on u.EmailAddressId = ead.EmailAddressId
where	UserId in (select * from #inactive_users)

update	Customer.UserContactAddress set
		JobTitleId = 0, -- 'UNKNOWN'
		AddressId = 0, -- '0	AddressLine1	AddressLine2	AddressLine3	City	Postcode	0	Province	0'
		CompanyId = 0, -- 'UNKNOWN'
		DateTimeCreated = getdate(),
		CreatorUserId = null,
		CreatorCultUserId = null,
		ReasonId = 0 -- 'none'
		-- ContactID - replacing the contact data itself
		-- EmailAddressId - replacing the emailaddress data itself
where	UserId in (select * from #inactive_users)

update	Logon.Users	set 
		UserName = @gdprReplacement + cast(newid() as char(36)),
		EncryptPassword = right(cast(newid() as char(36)), 25),
		IsLockedOut = 1,
		UserTypeId = 11 -- 'No Longer User'
where	UserId in (select * from #inactive_users)

update	Logon.UserSummary set 
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
where	UserId in (select * from #inactive_users)


-- Look for lost contacts, addresses, emails ...



/*
	Control deletion, not for production
*/
declare @userId int = (select top 1 userid from #inactive_users)

select	* 
from	Logon.Users u join 
		Logon.UserSummary s on u.UserId = s.UserId
where	u.UserId = @userId

select	*
from	Logon.SubscriptionUser su
where	UserId = @userId

select	c.*
from	[BackOffice].[Customer].[Contact] c
join	[BackOffice].[Customer].[UserContactAddress] u on u.ContactId = c.ContactId
where	UserId = @userId

select	ead.*
from	[BackOffice].[Customer].[EmailAddress] ead 
join	[BackOffice].[Customer].[UserContactAddress] u on u.EmailAddressId = ead.EmailAddressId
where	UserId = @userId

select	a.* 
from	Customer.Address a join 
		Customer.usercontactaddress u on a.AddressId = u.AddressId
where	u.UserId = @userId

select	a.* 
from	Customer.Company a join 
		Customer.usercontactaddress u on a.companyid = u.companyid
where	u.UserId = @userId

select	*
from	Customer.UserContactAddress
where	UserId = @userId


select 'AUDIT -->'

select *
from	[BackOffice].[Audit].[AuditColumn]
where	CreatorUserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[ClientTaxNumber]
where	CreatorUserId in (select * from #inactive_users)
or		UserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[OrderDetail]
where	CreatorUserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[Orders]
where	CreatorUserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[PasswordReset]
where	UserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[PIQUserAnswer]
where	UserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[PIQUserAnswer]
where	UserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[Subscription]
where	CreatorUserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[SubscriptionUser]
where	UserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[SubscriptionUserExcluded]
where	SubscriptionUserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[SubscriptionUserOption]
where	SubscriptionUserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[UserContactPreferences]
where	UserId in (select * from #inactive_users) 
or		CreatorUserId in (select * from #inactive_users)

select *
from	[BackOffice].[Audit].[Users]
where	UserId in (select * from #inactive_users)
or		CreatorUserId in (select * from #inactive_users)



rollback




