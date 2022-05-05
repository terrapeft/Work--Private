
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


--select * from [NewCentralUsers].[dbo].[Publications] where pshortname = 'mipeventsmidas'

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


/* 
	Create new clients
*/


	if not exists (select 1 from [Titan].[dbo].[Clients] where Id like 'mipeventsmidas%')
	insert into [Titan].[dbo].[Clients] (ClientGuid, Id) values
	('DEC2F177-A353-4C96-8F78-C0A5373EB61E', 'mipeventsmidas' ),
	('9BD0D66B-E615-4CE4-9AA5-C97CE764772C', 'mipeventsmidas_ca' ),
	('B9216BDC-2E78-4F88-991F-10634340EA33', 'mipeventsmidas_cd' )


	-- type 1
	if not exists (select 1 from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'mipeventsmidas' and ConfigType = 1)
	insert into [Titan].[dbo].[ConfigurationJson] (ConfigType, ConfigId, JsonText) values
	(1, 'mipeventsmidas', N'{
		"Panels": [{
			"Title": "Personal Details",
			"Fields": [{
				"Key": "firstName",
				"Validation": ["required"]
			}, {
				"Key": "lastName",
				"Validation": ["required"]
			}, {
				"Key": "jobTitle",
				"Validation": ["required"]
			}, {
				"Key": "companyName",
				"Validation": ["required"]
			}, {
				"Key": "phoneNumber",
				"Validation": ["required", "regex ^[(]{0,1}[\\+]{0,1}[0-9() -]+|[0-9() -]+$", "minLength 6"]
			}, {
				"Key": "city",
				"Validation": ["required"]
			}, {
				"Key": "country",
				"Validation": ["required"]
			}, {
				"Key": "cotype",
				"Validation": ["required"]
			}, {
				"Key": "practicearea",
				"Validation": ["required"]
			}, {
				"Key": "specialization",
				"Validation": ["required"]
			}]
		}]
	}')

	-- type 3
	if not exists (select * from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'mipeventsmidas' and ConfigType = 3)
	insert into [Titan].[dbo].[ConfigurationJson] (ConfigType, ConfigId, JsonText) values
	(3, 'mipeventsmidas', N'{

		"ClientMeta": {
			"ClientId": "mipeventsmidas",
			"ClientName": "Managing Intellectual Property - Midas",
			"AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
			"ClientType": "ncu",
			"Secret": "1ca39218-506e-41d7-84f1-50ec67010bb7",
			"IdmProvider": "titan"
		},
		"LegalCompliance": {
			"Reference": "dataprotectionandlegalrequiredtitan",
			"SiteUri": "http://www.managingip.com",
			"ReplacementKeys": { "Name of business": "Managing Intellectual Property - Midas" },
			"PreSelectCheckboxes": false
		},
		"Ncu": {
			"Trialists": {
				"LapsedTrialistsAmenstyDate": "31/01/2000",
				"LapsedTrialistsEmbargoLengthInMonths": 0
			},
			"Products": [{
				"Id": "9d1d65a2-3cfe-4223-bfc2-c008e4578416",
				"Key": "trial",
				"NcuPreVerifiedStatus": 2,
				"ProductCatalogId":' + CONVERT(varchar, @pcID)
				+ '"SourceCodeId":' + CONVERT(varchar, @scID)
				+ '"SubDefinitionId":' + CONVERT(varchar, @sdID)
				+ '"OrderCodeId":' + CONVERT(varchar, @ocID)
				+ '"CurrencyId": 1,
				"PublicationIds": [' + CONVERT(varchar, @pID) + ']
			}],
			"RetrieveClaims": true
		},
		"GoogleAnalytics": {
			"Enabled": true,
			"GoogleAnalyticsId": "UA-7074740-1",
			"TagManagerId": "GTM-M27ZLQ",
			"WebsiteName": "Managing Intelectual Property",
			"TrackingEmails": {
				"Medium": "Email operational",
				"Source": "Registration Form",
				"Campaign": "Email verification",
				"ContentDateFormat": "yyyy-MM-dd",
				"Term": "Verification link"
			}
		},
		"DefaultFormId": "mipeventsmidas",
		"LegacyCmsSiteId": "432",
		"BrandFolder": "mipeventsmidas",
		"NewsletterIds": [ 776,777,778,779 ],
		"AccessTokenLifetime": 7200,
		"EdenGroupMappings": {"cotype": 58, "practicearea": 56, "specialization": 57}

	}')


	-- type 4
	if not exists (select 1 from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'escdev::mipeventsmidas_localmidas' and ConfigType = 4)
	insert into [Titan].[dbo].[ConfigurationJson] (ConfigType, ConfigId, JsonText) values
	(4, 'escdev::mipeventsmidas_localmidas', N'{
	  "ConfigId": "escdev::mipeventsmidas_localmidas",
	  "JsonText": {
		"ClientSiteUrl": "http://local-midas.events.managingip.com",
		"IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
		"PostLoginRedirectUris": [
		  "http://local-midas.events.managingip.com/idm/in",
		  "https://local-midas.events.managingip.com/idm/in"
		],
		"PostLogoutRedirectUris": [
		  "http://local-midas.events.managingip.com",
		  "http://local-midas.events.managingip.com/logout.aspx",
		  "https://local-midas.events.managingip.com",
		  "https://local-midas.events.managingip.com/logout.aspx"
		]
	  },
	  "ConfigType": 4
	}')


	if not exists (select 1 from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'escdev::mipeventsmidas_cd' and ConfigType = 4)
	insert into [Titan].[dbo].[ConfigurationJson] (ConfigType, ConfigId, JsonText) values
	(4, 'escdev::mipeventsmidas_cd', N'{
	  "ConfigId": "escdev::mipeventsmidas_cd",
	  "JsonText": {
		"ClientSiteUrl": "http://events.managingip.ci02.global.root",
		"IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
		"PostLoginRedirectUris": [
		  "http://events.managingip.ci02.global.root/idm/in",
		  "https://events.managingip.ci02.global.root/idm/in"
		],
		"PostLogoutRedirectUris": [
		  "http://events.managingip.ci02.global.root",
		  "http://events.managingip.ci02.global.root/logout.aspx",
		  "https://events.managingip.ci02.global.root",
		  "https://events.managingip.ci02.global.root/logout.aspx"
		]
	  },
	  "ConfigType": 4
	}')


	if not exists (select 1 from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'escdev::mipeventsmidas_ca' and ConfigType = 4)
	insert into [Titan].[dbo].[ConfigurationJson] (ConfigType, ConfigId, JsonText) values
	(4, 'escdev::mipeventsmidas_ca', N'{
	  "ConfigId": "escdev::mipeventsmidas_ca",
	  "JsonText": {
		"ClientSiteUrl": "http://events-managingip-sitecore.ci02.global.root",
		"IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
		"PostLoginRedirectUris": [
		  "http://events-managingip-sitecore.ci02.global.root/idm/in",
		  "https://events-managingip-sitecore.ci02.global.root/idm/in"
		],
		"PostLogoutRedirectUris": [
		  "http://events-managingip-sitecore.ci02.global.root",
		  "http://events-managingip-sitecore.ci02.global.root/logout.aspx",
		  "https://events-managingip-sitecore.ci02.global.root",
		  "https://events-managingip-sitecore.ci02.global.root/logout.aspx"
		]
	  },
	  "ConfigType": 4
	}')


	if not exists (select 1 from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'azureuat::mipeventsmidas_cd' and ConfigType = 4)
	insert into [Titan].[dbo].[ConfigurationJson] (ConfigType, ConfigId, JsonText) values
	(4, 'azureuat::mipeventsmidas_cd', N'{
	  "ConfigId": "azureuat::mipeventsmidas_cd",
	  "JsonText": {
		"ClientSiteUrl": "http://uat-midas-events.managingip.com",
		"IdmUrl": "https://uat-identitymanagement.euromoneydigital.com",
		"PostLoginRedirectUris": [
		  "http://uat-midas-events.managingip.com/idm/in",
		  "https://uat-midas-events.managingip.com/idm/in"
		],
		"PostLogoutRedirectUris": [
		  "http://uat-midas-events.managingip.com",
		  "http://uat-midas-events.managingip.com/logout.aspx",
		  "https://uat-midas-events.managingip.com",
		  "https://uat-midas-events.managingip.com/logout.aspx"
		],
		"SecureEndpoint": "https://uat-midas-events.managingip.com/idm/in"
	  },
	  "ConfigType": 4
	}')


	if not exists (select 1 from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'azureuat::mipeventsmidas_ca' and ConfigType = 4)
	insert into [Titan].[dbo].[ConfigurationJson] (ConfigType, ConfigId, JsonText) values
	(4, 'azureuat::mipeventsmidas_ca', N'{
	  "ConfigId": "azureuat::mipeventsmidas_ca",
	  "JsonText": {
		"ClientSiteUrl": "http://uat-events-managingip.sitecore.euromoneydigital.com",
		"IdmUrl": "https://uat-identitymanagement.euromoneydigital.com",
		"PostLoginRedirectUris": [
		  "http://uat-events-managingip.sitecore.euromoneydigital.com/idm/in",
		  "https://uat-events-managingip.sitecore.euromoneydigital.com/idm/in"
		],
		"PostLogoutRedirectUris": [
		  "http://uat-events-managingip.sitecore.euromoneydigital.com",
		  "http://uat-events-managingip.sitecore.euromoneydigital.com/logout.aspx",
		  "https://uat-events-managingip.sitecore.euromoneydigital.com",
		  "https://uat-events-managingip.sitecore.euromoneydigital.com/logout.aspx"
		],
		"SecureEndpoint": "https://uat-events-managingip.sitecore.euromoneydigital.com/idm/in"
	  },
	  "ConfigType": 4
	}')


	if not exists (select 1 from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'azureprod::mipeventsmidas_cd' and ConfigType = 4)
	insert into [Titan].[dbo].[ConfigurationJson] (ConfigType, ConfigId, JsonText) values
	(4, 'azureprod::mipeventsmidas_cd', N'{
	  "ConfigId": "azureprod::mipeventsmidas_cd",
	  "JsonText": {
		"ClientSiteUrl": "http://beta-events.managingip.com",
		"IdmUrl": "https://account.managingip.com",
		"PostLoginRedirectUris": [
		  "http://beta-events.managingip.com/idm/in",
		  "https://beta-events.managingip.com/idm/in"
		],
		"PostLogoutRedirectUris": [
		  "http://beta-events.managingip.com",
		  "http://beta-events.managingip.com/logout.aspx",
		  "https://beta-events.managingip.com",
		  "https://beta-events.managingip.com/logout.aspx"
		],
		"SecureEndpoint": "https://beta-events.managingip.com/idm/in"
	  },
	  "ConfigType": 4
	}')


	if not exists (select 1 from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'azureprod::mipeventsmidas_ca' and ConfigType = 4)
	insert into [Titan].[dbo].[ConfigurationJson] (ConfigType, ConfigId, JsonText) values
	(4, 'azureprod::mipeventsmidas_ca', N'{
	  "ConfigId": "azureprod::mipeventsmidas_ca",
	  "JsonText": {
		"ClientSiteUrl": "http://events-managingip.sitecore.euromoneydigital.com",
		"IdmUrl": "https://account.managingip.com",
		"PostLoginRedirectUris": [
		  "http://events-managingip.sitecore.euromoneydigital.com/idm/in",
		  "https://events-managingip.sitecore.euromoneydigital.com/idm/in"
		],
		"PostLogoutRedirectUris": [
		  "http://events-managingip.sitecore.euromoneydigital.com",
		  "http://events-managingip.sitecore.euromoneydigital.com/logout.aspx",
		  "https://events-managingip.sitecore.euromoneydigital.com",
		  "https://events-managingip.sitecore.euromoneydigital.com/logout.aspx"
		],
		"SecureEndpoint": "https://events-managingip.sitecore.euromoneydigital.com/idm/in"
	  },
	  "ConfigType": 4
	}')


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