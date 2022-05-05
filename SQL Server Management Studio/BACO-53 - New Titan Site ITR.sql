USE [NewCentralUsers]

BEGIN TRY
    BEGIN TRANSACTION
	DECLARE @stID INT;
    DECLARE @pcID INT;
    DECLARE @ocID INT;
    DECLARE @scID INT;
    DECLARE @sdID INT;
	DECLARE @PublicationName NVARCHAR(MAX) = 'ITR Events';
	DECLARE @PublicationURL NVARCHAR(MAX) = 'beta-events.internationaltaxreview.com';
	DECLARE @ClaimName NVARCHAR(MAX) = 'registrant';
	DECLARE @SubscriptionName NVARCHAR(MAX) = 'ITR Events Registration';
	DECLARE @iiPublicationId INT = 5023; -- International Tax Review - Midas
	DECLARE @publicationId INT;
	DECLARE @rateID INT;

	INSERT INTO NewCentralUsers.dbo.Publications([pName],[pShortName],[pURL],[pEden],[pIP],[pAdmin_Email],[pCustomer_Service_Email],[pTrialDuration],[pNumberOfGUID],[pNumberOfSession],[pEclipseID],[pCentralContent],[pIssueBased],[pCheckSession],[pCheckGUID],[pLive],[pCentralContentID],[pPreviousDb],[PPreviousPID],[pPreviousCode],[pPLCFreeIssue],[pBoat],[pHFIApprovalRequired],[pHFIProductCode],[pCMSSiteID],[pEBMSFeed],[pIsActive],[pParentPublicationID],[pNBOStatusId])
	SELECT @PublicationName,[pShortName],[pURL],[pEden],[pIP],[pAdmin_Email],[pCustomer_Service_Email],[pTrialDuration],[pNumberOfGUID],[pNumberOfSession],[pEclipseID],[pCentralContent],[pIssueBased],[pCheckSession],[pCheckGUID],[pLive],[pCentralContentID],[pPreviousDb],[PPreviousPID],[pPreviousCode],[pPLCFreeIssue],[pBoat],[pHFIApprovalRequired],[pHFIProductCode],[pCMSSiteID],[pEBMSFeed],[pIsActive],[pParentPublicationID],[pNBOStatusId]
	FROM NewCentralUsers.dbo.Publications WHERE [pID]=@iiPublicationId

	SET @publicationId = SCOPE_IDENTITY();

	UPDATE NewCentralUsers.dbo.Publications
	SET pURL = @PublicationURL
	WHERE pID = @publicationID

	INSERT INTO NewCentralUsers.dbo.Rates
    ([description])
    VALUES
    ('default rates')
    SET @rateID = SCOPE_IDENTITY();

	-----------------

	INSERT INTO [NewCentralUsers].[dbo].[Statuses]
    (stPID ,stName ,stMask ,stCheckSession ,stCheckGUID)
    VALUES
    (@publicationId --publicationid
	,@ClaimName, 4 ,0 ,0)
	SELECT @stID = SCOPE_IDENTITY()

	-----------------
	/*
	select	 pcPID
			,pcDescription
			,pcType
			,pcSTID
			,pcFullfilmentType
			,pcActive
			,pcProfitCentre
			,pcVatID
			,pcCostCentre
			,pcCreatedBate
			,pcCreditOrDebit
	from [NewCentralUsers].[dbo].[ProductCatalogue]
	where pcdescription = 'International Tax Review'
	*/
	INSERT INTO [NewCentralUsers].[dbo].[ProductCatalogue]
    (pcPID
    ,pcDescription
    ,pcType
    ,pcSTID
    ,pcFullfilmentType
    ,pcActive
    ,pcProfitCentre
    ,pcVatID
    ,pcCostCentre
    ,pcCreatedBate
    ,pcCreditOrDebit)
    VALUES
    (@publicationId --publicationid
    ,@SubscriptionName -- rename
    ,1
    ,@stID
    ,1
    ,1
    ,'MTX' -- copy from current
    ,11 -- copy from current
    ,164 -- copy from current
    ,GETDATE()
    ,'C')
    SELECT @pcID = SCOPE_IDENTITY()

	-- ------------------
	

	INSERT INTO [NewCentralUsers].[dbo].[OrderCodes]
    (ocDefinition
    ,ocPCID
    ,ocPaymenttype
    ,ocFreePaid
    ,ocPublications)
    VALUES
    ('standard rates'
    ,@pcID
    ,2
    ,2
    ,',' + CAST(@publicationId AS varchar(12)) + ',') --publicationid
	SELECT @ocID = SCOPE_IDENTITY()
	-- -------------------------

	INSERT INTO [NewCentralUsers].[dbo].[Rates]
    ([description])
    VALUES
    ('description')
    SELECT @rateID = SCOPE_IDENTITY()

	-- ------------------------------

	INSERT INTO [NewCentralUsers].[dbo].[SourceCodes]
    (scDefinition
    ,scPCID
    ,scDefault
    ,scRateID
    ,scModifiedDate
    ,scNewRate
    ,scPublications
    ,scActive)
    VALUES
    ('default'
    ,@pcID
    ,1
    ,@rateID
    ,GETDATE()
    ,1
    ,'|' + CAST(@publicationId AS varchar(12)) + '|' -- publication ids
    ,1)
    SELECT @scID = SCOPE_IDENTITY()

	-- ----------------------------------------

	INSERT INTO [NewCentralUsers].[dbo].[SubDefinitions]
    (sdOCID ,sdDescription ,sdSubLength ,sdSubLengthType, sdProductPage ,sdActive)
    VALUES
    (@ocID ,@SubscriptionName, 0, 'days', 1, 1)
    SELECT @sdID = SCOPE_IDENTITY()

	-- -------------------------------------

	INSERT INTO NewCentralUsers.dbo.Prices
    (pRateID
    ,pOCID
    ,pCID
    ,pPrice
    ,pSDID
    ,pAuditLastModifiedDate)
    VALUES
    (@rateID
    ,@ocID
    ,1
    ,0
    ,@sdID
    ,GETDATE())

    INSERT INTO NewCentralUsers.dbo.Prices
    (pRateID
    ,pOCID
    ,pCID
    ,pPrice
    ,pSDID
    ,pAuditLastModifiedDate)
    VALUES
    (@rateID
    ,@ocID
    ,2
    ,0
    ,@sdID
    ,GETDATE())
    
    INSERT INTO NewCentralUsers.dbo.Prices
    (pRateID
    ,pOCID
    ,pCID
    ,pPrice
    ,pSDID
    ,pAuditLastModifiedDate)
    VALUES
    (@rateID
    ,@ocID
    ,3
    ,0
    ,@sdID
    ,GETDATE())

	PRINT 'StatusId: ' + cast(@stID as char(10));
	PRINT 'ProductCatalogId: ' + cast(@pcID as char(10));
	PRINT 'OrderCodeId: ' + cast(@ocID as char(10));
	PRINT 'SourceCodeId: ' + cast(@scID as char(10));
	PRINT 'SubDefinitionId: ' + cast(@sdID as char(10));
	PRINT 'PublicationName: ' + @PublicationName;
	PRINT 'ClaimName: ' + @ClaimName;
	PRINT 'SubscriptionName: ' + @SubscriptionName;
	PRINT 'IIPublicationId: ' + cast(@iiPublicationId as char(10));
	PRINT 'PublicationId: ' + cast(@publicationId as char(10));
	PRINT 'RateId: ' + cast(@rateID as char(10));

    COMMIT TRANSACTION;
END TRY

BEGIN CATCH
    DECLARE @error NVARCHAR(1000)
    SELECT @error = ERROR_MESSAGE()
    PRINT @error
    SELECT ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
END CATCH;
