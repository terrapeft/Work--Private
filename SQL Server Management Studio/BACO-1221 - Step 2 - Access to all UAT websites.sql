use NewCentralUsers

declare @uid int = 3628642
--set @uid = (select top 1 uid from UserDetails where uEmailAddress = 'svc-claranet-pentest@euromoneyplc.com')

;with current_subs as
(
	select distinct spid
	from subscriptions
	where suid = @uid
	and (sExpiryDate >= getdate() or sTrialExpiryDate >= getdate())
),
all_pubs as 
(
	select spid from 
	( values (225),(291),(5022),(368),(423),(356),(418),(319),(240),(66),(196),(2),(275),(238),(5047),(225)) as v (spid)	
),
sub_status as
(
	select stPID, sum(cast(st.stMask as bigint)) as stMask
	from dbo.Publications p join dbo.Statuses st on p.pID = st.stPID
	where st.stMask is not null
	group by stPID
	having sum(cast(st.stMask as bigint)) <= 2147483647
	union
	select stPID, max(st.stMask) as stMask
	from dbo.Publications p join dbo.Statuses st on p.pID = st.stPID
	where st.stMask is not null
	group by stPID
	having sum(cast(st.stMask as bigint)) > 2147483647
)

insert into Subscriptions (suid, spid, sStatus, sStartDate, sExpiryDate, sComments)
select @uid, t.spid, ss.stMask , getdate(), dateadd(year, 1, getdate()), 'UAT Refresh script for svc-claranet-pentest@euromoneyplc.com'
from (
	select spid
	from all_pubs
	except 
	select spid
	from current_subs
) t 
join Publications p on t.spid = p.pid
join sub_status ss on ss.stPID = t.spid







/*
;with s1 as
(
	select stPID, min(st.stMask) as stMask
	from dbo.Publications p 
	join dbo.Statuses st on p.pID = st.stPID
	where st.stMask is not null
	group by stPID
)
select s1.*, st.stName
from s1
join dbo.Statuses st on s1.stPID = st.stPID and s1.stMask = st.stMask
order by stPID
*/


/*

select *
from dbo.Statuses
where stpid = 320

*/


/*
delete from subscriptions
where suid = 3628642
and sComments = 'UAT Refresh script for svc-claranet-pentest@euromoneyplc.com'
*/



