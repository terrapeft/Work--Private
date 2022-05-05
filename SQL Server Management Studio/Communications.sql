USE BackOffice
 
DECLARE @ProductFamilyName VARCHAR(MAX) = 'Global Investor%'
DECLARE @CheckoutSearchPatterns TABLE (SearchPattern VARCHAR(MAX))
 
DECLARE @AccessManagerURL VARCHAR(MAX)
--SET @AccessManagerURL = 'http://dev-accessmanager.ci03.global.root/'
--SET @AccessManagerURL = 'http://uat-accessmanager.emazure.internal/'
SET @AccessManagerURL = 'http://accessmanager.emazure.internal/'
 
DECLARE @TrialManagerURL VARCHAR(MAX)
--SET @TrialManagerURL = 'http://dev-trialmanager.ci03.global.root/'
--SET @TrialManagerURL = 'http://uat-trialmanager.emazure.internal/'
SET @TrialManagerURL = 'http://trialmanager.emazure.internal/'
 
INSERT INTO @CheckoutSearchPatterns
VALUES
('%Checkout%'),
('%subscribe.aspx%'),
('%subscribe.html%'),
('%renew.aspx%'),
('%renew.html%')
 
DECLARE @ProductFamilies TABLE (ProductFamilyId INT, [Name] VARCHAR(MAX))
INSERT INTO @ProductFamilies
SELECT
    ProductFamilyId,
    [Name]
FROM
    Product.ProductFamilies
WHERE
       [Name] LIKE @ProductFamilyName
    -- Include only "UNIFIED ID" product families.
    AND ProductFamilyID >= 1000000
 
SELECT * FROM @ProductFamilies
 
SELECT
    csp.SearchPattern,
    p.ProductId,
    p.[Name] AS ProductName,
    CASE ce.CampaignEmailTypeId
        WHEN 0 THEN 'Trial Manager'
        WHEN 1 THEN 'Trial Manager'
        WHEN 2 THEN 'Access Manager'
        ELSE '???'
    END AS [Application],
    CASE
        WHEN ce.IsLive = 1 AND ce.IsDeleted = 0 THEN 'Full Plan'
        WHEN ce.IsLive = 0 AND ce.IsDeleted = 0 THEN 'Inactive'
        ELSE 'Deleted'
    END AS [Plan],
    CASE ce.CampaignEmailTypeId
        WHEN 0 THEN @TrialManagerURL
        WHEN 1 THEN @TrialManagerURL
        WHEN 2 THEN @AccessManagerURL
        ELSE NULL
    END +
    'Communications/EditEmailCampaign.aspx?id=' +
    CAST(ce.Id AS VARCHAR(MAX)) AS [Url],
    ce.Id,
    ce.[Name],
    ce.SendDay,
    CASE SendDayType
        WHEN 1 THEN 'Days from start'
        WHEN 2 THEN 'Days from end'
        WHEN 3 THEN 'Business days from start'
        WHEN 4 THEN 'Business days from end'
        ELSE '???'
    END,
    SUBSTRING(CONVERT(VARCHAR(MAX), ce.SendTime, 8 /* "hh:mm:ss" style */), 1, 5) AS SendTime,
    ce.FromAddress,
    ce.FromName,
    ce.EmailSubject,
    ce.PlainBody,
    ce.HTMLBody
FROM
    Product.Products p
JOIN
    dbo.CampaignEmail ce ON ce.ProductId = p.ProductId
CROSS JOIN
    @CheckoutSearchPatterns csp
WHERE
    -- Product family search.
    p.ProductFamilyId IN (SELECT ProductFamilyId FROM @ProductFamilies)
    AND
    -- Communication plan search.
    (
           ce.PlainBody LIKE csp.SearchPattern
        OR ce.HTMLBody LIKE csp.SearchPattern
    )
ORDER BY
    p.ProductId,
    ce.CampaignId,
    csp.SearchPattern 