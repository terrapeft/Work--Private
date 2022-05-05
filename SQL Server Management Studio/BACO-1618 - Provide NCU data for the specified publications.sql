use newcentralusers;


;with pubs as 
(
	select *
	from publications
	where pid in (
		225, 291
	)
),
subs as
(
	select s.sid as SubscriptionId, sUID, sPID, sStartDate, sExpiryDate, sTrialExpiryDate, sTrialTerminatedDate, sSubscriptionNumber,
		sCreationDate, sUpdateDate, sGUID as SubscriptionGuid, sStatus, string_agg(st.stName, ', ') as Status 
	from Subscriptions s
	join pubs p on s.sPID = p.pID
	join Statuses st on st.stpid = p.pid
	where sstatus & st.stMask = st.stMask
	and sExpiryDate >= '1-Jan-2019' 
	group by s.sid, sUID, sPID, sStartDate, sExpiryDate, sTrialExpiryDate, sTrialTerminatedDate, sSubscriptionNumber,
		sCreationDate, sUpdateDate, sGUID, sStatus

),
visits as (
	select [S].[sUID], max([uvLastAccess]) as LastUserVisit
	from newcentralusers.[dbo].[UserVisits] UV
	join newcentralusers.[dbo].[Subscriptions] S on [UV].[uvSID] = [S].[sID]
	join pubs p on s.sPID = p.pID
	group by S.[sUID]
),
logins as (
	select UL.ulSID, max([ulDateTime]) as LastLoggedIn
	from newcentralusers.[dbo].[UserLogin] UL
	join newcentralusers.[dbo].[Subscriptions] S on UL.ulSID = [S].[sUID]
	join pubs p on s.sPID = p.pID
	group by UL.ulSID
)

select
-- userdetails
	ud.uID, uUsername, uForenames, uSurname, uCompany, 
	uJobTitle, cast(uCreationDate as Date) as uCreationDate, cast(uUpdateDate as Date) as uUpdateDate,
-- logins/visits
	cast(v.LastUserVisit as Date) as LastUserVisit, cast(l.LastLoggedIn as Date) as LastLoggedIn,
-- subs
	SubscriptionId, cast(sStartDate as Date) as sStartDate, cast(sExpiryDate as Date) as sExpiryDate, 
	cast(sTrialExpiryDate as Date) as sTrialExpiryDate, cast(sTrialTerminatedDate as Date) as sTrialTerminatedDate,
	sSubscriptionNumber, cast(sCreationDate as Date) as sCreationDate, cast(sUpdateDate as Date) as sUpdateDate, 
	[Status],
-- pubs
	p.pID as PublicationId, p.pName, pCMSSiteID, pParentPublicationID
from UserDetails ud
join subs s on ud.uID = s.sUID
join pubs p on s.sPID = p.pID
left join visits v on ud.uID = v.sUID
left join logins l on ud.uID = l.ulSID
order by uusername
