/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Publication_ID]
      ,[Name]
      ,[ShortName]
      ,[URL]
      ,[LastUpdated]
      ,[UpdatedBy]
      ,[CMSVersion]
      ,[ISISPublicationName]
      ,[IsActive]
      ,[PublicationGroupId]
      ,[ArticleURLPattern]
      ,[ISISConsumerId]
  FROM [TheLibrary].[dbo].[Publication]
  where shortname = 'imae'





update TheLibrary.dbo.Publication set 
	ISISConsumerId = 'wnl5pvy5x355',
	ArticleURLPattern = '/article/{articleId}/{articleTitle}'
where shortname = 'imae'





update TheLibrary.dbo.Publication set 
	ISISConsumerId = 'g65cgs0jpvhl',
	ArticleURLPattern = '/article/{articleId}/{articleTitle}'
where shortname in ('em','EUROW','TS','EW_Asia','EW_SR','ASIAM','DW')

update TheLibrary.dbo.Publication set 
	ISISConsumerId = null,
	ArticleURLPattern = null
where shortname in ('II')

update TheLibrary.dbo.Publication set 
	ISISConsumerId = null,
	ArticleURLPattern = '/article/{articleId}/{articleTitle}'
where shortname in ('CM','AJ','REACT','TF','MML','FAEMM','GI','FOWeek','FOWorld','PF')

update TheLibrary.dbo.Publication set 
	ISISConsumerId = 'zxb17658gljp',
	ArticleURLPattern = '/article/{articleId}/{articleTitle}.html'
where shortname in ('EUROM')

update TheLibrary.dbo.Publication set 
	ISISConsumerId = 'b10rcmyrclczjx',
	ArticleURLPattern = '/article/{articleId}/{articleTitle}'
where shortname in ('GTB')



