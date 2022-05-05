/**
* ManagingIP - Free Content Email Weekly
**/

use backoffice

drop table if exists #NBORecords
drop table if exists #NBOUsers
drop table if exists #NCUUsers

SELECT *
INTO #NBORecords
FROM BackOffice.DBO.vwNewsletterPublicationSubscribedUsersNonBreakingNews
WHERE NewsletterAlertCategoryId = 777

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
INTO #NBOUsers
FROM
#NBORecords v WITH (NOLOCK)
left join BackOffice.Customer.vGetUsersForNewsletterEmailing ne WITH (NOLOCK) ON v.[Ins3] = ne.UserId
WHERE
ne.SubscriptionType IS NOT NULL
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
	NewsletterAlertID = 394 and Id = 777
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
INNER JOIN NewCentralUsers.dbo.Newsletters nl ON ud.UID = NL.NUID
INNER JOIN NewCentralUsers.dbo.Subscriptions su ON ud.uID = su.sUID
WHERE
uemailAddress COLLATE DATABASE_DEFAULT NOT IN (SELECT EmailAddress from #NBOUsers)
AND
uEmailAddress COLLATE DATABASE_DEFAULT NOT IN (
	SELECT EmailAddress COLLATE DATABASE_DEFAULT FROM [EUR05637-SQL1].[PubWiz].[DBO].[tbListItems] WHERE ListID = 135
)
AND
	(
		nNewsletterID IN (411, 622)
		OR
		(
			sPID IN (294, 297, 293, 295, 296)
			AND
			nNewsletterID IN (514, 516, 518, 519, 522)
		)
	)
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

SELECT EmailAddress COLLATE DATABASE_DEFAULT
FROM #NCUUsers
UNION
SELECT [EmailAddress]
FROM #NBOUsers






