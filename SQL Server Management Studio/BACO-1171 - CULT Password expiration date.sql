use Admin

/*
/****** Login Attempts  ******/
SELECT 
       l.UserID
	  ,u.Username
	  ,u.DisplayName
      ,l.[When]
      ,l.ActionID
	  ,la.AttemptDate
	  ,la.ToolID as LoginTo

	  ,a.Description
      ,l.Info
      ,ut.ToolName
	  ,CreateDate as PasswordCreated
FROM Admin.dbo.CULT_Log l
join Admin.dbo.ET_Users u on l.UserID = u.UserID
join Admin.dbo.LoginAttempt la on u.UserID = la.UserID
left join Admin.dbo.CULT_Actions a on l.ActionID = a.ActionID
left join Admin.dbo.ET_UsersPasswords p on l.UserID = p.UserId
left join Admin.dbo.UL2_Tools ut on ut.ToolID = l.ToolID
where l.[when] > '2021-01-18'
 and l.userid not in (4390, 3020)
 and ut.toolId = 98
order by l.[when] desc

*/


/*
/****** Password dates ******/
;with UsersPasswords as (
	select row_number() over(partition by userid order by CreateDate desc) as rowid, *
	from ET_UsersPasswords p
)
select DisplayName, CreateDate
from UsersPasswords p
join ET_Users u on p.UserId = u.UserID
where 
	u.UserID in (
		4167
       ,2446
       ,3086 
       ,3034 
       ,4126 
       ,2865 
       ,4174)
and rowid < 3
order by CreateDate desc

*/

/*
 76 - notification date
 90 - expiration date
*/
select p.userid, email, dateadd(dd, 76, cast(createdate as date)) as [notification date], dateadd(dd, 90, cast(createdate as date)) as [expiration date]
from et_UsersPasswords p join ET_Users u on p.UserId = u.UserID 
where isactive = 1
and dateadd(dd, 76, cast(createdate as date)) <= cast(getdate() as date)
and dateadd(dd, 85, cast(createdate as date)) >= cast(getdate() as date)
--and p.userid = 3034
order by createdate desc 
