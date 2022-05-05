select top 100 uusername, uCompany, uJobTitle, uCompanyType, uCreationDate, uCreatedBy
from userdetails ud
where uJobTitle is not null and uCompanyType is not null
and uCompanyType like '%institutional%'
order by uCreationDate desc

select uid, uusername, uforenames, uSurname, uCompany, uJobTitle, uCompanyType, uCreationDate, uCreatedBy
from userdetails
where uid = 3521161

select g.edgText, c.edcName
from EdenGroup g
join EdenGroupCodes gc on g.edgGroupID = gc.egcGroupID
join EdenCode c on gc.egcCodeID = c.edcCodeID
join EdenUser u on u.eduPubID = g.edgPublicationID and gc.egcCodeID = u.eduCodeID and gc.egcGroupID = u.eduGroupID
where u.eduuserid = 3521161
order by edgPublicationID

