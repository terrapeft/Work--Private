/*
use newcentralusers

select distinct pCMSSiteID
from Publications
where 
	(purl like '%iflr.com%'
	 or purl like '%internationaltaxreview.com%'
	 or purl like '%managingip.com%')
and pCMSSiteID is not null
*/

/*
-- Results: 
48,
97,
104,
171,
416,
432,
793

*/

use CMS

/*
select pubPublicationID, pubPrimarySiteID, pubName
from publications p
join sitepublications sp on p.pubPublicationId = sp.spPublicationID
where sp.spSiteID in (
--where p.pubPrimarySiteID in (
	48,
	97,
	104,
	171,
	416,
	432,
	793
)

except

--> use this one
select pubPublicationID, pubPrimarySiteID, pubName
from publications p
--join sitepublications sp on p.pubPublicationId = sp.spPublicationID
--where sp.spSiteID in (
where p.pubPrimarySiteID in (
	48,
	97,
	104,
	171,
	416,
	432,
	793
)
*/

select pubPublicationID, pubPrimarySiteID, pubName
from publications p
where p.pubPrimarySiteID in (
	48,
	97,
	104,
	171,
	416,
	432,
	793
)

go

use newcentralusers

SELECT TOP (1000) [nepRecNum]
      ,[nepUserID]
      ,[nepUserName]
      ,[nepPubCMSId]
      ,[nepEmail]
      ,[nepEmailFormat]
      ,[nepEmailRegion]
      ,[nepSelectCategories]
      ,[nepSelectEmails]
      ,[nepUpdateDate]
      ,[nepIsActive]
  FROM [NewCentralUsers].[dbo].[NewsletterEmailPreferences]
where neppubcmsid in (
	select pubPublicationID
	from cms.dbo.publications p
	where p.pubPrimarySiteID in (
		48,
		97,
		104,
		171,
		416,
		432,
		793
	)
)


SELECT distinct nepPubCMSId
  FROM [NewCentralUsers].[dbo].[NewsletterEmailPreferences]