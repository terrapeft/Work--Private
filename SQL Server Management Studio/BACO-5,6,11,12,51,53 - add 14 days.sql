use [NewCentralUsers]

update  [NewCentralUsers].[dbo].[SubDefinitions]
set sdSubLength = 14
where 
	sdID in (
				64835 /*baco-12*/, 
				64834 /*baco-53*/, 
				64833 /*baco-51*/, 
				64832 /*baco-5*/,
				64831 /*baco-11*/,
				64830 /*baco-6*/
			) 
	and sdSubLength = 0

update  [NewCentralUsers].[dbo].[SubDefinitions]
set sdDescription = 'Industrial Minerals Events Registration'
where sdID = 64831
