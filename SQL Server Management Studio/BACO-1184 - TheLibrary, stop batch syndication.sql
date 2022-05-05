use TheLibrary


update [TheLibrary].[dbo].[Tasks]
set Status = 1
where BatchID = 106979



/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[SubscriberID]
      ,[BatchID]
      ,[SentDate]
      ,[Status]
      ,[OLDTaskID]
  FROM [TheLibrary].[dbo].[Tasks]
  where BatchID in (106978, 106979)
