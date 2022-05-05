use NewCentralUsers

 
/* 
select *
from [NewCentralUsers].[dbo].[FulfilmentImpUpdLog]
where filename in ('EIVS0104.TXT', 'EIVS0105.TXT','EIVS0106.TXT','EIVS0107.TXT')
--where lindex in (104925, 104968, 105010, 105052)
*/
 

delete from dbo.FulfilmentImpUpdLog
where lIndex in (104925, 104968, 105010, 105052)