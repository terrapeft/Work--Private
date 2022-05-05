-- get subscribed newsletters by username
;with subscriptions as
(
	select 
		NewsletterAlertCategoryId, 
		ActionType, 
		BackOfficeUserId, 
		ActionDate,
		row_number() over (partition by NewsletterAlertCategoryId, BackOfficeUserId order by ActionDate desc) as rn
	from ProductNewsletterAlertCategoriesUser pnacui
	join Logon.Users u on pnacui.BackOfficeUserId = u.UserId
	where u.UserName = 'a.jimenezsanchez@eib.org'
)
select distinct /*pp.ProductID,*/ ppna.NewsletterAlertId, pnac.Id as ProductNewsletterAlertCategoryId, pnac.Title, s.BackOfficeUserId, u.UserName
from subscriptions s
	join Logon.Users u on s.BackOfficeUserId = u.UserId
	join ProductNewsletterAlertCategories pnac on s.NewsletterAlertCategoryId = pnac.Id
	join ProductProductNewsletterAlerts ppna on pnac.NewsletterAlertId = ppna.NewsletterAlertId
	join Product.Products pp on ppna.productid = pp.productid
	join Orders.Subscription os on pp.ProductID = os.ProductId
where rn = 1 
	and actiontype = 1 
	and pp.primaryproductownerid = 455
	and os.SubscriptionTypeId = 3
order by ppna.NewsletterAlertId



-- overall count
;with subscriptions as
(
	select 
		NewsletterAlertCategoryId, 
		ActionType, 
		BackOfficeUserId, 
		ActionDate,
		row_number() over (partition by NewsletterAlertCategoryId, BackOfficeUserId order by ActionDate desc) as rn
	from ProductNewsletterAlertCategoriesUser pnacui
	join Logon.Users u on pnacui.BackOfficeUserId = u.UserId
	where u.UserName = 'a.jimenezsanchez@eib.org'
)
select count(distinct  u.UserName)
from subscriptions s
	join Logon.Users u on s.BackOfficeUserId = u.UserId
	join ProductNewsletterAlertCategories pnac on s.NewsletterAlertCategoryId = pnac.Id
	join ProductProductNewsletterAlerts ppna on pnac.NewsletterAlertId = ppna.NewsletterAlertId
	join Product.Products pp on ppna.productid = pp.productid
	join Orders.Subscription os on pp.ProductID = os.ProductId
where rn = 1 
	and actiontype = 1 
	and pp.primaryproductownerid = 455
	and os.SubscriptionTypeId = 3




-- aggregate newsletters for subscribers
drop table if exists #gc_report
;with subscriptions as
(
	select 
		NewsletterAlertCategoryId, 
		ActionType, 
		BackOfficeUserId, 
		ActionDate,
		row_number() over (partition by NewsletterAlertCategoryId, BackOfficeUserId order by ActionDate desc) as rn
	from ProductNewsletterAlertCategoriesUser pnacui
	join Logon.Users u on pnacui.BackOfficeUserId = u.UserId
	--where u.UserName = 'michael.ouellette@nomura.com'
)
select distinct UserName, ppna.NewsletterAlertId, Title
into #gc_report
from subscriptions s
	join Logon.Users u on s.BackOfficeUserId = u.UserId
	join ProductNewsletterAlertCategories pnac on s.NewsletterAlertCategoryId = pnac.Id
	join ProductProductNewsletterAlerts ppna on pnac.NewsletterAlertId = ppna.NewsletterAlertId
	join Product.Products pp on ppna.productid = pp.productid
	join Orders.Subscription os on pp.ProductID = os.ProductId
where rn = 1 
	and actiontype = 1 
	and pp.primaryproductownerid = 455
	--and os.SubscriptionTypeId = 3
	--and os.SubscriptionEndDateTime > getdate()
order by UserName, ppna.NewsletterAlertId, Title

--select UserName, string_agg(cast(Title as nvarchar(max)), ', ')
select count(distinct UserName)
from #gc_report
group by UserName