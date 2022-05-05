/*

select name, compatibility_level
from sys.databases

*/


use tempdb -- compatibility level must be > 130 in order to use the openjson

DECLARE @json NVARCHAR(MAX);
SET @json = N'[
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "amm",
                "IdmProvider": "titan",
                "ClientName": "American Metal Market",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "c1e75cd9-5804-43c9-9ee2-59c194ea9248"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.amm.com",
                "ReplacementKeys": {
                    "Name of business": "American Metal Markets"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-18054912-16",
                "TagManagerId": "GTM-5FFF3M",
                "WebsiteName": "American Metal Markets",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                291
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 17453,
                    "SourceCodeId": 25125,
                    "SubDefinitionId": 46803,
                    "OrderCodeId": 16800,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        291
                    ],
                    "Id": "70071393-d0c6-484d-8ea1-6f1a16b21a6e",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "amm",
            "LegacyCmsSiteId": 168,
            "BrandFolder": "fm-amm",
            "EdenGroupMappings": {
                "cotype": 277,
                "area": 278,
                "jobf": 279
            },
            "NewsletterIds": [
                442
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 3
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 17453,
                        "SourceCodeId": 25125,
                        "SubDefinitionId": 46803,
                        "OrderCodeId": 16800,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            291
                        ],
                        "Id": "70071393-d0c6-484d-8ea1-6f1a16b21a6e",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 291,
                "PublicationIds": [
                    291
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-amm.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-amm.ci03.global.root/idm/in",
                "https://dev-amm.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-amm.ci03.global.root",
                "http://dev-amm.ci03.global.root/logout.aspx",
                "https://dev-amm.ci03.global.root",
                "https://dev-amm.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-amm.ci03.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-amm.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-amm.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "amm_local",
                "IdmProvider": "titan",
                "ClientName": "American Metal Market",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "c1e75cd9-5804-43c9-9ee2-59c194ea9248"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.amm.com",
                "ReplacementKeys": {
                    "Name of business": "American Metal Markets"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-18054912-16",
                "TagManagerId": "GTM-5FFF3M",
                "WebsiteName": "American Metal Markets",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                291
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 17453,
                    "SourceCodeId": 25125,
                    "SubDefinitionId": 46803,
                    "OrderCodeId": 16800,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        291
                    ],
                    "Id": "70071393-d0c6-484d-8ea1-6f1a16b21a6e",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "amm",
            "LegacyCmsSiteId": 168,
            "BrandFolder": "fm-amm",
            "EdenGroupMappings": {
                "cotype": 277,
                "area": 278,
                "jobf": 279
            },
            "NewsletterIds": [
                442
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 3
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 17453,
                        "SourceCodeId": 25125,
                        "SubDefinitionId": 46803,
                        "OrderCodeId": 16800,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            291
                        ],
                        "Id": "70071393-d0c6-484d-8ea1-6f1a16b21a6e",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 291,
                "PublicationIds": [
                    291
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://local.amm.com",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://local.amm.com/idm/in",
                "https://local.amm.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://local.amm.com",
                "http://local.amm.com/logout.aspx",
                "https://local.amm.com",
                "https://local.amm.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://local.amm.com/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://local.amm.com/idm/in",
        "CompleteAuthCodeRedirectUri": "http://local.amm.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "AMMEvents",
                "IdmProvider": "titan",
                "ClientName": "AMM Events",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "2e8672bc-da72-48f4-9115-06af23596521"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.amm.com/events",
                "ReplacementKeys": {
                    "Name of business": "AMM Events"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-18054912-3",
                "TagManagerId": "GTM-57TNWK",
                "WebsiteName": "AMM Events",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Titan registration",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                291
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 17463,
                    "SourceCodeId": 25142,
                    "SubDefinitionId": 46835,
                    "OrderCodeId": 16811,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        291
                    ],
                    "Id": "cafec83e-451d-4e9e-b517-8c245be276fa",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "AMMEvents",
            "LegacyCmsSiteId": 826,
            "BrandFolder": "fm-amm",
            "EdenGroupMappings": {
                "jobf": 292,
                "cotype": 290,
                "area": 291
            },
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 180
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 17463,
                        "SourceCodeId": 25142,
                        "SubDefinitionId": 46835,
                        "OrderCodeId": 16811,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            291
                        ],
                        "Id": "cafec83e-451d-4e9e-b517-8c245be276fa",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 291,
                "PublicationIds": [
                    291
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-amm.ci03.global.root/events",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-amm.ci03.global.root/events/idm/in",
                "https://dev-amm.ci03.global.root/events/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-amm.ci03.global.root/events",
                "http://dev-amm.ci03.global.root/events/logout.aspx",
                "https://dev-amm.ci03.global.root/events",
                "https://dev-amm.ci03.global.root/events/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-amm.ci03.global.root/events/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-amm.ci03.global.root/events/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-amm.ci03.global.root/events/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "AMMEvents_local",
                "IdmProvider": "titan",
                "ClientName": "AMM Events",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "2e8672bc-da72-48f4-9115-06af23596521"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.amm.com/events",
                "ReplacementKeys": {
                    "Name of business": "AMM Events"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-18054912-3",
                "TagManagerId": "GTM-57TNWK",
                "WebsiteName": "AMM Events",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Titan registration",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                291
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 17463,
                    "SourceCodeId": 25142,
                    "SubDefinitionId": 46835,
                    "OrderCodeId": 16811,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        291
                    ],
                    "Id": "cafec83e-451d-4e9e-b517-8c245be276fa",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "AMMEvents",
            "LegacyCmsSiteId": 826,
            "BrandFolder": "fm-amm",
            "EdenGroupMappings": {
                "jobf": 292,
                "cotype": 290,
                "area": 291
            },
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 180
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 17463,
                        "SourceCodeId": 25142,
                        "SubDefinitionId": 46835,
                        "OrderCodeId": 16811,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            291
                        ],
                        "Id": "cafec83e-451d-4e9e-b517-8c245be276fa",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 291,
                "PublicationIds": [
                    291
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://local.amm.com/events",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://local.amm.com/events/idm/in",
                "https://local.amm.com/events/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://local.amm.com/events",
                "http://local.amm.com/events/logout.aspx",
                "https://local.amm.com/events",
                "https://local.amm.com/events/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://local.amm.com/events/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://local.amm.com/events/idm/in",
        "CompleteAuthCodeRedirectUri": "http://local.amm.com/events/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "benchmark",
                "IdmProvider": "",
                "ClientName": "Benchmark Litigation",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "91a9386d-15d2-4174-99fc-faa578918c3d"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.benchmarklitigation.com",
                "ReplacementKeys": {
                    "Name of business": "Benchmark Litigation"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "",
                "TagManagerId": "GTM-TW3Z9V",
                "WebsiteName": "Benchmark Litigation",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                368
            ],
            "Products": [
                {
                    "ProductId": 1087799,
                    "NcuPublicationId": 368,
                    "Id": "0470d155-4409-4dc6-ac51-7c2be7e27c4f",
                    "Key": "Trial"
                }
            ],
            "DefaultFormId": "minimal",
            "LegacyCmsSiteId": 179,
            "BrandFolder": "benchmark",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1005138,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 12
                },
                "Products": [
                    {
                        "ProductId": 1087799,
                        "NcuPublicationId": 368,
                        "Id": "0470d155-4409-4dc6-ac51-7c2be7e27c4f",
                        "Key": "Trial"
                    }
                ],
                "PublicationIds": [
                    368
                ],
                "PrimaryPublicationId": 368,
                "DefaultTrialDurationDays": 14
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev.benchmarklitigation.com",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev.benchmarklitigation.com/idm/in",
                "https://dev.benchmarklitigation.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev.benchmarklitigation.com",
                "http://dev.benchmarklitigation.com/logout.aspx",
                "https://dev.benchmarklitigation.com",
                "https://dev.benchmarklitigation.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev.benchmarklitigation.com/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev.benchmarklitigation.com/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev.benchmarklitigation.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "benchmark_local",
                "IdmProvider": "",
                "ClientName": "Benchmark Litigation",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "91a9386d-15d2-4174-99fc-faa578918c3d"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.benchmarklitigation.com",
                "ReplacementKeys": {
                    "Name of business": "Benchmark Litigation"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "",
                "TagManagerId": "GTM-TW3Z9V",
                "WebsiteName": "Benchmark Litigation",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                368
            ],
            "Products": [
                {
                    "ProductId": 1087799,
                    "NcuPublicationId": 368,
                    "Id": "0470d155-4409-4dc6-ac51-7c2be7e27c4f",
                    "Key": "Trial"
                }
            ],
            "DefaultFormId": "minimal",
            "LegacyCmsSiteId": 179,
            "BrandFolder": "benchmark",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1005138,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 12
                },
                "Products": [
                    {
                        "ProductId": 1087799,
                        "NcuPublicationId": 368,
                        "Id": "0470d155-4409-4dc6-ac51-7c2be7e27c4f",
                        "Key": "Trial"
                    }
                ],
                "PublicationIds": [
                    368
                ],
                "PrimaryPublicationId": 368,
                "DefaultTrialDurationDays": 14
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://local.benchmarklitigation.com",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://local.benchmarklitigation.com/idm/in",
                "https://local.benchmarklitigation.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://local.benchmarklitigation.com",
                "http://local.benchmarklitigation.com/logout.aspx",
                "https://local.benchmarklitigation.com",
                "https://local.benchmarklitigation.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://local.benchmarklitigation.com/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://local.benchmarklitigation.com/idm/in",
        "CompleteAuthCodeRedirectUri": "http://local.benchmarklitigation.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "capacityconferences",
                "IdmProvider": "titan",
                "ClientName": "Capacity Conferences",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "f8c64fb7-d6cd-433f-8269-de1930dcc414"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.capacityconferences.com",
                "ReplacementKeys": {
                    "Name of business": "Capacity Conferences"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": false,
                "GoogleAnalyticsId": null,
                "TagManagerId": null,
                "WebsiteName": null,
                "TrackingEmails": {
                    "Medium": null,
                    "Source": null,
                    "Campaign": null,
                    "ContentDateFormat": null,
                    "Term": null
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [],
            "Products": [],
            "DefaultFormId": null,
            "LegacyCmsSiteId": -1,
            "BrandFolder": "",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 0,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev.capacityconferences.com",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev.capacityconferences.com/idm/in",
                "https://dev.capacityconferences.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev.capacityconferences.com",
                "http://dev.capacityconferences.com/logout.aspx",
                "https://dev.capacityconferences.com",
                "https://dev.capacityconferences.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev.capacityconferences.com/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev.capacityconferences.com/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev.capacityconferences.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "capacityconferences_local",
                "IdmProvider": "titan",
                "ClientName": "Capacity Conferences",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "f8c64fb7-d6cd-433f-8269-de1930dcc414"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.capacityconferences.com",
                "ReplacementKeys": {
                    "Name of business": "Capacity Conferences"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": false,
                "GoogleAnalyticsId": null,
                "TagManagerId": null,
                "WebsiteName": null,
                "TrackingEmails": {
                    "Medium": null,
                    "Source": null,
                    "Campaign": null,
                    "ContentDateFormat": null,
                    "Term": null
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [],
            "Products": [],
            "DefaultFormId": null,
            "LegacyCmsSiteId": -1,
            "BrandFolder": "",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 0,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://local.capacityconferences.com",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://local.capacityconferences.com/idm/in",
                "https://local.capacityconferences.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://local.capacityconferences.com",
                "http://local.capacityconferences.com/logout.aspx",
                "https://local.capacityconferences.com",
                "https://local.capacityconferences.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://local.capacityconferences.com/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://local.capacityconferences.com/idm/in",
        "CompleteAuthCodeRedirectUri": "http://local.capacityconferences.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "coaltrans_ca",
                "IdmProvider": "",
                "ClientName": "Coaltrans Conferences",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "6569efac-8026-4e58-a2a8-483b513a98e4"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://coaltrans.com/",
                "ReplacementKeys": {},
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7226941-1",
                "TagManagerId": "\tGTM-PDT2WS",
                "WebsiteName": "Coaltrans Conferences",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Titan registration",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                66
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 18753,
                    "SourceCodeId": 27480,
                    "SubDefinitionId": 52295,
                    "OrderCodeId": 18080,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        66
                    ],
                    "Id": "572282b3-55fb-437a-90b7-e3b2e3936748",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "fftevents",
            "LegacyCmsSiteId": 833,
            "BrandFolder": "coaltrans",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 180
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 18753,
                        "SourceCodeId": 27480,
                        "SubDefinitionId": 52295,
                        "OrderCodeId": 18080,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            66
                        ],
                        "Id": "572282b3-55fb-437a-90b7-e3b2e3936748",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 66,
                "PublicationIds": [
                    66
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://coaltrans-sitecore.ci02.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://coaltrans-sitecore.ci02.global.root/idm/in",
                "https://coaltrans-sitecore.ci02.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://coaltrans-sitecore.ci02.global.root",
                "http://coaltrans-sitecore.ci02.global.root/logout.aspx",
                "https://coaltrans-sitecore.ci02.global.root",
                "https://coaltrans-sitecore.ci02.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://coaltrans-sitecore.ci02.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://coaltrans-sitecore.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://coaltrans-sitecore.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "coaltrans_cd",
                "IdmProvider": "",
                "ClientName": "Coaltrans Conferences",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "6569efac-8026-4e58-a2a8-483b513a98e4"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://coaltrans.com/",
                "ReplacementKeys": {},
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7226941-1",
                "TagManagerId": "\tGTM-PDT2WS",
                "WebsiteName": "Coaltrans Conferences",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Titan registration",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                66
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 18753,
                    "SourceCodeId": 27480,
                    "SubDefinitionId": 52295,
                    "OrderCodeId": 18080,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        66
                    ],
                    "Id": "572282b3-55fb-437a-90b7-e3b2e3936748",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "fftevents",
            "LegacyCmsSiteId": 833,
            "BrandFolder": "coaltrans",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 180
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 18753,
                        "SourceCodeId": 27480,
                        "SubDefinitionId": 52295,
                        "OrderCodeId": 18080,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            66
                        ],
                        "Id": "572282b3-55fb-437a-90b7-e3b2e3936748",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 66,
                "PublicationIds": [
                    66
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://coaltrans.ci02.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://coaltrans.ci02.global.root/idm/in",
                "https://coaltrans.ci02.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://coaltrans.ci02.global.root",
                "http://coaltrans.ci02.global.root/logout.aspx",
                "https://coaltrans.ci02.global.root",
                "https://coaltrans.ci02.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://coaltrans.ci02.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://coaltrans.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://coaltrans.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "euromoney",
                "IdmProvider": "titan",
                "ClientName": "Euromoney",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "1337f4f5-2885-4358-8820-2ba05ec9f533"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.euromoney.com",
                "ReplacementKeys": {
                    "Name of business": "Euromoney"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7039836-6",
                "TagManagerId": "GTM-N5MPN4",
                "WebsiteName": "Euromoney",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                2
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 8,
                    "ProductCatalogId": 2309,
                    "SourceCodeId": 2877,
                    "SubDefinitionId": 3078,
                    "OrderCodeId": 2232,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        2
                    ],
                    "Id": "829363dc-6c04-4795-a339-e409e763a152",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "euromoney",
            "LegacyCmsSiteId": 1,
            "BrandFolder": "euromoney",
            "EdenGroupMappings": {
                "areamulti": 81,
                "cotype": 80
            },
            "NewsletterIds": [
                815,
                904
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 3
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 8,
                        "ProductCatalogId": 2309,
                        "SourceCodeId": 2877,
                        "SubDefinitionId": 3078,
                        "OrderCodeId": 2232,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            2
                        ],
                        "Id": "829363dc-6c04-4795-a339-e409e763a152",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": true,
                "PrimaryPublicationId": 2,
                "PublicationIds": [
                    2
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": true,
            "RememberMeDurationInDays": 365,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-myaccount-euromoney.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-myaccount-euromoney.ci03.global.root/idm/in",
                "https://dev-myaccount-euromoney.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-myaccount-euromoney.ci03.global.root",
                "http://dev-myaccount-euromoney.ci03.global.root/logout.aspx",
                "https://dev-myaccount-euromoney.ci03.global.root",
                "https://dev-myaccount-euromoney.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-myaccount-euromoney.ci03.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-myaccount-euromoney.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-myaccount-euromoney.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "euromoney_81_ca",
                "IdmProvider": "titan",
                "ClientName": "Euromoney",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "1337f4f5-2885-4358-8820-2ba05ec9f533"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.euromoney.com",
                "ReplacementKeys": {
                    "Name of business": "Euromoney"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7039836-6",
                "TagManagerId": "GTM-N5MPN4",
                "WebsiteName": "Euromoney",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                2
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 8,
                    "ProductCatalogId": 2309,
                    "SourceCodeId": 2877,
                    "SubDefinitionId": 3078,
                    "OrderCodeId": 2232,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        2
                    ],
                    "Id": "829363dc-6c04-4795-a339-e409e763a152",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "euromoney",
            "LegacyCmsSiteId": 1,
            "BrandFolder": "euromoney",
            "EdenGroupMappings": {
                "areamulti": 81,
                "cotype": 80
            },
            "NewsletterIds": [
                815,
                904
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 3
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 8,
                        "ProductCatalogId": 2309,
                        "SourceCodeId": 2877,
                        "SubDefinitionId": 3078,
                        "OrderCodeId": 2232,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            2
                        ],
                        "Id": "829363dc-6c04-4795-a339-e409e763a152",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": true,
                "PrimaryPublicationId": 2,
                "PublicationIds": [
                    2
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": true,
            "RememberMeDurationInDays": 365,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://ca-euromoney-81.ci02.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://ca-euromoney-81.ci02.global.root/idm/in",
                "https://ca-euromoney-81.ci02.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://ca-euromoney-81.ci02.global.root",
                "http://ca-euromoney-81.ci02.global.root/logout.aspx",
                "https://ca-euromoney-81.ci02.global.root",
                "https://ca-euromoney-81.ci02.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://ca-euromoney-81.ci02.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://ca-euromoney-81.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://ca-euromoney-81.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "euromoney_81_cd",
                "IdmProvider": "titan",
                "ClientName": "Euromoney",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "1337f4f5-2885-4358-8820-2ba05ec9f533"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.euromoney.com",
                "ReplacementKeys": {
                    "Name of business": "Euromoney"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7039836-6",
                "TagManagerId": "GTM-N5MPN4",
                "WebsiteName": "Euromoney",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                2
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 8,
                    "ProductCatalogId": 2309,
                    "SourceCodeId": 2877,
                    "SubDefinitionId": 3078,
                    "OrderCodeId": 2232,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        2
                    ],
                    "Id": "829363dc-6c04-4795-a339-e409e763a152",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "euromoney",
            "LegacyCmsSiteId": 1,
            "BrandFolder": "euromoney",
            "EdenGroupMappings": {
                "areamulti": 81,
                "cotype": 80
            },
            "NewsletterIds": [
                815,
                904
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 3
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 8,
                        "ProductCatalogId": 2309,
                        "SourceCodeId": 2877,
                        "SubDefinitionId": 3078,
                        "OrderCodeId": 2232,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            2
                        ],
                        "Id": "829363dc-6c04-4795-a339-e409e763a152",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": true,
                "PrimaryPublicationId": 2,
                "PublicationIds": [
                    2
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": true,
            "RememberMeDurationInDays": 365,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://cd-euromoney-81.ci02.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://cd-euromoney-81.ci02.global.root/idm/in",
                "https://cd-euromoney-81.ci02.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://cd-euromoney-81.ci02.global.root",
                "http://cd-euromoney-81.ci02.global.root/logout.aspx",
                "https://cd-euromoney-81.ci02.global.root",
                "https://cd-euromoney-81.ci02.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://cd-euromoney-81.ci02.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://cd-euromoney-81.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://cd-euromoney-81.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "euromoney_azureca",
                "IdmProvider": "titan",
                "ClientName": "Euromoney",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "1337f4f5-2885-4358-8820-2ba05ec9f533"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.euromoney.com",
                "ReplacementKeys": {
                    "Name of business": "Euromoney"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7039836-6",
                "TagManagerId": "GTM-N5MPN4",
                "WebsiteName": "Euromoney",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                2
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 8,
                    "ProductCatalogId": 2309,
                    "SourceCodeId": 2877,
                    "SubDefinitionId": 3078,
                    "OrderCodeId": 2232,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        2
                    ],
                    "Id": "829363dc-6c04-4795-a339-e409e763a152",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "euromoney",
            "LegacyCmsSiteId": 1,
            "BrandFolder": "euromoney",
            "EdenGroupMappings": {
                "areamulti": 81,
                "cotype": 80
            },
            "NewsletterIds": [
                815,
                904
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 3
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 8,
                        "ProductCatalogId": 2309,
                        "SourceCodeId": 2877,
                        "SubDefinitionId": 3078,
                        "OrderCodeId": 2232,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            2
                        ],
                        "Id": "829363dc-6c04-4795-a339-e409e763a152",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": true,
                "PrimaryPublicationId": 2,
                "PublicationIds": [
                    2
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": true,
            "RememberMeDurationInDays": 365,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-euromoney-sitecore.ci02.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-euromoney-sitecore.ci02.global.root/idm/in",
                "https://dev-euromoney-sitecore.ci02.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-euromoney-sitecore.ci02.global.root",
                "http://dev-euromoney-sitecore.ci02.global.root/logout.aspx",
                "https://dev-euromoney-sitecore.ci02.global.root",
                "https://dev-euromoney-sitecore.ci02.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-euromoney-sitecore.ci02.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-euromoney-sitecore.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-euromoney-sitecore.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "euromoney_local",
                "IdmProvider": "titan",
                "ClientName": "Euromoney",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "1337f4f5-2885-4358-8820-2ba05ec9f533"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.euromoney.com",
                "ReplacementKeys": {
                    "Name of business": "Euromoney"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7039836-6",
                "TagManagerId": "GTM-N5MPN4",
                "WebsiteName": "Euromoney",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                2
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 8,
                    "ProductCatalogId": 2309,
                    "SourceCodeId": 2877,
                    "SubDefinitionId": 3078,
                    "OrderCodeId": 2232,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        2
                    ],
                    "Id": "829363dc-6c04-4795-a339-e409e763a152",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "euromoney",
            "LegacyCmsSiteId": 1,
            "BrandFolder": "euromoney",
            "EdenGroupMappings": {
                "areamulti": 81,
                "cotype": 80
            },
            "NewsletterIds": [
                815,
                904
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 3
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 8,
                        "ProductCatalogId": 2309,
                        "SourceCodeId": 2877,
                        "SubDefinitionId": 3078,
                        "OrderCodeId": 2232,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            2
                        ],
                        "Id": "829363dc-6c04-4795-a339-e409e763a152",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": true,
                "PrimaryPublicationId": 2,
                "PublicationIds": [
                    2
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": true,
            "RememberMeDurationInDays": 365,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://local.euromoney.com",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://local.euromoney.com/idm/in",
                "https://local.euromoney.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://local.euromoney.com",
                "http://local.euromoney.com/logout.aspx",
                "https://local.euromoney.com",
                "https://local.euromoney.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://local.euromoney.com/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://local.euromoney.com/idm/in",
        "CompleteAuthCodeRedirectUri": "http://local.euromoney.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "euromoneymd",
                "IdmProvider": "titan",
                "ClientName": "Euromoney Market Data",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "30340e37-1f5a-412c-a4b1-7127c988ba45"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.euromoneymarketdata.com",
                "ReplacementKeys": {
                    "Name of business": "Euromoney Market Data"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "",
                "TagManagerId": "",
                "WebsiteName": "Euromoney Market Data",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                238
            ],
            "Products": [
                {
                    "ProductId": 1065728,
                    "NcuPublicationId": 238,
                    "Id": "36e554fd-658c-41c1-90c0-cfad68e94eef",
                    "Key": "Trial"
                }
            ],
            "DefaultFormId": "euromoneymd",
            "LegacyCmsSiteId": 146,
            "BrandFolder": "euromoneymd",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1002984,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 12
                },
                "Products": [
                    {
                        "ProductId": 1065728,
                        "NcuPublicationId": 238,
                        "Id": "36e554fd-658c-41c1-90c0-cfad68e94eef",
                        "Key": "Trial"
                    }
                ],
                "PublicationIds": [
                    238
                ],
                "PrimaryPublicationId": 238,
                "DefaultTrialDurationDays": 14
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-euromoneymarketdata.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-euromoneymarketdata.ci03.global.root/idm/in",
                "https://dev-euromoneymarketdata.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-euromoneymarketdata.ci03.global.root",
                "http://dev-euromoneymarketdata.ci03.global.root/logout.aspx",
                "https://dev-euromoneymarketdata.ci03.global.root",
                "https://dev-euromoneymarketdata.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-euromoneymarketdata.ci03.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-euromoneymarketdata.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-euromoneymarketdata.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "fmdatasolutions",
                "IdmProvider": "titan",
                "ClientName": "Fastmarkets Data Solutions",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "193a2865-61b3-4604-8b6c-3a3aedb83b1a"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.metalbulletin.com",
                "ReplacementKeys": {
                    "Name of business": "MetalBulletin"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-113890-16",
                "TagManagerId": "GTM-K22LFG",
                "WebsiteName": "Metal Bulletin",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                225
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 8420,
                    "SourceCodeId": 10282,
                    "SubDefinitionId": 17338,
                    "OrderCodeId": 8064,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        225
                    ],
                    "Id": "8e3569bb-090e-461c-b082-7edb35017daa",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "mb",
            "LegacyCmsSiteId": 863,
            "BrandFolder": "fm-datasolutions",
            "EdenGroupMappings": {
                "jobf": 289,
                "cotype": 287,
                "area": 288
            },
            "NewsletterIds": [
                147,
                511,
                512,
                758,
                804,
                896
            ],
            "AccessTokenLifetime": 7201,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 8420,
                        "SourceCodeId": 10282,
                        "SubDefinitionId": 17338,
                        "OrderCodeId": 8064,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            225
                        ],
                        "Id": "8e3569bb-090e-461c-b082-7edb35017daa",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 225,
                "PublicationIds": [
                    225
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": 48
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "https://dev-datasolutions.fastmarkets.com",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-datasolutions.fastmarkets.com/idm/in",
                "https://dev-datasolutions.fastmarkets.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "https://dev-datasolutions.fastmarkets.com/prices/exchange-news-and-prices/lme.html",
                "http://dev-datasolutions.fastmarkets.com/prices/exchange-news-and-prices/lme.html",
                "http://dev-datasolutions.fastmarkets.com/prices/exchange-news-and-prices.html",
                "https://dev-datasolutions.fastmarkets.com/prices/exchange-news-and-prices.html",
                "http://dev-datasolutions.fastmarkets.com",
                "http://dev-datasolutions.fastmarkets.com/logout.aspx",
                "https://dev-datasolutions.fastmarkets.com",
                "https://dev-datasolutions.fastmarkets.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-datasolutions.fastmarkets.com/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-datasolutions.fastmarkets.com/idm/in",
        "CompleteAuthCodeRedirectUri": "https://dev-datasolutions.fastmarkets.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "glf",
                "IdmProvider": "titan",
                "ClientName": "Global Leaders'' Forum",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "partial_npas",
                "Secret": "47B45B68-431B-45C8-80FB-A0B1E7B09E19"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionAndlegalrequired",
                "SiteUri": "http://www.internationaltelecomsweek.com",
                "ReplacementKeys": {
                    "Name of business": "Global Leaders'' Forum"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": false,
                "GoogleAnalyticsId": "",
                "TagManagerId": "",
                "WebsiteName": "",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                422
            ],
            "Products": [
                {
                    "ProductId": 1205106,
                    "NcuPublicationId": 422,
                    "Id": "060d9aea-7cdf-4d3b-80e9-0de780d0653f",
                    "Key": "Basic"
                }
            ],
            "DefaultFormId": "euromoney",
            "LegacyCmsSiteId": 161,
            "BrandFolder": "itw",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [
                    {
                        "ProductId": 1205106,
                        "NcuPublicationId": 422,
                        "Id": "060d9aea-7cdf-4d3b-80e9-0de780d0653f",
                        "Key": "Basic"
                    }
                ],
                "PublicationIds": [
                    422
                ],
                "PrimaryPublicationId": 422,
                "DefaultTrialDurationDays": 14
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "https://www.internationaltelecomsweek.com/about-itw/itw-global-leaders-forum",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "https://www.internationaltelecomsweek.com/about-itw/itw-global-leaders-forum",
                "https://www.internationaltelecomsweek.com/about-itw/itw-global-leaders-forum",
                "https://www.internationaltelecomsweek.com/about-itw/itw-global-leaders-forum",
                "https://www.internationaltelecomsweek.com/about-itw/itw-global-leaders-forum"
            ],
            "PostLogoutRedirectUris": [
                "https://www.internationaltelecomsweek.com/about-itw/itw-global-leaders-forum"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://www.internationaltelecomsweek.com/about-itw/itw-global-leaders-forum"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://www.internationaltelecomsweek.com/about-itw/itw-global-leaders-forum",
        "CompleteAuthCodeRedirectUri": "https://www.internationaltelecomsweek.com/about-itw/itw-global-leaders-forum/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "iflr",
                "IdmProvider": "titan",
                "ClientName": "International Financial Law Review",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "d10255f9-32b5-495e-b6a6-a364f51f28e7"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionAndlegalrequired",
                "SiteUri": "http://www.iflr.com",
                "ReplacementKeys": {
                    "Name of business": "International Financial Law Review"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-10709623-1",
                "TagManagerId": "GTM-WSX6LF",
                "WebsiteName": "International Financial Law Review",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                345
            ],
            "Products": [
                {
                    "ProductId": 1053886,
                    "NcuPublicationId": 345,
                    "Id": "fd58c425-16de-4bb0-a46a-7e162ff826ad",
                    "Key": "Trial"
                }
            ],
            "DefaultFormId": "iflr",
            "LegacyCmsSiteId": 793,
            "BrandFolder": "iflr",
            "EdenGroupMappings": {},
            "NewsletterIds": [
                615,
                606,
                607,
                608,
                609,
                614
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1002422,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "ProductId": 1053886,
                        "NcuPublicationId": 345,
                        "Id": "fd58c425-16de-4bb0-a46a-7e162ff826ad",
                        "Key": "Trial"
                    }
                ],
                "PublicationIds": [
                    345
                ],
                "PrimaryPublicationId": 345,
                "DefaultTrialDurationDays": 14
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-iflr.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-iflr.ci03.global.root/idm/in",
                "https://dev-iflr.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-iflr.ci03.global.root",
                "http://dev-iflr.ci03.global.root/logout.aspx",
                "https://dev-iflr.ci03.global.root",
                "https://dev-iflr.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "UA-10709623-1",
            "SecureEndpoint": ""
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "http://dev-iflr.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-iflr.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "institutionalinvestor_ca",
                "IdmProvider": "titan",
                "ClientName": "Institutional Investor",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "75fa72ba-b4ae-4430-92ce-f373eabdf80c"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.institutionalinvestor.com",
                "ReplacementKeys": {
                    "Name of business": "Institutional Investor"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "",
                "TagManagerId": "GTM-KPPSV7M",
                "WebsiteName": "Institutional Investor",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                320
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 7383,
                    "SourceCodeId": 9152,
                    "SubDefinitionId": 14997,
                    "OrderCodeId": 7035,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        320
                    ],
                    "Id": "5409c36e-ba8d-4809-b2f8-f5d1f24cc83b",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "institutionalinvestor",
            "LegacyCmsSiteId": 416,
            "BrandFolder": "institutionalinvestor",
            "EdenGroupMappings": {
                "cotype": 154,
                "jobf": 155,
                "iifundsize": 229,
                "iifreemagazine": 230,
                "iimonthlymagazine": 231,
                "iirrdemo": 232
            },
            "NewsletterIds": [
                792,
                785,
                794,
                793,
                791,
                788,
                798,
                790,
                789,
                553,
                545,
                552,
                548,
                797,
                676
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 7383,
                        "SourceCodeId": 9152,
                        "SubDefinitionId": 14997,
                        "OrderCodeId": 7035,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            320
                        ],
                        "Id": "5409c36e-ba8d-4809-b2f8-f5d1f24cc83b",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 320,
                "PublicationIds": [
                    320
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://institutionalinvestor-sitecore.ci02.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://institutionalinvestor-sitecore.ci02.global.root/idm/in",
                "https://institutionalinvestor-sitecore.ci02.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://institutionalinvestor-sitecore.ci02.global.root",
                "http://institutionalinvestor-sitecore.ci02.global.root/logout.aspx",
                "https://institutionalinvestor-sitecore.ci02.global.root",
                "https://institutionalinvestor-sitecore.ci02.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://institutionalinvestor-sitecore.ci02.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://institutionalinvestor-sitecore.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://institutionalinvestor-sitecore.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "institutionalinvestor_cd",
                "IdmProvider": "titan",
                "ClientName": "Institutional Investor",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "75fa72ba-b4ae-4430-92ce-f373eabdf80c"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.institutionalinvestor.com",
                "ReplacementKeys": {
                    "Name of business": "Institutional Investor"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "",
                "TagManagerId": "GTM-KPPSV7M",
                "WebsiteName": "Institutional Investor",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                320
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 7383,
                    "SourceCodeId": 9152,
                    "SubDefinitionId": 14997,
                    "OrderCodeId": 7035,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        320
                    ],
                    "Id": "5409c36e-ba8d-4809-b2f8-f5d1f24cc83b",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "institutionalinvestor",
            "LegacyCmsSiteId": 416,
            "BrandFolder": "institutionalinvestor",
            "EdenGroupMappings": {
                "cotype": 154,
                "jobf": 155,
                "iifundsize": 229,
                "iifreemagazine": 230,
                "iimonthlymagazine": 231,
                "iirrdemo": 232
            },
            "NewsletterIds": [
                792,
                785,
                794,
                793,
                791,
                788,
                798,
                790,
                789,
                553,
                545,
                552,
                548,
                797,
                676
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 7383,
                        "SourceCodeId": 9152,
                        "SubDefinitionId": 14997,
                        "OrderCodeId": 7035,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            320
                        ],
                        "Id": "5409c36e-ba8d-4809-b2f8-f5d1f24cc83b",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 320,
                "PublicationIds": [
                    320
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://institutionalinvestor.ci02.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://institutionalinvestor.ci02.global.root/idm/in",
                "https://institutionalinvestor.ci02.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://institutionalinvestor.ci02.global.root",
                "http://institutionalinvestor.ci02.global.root/logout.aspx",
                "https://institutionalinvestor.ci02.global.root",
                "https://institutionalinvestor.ci02.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://institutionalinvestor.ci02.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://institutionalinvestor.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://institutionalinvestor.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "internationaltaxreview_ca",
                "IdmProvider": "titan",
                "ClientName": "International Tax Review",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "64ee5d0d-ab0f-432c-98ea-b56ddba95ccf"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.internationaltaxreview.com",
                "ReplacementKeys": {
                    "Name of business": "International Tax Review"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7074768-1",
                "TagManagerId": "GTM-KKL6C4",
                "WebsiteName": "International Tax Review",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                5023
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 21581,
                    "SourceCodeId": 33634,
                    "SubDefinitionId": 64699,
                    "OrderCodeId": 20857,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        5023
                    ],
                    "Id": "ee83ed75-a1ae-449a-92a2-140404f4e2ae",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "internationaltaxreview",
            "LegacyCmsSiteId": 104,
            "BrandFolder": "itr_2019",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 21581,
                        "SourceCodeId": 33634,
                        "SubDefinitionId": 64699,
                        "OrderCodeId": 20857,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            5023
                        ],
                        "Id": "ee83ed75-a1ae-449a-92a2-140404f4e2ae",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 5023,
                "PublicationIds": [
                    5023
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://internationaltaxreview-sitecore.ci02.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://internationaltaxreview-sitecore.ci02.global.root/idm/in",
                "https://internationaltaxreview-sitecore.ci02.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://internationaltaxreview-sitecore.ci02.global.root",
                "http://internationaltaxreview-sitecore.ci02.global.root/logout.aspx",
                "https://internationaltaxreview-sitecore.ci02.global.root",
                "https://internationaltaxreview-sitecore.ci02.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://internationaltaxreview-sitecore.ci02.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://internationaltaxreview-sitecore.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://internationaltaxreview-sitecore.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "internationaltaxreview_cd",
                "IdmProvider": "titan",
                "ClientName": "International Tax Review",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "64ee5d0d-ab0f-432c-98ea-b56ddba95ccf"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.internationaltaxreview.com",
                "ReplacementKeys": {
                    "Name of business": "International Tax Review"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7074768-1",
                "TagManagerId": "GTM-KKL6C4",
                "WebsiteName": "International Tax Review",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                5023
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 21581,
                    "SourceCodeId": 33634,
                    "SubDefinitionId": 64699,
                    "OrderCodeId": 20857,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        5023
                    ],
                    "Id": "ee83ed75-a1ae-449a-92a2-140404f4e2ae",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "internationaltaxreview",
            "LegacyCmsSiteId": 104,
            "BrandFolder": "itr_2019",
            "EdenGroupMappings": {},
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 21581,
                        "SourceCodeId": 33634,
                        "SubDefinitionId": 64699,
                        "OrderCodeId": 20857,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            5023
                        ],
                        "Id": "ee83ed75-a1ae-449a-92a2-140404f4e2ae",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 5023,
                "PublicationIds": [
                    5023
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://internationaltaxreview.ci02.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://internationaltaxreview.ci02.global.root/idm/in",
                "https://internationaltaxreview.ci02.global.root/idm/in",
                "https://internationaltaxreview.ci02.global.root/successfullogin"
            ],
            "PostLogoutRedirectUris": [
                "http://internationaltaxreview.ci02.global.root",
                "http://internationaltaxreview.ci02.global.root/logout.aspx",
                "https://internationaltaxreview.ci02.global.root",
                "https://internationaltaxreview.ci02.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://internationaltaxreview.ci02.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://internationaltaxreview.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://internationaltaxreview.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "itr",
                "IdmProvider": "titan",
                "ClientName": "International Tax Review",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "55b7a57a-27ea-4aa1-b118-225095610971"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.internationaltaxreview.com",
                "ReplacementKeys": {
                    "Name of business": "International Tax Review"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7074768-1",
                "TagManagerId": "GTM-KKL6C4",
                "WebsiteName": "International Tax Review",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                310
            ],
            "Products": [
                {
                    "ProductId": 1058050,
                    "NcuPublicationId": 310,
                    "Id": "837ebd68-c93a-414d-8432-3d053ea6424a",
                    "Key": "Trial"
                }
            ],
            "DefaultFormId": "itr",
            "LegacyCmsSiteId": 104,
            "BrandFolder": "itr",
            "EdenGroupMappings": {
                "cotype": 54,
                "area": 55
            },
            "NewsletterIds": [
                861,
                862,
                863
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1002693,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "ProductId": 1058050,
                        "NcuPublicationId": 310,
                        "Id": "837ebd68-c93a-414d-8432-3d053ea6424a",
                        "Key": "Trial"
                    }
                ],
                "PublicationIds": [
                    310
                ],
                "PrimaryPublicationId": 310,
                "DefaultTrialDurationDays": 7
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-internationaltaxreview.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-internationaltaxreview.ci03.global.root/idm/in",
                "https://dev-internationaltaxreview.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-internationaltaxreview.ci03.global.root",
                "http://dev-internationaltaxreview.ci03.global.root/logout.aspx",
                "https://dev-internationaltaxreview.ci03.global.root",
                "https://dev-internationaltaxreview.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": null
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "http://dev-internationaltaxreview.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-internationaltaxreview.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "managingip",
                "IdmProvider": "titan",
                "ClientName": "Managing Intellectual Property",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "e575b6e5-27f4-4c50-b2be-ddcf5346e6e0"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.managingip.com",
                "ReplacementKeys": {
                    "Name of business": "Managing Intellectual Property"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
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
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                292,
                292
            ],
            "Products": [
                {
                    "ProductId": 1053887,
                    "NcuPublicationId": 292,
                    "Id": "7a01c2b4-917a-4606-8829-89cd50246719",
                    "Key": "Base"
                },
                {
                    "ProductId": 1058837,
                    "NcuPublicationId": 292,
                    "Id": "a20cfcaf-6202-4f11-a702-98e08ade4566",
                    "Key": "Asia"
                }
            ],
            "DefaultFormId": "managingip",
            "LegacyCmsSiteId": 432,
            "BrandFolder": "managingip",
            "EdenGroupMappings": {
                "cotype": 58,
                "practicearea": 56,
                "specialization": 57
            },
            "NewsletterIds": [
                776,
                777,
                778,
                779
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1002635,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [
                    {
                        "ProductId": 1053887,
                        "NcuPublicationId": 292,
                        "Id": "7a01c2b4-917a-4606-8829-89cd50246719",
                        "Key": "Base"
                    },
                    {
                        "ProductId": 1058837,
                        "NcuPublicationId": 292,
                        "Id": "a20cfcaf-6202-4f11-a702-98e08ade4566",
                        "Key": "Asia"
                    }
                ],
                "PublicationIds": [
                    292,
                    292
                ],
                "PrimaryPublicationId": 292,
                "DefaultTrialDurationDays": 183
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-managingip.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-managingip.ci03.global.root/idm/in",
                "https://dev-managingip.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-managingip.ci03.global.root",
                "http://dev-managingip.ci03.global.root/logout.aspx",
                "https://dev-managingip.ci03.global.root",
                "https://dev-managingip.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": null
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "http://dev-managingip.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-managingip.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "managingip_ca",
                "IdmProvider": "titan",
                "ClientName": "Managing Intellectual Property",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "e575b6e5-27f4-4c50-b2be-ddcf5346e6e0"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.managingip.com",
                "ReplacementKeys": {
                    "Name of business": "Managing Intellectual Property"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
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
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                292,
                292
            ],
            "Products": [
                {
                    "ProductId": 1053887,
                    "NcuPublicationId": 292,
                    "Id": "7a01c2b4-917a-4606-8829-89cd50246719",
                    "Key": "Base"
                },
                {
                    "ProductId": 1058837,
                    "NcuPublicationId": 292,
                    "Id": "a20cfcaf-6202-4f11-a702-98e08ade4566",
                    "Key": "Asia"
                }
            ],
            "DefaultFormId": "managingip",
            "LegacyCmsSiteId": 432,
            "BrandFolder": "managingip",
            "EdenGroupMappings": {
                "cotype": 58,
                "practicearea": 56,
                "specialization": 57
            },
            "NewsletterIds": [
                776,
                777,
                778,
                779
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1002635,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [
                    {
                        "ProductId": 1053887,
                        "NcuPublicationId": 292,
                        "Id": "7a01c2b4-917a-4606-8829-89cd50246719",
                        "Key": "Base"
                    },
                    {
                        "ProductId": 1058837,
                        "NcuPublicationId": 292,
                        "Id": "a20cfcaf-6202-4f11-a702-98e08ade4566",
                        "Key": "Asia"
                    }
                ],
                "PublicationIds": [
                    292,
                    292
                ],
                "PrimaryPublicationId": 292,
                "DefaultTrialDurationDays": 183
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
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
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": null
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "http://events-managingip-sitecore.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://events-managingip-sitecore.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "managingip_cd",
                "IdmProvider": "titan",
                "ClientName": "Managing Intellectual Property",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "e575b6e5-27f4-4c50-b2be-ddcf5346e6e0"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.managingip.com",
                "ReplacementKeys": {
                    "Name of business": "Managing Intellectual Property"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
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
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                292,
                292
            ],
            "Products": [
                {
                    "ProductId": 1053887,
                    "NcuPublicationId": 292,
                    "Id": "7a01c2b4-917a-4606-8829-89cd50246719",
                    "Key": "Base"
                },
                {
                    "ProductId": 1058837,
                    "NcuPublicationId": 292,
                    "Id": "a20cfcaf-6202-4f11-a702-98e08ade4566",
                    "Key": "Asia"
                }
            ],
            "DefaultFormId": "managingip",
            "LegacyCmsSiteId": 432,
            "BrandFolder": "managingip",
            "EdenGroupMappings": {
                "cotype": 58,
                "practicearea": 56,
                "specialization": 57
            },
            "NewsletterIds": [
                776,
                777,
                778,
                779
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1002635,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [
                    {
                        "ProductId": 1053887,
                        "NcuPublicationId": 292,
                        "Id": "7a01c2b4-917a-4606-8829-89cd50246719",
                        "Key": "Base"
                    },
                    {
                        "ProductId": 1058837,
                        "NcuPublicationId": 292,
                        "Id": "a20cfcaf-6202-4f11-a702-98e08ade4566",
                        "Key": "Asia"
                    }
                ],
                "PublicationIds": [
                    292,
                    292
                ],
                "PrimaryPublicationId": 292,
                "DefaultTrialDurationDays": 183
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
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
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": null
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "http://events.managingip.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://events.managingip.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "mb",
                "IdmProvider": "titan",
                "ClientName": "Metal Bulletin",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "aecc2162-ae93-4285-931a-6435dc20378a"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.metalbulletin.com",
                "ReplacementKeys": {
                    "Name of business": "MetalBulletin"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-113890-16",
                "TagManagerId": "GTM-K22LFG",
                "WebsiteName": "Metal Bulletin",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                225
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 8420,
                    "SourceCodeId": 10282,
                    "SubDefinitionId": 17338,
                    "OrderCodeId": 8064,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        225
                    ],
                    "Id": "8e3569bb-090e-461c-b082-7edb35017daa",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "mb",
            "LegacyCmsSiteId": 846,
            "BrandFolder": "fm-mb",
            "EdenGroupMappings": {
                "jobf": 289,
                "cotype": 287,
                "areamulti": 288
            },
            "NewsletterIds": [
                147,
                511,
                512,
                758,
                804,
                896
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 8420,
                        "SourceCodeId": 10282,
                        "SubDefinitionId": 17338,
                        "OrderCodeId": 8064,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            225
                        ],
                        "Id": "8e3569bb-090e-461c-b082-7edb35017daa",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 225,
                "PublicationIds": [
                    225
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": true,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-metalbulletin.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-metalbulletin.ci03.global.root/idm/in",
                "https://dev-metalbulletin.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-metalbulletin.ci03.global.root",
                "http://dev-metalbulletin.ci03.global.root/logout.aspx",
                "https://dev-metalbulletin.ci03.global.root",
                "https://dev-metalbulletin.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-metalbulletin.ci03.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-metalbulletin.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-metalbulletin.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "mb_local",
                "IdmProvider": "titan",
                "ClientName": "Metal Bulletin",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "aecc2162-ae93-4285-931a-6435dc20378a"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.metalbulletin.com",
                "ReplacementKeys": {
                    "Name of business": "MetalBulletin"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-113890-16",
                "TagManagerId": "GTM-K22LFG",
                "WebsiteName": "Metal Bulletin",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                225
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 8420,
                    "SourceCodeId": 10282,
                    "SubDefinitionId": 17338,
                    "OrderCodeId": 8064,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        225
                    ],
                    "Id": "8e3569bb-090e-461c-b082-7edb35017daa",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "mb",
            "LegacyCmsSiteId": 846,
            "BrandFolder": "fm-mb",
            "EdenGroupMappings": {
                "jobf": 289,
                "cotype": 287,
                "areamulti": 288
            },
            "NewsletterIds": [
                147,
                511,
                512,
                758,
                804,
                896
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 8420,
                        "SourceCodeId": 10282,
                        "SubDefinitionId": 17338,
                        "OrderCodeId": 8064,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            225
                        ],
                        "Id": "8e3569bb-090e-461c-b082-7edb35017daa",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 225,
                "PublicationIds": [
                    225
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": true,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://local.metalbulletin.com",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://local.metalbulletin.com/idm/in",
                "https://local.metalbulletin.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://local.metalbulletin.com",
                "http://local.metalbulletin.com/logout.aspx",
                "https://local.metalbulletin.com",
                "https://local.metalbulletin.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://local.metalbulletin.com/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://local.metalbulletin.com/idm/in",
        "CompleteAuthCodeRedirectUri": "http://local.metalbulletin.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "mbdatasolutions",
                "IdmProvider": "titan",
                "ClientName": "Fastmarkets Data Solutions",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "193a2865-61b3-4604-8b6c-3a3aedb83b1a"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.metalbulletin.com",
                "ReplacementKeys": {
                    "Name of business": "MetalBulletin"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-113890-16",
                "TagManagerId": "GTM-K22LFG",
                "WebsiteName": "Metal Bulletin",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": true,
            "PublicationIds": [
                225
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 8420,
                    "SourceCodeId": 10282,
                    "SubDefinitionId": 17338,
                    "OrderCodeId": 8064,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        225
                    ],
                    "Id": "8e3569bb-090e-461c-b082-7edb35017daa",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "mb",
            "LegacyCmsSiteId": 863,
            "BrandFolder": "fm-datasolutions",
            "EdenGroupMappings": {
                "jobf": 289,
                "cotype": 287,
                "area": 288
            },
            "NewsletterIds": [
                147,
                511,
                512,
                758,
                804,
                896
            ],
            "AccessTokenLifetime": 7201,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 8420,
                        "SourceCodeId": 10282,
                        "SubDefinitionId": 17338,
                        "OrderCodeId": 8064,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            225
                        ],
                        "Id": "8e3569bb-090e-461c-b082-7edb35017daa",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 225,
                "PublicationIds": [
                    225
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": 48
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "https://dev-datasolutions.metalbulletin.com",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-datasolutions.metalbulletin.com/idm/in",
                "https://dev-datasolutions.metalbulletin.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "https://dev-datasolutions.metalbulletin.com/prices/exchange-news-and-prices/lme.html",
                "http://dev-datasolutions.metalbulletin.com/prices/exchange-news-and-prices/lme.html",
                "http://dev-datasolutions.metalbulletin.com/prices/exchange-news-and-prices.html",
                "https://dev-datasolutions.metalbulletin.com/prices/exchange-news-and-prices.html",
                "http://dev-datasolutions.metalbulletin.com",
                "http://dev-datasolutions.metalbulletin.com/logout.aspx",
                "https://dev-datasolutions.metalbulletin.com",
                "https://dev-datasolutions.metalbulletin.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-datasolutions.metalbulletin.com/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-datasolutions.metalbulletin.com/idm/in",
        "CompleteAuthCodeRedirectUri": "https://dev-datasolutions.metalbulletin.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "mipeventsmidas_ca",
                "IdmProvider": "titan",
                "ClientName": "Managing Intellectual Property - Midas",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "1ca39218-506e-41d7-84f1-50ec67010bb7"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.managingip.com",
                "ReplacementKeys": {
                    "Name of business": "Managing Intellectual Property - Midas"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
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
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                5027
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 21602,
                    "SourceCodeId": 33655,
                    "SubDefinitionId": 64749,
                    "OrderCodeId": 20877,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        5027
                    ],
                    "Id": "9d1d65a2-3cfe-4223-bfc2-c008e4578416",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "mipeventsmidas",
            "LegacyCmsSiteId": 432,
            "BrandFolder": "mipeventsmidas",
            "EdenGroupMappings": {
                "jobf": 313,
                "cotype": 314,
                "area": 315
            },
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 180
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 21602,
                        "SourceCodeId": 33655,
                        "SubDefinitionId": 64749,
                        "OrderCodeId": 20877,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            5027
                        ],
                        "Id": "9d1d65a2-3cfe-4223-bfc2-c008e4578416",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 5027,
                "PublicationIds": [
                    5027
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
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
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": null
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "http://events-managingip-sitecore.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://events-managingip-sitecore.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "mipeventsmidas_cd",
                "IdmProvider": "titan",
                "ClientName": "Managing Intellectual Property - Midas",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "1ca39218-506e-41d7-84f1-50ec67010bb7"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.managingip.com",
                "ReplacementKeys": {
                    "Name of business": "Managing Intellectual Property - Midas"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
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
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                5027
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 21602,
                    "SourceCodeId": 33655,
                    "SubDefinitionId": 64749,
                    "OrderCodeId": 20877,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        5027
                    ],
                    "Id": "9d1d65a2-3cfe-4223-bfc2-c008e4578416",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "mipeventsmidas",
            "LegacyCmsSiteId": 432,
            "BrandFolder": "mipeventsmidas",
            "EdenGroupMappings": {
                "jobf": 313,
                "cotype": 314,
                "area": 315
            },
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 180
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 21602,
                        "SourceCodeId": 33655,
                        "SubDefinitionId": 64749,
                        "OrderCodeId": 20877,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            5027
                        ],
                        "Id": "9d1d65a2-3cfe-4223-bfc2-c008e4578416",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 5027,
                "PublicationIds": [
                    5027
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
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
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": null
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "http://events.managingip.ci02.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://events.managingip.ci02.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "mipeventsmidas_localmidas",
                "IdmProvider": "titan",
                "ClientName": "Managing Intellectual Property - Midas",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "1ca39218-506e-41d7-84f1-50ec67010bb7"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.managingip.com",
                "ReplacementKeys": {
                    "Name of business": "Managing Intellectual Property - Midas"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
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
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                5027
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 21602,
                    "SourceCodeId": 33655,
                    "SubDefinitionId": 64749,
                    "OrderCodeId": 20877,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        5027
                    ],
                    "Id": "9d1d65a2-3cfe-4223-bfc2-c008e4578416",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "mipeventsmidas",
            "LegacyCmsSiteId": 432,
            "BrandFolder": "mipeventsmidas",
            "EdenGroupMappings": {
                "jobf": 313,
                "cotype": 314,
                "area": 315
            },
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 180
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 21602,
                        "SourceCodeId": 33655,
                        "SubDefinitionId": 64749,
                        "OrderCodeId": 20877,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            5027
                        ],
                        "Id": "9d1d65a2-3cfe-4223-bfc2-c008e4578416",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": true,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 5027,
                "PublicationIds": [
                    5027
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://local-midas.events.managingip.com",
            "IdmUrl": "https://local-identitymanagement.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://local-midas.events.managingip.com/idm/in",
                "https://local-midas.events.managingip.com/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://local-midas.events.managingip.com",
                "http://local-midas.events.managingip.com/logout.aspx",
                "https://local-midas.events.managingip.com",
                "https://local-midas.events.managingip.com/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": null
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "http://local-midas.events.managingip.com/idm/in",
        "CompleteAuthCodeRedirectUri": "http://local-midas.events.managingip.com/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "powerfinance",
                "IdmProvider": "titan",
                "ClientName": "Power Finance & Risk",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "f6693848-82ed-4007-9111-01421e2bfc61"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.powerfinancerisk.com",
                "ReplacementKeys": {
                    "Name of business": "Power Finance Risk"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "",
                "TagManagerId": "GTM-KXL7KL",
                "WebsiteName": "Power Finance Risk",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                114
            ],
            "Products": [
                {
                    "ProductId": 1060864,
                    "NcuPublicationId": 114,
                    "Id": "27db9524-b241-482e-895e-df4bc829b890",
                    "Key": "Basic"
                }
            ],
            "DefaultFormId": "powerfinance",
            "LegacyCmsSiteId": 420,
            "BrandFolder": "powerfinance",
            "EdenGroupMappings": {},
            "NewsletterIds": [
                2811,
                2812,
                2876
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1003338,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "ProductId": 1060864,
                        "NcuPublicationId": 114,
                        "Id": "27db9524-b241-482e-895e-df4bc829b890",
                        "Key": "Basic"
                    }
                ],
                "PublicationIds": [
                    114
                ],
                "PrimaryPublicationId": 114,
                "DefaultTrialDurationDays": 14
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://powerfinancerisk.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://powerfinancerisk.ci03.global.root/idm/in",
                "https://powerfinancerisk.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://powerfinancerisk.ci03.global.root",
                "http://powerfinancerisk.ci03.global.root/logout.aspx",
                "https://powerfinancerisk.ci03.global.root",
                "https://powerfinancerisk.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://powerfinancerisk.ci03.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://powerfinancerisk.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://powerfinancerisk.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "sandbox-ncu",
                "IdmProvider": "titan",
                "ClientName": "IDM Integration (NCU)",
                "AdapterTypeName": "Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU",
                "ClientType": "ncu",
                "Secret": "0f4d2e5c-8563-4257-b6bf-8f3d4338cfcf"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://titanclient-ncu.ci03.global.root",
                "ReplacementKeys": {
                    "Name of business": "Titan Sandbox - NCU Adapter"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "UA-7039898-10",
                "TagManagerId": "GTM-WQ23MH",
                "WebsiteName": "Titan Sandbox - NCU Adapter",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": true,
            "AllowExternalLogins": false,
            "PublicationIds": [
                502
            ],
            "Products": [
                {
                    "NcuPreVerifiedStatus": 2,
                    "ProductCatalogId": 20263,
                    "SourceCodeId": 30574,
                    "SubDefinitionId": 58871,
                    "OrderCodeId": 19564,
                    "CurrencyId": 1,
                    "PublicationIds": [
                        502
                    ],
                    "Id": "ed75561a-b35d-4846-88e3-6287228bc9bc",
                    "Key": "trial"
                }
            ],
            "DefaultFormId": "1",
            "LegacyCmsSiteId": 852,
            "BrandFolder": "",
            "EdenGroupMappings": {
                "jobf": 250,
                "cotype": 251,
                "area": 254,
                "presp": 253,
                "sresp": 263,
                "dep": 255,
                "div": 257,
                "areamulti": 254
            },
            "NewsletterIds": [],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "NcuPreVerifiedStatus": 2,
                        "ProductCatalogId": 20263,
                        "SourceCodeId": 30574,
                        "SubDefinitionId": 58871,
                        "OrderCodeId": 19564,
                        "CurrencyId": 1,
                        "PublicationIds": [
                            502
                        ],
                        "Id": "ed75561a-b35d-4846-88e3-6287228bc9bc",
                        "Key": "trial"
                    }
                ],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 502,
                "PublicationIds": [
                    502
                ]
            },
            "Npas": {
                "NpasSiteId": 0,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "PublicationIds": [],
                "PrimaryPublicationId": 0,
                "DefaultTrialDurationDays": 0
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-spectrum.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-spectrum.ci03.global.root/idm/in",
                "https://dev-spectrum.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-spectrum.ci03.global.root",
                "http://dev-spectrum.ci03.global.root/logout.aspx",
                "https://dev-spectrum.ci03.global.root",
                "https://dev-spectrum.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-spectrum.ci03.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-spectrum.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-spectrum.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "swc",
                "IdmProvider": "titan",
                "ClientName": "Sovereign Wealth Center",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "3c1bee2c-cd7a-4558-8f82-b384c7dabca8"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.sovereignwealthcenter.com",
                "ReplacementKeys": {
                    "Name of business": "Sovereign Wealth Center"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "",
                "TagManagerId": "GTM-5VG8F3",
                "WebsiteName": "Sovereign Wealth Center",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                388
            ],
            "Products": [
                {
                    "ProductId": 1034022,
                    "NcuPublicationId": 388,
                    "Id": "35d09a85-4c6c-4179-9e6a-e22fdda0b57b",
                    "Key": "Premium"
                }
            ],
            "DefaultFormId": "swc",
            "LegacyCmsSiteId": 825,
            "BrandFolder": "swc",
            "EdenGroupMappings": {
                "cotype": 218,
                "jobf": 219
            },
            "NewsletterIds": [
                770,
                900
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1002771,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [
                    {
                        "ProductId": 1034022,
                        "NcuPublicationId": 388,
                        "Id": "35d09a85-4c6c-4179-9e6a-e22fdda0b57b",
                        "Key": "Premium"
                    }
                ],
                "PublicationIds": [
                    388
                ],
                "PrimaryPublicationId": 388,
                "DefaultTrialDurationDays": 14
            },
            "EnableRememberMe": true,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-sovereignwealthcenter.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-sovereignwealthcenter.ci03.global.root/idm/in",
                "https://dev-sovereignwealthcenter.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-sovereignwealthcenter.ci03.global.root",
                "http://dev-sovereignwealthcenter.ci03.global.root/logout.aspx",
                "https://dev-sovereignwealthcenter.ci03.global.root",
                "https://dev-sovereignwealthcenter.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-sovereignwealthcenter.ci03.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-sovereignwealthcenter.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-sovereignwealthcenter.ci03.global.root/idm/in-auth-code"
    },
    {
        "ClientSettings": {
            "ClientMeta": {
                "ClientId": "tpweek",
                "IdmProvider": "titan",
                "ClientName": "Transfer Pricing Week",
                "AdapterTypeName": "Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas",
                "ClientType": "npas",
                "Secret": "efcd2613-60c0-4656-b73b-46cb2ee2540e"
            },
            "LegalCompliance": {
                "Reference": "dataprotectionandlegalrequiredtitan",
                "SiteUri": "http://www.tpweek.com",
                "ReplacementKeys": {
                    "Name of business": "Transfer Pricing Week"
                },
                "PreSelectCheckboxes": false,
                "PreSelectSpecificCheckboxIds": []
            },
            "GoogleAnalytics": {
                "Enabled": true,
                "GoogleAnalyticsId": "",
                "TagManagerId": "GTM-5QJ85K",
                "WebsiteName": "Transfer Pricing Week",
                "TrackingEmails": {
                    "Medium": "Email operational",
                    "Source": "Registration Form",
                    "Campaign": "Email verification",
                    "ContentDateFormat": "yyyy-MM-dd",
                    "Term": "Verification link"
                }
            },
            "AreActiveAndLapsedSubscribersBlocked": false,
            "DisallowLoginWithExpiredAccount": false,
            "AllowExternalLogins": false,
            "PublicationIds": [
                242
            ],
            "Products": [
                {
                    "ProductId": 1032689,
                    "NcuPublicationId": 242,
                    "Id": "fd58c425-16dd-4bb0-a46a-7e162ff826ad",
                    "Key": "Trial"
                }
            ],
            "DefaultFormId": "tpweek",
            "LegacyCmsSiteId": 79,
            "BrandFolder": "tpweek",
            "EdenGroupMappings": {
                "cotype": 54,
                "accesstype": 55
            },
            "NewsletterIds": [
                1,
                2
            ],
            "AccessTokenLifetime": 7200,
            "Ncu": {
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "0001-01-01T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 0
                },
                "Products": [],
                "RetrieveClaims": false,
                "TrackOnLogOn": false,
                "PrimaryPublicationId": 0,
                "PublicationIds": []
            },
            "Npas": {
                "NpasSiteId": 1001647,
                "Trialists": {
                    "LapsedTrialistsAmenstyDate": "2000-01-31T00:00:00",
                    "LapsedTrialistsEmbargoLengthInMonths": 6
                },
                "Products": [
                    {
                        "ProductId": 1032689,
                        "NcuPublicationId": 242,
                        "Id": "fd58c425-16dd-4bb0-a46a-7e162ff826ad",
                        "Key": "Trial"
                    }
                ],
                "PublicationIds": [
                    242
                ],
                "PrimaryPublicationId": 242,
                "DefaultTrialDurationDays": 14
            },
            "EnableRememberMe": false,
            "RememberMeDefaultValue": false,
            "RememberMeDurationInDays": null,
            "ResetPasswordExpirationHours": null
        },
        "ClientEnvironmentSettings": {
            "ClientSiteUrl": "http://dev-assets-tpweek.ci03.global.root",
            "IdmUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root",
            "PostLoginRedirectUris": [
                "http://dev-assets-tpweek.ci03.global.root/idm/in",
                "https://dev-assets-tpweek.ci03.global.root/idm/in"
            ],
            "PostLogoutRedirectUris": [
                "http://dev-assets-tpweek.ci03.global.root",
                "http://dev-assets-tpweek.ci03.global.root/logout.aspx",
                "https://dev-assets-tpweek.ci03.global.root",
                "https://dev-assets-tpweek.ci03.global.root/logout.aspx"
            ],
            "GoogleAnalyticsId": "",
            "SecureEndpoint": "https://dev-assets-tpweek.ci03.global.root/idm/in"
        },
        "ServerSettings": {
            "IdmUrls": {
                "ImplicitClientRedirectUri": "/idm/in",
                "AuthCodeRedirectUri": "/idm/in-auth-code"
            },
            "InternalUrl": "https://titan-api-dev.euromoney.ci03.global.root",
            "ExternalUrl": "https://dev-identitymanagement.euromoneydigital.ci03.global.root"
        },
        "CompleteImplicitClientRedirectUri": "https://dev-assets-tpweek.ci03.global.root/idm/in",
        "CompleteAuthCodeRedirectUri": "http://dev-assets-tpweek.ci03.global.root/idm/in-auth-code"
    }
]';

-- NCU
select distinct pid
from openjson(@json)  
  with (
    clientId nvarchar(128) '$.ClientSettings.ClientMeta.ClientId',
	adapter nvarchar(128) '$.ClientSettings.ClientMeta.AdapterTypeName',
	url nvarchar(1024) '$.ClientEnvironmentSettings.ClientSiteUrl',
	pids nvarchar(max) '$.ClientSettings.PublicationIds' as json
  )
outer apply openjson(pids)
  with (pid int '$')
--where adapter = 'Euromoney.IdentityManagement.NCU.NcuIdmAdapter, Euromoney.IdentityManagement.NCU'
--and pid is not null


-- NPAS
/*
select distinct pid
from openjson(@json)  
  with (
    clientId nvarchar(128) '$.ClientSettings.ClientMeta.ClientId',
	adapter nvarchar(128) '$.ClientSettings.ClientMeta.AdapterTypeName',
	pids nvarchar(max) '$.ClientSettings.PublicationIds' as json
  )
outer apply openjson(pids)
  with (pid int '$')
where adapter = 'Euromoney.IdentityManagement.NPas.NpasIdmAdapter, Euromoney.IdentityManagement.NPas'
--and pid is not null
*/











