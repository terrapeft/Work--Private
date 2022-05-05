use BackOffice

begin try 
	begin tran
	drop table if exists #users
	drop table if exists #subs

	-- retrieves all User's Choices for given Site and Newsletter    
	;WITH NewsletterUsersChoices AS ( 
		SELECT 
			 ROW_NUMBER() OVER (PARTITION BY BackOfficeUserId, NewsletterAlertCategoryId, ppna.ProductId ORDER BY NewsletterAlertCategoryId, pnacu.Id DESC) AS NewsletterUsersChoicesOrder 
			,NewsletterAlertCategoryId 
			,BackOfficeUserId AS UserId 
			,CASE WHEN pnacu.ActionType = 1 THEN 1 ELSE 0 END AS IsSelected 
			,ppna.ProductId 
			,ps.SiteId 
		FROM dbo.ProductNewsletterAlertCategoriesUser pnacu 
		INNER JOIN dbo.ProductNewsletterAlertCategories pnac with(NOLOCK)ON pnac.Id = pnacu.NewsletterAlertCategoryId 
		INNER JOIN dbo.ProductProductNewsletterAlerts ppna with(NOLOCK) ON ppna.NewsletterAlertId = pnac.NewsletterAlertId 
		INNER JOIN Product.ProductSites ps with(NOLOCK) ON ps.ProductID = ppna.ProductId 
		INNER JOIN Orders.Subscription sub with(NOLOCK) ON sub.ProductId = ppna.ProductId 
		INNER JOIN Logon.SubscriptionUser su with(NOLOCK) ON su.SubscriptionId = sub.SubscriptionId AND su.UserId = BackOfficeUserId 
		LEFT JOIN Orders.ExcludedSubscription exs with(NOLOCK) ON exs.SubscriptionId = sub.SubscriptionId 
		LEFT JOIN Logon.SubscriptionUserExcluded exsu with(NOLOCK) ON exsu.SubscriptionUserId = su.SubscriptionUserId 
		WHERE pnacu.NewsletterAlertCategoryId = 606 
		and ps.SiteId = 1002422
		AND exs.SubscriptionId IS NULL 
		AND exsu.SubscriptionUserId IS NULL 

	) 
	-- retrieves Newsletter Recipients List based on dates and activity of User's Subscriptions 
	,NewsletterRecipientsList AS 
	( 
		SELECT 
			 ROW_NUMBER() OVER (PARTITION BY nuc.UserId ORDER BY SubscriptionTypeId DESC, SubscriptionEndDateTime desc) AS SubscriptionTypePriorityOrder 
			,sub.SubscriptionStartDateTime 
			,sub.SubscriptionEndDateTime 
			,sub.SubscriptionTypeId 
			,nuc.UserId 
			,nuc.SiteId 
			,nuc.ProductId 
		FROM NewsletterUsersChoices nuc 
		INNER JOIN Orders.Subscription sub with(NOLOCK) ON sub.ProductId = nuc.ProductId 
		INNER JOIN Logon.SubscriptionUser su with(NOLOCK) ON su.SubscriptionId = sub.SubscriptionId AND su.UserId = nuc.UserId 
		LEFT JOIN Orders.ExcludedSubscription exs with(NOLOCK) ON exs.SubscriptionId = sub.SubscriptionId 
		LEFT JOIN Logon.SubscriptionUserExcluded exsu with(NOLOCK) ON exsu.SubscriptionUserId = su.SubscriptionUserId 
		WHERE nuc.NewsletterUsersChoicesOrder = 1 AND nuc.IsSelected = 1  
		-- get the last user's choice and only if newsletter was selected 
	) 
	SELECT DISTINCT u.UserName, SubscriptionStartDateTime, SubscriptionEndDateTime--, nrl.SiteId
	into #users
	FROM NewsletterRecipientsList nrl 
	INNER JOIN Product.Products prod with(NOLOCK) ON prod.ProductID = nrl.ProductId 
	INNER JOIN Logon.Users u with(NOLOCK) ON u.UserId = nrl.UserId 
	INNER JOIN Orders.SubscriptionType st with(NOLOCK) ON st.SubscriptionTypeId = nrl.SubscriptionTypeId  
	INNER JOIN Product.Site s with(NOLOCK) ON s.SiteId = nrl.SiteId 
	WHERE SubscriptionTypePriorityOrder = 1 -- get the Subscription with the most priority Subscription Type 

	select *
	into #subs
	from NewCentralUsers.dbo.Subscriptions s 
	join NewCentralUsers.dbo.Userdetails ud on s.suid = ud.uid
	join #users us on ud.uUsername collate database_default = us.UserName collate database_default
	where spid = 5029
	and sExpiryDate >= SubscriptionEndDateTime


    insert into [dbo].[Subscriptions_Stage]
           ([sID]
           ,[sUID]
           ,[sPID]
           ,[sStartDate]
           ,[sExpiryDate]
           ,[sTrialExpiryDate]
           ,[sSubscriptionNumber]
           ,[sMasterRecord]
           ,[sAllowedSessions]
           ,[sNumberOfLogons]
           ,[sNumberOfGUIDs]
           ,[sStatus]
           ,[sCreationDate]
           ,[sCreatedBy]
           ,[sUpdateDate]
           ,[sUpdatedBy]
           ,[sAreasOfInterest]
           ,[sFirstLoggedOn]
           ,[sComments]
           ,[sQuestion]
           ,[sPendingPayment]
           ,[sIPOnly]
           ,[sAdditionalQuestions]
           ,[sCopyPaste]
           ,[sGUID]
           ,[sIPLogOnCheck]
           ,[sTrialTerminatedDate]
           ,[sAction])
     SELECT 
			[sID]
           ,[sUID]
           ,[sPID]
           ,[sStartDate]
           ,[sExpiryDate]
           ,[sTrialExpiryDate]
           ,[sSubscriptionNumber]
           ,[sMasterRecord]
           ,[sAllowedSessions]
           ,[sNumberOfLogons]
           ,[sNumberOfGUIDs]
           ,[sStatus]
           ,[sCreationDate]
           ,[sCreatedBy]
           ,[sUpdateDate]
           ,[sUpdatedBy]
           ,[sAreasOfInterest]
           ,[sFirstLoggedOn]
           ,case 
                when sComments is null then 'BACO-1078'
                else sComments  + ' | BACO-1078'
            end as sComments
           ,[sQuestion]
           ,[sPendingPayment]
           ,[sIPOnly]
           ,[sAdditionalQuestions]
           ,[sCopyPaste]
           ,[sGUID]
           ,[sIPLogOnCheck]
           ,[sTrialTerminatedDate]
           ,'I'
    from #subs

	commit tran
end try
begin catch
	if (@@trancount > 0)
		rollback
	;throw
end catch


