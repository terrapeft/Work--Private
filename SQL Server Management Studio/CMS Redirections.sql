USE CMS
 
DECLARE @SiteName VARCHAR(MAX) = 'Global Investor%'
DECLARE @CheckoutSearchPatterns TABLE (SearchPattern VARCHAR(MAX))
 
DECLARE @CmsURL VARCHAR(MAX)
--SET @CmsURL = 'http://dev-cms.ci03.global.root/'
--SET @CmsURL = 'http://uat-cms.emazure.internal/'
SET @CmsURL = 'http://cms.emazure.internal/'
 
INSERT INTO @CheckoutSearchPatterns
VALUES
('%Checkout%'),
('%subscribe%'),
('%renew%')
 
DECLARE @Sites TABLE (sitSiteId INT, sitName VARCHAR(MAX))
INSERT INTO @Sites
SELECT
    sitSiteId, sitName
FROM
    dbo.Sites
WHERE
    sitName LIKE @SiteName
 
SELECT * FROM @Sites
 
SELECT
    SearchPattern,
    sitSiteId,
    sitName,
    @CmsURL + 'sitemap_node_edit.asp?smpSitemapID=' +
        CAST(smpSitemapID AS VARCHAR(MAX)) +
        '&smnSitemapNodeID=' + CAST(smnSitemapNodeID AS VARCHAR(MAX)) +
        '&sitU&tree=true' AS [Url],
    smpSitemapID,
    smpName,
    smnSitemapNodeID,
    smnTitle,
    smnReference,
    smnPageUrl,
    smnRedirectUrl,
    smnMenuReference
FROM
    @Sites
JOIN
    dbo.SiteMaps ON smpSiteId = sitSiteId
JOIN
    dbo.SiteMapNodes ON smnSitemapId = smpSitemapID
CROSS JOIN
    @CheckoutSearchPatterns
WHERE
       smnPageUrl LIKE SearchPattern
    OR smnRedirectUrl LIKE SearchPattern
ORDER BY
    sitSiteId,
    smnSitemapNodeID,
    SearchPattern