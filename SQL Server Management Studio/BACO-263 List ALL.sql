use NewCentralUsers

select 
	p.pid as [Publication ID],  
	p.pName as [Publication], 
	edgGroupID as [Group ID], 
	edgText as [Group Name],
	-- ec.edcCodeID,
	ec.edcCode as [Code], 
	edcName as [Code Name]
from 
	EdenGroup e join 
	Publications p on e.edgPublicationid = p.pid join 
	EdenGroupCodes c on e.edgGroupId = c.egcGroupId join 
	EdenCode ec on c.egcCodeId = ec.edcCodeId
where edgPublicationID in (
	5023, -- ITR
	5027, -- MIP
	5029, -- IFLR
	5032, -- AsiaLaw
	5035, -- Benchmark

	66,   -- Coaltrans
	392,  -- Global Grain
	223,  -- IndMin
	225,  -- MB
	291   -- AMM
)
--and edgtext in (
--	'Company Type',
--	'Interest Area',
--	'Job Function',
--	'Area of Responsibility'
--)
--and edcCode = '9618'
order by edgPublicationID, edgGroupID, edcName

/*

select edgPublicationID, edgGroupId, edgText, edgAnswerFormat
from [NewCentralUsers].[dbo].[EdenGroup] 
where edgPublicationID in (
	5023, -- ITR
	5027, -- MIP
	5029, -- IFLR
	5032, -- AsiaLaw
	5035, -- Benchmark

	66,   -- Coaltrans
	392,  -- Global Grain
	223,  -- IndMin
	225,  -- MB
	291   -- AMM
)

order by edgPublicationID, edgGroupId, edgText


*/

