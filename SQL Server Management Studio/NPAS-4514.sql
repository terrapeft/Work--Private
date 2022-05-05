use BackOffice;

declare @expiresAfter datetime = getdate();
declare @siteName nvarchar(120) = '%Managing%';

with ex (subscriptionId)
as (
	select subscriptionId
	from Orders.ExcludedSubscription es
	join [Audit].Reason r ON r.ReasonId = es.ReasonId
),
i (userId)
as (
	select su.UserId
	from Logon.SubscriptionUser su 
		join Orders.Subscription s on su.SubscriptionId = s.SubscriptionId
		join Product.Products p on s.ProductID = p.ProductId
		join Product.ProductSites ps on p.ProductId = ps.ProductID
		join Product.Site si on ps.SiteId = si.SiteId
	where s.SubscriptionEndDateTime > @expiresAfter
		and si.Name like @siteName
		and s.SubscriptionTypeId = 2 /* trial */

	intersect 

	select us.UserId
	from Logon.UserGroup g
		join Logon.UserGroupSubscription gs on g.UserGroupId = gs.UserGroupId
		join Orders.Subscription s on gs.SubscriptionId = s.SubscriptionId
		join Logon.SubscriptionUser su on s.SubscriptionId = su.SubscriptionId
		join Logon.Users us on us.UserId = su.UserId
		join Product.Products p on s.ProductID = p.ProductId
		join Product.ProductSites ps on p.ProductId = ps.ProductID
		join Product.Site si on ps.SiteId = si.SiteId
	where s.SubscriptionEndDateTime > @expiresAfter
		and si.Name like @siteName
		and g.UserGroupTypeId = 2 /* key account */
		and s.SubscriptionTypeId = 3 /* subscription */
)
select distinct i.userId, u.username, p.name, s.subscriptionId, s.SubscriptionTypeId, s.OrderDetailId, s.SubscriptionStartDateTime, s.SubscriptionEndDateTime
from i
	join Logon.SubscriptionUser su on i.userid = su.userId
	join Orders.Subscription s on su.SubscriptionId = s.SubscriptionId
	join Logon.Users u on i.userid = u.userid
	join Product.Products p on s.ProductID = p.ProductId
	join Product.ProductSites ps on p.ProductId = ps.ProductID
	join Product.Site si on ps.SiteId = si.SiteId
where s.SubscriptionEndDateTime > @expiresAfter
	and si.Name like @siteName
order by i.userId, p.name, s.subscriptionId


