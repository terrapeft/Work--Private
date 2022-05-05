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

select 
	ud.uUsername as Email, 
	ud.uTitle as Title, 
	ud.uForenames as Name, 
	ud.uSurname as Surname, 
	ud.uCompany as Company,
	p.pName as Publication,
	s.sExpiryDate as Expiration, 
	string_agg(st.stName, ', ') as Statuses
from UserDetails ud
join Subscriptions s on ud.uID = s.sUID
join Publications p on s.sPID = p.pID
join Statuses st on p.pID = st.stPID
where 
	p.pID in (291)
	and st.stID = 868 -- LME Feed
	and s.sStatus & st.stMask = st.stMask
	and (s.sExpiryDate >= getdate() or s.sTrialExpiryDate >= getdate())
	and uUsername not like '%arcadia.spb.ru'
	and uUsername not like '%arcadiaspb%'
group by ud.uUsername, ud.uTitle, ud.uForenames, ud.uSurname, ud.uCompany, p.pName, s.sExpiryDate, s.sTrialExpiryDate
order by ud.uUsername


