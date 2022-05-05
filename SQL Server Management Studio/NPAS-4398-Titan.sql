select *
from [Titan].[dbo].[ConfigurationJson] 
where configid like '%managingip%'  and ConfigType = 4
order by configid, [version] desc


/* 
	Create new clients
*/
  
insert Clients 
select 'DEC2F177-A353-4C96-8F78-C0A5373EB61E', 'mipeventsmidas' 
except 
select ClientGuid, Id from Clients


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
if not exists (select 1 from [Titan].[dbo].[ConfigurationJson] where ConfigId = 'mipeventsmidas' and ConfigType = 3)
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
            "ProductCatalogId": 0,
            "SourceCodeId": 0,
            "SubDefinitionId": 0,
            "OrderCodeId": 0,
            "CurrencyId": 1,
            "PublicationIds": [0]
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


