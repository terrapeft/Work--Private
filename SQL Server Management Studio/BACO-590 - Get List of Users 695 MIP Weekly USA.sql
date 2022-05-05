/**
* ManagingIP - Free Content Email Weekly USA
**/

drop table if exists #NBORecords
drop table if exists #NBOUsers
drop table if exists #NCUUsers
drop table if exists #List


SELECT * INTO #NBORecords
FROM BackOffice.DBO.vwNewsletterPublicationSubscribedUsersNonBreakingNews
WHERE NewsletterAlertCategoryId = 776

SELECT DISTINCT
ne.EmailAddress AS [EmailAddress],
'' AS [ContactCode], 
ne.Fullname AS Fullname,
'' AS [JobTitle],
'' AS [Company],
'' AS [Address1],
'' AS [Address2],
'' AS [Address3],
'' AS [Address4],
ne.Title AS [Salutation],
ne.PostCode AS [PostCode],   
'' AS [Country],
'' AS [Ins1],
ne.UserName AS [Ins2],
ne.DecryptedPassword AS [Ins3],
'' AS [Ins4],
ne.UserId AS [Ins5]
INTO #NBOUsers FROM #NBORecords v WITH (NOLOCK)
left join BackOffice.Customer.vGetUsersForNewsletterEmailing ne WITH (NOLOCK) ON v.[Ins3] = ne.UserId
WHERE ne.SubscriptionType IS NOT NULL
AND
(
	(ne.UnderAKeyAccount = 0) 
	OR
	(ne.UnderAKeyAccount = 1 AND KeyAccountIsActive = 1 AND SubscriptionUserExcluded = 0)
)
and v.NewsletterAlertCategoryId in 
(
	select [ID] 
	from BackOffice.dbo.ProductNewsletterAlertCategories WITH (NOLOCK)
	where 
	NewsletterAlertID = 394 and Id = 776
)

SELECT DISTINCT
LEFT(ud.uEmailAddress, 150) AS EmailAddress,
'' AS ContactCode,
LEFT(coalesce (ud.uForenames + ' ' + ud.uSurname,'Colleague'),150) AS [FullName],
'' AS [JobTitle],
'' AS [Company],
'' AS [Address1],
'' AS [Address2],
'' AS [Address3],
'' AS [Address4],
LEFT(coalesce (ud.uTitle, ''), 50) AS [Salutation],
'' AS [PostCode],
'' AS [Country],
'' AS [Ins1],
LEFT(ud.uUsername, 150) AS Ins2,
LEFT(ud.uPassword, 150) AS Ins3,
LEFT(REPLACE (REPLACE (ud.GUID,'}',''),'{',''), 150) AS Ins4,
LEFT(ud.uID, 150) AS Ins5
INTO #NCUUsers
FROM NewCentralUsers.dbo.UserDetails ud
INNER JOIN NewCentralUsers.dbo.Newsletters nl ON ud.UID = nl.nUID
WHERE
uemailAddress COLLATE DATABASE_DEFAULT NOT IN (SELECT EmailAddress from #NBOUsers)
AND
nNewsletterID = 695
AND NOT EXISTS (SELECT DISTINCT nud.uEmailAddress
								FROM NewCentralUsers.dbo.UserDetails nud WITH (NOLOCK)
								INNER JOIN NewCentralUsers.dbo.Newsletters nl WITH (NOLOCK) ON nud.uID  = nl.nuid
								INNER JOIN NewCentralUsers.dbo.Subscriptions su WITH (NOLOCK) ON nud.uID = su.sUID
								WHERE
									(
										sPID IN (292, 295, 296, 293, 294 )
										AND
										nNewsletterID = 750
										AND
										(DATEADD(WEEK, 2, sExpiryDate) >= GETDATE() OR DATEADD(WEEK, 2, sTrialExpiryDate) >= GETDATE())			
									)
									AND 
									ud.uEmailAddress = nud.uEmailAddress
								)

SELECT DISTINCT 
li.EmailAddress COLLATE DATABASE_DEFAULT AS [EmailAddress],
[ContactCode] COLLATE DATABASE_DEFAULT AS [ContactCode],
Fullname COLLATE DATABASE_DEFAULT AS [Fullname],
[JobTitle] COLLATE DATABASE_DEFAULT AS [JobTitle],
[Company] COLLATE DATABASE_DEFAULT AS [Company],
[Address1] COLLATE DATABASE_DEFAULT AS [Address1],
[Address2] COLLATE DATABASE_DEFAULT AS [Address2],
[Address3] COLLATE DATABASE_DEFAULT AS [Address3],
[Address4] COLLATE DATABASE_DEFAULT AS [Address4],
[Salutation] COLLATE DATABASE_DEFAULT AS [Salutation],
[PostCode] COLLATE DATABASE_DEFAULT AS [PostCode],
[Country] COLLATE DATABASE_DEFAULT AS [Country],
[Ins1] COLLATE DATABASE_DEFAULT AS [Ins1],
[Ins2] COLLATE DATABASE_DEFAULT AS [Ins2],
[Ins3] COLLATE DATABASE_DEFAULT AS [Ins3],
[Ins4] COLLATE DATABASE_DEFAULT AS [Ins4],
[Ins5] COLLATE DATABASE_DEFAULT AS [Ins5]
INTO #List FROM [EUR05637-SQL1].[PubWiz].[DBO].[tbListItems] li
WHERE ListID = 147
 AND li.EmailAddress not in (SELECT EmailAddress COLLATE DATABASE_DEFAULT FROM #NCUUsers)
 AND li.EmailAddress not in (SELECT EmailAddress COLLATE DATABASE_DEFAULT FROM #NBOUsers)

select
EmailAddress COLLATE DATABASE_DEFAULT
FROM #NCUUsers
UNION
SELECT
[EmailAddress]
FROM #NBOUsers
UNION
SELECT
[EmailAddress]
FROM #List