use NewCentralUsers
/*
select *
from qss_cast_27102020
where email = 'Isobel.wright@hoganlovells.com'

select *
from qss_result_28102020
where email = 'Isobel.wright@hoganlovells.com'



select email
from qss_result_28102020
except
select email
from qss_cast_27102020
*/

select distinct c.email, c.pid [cpid], r.pid [rpid], c.pname
	,c.sExpiryDate as [before]
	,r.sExpiryDate as [after]
	--,s.sStartDate, s.sExpiryDate, s.sTrialExpiryDate, s.sTrialTerminatedDate, s.sCreationDate, s.sUpdateDate
from qss_cast_27102020 c
join qss_result_28102020 r on c.email = r.email
where r.sExpiryDate < c.sExpiryDate
	and r.sExpiryDate < getdate() 
	and c.sExpiryDate > getdate()
order by email

select distinct c.email, c.pid [cpid], r.pid [rpid], c.pname
	,c.sExpiryDate as [before]
	,r.sExpiryDate as [after]
	--,s.sStartDate, s.sExpiryDate, s.sTrialExpiryDate, s.sTrialTerminatedDate, s.sCreationDate, s.sUpdateDate
from qss_cast_27102020 c
join qss_result_28102020 r on c.email = r.email
where r.sExpiryDate > c.sExpiryDate
	and r.sExpiryDate > getdate() 
	and c.sExpiryDate < getdate()
order by email



select *
from qss_cast_27102020
where email = 'aescribano@loomissayles.com'

select *
from qss_result_28102020
where email = 'aescribano@loomissayles.com'

;with cst as (
	select email, pid, pname, isnull(sStartDate, '1783-12-31') sStartDate, isnull(sExpiryDate, '1783-12-31') sExpiryDate
	from qss_cast_27102020
),
rslt as (
	select email, pid, pname, isnull(sStartDate, '1783-12-31') sStartDate, isnull(sExpiryDate, '1783-12-31') sExpiryDate
	from qss_result_28102020
)
select distinct c.email, r.email, c.pid [pub before], r.pid [pub after], c.pname
	,c.sExpiryDate as [before]
	,r.sExpiryDate as [after]
	--,r.sUpdateDate
	--,s.sStartDate, s.sExpiryDate, s.sTrialExpiryDate, s.sTrialTerminatedDate, s.sCreationDate, s.sUpdateDate
from cst c
full outer join rslt r on 
	c.email = r.email 
	and c.pid = r.pid 
	and (
			c.sStartDate = r.sStartDate or c.sExpiryDate = r.sExpiryDate
		)
where 
	--c.email = 'Isobel.wright@hoganlovells.com' 
	--and
	c.email is null or r.email is null
