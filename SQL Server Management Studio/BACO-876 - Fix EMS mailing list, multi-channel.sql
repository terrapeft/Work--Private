use EmailCampaign

drop table if exists dbo.C_Campaign_Sent_Emails

create table dbo.C_Campaign_Sent_Emails (
	cseCampaignId int not null,
	cseMIndex int not null,
	primary key (cseCampaignId, cseMIndex)
)
