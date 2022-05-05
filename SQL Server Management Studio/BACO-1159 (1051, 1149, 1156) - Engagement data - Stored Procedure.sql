use EmailCampaign
go

create or alter procedure dbo.CollectEngagementData
	@startdate datetime
as

/*
	 Step 1 - Collect users
*/

drop table if exists EmailCampaign.dbo.t1051 

create table EmailCampaign.dbo.t1051 
(
    MIndex int,
    CampaignID int,
    Email varchar(250),
    FullName varchar(500),
    Forename varchar(500),
    Surname varchar(500),
    Company_in_EMS varchar(500),
    Company_in_NCU varchar(500),
    Company_in_Backoffice varchar(500),
    UserID int,
    UserIDSource varchar(25),
    --primary key(CampaignID, Email)
)

;with addr_l1 as (
        select u.userid, username, cc.companyname, max(datetimecreated) as datetimecreated
        from [SQL-NBO].BackOffice.Logon.Users u
        join [SQL-NBO].Backoffice.Customer.UserContactAddress ua on u.userid = ua.userId
        join [SQL-NBO].Backoffice.Customer.Company cc on ua.companyid = cc.CompanyId
        where islockedout = 0 and usertypeid = 0
        group by u.userid, username, cc.companyname
),
addr as (
        select row_number() over (partition by userid order by datetimecreated desc) as rn, userid, username, companyname, datetimecreated
        from addr_l1
)

insert into EmailCampaign.dbo.t1051 (MIndex, CampaignID, Email, FullName, Forename, Surname, Company_in_EMS, Company_in_NCU, Company_in_Backoffice, UserID, UserIDSource)
select distinct
     list.mIndex 
    ,list.CampaignID
    ,list.Email
    ,list.[FullName in EMS]
    ,ud.uForenames [Name In NCU]
    ,ud.uSurname [Surname In NCU]
    ,list.[Company in EMS]
    ,ud.uCompany [Company In NCU]
    ,addr.CompanyName [Company In Backoffice]
    ,case when try_cast(list.Ins3 as int) > 0 then list.Ins3
        else NULL
     end as [User ID]
    ,case 
        when try_cast(list.Ins3 as int) > 0 then 'EMS'
        else case
            when ud.uid is not null then 'NCU'
            else case 
                when us.userid is not null then 'Backoffice'
                else null
            end
        end
    end as [User ID Source]
from (
        select distinct
             ml.mIndex 
            ,ml.EmailAddress as [Email]
            ,ml.FullName [FullName in EMS]
            ,ml.Company [Company in EMS]
            ,ml.CampaignID
            ,ml.Ins3
        from EmailCampaign.dbo.C_Business b 
            join EmailCampaign.dbo.C_Campaigns c on b.bIndex = c.cBusinessID
            join EmailCampaign_Archive.dbo.C_Mailinglist ml on ml.CampaignID = c.cIndex
        where 
            ml.Undeliverable = 0
            and c.cSent = 1
            and c.cTimeSent > @startDate
            and b.bIndex  in (305, 310, 256, 309, 314, 304, 311, 302, 313, 380, 369, 385, 269, 308, 399, 381, 382, 383, 384, 370, 379, 197)
			and ml.EmailAddress not like '%fastmarkets.com'
			and ml.EmailAddress not like '%amm.com'
			and ml.EmailAddress not like '%indmin.com'
			and ml.EmailAddress not like '%euromoneyplc.com'
			and ml.EmailAddress not like '%metalbulletin%'
    
        union

        select distinct
                 ml.mIndex 
                ,ml.EmailAddress as [Email]
                ,ml.FullName [FullName in EMS]
                ,ml.Company [Company in EMS]
                ,ml.CampaignID
                ,ml.Ins3
        from EmailCampaign.dbo.C_Business b 
            join EmailCampaign.dbo.C_Campaigns c on b.bIndex = c.cBusinessID
            join EmailCampaign.dbo.C_Mailinglist ml on ml.CampaignID = c.cIndex
        where 
            ml.Undeliverable = 0
            and c.cSent = 1
            and c.cTimeSent > @startDate
            and b.bIndex  in (305, 310, 256, 309, 314, 304, 311, 302, 313, 380, 369, 385, 269, 308, 399, 381, 382, 383, 384, 370, 379, 197)
			and ml.EmailAddress not like '%fastmarkets.com'
			and ml.EmailAddress not like '%amm.com'
			and ml.EmailAddress not like '%indmin.com'
			and ml.EmailAddress not like '%euromoneyplc.com'
			and ml.EmailAddress not like '%metalbulletin%'
) list
left join [SQL-NBO].NewCentralUsers.dbo.UserDetails ud on ud.uEmailAddress collate database_default = list.Email collate database_default
left join [SQL-NBO].Backoffice.Logon.Users us on us.Username collate database_default = list.Email collate database_default
left join addr on us.UserId = addr.UserId and addr.rn = 1



/*
	 Step 2 - Collect data
*/

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

-- Stage 6: Set email first open date     
UPDATE      e
SET         e.FirstOpenDate = o.vlDateTime
FROM  dbo.ExportData e
            INNER JOIN
            ##OpenLogsTemp o
                    ON e.CampaignID = o.vlCID
                    AND e.EmailAddress = o.vlEmail
WHERE o.rn = 1
            
-- Stage 7: Set first link click
UPDATE      e
SET         e.FirstLinkClickDate = c.hDate
FROM  dbo.ExportData e
            INNER JOIN
            ##ClickLogsTemp c
                    ON e.CampaignID = c.hCampaignID
                    AND e.mIndex = c.hmIndex
WHERE c.rn = 1
      
                        
-- Stage 9: Clean up    
            
DROP TABLE ##NewslettersTmp
DROP TABLE ##MailingListTemp        
DROP TABLE ##OpenLogsTemp
DROP TABLE ##ClickLogsTemp
DROP TABLE ##subscribers
            
SET NOCOUNT OFF