use backoffice

;with ppnatable as (
		select NewsletterAlertId, ProductId 
		from ProductProductNewsletterAlerts
		where productId = 1065755
			union
	    select 2813, 1065755
			union
		select 2813, 1065729
	)
SELECT distinct
		pnac.NewsletterAlertId
	,pnacu.SelectedFormat
	,NewsletterAlertCategoryId
	,Title
	,BackOfficeUserId AS UserId
	,CASE WHEN pnacu.ActionType = 1 THEN 1 ELSE 0 END AS IsSelected
	,ppna.ProductId
	,ps.SiteId
	,*
FROM dbo.ProductNewsletterAlertCategoriesUser pnacu
INNER JOIN dbo.ProductNewsletterAlertCategories pnac ON pnac.Id = pnacu.NewsletterAlertCategoryId
INNER JOIN /*ProductProductNewsletterAlerts*/ppnatable ppna ON ppna.NewsletterAlertId = pnac.NewsletterAlertId
INNER JOIN Product.ProductSites ps ON ps.ProductID = ppna.ProductId
INNER JOIN Orders.Subscription sub ON sub.ProductId = ppna.ProductId
INNER JOIN Logon.SubscriptionUser su ON su.SubscriptionId = sub.SubscriptionId AND su.UserId = BackOfficeUserId
LEFT JOIN Orders.ExcludedSubscription exs ON exs.SubscriptionId = sub.SubscriptionId
LEFT JOIN Logon.SubscriptionUserExcluded exsu ON exsu.SubscriptionUserId = su.SubscriptionUserId


WHERE 
	pnacu.NewsletterAlertCategoryId in (2640)
AND 
	ps.SiteId = 1003137
AND BackOfficeUserId in (1774588, 2651450, 1060136)
		
		
AND	(
		(sub.SubscriptionTypeId = 3 AND sub.SubscriptionEndDateTime >= '2019-07-01')
		OR (sub.SubscriptionTypeId = 2 AND sub.SubscriptionEndDateTime >= '2019-07-01')
	)
--	AND exs.SubscriptionId IS NULL AND exsu.SubscriptionUserId IS NULL
--	AND nuc.NewsletterUsersChoicesOrder = 1 
--AND pnacu.ActionType = 1 -- get the last user's choice and only if newsletter was selected

		
		
order by BackOfficeUserId

		/*


		select top 100 * 
		from ProductProductNewsletterAlerts
		where productid = 1065755


		*/

