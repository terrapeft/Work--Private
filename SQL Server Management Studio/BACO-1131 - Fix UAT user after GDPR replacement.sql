use NewCentralUsers

/*
	select ud.*
	from userdetails ud
	join Subscriptions s on s.suid = ud.uID
	where uid = 3524162
*/

update UserDetails set
	uUsername = uEmailAddress
where uid in ( 3524162 )