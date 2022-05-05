
/* Add IFLR-Midas publication to NCU-NBO replication */


-- this is for the trigger to add subscription to the stage table
insert into [NewCentralUsers].[dbo].[Repl_Publication]
select 5029, p.ProductID, 0
-- select *
from [BackOffice].[dbo].[ProductNewsletterAlertCategories] pnac
join [BackOffice].[dbo].[ProductProductNewsletterAlerts] ppna on pnac.NewsletterAlertId = ppna.NewsletterAlertId
join [BackOffice].[Product].[Products] p on ppna.ProductId = p.ProductId
where Id = 606 and ProfitCentreID = 482

update [NewCentralUsers].[dbo].[Repl_Publication] set
	Parent = 1
where ProductId = 1053894


-- this is for the SSIS package to process the subscription records from the stage table
insert into [BackOffice].[Interim].[Repl_NCUNBOProductMap]
select p.ProductID, 5029, 0
-- select *
from [BackOffice].[dbo].[ProductNewsletterAlertCategories] pnac
join [BackOffice].[dbo].[ProductProductNewsletterAlerts] ppna on pnac.NewsletterAlertId = ppna.NewsletterAlertId
join [BackOffice].[Product].[Products] p on ppna.ProductId = p.ProductId
where Id = 606 and ProfitCentreID = 482

update [BackOffice].[Interim].[Repl_NCUNBOProductMap] set
	Parent = 1
where ProductId = 1053894



/* Re-create subscription to place it in the queue */

delete from [NewCentralUsers].[dbo].[subscriptions] where suid = 5087841/*elizabeth.meager@legalmediagroup.com*/ and spid = 5029
exec [NewCentralUsers].[dbo].[subscriber] 5087841, 5029, '01 June 2020', '01 June 2021', '', 1, '4', 1, 1, 'Vitaly Chupaev','', 0, 0;


