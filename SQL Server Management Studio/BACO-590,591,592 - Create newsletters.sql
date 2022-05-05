use newcentralusers

begin try

    begin transaction

	declare @psNewsletterId int, @mipNewsletterId int, @mipUsaNewsletterId int

	-- Patent Strategy	
	set @psNewsletterId = (select max(nlnNewsletterID) + 1 from NewsletterNames)
	print 'Patent Strategy nNewsletterId: ' + cast(@psNewsletterId as varchar(12))

	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (@psNewsletterId, 'Patent Strategy', 5027, 1, 1, 0)

	-- MIP Weekly
	set @mipNewsletterId = (select max(nNewsletterID) + 1 from Newsletters)
	print 'ManagingIP - Free Content Email Weekly nNewsletterId: ' + cast(@mipNewsletterId as varchar(12))

	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (@mipNewsletterId, 'ManagingIP - Free Content Email Weekly', 5027, 1, 1, 0)

	-- MIP Weekly USA
	set @mipUsaNewsletterId = (select max(nNewsletterID) + 1 from Newsletters)
	print 'ManagingIP - Free Content Email Weekly USA nNewsletterId: ' + cast(@mipUsaNewsletterId as varchar(12))

	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (@mipUsaNewsletterId, 'ManagingIP - Free Content Email Weekly USA', 5027, 1, 1, 0)

	--select @nlnId
	rollback
	
	commit transaction;
end try
begin catch
    declare @ERROR nvarchar(1000)
    select @ERROR = error_message()
    print @ERROR
    select ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage

    if @@trancount > 0
        rollback transaction;
end catch;