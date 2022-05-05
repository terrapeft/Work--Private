/*
 *
 *  NPAS-4396
 *
 */



/*

-- test before run/after rollback

select count(*) as [EdenCode Count]
from edencode

select * 
from EdenCode
where edcCode in ('1560', '1561', '1562', '1563', '1564', '1565', 
	'6732', '6733', '6734', '6735', '6736', '6737', '6738', '6739', '6740', '6741', '6742', '6743',
	'9614', '9615', '9616', '9617', '9618', '9619', '9620', '9621', '9622', '9623', '9624', '9625')

select count(*)  as [EdenGroup Count] 
from edengroup

select *
from EdenGroup e 
where edgPublicationID = 5027

select count (*)  as [EdenGroupCodes Count]
from [NewCentralUsers].[dbo].[EdenGroupCodes]
where egcCodeId IN (select edcCodeID from [NewCentralUsers].[dbo].[EdenCode] 
where edccode in ( '1560', '1561', '1562', '1563', '1564', '1565', 
		'6732', '6733', '6734', '6735', '6736', '6737', '6738', '6739', '6740', '6741', '6742', '6743',
		'9614', '9615', '9616', '9617', '9618', '9619', '9620', '9621', '9622', '9623', '9624', '9625'))

*/

USE [NewCentralUsers]

BEGIN TRY
	BEGIN TRANSACTION

		declare @output table (ID int)
		declare @id int

		-- ===============================================
		/*
			1. Update existing EDEN code, there is no corresponding publication.

			select e.edgPublicationId, ec.edcCode, p.pName
			from 
				EdenGroup e join 
				Publications p on e.edgPublicationid = p.pid join 
				EdenGroupCodes c on e.edgGroupId = c.egcGroupId join 
				EdenCode ec on c.egcCodeId = ec.edcCodeId
			where edcCode in ('1560')
		*/
		-- ===============================================
		update [NewCentralUsers].[dbo].[EdenCode]
		set edcName = 'LMG law firm'
		where edcCode = '1560'

		print 'Updated: 1560 set to LMG law firm'

		-- ===============================================
		--    2. Insert missing EDEN codes
		-- ===============================================
		if not exists (select 1 from [NewCentralUsers].[dbo].[EdenCode] where edccode in ( '1561', '1562', '1563', '1564', '1565', 
			'6732', '6733', '6734', '6735', '6736', '6737', '6738', '6739', '6740', '6741', '6742', '6743',
			'9614', '9615', '9616', '9617', '9618', '9619', '9620', '9621', '9622', '9623', '9624', '9625'))
		begin
			insert into [NewCentralUsers].[dbo].[EdenCode] (edcName, edcCode)
			values	('LMG in-house', '6732'),
					('LMG Partner', '6733'),
					('LMG associate', '6734'),
					('LMG of counsel', '6735'),
					('LMG private practice', '6736'),
					('LMG marketing & BD', '6737'),
					('LMG Tax adviser', '6738'),
					('LMG Tax executive', '6739'),
					('LMG Tax director', '6740'),
					('LMG Diversity', '6741'),
					('LMG Intellectual Property', '6742'),
					('LMG Banking & Finance', '6743'),
					('LMG corporate', '1561'),
					('LMG Regtech', '1562'),
					('LMG tax', '1563'),
					('LMG financial institution', '1564'),
					('LMG bank', '1565'),
					('LMG Patents', '9614'),
					('LMG Copyright', '9615'),
					('LMG Trademarks', '9616'),
					('LMG Litigation/dispute resolution', '9617'),
					('LMG corporate', '9618'),
					('LMG Transfer Pricing', '9619'),
					('LMG Tax', '9620'),
					('LMG capital markets', '9621'),
					('LMG M&A', '9622'),
					('LMG privacy/data protection', '9623'),
					('LMG competition', '9624'),
					('LMG Fintech', '9625')
		
			print 'Eden codes were inserted.'
		end
		else
			print 'Some or all Eden codes were found in the table, the step has been skipped.'

		-- ========================================================================
		--    Job Functions
		-- ========================================================================
		if not exists (select 1 from [NewCentralUsers].[dbo].[EdenGroup] where edgPublicationID = 5027 and edgText = 'Job Function') 
		begin
			insert into [NewCentralUsers].[dbo].[EdenGroup] (
				edgText,
				edgPublicationID,
				edgMultiple,
				edgIsPersistent,
				edgAnswerFormat,
				edgIsMandatory,
				edgPrefixID,
				edgHorizontalAlign)
			values (
				'Job Function',
				5027, -- Managing Intellectual Property - Site
				1,
				1,
				'dropdown',
				1,
				5,
				1)
			print 'Job Function edgGroupID: ' + CONVERT(VARCHAR, @id)
		end
		else
			print 'The Job Function for PublicationId = 5027 already exists, the step has been skipped.'


		set @id = (select top 1 edgGroupId 
					from [NewCentralUsers].[dbo].[EdenGroup] 
					where edgPublicationID = 5027 and edgText = 'Job Function' 
					order by edgGroupId desc)

		insert into [NewCentralUsers].[dbo].[EdenGroupCodes] (egcGroupID, egcCodeID)
		select @id as 'egcGroupID', edcCodeId as 'egcCodeID'
		from [NewCentralUsers].[dbo].[EdenCode]
		where edcCode IN ('6732', '6733', '6734', '6735', '6736', '6737', '6738', '6739', '6740', '6741', '6742', '6743')

	-- ========================================================================
	--    Company Types
	-- ========================================================================
		if not exists (select 1 from [NewCentralUsers].[dbo].[EdenGroup] where edgPublicationID = 5027 and edgText = 'Job Function') 
		begin
			insert into [NewCentralUsers].[dbo].[EdenGroup] (
				edgText,
				edgPublicationID,
				edgMultiple,
				edgIsPersistent,
				edgAnswerFormat,
				edgIsMandatory,
				edgPrefixID,
				edgHorizontalAlign)
			values (
				'Company Type',
				5027, -- Managing Intellectual Property - Site
				1,
				1,
				'dropdown',
				1,
				2,
				1)
			print 'Managing IP Company Type edgGroupID: ' + CONVERT(VARCHAR, @id)
		end
		else
			print 'The Company Type for PublicationId = 5027 already exists, the step has been skipped.'
		
		set @id = (select top 1 edgGroupId 
					from [NewCentralUsers].[dbo].[EdenGroup] 
					where edgPublicationID = 5027 and edgText = 'Company Type' 
					order by edgGroupId desc)

		insert into [NewCentralUsers].[dbo].[EdenGroupCodes] (egcGroupID, egcCodeID)
		select @id as 'egcGroupID', edcCodeId as 'egcCodeID'
		from [NewCentralUsers].[dbo].[EdenCode]
		where edcCode IN ('1560', '1561', '1562', '1563', '1564', '1565')

		print 'Company Type edgGroupID: ' + CONVERT(VARCHAR, @id)

	-- ========================================================================
	--    Interest Area
	-- ========================================================================
		if not exists (select 1 from [NewCentralUsers].[dbo].[EdenGroup] where edgPublicationID = 5027 and edgText = 'Areas of Interest') 
		begin
			insert into [NewCentralUsers].[dbo].[EdenGroup] (
				edgText,
				edgPublicationID,
				edgMultiple,
				edgIsPersistent,
				edgAnswerFormat,
				edgIsMandatory,
				edgPrefixID,
				edgHorizontalAlign)
			values (
			'Areas of Interest',
			5027, -- Managing Intellectual Property - Site
			1,
			1,
			'dropdown',
			1,
			1,
			1
			)
			print 'Managing IP Interest Area edgGroupID: ' + CONVERT(VARCHAR, @id)
		end
		else
			print 'The Interest Area for PublicationId = 5027 already exists, the step has been skipped.'

		set @id = (select top 1 edgGroupId 
			from [NewCentralUsers].[dbo].[EdenGroup] 
			where edgPublicationID = 5027 and edgText = 'Areas of Interest' 
			order by edgGroupId desc)


		insert into [NewCentralUsers].[dbo].[EdenGroupCodes] (egcGroupID, egcCodeID)
		select @id as 'egcGroupID', edcCodeId as 'egcCodeID'
		from [NewCentralUsers].[dbo].[EdenCode]
		where edcCode IN ('9614', '9615', '9616', '9617', '9618', '9619', '9620', '9621', '9622', '9623', '9624', '9625')

		print 'Areas of Interest edgGroupID: ' + CONVERT(VARCHAR, @id)

	COMMIT TRANSACTION;
END TRY

BEGIN CATCH
	DECLARE @error NVARCHAR(1000)
	SELECT @error = ERROR_MESSAGE()
	PRINT @error
	SELECT ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage

	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
END CATCH;