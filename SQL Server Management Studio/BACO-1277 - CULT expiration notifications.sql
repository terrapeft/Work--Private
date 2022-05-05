use Admin

/*
	Also see BACO-1171 [...].sql for some other details. 
*/

select p.userid, 
       email, 
       format(dateadd(dd, 76, cast(createdate as date)), 'dd-MM-yyyy') as [notification date],
       format(dateadd(dd, 90, cast(createdate as date)), 'dd-MM-yyyy') as [expiration date]
from et_UsersPasswords p join ET_Users u on p.UserId = u.UserID 
where year(createdate) = 2021
and email in ('agrimbert@fastmarkets.com', 'ben.fisher@fastmarkets.com', 'mpetrova@fastmarkets.com')
order by email asc, createdate desc 






