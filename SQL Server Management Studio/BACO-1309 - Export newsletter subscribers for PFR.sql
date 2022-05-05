use backoffice

declare @today datetime = getdate()


-- retrieves all User's Choices for given Site and Newsletter	
;WITH NewsletterUsersChoices AS (
	SELECT
		 ROW_NUMBER() OVER (PARTITION BY BackOfficeUserId, NewsletterAlertCategoryId, ppna.ProductId ORDER BY NewsletterAlertCategoryId, pnacu.Id DESC) AS NewsletterUsersChoicesOrder
		,pnac.NewsletterAlertId
		,pnacu.SelectedFormat
		,NewsletterAlertCategoryId
		,Title
		,BackOfficeUserId AS UserId
		,CASE WHEN pnacu.ActionType = 1 THEN 1 ELSE 0 END AS IsSelected
		,ppna.ProductId
		,ps.SiteId
	FROM dbo.ProductNewsletterAlertCategoriesUser pnacu
	INNER JOIN dbo.ProductNewsletterAlertCategories pnac ON pnac.Id = pnacu.NewsletterAlertCategoryId
	INNER JOIN dbo.ProductProductNewsletterAlerts ppna ON ppna.NewsletterAlertId = pnac.NewsletterAlertId
	INNER JOIN Product.ProductSites ps ON ps.ProductID = ppna.ProductId
	WHERE ppna.ProductId in (select ProductID
								from Product.Products
								where name like 'power finance%')
)
-- retrieves Newsletter Recipients List based on dates and activity of User's Subscriptions
,NewsletterRecipientsList AS
(
	SELECT
		 sub.SubscriptionStartDateTime
		,sub.SubscriptionEndDateTime
		,sub.SubscriptionTypeId
		,su.SubscriptionId
		,nuc.UserId
		,nuc.SiteId
		,nuc.ProductId
		,nuc.NewsletterAlertId
		,nuc.NewsletterAlertCategoryId
		,nuc.Title
		,nuc.SelectedFormat AS SelectedNewsletterFormat
	FROM NewsletterUsersChoices nuc
	INNER JOIN Orders.Subscription sub ON sub.ProductId = nuc.ProductId
	INNER JOIN Logon.SubscriptionUser su ON su.SubscriptionId = sub.SubscriptionId AND su.UserId = nuc.UserId
	LEFT JOIN Orders.ExcludedSubscription exs ON exs.SubscriptionId = sub.SubscriptionId
	LEFT JOIN Logon.SubscriptionUserExcluded exsu ON exsu.SubscriptionUserId = su.SubscriptionUserId
	WHERE
		(
			(sub.SubscriptionTypeId = 3 AND sub.SubscriptionEndDateTime >= @today)
			OR (sub.SubscriptionTypeId = 2 AND sub.SubscriptionEndDateTime >= @today)
		)
		AND exs.SubscriptionId IS NULL AND exsu.SubscriptionUserId IS NULL
		AND nuc.NewsletterUsersChoicesOrder = 1 AND nuc.IsSelected = 1 -- get the last user's choice and only if newsletter was selected
)

select 
	 --prod.Name as Product
	 nrl.Title as Newsletter
	,u.UserId
	,uinfo.Title as Salutation
	,uinfo.Forenames as FirstNames
	,uinfo.Surname as LastName
	,uinfo.CompanyName
	,uinfo.EmailAddress

from NewsletterRecipientsList nrl
join Product.Products prod on prod.ProductID = nrl.ProductId
join Logon.Users u on u.UserId = nrl.UserId
join Orders.SubscriptionType st on st.SubscriptionTypeId = nrl.SubscriptionTypeId 
cross apply Customer.ufGetDefaultUserContactBasic(u.UserId) uinfo
order by uinfo.EmailAddress



