use NewCentralUsers;

declare @stID int;
declare @pubId int = 5029;


update [ProductCatalogue]
set pcDescription = 'IFLR - Midas'
where pcPID = @pubId

update SubDefinitions
set sdDescription = 'IFLR - Midas Registration' -- currently it's 'IFLR Events Registration'
where sdOCID = (select top 1 ocId from ordercodes where ocpcid = (
							select top 1 pcid from productcatalogue where pcPID = @pubId))

update [NewCentralUsers].[dbo].[Statuses]
set stName = 'Trial'
where stPID = @pubId

insert into [NewCentralUsers].[dbo].[Statuses]
(stPID, stName, stMask, stCheckSession, stCheckGUID)
values
(@pubId, 'Subscription', 4 ,0 ,0)



/*---------------------------*/

--declare @pubId int = 5029;

select edgGroupId as 'EdenGroupId', edgText, edgPublicationID
from edengroup 
where edgpublicationid = @pubId

select pcid as 'ProductCatalogueId'
from productcatalogue 
where pcPID = @pubId

select scId as 'SourceCodeId', scDefinition, scEclipseID, scDescription
from SourceCodes
where scPCID = (select top 1 pcid from productcatalogue where pcPID = @pubId)

select sdId as 'SubdefinitionId', sdDescription
from SubDefinitions
where sdOCID = (select top 1 ocId from ordercodes where ocpcid = (select top 1 pcid from productcatalogue where pcPID = @pubId))

select ocId as 'OrderCodeId', ocDefinition
from ordercodes
where ocpcid = (select top 1 pcid from productcatalogue where pcPID = @pubId)

select stID as 'StatusId', stPid, stName, stMask
from Statuses
where stPID = @pubId

select nNewsletterId as 'NewsletterId', nIndex, nPublication
from Newsletters
where nPublication = @pubId



