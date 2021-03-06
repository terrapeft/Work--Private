use [PubWiz]

declare @StartDate as datetime = dateadd(month, -1, getdate())
declare	@EndDate as datetime = getdate()

;with cnt as
(
	select b.DisplayName, count(*) as ActionsCount
	from tbActions A 
		join [EUR05637-SQL2].[Admin].[dbo].ET_Users B ON B.UserID = A.UserID 
		left join tbActionTypes C ON C.TypeID = A.TypeID
		left join tbNewsletters D ON D.[NewsletterID] = A.NewsletterID
		left join tbSections E ON E.[SectionID] = A.SectionID
	where A.DateOccurred between @StartDate and @EndDate
	group by b.DisplayName
),
dist as 
(
	select distinct b.DisplayName, c.[Description]
	from tbActions A 
		join [EUR05637-SQL2].[Admin].[dbo].ET_Users B ON B.UserID = A.UserID 
		left join tbActionTypes C ON C.TypeID = A.TypeID
		left join tbNewsletters D ON D.[NewsletterID] = A.NewsletterID
		left join tbSections E ON E.[SectionID] = A.SectionID
	where A.DateOccurred between @StartDate and @EndDate
)

select cnt.DisplayName, cnt.ActionsCount, string_agg(cast(dist.[Description] as nvarchar(max)), ', ') 
from cnt join dist on cnt.DisplayName = dist.DisplayName
group by cnt.DisplayName, cnt.ActionsCount
order by cnt.DisplayName


select A.DateOccurred, b.DisplayName, c.[Description]
from tbActions A 
	join [EUR05637-SQL2].[Admin].[dbo].ET_Users B ON B.UserID = A.UserID 
	left join tbActionTypes C ON C.TypeID = A.TypeID
	left join tbNewsletters D ON D.[NewsletterID] = A.NewsletterID
	left join tbSections E ON E.[SectionID] = A.SectionID
where A.DateOccurred between @StartDate and @EndDate and displayname = 'Kyle Docherty'
order by A.DateOccurred desc