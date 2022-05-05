USE BackOffice
 
DECLARE @ProductFamilyName VARCHAR(MAX) = 'Global Investor%'
DECLARE @CheckoutSearchPatterns TABLE (SearchPattern VARCHAR(MAX))
 
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
    pf.ProductFamilyId,
    pf.[Name] AS ProductFamilyName,
    @TrialManagerURL +
        'Communications/AuthenticationMessageEdit.aspx?amId=' +
        CAST(am.Id AS VARCHAR(MAX)) AS [Url],
    am.Id,
    am.[Name],
    am.[Message]
FROM
    @ProductFamilies pf
JOIN
    dbo.AuthenticationMessages am ON am.ProductFamilyId = pf.ProductFamilyId
CROSS JOIN
    @CheckoutSearchPatterns csp
WHERE
    -- Authentication messages search.
    am.[Message] LIKE csp.SearchPattern
ORDER BY
    pf.ProductFamilyId,
    am.Id,
    csp.SearchPattern