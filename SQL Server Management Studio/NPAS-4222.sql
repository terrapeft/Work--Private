

SELECT TOP (1000) *
  FROM [NewCentralUsers].[dbo].[Newsletters]
  where [nCreationDate] > '2019-02-28'
  and npublication = 5022
  order by [nCreationDate] desc



SELECT TOP (1000) *
  FROM [NewCentralUsers].[dbo].[Subscriptions]
  where [sCreationDate] > '2019-02-28'
  and spid = 5022
  order by [sCreationDate] desc




  SELECT   pId,pProfitCentre,Plive 
  FROM Publications 
  WHERE  pSource = 'QSS' and pFeedActive = 1  and pProfitcentre is not null 
  order by  pid

  Select top 1 * 
  from FulfilmentImpUpdLog 
  where Fulfilment like 'QSSH' and actionTaken = 'Import' and (ActionOK = 1 and ActionOK is not Null ) and (UpdateDone is Null or UpdateDone = 0) and (NewCentral = 1 )  
  Order by ActionDate Desc

  update FulfilmentImpUpdLog 
  set UpdateDone = 0
  where lIndex = 91912 and FileName = 'eivs280219070000.txt'
  

  select * from statuses where stpid = 5022