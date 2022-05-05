declare @SiteID					INT = 1003137
declare	@NewsletterAlertCategoryId	INT = 2888
declare	@SubEndDate				DATETIME = '2018-01-01'
declare	@TrialEndDate				DATETIME = '2018-01-01'
declare	@IncludeRegistrants		BIT = 0

	-- retrieves all User's Choices for given Site and Newsletter	
	;with
	--ppnatable as (
	--	select NewsletterAlertId, ProductId 
	--	from ProductProductNewsletterAlerts
	--	where productId = 1065729
	--		union
	--    select NewsletterAlertId, 1065729
	--	from ProductProductNewsletterAlerts
	--	where productid in (1065764)
	--),
	NewsletterUsersChoices AS (
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
		INNER JOIN ProductProductNewsletterAlerts ppna ON ppna.NewsletterAlertId = pnac.NewsletterAlertId
		INNER JOIN Product.ProductSites ps ON ps.ProductID = ppna.ProductId
		WHERE 
			pnacu.NewsletterAlertCategoryId = @NewsletterAlertCategoryId
		AND 
			ps.SiteId = @SiteID
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
			,nuc.SelectedFormat AS SelectedNewsletterFormat
		FROM NewsletterUsersChoices nuc
		INNER JOIN Orders.Subscription sub ON sub.ProductId = nuc.ProductId
		INNER JOIN Logon.SubscriptionUser su ON su.SubscriptionId = sub.SubscriptionId AND su.UserId = nuc.UserId
		LEFT JOIN Orders.ExcludedSubscription exs ON exs.SubscriptionId = sub.SubscriptionId
		LEFT JOIN Logon.SubscriptionUserExcluded exsu ON exsu.SubscriptionUserId = su.SubscriptionUserId
		WHERE
			(
				   ISNULL(@IncludeRegistrants, 0) = 1
				OR (sub.SubscriptionTypeId = 3 AND sub.SubscriptionEndDateTime >= @SubEndDate)
				OR (sub.SubscriptionTypeId = 2 AND sub.SubscriptionEndDateTime >= @TrialEndDate)
			)
			AND exs.SubscriptionId IS NULL AND exsu.SubscriptionUserId IS NULL
			AND nuc.NewsletterUsersChoicesOrder = 1 AND nuc.IsSelected = 1 -- get the last user's choice and only if newsletter was selected
	)
	SELECT DISTINCT top 100 
		 u.UserId
		,u.UserName
		,CASE
			WHEN LOWER(uinfo.Title) = 'not selected' THEN ''
			ELSE uinfo.Title
		 END AS Title
		,CASE
			WHEN LOWER(LTRIM(RTRIM(uinfo.Forenames))) = 'unknown' THEN ''
			ELSE uinfo.Forenames
		 END AS Forenames
		,CASE
			WHEN LOWER(LTRIM(RTRIM(uinfo.Surname))) = 'unknown' THEN ''
			ELSE uinfo.Surname
		 END AS Surname
		,st.SubscriptionType AS UserStatus
		,CASE 
			WHEN nrl.SubscriptionStartDateTime < GETDATE() AND nrl.SubscriptionEndDateTime > GETDATE() THEN 'Active'
			WHEN nrl.SubscriptionEndDateTime < GETDATE() THEN 'Expired'
			ELSE 'N/A' 
		 END AS UserExpiry
		,nrl.SiteId
		,s.Name AS SiteName
		,nrl.ProductId
		,prod.Name AS ProductName
		,nrl.SubscriptionId
		,nrl.SubscriptionStartDateTime
		,nrl.SubscriptionEndDateTime
		,nrl.NewsletterAlertId
		,nrl.NewsletterAlertCategoryId
		,nrl.Title AS NewsletterTitle
		,nrl.SubscriptionTypeId
		,nrl.SelectedNewsletterFormat
	FROM NewsletterRecipientsList nrl
	INNER JOIN Product.Products prod ON prod.ProductID = nrl.ProductId
	INNER JOIN Logon.Users u ON u.UserId = nrl.UserId
	INNER JOIN Orders.SubscriptionType st ON st.SubscriptionTypeId = nrl.SubscriptionTypeId 
	INNER JOIN Product.Site s ON s.SiteId = nrl.SiteId
	CROSS APPLY Customer.ufGetDefaultUserContactBasic(u.UserId) uinfo
	WHERE SubscriptionTypePriorityOrder = 1 -- get the Subscription with the most priority Subscription Type
	and username in ('ADAM.HYLTON@HSF.COM')



