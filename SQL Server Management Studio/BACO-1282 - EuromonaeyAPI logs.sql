use euromoneyapi

select *
from ConsumerHistory h 
join ConsumerInfo c on h.ConsumerID = c.ConsumerID
where created between dateadd(month, -1, getdate()) and getdate()
order by created desc


select c.ConsumerId, c.CompanyName, count(c.Consumerid) as Count
from ConsumerHistory h 
join ConsumerInfo c on h.ConsumerID = c.ConsumerID
--join ConsumerMethodExecutionPrivileges p on c.ConsumerID = p.ConsumerID
--join Methods m on p.MethodId = m.MethodId
where created between dateadd(month, -1, getdate()) and getdate()
group by c.ConsumerId, c.CompanyName
order by c.CompanyName


