/****** Script for SelectTopNRows command from SSMS  ******/
  SELECT * -- 1065729
  FROM [BackOffice].[Product].[Products]
  where name like '%Global Capital: L13%'

    SELECT * -- 1034022
  FROM [BackOffice].[Product].[Products]
  where name like 'sovereign%'


  select * -- pubid 413
  from product.products pp join product.Site s on pp.ProductID = s.DefaultProductId
  where pp.ProductID in (1065764, 1065729)
  
  select * -- 
  from ProductProductNewsletterAlerts
  where productid in (1065764)

  select * -- 770 weekly, 900 daily
  from ProductNewsletterAlertCategories
  where NewsletterAlertId in (select newsletteralertid
  from ProductProductNewsletterAlerts
  where productid in (1065729))
  and NewsletterAlertId = 2640
  




