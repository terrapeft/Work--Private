use EmailCampaign

declare @startDate datetime = '2020-10-31'

truncate table EmailCampaign.dbo.t1051
/*
drop table EmailCampaign.dbo.t1051 
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
*/

;with addr_l1 as (
        select u.userid, username, cc.companyname, max(datetimecreated) as datetimecreated
        from [SQL-NBO].[BackOffice].[Logon].[Users] u
        join [SQL-NBO].Backoffice.Customer.UserContactAddress ua on u.userid = ua.userId
        join [SQL-NBO].Backoffice.Customer.Company cc on ua.companyid = cc.CompanyId
        where islockedout = 0 and usertypeid = 0
        group by u.userid, username, cc.companyname
),
addr as (
        select row_number() over (partition by userid order by datetimecreated desc) as rn, userid, username, companyname, datetimecreated
        from addr_l1
)

insert into EmailCampaign..t1051 (MIndex, CampaignID, Email, FullName, Forename, Surname, Company_in_EMS, Company_in_NCU, Company_in_Backoffice, UserID, UserIDSource)
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
        from C_Business b 
            join C_Campaigns c on b.bIndex = c.cBusinessID
            join EmailCampaign_Archive..C_Mailinglist ml on ml.CampaignID = c.cIndex
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
        from C_Business b 
            join C_Campaigns c on b.bIndex = c.cBusinessID
            join C_Mailinglist ml on ml.CampaignID = c.cIndex
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
--order by list.Email


