USE [BackOffice]
GO
/****** Object:  StoredProcedure [FeedManager].[uspGetECommerceProductExportData]    Script Date: 27-Dec-18 09:53:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [FeedManager].[uspGetECommerceProductExportData]	   
(
	@FeedId int
) 
AS

SET NOCOUNT ON;  
-----------------------------------------------------------------------------  
-- define local variables  
-----------------------------------------------------------------------------  
  
DECLARE  
 -- Used to invoke RAISERROR  
 @ErrorMessage   NVARCHAR(4000) -- holds the RAISERROR error message to be returned  
 ,@ErrorSeverity   INT    -- holds the severity the error is to be raised under  
 ,@ErrorProcedure  SYSNAME   -- holds the stored procedure/trigger name raising the error  
 ,@DatabaseId   SMALLINT  -- holds the database id from sys.databases  
 ,@ErrorLogId   INT    -- holds the pk of Error.ErrorLog table, for record added  
 -- Logging  
 ,@ObjectName   SYSNAME   -- holds the name of the database object  
 ,@SchemaName   SYSNAME   -- holds the schema of the database object  
 ,@Now     DATETIME  -- holds the date and time the SP was called  
 ,@LogDuration   BIGINT   -- holds the duration of the SP call  
 -- Variables  
 ,@uID     INT    -- holds the NcuUserId  
   
BEGIN TRY  
 -------------------------------------------------------------------------  
 -- Record execution start time  
 -------------------------------------------------------------------------  
 EXEC Shared.uspGetVariableForObjectId  
        @@PROCID  
       ,@DatabaseId OUTPUT  
       ,@ObjectName OUTPUT  
       ,@SchemaName OUTPUT  
       ,@Now OUTPUT ;    
    
 -------------------------------------------------------------------------  
 -- Main block  
 -------------------------------------------------------------------------  
 
 
 --get a list of specific prod ids from feedmanager  (for testing purposes) 
 DECLARE  @HoldProductIdsToExport TABLE
 (
	ProductId INT NOT NULL
 )
 DECLARE @NoOfSpecificProdsToExport int
 
 INSERT @HoldProductIdsToExport 
 EXEC   FeedManager.[dbo].[BO_sp_GetFeedAssociatedProducts] @FeedId;
 SELECT @NoOfSpecificProdsToExport = (SELECT COUNT(*) FROM @HoldProductIdsToExport)
 --get a list of specific prod ids from feedmanager  (for testing purposes)
 
 
 DECLARE @xml_var XML     
 SET @xml_var =     
 (   
   
 SELECT    
  pr.ProductID			AS "ProductID",  
  pr.SiteDisplayName	AS "ProductName",  
  pr.BriefDescription   AS "BriefDescription",  
  pr.FullDescription    AS "FullDescription",  
  pr.ProductFamilyID,  
  ISNULL(pt.ProductTypeID,0)	AS "ProductType",  
  RIGHT(ple.Name, 3)	AS "LegalEntity",    
  psub.Name				AS "ProductSubType",
  pr.VariantParentID			AS "VariantParentID", 
  ''					AS "ProductMatrixHTML",  
  999					AS "StockAvailable",  
  ''					AS "DeliveryTimescale"  ,  
 ----   
 (SELECT ptc.Name AS "Classification"  
		  FROM   Product.ProductTertiaryClassificationAssignments ptca    
		  INNER  JOIN Product.ProductTertiaryClassifications ptc   
		  ON ptc.ProductTertiaryClassificationID = ptca.ProductTertiaryClassificationID  
		  WHERE  ptca.ProductID = pr.ProductID  
		  FOR XML PATH('ProductClassifications'), TYPE),  
 -----   
 "StatusFlags" =  
	 (SELECT pf.Name AS "FlagName",  
			 pf.ProductFlagID AS "FlagValue"  
			  FROM Product.ProductFlagAssignments pfa    
			  INNER JOIN Product.ProductFlags pf ON pfa.ProductFlagID = pf.ProductFlagID  
			  WHERE pfa.ProductID = pr.ProductID  
			  FOR XML PATH('StatusFlag'), TYPE),  
  -----  
  "Images" =  
			(SELECT STUFF(ISNULL(pra.Name,''), LEN(ISNULL(pra.Name,''))-(CHARINDEX('.', REVERSE(ISNULL(pra.Name,'')))-1), 0, '-' + CONVERT(VARCHAR(MAX),pri.AttachmentId ))AS "ImageURL",
				 CASE WHEN pri.IsSuitableForCarousel = 1 THEN 'Large' ELSE   'Normal' END AS "ImageSize",  
				 ISNULL(pri.[Order],0) AS "ImageDisplayOrder",  
				 ISNULL(pri.AltText, '') AS "ImageALTtag"  
			  FROM Product.Images pri    
			  INNER JOIN  Product.Attachments pra ON pri.AttachmentId = pra.AttachmentId    
			  WHERE  pri.ProductID = pr.ProductID  
			  AND pri.ParentImageID IS NULL 
			  FOR XML PATH('Image'), TYPE),  
  -----  
"Categories" =  
		 (SELECT ptc.Name AS "CategoryName",  
					ptc.Name AS "CategoryValue"  
					  FROM Product.ProductTertiaryClassificationAssignments ptca    
					  INNER JOIN Product.ProductTertiaryClassifications ptc   
					  ON ptc.ProductTertiaryClassificationID = ptca.ProductTertiaryClassificationID  
					  WHERE ptca.ProductID = pr.ProductID  
					  FOR XML PATH('Category'), TYPE),  
  -----  
  "TaxApplicability" =  
		 (SELECT pt.Name AS "ElementName",  
				 prt.Name AS "ElementType",  
			     ISNULL(prt.RevenueTypeCode, '') AS "ElementTaxType",   
			     prta.Value AS "ElementPercentage"  
		  FROM Product.Products prd   
		  INNER JOIN Product.ProductRevenueTypesAssignments prta  
		  ON prd.ProductID = prta.ProductID  
		  INNER JOIN Product.ProductRevenueTypes prt   
		  ON prta.ProductRevenueTypeID = prt.ProductRevenueTypeID  
		  INNER JOIN Product.ProductTypes pt  
		  ON prd.TypeID = pt.ProductTypeID  
		  WHERE  prta.ProductID = pr.ProductID  
		  FOR XML PATH('TaxableElement'), TYPE),  
 --   
 "ForcedRelatedProducts" =  
		 (SELECT frp.DependentProductID AS "ProductID"  
			  FROM Product.RelatedProducts frp   
			  WHERE  frp.BaseProductID = pr.ProductID  
			  FOR XML PATH(''), TYPE),  
  --  
 "CrossSellOptions" =  
 (SELECT up.DependentProductID   as "ProductID",  
     up.DependentPriceGroupID as "PricingID",  
     up.[Description]    as "UpsellText"  
  from Product.CrossSellProducts  up   
  where  up.BaseProductID = pr.ProductID  
  FOR XML PATH('CrossSellOption'), type),   
  pr.ShopShortLink as "ProductShortLink", 
  -----  
  "KeywordList" =  
		 (SELECT pk.Keyword AS "Keyword"  
				  FROM   Product.Keywords pk     
				  WHERE  pk.ProductID = pr.ProductID  
				  FOR XML PATH(''), TYPE),  
  ----  
 "TaxonomyNodes" = 
		 (SELECT tn.TaxonomyAreaID  AS "TaxonomyNode"  
			  FROM Product.TaxonomyAreasAssignments tn    
			  WHERE  tn.ProductID = pr.ProductID  
			  FOR XML PATH(''), TYPE),  

  (SELECT CASE 
			WHEN ISNULL(pot.TypeID,0) = 2		THEN 'Hybrid'
			WHEN pt.ProductTypeID in (5, 9, 24) THEN 'Event'
			WHEN pt.ProductTypeID in (16, 19)   THEN 'Magazines'
			WHEN pt.ProductTypeID in (34, 35)   THEN 'addon'			
			ELSE 'Books' 
			END AS [@type],  
			"UpsellPaths" =   
					  (SELECT pup.PriceIDUpsellFrom AS "PriceFrom",  
								pup.PriceIDUpsellTo AS "PriceTo",   
            "UpsellCosts" =     
					 (SELECT pup.Amount  AS "UpgradeCostValue",  
								oc2.IsoCode  AS "UpgradeCostCurrency"  
								  FROM Product.Price pp
								  INNER JOIN Orders.Currency oc2 ON pp.CurrencyId = oc2.CurrencyId
								  where   pp.PriceID = pup.PriceIDUpsellFrom
								  FOR XML PATH('UpsellCost'), TYPE),    
             '1' AS "ProratedCalculationType" -- ** HARD CODED INITIALLY                    
					FROM Product.UpsellPath pup       
						WHERE pup.ProductID = pr.ProductID  
				FOR XML PATH('UpgradePath'), type),  
           ------------  

					-----------------------------------------------	EVENTS					
			"EventSiteCategorisation" = (SELECT pt.Name
											WHERE pt.ProductTypeID IN (5, 9, 24)),
				"EventSiteCategories"= (SELECT cat.catName AS "EventCategoryName",
												'True' AS "EventCategoryValue"
												 FROM Product.ProductEventCategorisationAssigments evc  
													LEFT JOIN Product.ProductEventCategorisations ec  
													ON  evc.ProductEventCategorisationAssigmentID = ec.ProductEventCategorisationAssigmentID  
													LEFT JOIN dbo.synEventsCategories cat ON  ec.EventSiteCategoryID = cat.catCategoryID  
													WHERE evc.ProductID = pr.ProductID
													AND pr.TypeID IN (5, 9, 24)	-- Conference 		
													FOR XML PATH('EventSiteCategory'), TYPE),
				"FixedMaxLimit" = (SELECT CASE WHEN ISNULL(pfa.ProductFlagAssignmentID,0) > 0  
												THEN 'True' ELSE 'False' END 
													FROM Product.ProductFlagAssignments pfa 
													INNER JOIN Product.ProductFlags pf	
													ON pfa.ProductFlagID = pf.ProductFlagID
													AND  pf.ProductFlagID = 39
													WHERE pfa.ProductId = pr.ProductID 
													AND pr.TypeID IN (5, 9, 24)),
				"MaxAttendees" = (SELECT ProductFlagAttributes  
												FROM Product.ProductFlagAssignments pfa 
												INNER JOIN Product.ProductFlags pf	
												ON pfa.ProductFlagID = pf.ProductFlagID
												AND  pf.ProductFlagID = 39
												WHERE pfa.ProductId = pr.ProductID 
												AND pr.TypeID IN (5, 9, 24)),
												
				"EventInstances" =
				(SELECT 
						ped.EventDateID, 
						CONVERT(VARCHAR(10), ped.EventDate, 103)AS 'EventStartDate',																						
						CONVERT(VARCHAR(10), DATEADD(d, ped.EventDuration, EventDate), 103) AS 'EventEndDate',				
						ped.EventDuration AS 'EventLength',
						CASE WHEN (pr.TypeID in (5, 9, 24)) THEN 'Days' ELSE NULL END as 'EventLengthUnits',
						epg.PriceGroupID As 'DefaultPriceGroupID',
						c.Country AS 'EventCountry',
						c.CountryCode AS 'EventCountryISOCode',
						pl.City AS 'EventCity',
						ISNULL(cp.Province, '') AS 'EventState',
						ISNULL(pl.ZipCode, '') AS 'EventZip',
						'' AS 'EventVenue',
						'' AS 'EventLocationDescription',
						'' AS 'EventMapURL'				
						FROM  Product.ProductEventDates ped inner join Product.Locations  pl  
													ON ped.LocationID = pl.LocationID
													INNER JOIN Product.PriceGroups epg
													ON  ped.EventDateID =  epg.EventDateID
													LEFT JOIN  Customer.Country c  	
													ON	c.CountryID = pl.CountryID
														LEFT JOIN Customer.Province cp 
														ON cp.ProvinceID = pl.StateProvinceId	 													
														WHERE ped.ProductID = pr.ProductID AND pr.TypeID IN (5, 9, 24)
						FOR XML PATH('EventInstance'), TYPE),
				---------------------																			
				"EventProductCode" = (SELECT pc.ProductCode
										FROM Product.ProductEventDates ped 
										INNER JOIN Product.Codes pc ON ped.CodesID = pc.CodesID 
										INNER JOIN Product.ProductsEventFields pef ON ped.ProductID = pef.ProductID  					
										WHERE ped.ProductID = pr.ProductID AND  pr.TypeID IN (5, 9, 24)),
				"EventAccountCode" = (SELECT pc.AccountCode
										FROM Product.ProductEventDates ped 
										INNER JOIN Product.Codes pc ON ped.CodesID = pc.CodesID 
										INNER JOIN Product.ProductsEventFields pef ON ped.ProductID = pef.ProductID  					
										WHERE ped.ProductID = pr.ProductID AND  pr.TypeID IN (5, 9, 24)),
				"EventTitle" = (SELECT pef.EventTitle
										FROM Product.ProductEventDates ped 
										INNER JOIN Product.Codes pc ON ped.CodesID = pc.CodesID 
										INNER JOIN Product.ProductsEventFields pef ON ped.ProductID = pef.ProductID  					
										WHERE ped.ProductID = pr.ProductID AND  pr.TypeID IN (5, 9, 24)),
				"EventBriefDescription" = (SELECT pef.EventBriefDescription
											FROM Product.ProductEventDates ped 
										INNER JOIN Product.Codes pc ON ped.CodesID = pc.CodesID 
										INNER JOIN Product.ProductsEventFields pef ON ped.ProductID = pef.ProductID  					
										WHERE ped.ProductID = pr.ProductID AND  pr.TypeID IN (5, 9, 24)),
				"EventFullDescription" = (SELECT pef.EventFullDescription
										FROM Product.ProductEventDates ped 
										INNER JOIN Product.Codes pc ON ped.CodesID = pc.CodesID 
										INNER JOIN Product.ProductsEventFields pef ON ped.ProductID = pef.ProductID  					
										WHERE ped.ProductID = pr.ProductID AND  pr.TypeID IN (5, 9, 24)),
				"Speakers"= (SELECT ps.SpeakerName AS "SpeakerName",
									ps.[Description] AS "SpeakerDescription",
									ISNULL(pra.Name,'') AS "SpeakerImage",
									ISNULL(pri.AltText, '') AS "SpeakerImageALTtext",
									'' AS "SpeakerExternalBioURL"
										FROM Product.Speakers ps 
									  LEFT JOIN  Product.Attachments pra ON ps.ThumbNailID = pra.AttachmentId  
									  LEFT JOIN  Product.Images pri ON pra.AttachmentId = pri.AttachmentId	
										 WHERE ps.ProductID = pr.ProductID AND pr.TypeID IN (5, 9, 24)		
														FOR XML PATH('Speaker'), type),
					    --------------------------------
				"Partners" = (
					SELECT pp.PartnerName AS "PartnerName",
					ISNULL(pra.Name,'') AS  "PartnerLogo",
					ISNULL(pri.AltText, '') AS "PartnerLogoALTtext",
					ISNULL(pp.WebSiteURL, '')  AS "PartnerWebsite",
					ISNULL(pp.[Description], '')  AS "PartnerDescription",
					ISNULL(ppt.TypeName, '')  AS "PartnerType"						
					FROM Product.Partners pp
					LEFT JOIN  Product.Attachments pra ON pp.AttachmentId = pra.AttachmentId  
					LEFT JOIN  Product.Images pri ON pra.AttachmentId = pri.AttachmentId
					LEFT JOIN Product.PartnerTypes ppt ON pp.PartnerTypeID = ppt.PartnerTypeID
					WHERE pp.ProductID = pr.ProductID AND pr.TypeID IN (5, 9, 24)
						FOR XML PATH('Partner'), TYPE),	    			    
						--------------------------------
				"PreviousEvents" = 
					(SELECT pva.PreviousEventID AS "PreviousEventID",
							ISNULL(pef.EventTitle, '') AS "PreviousEventDisplayText"
							FROM Product.PreviousEventsAssignments pva 
							LEFT JOIN Product.ProductsEventFields pef ON pef.ProductID  = pva.PreviousEventID
						WHERE pva.EventID = pr.ProductID 	AND pr.TypeID IN (5, 9, 24)
						FOR XML PATH('PreviousEvent'), TYPE),																																									
				----------------------------------------------------
				"ParentProductID" = 
						( SELECT plp.ProductID 
										FROM Product.ProductLinkedProductAssignments plp
										WHERE plp.LinkedProductID = pr.ProductID AND pr.TypeID IN (34, 35) ),
				"IsAlternative"	=
						(SELECT CASE WHEN EXISTS (SELECT plp.LinkedProductID  FROM Product.ProductLinkedProductAssignments plp
											WHERE plp.LinkedProductID = pr.ProductID AND pr.TypeID = 35) 
											THEN 'yes' ELSE 'no' END),	
				
				"PurchaseLimit"	=
						(SELECT 99 FROM Product.ProductLinkedProductAssignments plp
										WHERE plp.LinkedProductID = pr.ProductID AND pr.TypeID IN (34, 35) ),			
									
				"AvailableSeparately"	=
						(SELECT 'no' FROM Product.ProductLinkedProductAssignments plp
										WHERE plp.LinkedProductID = pr.ProductID AND pr.TypeID IN (34, 35) ),
				--------------------------------------------------------		
  				"Assets" =  
						ISNULL((SELECT  proa.Name    AS "AssetName",  
						   proa.[Description] AS "AssetDescription",  
						   proat.Name   AS "AssetType",  
						   proa.PublicUrl  AS "AssetURL",  
						   ISNULL(proac.Name , '')  AS "AssetCategory"  
						 FROM Product.Assets proa  
						  INNER JOIN Product.AssetsType proat ON proa.TypeID = proat.TypeID  
						  LEFT OUTER JOIN Product.AssetsCategory proac ON proa.CategoryID = proac.CategoryID  
							WHERE  proa.ProductID = pr.ProductID  
							FOR XML PATH('Asset'), type), '')	
																				
  FOR XML PATH('ProductDetails'), TYPE),  
  ------------------------------------------------------- 
  "Pricing"=  
   (SELECT 'CreditCardOptionAvailable' = (SELECT CASE WHEN ISNULL(pfa.ProductFlagAssignmentID,0) > 0    
                THEN 'True' ELSE 'False' END   
                 FROM Product.ProductFlagAssignments pfa   
                INNER JOIN Product.ProductFlags pf ON pfa.ProductFlagID = pf.ProductFlagID  
                AND  pf.ProductFlagID = 19  
                WHERE pfa.ProductId = pr.ProductID),  
      'InvoiceOptionAvailable' =  CASE WHEN exists (SELECT pfa.ProductFlagAssignmentID  FROM Product.ProductFlagAssignments pfa   
               INNER JOIN Product.ProductFlags pf ON pfa.ProductFlagID = pf.ProductFlagID  
               AND  pf.ProductFlagID = 21 
               WHERE pfa.ProductId = pr.ProductID)    
                THEN 'True' ELSE 'False' END ,  
	'InvoiceRestricted'  =  CASE WHEN EXISTS (SELECT pfa.ProductFlagAssignmentID  
			FROM Product.ProductFlagAssignments pfa   
               INNER JOIN Product.ProductFlags pf ON pfa.ProductFlagID = pf.ProductFlagID 
				AND  pf.ProductFlagID = 20  
					WHERE pfa.ProductId = pr.ProductID) 
						THEN 'True' ELSE 'False' END ,  
      'SourceCode' = (SELECT CASE WHEN ISNULL(pfa.ProductFlagAssignmentID,0) > 0     
							THEN 'True' ELSE 'False' END   
                 FROM Product.ProductFlagAssignments pfa   
						INNER JOIN Product.ProductFlags pf on pfa.ProductFlagID = pf.ProductFlagID  
							AND  pf.ProductFlagID = -1 -- no source code flag  
					WHERE pfa.ProductId = pr.ProductID),  
      'ExcludeFromDiscounts' = CASE WHEN EXISTS (SELECT pfa.ProductFlagAssignmentID  
					FROM Product.ProductFlagAssignments pfa   
						INNER JOIN Product.ProductFlags pf ON pfa.ProductFlagID = pf.ProductFlagID 
							AND pf.ProductFlagID = 29  
				WHERE pfa.ProductId = pr.ProductID) 
					THEN 'True' else 'False' end   
			FOR XML PATH('PricingFlags'), type),  
   --------- 
   "PriceGroups" = 
		   (SELECT	pg.PriceGroupID,
					SUBSTRING(pg.[DisplayText],0,100)   AS "PriceName",  --Need to cap the DisplayText as if too long it breaks the eib integration service
					pg.[PriceGroupDescription] AS "PriceDescription", 
					CASE [IsDefault] WHEN  1 THEN 'Y' ELSE 'N' END AS "IsDefaultPrice",
					pgt.Name AS "PriceType",
					pg.PriceGroupStartDate   AS "PriceGroupValidStartDate",  
					COALESCE(CONVERT(VARCHAR, pg.PriceGroupEndDate, 121), '')AS "PriceGroupValidEndDate",
					COALESCE(pg.ShopShortLink, '') AS "PriceGroupShortLink",					
					COALESCE(pg.FirstPromoCode, '') AS "PromoCode1",
					COALESCE(pg.SubsequentPromoCode, '') AS "PromoCode2",					 				  
					   (SELECT '',
							  (SELECT	pp2.PriceID AS "PriceID", 
										oc.IsoCode AS "PriceCurrency", 
										pp2.Amount AS "PriceAmount",
										pp2.ActiveDate AS "PriceStartDate",
										COALESCE(CONVERT(VARCHAR, pp2.DecommissionDate, 121), '')AS "PriceEndDate",
										ppg.PriceGroupID AS "PriceGroupID",
										CASE WHEN pt.ProductTypeID in (16, 19) THEN COALESCE(ptm.TermLength, 0) ELSE 0 END AS "SubLength",
										CASE WHEN pt.ProductTypeID in (16, 19) THEN COALESCE(ptu.Name, '') ELSE '' END AS "SubLengthUnits"          
											FROM Product.Price pp2    
											INNER JOIN Product.PriceGroups ppg ON  ppg.PriceGroupID = pp2.PriceGroupID
											INNER JOIN Orders.Currency oc ON oc.CurrencyId = pp2.CurrencyId
											INNER JOIN Orders.SubscriptionType ost ON ppg.SubscriptionTypeID = ost.SubscriptionTypeId
											LEFT JOIN Product.PriceTerm ppt ON  ppt.PriceID = pp2.PriceID
											LEFT JOIN Product.Term ptm ON ppt.TermID = ptm.TermID
											LEFT JOIN Product.TimeUnits ptu ON COALESCE(ptm.TimeUnitsId, 2) = ptu.TimeUnitId  
											WHERE ppg.productId = pr.productId
											AND ppg.PriceGroupID = pg.PriceGroupID
											AND  oc.CurrencyId = pp2.CurrencyId
											AND NOT ppg.SubscriptionTypeID IN (1,2,6)
											AND  ISNULL(pp2.DecommissionDate, '2099-01-01') >= GETDATE() 
											FOR XML PATH('Price'), TYPE) 
						FOR XML PATH('Prices'), TYPE)        
	   FROM Product.PriceGroups pg
			INNER JOIN Product.PriceGroupTypes pgt ON pg.PriceGroupTypeID = pgt.PriceGroupTypeID
			INNER JOIN Orders.SubscriptionType ost ON pg.SubscriptionTypeID = ost.SubscriptionTypeId
			WHERE  pg.productId = pr.productId
			AND pg.IsActive = 1 
			AND  ISNULL(pg.PriceGroupEndDate, '2099-01-01') >= GETDATE()
			AND pg.SubscriptionTypeId IN (3, 4, 5)
			FOR XML PATH('PriceGroup'), TYPE),
 ---------  
 "Renewals" =
	 (SELECT rs.RenewalSeriesId   AS "RenewalSeriesID",
			CASE rs.OnlyCurrentTerm WHEN 1 THEN 'Y' ELSE 'N' END AS "CurrentTermOnly",
			rs.Name   AS "Name",   
				 "Efforts" =    
					   (SELECT	re.RenewalEffortId AS "RenewalEffortID",
								pg.PriceGroupStartDate AS "RenewalEffortStartDate",  
								pg.PriceGroupEndDate AS "RenewalEffortEndDate",
								pg.PriceGroupID
								FROM Product.RenewalEfforts re
								INNER JOIN Product.PriceGroups pg ON re.RenewalEffortId = pg.RenewalEffortId  
									WHERE re.RenewalSeriesId = rs.RenewalSeriesId
										AND pg.IsActive = 1 
											AND  ISNULL(pg.PriceGroupEndDate, '2099-01-01') >= GETDATE()
												AND pg.productId = pr.productId
													ORDER BY re.RenewalEffortId 
													FOR XML PATH('RenewalEffort'), TYPE)  
			  FROM   Product.RenewalSeries rs 
			  WHERE  rs.ProductId  = pr.ProductId
			  FOR XML PATH('RenewalSeries'), TYPE)       
 FROM Product.Products pr    
 LEFT JOIN Product.ProductTypes			pt		ON pr.TypeID = pt.ProductTypeID  
 LEFT JOIN Product.ProductOverallTypes	pot		ON pr.OverallTypeID = pot.TypeID  
 LEFT JOIN Product.ProductSubTypes		psub	ON pr.SubtypeID = psub.ProductSubtypeID  
 LEFT JOIN Product.LegalEntities		ple		ON pr.LegalEntityID = ple.LegalEntityID  
 WHERE   
	 (
		pr.ProductID IN ( SELECT productid FROM @HoldProductIdsToExport )
		OR 
		(
			(@NoOfSpecificProdsToExport = 0)
			 AND  
			(pr.IsActive = 1)
		)
	  )

   
 FOR XML PATH('Product'), ROOT('Products')  
   
 )  
   
 SELECT @xml_var AS XMLToExport     
	
	
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