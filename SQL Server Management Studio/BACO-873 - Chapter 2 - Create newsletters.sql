use newcentralusers

/*

	Newsletterids are taken the same as in NPAS
	use backoffice
	select *
	from ProductNewsletterAlertCategories c 
		join ProductNewsletterAlerts a on c.newsletteralertid = a.Id
	where a.id in (215,217,211)


	Id	NewsletterAlertId	Title
	606	215	Banking
	607	215	Capital markets
	608	215	Corporate
	609	215	Regulatory
	614	217	Monthly magazine

*/


begin try

    begin transaction

	if exists (select 1 from newsletternames where nlnNewsletterId in (606, 607, 608, 609, 614))
	begin
		print 'Newsletter ids are already used for other newsletters.'
		return
	end

	-- 1 --
	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (606, 'Banking', 5029, 1, 1, 0)

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 606, 0, 1
	from UserDetails ud
	join Subscriptions s
	on ud.uID = s.sUID
	where sPID = 5029


	-- 2 --
	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (607, 'Capital markets', 5029, 1, 1, 0)

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 607, 0, 1
	from UserDetails ud
	join Subscriptions s
	on ud.uID = s.sUID
	where sPID = 5029


	-- 3 --
	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (608, 'Corporate', 5029, 1, 1, 0)

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 608, 0, 1
	from UserDetails ud
	join Subscriptions s
	on ud.uID = s.sUID
	where sPID = 5029


	-- 4 --
	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (609, 'Regulatory', 5029, 1, 1, 0)

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 609, 0, 1
	from UserDetails ud
	join Subscriptions s
	on ud.uID = s.sUID
	where sPID = 5029


	-- 5 --
	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (614, 'Monthly magazine', 5029, 1, 1, 0)

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 614, 0, 1
	from UserDetails ud
	join Subscriptions s
	on ud.uID = s.sUID
	where sPID = 5029


	commit transaction;
end try
begin catch
	if (@@TRANCOUNT > 0)
		rollback
	;throw
end catch