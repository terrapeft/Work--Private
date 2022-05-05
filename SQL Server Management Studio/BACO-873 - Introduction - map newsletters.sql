use backoffice

-- find newsletters in NPAS by name
select c.Id, NewsletterAlertId, c.Title
from ProductNewsletterAlertCategories c 
	join ProductNewsletterAlerts a on c.newsletteralertid = a.Id
where c.title in ('monthly magazine', 'capital markets', 'regulatory', 'corporate', 'banking')
and a.id in (215,217)

-- different products (here it became clear which are the iflr)
select *
from BackOffice.dbo.ProductProductNewsletterAlerts a
join BackOffice.Product.Products p on a.ProductId = p.ProductID
where NewsletterAlertId in (215, 217)

go

use NewCentralUsers

-- check if NPAS ids are taken in NCU
select * 
from newsletternames
where nlnNewsletterId in (606, 607, 608, 609, 614)

-- find the IFLR publication Id
select *
from publications
where pshortname like 'iflr' or pURL like '%iflr%'
