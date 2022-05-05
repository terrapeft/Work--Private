select *
from backoffice.logon.users u
join backoffice.logon.usersummary us on u.userid = us.userid
where u.username like '%Orrick%'
