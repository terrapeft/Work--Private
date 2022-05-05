use newcentralusers

begin try

    begin transaction

	if exists (select 1 from newsletternames where nlnNewsletterId in (613))
	begin
		print 'Newsletter id is already used for other newsletter.'
		return
	end

	-- 1 --
	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (613, 'IFLR Weekly', 5029, 1, 1, 0)

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 613, 0, 1
	/*
		the part below is from the Pubwiz's datasource, except the expiration filter
		https://pubwizadmin.emazure.internal/NewsletterEdit.aspx?NewsletterID=211
	*/
	from backoffice.dbo.vwNewsletterPublicationSubscribedUsersNonBreakingNews v
	join UserDetails ud on v.[Ins3] = ud.uid
	join Subscriptions s on ud.uID = s.sUID and s.sPID = 42
	where NewsletterAlertCategoryId = 172
	and (sExpiryDate >= getdate() or sTrialExpiryDate >= getdate())


	commit transaction;
end try
begin catch
	if (@@TRANCOUNT > 0)
		rollback
	;throw
end catch