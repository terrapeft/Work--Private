USE [PubWiz]
GO
/****** Object:  StoredProcedure [dbo].[UpdateMostReadPubwiz]    Script Date: 09/03/2021 19:58:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[UpdateMostReadPubwiz]
as
DECLARE @Tops TABLE
(
      tAmount           int,
      tArticleID  int,
      tTitle            nvarchar(1000),
      tPubID            int
)

 

DECLARE @PubID INT, @ActiveDate14 Datetime, @ActiveDate21 Datetime, @ActiveDate28 Datetime, @ActiveDate30 Datetime, @ActiveDate60 Datetime
SET @PubID = 538
SET @ActiveDate14 = GetDate() - 14
SET @ActiveDate21 = GetDate() - 21
SET @ActiveDate28 = GetDate() - 28
SET @ActiveDate30 = GetDate() - 30
SET @ActiveDate60 = GetDate() - 60

 

--IF EXISTS (SELECT 1 FROM PubWiz.dbo.tbNEwsletters WHERE PubID = @PubID)
--BEGIN
--            INSERT INTO @Tops (tAmount, tArticleID, tTitle, tPubID)
            
--            SELECT TOP 10 SUM(SummaryValue)
--            , ArticleID
--            , CMS.artTitle
--            , @PubID
--            FROM [EUR05637-BOATSQL1].BOATSummary.dbo.BOAT_Logging_DailyArticleActionSummary A
--            INNER JOIN [SQL-NCU].NewCentralUsers.dbo.Publications B ON A.pubID = B.pID
--            INNER JOIN PubWiz.dbo.tbBoatToCMS BTC on B.pID = BTC.BOATID
--            --LEFT OUTER JOIN PubWiz.dbo.tbNewsletters NL on B.pID = NL.PubID
--            LEFT OUTER JOIN [SQL-CMS].cms.dbo.articles CMS on A.articleid = CMS.artArticleID
--            WHERE SummaryDate > DateAdd(d, -2, GetDate())

 

--            AND artActiveDate > getdate() - 21
--            AND ArticleID <> 0 
--            AND BTC.CMSID = @PubID
--            AND a.[ActionID] = 2          
--            group by articleid,CMS.artTitle
--            order by 1 desc
--END

 

DECLARE @ListPubIDs TABLE
(
        lpID      INT IDENTITY(1,1)
      , lpPubID INT
)

 

INSERT INTO @ListPubIDs (lpPubID)
SELECT DISTINCT PubID 
FROM PubWiz.dbo.tbNEwsletters 
WHERE PubID is not null 
AND PubID <> '' 
AND PubID <> 0 
AND PubID IN (select CMSID from PubWiz..tbBoatToCMS)

 

 


DECLARE @i INT
SET @i = 1

 

WHILE (@i <= (SELECT MAX(lpID) FROM @ListPubIDs))
BEGIN
      SET @PubID = (SELECT lpPubID FROM @ListPubIDs WHERE lpID = @i)

 

      -- add for newsletter 

 

IF @PubID in (      538,569,598,563,562,613,572,610,614)
begin
      IF   @PubID in (538,569,598,563,562) -- DI,SI,REFI,FII,PI
       Begin     
         INSERT INTO @Tops (tAmount, tArticleID, tTitle, tPubID)
          
          SELECT TOP 5 SUM(SummaryValue)
          , ArticleID
          , CMS.artTitle
          , @PubID
          FROM [EUR05637-BOATSQL1].BOATSummary.dbo.BOAT_Logging_DailyArticleActionSummary A
          INNER JOIN [SQL-NCU].NewCentralUsers.dbo.Publications B ON A.pubID = B.pID
          INNER JOIN PubWiz.dbo.tbBoatToCMS BTC on B.pID = BTC.BOATID
          --LEFT OUTER JOIN PubWiz.dbo.tbNewsletters NL on B.pID = NL.PubID
          LEFT OUTER JOIN [SQL-CMS].cms.dbo.articles CMS on A.articleid = CMS.artArticleID
          INNER JOIN [SQL-CMS].cms.dbo.articlecategories AC on CMS.artArticleID = AC.acArticleID          
          WHERE SummaryDate > DateAdd(d, -30, GetDate())
          AND artActiveDate > @ActiveDate14 --getdate() - 14
          AND ArticleID <> 0 
          AND BTC.CMSID = @PubID
          AND a.[ActionID] = 2          
          group by articleid,CMS.artTitle
          order by 1 desc

 

          SET @i = @i + 1
       End
         
       IF   @PubID in (613,572) -- MMI,CI
           Begin     
         INSERT INTO @Tops (tAmount, tArticleID, tTitle, tPubID)
          
          SELECT TOP 5 SUM(SummaryValue)
          , ArticleID
          , CMS.artTitle
          , @PubID
          FROM [EUR05637-BOATSQL1].BOATSummary.dbo.BOAT_Logging_DailyArticleActionSummary A
          INNER JOIN [SQL-NCU].NewCentralUsers.dbo.Publications B ON A.pubID = B.pID
          INNER JOIN PubWiz.dbo.tbBoatToCMS BTC on B.pID = BTC.BOATID
          --LEFT OUTER JOIN PubWiz.dbo.tbNewsletters NL on B.pID = NL.PubID
          LEFT OUTER JOIN [SQL-CMS].cms.dbo.articles CMS on A.articleid = CMS.artArticleID
          INNER JOIN [SQL-CMS].cms.dbo.articlecategories AC on CMS.artArticleID = AC.acArticleID          
          WHERE SummaryDate > DateAdd(d, -30, GetDate())

 

          AND artActiveDate > @ActiveDate30 -- getdate() - 30
          AND ArticleID <> 0 
          AND BTC.CMSID = @PubID
          AND a.[ActionID] = 2          
          group by articleid,CMS.artTitle
          order by 1 desc

 

          SET @i = @i + 1
        End
       IF   @PubID in (610,614) --FEI,FDI
       Begin     
         INSERT INTO @Tops (tAmount, tArticleID, tTitle, tPubID)
          
          SELECT TOP 5 SUM(SummaryValue)
          , ArticleID
          , CMS.artTitle
          , @PubID
          FROM [EUR05637-BOATSQL1].BOATSummary.dbo.BOAT_Logging_DailyArticleActionSummary A
          INNER JOIN [SQL-NCU].NewCentralUsers.dbo.Publications B ON A.pubID = B.pID
          INNER JOIN PubWiz.dbo.tbBoatToCMS BTC on B.pID = BTC.BOATID
          --LEFT OUTER JOIN PubWiz.dbo.tbNewsletters NL on B.pID = NL.PubID
          LEFT OUTER JOIN [SQL-CMS].cms.dbo.articles CMS on A.articleid = CMS.artArticleID
          INNER JOIN [SQL-CMS].cms.dbo.articlecategories AC on CMS.artArticleID = AC.acArticleID          
          WHERE SummaryDate > DateAdd(d, -30, GetDate())

 

          AND artActiveDate > @ActiveDate60 -- getdate() - 60
          AND ArticleID <> 0 
          AND BTC.CMSID = @PubID
          AND a.[ActionID] = 2          
          group by articleid,CMS.artTitle
          order by 1 desc

 

          SET @i = @i + 1
       End
end

 

      ELSE
       Begin
          INSERT INTO @Tops (tAmount, tArticleID, tTitle, tPubID)
          
          SELECT TOP 10 SUM(SummaryValue)
          , ArticleID
          , CMS.artTitle
          , @PubID
          FROM [EUR05637-BOATSQL1].BOATSummary.dbo.BOAT_Logging_DailyArticleActionSummary A
          INNER JOIN [SQL-NCU].NewCentralUsers.dbo.Publications B ON A.pubID = B.pID
          INNER JOIN PubWiz.dbo.tbBoatToCMS BTC on B.pID = BTC.BOATID
          --LEFT OUTER JOIN PubWiz.dbo.tbNewsletters NL on B.pID = NL.PubID
          LEFT OUTER JOIN [SQL-CMS].cms.dbo.articles CMS on A.articleid = CMS.artArticleID
          INNER JOIN [SQL-CMS].cms.dbo.articlecategories AC on CMS.artArticleID = AC.acArticleID          
          WHERE SummaryDate > DateAdd(d, -2, GetDate())

 

          AND artActiveDate > @ActiveDate21 -- getdate() - 21
          AND ArticleID <> 0 
          AND BTC.CMSID = @PubID
          AND a.[ActionID] = 2          
          group by articleid,CMS.artTitle
          order by 1 desc

 

          SET @i = @i + 1
      END 
END

 

delete from PubWiz.dbo.tbTopReadStoriesByNewsletter

 

insert into PubWiz.dbo.tbTopReadStoriesByNewsletter (NewsletterID, Hits, ArticleID, Title)
select distinct a.NewsletterID, b.tAmount, b.tArticleID, b.tTitle
from Pubwiz.dbo.tbNewsletters a
INNER JOIN @tops b ON a.PubID = b.tPubID
order by NewsletterID asc, tAmount desc