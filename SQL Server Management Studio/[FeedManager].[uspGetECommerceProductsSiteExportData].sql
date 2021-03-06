USE [BackOffice]
GO
/****** Object:  StoredProcedure [FeedManager].[uspGetECommerceProductsSiteExportData]    Script Date: 27-Dec-18 09:53:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [FeedManager].[uspGetECommerceProductsSiteExportData]	   
(
	@FeedId int
)
AS			
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

	 --get a list of specific prod ids from feedmanager  (for testing purposes)what 
	 DECLARE  @HoldProductIdsToExport TABLE
	 (
		ProductId INT NOT NULL
	 )
	 DECLARE @NoOfSpecificProdsToExport int
	 
	 INSERT @HoldProductIdsToExport 
	 EXEC   FeedManager.[dbo].[BO_sp_GetFeedAssociatedProducts] @FeedId;
	-- SELECT @NoOfSpecificProdsToExport = (SELECT COUNT(*) FROM @HoldProductIdsToExport)
	 --get a list of specific prod ids from feedmanager  (for testing purposes)

	 DECLARE @xml_var XML     
	 SET @xml_var =   
	 (SELECT  ps.SiteID as 'SiteID',
	 CASE WHEN p2.ProductFamilyID IS NULL THEN '' ELSE CAST(p2.ProductFamilyID AS NVARCHAR(20)) END AS 'ProductFamilyID',
	  "PRODUCTLIST" = 
			  (SELECT ProductID AS 'ProductID',
				CASE DisplayedForSale WHEN 1 THEN 'true' ELSE 'false' END AS 'Display'
								FROM Product.ProductSites ps2
								WHERE ps.SiteID = ps2.SiteID
								FOR XML PATH('Product'), TYPE),
		CASE WHEN s.DefaultProductId IS NULL THEN '' ELSE CAST(s.DefaultProductId AS NVARCHAR(20)) END AS 'DefaultProductID'
		FROM Product.ProductSites ps 
			INNER JOIN Product.[Site] s ON ps.SiteID = s.SiteID
			INNER JOIN Product.Products p ON p.ProductId = ps.ProductId
			left join Product.Products p2 on s.DefaultProductId = p2.ProductId
		WHERE    
		 (
			--p.ProductID IN ( SELECT productid FROM  @HoldProductIdsToExport )
			--AND 
			p2.ProductFamilyID IS NOT NULL
			--OR 
			--(
			--	(@NoOfSpecificProdsToExport = 0)
			--	 AND  
			--	(p.IsActive = 1)
			--)
		 )
		  
		GROUP BY ps.SiteID, s.DefaultProductId, p2.ProductFamilyID
	 FOR XML PATH('SITE'), ROOT('CATALOGUES'))
	 
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