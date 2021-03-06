-- publications
select *
from [BackOffice].[dbo].[Publication]
where PublicationName like '%itr%' or PublicationName like '%tpweek%'
-- 357, 242

-- products
select *
from [BackOffice].[Product].[Products]
where name like '%tp week%' or name like '%international tax%'
-- 1061279,1059674,1059673,1059672,1032689,6051

-- subcriptions
select SubscriptionId
from orders.subscription
where productid in (1061279,1059674,1059673,1059672,1032689)

-- users
with itrUsers as (
	select su.subscriptionid, su.userid, username, subscriptiontypeid, productid, orderdetailid, subscriptioncodeid, SubscriptionStartDateTime, SubscriptionEndDateTime 
	from Logon.SubscriptionUser su 
		join Logon.Users u on su.UserId = u.userId
		join Orders.Subscription s on su.SubscriptionId = s.SubscriptionId
	where su.subscriptionId in (select SubscriptionId
									from orders.subscription
									where productid in (select productid
															from [BackOffice].[Product].[Products]
															where name like '%international tax review%')
	)
),
tpweekUsers as (
	select su.subscriptionid, su.userid, username, subscriptiontypeid, productid, orderdetailid, subscriptioncodeid, SubscriptionStartDateTime, SubscriptionEndDateTime 
	from Logon.SubscriptionUser su 
		join Logon.Users u on su.UserId = u.userId
		join Orders.Subscription s on su.SubscriptionId = s.SubscriptionId
	where su.subscriptionId in (select SubscriptionId
									from orders.subscription
									where productid in (select productid
															from [BackOffice].[Product].[Products]
															where name like '%tp week%')
	)
)

select * from itrUsers
except 
select * from tpweekUsers

/*
-- ITR only
select * from itrUsers
except 
select * from tpweekUsers


-- TPWeek only
select * from tpweekUsers
except 
select * from itrUsers

-- in both
select * from tpweekUsers
intersect
select * from itrUsers

*/

order by SubscriptionStartDateTime desc







