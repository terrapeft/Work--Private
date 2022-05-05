use BackOffice

--Step 1, Users
/*
select --count(*)
	 u.UserId
	,u.UserName
	,u.IsLockedOut
	,u.UserTypeId
	,ut.UserType
	,s.SubscriptionId
	,s.SubscriptionTypeId
	,st.SubscriptionType
	,s.SubscriptionCodeId
	,s.ParentSubscriptionId
	,s.SubscriptionUserLimit
	,s.SubscriptionStartDateTime
	,s.SubscriptionEndDateTime
	,s.RenewalCount
	,s.ConcurrencyLimit
	,p.*
	,pt.Name as [Product Type]
	,od.OrderDetailId
    ,od.ApplicationId
    ,od.PriceID
    ,od.Quantity
    ,od.UnitPrice
    ,od.NetValue
    ,od.TaxPaid
    ,od.PostagePackageFee
    ,od.DispatchCode
	,o.OrderId
    ,o.OrderTypeId
    ,o.CreatorUserId
    ,o.OrderDateTime
    ,o.BillingUserContactAddressId
    ,o.UserContactAddressId
    ,o.CustomerReference
    ,o.LeadSourceId
    ,o.ClientVatNumber
    ,o.CurrencyId
    ,o.NetTotalValue
    ,o.TotalVatPaid
    ,o.TotalPostagePackageFee
    ,o.IntServerIpAddress
    ,o.ParentOrderId
    ,o.CreatorCultUserId
    ,o.LineItemCount
    ,o.TaxCalculationId
    ,o.PaymentProviderId
    ,o.PaymentStatusId
    ,o.MCOrderId
    ,o.SiteId
    ,o.PaymentReference
    ,o.CreditCardLastFourDigits
	,ugs.* -- key accounts
	
from Logon.Users u
join Logon.UserType ut on u.UserTypeId = ut.UserTypeId
join Logon.SubscriptionUser su on u.UserId = su.UserId
join Orders.Subscription s on su.SubscriptionId = s.SubscriptionId
join Orders.SubscriptionType st on s.SubscriptionTypeId = st.SubscriptionTypeId
join Orders.OrderDetail od on s.OrderDetailId = od.OrderDetailId
join Orders.Orders o on od.OrderId = o.OrderId
join Product.Products p on s.ProductId = p.ProductId
join Product.ProductTypes pt on p.TypeID = pt.ProductTypeID
left join Logon.UserGroupSubscription ugs on s.SubscriptionId = ugs.SubscriptionId
left join Logon.SubscriptionUserExcluded sue on su.SubscriptionUserId = sue.SubscriptionUserId
left join Orders.ExcludedSubscription es on su.SubscriptionId = es.SubscriptionId
where 
	sue.SubscriptionUserId is null
and es.SubscriptionId is null
--and ugs.SubscriptionId is null
and s.SubscriptionEndDateTime > GETDATE()
and p.ProductID in (
	select ProductID
	from Product.Products
	where name like 'global capital%'
	--and IsActive = 1
)
and u.UserTypeId <> 11
--and u.userid = 14985
*/


-- Step 2, Newsletters

;with NewsletterUsersChoices as (
	select
		 ROW_NUMBER() OVER (PARTITION BY BackOfficeUserId, NewsletterAlertCategoryId, ppna.ProductId ORDER BY NewsletterAlertCategoryId, pnacu.Id DESC) AS NewsletterUsersChoicesOrder
		,pnac.NewsletterAlertId
		,pnacu.SelectedFormat
		,NewsletterAlertCategoryId
		,Title
		,BackOfficeUserId AS UserId
		,case when pnacu.ActionType = 1 then 1 else 0 end as IsSelected
		,ppna.ProductId
		,ps.SiteId
	from dbo.ProductNewsletterAlertCategoriesUser pnacu
	join dbo.ProductNewsletterAlertCategories pnac with(nolock) on pnac.Id = pnacu.NewsletterAlertCategoryId
	join dbo.ProductProductNewsletterAlerts ppna with(nolock) on ppna.NewsletterAlertId = pnac.NewsletterAlertId
	join Product.ProductSites ps with(nolock) on ps.ProductID = ppna.ProductId
	where 
		ppna.ProductId in (
			select ProductID
			from Product.Products
			where name like 'global capital%'
	)
)

select distinct
	 UserId
	,NewsletterAlertCategoryId
	,NewsletterAlertId
	,ProductId
	,SiteId
	,Title
	,SelectedFormat
from NewsletterUsersChoices nuc 
where 
	NewsletterUsersChoicesOrder = 1 
	and IsSelected = 1
order by UserId, NewsletterAlertCategoryId, NewsletterAlertId, ProductId, SiteId





 --   union all

	--select *
	--from Logon.Users u
	--join Logon.SubscriptionUser su on u.UserId = su.UserId
	--join Orders.Subscription s on su.SubscriptionId = s.SubscriptionId
	--join Orders.SubscriptionType st on s.SubscriptionTypeId = st.SubscriptionTypeId
	--join Product.Products p on s.ProductId = p.ProductId
	--join Logon.UserGroupSubscription ugs on s.SubscriptionId = ugs.SubscriptionId
	--left join Logon.SubscriptionUserExcluded sue on su.SubscriptionUserId = sue.SubscriptionUserId
	--left join Orders.ExcludedSubscription es on su.SubscriptionId = es.SubscriptionId
	--where sue.SubscriptionUserId is null
	--and es.SubscriptionId is null
	--and s.SubscriptionEndDateTime > GETDATE()
	--and p.ProductID in (
	--	select ProductID
	--	from Product.Products
	--	where name like 'global capital%'
	--	and IsActive = 1
	--)







/*
-- KA
select *
from Logon.UserGroup ug
join Logon.UserGroupCompany ugc on ug.UserGroupId = ugc.UserGroupId
join Customer.Company c on ugc.CompanyId = c.CompanyId
where CompanyName like '%global capital%'
*/
















