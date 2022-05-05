
/*

	Create new publication: mipeventsmidas

*/

BEGIN TRY
BEGIN TRANSACTION

DECLARE @pID INT;
DECLARE @stID INT;
DECLARE @pcID INT;
DECLARE @ocID INT;
DECLARE @rateID INT;
DECLARE @scID INT;
DECLARE @sdID INT;


-- Copy of mipSite (pid = 292), except pName and pShortName
INSERT INTO [NewCentralUsers].[dbo].[Publications]
(pName
,pShortName
,pURL
,pNumberOfGUID
,pNumberOfSession
,pCentralContent
,pIssueBased
,pLive
,pCentralContentID
,pProfitCentre
,pSource
,pFeedActive
,pCMSSiteID
,pIsActive
,pNBOStatusId)
VALUES
('Managing Intellectual Property - Midas'
,'mipeventsmidas'
,'www.managingip.com'
,1
,1
,1
,1
,1
,0
,'MIP,MQF'
,'QSS'
,0
,432
,1
,3)

SELECT @pID = SCOPE_IDENTITY()

-- Copy of mipSite (pid = 292)
INSERT INTO [NewCentralUsers].[dbo].[Statuses]
(stPID ,stName ,stMask ,stCheckSession ,stCheckGUID)
VALUES
(@pID ,'registration',	2,	1,	0)

SELECT @stID = SCOPE_IDENTITY()

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
(@pID
,'Free Trial'
,1
,@stID
,1
,1
,'MIP' -- as for pcPID = 292
,22 -- as for pcPID = 292
,130 -- as for pcPID = 292
,GETDATE()
,'C')

SELECT @pcID = SCOPE_IDENTITY()


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
,'..') -- as for other ordercodes corresponding to pub 292

SELECT @ocID = SCOPE_IDENTITY()

INSERT INTO [NewCentralUsers].[dbo].[Rates]
([description])
VALUES
('description')

SELECT @rateID = SCOPE_IDENTITY()

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
,'|61|' -- as for scpcid = 292
,1)

SELECT @scID = SCOPE_IDENTITY()

INSERT INTO [NewCentralUsers]..[SubDefinitions]
(sdOCID ,sdDescription ,sdSubLength ,sdProductPage ,sdActive)
VALUES
(@ocID ,'MIP Free Access', 0, 1, 1)

SELECT @sdID = SCOPE_IDENTITY()

COMMIT TRANSACTION

PRINT 'pID: ' + CONVERT(varchar, @pID)
PRINT 'stID: ' + CONVERT(varchar, @stID)
PRINT 'pcID: ' + CONVERT(varchar, @pcID)
PRINT 'ocID: ' + CONVERT(varchar, @ocID)
PRINT 'rateID: ' + CONVERT(varchar, @rateID)
PRINT 'scID: ' + CONVERT(varchar, @scID)
PRINT 'sdID: ' + CONVERT(varchar, @sdID)

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
END CATCH;