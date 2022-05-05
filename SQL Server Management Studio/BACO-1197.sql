use backoffice

select distinct
	 ti.Id as [TitanGUID]
	,u.UserId [BackofficeUserId]
	,u.UserName
	,ti.HashedPassword
from Logon.Users u
join Logon.UserType ut on u.UserTypeId = ut.UserTypeId
join Logon.SubscriptionUser su on u.UserId = su.UserId
join Orders.Subscription s on su.SubscriptionId = s.SubscriptionId
join Orders.SubscriptionType st on s.SubscriptionTypeId = st.SubscriptionTypeId
join Orders.OrderDetail od on s.OrderDetailId = od.OrderDetailId
join Orders.Orders o on od.OrderId = o.OrderId
join Product.Products p on s.ProductId = p.ProductId
join Product.ProductTypes pt on p.TypeID = pt.ProductTypeID
join AZUREPRODPAAS.Titan.dbo.[Identity] ti on u.UserName = ti.Username
--join NewCentralUsers.dbo.UserDetails ud on u.UserId = ud.uID
--join #tempTable tt on u.username = tt.username
left join Logon.UserGroupSubscription ugs on s.SubscriptionId = ugs.SubscriptionId
left join Logon.SubscriptionUserExcluded sue on su.SubscriptionUserId = sue.SubscriptionUserId
left join Orders.ExcludedSubscription es on su.SubscriptionId = es.SubscriptionId
where 
--sue.SubscriptionUserId is null
--and es.SubscriptionId is null
--and ugs.SubscriptionId is null
--and s.SubscriptionEndDateTime > GETDATE()
--and 
p.ProductID in (
	select ProductID
	from Product.Products
	where name like 'global capital%'
	--and IsActive = 1
)
and u.UserTypeId <> 11
