use newcentralusers

declare @uid int

set @uid = (select uid 
from userdetails
where uUsername = 'ebyrne@mwe.com')

if @uid is not null 
	insert into Subscriptions (suid, spid, sStartDate, sExpiryDate, sStatus, sComments)
	values (@uid, 5029, getdate(), dateadd(day, 30, getdate()), 2, 'Manually added trial, BACO-1279')


/*
select *
from subscriptions
where suid = 3640270
*/
