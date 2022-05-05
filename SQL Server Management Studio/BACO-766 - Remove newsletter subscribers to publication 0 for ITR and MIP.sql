use NewCentralUsers

begin try
	begin tran

	-- update zeroes
	update Newsletters set
		nPublication = 5023
	from [NewCentralUsers].[dbo].[Newsletters] n
	join (
		select distinct nNewsletterID
		from [NewCentralUsers].[dbo].[Newsletters]
		where nPublication in (5023)
	) ids on n.nNewsletterID = ids.nNewsletterID
	where nPublication = 0

	update Newsletters set
		nPublication = 5027
	from [NewCentralUsers].[dbo].[Newsletters] n
	join (
		select distinct nNewsletterID
		from [NewCentralUsers].[dbo].[Newsletters]
		where nPublication in (5027)
	) ids on n.nNewsletterID = ids.nNewsletterID
	where nPublication = 0


	-- remove duplicates
	delete x
	from (
	  select *, rn=row_number() over (partition by nuid, nnewsletterid order by ncreationdate desc)
	  from Newsletters 
	  where nPublication in (5027, 5023)
	) x
	where rn > 1 

	commit
end try
begin catch
	if (@@TRANCOUNT > 0)
		rollback
	;throw
end catch
