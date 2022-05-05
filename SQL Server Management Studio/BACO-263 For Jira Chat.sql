use NewCentralUsers

select edgText, edcName, e.edgPublicationId, edgGroupID, ec.edcCode, p.pName
from 
	EdenGroup e join 
	Publications p on e.edgPublicationid = p.pid join 
	EdenGroupCodes c on e.edgGroupId = c.egcGroupId join 
	EdenCode ec on c.egcCodeId = ec.edcCodeId
where edgPublicationID in (223)
and edgText = 'Company Type'
order by edgPublicationID, edgGroupID, edcCode


where edcCode in ('1503', '1950')


select * 
from [NewCentralUsers].[dbo].[EdenGroup] 
where edgPublicationID = 392 --and edgText = @groupName