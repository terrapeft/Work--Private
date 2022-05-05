
drop table if exists #contacts_map
drop table if exists #errors

create table #errors (
	userid int,
	ucaid int,
	aucaid int,
	udcid int,
	line int
)

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
			a.forenames like 'Replaced in terms of the GDPR compliance%'
		or
			a.surname like 'Replaced in terms of the GDPR compliance%'
		or
			a.initials like 'GDPR'
	)
	and u.UserTypeId <> 11
)

select 
	 u.UserId
	,u.username
	,cc.ContactId
	,cc.TitleId
	,cc.Forenames
	,cc.Surname
	,cc.Initials
	,cc.GenderId
	,cv.UserContactAddressId
	,cv.ActiveUserContactAddressId
		
into #contacts_map
from current_valid cv
join backoffice.customer.contact cc on cv.contactid = cc.contactid
join backoffice.logon.users u on cv.userid = u.userid


--select * from #contacts_map order by userid

declare @count int = 0

while exists (select * from #contacts_map)
begin
	declare 
		@UserId int = null, 
		@username nvarchar(1024) = null

	declare 
		@usercontactaddressid int = null,
		@activeusercontactaddressid int = null,
		@ContactId int = null,
		@TitleId int = null,
		@Forenames nvarchar(1024) = null,
		@Surname nvarchar(1024) = null,
		@Initials nvarchar(256) = null,
		@GenderId int = null

	declare 
		@bckContactId int = null,
		@bckusercontactaddressid int = null,
		@bckactiveusercontactaddressid int = null,
		@bckTitleId int = null,
		@bckForenames nvarchar(1024) = null,
		@bckSurname nvarchar(1024) = null,
		@bckInitials nvarchar(256) = null,
		@bckGenderId int = null

	-- get user with current information
	select top 1 
		@userid = userid, 
		@username = username,
		@usercontactaddressid = usercontactaddressid,
		@activeusercontactaddressid = activeusercontactaddressid,
		--@TitleId = TitleId,
		--@Forenames = Forenames,
		--@Surname = Surname,
		--@Initials = Initials,
		--@GenderId = GenderId,
		@ContactId = ContactId
	from #contacts_map
	
	--select @userid, @username, @usercontactaddressid, @activeusercontactaddressid, @ContactId as ContactId


	-- search for backup values by contact id
	select 		
		@bckTitleId = TitleId,
		@bckForenames = Forenames,
		@bckSurname = Surname,
		@bckInitials = Initials,
		@bckGenderId = GenderId,
		@bckContactId = ContactId
	from BackOffice_Backup.Customer.Contact
	where ContactId = @ContactId

	--select @bckTitleId, @bckForenames, @bckSurname, @bckInitials, @bckGenderId

	set @ContactId = null
	set @TitleId = null
	set @Forenames = null
	set @Surname = null
	set @Initials = null
	set @GenderId = null

	-- search for current contact id by backup values
	select 
		@ContactId = ContactId,
		@TitleId = TitleId,
		@Forenames = Forenames,
		@Surname = Surname,
		@Initials = Initials,
		@GenderId = GenderId
	from BackOffice.Customer.Contact
	where 		
		TitleId = isnull(@bckTitleId, -1) and
		Forenames = isnull(@bckForenames, '') and
		Surname = isnull(@bckSurname, '') and
		((Initials = @bckInitials) OR (ISNULL(Initials, @bckInitials) IS NULL)) and
		GenderId = isnull(@bckGenderId, -1)

	--select @ContactId, @bckContactId

	-- Normal case, contact already exists
	if (@ContactId is not null and @bckContactId is not null)
	begin
		set @count = @count + 1
		declare @ucaid int

		begin try
			begin tran

			insert into backoffice.customer.usercontactaddress (
				UserId, AddressId, ContactId, EmailAddressId, AddressTypeId, CompanyId, JobTitleId, ParentUserContactAddressId, DateTimeCreated, CreatorUserId, CreatorCultUserId, ApplicationId, ReasonId
			)
			select UserId, AddressId, @ContactId, EmailAddressId, AddressTypeId, CompanyId, JobTitleId, ParentUserContactAddressId, getutcdate(),CreatorUserId, CreatorCultUserId, ApplicationId, ReasonId
			from backoffice.customer.usercontactaddress
			where usercontactaddressid = @usercontactaddressid

			set @ucaid = @@IDENTITY

			update BackOffice.Customer.ActiveUserContactAddress
			set UserContactAddressId = @ucaid
			where activeusercontactaddressid = @activeusercontactaddressid

			update BackOffice.Logon.UserDefaultCommunication
			set ContactId = @ContactId,
				ActiveUserContactAddressId = @activeusercontactaddressid
			where 
				userid = @UserId

			commit
		end try
		begin catch
			if @@TRANCOUNT > 0
				rollback
			insert into #errors (	userid, 	ucaid, 	aucaid, 	line) values
				(@userid, @ucaid, @activeusercontactaddressid, error_line())
			;throw
		end catch


	end


	delete top(1) from #contacts_map
end
