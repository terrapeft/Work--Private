/*
use EmailCampaign

select mIndex, mCount, mEMailAddress
into C_Summary_Badmail_Count_BACO_1075
from C_Summary_Badmail_Count

delete 
from C_Summary_Badmail_Count
*/

/*
select * 
from C_Mailinglist
where campaignid = 1615100
*/

select CampaignID, cStartDate, cEndDate, cTimeSent
from EmailCampaign..C_Campaigns c
join EmailCampaign_Archive..C_Mailinglist m on c.cIndex = m.CampaignId
where c.cIndex = 1615200
and emailaddress like 'tpetten%'
