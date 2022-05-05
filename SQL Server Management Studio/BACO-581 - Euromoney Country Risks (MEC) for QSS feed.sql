use NewCentralUsers

update NewCentralUsers.dbo.Publications
set pProfitCentre = 'MEM,MEL,MEC'
where pProfitCentre = 'MEM,MEL' and pId = 2

