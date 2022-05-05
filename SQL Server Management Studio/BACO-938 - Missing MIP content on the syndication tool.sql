use TheLibrary

update [TheLibrary].[dbo].[Publication]
set ISISConsumerId = 'b1htt52pdnlhn5',
	ISISPublicationName = 'http://data.emii.com/publications/managing-intellectual-property',
	ArticleURLPattern = '/Article/{articleId}/{articleTitle}',
	CMSVersion = 2
where shortname = 'mip'