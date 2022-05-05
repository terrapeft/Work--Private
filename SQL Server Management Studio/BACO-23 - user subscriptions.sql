use backoffice

select distinct 
	username,
	s.subscriptionid, 
	c.NewsletterAlertId, 
	pnacu.NewsletterAlertCategoryId, 
	p.productid, 
	subscriptionenddatetime, 
	su.userid, 
	p.Name, 
	ps.SiteId,
	ncupublicationid
from orders.subscription s 
	join Logon.SubscriptionUser su on s.subscriptionid = su.SubscriptionId
	join Logon.Users u on su.UserId = u.UserId
	join product.products p on s.ProductId = p.ProductID
	join ProductNewsletterAlertCategoriesUser pnacu on su.userid = pnacu.BackOfficeUserId
	join ProductNewsletterAlertCategories c on pnacu.newsletteralertcategoryid = c.id
	join Product.ProductSites ps on p.ProductId = ps.ProductId
where 
	su.userid in (1774588, 2651450, 1060136)
	and subscriptionenddatetime > '2019-09-01'
	and newsletteralertcategoryid in (2640,2888)
	and IsActive = 1
	and ncupublicationid = 413
	and subscriptiontypeid in (3, 2)
	and siteId = 1003137
order by su.userid
