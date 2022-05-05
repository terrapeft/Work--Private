use backoffice

-- find products
select productid
from Product.Products
--where primaryproductownerid = 455
where name like 'Global Capital%' 
and isactive = 1

-- subscribers by newsletter
select distinct /*pp.ProductID, pp.Name, pp.SiteDisplayName,*/ ppna.NewsletterAlertId, pnac.Id as ProductNewsletterAlertCategoryId, pnac.Title, pnacu.BackOfficeUserId, us.UserName
from Product.Products pp 
join ProductProductNewsletterAlerts ppna on pp.productid = ppna.productid
join ProductNewsletterAlertCategories pnac on ppna.NewsletterAlertId = pnac.NewsletterAlertId
join ProductNewsletterAlertCategoriesUser pnacu on pnac.Id = pnacu.NewsletterAlertCategoryId
join Logon.Users us on pnacu.BackOfficeUserId = us.UserId
where primaryproductownerid = 455 and pnac.Id = 2827
order by username

-- newsletters by subscriber
select distinct /*pp.ProductID, pp.Name, pp.SiteDisplayName,*/ ppna.NewsletterAlertId, pnac.Id as ProductNewsletterAlertCategoryId, pnac.Title, pnacu.BackOfficeUserId, us.UserName
from Product.Products pp 
join ProductProductNewsletterAlerts ppna on pp.productid = ppna.productid
join ProductNewsletterAlertCategories pnac on ppna.NewsletterAlertId = pnac.NewsletterAlertId
join ProductNewsletterAlertCategoriesUser pnacu on pnac.Id = pnacu.NewsletterAlertCategoryId
join Logon.Users us on pnacu.BackOfficeUserId = us.UserId
where primaryproductownerid = 455 and us.UserName = 'ejanus@chathamfinancial.com'
order by username

-- count users
select count(distinct us.UserName) 
from Product.Products pp 
join ProductProductNewsletterAlerts ppna on pp.productid = ppna.productid
join ProductNewsletterAlertCategories pnac on ppna.NewsletterAlertId = pnac.NewsletterAlertId
join ProductNewsletterAlertCategoriesUser pnacu on pnac.Id = pnacu.NewsletterAlertCategoryId
join Logon.Users us on pnacu.BackOfficeUserId = us.UserId
where primaryproductownerid = 455

-- number of subscribers per newsletter
select pnac.Title, count(distinct us.UserName) 
from Product.Products pp 
join ProductProductNewsletterAlerts ppna on pp.productid = ppna.productid
join ProductNewsletterAlertCategories pnac on ppna.NewsletterAlertId = pnac.NewsletterAlertId
join ProductNewsletterAlertCategoriesUser pnacu on pnac.Id = pnacu.NewsletterAlertCategoryId
join Logon.Users us on pnacu.BackOfficeUserId = us.UserId
where primaryproductownerid = 455
group by pnac.Title

-- aggregate newsletters for subscribers
;with x as
(
	select distinct us.UserName, pnac.Title
	from Product.Products pp 
	join ProductProductNewsletterAlerts ppna on pp.productid = ppna.productid
	join ProductNewsletterAlertCategories pnac on ppna.NewsletterAlertId = pnac.NewsletterAlertId
	join ProductNewsletterAlertCategoriesUser pnacu on pnac.Id = pnacu.NewsletterAlertCategoryId
	join Logon.Users us on pnacu.BackOfficeUserId = us.UserId
	where primaryproductownerid = 455
	group by us.UserName, pnac.Title
)

select distinct UserName, string_agg(cast(Title as nvarchar(max)), ', ')
from x
group by UserName
