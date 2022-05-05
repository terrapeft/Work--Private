select distinct
         st.UserId
        ,st.Pubwiz_PubId
        ,st.Pubwiz_PubName
        ,st.NewsletterId
        ,st.NewsletterName
        ,st.SiteID
        ,st.SiteName
        ,st.BusinessId
        ,st.CampaignID
        ,format(st.TimeSent, 'yyyy-MM-dd HH:mm:ss') as TimeSent
        ,st.Email
        ,st.Forename
        ,st.Surname
        ,st.Company_in_EMS
        ,st.Company_in_NCU
        ,st.Company_in_Backoffice
        ,st.Unsubscribed
        ,st.ReturnedMailReason
        ,st.hURL
        ,format(st.FirstOpenDate, 'yyyy-MM-dd HH:mm:ss') as FirstOpenDate
        ,format(st.FirstLinkClickDate, 'yyyy-MM-dd HH:mm:ss') as FirstLinkClickDate
        ,st.Newsletters
        ,st.Campaigns
        ,st.RecordedClicks

        ,s.sid as SubscriptionId
        ,format(s.sStartDate, 'yyyy-MM-dd HH:mm:ss') as sStartDate
        ,format(s.sExpiryDate, 'yyyy-MM-dd HH:mm:ss') as sExpiryDate
        ,format(s.sTrialExpiryDate, 'yyyy-MM-dd HH:mm:ss') as sTrialExpiryDate
        
        ,p.pID as PublicationId, p.pName, p.pShortName, p.pURL
        
        ,od.odOrderID
        ,od.odProductCatalogueID
    
from ##stats st
join [SQL-NBO].NewCentralUsers.dbo.UserDetails ud on st.UserID = ud.uID
join [SQL-NBO].NewCentralUsers.dbo.Subscriptions s on ud.uID = s.sUID
join [SQL-NBO].NewCentralUsers.dbo.Publications p on p.pID = s.sPID
left join [SQL-NBO].NewCentralUsers.dbo.OrderDetails od on s.sID = od.odSubscriptionID

where p.pID in (
	230,
	213,
	212,
	211,
	291,
	5033,
	5044,
	216,
	6,
	5022,
	5069,
	5049,
	417,
	218,
	5047,
	219,
	217,
	250,
	5046,
	414,
	223,
	251,
	372,
	371,
	373,
	224,
	5031,
	5048,
	5010,
	5011,
	5024,
	5019,
	5013,
	5020,
	5015,
	5021,
	5012,
	5014,
	5018,
	334,
	335,
	384,
	336,
	337,
	338,
	339,
	340,
	365,
	264,
	257,
	5045,
	5025,
	225,
	327,
	262,
	341,
	331,
	267,
	206,
	269,
	273,
	383,
	5050,
	231,
	233,
	353,
	235,
	404,
	234,
	268,
	5017,
	236
)

order by st.Email