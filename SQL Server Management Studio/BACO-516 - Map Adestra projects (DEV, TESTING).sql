use NewCentralUsers

declare @newsletterId int
declare @nlname varchar(50) = 'BACO-tickets - Adestra Test'
set @newsletterId = 666

select @newsletterId

begin try
	begin tran

	-- copy Tax Newsletter into ITR Round-up
	insert into [NewCentralUsers].[dbo].[NewsletterNames] (nlnNewsletterID, nlnName, nlnPubID, nlnDescription, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	select @newsletterId, @nlname, nlnPubID, nlnDescription, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews
	FROM [NewCentralUsers].[dbo].[NewsletterNames]
	where nlnNewsletterID = 909

	-- copy users
	insert into [NewCentralUsers].[dbo].[Newsletters] (nPublication, nUID, nNewsletterID, nPlain, nHTML, nUpdated)
	select top 1006 5023, nUID, @newsletterId, nPlain, nHTML, nUpdated
	from [NewCentralUsers].[dbo].[Newsletters]
	where [nNewsletterID] = 909

	commit
end try
begin catch
	if (@@TRANCOUNT > 0)
		rollback
	;throw
end catch

select distinct top 5  d.uusername
from [NewCentralUsers].[dbo].[Newsletters] n
join [NewCentralUsers].[dbo].Userdetails d on n.nuid = d.uid
join (
		select uusername
		from (values ('hbanck@citco.com'), ('siclarke@deloitte.co.uk')) v (uusername)
	) adestra on d.uusername = adestra.uusername
where [nNewsletterID] = 909


