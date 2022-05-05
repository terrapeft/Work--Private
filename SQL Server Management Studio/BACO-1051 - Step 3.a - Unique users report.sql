use EmailCampaign

--select 
--	 Email
--	,FullName
--	,Company_in_NCU
--	,Unsubscribed
--	,min(FirstOpenDate) as FirstOpenDate
--	,min(FirstLinkClickDate) as FirstLinkClickDate
--	,count(distinct NewsletterId) as Newsletters
--	,count(distinct t.CampaignId) as Campaigns
--	,count(hURL) as Clicks
--from t1051 t 
--	join exportdata e on t.mindex = e.mindex and e.TimeSent != 'not sent'
--	join emailcampaign_archive..C_LinksHitsLog l on l.hmIndex = t.mindex
--where email = 'A.INOUE@MITSUI.COM'
	
--group by Email, FullName, Company_in_NCU, Unsubscribed
----order by Email

--union 

;with groups as
(
select 
	 Email
	,min(FirstOpenDate) as FirstKnownOpenDate
	,min(FirstLinkClickDate) as FirstKnownLinkClickDate
	,count(distinct NewsletterId) as Newsletters
	,count(distinct t.CampaignId) as Campaigns
	,count(hURL) as RecordedClicks
from t1051 t 
	left join exportdata e on t.mindex = e.mindex and e.TimeSent != 'not sent'
	left join emailcampaign_archive..C_LinksHitsLog l on l.hmIndex = t.mindex
--where email = 'ASAMI.IRIE@SUMITOMOCORP.COM' --and
	--(e.EmailAddress is null or l.hCampaignID is null)
	 
group by Email
)
select distinct t.Email, t.Forename, t.Surname, t.Company_in_NCU, g.FirstKnownOpenDate, g.FirstKnownLinkClickDate, g.Newsletters, g.Campaigns, g.RecordedClicks
from groups g 
join t1051 t on g.Email = t.Email


/* Detailed by user */
select 
	 t.CampaignID
	,e.TimeSent
	,Email
	,Forename
	,Surname
	,Company_in_EMS
	,Company_in_NCU
	,Company_in_Backoffice
	,UserId
	,Pubwiz_PubId
	,Pubwiz_PubName
	,NewsletterId
	,NewsletterName
	,SiteID
	,SiteName
	,BusinessId
	,Unsubscribed
	,ReturnedMailReason
	,FirstOpenDate
	,FirstLinkClickDate
	,hURL
	,hDate


from t1051 t 
left join exportdata e on t.mindex = e.mindex and e.TimeSent != 'not sent'
left join emailcampaign_archive..C_LinksHitsLog l on l.hmIndex = t.mindex
where email = 'upvzscrtf@moakt.ws' 






/*

select t.CampaignID, e.timesent, *
from t1051 t 
left join exportdata e on t.mindex = e.mindex
left join emailcampaign_archive..C_LinksHitsLog l on l.hmIndex = t.mindex
where email = 'CARMS@FMI.COM' and e.timesent != 'not sent'
order by e.timesent desc

*/