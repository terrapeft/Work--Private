use NewCentralUsers

-- MBIOI
select uID, uUsername, uTitle, uForenames, uSurname, uJobTitle, sStartDate, sExpiryDate, sTrialExpiryDate, sUpdateDate, pShortName
from UserDetails ud
join Subscriptions s on s.sUID = ud.uID
join Publications p on s.sPID = p.pID
where uUsername like '%@vale.com'
and pid = 264
order by uUsername

-- Fastmarkets Platform
select uID, uUsername, uTitle, uForenames, uSurname, uJobTitle, sStartDate, sExpiryDate, sTrialExpiryDate, sUpdateDate, pShortName
from UserDetails ud
join Subscriptions s on s.sUID = ud.uID
join Publications p on s.sPID = p.pID
where uUsername like '%@vale.com'
and pid = 5047
order by uUsername



/*
select *
from Publications
where pName like '%fast%' or pShortName = 'MBIOI'
*/



