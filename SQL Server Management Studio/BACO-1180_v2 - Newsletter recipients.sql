use BackOffice

declare	 @SubscriptionExpiryDate DATETIME = '2005-01-01'
		,@TrialExpiryDate        DATETIME = '2005-01-01'
		,@PublicationId          INT = 5029
		,@NewsletterId           INT = 614
		,@IncludeRegistrants     BIT = 0



	IF OBJECT_ID('tempdb..#RawRecipientList') IS NOT NULL
		DROP TABLE #RawRecipientList

	IF OBJECT_ID('tempdb..#EMSScreamerList') IS NOT NULL
		DROP TABLE #EMSScreamerList

	CREATE TABLE #RawRecipientList
	(
		 EmailAddress             VARCHAR(150)
		,Salutation               VARCHAR(150)
		,FirstName                VARCHAR(150)
		,Surname                  VARCHAR(100)
		,UserExpiry               DATETIME
		,UserStatus               VARCHAR(50)
		,SelectedNewsletterFormat INT
	)


		
		INSERT INTO #RawRecipientList
		(
			 EmailAddress
			,Salutation
			,FirstName
			,Surname
			,UserExpiry
			,UserStatus
			,SelectedNewsletterFormat
		)
		SELECT DISTINCT
			ud.uEmailAddress AS [EmailAddress],
			
			CASE
				WHEN LOWER(LTRIM(RTRIM(COALESCE(ud.uTitle, '')))) IN ('not selected', '#')
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

			CASE
				WHEN nl.nHTML = 1 THEN 1 -- HTML
				ELSE                   2 -- Text
			END
			AS [SelectedNewsletterFormat]

		FROM
			[SQL-NCU].NewCentralUsers.dbo.Newsletters nl WITH (NOLOCK) 
		JOIN
			[SQL-NCU].NewCentralUsers.dbo.UserDetails ud WITH (NOLOCK)
				ON nl.nUID = ud.uID AND nl.nNewsletterID = @NewsletterId
		JOIN
			[SQL-NCU].NewCentralUsers.dbo.Subscriptions s WITH (NOLOCK)
				ON ud.uID = s.sUID AND s.sPid = @PublicationId
		WHERE
		(
			-- Filtering by registration type.
			   ISNULL(@IncludeRegistrants, 0) = 1
			OR (s.sExpiryDate >= @SubscriptionExpiryDate)
			OR (s.sTrialExpiryDate >= @TrialExpiryDate)
		)
		AND
		(
			nl.nPlain = 1 OR nl.nHTML = 1
		)


	-------------------------------------------------------------------------
	--  Lookup all of the EMS screamers
	-------------------------------------------------------------------------

	SELECT uEmail
	INTO #EMSScreamerList
	FROM [UK-SQL-05].EmailCampaign.dbo.C_Unsubscribers WITH (NOLOCK)
	WHERE uCampaignID = 1
	
	-------------------------------------------------------------------------
	-- Remove the EMS screamers from our recipient list	
	-------------------------------------------------------------------------

	DELETE FROM #RawRecipientList
	WHERE EmailAddress COLLATE DATABASE_DEFAULT IN
	(
		SELECT uEmail COLLATE DATABASE_DEFAULT
		FROM #EMSScreamerList
	)
	
	-------------------------------------------------------------------------
	-- Return the resultant recordset
	-------------------------------------------------------------------------

	SELECT
		EmailAddress,
		Salutation,
		FirstName,
		Surname,
		UserExpiry,
		UserStatus,
		SelectedNewsletterFormat
	FROM
		#RawRecipientList

	DROP TABLE #RawRecipientList
	DROP TABLE #EMSScreamerList
