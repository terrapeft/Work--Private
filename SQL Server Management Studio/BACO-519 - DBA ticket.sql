use NewCentralUsers;

declare @stID int;
declare @pubId int = 5029;
 
update [ProductCatalogue]
set pcDescription = 'IFLR - Midas'
where pcPID = @pubId

update [Publications]
set pName = 'IFLR - Midas'
where pid = @pubId

update SubDefinitions
set sdDescription = 'IFLR - Midas Registration' -- currently it's 'IFLR Events Registration'
where sdOCID = (select top 1 ocId from ordercodes where ocpcid = (
                            select top 1 pcid from productcatalogue where pcPID = @pubId))
 
update [NewCentralUsers].[dbo].[Statuses]
set stName = 'Trial',
	stMask = 2
where stPID = @pubId

insert into [NewCentralUsers].[dbo].[Statuses]
(stPID, stName, stMask, stCheckSession, stCheckGUID)
values
(@pubId, 'Subscription', 4 ,0 ,0)

