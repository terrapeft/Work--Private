select --sid,
	Forename, 
	Surname, 
	Email,
	LastAccess,
	--format(LastAccess, 'dd-MM-yyyy HH:mm', 'en-US' ) LastAccess, --commented in order to have the 'ORDER BY' clause without additional 'SELECT FROM'
	Subscriptions

from (

  select --sid,
    --,uTitle
    uForenames Forename
    ,uSurname Surname
	,uEmailAddress Email
    --,uCompany
	,uvLastAccess LastAccess
  	,' ' as Subscriptions
  from Subscriptions s 
	left join UserDetails d on s.suid = d.uID
	left join UserVisits v on v.uvSID = s.sid
  where spid = 320 -- Publication: InstitutionalInvestor.com 2011 
	and cast (sExpiryDate as date) >= cast(getdate() as date)
	and sid not in (
	  select distinct sid
	  from Subscriptions s 
		left join UserDetails d on s.suid = d.uID
		left join UserVisits v on v.uvSID = s.sid
		join Statuses st on st.stPID = s.sPID
	  where spid = 320 -- Publication: InstitutionalInvestor.com 2011 
	  and s.sStatus & st.stMask = st.stMask
	  and cast (sExpiryDate as date) >= cast(getdate() as date)
  )

union

  select --sid,
    --,uTitle
     uForenames Forename
    ,uSurname Surname
	,uEmailAddress Email
    --,uCompany
	,uvLastAccess LastAccess
  	,string_agg(stName, ', ') as Subscriptions
  from Subscriptions s 
	left join UserDetails d on s.suid = d.uID
	left join UserVisits v on v.uvSID = s.sid
	join Statuses st on st.stPID = s.sPID
  where spid = 320 -- Publication: InstitutionalInvestor.com 2011 
  and s.sStatus & st.stMask = st.stMask
  and cast (sExpiryDate as date) >= cast(getdate() as date)
  group by --sid,
    --,uTitle
     uForenames
    ,uSurname
	,uEmailAddress
    --,uCompany
	,uvLastAccess
) q


order by LastAccess desc, Forename, Surname

