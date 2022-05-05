use NewCentralUsers


/*
	Need the WITH clause to avoid duplicates in the string_agg for users with several identical subscriptions for one publication
	(see george.billings@nucor.com: uusername = 'george.billings@nucor.com' and pid = 291)
*/
;with users as (
	select distinct top 1000000
		 uUsername
		,sStartDate
		,sExpiryDate
		,pID
		,pName
		,pShortName
		,sTrialExpiryDate
		,uv.LastUserVisit
		,sStatus
	from publications p 
	join subscriptions s on p.pID = s.sPID
	join userdetails ud on s.sUID = ud.uID
	left join (
		select S.sUID, max(uvLastAccess) as LastUserVisit
		from newcentralusers.dbo.UserVisits UV
		join newcentralusers.dbo.Subscriptions S
		on UV.uvSID = S.sID
		group by S.sUID
	) UV on UV.sUID = ud.uID
	where (
		   pname = 'Fastmarkets Platform'
		or pname = 'IM News'
		or pname = 'MB Data - All Metals'
		or pname = 'MB News'
		or pname = 'Metal Bulletin'
		or pname = 'Metal Bulletin Research'
		or pname = 'Steel Raw Materials'
		or pname = 'Steel Tracker'
		or pname = 'American Metal Markets')
		and (s.sExpiryDate >= dateadd(year, -2, getdate()) or s.sTrialExpiryDate >= dateadd(year, -2, getdate()))
		order by pid, pname, sstatus -- this is to have the same order in the string_agg for the same statuses
	) 
select
	 uUsername
	,sStartDate
	,sExpiryDate
	,pName
	,pShortName
	,sTrialExpiryDate
	,LastUserVisit
	,sStatus
	,string_agg(st.stName, ', ') as [Status]
from users u 
join statuses st on u.pid = st.stPID
where
sstatus & st.stMask = st.stMask
group by uUsername, sStartDate, sExpiryDate, pName, pShortName, sTrialExpiryDate, LastUserVisit, sStatus
order by uUsername, pName, sStatus

