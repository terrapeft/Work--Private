use backoffice

drop table if exists #gc_report
;with subscriptions as
(
	 SELECT
         su.SubscriptionUserId
		,su.UserId
        ,sub.SubscriptionId
		,sub.SubscriptionTypeId 
        ,sub.SubscriptionStartDateTime
        ,sub.SubscriptionEndDateTime
        ,prod.Name as ProductName
        ,prod.ProductID
		,prod.PrimaryProductOwnerID
        ,es.ReasonId as ExcludedReasonId
		,IsEndUserActive =
			CASE
				WHEN sue.SubscriptionUserId IS NULL THEN 1
				ELSE 0
			END
    FROM
        Orders.Subscription sub with (nolock)
    JOIN
        Logon.SubscriptionUser su with (nolock)
            ON  sub.SubscriptionId = su.SubscriptionId
    JOIN
        Product.Products prod with (nolock)
            ON sub.ProductID = prod.ProductID
			AND sub.ProductId in (
				select productid
				from Product.Products
				where name like 'Global Capital%' 
				and isactive = 1
			)
    LEFT JOIN
		Orders.ExcludedSubscription es with (nolock)
			ON sub.SubscriptionId = es.SubscriptionId
	LEFT JOIN
		Logon.SubscriptionUserExcluded sue
			ON su.SubscriptionUserId = sue.SubscriptionUserId
	where 	sub.SubscriptionTypeId = 3
			and sub.SubscriptionEndDateTime > getdate()
			--and sue.SubscriptionUserId IS NULL
),
newsletters as
(
	select 
		NewsletterAlertCategoryId,
		BackOfficeUserId,
		ActionType, 
		row_number() over (partition by NewsletterAlertCategoryId, BackOfficeUserId order by ActionDate desc) as rn
	from ProductNewsletterAlertCategoriesUser pnacui
)
select distinct UserName, pnac.NewsletterAlertId, pnac.Title, s.ProductName, s.ProductID
into #gc_report
from subscriptions s
	join ProductProductNewsletterAlerts ppna on s.ProductID = ppna.ProductID
	--join ProductNewsletterAlerts pna on ppna.NewsletterAlertId = pna.Id
	join ProductNewsletterAlertCategories pnac on ppna.NewsletterAlertId = pnac.NewsletterAlertId
	join newsletters n on pnac.Id = n.NewsletterAlertCategoryId and s.UserId = n.BackOfficeUserId
	join Logon.Users u on s.UserId = u.UserId
where n.rn = 1 and n.actiontype = 1 --and username = 'n.henin@eib.org'
order by UserName, pnac.NewsletterAlertId, pnac.Title

-- newsletters by user
select distinct UserName as Email, Title as Newsletter--, ProductName as Product
from #gc_report
order by UserName, Title--, ProductName

---- newsletters by user, aggregated
--select UserName, string_agg(cast(Title as nvarchar(max)), ', ')
--from #gc_report
--group by UserName
--order by UserName

-- users by newsletter			
select distinct Title as Newsletter, UserName as Email--, ProductName as Product
from #gc_report
--group by ProductName, Title, UserName
order by Title, UserName--, ProductName

---- users by newsletter, aggregated
--select Title, string_agg(cast(UserName as nvarchar(max)), ', ')
--from #gc_report
--group by Title
--order by Title
