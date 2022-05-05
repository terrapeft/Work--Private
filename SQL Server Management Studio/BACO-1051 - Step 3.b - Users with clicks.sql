use EmailCampaign;

--declare @user varchar(120) = 'UWulfert@titan-intertractor.com'
--declare @user varchar(120) = 'uwaldburger@ega.ae'
declare @monthsAgo int = 1
declare @today date = GetDate();

/* Detailed by user */
select 
	 UserId
	,Pubwiz_PubId
	,Pubwiz_PubName
	,NewsletterId
	,NewsletterName
	,SiteID
	,SiteName
	,BusinessId
	,t.CampaignID
	,e.TimeSent
	,Email
	,Forename
	,Surname
	,Company_in_EMS
	,Company_in_NCU
	,Company_in_Backoffice
	,Unsubscribed
	,ReturnedMailReason
	,hURL
	--,min(hDate) as hDate
	,min(FirstOpenDate) as FirstOpenDate
	,min(FirstLinkClickDate) as FirstLinkClickDate
	--,min(e.TimeSent) as TimeSent
	,count(distinct NewsletterId) as Newsletters
	,count(distinct t.CampaignId) as Campaigns
	,count(hURL) as RecordedClicks

from t1051 t 
left join exportdata e on t.mindex = e.mindex and e.TimeSent != 'not sent'
join emailcampaign_archive..C_LinksHitsLog l on l.hmIndex = t.mindex
where e.TimeSent >= dateadd(month, datediff(month, 0, @today) - @monthsAgo, 0) and e.TimeSent <= eomonth(@today, -@monthsAgo)
	--and email = @user 
	--and email like '%metalbulletin%'
	--and ReturnedMailReason is not null
group by 
	 UserId
	,Pubwiz_PubId
	,Pubwiz_PubName
	,NewsletterId
	,NewsletterName
	,SiteID
	,SiteName
	,BusinessId
	,t.CampaignID
	,e.TimeSent
	,Email
	,Forename
	,Surname
	,Company_in_EMS
	,Company_in_NCU
	,Company_in_Backoffice
	,Unsubscribed
	,ReturnedMailReason
	,hURL
order by Email
