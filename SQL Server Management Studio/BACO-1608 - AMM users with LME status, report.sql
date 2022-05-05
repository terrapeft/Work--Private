use NewCentralUsers

declare @LmeStatus int = 8, @pid int = 291
declare @startDate date = dateadd(day, 1, eomonth(getdate(), -2))

;with list as (
	select distinct
		ud.uID,
		ud.uForenames as Name, 
		ud.uSurname as Surname, 
		ud.uUsername as Email, 
		ud.uCompany as Company,
		a.aID as AddressId,
		a.aAddress1 as Address1,
		a.aAddress2 as Address2,
		a.aAddress3 as Address3,
		a.aCity as City,
		a.aCounty as County,
		a.aState as [State],
		a.aPostCode as PostCode,
		a.aTel as Tel,
		a.aFax as Fax,
		a.aMobTel as MobTel,
		case when (s.sExpiryDate is not null) then s.sExpiryDate else s.sTrialExpiryDate end as Expiration,
		case (s.sStatus & st.stMask) when @LmeStatus then 1 else 0 end as LME
	from UserDetails ud
	join Subscriptions s on ud.uID = s.sUID
	join Publications p on s.sPID = p.pID
	join Statuses st on p.pID = st.stPID and s.sStatus & st.stMask = st.stMask
	left join Addresses a on ud.uID = a.aUID and aActive = 1 and aDefault = 1
	where 
		p.pID = @pid
		and (s.sExpiryDate >= @startDate or s.sTrialExpiryDate >= @startDate)
		and uUsername not like '%arcadia.spb.ru'
		and uUsername not like '%arcadiaspb%'
),
res as (
	select 
		uID, Name, Surname, Email, Company, 
		AddressId, Address1, Address2, Address3, City, County, [State], PostCode, Tel, Fax, MobTel, Expiration, 
		case when sum(LME) > 0 then 1 else 0 end as LME
	from list
	group by uID, Name, Surname, Email, Company, AddressId, Address1, Address2, Address3, City, County, [State], PostCode, Tel, Fax, MobTel, Expiration
)

select * 
from res
where Expiration >= case when LME = 0 then getdate() else @startDate end
order by LME desc, Email asc









