-- control instruments for AA_NPAS

;with current_valid as (
	select distinct 
		u.userid, 
		udc.ActiveUserContactAddressId,
		udc.ContactId,
		ac.UserContactAddressId
	from backoffice.logon.users u
	join backoffice.logon.userdefaultcommunication udc on u.userid = udc.userid
	join backoffice.customer.contact a on udc.contactid = a.contactid
	join backoffice.Customer.ActiveUserContactAddress ac on udc.ActiveUserContactAddressId = ac.ActiveUserContactAddressId
	where 
	(
			a.initials like 'tsts'
	)
	and u.UserTypeId <> 11
)

select 
	 u.*
	,s.*
	,cc.ContactId
	,cc.TitleId
	,cc.Forenames
	,cc.Surname
	,cc.Initials
	,cc.GenderId
	,cv.UserContactAddressId
	,cv.ActiveUserContactAddressId
		
from current_valid cv
join backoffice.customer.contact cc on cv.contactid = cc.contactid
join backoffice.logon.users u on cv.userid = u.userid
join BackOffice.logon.UserSummary s on u.UserId = s.UserId
order by u.userid


/*
select *
from [NewCentralUsers].[dbo].[AutoArchiving_Log]

select top 100 *
from [NewCentralUsers].[dbo].[AutoArchiving_Errors]
where aealid = 11

*/

