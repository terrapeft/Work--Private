use emailcampaign;
declare @startDate datetime = '2019-07-31'

--  PRINT 'STAGE 1 STARTING - ' + CONVERT(VARCHAR(20), GETDATE(),113)           
      -- Stage 1: Get 
            SET NOCOUNT ON
            SELECT --TOP 50
                        n.NewsletterId,
                        n.PubId,
                        n.Name,
                        c.cIndex, 
                        c.cParentCampaignID,
                        c.cTitle, 
                        c.cDescription, 
                        c.cTimeStamp,     
                        c.cBusinessID,
                        s.sitSiteID,
                        s.sitname
            INTO  ##NewslettersTmp
            FROM  [EmailCampaign].[dbo].[C_Campaigns] c WITH (NOLOCK)
                        LEFT JOIN
                        [UK-SQL-04].Pubwiz.dbo.tbNewsletters n WITH (NOLOCK)
                              ON c.cParentCampaignID = n.EMSTemplateID
                        LEFT JOIN
                        [UK-SQL-01].CMS.dbo.Sites s WITH (NOLOCK)
                              ON n.SiteID = s.sitSiteId
            WHERE 
                        c.cTimeSent >= @startDate
                        AND         c.cParentCampaignID IS NOT NULL
                        AND s.sitname IS NOT NULL 
       
CREATE NONCLUSTERED INDEX [IX_NewslettersTmp_cIndex]
ON [##NewslettersTmp] ([cIndex])

    

--STAGE 1 B 

select distinct U.uUsername COLLATE Latin1_General_CI_AS as uUsername 
INTO ##subscribers 
from 
      [UK-SQL-02].NewCentralUsers.dbo.subscriptions S
inner join 
      [UK-SQL-02].NewCentralUsers.dbo.UserDetails U on S.sUID = U.uid
where
      S.sExpiryDate is not null
      and S.sExpiryDate > '1 December 2014'
      and (S.sStatus & 8) > 0

CREATE NONCLUSTERED INDEX [IX_subscribers_uUsername]
ON [##subscribers] ([uUsername])
 
--PRINT 'STAGE 2 STARTING - ' + CONVERT(VARCHAR(20), GETDATE(),113)           


      -- Stage 2: Get mail logs
            SELECT      m.CampaignID, m.mIndex, m.TimeSent, m.EmailAddress, m.Undeliverable, m.Unsubscribed, m.ReturnedMailReason 
            INTO  ##MailingListTemp         
            FROM EmailCampaign_Archive.dbo.C_MailingList_Main m WITH (NOLOCK)
                INNER JOIN 
                        ##NewslettersTmp n
                            ON n.cIndex = m.CampaignID    
                INNER JOIN 
                        ##subscribers s 
                            ON m.EmailAddress = s.uUsername
			where m.EmailAddress not like '%fastmarkets.com'
				and m.EmailAddress not like '%amm.com'
				and m.EmailAddress not like '%indmin.com'
				and m.EmailAddress not like '%euromoneyplc.com'
				and m.EmailAddress not like '%metalbulletin%'
 
--  PRINT 'STAGE 3 STARTING - ' + CONVERT(VARCHAR(20), GETDATE(),113)           
            
      -- Stage 3: Get email opened records                  
            SELECT      o.vlIndex,
                        o.vlDateTime,
                        o.vlCID,
                        o.vlEmail,
                        ROW_NUMBER() OVER (PARTITION BY o.vlEmail, o.vlCID ORDER BY o.vlDateTime ASC) AS rn
            INTO  ##OpenLogsTemp
            FROM  EmailCampaign_Archive.dbo.C_OpenLog o WITH (NOLOCK)
                        INNER JOIN
                        ##MailingListTemp m
                              ON o.vlMIndex = m.mIndex
--STAGE 3 ENDING - 30 Mar 2015 17:55:02
                        
  --PRINT 'STAGE 4 STARTING - ' + CONVERT(VARCHAR(20), GETDATE(),113)           
            
      -- Stage 4: Get link click records
            SELECT      
                        l.hIndex,
                        l.hmIndex,
                        l.hLinkID,
                        l.hCampaignID,
                        l.hURL,
                        l.hDate,
                        l.hEMAF,
                        ROW_NUMBER() OVER (PARTITION BY l.hmIndex ORDER BY l.hDate ASC) AS rn
            INTO  ##ClickLogsTemp
            FROM  EmailCampaign_Archive.dbo.C_LinksHitsLog l WITH (NOLOCK)
                        INNER JOIN
                        ##MailingListTemp m
                              ON l.hmIndex = m.mIndex
      
  -- PRINT 'STAGE 5 STARTING - ' + CONVERT(VARCHAR(20), GETDATE(),113)           
     
      -- Stage 5: Merge data  
      drop table if exists dbo.ExportData
      CREATE TABLE dbo.ExportData(NewsletterId int, Pubwiz_PubId int, Pubwiz_PubName varchar(255), Pubwiz_PubShortName varchar(50),
                                  NewsletterName varchar(50), SiteID int, SiteName varchar(200), CampaignID int, BusinessId int, Newsletter varchar(200),
                                  TimeSent varchar(50), EmailAddress varchar(150), mIndex int,
                                  Undeliverable int, Unsubscribed int, ReturnedMailReason varchar(250),
                                  FirstOpenDate datetime NULL, FirstLinkClickDate datetime NULL);
      
            INSERT INTO dbo.ExportData
            SELECT      DISTINCT
                        n.NewsletterId,
                        n.PubId,
                        p.pubName,
                        p.pubShortName,
                        n.Name,
                        n.sitSiteID,
                        n.sitName,
                        m.CampaignID,
                        n.cBusinessId,
                        n.cTitle as Newsletter,
                        ISNULL(CAST(m.TimeSent as varchar(50)), 'Not sent') as DateSent,
                        m.EmailAddress,
                        m.mIndex,
                        m.Undeliverable,
                        m.Unsubscribed,
                        m.ReturnedMailReason,
                        NULL as FirstOpenDate,
                        NULL as FirstLinkClickDate
            FROM        ##NewslettersTmp n
                        INNER JOIN              
                        ##MailingListTemp m ON n.cIndex = m.CampaignID
                        INNER JOIN
                        EmailCampaign.dbo.C_Business b WITH (NOLOCK)
                              ON n.cBusinessID = b.bIndex
                        left join [UK-SQL-04].Pubwiz.dbo.Publications p on n.PubId = p.pubPublicationID

  --PRINT 'STAGE 6 STARTING - ' + CONVERT(VARCHAR(20), GETDATE(),113)           

      -- Stage 6: Set email first open date     
            UPDATE      e
            SET         e.FirstOpenDate = o.vlDateTime
            FROM  dbo.ExportData e
                        INNER JOIN
                        ##OpenLogsTemp o
                              ON e.CampaignID = o.vlCID
                              AND e.EmailAddress = o.vlEmail
            WHERE o.rn = 1
            
  --PRINT 'STAGE 7 STARTING - ' + CONVERT(VARCHAR(20), GETDATE(),113)           

      -- Stage 7: Set first link click
            UPDATE      e
            SET         e.FirstLinkClickDate = c.hDate
            FROM  dbo.ExportData e
                        INNER JOIN
                        ##ClickLogsTemp c
                              ON e.CampaignID = c.hCampaignID
                              AND e.mIndex = c.hmIndex
            WHERE c.rn = 1
      
                        
   --PRINT 'STAGE 9 STARTING - ' + CONVERT(VARCHAR(20), GETDATE(),113)           
                       
      -- Stage 9: Clean up    
            
            DROP TABLE ##NewslettersTmp
            DROP TABLE ##MailingListTemp        
            DROP TABLE ##OpenLogsTemp
            DROP TABLE ##ClickLogsTemp
            DROP TABLE ##subscribers
            
            SET NOCOUNT OFF
  --PRINT 'TERMINATING - ' + CONVERT(VARCHAR(20), GETDATE(),113)           
