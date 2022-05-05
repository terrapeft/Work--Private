declare @pubId int = 223

select 'Publications:', pid, pname, purl
from publications
where pid = @pubId

select 'Product Catalogue:', pcid, pcpid, pcDescription
from ProductCatalogue
where pcPID = @pubId

select 'Orders code: ', ocID, ocPCID, ocDefinition
from OrderCodes
where ocPCID in (
	select pcid 
	from ProductCatalogue 
	where pcPID = @pubId
)

select 'SubDefenitions: ', sdId, sdOCID, sdDescription, sdSubLength 
from SubDefinitions
where sdOCID in (
	select ocID
	from OrderCodes
	where ocPCID in (
		select pcid 
		from ProductCatalogue 
		where pcPID = @pubId
	)
)

select 'Source code:', scId, scPCID, scPublications
from SourceCodes
where scPCID  in (
	select pcid 
	from ProductCatalogue 
	where pcPID = @pubId
) 