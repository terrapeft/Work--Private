use TheLibrary

-- Overall with batches in 2020
/*
select distinct PublicationId, p.Name, ShortName, SubscriberID, s.Name
from Batches b 
	join Publication p on b.PublicationID = p.Publication_ID
	join Subscriber s on b.SubscriberId = s.Subscriber_ID
where BatchedDate > '2020-01-01'
*/

-- Active publications (with batches in 2020)
select distinct PublicationId, p.Name, ShortName, p.IsActive
from Batches b 
	join Publication p on b.PublicationID = p.Publication_ID
	join Subscriber s on b.SubscriberId = s.Subscriber_ID
where BatchedDate > '2020-01-01'
order by PublicationId

-- Active subscribers (with batches in 2020)
select distinct SubscriberID, s.Name
from Batches b 
	join Publication p on b.PublicationID = p.Publication_ID
	join Subscriber s on b.SubscriberId = s.Subscriber_ID
where BatchedDate > '2020-01-01'
order by SubscriberID 

-- Recent CMS articles
select distinct PublicationID, p.Name
from Articles a
	join Publication p on a.PublicationID = p.Publication_ID
where PublishDate > '2020-01-01' 
	and CMSArticleID <> 0
order by PublicationId

-- Recent ISIS articles
select distinct PublicationID, p.Name
from Articles a
	join Publication p on a.PublicationID = p.Publication_ID
where PublishDate > '2020-01-01' 
	and CMSArticleID = 0
order by PublicationId

-- count articles
select count(*)
from Articles a

select FORMAT(PublishDate, 'yyyy') as Year, count(*) as Count
from Articles a
--where PublishDate > '2016-01-01'
group by FORMAT(PublishDate, 'yyyy')
order by FORMAT(PublishDate, 'yyyy') desc


-- select number of articles per day for some publications
select FORMAT(PublishDate, 'yyyy-MM-dd') as Date, a.PublicationID, p.Name, count(*) as Count
from Articles a
	join Publication p on a.PublicationID = p.Publication_ID
where a.PublicationID in (69, 78, 88, 89, 90)
and PublishDate > '2020-01-01'
group by a.PublicationID, p.Name, FORMAT(PublishDate, 'yyyy-MM-dd')
order by FORMAT(PublishDate, 'yyyy-MM-dd'), a.PublicationID

-- overall number of articles for those publications
select a.PublicationID, p.Name, count(*) as Count
from Articles a
	join Publication p on a.PublicationID = p.Publication_ID
where a.PublicationID in (69, 78, 88, 89, 90)
and PublishDate > '2020-01-01'
group by a.PublicationID, p.Name
order by a.PublicationID

-- number of articles in 2020 for all publications
select a.PublicationID, p.Name, count(*) as Count, 
	(case when ceiling(sum(datalength(Body)/1048576.0)) > 0
		then concat(ceiling(sum(datalength(Body))/1048576.0), ' Mb')
		else concat(ceiling(sum(datalength(Body))/1024.0), ' Kb')
	end) as [Length]
from Articles a
	join Publication p on a.PublicationID = p.Publication_ID
--where PublishDate > '2020-12-31'
group by a.PublicationID, p.Name
order by a.PublicationID