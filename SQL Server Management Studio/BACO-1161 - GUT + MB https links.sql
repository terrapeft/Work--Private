/*
SELECT 	p.*--sp.*, s.*
FROM [CMS].[dbo].[Articles] a
join [CMS].[dbo].Issues i on a.artissueId = i.issIssueID
join [CMS].[dbo].SitePublications sp on i.issPublicationID = sp.spPublicationID
join [CMS].[dbo].Sites s on sp.spSiteID = s.sitSiteID
join [CMS].[dbo].Publications p on p.pubPublicationID = sp.spPublicationID
where artArticleID in (3951413, 1403034)
and s.sitSiteID in (840)


SELECT count(distinct a.artArticleID)
FROM [CMS].[dbo].[Articles] a
join [CMS].[dbo].Issues i on a.artissueId = i.issIssueID
join [CMS].[dbo].SitePublications sp on i.issPublicationID = sp.spPublicationID
join [CMS].[dbo].Sites s on sp.spSiteID = s.sitSiteID
where issActive = 1
and artActive = 1
and s.sitSiteID in (840)
*/


--SELECT cast(artBody as varchar(max))
--FROM [CMS].[dbo].[Articles] a
--join [CMS].[dbo].Issues i on a.artissueId = i.issIssueID
--join [CMS].[dbo].SitePublications sp on i.issPublicationID = sp.spPublicationID
----join [CMS].[dbo].Sites s on sp.spSiteID = s.sitSiteID
----join [CMS].[dbo].Publications p on p.pubPublicationID = sp.spPublicationID
--where --issActive = 1
----and artActive = 1
----and 
----sp.spSiteID in (840)
----and 
--contains(artBody, '"http://www.metalbulletin.com/Assets/pdf*"')

--except

SELECT * --artArticleID, cast(artBody as varchar(max))
FROM [CMS].[dbo].[Articles] a
join [CMS].[dbo].Issues i on a.artissueId = i.issIssueID
join [CMS].[dbo].SitePublications sp on i.issPublicationID = sp.spPublicationID
join [CMS].[dbo].Sites s on sp.spSiteID = s.sitSiteID
--join [CMS].[dbo].Publications p on p.pubPublicationID = sp.spPublicationID
where 
--contains(artBody, '"http://www.metalbulletin.com/Assets/pdf"')
--and (artBody like '%http://%' and artBody like '%.pdf%')
--and 
artArticleID in (3787474)

-- 1. Verify replace
select cast(replace(cast(artBody as nvarchar(max)),'http://www.metalbulletin.com/Assets/pdf','https://www.metalbulletin.com/Assets/pdf') as ntext)
from CMS.dbo.Articles
where artArticleID = 3951413

-- 2. Look for long articles
select top 10 artArticleID, len(cast(artBody as nvarchar(max)))
from CMS.dbo.Articles
where len(cast(artBody as nvarchar(max))) > 8000
and contains(artBody, '"http://www.metalbulletin.com/Assets/pdf"')

/*

artArticleID	(No column name)
3776794	8503
3787474	11327
3787557	10510
3793774	8619
3815844	14964
3815869	14545
3815876	14053
3819788	13125
3820538	14261
3827244	12985

*/


select 
	--replace(cast(artBody as nvarchar(max)),'http://www.metalbulletin.com/Assets/pdf','https://www.metalbulletin.com/Assets/pdf'),
	artBody
from CMS.dbo.Articles
where artArticleID = 3787474

update CMS.dbo.Articles
set artBody = replace(cast(artBody as nvarchar(max)),'http://www.metalbulletin.com/Assets/pdf','https://www.metalbulletin.com/Assets/pdf'),
	artUpdateDate = GETDATE()
where artArticleID = 3787474

select *
from CMS.dbo.Articles
where artArticleID = 3787474



