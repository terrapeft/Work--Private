use backoffice

/*

	First result set:
	Active GC users 
	with active subscriptions of type Subcription (type id: 3) or Trial (type id: 2),
	that are not in the Logon.SubscriptionUserExcluded (deactivated end users) 
	and not in the Orders.SubscriptionExcluded (deactivated subscriptions or trials)
	with one default address (there could be several active addresses),
	with phones aggregated in one field

	Second result set:
	DPA settings for those users who have them.
*/



select distinct top 100 *
from Logon.Users u
join Logon.UserType ut on u.UserTypeId = ut.UserTypeId
join Logon.SubscriptionUser su on u.UserId = su.UserId
join Orders.Subscription s on su.SubscriptionId = s.SubscriptionId
join Orders.SubscriptionType st on s.SubscriptionTypeId = st.SubscriptionTypeId
join Orders.OrderDetail od on s.OrderDetailId = od.OrderDetailId
join Orders.Orders o on od.OrderId = o.OrderId
join Product.Products p on s.ProductId = p.ProductId
join Product.ProductTypes pt on p.TypeID = pt.ProductTypeID
where p.ProductID in (
	6192
)
--and u.UserTypeId <> 11
--and s.SubscriptionTypeId <> 1 
--and addr.IsDefaultUserContactAddress = 1
order by UserName


-- Main results
--select * from #results_1247

/*
-- DPA information from the LegalCompliance database on AZ01-SQL-PRD-01

select Email, Title, IsAccepted 
from
(
select row_number() over (partition by a.UserID, c.Title order by a.LatestUpdate desc) as rownum, u.Email, c.Title, c.ContractID, a.IsAccepted
  from [UK-SQL-01].[LegalCompliance].[dbo].[Acceptance] a
  join [UK-SQL-01].[LegalCompliance].[dbo].[User] u on a.UserID = u.UserID
  join [UK-SQL-01].[LegalCompliance].[dbo].[ContractVersion] cv on a.ContractVersionID = cv.ContractVersionID
  join [UK-SQL-01].[LegalCompliance].[dbo].[Contract] c on cv.ContractID = c.ContractID
  where u.Email in (select email from #uids_1247)
  and c.ContractID in (1, 2, 4, 6, 7, 8)
) r
where r.rownum = 1
order by Email
*/
