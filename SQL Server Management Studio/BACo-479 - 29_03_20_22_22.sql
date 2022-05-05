with last_valid as (
	select distinct u.userid
		,max(a.ContactId) as contactid
		,max(uca.UserContactAddressId) as UserContactAddressId
		,max(ac.ActiveUserContactAddressId) as ActiveUserContactAddressId
	from backoffice_backup.customer.contact a
	join backoffice_backup.customer.usercontactaddress uca on a.ContactId = uca.ContactId
	join backoffice_backup.Customer.ActiveUserContactAddress ac on uca.UserContactAddressId = ac.UserContactAddressId
	join backoffice_backup.logon.users u on uca.userid = u.userid
	where u.userid in (3005787)
	group by u.userid
),

current_valid as (
	select distinct u.userid
		,max(a.ContactId) as contactid
		,max(uca.UserContactAddressId) as UserContactAddressId
		,max(ac.ActiveUserContactAddressId) as ActiveUserContactAddressId
	from backoffice.customer.contact a
	join backoffice.customer.usercontactaddress uca on a.ContactId = uca.ContactId
	join backoffice.Customer.ActiveUserContactAddress ac on uca.UserContactAddressId = ac.UserContactAddressId
	join backoffice.logon.users u on uca.userid = u.userid
	where u.userid in (3005787)

	group by u.userid
)

---- список юзеров по группам в бэкапе
--select distinct lv.contactid, lv.userid, a.titleid, a.genderid, a.forenames, a.surname, a.Initials
--from last_valid lv
--join backoffice_backup.customer.contact a on lv.ContactId = a.ContactId
--join backoffice_backup.customer.usercontactaddress uca on lv.UserContactAddressId = uca.UserContactAddressId
--group by lv.contactid, lv.userid, a.titleid, a.genderid, a.forenames, a.surname, a.Initials
--order by lv.contactid, lv.userid

---- список юзеров по группам сейчас
--select distinct lv.contactid, lv.userid, a.titleid, a.genderid, a.forenames, a.surname, a.Initials
--from current_valid lv
--join backoffice.customer.contact a on lv.ContactId = a.ContactId
--join backoffice.customer.usercontactaddress uca on lv.UserContactAddressId = uca.UserContactAddressId
--group by lv.contactid, lv.userid, a.titleid, a.genderid, a.forenames, a.surname, a.Initials
--order by lv.contactid, lv.userid

---- список юзеров по группам сейчас c replace
--select distinct lv.contactid, lv.userid, a.titleid, a.genderid, a.forenames, a.surname, a.Initials
--from current_valid lv
--join backoffice.customer.contact a on lv.ContactId = a.ContactId
--join backoffice.customer.usercontactaddress uca on lv.UserContactAddressId = uca.UserContactAddressId
--where forenames like 'Replaced in terms of the GDPR compliance%'
--group by lv.contactid, lv.userid, a.titleid, a.genderid, a.forenames, a.surname, a.Initials
--order by lv.contactid, lv.userid

---- соединяем до и после
select 
	lv.UserId, u.username,
	lv.usercontactaddressid, lc.*,
	cv.usercontactaddressid, cc.*
from last_valid lv 
join current_valid cv on lv.userid = cv.userid
join backoffice.customer.contact cc on cv.contactid = cc.contactid
join backoffice_backup.customer.contact lc on lv.contactid = lc.contactid
join backoffice.logon.users u on cv.userid = u.userid





--select distinct u.userid
--	,max(a.ContactId) as contactid
--	,max(uca.UserContactAddressId) as UserContactAddressId
--	,max(ac.ActiveUserContactAddressId) as ActiveUserContactAddressId
--from backoffice.customer.contact a
--join backoffice.customer.usercontactaddress uca on a.ContactId = uca.ContactId
--join backoffice.Customer.ActiveUserContactAddress ac on uca.UserContactAddressId = ac.UserContactAddressId
--join backoffice.logon.users u on uca.userid = u.userid
--where u.userid = 5030603
--group by u.userid
