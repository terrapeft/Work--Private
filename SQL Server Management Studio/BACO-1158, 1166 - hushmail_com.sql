use TrialManager

/*

select *
from TrialManager.dbo.[Domain] d
join BackOffice.Product.Products p on d.PublicationId = p.productId
where d.Name = 'hushmail.com' 
and p.Name like '%Global Capital%'

*/

update d
set state = 1
from TrialManager.dbo.[Domain] d
join BackOffice.Product.Products p on d.PublicationId = p.productId
where d.Name = 'hushmail.com' 
and p.Name like '%Global Capital%'