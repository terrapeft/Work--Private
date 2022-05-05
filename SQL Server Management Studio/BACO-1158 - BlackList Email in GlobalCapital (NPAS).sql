
/*

-- find products, which configures lw.com somehow

select *
from BackOffice.Product.Products 
where productId in (
    select publicationId
    from TrialManager.dbo.[Domain]
    where Name = 'lw.com'
)
and Name like '%Global Capital%'


*/


-- update products where 'Global Capital' is in name

update TrialManager.dbo.[Domain]
set 
	state = 1
where Name = 'lw.com'
and publicationid in (
    1061682,
    1065762,
    1065764,
    1065777
   
)

select *
from TrialManager.dbo.[Domain]
where Name = 'lw.com'
and publicationid in (
    1061682,
    1065762,
    1065764,
    1065777
    
)
