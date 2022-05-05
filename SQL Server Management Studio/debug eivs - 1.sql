
select *
from [NewCentralUsers].[dbo].[FulfilmentImpUpdLog]
where filename in ('EIVS0104.TXT', 'EIVS0105.TXT','EIVS0106.TXT','EIVS0107.TXT')
--where lindex in (104925, 104968, 105010, 105052)
and lIndex > 100000


/*

select top 1 * from FulfilmentImpUpdLog 
where (Fulfilment like 'QSS%' )
and ActionTaken = 'Import' 
and (ActionOK = 1 and ActionOK is not Null ) 
and ( (UpdateDone = 0 or UpdateDone is null)  and (NewCentral = 1 ) )
Order by ActionDate Asc

*/

/*

delete from dbo.FulfilmentImpUpdLog
where filename in ('EIVS0104.TXT', 'EIVS0105.TXT','EIVS0106.TXT','EIVS0107.TXT')

*/

/*
update FulfilmentImpUpdLog
set UpdateDone = 0
where filename = 'EIVS0104.TXT'
and lindex > 100000
*/


select * from qss_table

SELECT TOP 3  *  FROM QSS_TABLE WHERE (Field1 = 'MEM') AND (flg_done is null) AND (Field29 LIKE '%_@__%.__%') ORDER BY Field29,Field80 desc, Field78


SELECT   pId,pProfitCentre,Plive FROM Publications WHERE  pSource = 'QSS' and pFeedActive = 1  and pProfitcentre like '%mfl%'


SELECT  pId, pProfitCentre, Plive 
FROM Publications 
where pProfitCentre in ('man', 'mbc', 'mfl', 'mfp', 'miv', 'mnp', 'mpr' ) -- 08

SELECT  pId, pProfitCentre, Plive 
FROM Publications 
where pProfitCentre like '%mem%'-- 04






