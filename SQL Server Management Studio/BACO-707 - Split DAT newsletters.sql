use NewCentralUsers

declare @newsletterId int
set @newsletterId = (select max(nlnNewsletterID) + 1 from NewsletterNames)

select @newsletterId

begin try
	begin tran

	-- copy Tax Newsletter into ITR Round-up
	insert into [NewCentralUsers].[dbo].[NewsletterNames] (nlnNewsletterID, nlnName, nlnPubID, nlnDescription, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	select @newsletterId, 'ITR Round-up', nlnPubID, nlnDescription, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews
	FROM [NewCentralUsers].[dbo].[NewsletterNames]
	where nlnNewsletterID = 909

	-- copy users
	insert into [NewCentralUsers].[dbo].[Newsletters] (nPublication, nUID, nNewsletterID, nPlain, nHTML, nUpdated)
	select nPublication, nUID, @newsletterId, nPlain, nHTML, nUpdated
	from [NewCentralUsers].[dbo].[Newsletters]
	where [nNewsletterID] = 909

	commit
end try
begin catch
	if (@@TRANCOUNT > 0)
		rollback
	;throw
end catch