/*
az01-sql-prd-01
*/
use CMS 

-- Articles

--select artArticleID, artIssueID, artTitle, artCreatedDate, artUpdateDate
select count(*)
from Articles
where artCreatedDate > dateadd(month, -1, getdate())
--order by [artUpdateDate] desc


-- Audit

select AudCompleteTime, AudChangeDescription, AudChangeDetail, usrEmail, usrForename, usrSurname, AActValue
--select count(*)
from [Audit] a
join AuditAction aa on a.audaactid = aa.aactid
join Users u on a.AudUserID = u.usrUserID
where AudCompleteTime > dateadd(month, -1, getdate())
order by AudCompleteTime desc


select usrEmail, usrForename, usrSurname
from [Audit] a
join AuditAction aa on a.audaactid = aa.aactid
join Users u on a.AudUserID = u.usrUserID
where AudCompleteTime > dateadd(month, -3, getdate())
group by usrEmail, usrForename, usrSurname






