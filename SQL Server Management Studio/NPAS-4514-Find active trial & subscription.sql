use backoffice

declare @expiresAfter datetime = getdate();
declare @siteName nvarchar(120) = '%Euromoney PLC%';

with intersections (UserGroupId)
as (
	select g.UserGroupId
	from Logon.UserGroup g
	join Logon.UserGroupSubscription gs on g.UserGroupId = gs.UserGroupId
	join Orders.Subscription s on gs.SubscriptionId = s.SubscriptionId
	where s.SubscriptionEndDateTime > @expiresAfter
	and g.UserGroupTypeId = 2 /* key account */
	and s.SubscriptionTypeId = 2 /* trial */

	intersect 

	select g.UserGroupId
	from Logon.UserGroup g
	join Logon.UserGroupSubscription gs on g.UserGroupId = gs.UserGroupId
	join Orders.Subscription s on gs.SubscriptionId = s.SubscriptionId
	where s.SubscriptionEndDateTime > @expiresAfter
	and g.UserGroupTypeId = 2 /* key account */
	and s.SubscriptionTypeId = 3 /* subscription */
)
select distinct
	g.UserGroupId,
	g.UserGroupName,
	s.SubscriptionId,
	s.SubscriptionTypeId,
	st.SubscriptionType,
	s.SubscriptionEndDateTime,
	e.EmailAddress as [KeyAccountEmail],
	si.SiteId,
	si.Name,
	us.UserName
from Logon.UserGroup g
	join Logon.UserGroupSubscription gs on g.UserGroupId = gs.UserGroupId
	join Orders.Subscription s on gs.SubscriptionId = s.SubscriptionId
	join Logon.UserGroupEmailAddress ge on g.UserGroupId = ge.UserGroupId
	join Customer.EmailAddress e on ge.EmailAddressId = e.EmailAddressId
	join Orders.SubscriptionType st on s.SubscriptionTypeId = st.SubscriptionTypeId
	join Logon.SubscriptionUser su on s.SubscriptionId = su.SubscriptionId
	join Product.Products p on s.ProductID = p.ProductId
	join Product.ProductSites ps on p.ProductId = ps.ProductID
	join Product.Site si on ps.SiteId = si.SiteId
	join Logon.Users us on us.UserId = su.UserId
where g.UserGroupId in (select UserGroupId from intersections)
	and s.SubscriptionEndDateTime > getdate()
	and si.Name like @siteName
	
