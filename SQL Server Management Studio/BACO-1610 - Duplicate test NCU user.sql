use NewCentralUsers

begin try 
	begin tran

	declare @userId int
	declare @email varchar(100), @name varchar(100)

	drop table if exists #new_users

	select * into #new_users from (values 
	('fusionTestUser6@euromoneyplc.com','Test6'),
	('fusionTestUser7@euromoneyplc.com','Test7'),
	('fusionTestUser8@euromoneyplc.com','Test8')
	) v (email, forename)

	while (select count(*) from #new_users) > 0
	begin
		set @email = (select top 1 email from #new_users)
		set @name = (select top 1 forename from #new_users)

		insert into UserDetails ([uEclipseCustomerID], [uUsername], [uPassword], [uOldPassword], [uEmailAddress], [uTitle], [uForenames], [uSurname], [uCompany], [uJobTitle], [uCompanyType], [uIndustry], [uRegisteredVia], [uEuromoneyPhone], [uEuromoneyFax], [uEuromoneyEmail], [uThirdParty], [uDPAConfirmed], [uCreationDate], [uCreatedBy], [uUpdateDate], [uUpdatedBy], [userid], [uComments], [GUID], [uAreasofInterest], [uHtmlEmail], [uUpdateComment], [uQuestion], [uOldusername], [uFreeIssueID], [uTestUser], [uHFIApproved], [uHFISubscriberID], [uDescription], [uEuromoneyMail])
		select [uEclipseCustomerID], @email, [uPassword], [uOldPassword], @email, [uTitle], @name, [uSurname], [uCompany], [uJobTitle], [uCompanyType], [uIndustry], [uRegisteredVia], [uEuromoneyPhone], [uEuromoneyFax], [uEuromoneyEmail], [uThirdParty], [uDPAConfirmed], getdate(), [uCreatedBy], getdate(), [uUpdatedBy], [userid], [uComments], newid(), [uAreasofInterest], [uHtmlEmail], [uUpdateComment], [uQuestion], [uOldusername], [uFreeIssueID], [uTestUser], [uHFIApproved], [uHFISubscriberID], [uDescription], [uEuromoneyMail]
		from UserDetails
		where uID = 3660575

		-- @@identity works, but NCU is an actively used database, there could be collisions
		-- scope_identity() and 'output into' clause return null and zero because of the triggers
		set @userId = (select top 1 uid from UserDetails where uUsername = @email)

		insert into Subscriptions ([sUID], [sPID], [sStartDate], [sExpiryDate], [sTrialExpiryDate], [sSubscriptionNumber], [sMasterRecord], [sAllowedSessions], [sNumberOfLogons], [sNumberOfGUIDs], [sStatus], [sCreationDate], [sCreatedBy], [sUpdateDate], [sUpdatedBy], [sAreasOfInterest], [sFirstLoggedOn], [sComments], [sQuestion], [sPendingPayment], [sIPOnly], [sAdditionalQuestions], [sCopyPaste], [sGUID], [sIPLogOnCheck], [sTrialTerminatedDate])
		select @userId, [sPID], [sStartDate], [sExpiryDate], [sTrialExpiryDate], [sSubscriptionNumber], [sMasterRecord], [sAllowedSessions], [sNumberOfLogons], [sNumberOfGUIDs], [sStatus], getdate(), [sCreatedBy], [sUpdateDate], [sUpdatedBy], [sAreasOfInterest], [sFirstLoggedOn], [sComments], [sQuestion], [sPendingPayment], [sIPOnly], [sAdditionalQuestions], [sCopyPaste], newid(), [sIPLogOnCheck], [sTrialTerminatedDate]
		from Subscriptions
		where sUID = 3660575

		insert into Addresses ([aUID], [aAncestorID], [aParentID], [aEclipseCode], [aJobTitle], [aCompany], [aAddress1], [aAddress2], [aAddress3], [aCity], [aCounty], [aState], [aPostCode], [aCID], [aTel], [aFax], [aMobTel], [aCreationDate], [aCreatedBy], [aUpdatedDate], [aUpdatedBy], [aActive], [aDefault], [aSessionID], [aUpdateReason])
		select @userId, [aAncestorID], [aParentID], [aEclipseCode], [aJobTitle], [aCompany], [aAddress1], [aAddress2], [aAddress3], [aCity], [aCounty], [aState], [aPostCode], [aCID], [aTel], [aFax], [aMobTel], getdate(), [aCreatedBy], getdate(), [aUpdatedBy], [aActive], [aDefault], [aSessionID], [aUpdateReason]
		from Addresses
		where aUID = 3660575

		delete top (1) from #new_users
	end

	commit transaction
	drop table if exists #new_users

end try
begin catch
    declare @error nvarchar(1000)
    select @error = error_message()
    print @error
    select error_number() AS ErrorNumber,
        error_severity() AS ErrorSeverity,
        error_state() AS ErrorState,
        error_procedure() AS ErrorProcedure,
        error_line() AS ErrorLine,
        error_message() AS ErrorMessage

    if @@trancount > 0
        rollback transaction;
end catch


/*

delete from Addresses
where auid in (3670376, 3670377, 3670378)

delete from Subscriptions
where suid in (3670376, 3670377, 3670378)

delete from userdetails 
where uid in (3670376, 3670377, 3670378)


select *
from UserDetails
where uid in (3670376, 3670377, 3670378)

select *
from Subscriptions
where sUID in (3670376, 3670377, 3670378)

select *
from Addresses
where aUID in (3670376, 3670377, 3670378)



select *
from userdetails
--where uusername = 'fusiontestuser5@euromoneyplc.com' or uusername = 'fusiontestuser6@euromoneyplc.com'
where guid = '0691e3b4-dc92-42dc-90af-5bc380f794ce'



/* No results for queries below */

select * 
from CAPMaster 
where cmMasterSubID in (
	select sID
	from Subscriptions
	where sUID = 3660575
)

select * 
from CAPMasterDonor
where cmdMasterSubID in (
	select sID
	from Subscriptions
	where sUID = 3660575
)
or cmdDonorSubID in (
	select sID
	from Subscriptions
	where sUID = 3660575
)
s
select *
from Newsletters
where nUID = 3660575

select *
from Orders
where oUID = 3660575

select *
from publications
where pid = 1


*/




