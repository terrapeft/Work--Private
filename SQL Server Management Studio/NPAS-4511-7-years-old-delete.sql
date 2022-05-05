/*
The chain:
The User depends on UserContactAddress, the UserContactAddress depends on the Orders, 
the Orders depends on the OrderDetail, the OrderDetail depends on the Subscription,
the Subscription depends on the SubscriptionUser, which contains multiple users for one Subscription.
We can delete the SubscriptionUser record, but cannot delete the Subscription, 
because there are other SubscriptionUser records for other users.
We cannot delete User, bacause its ID also is used in the UserContactAddress, and so on.

*/

/*

Bypassing [dbo] tables as they are not in use.

Also reviewed:
Eden.EmailAddress - one to many for UserContactAddress, doesn't participate in deletion (DPiD)
Eden.PhoneNumber - DPiD
Eden.SiteDemographicAnswer - one to many for UserDemographic, DPiD

- Cannot delete Orders.OrderDetail, because Orders.Subscription has OrderDetailId FK and requires Orders.Subscription to be deleted.
- Cannot delete Orders.Subscription because it has many-to-many relationship with Users.
- Cannot delete Customer.UserContactAddress - the Orders.Orders has BillingUserContactAddressId FK



*/

declare @userId int = 5040357

/*

	Delete subscriptions

*/

delete	[BackOffice].[Orders].[SubscriptionUserRegistrantType]
from	[BackOffice].[Orders].[SubscriptionUserRegistrantType] rt 
join	[BackOffice].[Logon].[SubscriptionUser] u on rt.SubscriptionUserId = u.SubscriptionUserId
where	u.UserId = @userId

delete 
from	[BackOffice].[Logon].[SubscriptionUser] 
where	UserId = @userId




delete	[BackOffice].[Customer].[UserContactAddressPhoneNumber]
from	[BackOffice].[Customer].[UserContactAddressPhoneNumber] ph
join	[BackOffice].[Customer].[UserContactAddress] ad on ph.UserContactAddressId = ad.UserContactAddressId
where	ad.UserId = @userId

delete	[BackOffice].[Logon].[UserDefaultCommunication]
from	[BackOffice].[Logon].[UserDefaultCommunication] udc 
join	[BackOffice].[Customer].[UserContactAddress] ad on udc.UserId = ad.UserId
where	udc.UserId = @userId

delete	[BackOffice].[Customer].[ActiveUserContactAddress]
from	[BackOffice].[Customer].[ActiveUserContactAddress] aca 
join	[BackOffice].[Customer].[UserContactAddress] ad on aca.UserContactAddressId = ad.UserContactAddressId
where	ad.UserId = @userId

--delete 
--from	[BackOffice].[Customer].[UserContactAddress] 
--where	UserId = @userId
--or		CreatorUserId = @userId

/*

	Delete user, including records where UserId, SubscriptionUserId or CreatorUserId are not foreign keys.

*/

-- [Audit]

-- CreatorUserId is not an FK
delete 
from	[BackOffice].[Audit].[AuditColumn]
where	CreatorUserId = @userId

-- CreatorUserId is a FK
-- UserId is not a FK
delete 
from	[BackOffice].[Audit].[ClientTaxNumber]
where	CreatorUserId = @userId
or		UserId = @userId

-- CreatorUserId is not a FK
delete 
from	[BackOffice].[Audit].[OrderDetail]
where	CreatorUserId = @userId

delete 
from	[BackOffice].[Audit].[Orders]
where	CreatorUserId = @userId

delete 
from	[BackOffice].[Audit].[PasswordReset]
where	UserId = @userId

-- UserId is not a FK
delete 
from	[BackOffice].[Audit].[PIQUserAnswer]
where	UserId = @userId

-- UserId is not a FK
delete 
from	[BackOffice].[Audit].[PIQUserAnswer]
where	UserId = @userId

delete 
from	[BackOffice].[Audit].[Subscription]
where	CreatorUserId = @userId

-- UserId is not a FK
delete 
from	[BackOffice].[Audit].[SubscriptionUser]
where	UserId = @userId

-- SubscriptionUserId is not a FK
delete 
from	[BackOffice].[Audit].[SubscriptionUserExcluded]
where	SubscriptionUserId = @userId

-- SubscriptionUserId is not a FK
delete 
from	[BackOffice].[Audit].[SubscriptionUserOption]
where	SubscriptionUserId = @userId

delete 
from	[BackOffice].[Audit].[UserContactPreferences]
where	UserId = @userId 
or		CreatorUserId = @userId

-- UserId is not a foreign key
delete 
from	[BackOffice].[Audit].[Users]
where	UserId = @userId
or		CreatorUserId = @userId


-- [Customer]


delete 
from	[Backoffice].[Customer].[UserContactPreferences]
where	UserId = @userId

delete 
from	[BackOffice].[Customer].[SiteRegistered] 
where	UserId = @userId

delete 
from	[BackOffice].[Customer].[UserProductDownloads] 
where	UserId = @userId


-- [Eden]

delete 
from	[BackOffice].[Eden].[UserDemographic] 
where	UserId = @userId


delete	[BackOffice].[Eden].[SiteDemographicAnswer]
from	[BackOffice].[Eden].[SiteDemographicAnswer] a 
join	[BackOffice].[Eden].[UserDemographic] ud on a.SiteDemographicAnswerId = ud.SiteDemographicAnswerId
where	UserId = @userId


-- [Logon]


--delete 
--from	[BackOffice].[Logon].[UserSummary] 
--where	UserId = @userId



--delete 
--from	[BackOffice].[Logon].[Users] 
--where	UserId = @userId




rollback








