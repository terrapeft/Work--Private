	use backoffice

	---- история изменений при апдейте имени через АМ
	select distinct top 10 u.userid, ac.ActiveUserContactAddressId, a.contactid, uca.usercontactaddressid, a.*
	from backoffice.customer.contact a
	join backoffice.customer.usercontactaddress uca on a.ContactId = uca.ContactId
	left join backoffice.Customer.ActiveUserContactAddress ac on uca.UserContactAddressId = ac.UserContactAddressId
	join backoffice.logon.users u on uca.userid = u.userid
	where u.userid in (5137517)
	order by ac.ActiveUserContactAddressId desc

	;with duplicated_emails (emailaddressid, cu) as (
		---- email адреса, которые используются многими юзерами
		select uca.emailaddressid, count(u.userid)
		from backoffice.customer.EmailAddress e
		join backoffice.customer.usercontactaddress uca on e.EmailAddressId = uca.EmailAddressId
		join backoffice.logon.users u on uca.userid = u.userid
		group by uca.emailaddressid
		having count(u.userid) > 1
	)
	---- юзера, которые пользуются одним мылом
	select e.*, u.userid, u.username
	from backoffice.customer.EmailAddress e
	join backoffice.customer.usercontactaddress uca on e.EmailAddressId = uca.EmailAddressId
	join backoffice.logon.users u on uca.userid = u.userid
	where e.EmailAddressId in (select emailaddressid from duplicated_emails)
	order by e.emailaddress





