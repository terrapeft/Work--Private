/*
	Version 2, 2020-10-21
*/

use BackOffice

drop table if exists #users

/* gather users with missing spp records and/or with empty expiration date */
select uID, uUsername, uComments, sStartDate, sExpiryDate, sTrialExpiryDate, sID, sCreatedBy
into #users
from NewCentralUsers.dbo.UserDetails ud 
join NewCentralUsers.dbo.Subscriptions s ON s.sUID = ud.uID 
left join Backoffice.dbo.SubscriptionProductPublication spp  ON s.[sID] = spp.SubscriptionId
where s.spid = 223 
and spp.SubscriptionId is null
and (sExpiryDate >= getDate() or (sExpiryDate is null and (sTrialExpiryDate is null or sTrialExpiryDate >= getDate())))



/* update empty dates - decided to skip */
/*
update s
set sExpiryDate = datefromparts(2050, 12, 31)
--select *
from NewCentralUsers.dbo.Subscriptions s
join #users u on s.suid = u.uid
where spid = 223 and (s.sExpiryDate is null and (s.sTrialExpiryDate is null or s.sTrialExpiryDate >= getDate()))
*/


/* add to SubscriptionProductPublication */
insert into Backoffice.dbo.SubscriptionProductPublication (SubscriptionId, ProductId, PublicationId, SubscriptionStatus)
select s.sid, 6088, 223, s.sStatus
from NewCentralUsers.dbo.Subscriptions s
join #users u on s.suid = u.uid
left join Backoffice.dbo.SubscriptionProductPublication spp on spp.SubscriptionId = s.sid and spp.ProductId = 6088
where 
	spid = 223 
	and spp.SubscriptionId is null
	and s.sExpiryDate >= getDate()

