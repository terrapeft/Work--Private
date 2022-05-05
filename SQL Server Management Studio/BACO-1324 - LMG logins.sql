use newcentralusers

/*
select s.sUID, ud.uUsername, sStartDate, sExpiryDate, v.*
from Publications p 
join Subscriptions s on p.pID = s.sPID
left join (
	select si.sUID, max(uvLastAccess) as LastUserVisit
	from UserVisits uv
	join Subscriptions si on uv.uvSID = si.sID
	group by si.sUID
) v on v.sUID = s.sUID
join UserDetails ud on ud.uid = s.suid
where pShortName = 'lmg'
and sExpiryDate < LastUserVisit
and LastUserVisit >= dateadd(year, -3, getdate())
order by LastUserVisit desc


select s.sUID, ud.uUsername, sStartDate, sExpiryDate, l.*
from Publications p 
join Subscriptions s on p.pID = s.sPID
left join (
	select UL.ulSID, max([ulDateTime]) as LastLoggedIn
	from UserLogin ul
	group by ul.ulSID
) l on l.ulSID = s.sUID
join UserDetails ud on ud.uid = s.suid
where pShortName = 'lmg'
and sExpiryDate < LastLoggedIn
and LastLoggedIn >= dateadd(year, -3, getdate())
order by LastLoggedIn desc


select * 
from Subscriptions s
join Publications p on p.pID = s.sPID
left join (
	select UL.ulSID, max([ulDateTime]) as LastLoggedIn
	from UserLogin ul
	group by ul.ulSID
) l on l.ulSID = s.sUID
where suid = 93006 and pShortName = 'lmg'


select top 1000 *
from UserLogin ul
where ulSID = 93006
*/

SELECT pid, pName, sStatus, sStartdate, sexpiryDate, sTrialExpirydate, uvNumberOfVisits, uvLastaccess, 1
FROM Publications
JOIN Subscriptions ON pid = spid 
LEFT JOIN UserVisits ON sid = uvSID 
where 
uvLastAccess is not null
and uvlastaccess > strialexpirydate
and pid = 1
order by uvlastaccess desc


select uusername, sExpiryDate, l.* 
from UserLogin l
join Subscriptions s on l.ulsid = s.sid
join UserDetails ud on s.suid = ud.uid
where s.spid = 1
and ulDateTime > s.sExpiryDate
--and ulDateTime > '31-12-2010'
order by ulDateTime desc

/*
BOAT
*/

use BOAT

;with boat as (
    select 
      [when]
      ,pubid
      ,right(info, charindex(':', reverse(info) + ':') - 2) as username
      ,left(info, len(info) - charindex(':', reverse(info) + ':')) as action
      from [BOAT].[dbo].[BOAT_Logging] bl
      where info like '*TITAN*%' 
      and charindex(':', info) > 0
)
--select uusername, Action, sExpiryDate, pShortName, pid, max([when]) as ActionDate
select *
from boat 
join [uk-sql-02].NewCentralUsers.dbo.Publications p on p.pid = boat.pubid
--join [uk-sql-02].NewCentralUsers.dbo.Subscriptions s on s.spid = p.pid
--join [uk-sql-02].NewCentralUsers.dbo.UserDetails ud on s.suid = ud.uid and ud.uUsername = username
where pid = 1 -- LMG
--and sExpiryDate < [when]
--group by uUsername, Action, sExpiryDate, pShortName, pid
--order by uUsername

