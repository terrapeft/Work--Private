use BackOffice

/*
select *
from Logon.UserGroup ug

select *
from Logon.UserGroupSubscription ugs

select *
from Logon.UserGroupSubscriptionIpRange ipr

select *,
	(CASE WHEN SCA.IntIpAddressStart >= 0 THEN SCA.IntIpAddressStart ELSE CAST(SCA.IntIpAddressStart as BIGINT)+ 4294967296 END) AS IntIpAddressStart
   ,(CASE WHEN SCA.IntIpAddressEnd >= 0 THEN SCA.IntIpAddressEnd ELSE Cast(SCA.IntIpAddressEnd as BIGINT) + 4294967296  END) AS IntIpAddressEnd
from Logon.IpRange sca
*/

/*
-- Site licences
select 
	 ug.UserGroupName, ug.UserGroupDescription, ug.DateTimeCreated
	,ugt.UserGroupType
	,ugs.SubscriptionId
	,ipr.ActiveStartDate, ipr.ActiveEndDate
	,sca.IntIpAddressStart
	,sca.IntIpAddressEnd
	,cast(round((cast(cast(sca.IntIpAddressStart as binary(4)) as bigint)/16777216), 0, 1) as varchar(4)) + '.' +
	 cast((round((cast(cast(sca.IntIpAddressStart as binary(4)) as bigint)/65536), 0, 1) % 256) as varchar(4)) + '.' +
	 cast((round((cast(cast(sca.IntIpAddressStart as binary(4)) as bigint)/256), 0, 1) % 256) as varchar(4)) + '.' + 
	 cast((cast(cast(sca.IntIpAddressStart as binary(4)) as bigint) % 256) as varchar(4)) as IpAddressStart
	,cast(round((cast(cast(sca.IntIpAddressEnd as binary(4)) as bigint)/16777216), 0, 1) as varchar(4)) + '.' +
	 cast((round((cast(cast(sca.IntIpAddressEnd as binary(4)) as bigint)/65536), 0, 1) % 256) as varchar(4)) + '.' +
	 cast((round((cast(cast(sca.IntIpAddressEnd as binary(4)) as bigint)/256), 0, 1) % 256) as varchar(4)) + '.' + 
	 cast((cast(cast(sca.IntIpAddressEnd as binary(4)) as bigint) % 256) as varchar(4)) as IpAddressEnd
from Logon.UserGroup ug
join Logon.UserGroupType ugt on ug.UserGroupTypeId = ugt.UserGroupTypeId
join Logon.UserGroupSubscription ugs on ug.UserGroupId = ugs.UserGroupId
join Logon.UserGroupSubscriptionIpRange ipr on ugs.UserGroupSubscriptionId = ipr.UserGroupSubscriptionId
join Logon.IpRange sca on ipr.IpRangeId = sca.IpRangeId
join Orders.Subscription s on ugs.SubscriptionId = s.SubscriptionId
join Product.Products p on s.ProductId = p.ProductId
where ug.UserGroupTypeId = 1
and s.SubscriptionEndDateTime >= getdate()
and p.ProductID in (
	select ProductID
	from Product.Products
	where name like 'global capital%'
)
*/


-- Key accounts with subscribers
select distinct
	 --ug.UserGroupId
	 ug.UserGroupName, ug.UserGroupDescription, ug.DateTimeCreated
	,ugt.UserGroupType
	,ugs.SubscriptionId, ugs.SendEmailWithCredentialsToNewEndUsers
	,ipr.ActiveStartDate, ipr.ActiveEndDate
	,sca.IntIpAddressStart
	,sca.IntIpAddressEnd
	,cast(round((cast(cast(sca.IntIpAddressStart as binary(4)) as bigint)/16777216), 0, 1) as varchar(4)) + '.' +
	 cast((round((cast(cast(sca.IntIpAddressStart as binary(4)) as bigint)/65536), 0, 1) % 256) as varchar(4)) + '.' +
	 cast((round((cast(cast(sca.IntIpAddressStart as binary(4)) as bigint)/256), 0, 1) % 256) as varchar(4)) + '.' + 
	 cast((cast(cast(sca.IntIpAddressStart as binary(4)) as bigint) % 256) as varchar(4)) as IpAddressStart
	,cast(round((cast(cast(sca.IntIpAddressEnd as binary(4)) as bigint)/16777216), 0, 1) as varchar(4)) + '.' +
	 cast((round((cast(cast(sca.IntIpAddressEnd as binary(4)) as bigint)/65536), 0, 1) % 256) as varchar(4)) + '.' +
	 cast((round((cast(cast(sca.IntIpAddressEnd as binary(4)) as bigint)/256), 0, 1) % 256) as varchar(4)) + '.' + 
	 cast((cast(cast(sca.IntIpAddressEnd as binary(4)) as bigint) % 256) as varchar(4)) as IpAddressEnd
	,s.SubscriptionId, s.ProductId, s.OrderDetailId, s.SubscriptionCodeId, s.ParentSubscriptionId
	,s.SubscriptionUserLimit, s.RenewalCount, s.ConcurrencyLimit
	,su.UserId, u.UserName
from Logon.UserGroup ug
join Logon.UserGroupType ugt on ug.UserGroupTypeId = ugt.UserGroupTypeId
left join Logon.UserGroupSubscription ugs on ug.UserGroupId = ugs.UserGroupId
left join Logon.UserGroupSubscriptionIpRange ipr on ugs.UserGroupSubscriptionId = ipr.UserGroupSubscriptionId
left join Logon.IpRange sca on ipr.IpRangeId = sca.IpRangeId
left join Orders.Subscription s on ugs.SubscriptionId = s.SubscriptionId
left join Orders.SubscriptionType st on s.SubscriptionTypeId = st.SubscriptionTypeId
left join Logon.SubscriptionUser su on su.SubscriptionId = s.SubscriptionId
join Logon.Users u on u.UserId = su.UserId
join Product.Products p on s.ProductId = p.ProductId
left join Logon.SubscriptionUserExcluded sue on su.SubscriptionUserId = sue.SubscriptionUserId
left join Orders.ExcludedSubscription es on su.SubscriptionId = es.SubscriptionId
where ug.UserGroupTypeId = 2
and sue.SubscriptionUserId is null
and es.SubscriptionId is null
and p.ProductID in (
	select ProductID
	from Product.Products
	where name like 'global capital%'
)
and s.SubscriptionEndDateTime >= getdate()
and u.UserName not like 'Deactivated_%'
and u.UserTypeId <> 11


