USE BackOffice
 
DECLARE @ProductFamilyName VARCHAR(MAX) = 'Global Investor%'
DECLARE @CheckoutSearchPatterns TABLE (SearchPattern VARCHAR(MAX))
 
INSERT INTO @CheckoutSearchPatterns
VALUES
('%Checkout%'),
('%subscribe.aspx%'),
('%subscribe.html%'),
('%renew.aspx%'),
('%renew.html%')
 
DECLARE @NcuPublications TABLE (pid INT, pName VARCHAR(MAX))
INSERT INTO @NcuPublications
SELECT
    pid,
    pName
FROM
    NewCentralUsers.dbo.Publications
WHERE
    pid IN
    (
        SELECT NcuPublicationId
        FROM Product.Products
        WHERE
            -- Product family search.
            ProductFamilyId IN
            (
                SELECT
                    ProductFamilyId
                FROM
                    Product.ProductFamilies
                WHERE
                    [Name] LIKE @ProductFamilyName
                -- Include only "UNIFIED ID" product families.
                AND ProductFamilyID >= 1000000
        )
    )
 
SELECT * FROM @NcuPublications
 
SELECT
    csp.SearchPattern,
    pub.[pid],
    pub.pName,
    ett.EmailTemplateTypeId,
    ett.[Description] AS EmailTemplateType,
    et.EmailTemplateId,
    et.TemplateBody,
    et.[Subject],
    et.TemplateBodyHTML,
    et.TemplateHeaderHTML,
    et.TemplateFooterHTML
FROM
    @NcuPublications pub
JOIN
    dbo.PublicationEmailTemplate pet ON pet.ProductId = pub.[pid]
JOIN
    dbo.EmailTemplate et ON et.EmailTemplateId = pet.EmailTemplateId
JOIN
    dbo.EmailTemplateType ett ON ett.EmailTemplateTypeId = et.EmailTemplateTypeID
CROSS JOIN
    @CheckoutSearchPatterns csp
WHERE
    -- Email template.
    (
           et.TemplateBody LIKE csp.SearchPattern
        OR et.[Subject] LIKE csp.SearchPattern
        OR et.TemplateBodyHTML LIKE csp.SearchPattern
        OR et.TemplateHeaderHTML LIKE csp.SearchPattern
        OR et.TemplateFooterHTML LIKE csp.SearchPattern
    )
ORDER BY
    pub.pid,
    et.EmailTemplateID,
    csp.SearchPattern