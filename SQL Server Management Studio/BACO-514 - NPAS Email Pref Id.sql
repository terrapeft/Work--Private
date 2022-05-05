use backoffice

select top 1000 p.*
from dbo.productnewsletteralerts a 
join dbo.ProductNewsletterAlertCategories p on a.id = p.newsletteralertid
join dbo.ProductNewsletterAlertCategoriesUser pu on p.Id = pu.NewsletterAlertCategoryId
join Logon.Users u on u.UserId = pu.BackOfficeUserId
--where Title = 'IJGlobal Friday Editorial Newsletter'
where backofficeuserid = 5232655
order by actiondate desc


/*
select top 100 *
from dbo.productnewsletteralerts

select top 100 *
from dbo.productnewsletteralertcategories

select top 100 *
from dbo.productnewsletteralerts a join dbo.productnewsletteralertcategories c on a.id = c.newsletteralertid
*/



