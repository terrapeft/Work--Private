use BackOffice_Backup

/*
-- List broken emails
select distinct u.userid, u.usertypeid, u.username, ead.emailaddress, ead_b.emailaddress, ead.emailaddressid, ead_b.emailaddressid
--select count(distinct u.userid)
--select distinct cast (u.userid as nvarchar(20)) + ','
from [BackOffice].[Logon].[UserSummary] usr 
join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
join [Backoffice].[Customer].[UserContactAddress] uca on u.userid = uca.userid
join [Backoffice].[Customer].[EmailAddress] ead on uca.EmailAddressId = ead.EmailAddressId
join [Backoffice_Backup].[Customer].[EmailAddress] ead_b on ead.EmailAddressId = ead_b.EmailAddressId
where ead.emailaddress like 'Replaced in terms%'
and u.UserTypeId <> 11


-- List broken contacts
select distinct u.userid, u.usertypeid, u.username, c.surname, c_b.surname, c.forenames, c_b.forenames, c.Initials, c_b.Initials, c.ContactId, c_b.ContactId
--select count(distinct u.userid)
--select distinct cast (u.userid as nvarchar(20)) + ','
from [BackOffice].[Logon].[UserSummary] usr 
join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
join [Backoffice].[Customer].[UserContactAddress] uca on u.userid = uca.userid
join [Backoffice].[Customer].[Contact] c on uca.ContactId = c.ContactId
--join [Backoffice_Backup].[Customer].[Contact] c_b on c.ContactId = c_b.ContactId
where (c.Surname like 'Replaced in terms%' or c.Forenames like 'Replaced in terms%' or c.Initials like 'GDPR')
and u.UserTypeId <> 11


*/

begin try
	begin tran

	-- update emails
	update [Backoffice].[Customer].[EmailAddress]
	set  emailaddress = ead_b.emailaddress
	from [BackOffice].[Logon].[UserSummary] usr 
	join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
	join [Backoffice].[Customer].[UserContactAddress] uca on u.userid = uca.userid
	join [Backoffice].[Customer].[EmailAddress] ead on uca.EmailAddressId = ead.EmailAddressId
	join [Backoffice_Backup].[Customer].[EmailAddress] ead_b on ead.EmailAddressId = ead_b.EmailAddressId
	where ead.emailaddress like 'Replaced in terms%'
	and u.UserTypeId <> 11

	-- update contacts
	update [Backoffice].[Customer].[Contact]
	set  Surname = c_b.surname,
		 Forenames = c_b.forenames,
		 Initials = c_b.Initials
	from [BackOffice].[Logon].[UserSummary] usr 
	join [Backoffice].[Logon].[Users] u on usr.UserId = u.UserId
	join [Backoffice].[Customer].[UserContactAddress] uca on u.userid = uca.userid
	join [Backoffice].[Customer].[Contact] c on uca.ContactId = c.ContactId
	join [Backoffice_Backup].[Customer].[Contact] c_b on c.ContactId = c_b.ContactId
	where (c.Surname like 'Replaced in terms%' or c.Forenames like 'Replaced in terms%' or c.Initials like 'GDPR')
	and u.UserTypeId <> 11

	commit tran
end try
begin catch
	if @@trancount > 0
		rollback;
	throw
end catch
