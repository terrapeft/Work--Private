/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [FeedActionLogId]
      ,[FeedId]
      ,[LogXML]
      ,[FeedProcessingHistoryId]
      ,[RunAt]
  FROM [FeedManager].[dbo].[FeedActionLog]
  where logXML like '%eivt191220190106.txt%'


  select logxml.query('/ActionLogEntry/WorkflowStageRetrieve[retrievedfiles="eivt191220190106.txt"]')
  FROM [FeedManager].[dbo].[FeedActionLog]