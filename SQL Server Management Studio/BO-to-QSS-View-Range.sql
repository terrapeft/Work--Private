/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Journal Code]
      ,[Email]
      ,[Order Date]
  FROM [NewCentralUsers].[dbo].[BO_to_QSS_View_Range]
  where cast([Order Date] as date) > cast('2018-08-31' as date) 
  and   cast([Order Date] as date) < cast('2018-10-01' as date)
  order by [order date]
  --where email in ('georgina.holland@hsbcib.com', 'samuele.premi@unicreditgroup.at')

  
  -- missed by dyas
  select email
  from [BO_To_QSS_VIEW_Range] 
  where left(convert(DateTime,[Order Date],102),11) in (convert(DateTime,'4-SEP-2018',102), convert(DateTime,'5-SEP-2018',102), convert(DateTime,'11-SEP-2018',102))
  order by [Journal Code],[Order Date], [EII Order Ref]

  -- missed by value
  select email, *
  from [BO_To_QSS_VIEW_Range] 
  where left(convert(DateTime,[Order Date],102),11) in (convert(DateTime,'10-SEP-2018',102))
  /*or email in (
    'amish@sqninvestors.com',
	  'Johanna.Diaz@gs.com', 'notaris@jnpllc.co', 'katherine.murray@cbre.com', 'georgina.holland@hsbcib.com', 'ricardo.senerman@sencorp.com', 'greg.bechtel@archesam.com'  )*/
  order by [Journal Code],[Order Date], [EII Order Ref]

  
  -- should not be missed
  select email, *
  from [BO_To_QSS_VIEW_Range] 
  where cast([Order Date] as date) > cast('2018-08-31' as date) 
  and   cast([Order Date] as date) < cast('2018-10-01' as date)
  order by [Journal Code],[Order Date]

  Select * from [BO_To_QSS_VIEW_Range] where left(convert(DateTime,[Order Date],102),11) = convert(DateTime,'5-Sep-2018',102)  
  order by [Journal Code],[Order Date], [EII Order Ref]

