use NewCentralUsers

declare @uid int, @sid int


/*

delete from subscriptions 
where suid in (
	select uid
	from userdetails
	where uusername in ('b275ea53b0be4a079cf2bc0be458e9a0@example.com', 'c72b0b6e76274db68f855399210ce706@example.com')
)

delete from userdetails
where uusername in ('b275ea53b0be4a079cf2bc0be458e9a0@example.com', 'c72b0b6e76274db68f855399210ce706@example.com')

*/

/*
	WIPO 
*/
insert into UserDetails (uUsername, uEmailAddress, uCompany, uCompanyType, uComments)
values 
	('c72b0b6e76274db68f855399210ce706@example.com', 'c72b0b6e76274db68f855399210ce706@example.com', 'World Intellectual Property Organization', 'Intellectual Property', 'BACO-697')

set @uid = @@identity

insert into Subscriptions (sUID, sPID, sStartDate, sExpiryDate, sStatus, sIPOnly)
values 
	(@uid, 5027, getdate(), dateadd(yy, 10, getdate()), 2, 1)



/* 
	Unimelb
*/
insert into UserDetails (uUsername, uEmailAddress, uCompany, uCompanyType, uComments)
values 
	('b275ea53b0be4a079cf2bc0be458e9a0@example.com', 'c72b0b6e76274db68f855399210ce706@example.com', 'University of Melbourne', 'Research University', 'BACO-697')

set @uid = @@identity

insert into Subscriptions (sUID, sPID, sStartDate, sExpiryDate, sStatus, sIPOnly)
values 
	(@uid, 5027, getdate(), dateadd(yy, 10, getdate()), 2, 1)


/*	

select * 
from subscriptions 
where suid in (
	select uid
	from userdetails
	where uusername in ('b275ea53b0be4a079cf2bc0be458e9a0@example.com', 'c72b0b6e76274db68f855399210ce706@example.com')
)

select * 
from userdetails
where uusername in ('b275ea53b0be4a079cf2bc0be458e9a0@example.com', 'c72b0b6e76274db68f855399210ce706@example.com')

*/



