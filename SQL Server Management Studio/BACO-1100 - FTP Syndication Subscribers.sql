use TheLibrary

select 
	 s.Name as Subscriber
	,p.Name as Publication
	,p.ShortName
	,case CMSVersion
		when 2 then 'ISIS'
		else 'CMS'
	 end as DataSource
	,FTPTarget
	,URL
	,s.IsActive as [Active Subscriber]
	,p.IsActive as [Active Publication]
	,ArchiveStartDate
--select *
from Subscriber s
join Subscription o on s.Subscriber_ID = o.Subscriber_ID
join Publication p on o.Publication_ID = p.Publication_ID
order by Subscriber, Publication, ShortName