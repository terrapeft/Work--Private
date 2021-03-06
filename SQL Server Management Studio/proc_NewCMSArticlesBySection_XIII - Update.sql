USE [PubWiz]
GO
/****** Object:  StoredProcedure [dbo].[proc_NewCMSArticlesBySection_XIII]    Script Date: 20-Aug-18 12:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[proc_NewCMSArticlesBySection_XIII]
@PublicationID int,  
@SectionID int  
AS  
BEGIN  
	SET NOCOUNT ON;

	DECLARE @sfdIssue1 int
	DECLARE @sfdIssue2 int
	SELECT @sfdIssue1 = dbo.LatestIssueByPublication(656)
	SELECT @sfdIssue2 = dbo.SecondLatestIssueByPublication(656)
  
	DECLARE @DaysPastST int
	DECLARE @DaysPastNewsAlerts int
	DECLARE @DayofWeekST int
	DECLARE @ArticleDateFromST datetime
	DECLARE @dateNowST  datetime
 
	set @dateNowST=getdate()  
	set @DayofWeekST=DATEPART(dw, @dateNowST)
 
	SELECT @DaysPastST = CASE (@DayofWeekST)
		WHEN 1 THEN 3 --SUNDAY  
		WHEN 2 THEN 1 --MONDAY 
		WHEN 3 THEN 1 --TUESDAY 
		WHEN 4 THEN 1 --WEDNESDAY
		WHEN 5 THEN 1 --THURSDAY 
		WHEN 6 THEN 1 --FRIDAY 
		WHEN 7 THEN 2 --SATURDAY 
	END

	SELECT @DaysPastNewsAlerts = CASE (@DayofWeekST)
		WHEN 1 THEN 2 --SUNDAY  
		WHEN 2 THEN 3 --MONDAY 
		WHEN 3 THEN 1 --TUESDAY 
		WHEN 4 THEN 1 --WEDNESDAY
		WHEN 5 THEN 1 --THURSDAY 
		WHEN 6 THEN 1 --FRIDAY 
		WHEN 7 THEN 1 --SATURDAY 
	END

    SET @ArticleDateFromST=@dateNowST - @DaysPastST 

	CREATE TABLE #stArts(
	[staid] INT IDENTITY(1,1),
	[artActiveDate] [datetime] NULL,
	[aevValue] nvarchar(1000) NULL,
	[ArticleID] [int] NOT NULL,
	[Teaser] [varchar](2000) NULL,
	[Title] [varchar](1024) NULL,
	[SubHeadline] [varchar](1024) NULL,
	[Body] [ntext] NULL,
	[Author] [ntext] NULL)  

	-- MB - Daily Steel
	IF @SectionID IN (8031,8032,8033,8034,8035,8036,8037,8038,8039,8049) BEGIN 
		IF @SectionID = 8031 -- top story section
		BEGIN
			INSERT INTO #stArts ([artActiveDate],[aevValue],[ArticleID],[Teaser],[Title],[SubHeadline],[Body])  
			SELECT artActiveDate,aevVarChar,artArticleID,aevVarChar,artTitle,cast(cats.catName as varchar),
			case when artDescription = '' or artDescription is null then cast(artBody as varchar(max)) else cast(artDescription as varchar(max)) + '<br /><br />' + cast(artBody as varchar(max)) end
			FROM [SQL-CMS].[CMS].[dbo].[Articles] art
				INNER JOIN [SQL-CMS].[CMS].[dbo].[Issues] iss ON art.artIssueId = iss.issIssueId
				INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat on art.artArticleID = cat.acArticleID
				INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat2 on art.artArticleID = cat2.acArticleID
				INNER JOIN [SQL-CMS].[CMS].[dbo].[Categories] cats on cat2.acCategoryID = cats.catCategoryID
				LEFT OUTER JOIN [SQL-CMS].[CMS].[dbo].ArticleExtraValues aev on art.artArticleID = aev.aevArticleID and aevArticleExtraFieldID = 755
			WHERE cat.acCategoryID = 9510 AND cat2.acCategoryID = 14481
				AND iss.issIssueID in (@sfdIssue1,@sfdIssue2)
				AND art.ArtActiveDate >=@ArticleDateFromST
				AND artActive = 1 AND iss.issActive = 1
			ORDER BY artArticleID desc
		END	else begin -- region sections
			DECLARE @stRegionCatID  int
			SET @stRegionCatID = 0
			IF @SectionID = 8032 set @stRegionCatID =  17174 -- global
			IF @SectionID = 8033 set @stRegionCatID =  17171 -- asia
			IF @SectionID = 8034 set @stRegionCatID =  17176 -- middle east
			IF @SectionID = 8035 set @stRegionCatID =  17173 -- europe
			IF @SectionID = 8036 set @stRegionCatID =  17178 -- CIS/Russia
			IF @SectionID = 8037 set @stRegionCatID =  17177 -- North America
			IF @SectionID = 8038 set @stRegionCatID =  17175 -- Latin America
			IF @SectionID = 8039 set @stRegionCatID =  17172 -- Australia
			IF @SectionID = 8049 set @stRegionCatID =  17170 -- Africa
		
			INSERT INTO #stArts ([artActiveDate],[aevValue],[ArticleID],[Teaser],[Title],[SubHeadline],[Body])  
			SELECT artActiveDate,   
			aevVarChar,  
			artArticleID,  
			aevVarChar,  
			artTitle,  
			cast(cats.catName as varchar),  
			case when artDescription = '' or artDescription is null then cast(artBody as varchar(max)) else cast(artDescription as varchar(max)) + '<br /><br />' + cast(artBody as varchar(max)) end
			FROM [SQL-CMS].[CMS].[dbo].[Articles] art
				INNER JOIN [SQL-CMS].[CMS].[dbo].[Issues] iss ON art.artIssueId = iss.issIssueId
				INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat on art.artArticleID = cat.acArticleID AND cat.acCategoryID = @stRegionCatID
				INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat2 on art.artArticleID = cat2.acArticleID
				INNER JOIN [SQL-CMS].[CMS].[dbo].[Categories] cats on cat2.acCategoryID = cats.catCategoryID AND cats.catCategoryGroupID = 1232
				LEFT OUTER JOIN [SQL-CMS].[CMS].[dbo].ArticleExtraValues aev on art.artArticleID = aev.aevArticleID and aevArticleExtraFieldID = 755
			WHERE iss.issIssueID in (@sfdIssue1,@sfdIssue2)
			AND art.ArtActiveDate >=@ArticleDateFromST
			AND artActive = 1
			AND iss.issActive = 1			
			ORDER BY artArticleID desc
		end	
	end 
	else 
	if @sectionId in (8042,8043,8044,8045,8046,8058) Begin --MB - raw materials
		IF @SectionID = 8058 -- top story section
		BEGIN
			INSERT INTO #stArts ([artActiveDate],[aevValue],[ArticleID],[Teaser],[Title],[SubHeadline],[Body])  
			SELECT artActiveDate,aevVarChar,artArticleID,aevVarChar,artTitle,'N/A',case when artDescription = '' or artDescription is null then cast(artBody as varchar(max)) else cast(artDescription as varchar(max)) + '<br /><br />' + cast(artBody as varchar(max)) end
			FROM [SQL-CMS].[CMS].[dbo].[Articles] art
				INNER JOIN [SQL-CMS].[CMS].[dbo].[Issues] iss ON art.artIssueId = iss.issIssueId
				INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat on art.artArticleID = cat.acArticleID
				INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat2 on art.artArticleID = cat2.acArticleID
				LEFT OUTER JOIN [SQL-CMS].[CMS].[dbo].ArticleExtraValues aev on art.artArticleID = aev.aevArticleID and aevArticleExtraFieldID = 755
			WHERE cat.acCategoryID = 9510 AND cat2.acCategoryID in (9492,17127,9496,16978,9493,17126,17066,9495)
				AND iss.issIssueID in (@sfdIssue1,@sfdIssue2)
				AND art.ArtActiveDate >=@ArticleDateFromST
				AND artActive = 1 AND iss.issActive = 1
			ORDER BY artArticleID desc
		END	else begin -- region sections
			create table #categories(id int)
			IF @SectionID = 8042 begin insert into #categories values(9493) end -- Iron Ore
			IF @SectionID = 8043 begin insert into #categories values(9492) end -- Coke / Coaking Coal
			IF @SectionID = 8044 begin insert into #categories values(9496) end -- Scrap
			IF @SectionID = 8045 begin
				insert into #categories values(17127)
				insert into #categories values(16978)
				insert into #categories values(17126)
			end -- Pig Iron / DRI
			IF @SectionID = 8046 begin
				insert into #categories values(17066)
				insert into #categories values(9495)
			end -- Nickel / Alloys

			INSERT INTO #stArts ([artActiveDate],[aevValue],[ArticleID],[Teaser],[Title],[SubHeadline],[Body])  
			SELECT artActiveDate,aevVarChar,artArticleID,aevVarChar,artTitle,'N/A',case when artDescription = '' or artDescription is null then cast(artBody as varchar(max)) else cast(artDescription as varchar(max)) + '<br /><br />' + cast(artBody as varchar(max)) end
			FROM [SQL-CMS].[CMS].[dbo].[Articles] art
				INNER JOIN [SQL-CMS].[CMS].[dbo].[Issues] iss ON art.artIssueId = iss.issIssueId
				INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat on art.artArticleID = cat.acArticleID
				LEFT OUTER JOIN [SQL-CMS].[CMS].[dbo].ArticleExtraValues aev on art.artArticleID = aev.aevArticleID and aevArticleExtraFieldID = 755
			WHERE cat.acCategoryID in (select id from #categories)
				AND iss.issIssueID in (@sfdIssue1,@sfdIssue2)
				AND art.ArtActiveDate >=@ArticleDateFromST
				AND artActive = 1 AND iss.issActive = 1
			ORDER BY artArticleID desc
		END
	End

--MB - Steel Market Outlook
else IF @SectionID in (8052)
BEGIN
	INSERT INTO #stArts ([artActiveDate],[aevValue],[ArticleID],[Teaser],[Title],[SubHeadline],[Body],[Author])  
	SELECT top 100 artActiveDate,   
	'',  
	artArticleID,  
	artDescription,  
	artTitle,  
	cast(cats.catName as varchar),  
	case when artDescription = '' or artDescription is null then cast(artBody as varchar(max)) else cast(artDescription as varchar(max)) + '<br /><br />' + cast(artBody as varchar(max)) end,  
	dbo.FormDate(artActiveDate, 'dd MMMM yyyy')  
	FROM [SQL-CMS].[CMS].[dbo].[Articles] art  
	 INNER JOIN [SQL-CMS].[CMS].[dbo].[Issues] iss ON art.artIssueId = iss.issIssueId  
	 INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat on art.artArticleID = cat.acArticleID  
	 INNER JOIN [SQL-CMS].[CMS].[dbo].[Categories] cats on cat.acCategoryID = cats.catCategoryID                
	WHERE   
	iss.issPublicationId = 656
	AND artActive = 1  
	AND iss.issActive = 1 
	AND cats.catCategoryID = 17118
	AND artActiveDate > getdate() - 10  
	ORDER BY artActiveDate desc 
END 

--MB - China Steel Insight
else IF @SectionID in (8062)
BEGIN
	INSERT INTO #stArts ([artActiveDate],[aevValue],[ArticleID],[Teaser],[Title],[SubHeadline],[Body],[Author])  
	SELECT top 2 artActiveDate,   
	'',  
	artArticleID,  
	artDescription,  
	artTitle,  
	cast(cats.catName as varchar),  
	case when artDescription = '' or artDescription is null then cast(artBody as varchar(max)) else cast(artDescription as varchar(max)) + '<br /><br />' + cast(artBody as varchar(max)) end,  
	dbo.FormDate(artActiveDate, 'dd MMMM yyyy')  
	FROM [SQL-CMS].[CMS].[dbo].[Articles] art  
	 INNER JOIN [SQL-CMS].[CMS].[dbo].[Issues] iss ON art.artIssueId = iss.issIssueId  
	 INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat on art.artArticleID = cat.acArticleID  
	 INNER JOIN [SQL-CMS].[CMS].[dbo].[Categories] cats on cat.acCategoryID = cats.catCategoryID                
	WHERE   
	iss.issPublicationId = 656
	AND artActive = 1  
	AND iss.issActive = 1 
	AND cats.catCategoryID = 17119
	AND artActiveDate > getdate() - 10  
	ORDER BY artActiveDate desc 
END 

---MB news alert
else IF @SectionID IN (7963, 7965, 7966, 7967)  
BEGIN  

	/*  
	15485 queue 1   
	15486 queue 2   
	17102 queue 3 
	17103 queue 4  
	*/  

	--DECLARE @SectionID int  
	--SET @SectionID = 6610  

	DECLARE @CatID int  
	IF @SectionID = 7963 SET @CatID = 15485
	IF @SectionID = 7965 SET @CatID = 15486  
	IF @SectionID = 7966 SET @CatID = 17102
	IF @SectionID = 7967 SET @CatID = 17103  

	INSERT INTO #stArts ([artActiveDate],[aevValue],[ArticleID],[Teaser],[Title],[SubHeadline],[Body],[Author])  
	SELECT top 100 artActiveDate,   
	'<br /><br /><br />' + stuff((Select 
				case when autEmailaddress is null or autEmailaddress = '' then
					autName + ', '
				else
					'<a href="mailto:' + autEmailaddress + '">' + autName + '</a>, '
				end
			from [SQL-CMS].[CMS].[dbo].Authors 
			Join [SQL-CMS].[CMS].[dbo].ArticleAuthors on aaAuthorID = autAuthorID 
			where aaArticleID = art.artArticleId
			FOR XML PATH(''), type).value('.', 'VARCHAR(MAX)'),
			1, 0, ''),  
	artArticleID,  
	artDescription,  
	artTitle,  
	cast(cats.catName as varchar),  
	case when artDescription = '' or artDescription is null then cast(artBody as varchar(max)) else cast(artDescription as varchar(max)) + '<br /><br />' + cast(artBody as varchar(max)) end
	,dbo.FormDate(artActiveDate, 'dd MMMM yyyy')
	FROM [SQL-CMS].[CMS].[dbo].[Articles] art  
				INNER JOIN [SQL-CMS].[CMS].[dbo].[Issues] iss ON art.artIssueId = iss.issIssueId  
				INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat on art.artArticleID = cat.acArticleID  
				INNER JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat2 on art.artArticleID = cat2.acArticleID   
				INNER JOIN [SQL-CMS].[CMS].[dbo].[Categories] cats on cat2.acCategoryID = cats.catCategoryID
	WHERE   
	iss.issIssueID in (@sfdIssue1,@sfdIssue2)  
	AND art.ArtActiveDate >= @dateNowST - @DaysPastNewsAlerts 
	AND artActive = 1  
	AND iss.issActive = 1      
	AND cats.catCategoryID = @CatID  
	AND artArticleID not in (select ArticleID from tbCampaignArticleAudit where sectionid = @SectionID)    
	ORDER BY artArticleID desc    
	
	update #stArts
	set [Body] = cast([Body] as varchar(max)) + substring(rtrim([aevValue]),1,len(rtrim([aevValue]))-1)
	where not [aevValue] is null
END

---MB steel price alerts
else IF @SectionID IN (7999, 7997, 7995, 7993, 7991, 7989, 7987, 7986, 7984, 7983, 7979, 7977, 7981, 7975, 7973, 7971,8082,8081,8083)  
	BEGIN
	DECLARE @alertCategoryID int

	set @alertCategoryID = CASE (@SectionID)
	  WHEN 7999 THEN 17187
      WHEN 7997 THEN 17188
      WHEN 7995 THEN 17189
      WHEN 7993 THEN 17190
      WHEN 7991 THEN 17191
      WHEN 7989 THEN 17192
      WHEN 7987 THEN 17193
      WHEN 7986 THEN 17194
      WHEN 7984 THEN 17195
      WHEN 7983 THEN 17196
      WHEN 7979 THEN 17197
      WHEN 7977 THEN 17198
      WHEN 7981 THEN 17199
      WHEN 7975 THEN 17200
      WHEN 7973 THEN 17201
      WHEN 7971 THEN 17202
	  WHEN 8082 THEN 17527 -- ALBA 
	  WHEN 8081 THEN 17526 -- HYDRO
	  WHEN 8083 THEN 17528 -- HYDRO			 
	END

	 SELECT TOP 1
		    ART.ARTARTICLEID AS 'ARTICLEID',
		    artDescription AS 'Teaser',
		    ART.ARTTITLE AS 'TITLE',
		    ARTSUBHEADLINE AS 'SUBHEADLINE',
		    ART.ARTACTIVEDATE AS 'ACTIVEDATE',
		    ART.artPictureSmall as 'ImageUrl',
		    art.artBody as 'Body'
		  FROM [SQL-CMS].cms.dbo.[Articles] AS art
		  JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat on art.artArticleID = cat.acArticleID
		  WHERE cat.acCategoryID = @alertCategoryID
		  AND artActive = 1
		  and ART.artActiveDate >= getdate() - 1
		  ORDER BY artActiveDate DESC
END
else if @SectionID = 8065
begin
	INSERT INTO #stArts ([artActiveDate],[aevValue],[ArticleID],[Teaser],[Title],[SubHeadline],[Body],[Author])  
	SELECT top 100 artActiveDate,   
	'<br /><br /><br />' + stuff((Select 
				case when autEmailaddress is null or autEmailaddress = '' then
					autName + ', '
				else
					'<a href="mailto:' + autEmailaddress + '">' + autName + '</a>, '
				end
			from [SQL-CMS].[CMS].[dbo].Authors 
			Join [SQL-CMS].[CMS].[dbo].ArticleAuthors on aaAuthorID = autAuthorID 
			where aaArticleID = art.artArticleId
			FOR XML PATH(''), type).value('.', 'VARCHAR(MAX)'),
			1, 0, ''),  
	artArticleID,  
	artDescription,  
	artTitle,  
	artSubheadline,  
	case when artDescription = '' or artDescription is null then cast(artBody as varchar(max)) else cast(artDescription as varchar(max)) + '<br /><br />' + cast(artBody as varchar(max)) end,
	dbo.FormDate(artActiveDate, 'dd MMMM yyyy')
	FROM [SQL-CMS].cms.dbo.[Articles] AS art
	JOIN [SQL-CMS].[CMS].[dbo].[ArticleCategories] cat on art.artArticleID = cat.acArticleID
	WHERE (cat.acCategoryID = 16942 or cat.acCategoryID = 17120) -- week in brief
	AND artActive = 1
	and ART.artActiveDate >= dateadd(d, -7, getdate())
	ORDER BY artActiveDate DESC

	update #stArts
	set [Body] = cast([Body] as varchar(max)) + substring(rtrim([aevValue]),1,len(rtrim([aevValue]))-1)
	where not [aevValue] is null
end

--Remove duplicates
delete from #stArts where staid not in (select max(staid) from #stArts group by articleid)

SELECT * FROM #stArts ORDER BY artActiveDate desc

DROP TABLE #stArts

end