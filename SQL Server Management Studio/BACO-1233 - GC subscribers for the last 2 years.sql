use backoffice

declare @subscriberLimit date = dateadd(year, -2, getdate())
declare @trialLimit date = dateadd(month, -6, getdate())

;WITH NewsletterUsersChoices AS (
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
-- retrieves Newsletter Recipients List based on dates and activity of User's Subscriptions
,NewsletterRecipientsList AS
(
	SELECT
		 ROW_NUMBER() OVER (PARTITION BY nuc.UserId ORDER BY SubscriptionTypeId DESC) AS SubscriptionTypePriorityOrder
		,sub.SubscriptionStartDateTime
		,sub.SubscriptionEndDateTime
		,sub.SubscriptionTypeId
		,su.SubscriptionId
		,nuc.UserId
		,nuc.SiteId
		,nuc.ProductId
		,nuc.NewsletterAlertId
		,nuc.NewsletterAlertCategoryId
		,nuc.Title
		,nuc.SelectedFormat
	FROM NewsletterUsersChoices nuc
	INNER JOIN Orders.Subscription sub ON sub.ProductId = nuc.ProductId
	INNER JOIN Logon.SubscriptionUser su ON su.SubscriptionId = sub.SubscriptionId AND su.UserId = nuc.UserId
	LEFT JOIN Orders.ExcludedSubscription exs ON exs.SubscriptionId = sub.SubscriptionId
	LEFT JOIN Logon.SubscriptionUserExcluded exsu ON exsu.SubscriptionUserId = su.SubscriptionUserId
	WHERE
		(
			(sub.SubscriptionTypeId = 3 AND sub.SubscriptionEndDateTime >= @subscriberLimit)
			OR (sub.SubscriptionTypeId = 2 AND sub.SubscriptionEndDateTime >= @trialLimit)
		)
		AND exs.SubscriptionId IS NULL AND exsu.SubscriptionUserId IS NULL
		AND nuc.NewsletterUsersChoicesOrder = 1 AND nuc.IsSelected = 1 -- get the last user's choice and only if newsletter was selected
)

select distinct 
     NewsletterAlertId
    ,SelectedFormat
    ,NewsletterAlertCategoryId
    ,Title
    ,UserId
    ,ProductId
    ,SiteId
from NewsletterRecipientsList nrl
