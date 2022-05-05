use NewCentralUsers

/* The nice one */
/*
select l.alId as ID, l.alFinishedAtUtc as [Date], l.alUsersCount as [User Count], n.adName as [Database]
from [NewCentralUsers].[dbo].[AutoArchiving_Log] l
left join [NewCentralUsers].[dbo].[AutoArchiving_DbNames] n on l.alDatabaseId = n.adId
*/

/* The tech one */

declare @date datetime = dateadd(day, -1, getutcdate()) 

select l.alId, l.alStartedAtUtc, l.alFinishedAtUtc, l.alUsersCount, l.alProgressPercent, l.alHasErrors, n.adName
from [NewCentralUsers].[dbo].[AutoArchiving_Log] l
left join [NewCentralUsers].[dbo].[AutoArchiving_DbNames] n on l.alDatabaseId = n.adId
--where alFinishedAtUtc > @date
--order by alFinishedAtUtc asc

select top 100 *
from [NewCentralUsers].[dbo].[AutoArchiving_Errors] e
join (
	select top 5 l.alId
	from [NewCentralUsers].[dbo].[AutoArchiving_Log] l
	left join [NewCentralUsers].[dbo].[AutoArchiving_DbNames] n on l.alDatabaseId = n.adId
	where alFinishedAtUtc > @date
	order by alFinishedAtUtc desc

) l on e.aeAlId = l.alId
order by alid desc

