select *
from [BackOffice].[dbo].[Countries]
where cid in (210, 13, 145, 23)
order by cname

select *
from [BackOffice].[Customer].[Country]
where countryid in (98, 129, 215)
order by country

select *
from [NewCentralUsers].[dbo].[Countries]
where cid in (210, 13, 145, 23)
order by cname