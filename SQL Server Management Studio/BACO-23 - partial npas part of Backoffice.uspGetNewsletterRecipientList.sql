declare	@SubscriptionExpiryDate DATETIME = '2019-08-30'
declare	@TrialExpiryDate        DATETIME = '2019-08-30'
declare @PublicationId          INT = 388
declare @NewsletterId           INT = 770
declare @IncludeRegistrants     BIT = 1


-------------------------------------------------------------------------
-- Partial NPAS
-------------------------------------------------------------------------

SELECT DISTINCT
	ud.uEmailAddress AS [EmailAddress],
			
	CASE
		WHEN LOWER(LTRIM(RTRIM(COALESCE(ud.uTitle, '')))) = 'not selected'
		THEN ''
		ELSE COALESCE(ud.uTitle, '')
	END
	AS [Salutation],

	CASE
		WHEN LOWER(LTRIM(RTRIM(COALESCE(ud.uForenames, '')))) = 'unknown'
		THEN ''
		ELSE COALESCE(ud.uForenames, '')
	END
	AS [FirstName],

	CASE
		WHEN LOWER(LTRIM(RTRIM(COALESCE(ud.uSurname, '')))) = 'unknown'
		THEN ''
		ELSE COALESCE(ud.uSurname, '')
	END
	AS [Surname],

	CASE
		WHEN s.sExpiryDate IS NULL             THEN s.sTrialExpiryDate
		WHEN s.sTrialExpiryDate IS NULL        THEN s.sExpiryDate
		WHEN s.sExpiryDate >= sTrialExpiryDate THEN s.sExpiryDate
		ELSE                                        s.sTrialExpiryDate
	END
	AS [UserExpiry],

	CASE
		WHEN (s.sExpiryDate IS NULL) AND (s.sTrialExpiryDate IS NULL) THEN ''
		WHEN s.sExpiryDate IS NULL                                    THEN 'Trial'
		WHEN s.sTrialExpiryDate IS NULL                               THEN 'Subscription'
		WHEN s.sExpiryDate >= sTrialExpiryDate                        THEN 'Subscription'
		ELSE                                                               'Trial'
	END
	AS [UserStatus],

	v.SelectedFormat AS [SelectedNewsletterFormat]

FROM
	dbo.vwNewsletterPublicationSubscribedUsersNonBreakingNews v WITH (NOLOCK)
JOIN
	[SQL-NCU].NewCentralUsers.dbo.UserDetails ud WITH (NOLOCK)
		ON v.[Ins3] = ud.[UID]
JOIN
	[SQL-NCU].NewCentralUsers.dbo.Subscriptions s WITH (NOLOCK)
		ON     ud.uID = s.sUID
			AND s.sPID = @PublicationId
WHERE
	v.NewsletterAlertCategoryId = @NewsletterId
	AND
	(
		-- Filtering by registration type.
		@IncludeRegistrants = 1
		OR (s.sExpiryDate >= @SubscriptionExpiryDate)
		OR (s.sTrialExpiryDate >= @TrialExpiryDate)
	)
	and ud.uEmailAddress in ('ann.mathew@ca.ey.com', 'sara.yamotahari@ca.ey.com', 'ADAM.HYLTON@HSF.COM', 'PUBLISHER.ENQUIRIES@ALDL.AC.UK')
	
	
