use EmailCampaign

select substring(memailaddress, charindex('@',memailaddress) + 1, len(memailaddress) - charindex('@',memailaddress)), count(*)
from EmailCampaign..C_Summary_Badmail_Count c
group by substring(memailaddress, charindex('@',memailaddress) + 1, len(memailaddress) - charindex('@',memailaddress))


select *
from EmailCampaign..C_Summary_Badmail_Count c
join EmailCampaign..C_Summary_Badmail_Count_BACO_1075 cc on c.memailaddress = cc.memailaddress
--where memailaddress like '%fastmarkets.com'


select *
from EmailCampaign..C_Summary_Badmail_Count--_BACO_1075 c
where mEmailAddress = 'francesca.brindle@fastmarkets.com'


select *
from [EmailCampaign_Archive].[dbo].[C_MailingList_Main]
WHERE --EmailAddress = 'tpettengell@fastmarkets.com'
--AND 
(DATEDIFF([d], SendTime, GETDATE())) < 15
AND ReturnedMailReason like 'Invalid Mailbox';



-- look for users who are in bad mails but have recently delivered newsletters
Select distinct CM.EmailAddress
from emailcampaign_archive.dbo.C_Mailinglist  CM WITH (NOLOCK)
INNER Join EMailCampaign.dbo.C_Campaigns CC ON CM.CampaignID = CC.cIndex
INNER Join EMailCampaign.dbo.C_Business CB ON CC.cBusinessID = CB.bIndex
Where  CM.EmailAddress in (select memailaddress from EmailCampaign..C_Summary_Badmail_Count c)
and CM.Undeliverable = 0
and (
		(cTimeStamp >= DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), 0)-30 AND cTimeStamp IS NOT NULL)
		or (cTimeSent >= DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), 0)-30 AND cTimeSent IS NOT NULL)
	)




