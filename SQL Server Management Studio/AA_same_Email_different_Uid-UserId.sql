select *
from logon.users u
join logon.UserSummary s on u.userid = s.userid
where s.userid = 5003293


select top 1 * 
from newcentralusers.dbo.userdetails
where uusername = 'Grace_Li@cymer.com' 
	or uemailaddress = 'Grace_Li@cymer.com'
	or uid = 5003293


