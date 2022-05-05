use LegalCompliance

declare @refId int, @containerId int, @contractId int, @commonTagId int, @TCTagId int, @siteId int


begin tran


	insert into Reference (Ref, Created, CreatedBy) values ('iilegalrequired', getdate(), 3020)
	
	insert into Container (Title, BodyCopy, Created, CreatedBy) values
	('Legal statements for II', '<p>We have made some changes to our Terms/Privacy Policy. Please read and tick to show you have understood before continuing.</p>
<p>
    If you wish to update your marketing preferences, then please visit our     
    <a href="https://content.marketingpreferences.euromoneyplc.com/preference_centre_global_euromoney.html" target="_blank">
        preference centre</a> to do so.
</p>
<p><a href="https://www.euromoneyplc.com/privacy-policy" target="_blank">Privacy Notice</a><br/>{$TermsConditions}</p>', getdate(), 3020)
	
	set @refId = (select top 1 referenceid from Reference where ref = 'iilegalrequired')
	set @containerId = (select top 1 containerId from Container where Title = 'Legal statements for II')
	set @contractId = (select top 1 contractId from Contract where ref = '{$TermsConditions}')
	set @commonTagId = (select top 1 tagId from Tag where name = 'common')
	set @TCTagId = (select top 1 tagId from Tag where name = 'termsandconditions')
	set @siteId = (select top 1 siteId from Site where siteUri = 'http://www.institutionalinvestor.com')

	insert into ContainerContract (containerid, contractid, Created, CreatedBy) values
	(@containerId, @contractId, getdate(), 3020)

	insert into ContainerTagReference (TagID, ContainerID, ReferenceID, Created, CreatedBy) values
	(@commonTagId, @containerId, @refId, getdate(), 3020)

	insert into ContainerTagReference (TagID, ContainerID, ReferenceID, Created, CreatedBy) values
	(@TCTagId, @containerId, @refId, getdate(), 3020)

	insert into SiteContainer (SiteID, ContainerID, Created, CreatedBy) values
	(@siteId, @containerId, getdate(), 3020)

rollback

