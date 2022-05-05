USE EMAILCAMPAIGN

UPDATE [EmailCampaign_Archive].[dbo].[C_MailingList_Main]
SET ReturnedMailReason = 'Invalid Mailbox (Updated ' + CONVERT(VARCHAR, GETDATE(), 103) + ' JIRA, BACO-1075)'
WHERE EmailAddress in (select mEMailAddress from EmailCampaign..C_Summary_Badmail_Count)
AND (DATEDIFF([d], SendTime, GETDATE())) < 15
AND ReturnedMailReason='Invalid Mailbox';


delete 
from EmailCampaign..C_Summary_Badmail_Count


