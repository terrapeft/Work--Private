use backoffice

exec [dbo].[BO_sp_AutoArchiving]

declare 
	@gdprContactId int,
	@gdprEmailAddressId int


select @gdprContactId = ContactId 
from customer.contact 
where forenames = 'GDPR Replacement' 
and surname = 'GDPR Replacement' 
and titleid = 0 
and genderid = 0 
and initials is null

select @gdprEmailAddressId = emailaddressid
from Customer.EmailAddress
where emailaddress = 'GDPR Replacement' 

select count(distinct u.userid)
from logon.users u
join logon.UserSummary us on u.UserId = us.UserId
join customer.usercontactaddress ca on u.UserId = ca.UserId
left join backoffice.logon.userdefaultcommunication udc on u.userid = udc.userid
left join backoffice.Customer.ActiveUserContactAddress ac on udc.ActiveUserContactAddressId = ac.ActiveUserContactAddressId
where u.UserTypeId = 11
	and ca.contactid = @gdprContactId
	and ca.emailaddressid = @gdprEmailaddressId


select *
from logon.users u
join logon.UserSummary us on u.UserId = us.UserId
join customer.usercontactaddress ca on u.UserId = ca.UserId
left join backoffice.logon.userdefaultcommunication udc on u.userid = udc.userid
left join backoffice.Customer.ActiveUserContactAddress ac on udc.ActiveUserContactAddressId = ac.ActiveUserContactAddressId
where u.UserTypeId = 11
	and ca.contactid = @gdprContactId
	and ca.emailaddressid = @gdprEmailaddressId
