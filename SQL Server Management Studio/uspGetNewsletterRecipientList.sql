USE [BackOffice]
GO
/****** Object:  StoredProcedure [dbo].[uspGetNewsletterRecipientList]    Script Date: 2021-02-03 15:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspGetNewsletterRecipientList]
	(
		 @SubscriptionExpiryDate DATETIME
		,@TrialExpiryDate        DATETIME
		,@PublicationId          INT
		,@NewsletterId           INT
		,@IncludeRegistrants     BIT = 0
	)
WITH RECOMPILE
AS
SET NOCOUNT ON;

-----------------------------------------------------------------------------
--	Define local variables
-----------------------------------------------------------------------------

DECLARE
	--	Used to invoke RAISERROR
	 @ErrorMessage			NVARCHAR(4000)	--	holds the RAISERROR error message to be returned
	,@ErrorProcedure		SYSNAME			--	holds the stored procedure/trigger name raising the error
	,@DatabaseId			SMALLINT		--	holds the database id from sys.databases
	,@ErrorLogId			INT				--	holds the pk of Error.ErrorLog table, for record added

	,@NboStatusId			AS INT

BEGIN TRY

	-------------------------------------------------------------------------
	--	Check parameter good
	-------------------------------------------------------------------------
	
	SELECT 
	    @ErrorMessage =
			Shared.ufDateTimeIsNull(@SubscriptionExpiryDate, '@SubscriptionExpiryDate') +
			Shared.ufDateTimeIsNull(@TrialExpiryDate,        '@TrialExpiryDate') +
			Shared.ufIntIsNull(@PublicationId,               '@PublicationId') +
			Shared.ufIntIsNull(@NewsletterId,                '@NewsletterId')

	IF	ISNULL(@ErrorMessage,'') != ''
		BEGIN
			SELECT
				 @ErrorMessage = 'Procedure STOPPED, because ' + CHAR(13) + CHAR(10) + @ErrorMessage
				,@ErrorProcedure = OBJECT_NAME(@@PROCID)
				
			EXECUTE AdminHub.Error.uspGenerateError
				 @ErrorMessage
				,16
				,@ErrorProcedure;
		END
	
	-------------------------------------------------------------------------
	--	Delete temp tables used by the stored procedure, if they exist,
	--	create #RawRecipientList temp table to be used by consecutive
	--	parts of the stored procedure.
	-------------------------------------------------------------------------

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

	-------------------------------------------------------------------------
	--	Check if publication is NCU or partial-NPAS.
	-------------------------------------------------------------------------

	SELECT
		@NboStatusId = pNBOStatusId
	FROM
		NewCentralUsers.dbo.Publications
	WHERE
		pID = @PublicationId
	
	IF @NboStatusId = 1
	BEGIN
		
		-------------------------------------------------------------------------
		-- Full NCU
		-------------------------------------------------------------------------

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
	END
	ELSE
	BEGIN

		-------------------------------------------------------------------------
		-- Partial NPAS
		-------------------------------------------------------------------------

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
				   ISNULL(@IncludeRegistrants, 0) = 1
				OR (s.sExpiryDate >= @SubscriptionExpiryDate)
				OR (s.sTrialExpiryDate >= @TrialExpiryDate)
			)
	END
	
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

END TRY
BEGIN CATCH
    --	Rollback active/uncommittable transactions so failure condition can be logged
	IF XACT_STATE() = -1 OR @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION;
		END
	
	SELECT
		@DatabaseId = DB_ID()
	
	--	Record TRY..CATCH error details
    EXECUTE AdminHub.Error.uspAddTryCatchBlockProperties
			 @DatabaseId
			,@ErrorLogId OUTPUT;
			
	SELECT @ErrorLogId = ISNULL(@ErrorLogId,-1);

	IF OBJECT_ID('tempdb..#RawRecipientList') IS NOT NULL
		DROP TABLE #RawRecipientList

	IF OBJECT_ID('tempdb..#EMSScreamerList') IS NOT NULL
		DROP TABLE #EMSScreamerList

	RETURN @ErrorLogId	-- exit returning ErrorLogId (to indicate failure)
END CATCH;