use EmailCampaign

/*
select *
from EmailCampaign_Archive..C_MailingList_Main
where EmailAddress in (select mEMailAddress from EmailCampaign..C_Summary_Badmail_Count)
and (datediff([d], SendTime, getdate())) < 15
and ReturnedMailReason='Invalid Mailbox'
and EmailAddress = 'nwallace@swvainc.com'


select *
from EmailCampaign..C_Summary_Badmail_Count
where mEmailAddress like '%nwallace%'

*/



update EmailCampaign_Archive..C_MailingList_Main
set ReturnedMailReason = 'Invalid Mailbox (Updated ' + convert(varchar, getdate(), 103) + ' JIRA, BACO-1075)'
where EmailAddress in (select mEMailAddress from EmailCampaign..C_Summary_Badmail_Count)
and (datediff([d], SendTime, getdate())) < 15
and ReturnedMailReason='Invalid Mailbox';

delete 
from EmailCampaign..C_Summary_Badmail_Count
where mEmailAddress = 'nwallace@swvainc.com'


