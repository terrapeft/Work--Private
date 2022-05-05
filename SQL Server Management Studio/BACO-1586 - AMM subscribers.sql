use newcentralusers

/*

select *
from Publications
where pname like '%amm%' or pname like '%american%'-- or pname like '%mb%'
--where (pUrl like '%mbdatabase%' or pUrl like '%metalbulletin%' or pUrl like '%mbmarket%')
--and (pName not like 'Titan Test Publication' and pName not like '%do not use%')

select top 100 *
from Subscriptions

select * --distinct stName
from Statuses 
where stName like '%LME%'

*/

declare @LmeStatus int = 8, @pid int = 291

;with list as (
	select 
		ud.uUsername as Email, 
		ud.uTitle as Title, 
		ud.uForenames as Name, 
		ud.uSurname as Surname, 
		ud.uCompany as Company,
		p.pName as Publication,
		s.sExpiryDate as Expiration, 
		st.stName as Status,
		case (s.sStatus & st.stMask) when @LmeStatus then 1 else 0 end as LME
	from UserDetails ud
	join Subscriptions s on ud.uID = s.sUID
	join Publications p on s.sPID = p.pID
	join Statuses st on p.pID = st.stPID
	where 
		p.pID = @pid
		and s.sStatus & st.stMask = st.stMask
		and (s.sExpiryDate >= getdate() or s.sTrialExpiryDate >= getdate())
		and uUsername not like '%arcadia.spb.ru'
		and uUsername not like '%arcadiaspb%'
)
select 
	Email, 
	Title, 
	Name, 
	Surname, 
	Company,
	Publication,
	Expiration, 
	case when sum(LME) > 0 then 1 else 0 end as LME,
	string_agg(Status, ', ') as Statuses
from list
group by Email, Title, Name, Surname, Company, Publication, Expiration
order by LME desc, Email asc






