USE [BackOffice]
GO
/****** Object:  StoredProcedure [FeedManager].[uspGetECommerceOfferExportData]    Script Date: 27-Dec-18 09:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [FeedManager].[uspGetECommerceOfferExportData]
(
  @FeedId int
) 
As
SET NOCOUNT ON;
-----------------------------------------------------------------------------
--	define local variables
-----------------------------------------------------------------------------
DECLARE
	--	Used to invoke RAISERROR
	 @ErrorMessage			NVARCHAR(4000)	--	holds the RAISERROR error message to be returned
	,@ErrorSeverity			INT				--	holds the severity the error is to be raised under
	,@ErrorProcedure		SYSNAME			--	holds the stored procedure/trigger name raising the error
	,@DatabaseId			SMALLINT		--	holds the database id from sys.databases
	,@ErrorLogId			INT				--	holds the pk of Error.ErrorLog table, for record added
	--	Logging
	,@ObjectName			SYSNAME			--	holds the name of the database object
	,@SchemaName			SYSNAME			--	holds the schema of the database object
	,@Now					DATETIME		--	holds the date and time the SP was called
	,@LogDuration			BIGINT			--	holds the duration of the SP call
	--	Variables
	,@uID					INT				--	holds the NcuUserId
	
BEGIN TRY
	-------------------------------------------------------------------------
	--	Record execution start time
	-------------------------------------------------------------------------
	EXEC Shared.uspGetVariableForObjectId
							 @@PROCID
							,@DatabaseId OUTPUT
							,@ObjectName OUTPUT
							,@SchemaName OUTPUT
							,@Now OUTPUT ;		
	 
	-------------------------------------------------------------------------
	--	Main block
	-------------------------------------------------------------------------
 DECLARE @xml_var XML   
 SET @xml_var =   
 ( 
	SELECT  
	 o.Id					as "OfferID",
	 o.Name					as "OfferName",
	 CASE ot.id	WHEN 1 THEN '3' -- These have to be mapped to the documentation	 
				WHEN 2 THEN '2' -- XML Offer overview, not ideal but EIB working against
				WHEN 3 THEN '1' -- this doc and any changes would cause delay 
				WHEN 5 THEN '5'
				WHEN 6 THEN '4'
				WHEN 7 THEN '6'
				WHEN 8 THEN '7'
				WHEN 9 THEN '8'												 
	 			END			as "OfferType",
	 o.StartDate			as "OfferStartDate",
	 o.EndDate				as "OfferEndDate",
	---- 
	"Limiters" = 
		(SELECT o.LimiterTypeId  as "LimiterType"	
		 where  o.LimiterTypeId = 0 	  
		 FOR XML PATH('OfferLimiter'), type), 
	---- 
	"Limiters" = 
		(SELECT o.LimiterTypeId  as "LimiterType",
				  o.LimiterValue   as "UsageLimiter"
		 where  o.LimiterTypeId = 1 	 
		 FOR XML PATH('OfferLimiter'), type), 
	---- 
	"Limiters" = 
		(SELECT o.LimiterTypeId  as "LimiterType",
				  olp.Value		    as "ValueLimiter",
				  c.IsoCode		    as "ValueLimiterCurrency"
		 from	       Offer.OfferLimiterPrices olp
		 inner  join Orders.Currency c on olp.CurrencyId = c.CurrencyId
		 where       o.LimiterTypeId = 2
		 and	       olp.OfferId = o.id 	 
		 FOR XML PATH('OfferLimiter'), type), 
	-------
	"Qualifications" = 
		(SELECT  CASE o.QualificationId 
					WHEN 1 THEN '1'
					 WHEN 2 THEN '2' 
					  WHEN 5 THEN '0' -- 5 should be 0 !!  is pending change in related BO enumeration					    
						END as "QualificationType" 
		 where   o.QualificationId in (5,1,2) 
		 FOR XML PATH('Qualification'), type), 
		------- 	
	"Qualifications" = 
		(SELECT  o.QualificationId    as "QualificationType",	
		         o.QualificationValue as "QualificationCode" 
		 where   o.QualificationId = 3
		 FOR XML PATH('Qualification'), type), 
		------- 	
	"Qualifications" = 
		(SELECT o.QualificationId  as "QualificationType",
		 	(SELECT qual.Email   as "User"	
		 	  from Offer.EmailQualifications qual
		 	  where qual.OfferId = o.id
			  and o.QualificationId = 4
			  FOR XML PATH(''), type) as "ValidUserList",
		 'This offer is only available to users who received the offer email. Sorry!' as "InvalidMessage"		
		 where   o.QualificationId = 4
		 FOR XML PATH('Qualification'), type), 
		------- 
			 
	  (SELECT   CASE ot.id	WHEN 1 THEN '3' -- These have to be mapped to the documentation	 
							WHEN 2 THEN '2' -- XML Offer overview, not ideal but EIB working against
							WHEN 3 THEN '1' -- this doc and any changes wold cause delay 
							WHEN 5 THEN '5'
							WHEN 6 THEN '4'
							WHEN 7 THEN '6'
							WHEN 8 THEN '7'
							WHEN 9 THEN '8'												 
	 						END	as "@type",			
					----------
					-- We need to pick nQuantity up correctly, when implemented this section will be removed
					CASE o.TypeId WHEN 1 THEN '1' 
									WHEN 2 THEN '2' 
									WHEN 3 THEN '3' 
									WHEN 4 THEN '1'
									WHEN 5 THEN '1'  
									END AS "nQuantity",
					CASE o.TypeId WHEN 2 THEN 'True'WHEN 3 THEN 'True' END AS "OrMoreFlag",
					CASE o.TypeId WHEN 5 THEN (select top 1 od.code 
												from    Offer.OfferDiscounts od 
												where   od.OfferId  = o.Id
												and     od.[Type] = 1)  END AS "QualificationCode",					
					CASE o.TypeId WHEN 6 THEN (select  top 1 od.code 
												from    Offer.OfferDiscounts od 
												where   od.OfferId  = o.Id
												and     od.[Type] = 2)  END AS "QualificationCode",					
					
								
					(select top 1 pu1.UniverseId as "@id", 				
								-----
						(select pu2.productid as [*]
			 			 from   Offer.ProductUniverses pu2	 
						 where  pu2.UniverseId  = pu1.UniverseId
						 and pu2.OfferId  = pu1.OfferId
						 FOR XML PATH('ProductID'), type)
								-----
							from   Offer.ProductUniverses pu1	 
							where  pu1.OfferId  = o.Id	
							and	  pu1.UniverseId = 0
							and	  o.TypeId  = 1
							FOR XML PATH('ProductList'), type) ,				    
							    ------
						-- We need to pick this second list up correctly when implemented
						-- for now we duplicate the first list   
					 (select top 1 (pu1.UniverseId + 1) as "@id",  				
						(select pu2.productid 	as [*]
			 			 from   Offer.ProductUniverses pu2	 
						 where  pu2.UniverseId  = pu1.UniverseId
						 and pu2.OfferId  = pu1.OfferId	 
						 FOR XML PATH('ProductID'), type)
								-----		 
					   from   Offer.ProductUniverses pu1	 
					   where  pu1.OfferId  = o.Id	
					   and    pu1.UniverseId = 0
					   and	  o.TypeId  = 1
						FOR XML PATH('ProductList'), type), 
								----------		 									    
					(select top 1 pu1.UniverseId as "@id", 				
												-----
								(select pu2.productid 	as [*]
					 			 from   Offer.ProductUniverses pu2	 
								 where  pu2.UniverseId  = pu1.UniverseId
								 and	  pu2.OfferId  = pu1.OfferId	 
								 FOR    XML PATH('ProductID'), type)
												-----
								       from   Offer.ProductUniverses pu1	 
								       where  pu1.OfferId  = o.Id	
								       and	  pu1.UniverseId = 0
									 	 and	  o.TypeId = 2
									    FOR    XML PATH('ProductList'), type),
									    ----------		
					(select top 1 pu1.UniverseId as "@id", 				
												-----
								(select pu2.productid 	as [*]
					 			 from   Offer.ProductUniverses pu2	 
								 where  pu2.UniverseId  = pu1.UniverseId
								 and pu2.OfferId  = pu1.OfferId	 
								 FOR XML PATH('ProductID'), type)
												-----
								       from   Offer.ProductUniverses pu1	 
								       where  pu1.OfferId  = o.Id	
								       and	  pu1.UniverseId in (0)
										 and	  o.TypeId = 3
									    FOR XML PATH('ProductList'), type),
									    -----------
					(select top 1 pu1.UniverseId as "@id", 				
												-----
								(select pu2.productid 	as [*]
					 			 from   Offer.ProductUniverses pu2	 
								 where  pu2.UniverseId  = pu1.UniverseId
								 and pu2.OfferId  = pu1.OfferId	 
								 FOR XML PATH('ProductID'), type)
												-----
								       from   Offer.ProductUniverses pu1	 
								       where  pu1.OfferId  = o.Id	
								       and	  pu1.UniverseId in (0)
										 and	  o.TypeId = 7
									    FOR XML PATH('ProductList'), type),
										---------
						
													    
					-------------------------
					-- Currently GUI Offer Renewal Linked Discount
					"PrimaryProductID" = (select rlop.FirstProductID 
												from   Offer.RenevalLinkedOfferProducts rlop	  
												where  rlop.OfferId  = o.Id),
												(select 'Primary' as "@Name",
													(select pg1.PriceGroupID 	as PriceID
 													 from Product.PriceGroups pg1 inner join Offer.RenevalLinkedOfferProducts rlop 
 													 on pg1.ProductID = rlop.FirstProductID 	
													 where  rlop.OfferId  = o.Id
														FOR XML PATH(''), type)
												where o.TypeId  = 8				
												FOR XML PATH('ValidPrices'), type),
					"SecondaryProductID" = (select rlop.SecondProductID 
												from   Offer.RenevalLinkedOfferProducts rlop	  
												where  rlop.OfferId  = o.Id),
												(select 'Secondary' as "@Name",
													(select pg1.PriceGroupID 	as PriceID
													 from Product.PriceGroups pg1 inner join Offer.RenevalLinkedOfferProducts rlop 
													 on pg1.ProductID = rlop.SecondProductID 	
													 where  rlop.OfferId  = o.Id 
														FOR XML PATH(''), type)
												where o.TypeId  = 8													
												FOR XML PATH('ValidPrices'), type),															
					-----------			    
					 "BasketList"= (Select  fdp.ProductId,
										     fdp.PriceGroupID as "PriceID"
							 					from    Offer.FixedBasketDiscountProducts  fdp	 
												where   fdp.OfferID = o.Id	
												and	    o.TypeId = 9 
												FOR XML PATH('Product'), type),
					-- Discount Node Code - Amount	
					(select od.[Type]			as "DiscountType", 
							 od.Value			as "DiscountAmount",
							 c.IsoCode			as "DiscountCurrency"
					from    Offer.OfferDiscounts od 
					inner   join Orders.Currency c on od.CurrencyId = c.CurrencyId
					where   od.OfferId  = o.Id
					and	  od.[Type] = 1
					FOR XML PATH('Discount'), type),
					-- Discount Node Code - Percentage							  
					(select od.[Type]		as "DiscountType", 
							  od.Value		as "DiscountPercentage",
							  'GBP'		as "DiscountCurrency"
					from    Offer.OfferDiscounts od 
					where   od.OfferId  = o.Id
					and     od.[Type] = 2
					FOR XML PATH('Discount'), type)
					-----			

	   FOR XML PATH('OfferDetails'), type) 
		------- 	 
	 
	FROM  Offer.Offers o	
	inner join Offer.OfferTypes ot ON o.TypeId = ot.Id
	WHERE o.StartDate < getdate()	and o.EndDate > getdate()	
	and not o.TypeId = 4 -- Dont pick up offer type 4, until EIB support this type
	order by o.TypeId
	FOR XML PATH('Offer'), ROOT('Offers') 	
 )
	
 select @xml_var as XMLToExport
	
	
	-------------------------------------------------------------------------
	--	Logging
	-------------------------------------------------------------------------
	SELECT -- set duration  
		@LogDuration = DATEDIFF(ms,@Now,GETDATE()) ;  

	EXEC AdminHub.SqlObject.uspMasterStoredProcedureLogging  
		 @DatabaseId  
		,@SchemaName
		,@ObjectName
		,@Now
		,@LogDuration
		,0 ; -- Logging step  
	
END TRY
BEGIN CATCH
    --	Rollback active/uncommittable transactions so failure condition can be logged
	IF XACT_STATE() = -1 OR @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION;
		END
		
	SELECT
		@DatabaseId = DB_ID();
		
	--	Record TRY..CATCH error details
    EXECUTE AdminHub.Error.uspAddTryCatchBlockProperties
			 @DatabaseId
			,@ErrorLogId OUTPUT;
			
	SELECT
		@ErrorLogId = ISNULL(@ErrorLogId,-1);

	RETURN @ErrorLogId							-- exit returning ErrorLogId (to indicate failure)
END CATCH;