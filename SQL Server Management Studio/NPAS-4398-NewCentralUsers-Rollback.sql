use NewCentralUsers

declare @pid int
declare @rateIds table (id int)

set @pid = (select pid from [NewCentralUsers].[dbo].[Publications] where pShortName = 'mipeventsmidas')

insert into @rateIds
select scRateID from [NewCentralUsers].[dbo].[SourceCodes] where scPCID in 
		(select pcID from [NewCentralUsers].[dbo].[ProductCatalogue] where pcPid = @pid)

-- SubDefinitions
delete from [NewCentralUsers]..[SubDefinitions] where sdDescription = 'MIP Free Access'

-- ProductCatalogue
delete from [NewCentralUsers].[dbo].[ProductCatalogue] where pcPID = @pid

-- OrderCodes
delete from [NewCentralUsers].[dbo].[OrderCodes] where ocPCID in 
	(select pcID from [NewCentralUsers].[dbo].[ProductCatalogue] where pcPid = @pid)

-- SourceCodes
delete from [NewCentralUsers].[dbo].[SourceCodes] where scPCID in 
	(select pcID from [NewCentralUsers].[dbo].[ProductCatalogue] where pcPid = @pid)

-- Rates
delete from [NewCentralUsers].[dbo].[Rates] where rateIndex in (select id from @rateIds)


-- Publications
delete from [NewCentralUsers].[dbo].[Publications] where pid = @pid