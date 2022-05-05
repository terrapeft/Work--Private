with all_of_it as (
	select 
		EmailAddress, 
		min(e.mIndex) as mIndex
	from EmailCampaign_Archive.dbo.C_Mailinglist_ExtraFields e
	join EmailCampaign_Archive.dbo.C_MailingList_Main m on e.mIndex = m.mIndex 
	where 
		ReturnedMailReason like 'Invalid mailbox%'
		and EmailAddress in 
		(	'tpettengell@fastmarkets.com', 
			'suban.purushothmakumar@fastmarkets.com', 
			'weijun.lau@fastmarkets.com', 
			'derry.neo@fastmarkets.com',
			'peter.lunn@specialityuk.com',
			'jade.cox@fastmarkets.com',
			'hadia@ezzsteel.com',
			'gerkmen@colakoglu.com.tr',
			'mrtynbrbr@aol.com',
			'tsoresearch@yahoo.com',
			'Edward.Vore@arcelormittal.com'
		)
		--(select memailaddress from EmailCampaign..C_Summary_Badmail_Count)
	and TimeSent >= DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), 0)-90
	and PreFailed = 0
	group by EmailAddress
) 

select 
		a.mIndex,
		TimeSent,
		a.EmailAddress,
		ReturnedMailBody as ReturnedEmailHtml, 
		Undeliverable, 
		PreFailed, 
		ReturnedMailReason, 
		e.mIndex, 
		CampaignId

from all_of_it a
join EmailCampaign_Archive.dbo.C_Mailinglist_ExtraFields e on a.mIndex = e.mIndex
join EmailCampaign_Archive.dbo.C_MailingList_Main m on e.mIndex = m.mIndex 



	
