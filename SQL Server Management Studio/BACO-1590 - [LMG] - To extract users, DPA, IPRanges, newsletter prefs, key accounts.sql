use NewCentralUsers


/* Trialists, subscribers, site license subscriptions */

select top 100 *
	 --ud.uId, ud.uusername, ud.uTitle, ud.uforenames, ud.uSurname, ud.uCompany, ud.uJobtitle, ud.ucompanytype 
	--,ud.uindustry, ud.uEuromoneyPhone, ud.uEuromoneyFax, ud.uEuromoneyMail, ud.uEuromoneyEmail, ud.uThirdParty, ud.uHtmlEmail
	--,s.sID, s.sExpiryDate, s.sTrialExpiryDate, s.sTrialTerminatedDate, s.sPID
	--,r.iprIPRangeID, r.iprFromAddress, r.iprToAddress, r.iprCreatedDate
	,(case when cm.cmMasterSubID is not null then cm.cmActive else 0 end) as CapDonor
	--,string_agg(st.stName, ', ') as Statuses
-- select count_big(*)
from UserDetails ud
join Subscriptions s on ud.uID = s.sUID
join Publications p on p.pID = s.sPID
--join Statuses st on p.pID = st.stPID
left join IPRanges r on s.sid = r.iprSubscriptionID and r.iprActive = 1
left join CAPMaster cm on s.[sID] = cm.cmMasterSubID and cm.cmActive = 1
where	((s.sExpiryDate is not null and s.sExpiryDate > dateadd(year, -4, getdate())) or (s.sTrialExpiryDate is not null and s.sTrialExpiryDate > dateadd(year, -4, getdate())))
and		p.pID = 5023 /* LMG */
and		ud.uUsername not like 'Deactivated_%'
--and		s.sStatus & st.stMask = st.stMask
--group by ud.uId, ud.uusername, ud.uTitle, ud.uforenames, ud.uSurname, ud.uCompany, ud.uJobtitle, ud.ucompanytype 
--	,ud.uindustry, ud.uEuromoneyPhone, ud.uEuromoneyFax, ud.uEuromoneyMail, ud.uEuromoneyEmail, ud.uThirdParty, ud.uHtmlEmail
--	,s.sID, s.sExpiryDate, s.sTrialExpiryDate, s.sTrialTerminatedDate, s.sPID
--	,r.iprIPRangeID, r.iprFromAddress, r.iprToAddress, r.iprCreatedDate
--	,(case when cm.cmMasterSubID is not null then cm.cmActive else 0 end)
order by uUpdateDate desc


/* Newsletter preferences */
select top 100 pf.*
--select count(*)
from NewsletterEmailPreferences pf
join Publications p on p.pID = pf.nepPubCMSId
where nepPubCMSId in (5023, 5027, 5029)
and nepIsActive = 1
and nepUpdateDate >= dateadd(year, -4, getdate())
--order by nepEmail

;with users as (
    select distinct ud.uusername
    from [UK-SQL-02].[NewCentralUsers].[dbo].UserDetails ud
    join [UK-SQL-02].[NewCentralUsers].[dbo].Subscriptions s on ud.uID = s.sUID
    join [UK-SQL-02].[NewCentralUsers].[dbo].Publications p on p.pID = s.sPID
    where   ((s.sExpiryDate is not null and s.sExpiryDate > dateadd(year, -4, getdate())) or (s.sTrialExpiryDate is not null and s.sTrialExpiryDate > dateadd(year, -4, getdate())))
    and     p.pID = 1 /* LMG */
    and     ud.uUsername not like 'Deactivated_%'
)
select top 100 *
from NewsletterEmailPreferences nep
join users u on nep.nepEmail = u.uusername
join Publications p on nep.nepPubCMSId = p.pID









/* DPA */
;with users as (
    select distinct ud.uusername
    from [UK-SQL-02].[NewCentralUsers].[dbo].UserDetails ud
    join [UK-SQL-02].[NewCentralUsers].[dbo].Subscriptions s on ud.uID = s.sUID
    join [UK-SQL-02].[NewCentralUsers].[dbo].Publications p on p.pID = s.sPID
    where   ((s.sExpiryDate is not null and s.sExpiryDate > dateadd(year, -4, getdate())) or (s.sTrialExpiryDate is not null and s.sTrialExpiryDate > dateadd(year, -4, getdate())))
    and     p.pID = 1 /* LMG */
    and     ud.uUsername not like 'Deactivated_%'
)
select R.Email, R.Title, R.IsAccepted from
(
  select row_number() over (partition by u.UserID, c.Title order by a.LatestUpdate desc) as rownum, u.Email, c.Title, a.IsAccepted
  from [LegalCompliance].[dbo].[Acceptance] a
  join [LegalCompliance].[dbo].[User] u on a.UserID = u.UserID
  join [LegalCompliance].[dbo].[ContractVersion] cv on a.ContractVersionID = cv.ContractVersionID
  join [LegalCompliance].[dbo].[Contract] c on cv.ContractID = c.ContractID
  where u.Email collate DATABASE_DEFAULT in (select uusername collate DATABASE_DEFAULT from users)
) r
where r.rownum = 1


/* password hash */
;with users as (
    select distinct ud.uusername
    from [UK-SQL-02].[NewCentralUsers].[dbo].UserDetails ud
    join [UK-SQL-02].[NewCentralUsers].[dbo].Subscriptions s on ud.uID = s.sUID
    join [UK-SQL-02].[NewCentralUsers].[dbo].Publications p on p.pID = s.sPID
    where   ((s.sExpiryDate is not null and s.sExpiryDate > dateadd(year, -4, getdate())) or (s.sTrialExpiryDate is not null and s.sTrialExpiryDate > dateadd(year, -4, getdate())))
    and     p.pID = 1 /* LMG */
    and     ud.uUsername not like 'Deactivated_%'
)
select Username, HashedPassword
from [PD_RELEASE].[Titan].[dbo].[Identity] i
join users u on i.Username collate DATABASE_DEFAULT = u.uUsername collate DATABASE_DEFAULT






select *
from publications
where pid > 5000
-where pname like '%steel scrap%'






