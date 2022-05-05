SELECT   pId,pProfitCentre,Plive FROM Publications WHERE  pSource = 'QSS' and pFeedActive = 1  and pProfitcentre is not null



select *
from [NewCentralUsers].[dbo].[FulfilmentImpUpdLog]
where filename like 'eivt%'
