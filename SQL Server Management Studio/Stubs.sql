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
    p.ProductId,
    p.[Name] AS ProductName,
    @TrialManagerURL +
        'Communications/CommunicationTemplateEdit.aspx?tid=' +
        CAST(ct.TemplateTypeId AS VARCHAR(MAX)) AS [Url],
    ct.Id,
    ctt.[Name],
    ct.OnScreenMessage,
    ct.EmailFromName,
    ct.EmailFromAddress,
    ct.EmailPlainText,
    ct.EmailHTML
FROM
    Product.Products p
JOIN
    dbo.CommunicationTemplate ct ON ct.ProductId = p.ProductId
JOIN
    dbo.CommunicationTemplateType ctt ON ctt.Id = ct.TemplateTypeId
CROSS JOIN
    @CheckoutSearchPatterns csp
WHERE
    p.ProductFamilyId IN (SELECT ProductFamilyId FROM @ProductFamilies)
    AND
    -- Communication template search.
    (
           ct.OnScreenMessage LIKE csp.SearchPattern
        OR ct.EmailHTML LIKE csp.SearchPattern
        OR ct.EmailPlainText LIKE csp.SearchPattern
    )
ORDER BY
    p.ProductId,
    ct.Id,
    csp.SearchPattern