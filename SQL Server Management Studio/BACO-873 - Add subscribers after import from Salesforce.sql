use newcentralusers

begin try

    begin transaction

	-- this will delete current subscriptions to avoid duplicates,
	-- they will be re-created with the script below
	delete from newsletters
	where nPublication = 5029 and nNewsletterID in (606, 607, 608, 609, 614)

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 606, 0, 1
	from UserDetails ud
	join Subscriptions s
	on ud.uID = s.sUID
	where sPID = 5029

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 607, 0, 1
	from UserDetails ud
	join Subscriptions s
	on ud.uID = s.sUID
	where sPID = 5029

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 608, 0, 1
	from UserDetails ud
	join Subscriptions s
	on ud.uID = s.sUID
	where sPID = 5029

	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5029, ud.uID, 609, 0, 1
	from UserDetails ud
	join Subscriptions s
	on ud.uID = s.sUID
	where sPID = 5029

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