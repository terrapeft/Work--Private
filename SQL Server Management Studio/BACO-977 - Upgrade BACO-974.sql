use newcentralusers

begin try

    begin transaction

	/*
		1. Add all expired opt ins from BO that are missed in NCU
	*/

	;with existing_users as
	(
		select distinct ud.uID
		from UserDetails ud 
		join Newsletters n on ud.uid = n.nuid
		where n.nNewsletterID = 613 and n.nPublication = 5029
	)

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 613, 0, 1
	from backoffice.dbo.vwNewsletterPublicationSubscribedUsersNonBreakingNews v
	join UserDetails ud on v.[Ins3] = ud.uid
	join Subscriptions s on ud.uID = s.sUID and s.sPID = 42
	left join existing_users eu on ud.uID = eu.uID
	where NewsletterAlertCategoryId = 172 and eu.uID is null


	/*
		2. Copy subscriptions from BO, even expired, for all subscribers.
		Without areas of interest.
	*/
	;with existing_subscriptions as
	(
		select distinct ud.uid
		from UserDetails ud 
		join Subscriptions s on ud.uID = s.sUID
		where s.sPID = 5029
	)

	insert into Subscriptions (suid, spid, sStartDate, sExpiryDate, sTrialExpiryDate, sTrialTerminatedDate, sMasterRecord, 
							sAllowedSessions, sNumberOfLogons, sNumberOfGUIDs, sStatus, sComments)
	select s.sUID, 5029, s.sStartDate, s.sExpiryDate, s.sTrialExpiryDate, s.sTrialTerminatedDate, s.sMasterRecord, 
							s.sAllowedSessions, s.sNumberOfLogons, s.sNumberOfGUIDs, s.sStatus, 'Migrating from Pubwiz, copy of subscription ' + cast(s.sid as varchar(15))
	from backoffice.dbo.vwNewsletterPublicationSubscribedUsersNonBreakingNews v
	join UserDetails ud on v.[Ins3] = ud.uid
	join Subscriptions s on ud.uID = s.sUID and s.sPID = 42
	left join existing_subscriptions es on ud.uID = es.uID
	where NewsletterAlertCategoryId = 172 and es.uID is null

	commit transaction;
end try
begin catch
	if (@@TRANCOUNT > 0)
		rollback
	;throw
end catch

