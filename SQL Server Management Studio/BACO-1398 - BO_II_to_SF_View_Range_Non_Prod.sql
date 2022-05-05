USE [NewCentralUsers]
GO

CREATE OR ALTER VIEW [dbo].[BO_II_to_SF_View_Range_Non_Prod]
AS
SELECT CASE
           WHEN PC.pcID = 16277 THEN 'MIG'
           WHEN PC.pcID = 16280 THEN 'MIJ'
           WHEN PC.pcID = 16128 THEN 'MSE'
           WHEN PC.pcId = 8810 THEN 'MEL'
           WHEN PC.pcId = 8811 THEN 'MEM'
           WHEN PC.pcID = 15424 THEN 'MXT'
           WHEN
               PB.pId IN (414) THEN 'MBC'
           WHEN PC.pcID = 19372 THEN 'MCB'
           WHEN PC.pcID = 19689 THEN 'MJC'
           WHEN O.oOrderFrom = 206 THEN CASE
                                            WHEN PC.pcId = 6912 THEN 'MBM'
                                            ELSE LEFT(CC.ccCode, 3)
               END
           WHEN O.oOrderfrom = 225 THEN CASE WHEN PC.pcId = 6912 THEN 'MBM' ELSE LEFT(CC.ccCode, 3) END
           WHEN LEFT(PB.pProfitCentre, 3) = 'MSF' THEN 'MFS'
           WHEN CC.ccQSS = 1 THEN LEFT(CC.ccQSSCode, 3)
           WHEN PB.pId IN (297) THEN 'MIP'
           WHEN oOrderFrom = 345 THEN CASE WHEN PC.pcId = 14990 THEN 'MFL' ELSE LEFT(PB.pProfitCentre, 3) END
           ELSE LEFT(PB.pProfitCentre, 3) END                                                                       AS [Journal Code],
       CASE WHEN U.uForenames <> '' THEN LEFT(U.uForenames, 20) ELSE '' END                                         AS [First Name],
       CASE WHEN U.uSurname <> '' THEN LEFT(U.uSurname, 20) ELSE '' END                                             AS [Last Name],
       CASE WHEN U.utitle <> '' THEN LEFT(U.utitle, 5) ELSE '' END                                                  AS Title,
       CASE WHEN U.uCompany <> '' THEN LEFT(U.uCompany, 60) ELSE '' END                                             AS [Company Name],
       CASE
           WHEN U.uJobtitle <> '' THEN LEFT(U.uJobtitle, 60)
           ELSE '' END                                                                                              AS [Job Title],
       CASE
           WHEN DA.aAddress1 = '' THEN ''
           WHEN DA.aAddress1 IS NULL THEN ''
           ELSE rtrim(LEFT(DA.aAddress1, 30)) END                                                                   AS [Address Line 1],
       CASE
           WHEN DA.aAddress2 = '' THEN ''
           WHEN DA.aAddress2 IS NULL THEN ''
           ELSE rtrim(LEFT(DA.aAddress2, 30)) END                                                                   AS [Address Line 2],
       CASE
           WHEN DA.aAddress3 = '' THEN ''
           WHEN DA.aAddress3 IS NULL
               THEN ''
           ELSE rtrim(LEFT(DA.aAddress3, 30)) END                                                                   AS [Address Line 3],
       CASE
           WHEN DA.aCity = '' THEN ''
           WHEN DA.aCity IS NULL THEN ''
           ELSE rtrim(LEFT(DA.aCity, 20)) END                                                                       AS Town,
       CASE
           WHEN DA.aCounty = '' THEN ''
           WHEN DA.aCounty IS NULL THEN ''
           ELSE rtrim(LEFT(DA.aCounty, 20)) END                                                                     AS County,
       CASE
           WHEN DAUS.usName = '' THEN ''
           WHEN DAUS.usName IS NULL
               THEN ''
           ELSE rtrim(LEFT(DAUS.usName, 20)) END                                                                    AS STATE,
       CASE
           WHEN DA.aPostcode = '' THEN ''
           WHEN DA.aPostcode IS NULL THEN ''
           ELSE rtrim(LEFT(DA.aPostcode, 18)) END                                                                   AS [Post Code],
       CASE
           WHEN DAC.cName = '' THEN ''
           WHEN DAC.cName IS NULL THEN ''
           ELSE rtrim(LEFT(DAC.cName, 100)) END                                                                      AS Country,
       CASE WHEN DA.aTel <> '' THEN LEFT(A.aTel, 20) ELSE '' END                                                    AS Telephone,
       CASE WHEN DA.aFax <> '' THEN LEFT(A.afax, 20) ELSE '' END                                                    AS Fax,
       CASE
           WHEN U.uEmailAddress <> '' THEN LEFT(U.uEmailAddress, 60)
           ELSE '' END                                                                                              AS Email,
       CASE
           WHEN U.uForenames <> '' THEN LEFT(U.uForenames,
                                             20)
           ELSE '' END                                                                                              AS [Billing First Name],
       CASE WHEN U.uSurname <> '' THEN LEFT(U.uSurname, 20) ELSE '' END                                             AS [Billing Last Name],
       CASE WHEN U.uTitle <> '' THEN LEFT(U.uTitle, 5) ELSE '' END                                                  AS [Billing Title],
       CASE WHEN U.uCompany <> '' THEN LEFT(U.uCompany, 60) ELSE '' END                                             AS [Billing Company Name],
       CASE WHEN U.uJobtitle <> '' THEN LEFT(U.uJobtitle, 60) ELSE '' END                                           AS [Billing Job Title],
       CASE
           WHEN BA.aAddress1 = '' THEN ''
           WHEN BA.aAddress1 IS NULL THEN ''
           ELSE rtrim(LEFT(BA.aAddress1, 30)) END                                                                   AS [Billing Address Line 1],
       CASE
           WHEN BA.aAddress2 = '' THEN ''
           WHEN BA.aAddress2 IS NULL
               THEN ''
           ELSE rtrim(LEFT(BA.aAddress2, 30)) END                                                                   AS [Billing Address Line 2],
       CASE
           WHEN BA.aAddress3 = '' THEN ''
           WHEN BA.aAddress3 IS NULL THEN ''
           ELSE rtrim(LEFT(BA.aAddress3, 30)) END                                                                   AS [Billing Address Line 3],
       CASE
           WHEN BA.aCity = '' THEN ''
           WHEN BA.aCity IS NULL THEN ''
           ELSE rtrim(LEFT(BA.aCity, 20)) END                                                                       AS [Billing Town],
       CASE
           WHEN BA.aCounty = '' THEN ''
           WHEN BA.aCounty IS NULL THEN ''
           ELSE rtrim(LEFT(BA.aCounty,
                           20)) END                                                                                 AS [Billing County],
       CASE
           WHEN BAUS.usName = '' THEN ''
           WHEN BAUS.usName IS NULL THEN ''
           ELSE rtrim(LEFT(BAUS.usName, 20)) END                                                                    AS [Billing State],
       CASE
           WHEN BA.aPostcode = '' THEN ''
           WHEN BA.aPostcode IS NULL THEN ''
           ELSE rtrim(LEFT(BA.aPostcode, 18)) END                                                                   AS [Billing Post Code],
       CASE
           WHEN BAC.cName = '' THEN ''
           WHEN BAC.cName IS NULL
               THEN ''
           ELSE rtrim(LEFT(BAC.cName, 100)) END                                                                      AS [Billing Country],
       CASE WHEN BA.aTel <> '' THEN LEFT(BA.aTel, 20) ELSE '' END                                                   AS [Billing Telephone],
       CASE
           WHEN BA.afax <> '' THEN LEFT(BA.aFax, 20)
           ELSE '' END                                                                                              AS [Billing Fax],
       CASE
           WHEN U.uEmailAddress <> '' THEN LEFT(U.uEmailAddress, 60)
           ELSE '' END                                                                                              AS [Billing Email],
       CASE
           WHEN O.oOrderFrom = 206 AND PC.pcId IN (9661, 9660, 9659, 9658)
               THEN CASE
                        WHEN (isnumeric(O.oLeadSource) = 1) AND (len(O.oLeadSource) = 3)
                            THEN O.oLeadSource + '0' + SC.scSourceCode
                        WHEN (len(O.oLeadSource) = 4) AND (RIGHT(O.oLeadSource, 1) = 'D')
                            THEN O.oLeadSource + SC.scSourceCode
                        ELSE 'WEB8' + SC.scSourceCode END
           ELSE CASE
                    WHEN (len(O.oLeadSource) >= 1) AND (len(O.oLeadSource) <= 5)
                        THEN O.oLeadSource
                    WHEN SC.scSourceCode <> '' THEN LEFT(SC.scSourceCode, 5)
                    ELSE '' END END                                                                                 AS [Prom Code],
       CASE
           WHEN SD.sdSubLengthtype = 'months' AND
                SD.sdSublength = 12 THEN '1Y'
           WHEN SD.sdSubLengthtype = 'months' AND SD.sdSublength = 24 THEN '2Y'
           WHEN SD.sdSubLengthtype = 'months' AND
                SD.sdSublength = 36 THEN '3Y'
           WHEN SD.sdSubLengthtype = 'days' AND SD.sdSublength = 30 THEN '1M'
           ELSE '' END                                                                                              AS Term,
       CASE
           WHEN (OD.odVAT IS NULL OR
                 OD.odQuantity IS NULL) THEN OD.odPrice
           ELSE (OD.odPrice + OD.odVAT) * OD.odQuantity END                                                         AS Value,
       CU.cCode                                                                                                     AS Currency,
       CASE
           WHEN OD.odVat > 0 THEN ISNULL(oVatNumber, '')
           ELSE 'Zero Rate Tax' END                                                                                 AS [Vat Number],
       CASE
           WHEN oPaymentType = 1 THEN 'Invoice'
           WHEN oPaymentType = 2
               THEN 'C. card' END                                                                                   AS [Payment Method],
       ''                                                                                                           AS [Sales Rep Code],
       CASE
           WHEN OD.odNewOrRenew = 'new' THEN 'N'
           WHEN OD.odNewOrRenew = 'renewal' THEN 'R'
           WHEN OD.odPrice = 0 THEN 'F'
           ELSE '' END                                                                                              AS [Order Type],
       CASE
           WHEN U.uEuromoneyPhone = 1 THEN 'y'
           WHEN U.uEuromoneyPhone = 0
               THEN 'n' END                                                                                         AS [DPA Phone],
       CASE
           WHEN U.uEuromoneyFax = 1 THEN 'y'
           WHEN U.uEuromoneyFax = 0
               THEN 'n' END                                                                                         AS [DPA Fax],
       CASE
           WHEN U.uEuromoneyEmail = 1 THEN 'y'
           WHEN U.uEuromoneyEmail = 0
               THEN 'n' END                                                                                         AS [DPA Email],
       'n'                                                                                                          AS [DPA Eamil Third Party],
       CASE WHEN U.uThirdParty = 1 THEN 'y' WHEN U.uThirdParty = 0 THEN 'n' END                                     AS [DPA Third Party],
       OD.odOrderID                                                                                                 AS [EII Order Ref],
       PC.pcQssDemographic                                                                                          AS [Package Level],
       O.oOrderDate                                                                                                 AS [Order Date],
       O.oDataCashRef                                                                                               AS [Datacash Ref],
       CASE
           WHEN U.uEuromoneyMail = 1 THEN 'y'
           WHEN U.uEuromoneyMail = 0
               THEN 'n' END                                                                                         AS [DPA Mail],
       CASE
		   WHEN LEFT(PB.pProfitCentre, 3) = 'MIV' THEN PC.pcDescription
           WHEN PC.pcHasPrint = 1 THEN 'PRINT'
           WHEN PC.pcId = 8811 THEN 'PRINT PACKAGE'
           WHEN (CASE
                     WHEN PC.pcID = 16277 THEN 'MIG'
                     WHEN PC.pcID = 16280 THEN 'MIJ'
                     WHEN PC.pcID = 16128 THEN 'MSE'
                     WHEN PC.pcId
                         = 8810 THEN 'MEL'
                     WHEN PC.pcID = 15424 THEN 'MXT'
                     WHEN PB.pId IN (414)
                         THEN 'MBC'
                     WHEN PC.pcID = 19372 THEN 'MCB'
                     WHEN PC.pcID = 19689 THEN 'MJC'
                     WHEN O.oOrderFrom = 206 THEN CASE
                                                      WHEN PC.pcId = 6912 THEN 'MBM'
                                                      ELSE LEFT(CC.ccCode, 3)
                         END
                     WHEN O.oOrderfrom = 225 THEN CASE WHEN PC.pcId = 6912 THEN 'MBM' ELSE LEFT(CC.ccCode, 3) END
                     WHEN LEFT(PB.pProfitCentre, 3) = 'MSF' THEN 'MFS'
                     WHEN CC.ccQSS = 1 THEN LEFT(CC.ccQSSCode, 3)
                     WHEN PB.pId IN (297) THEN 'MIP'
                     WHEN oOrderFrom = 345 THEN CASE WHEN PC.pcId = 14990 THEN 'MFL' ELSE LEFT(PB.pProfitCentre, 3) END
                     ELSE LEFT(PB.pProfitCentre, 3) END) IN ('MRR', 'MWK', 'MFE', 'MDR', 'MFU',
                                                             'MGM', 'MIS', 'MIE', 'MAA', 'MJA', 'MJM', 'MJD',
                                                             'MJF', 'MJX', 'MJI', 'MJP', 'MJR', 'MJS', 'MJT', 'MJW',
                                                             'MLF', 'MML', 'MPR', 'MEF', 'MTO', 'MWL', 'MJC') THEN ''
           ELSE 'ONLINE' END                                                                                        AS [Package Type],
       CASE WHEN odVat IS NULL THEN '0' ELSE odVAT END                                                              AS [VAT Amount],
       SUB.sGUID AS [Subscription GUID]
FROM dbo.UserDetails AS U WITH (NOLOCK)
         INNER JOIN
     dbo.Addresses AS A WITH (NOLOCK) ON U.uID = A.aUID AND A.aDefault = 1 AND A.aActive = 1
         LEFT OUTER JOIN
     dbo.USStates AS US WITH (NOLOCK) ON A.aState = US.usCode
         LEFT OUTER JOIN
     dbo.Countries AS C WITH (NOLOCK) ON A.aCID = C.cID
         INNER JOIN
     (SELECT oID,
             oUID,
             oOrderDate,
             oAddress,
             oDeliveryAddress,
             oBillAddress,
             oUpSaleEffort,
             oPaymentType,
             oPaymentCleared,
             oDataCashRef,
             oCurrencyID,
             oCardholdername,
             oLastFourDigits,
             oCardType,
             oCustomerRef,
             oOrderFrom,
             oLeadSource,
             oTest,
             oExtraInfo,
             oServerIP,
             oSessionId,
             oHFIExported,
             oVatNumber
      FROM dbo.II_Orders
     ) AS O ON U.uID = O.oUID
         INNER JOIN
     (SELECT odID,
             odOrderID,
             odSubscriptionID,
             odProductCatalogueID,
             odSubDefinitionID,
             odOrderCodeID,
             odSourceCodeID,
             odQuantity,
             odOnEclipse,
             odEclipseReason,
             odEclipsePaymentStatus,
             odEclipseOrdRef,
             odEclipseSeqID,
             odPrice,
             odDiscountCodes,
             odDiscountPercent,
             odVat,
             odVatRateID,
             odPostage,
             odNeworRenew,
             odCreatedBy,
             odPaymentCleared,
             odChangeExpiryDate,
             odInReportTable,
             odAreasOfInterest,
             odComments,
             odSubscriptionNumber,
             odQuestion,
             odOnCancel,
             odItemDescription,
             odPPV,
             odGUID,
             odPPVCount,
             odPPVExpired,
             odDownloadNum
      FROM dbo.II_OrderDetails
      WHERE (odPrice > 0)
        AND (odQuantity > 0)
        AND (odOnCancel IS NULL OR
             odOnCancel = 0)) AS OD ON O.oID = OD.odOrderID
         INNER JOIN
     dbo.Subscriptions AS SUB WITH (NOLOCK) ON OD.odSubscriptionID = SUB.sID
         INNER JOIN
     dbo.SourceCodes AS SC WITH (NOLOCK) ON OD.odSourceCodeID = SC.scId
         INNER JOIN
     dbo.ProductCatalogue AS PC WITH (NOLOCK) ON OD.odProductCatalogueID = PC.pcID
         LEFT OUTER JOIN
     (SELECT pID,
             pName,
             pShortName,
             pURL,
             pEden,
             pIP,
             pAdmin_Email,
             pCustomer_Service_Email,
             pTrialDuration,
             pNumberOfGUID,
             pNumberOfSession,
             pEclipseID,
             pCentralContent,
             pIssueBased,
             pCheckSession,
             pCheckGUID,
             pLive,
             pCentralContentID,
             pProfitCentre,
             pPreviousDb,
             PPreviousPID,
             pPreviousCode,
             pSource,
             pFeedActive,
             pPLCFreeIssue,
             pBoat,
             pHFIApprovalRequired,
             pHFIProductCode,
             pCMSSiteID,
             pEBMSFeed,
             pIsActive,
             pParentPublicationID,
             pNBOStatusId
      FROM dbo.Publications
      WHERE (pID NOT IN (153, 19, 20))
         OR (pID IS NULL)) AS PB ON PC.pcPID = PB.pID
         LEFT OUTER JOIN
     dbo.CostCenters AS CC WITH (NOLOCK) ON PC.pcCostCentre = CC.ccIndex
         LEFT OUTER JOIN
     dbo.Currencies AS CU WITH (NOLOCK) ON O.oCurrencyID = CU.cID
         INNER JOIN
     dbo.SubDefinitions AS SD WITH (NOLOCK) ON OD.odSubDefinitionID = SD.sdID
         LEFT OUTER JOIN
     dbo.Addresses AS DA WITH (NOLOCK)
     ON O.oDeliveryAddress = DA.aID AND RTRIM(LTRIM(DA.aAddress1)) <> '' AND DA.aActive = 1
         LEFT OUTER JOIN
     dbo.USStates AS DAUS WITH (NOLOCK) ON DA.aState = DAUS.usCode
         LEFT OUTER JOIN
     dbo.Countries AS DAC WITH (NOLOCK) ON DA.aCID = DAC.cID
         LEFT OUTER JOIN
     dbo.Addresses AS BA WITH (NOLOCK)
     ON O.oBillAddress = BA.aID AND RTRIM(LTRIM(BA.aAddress1)) <> '' AND BA.aActive = 1
         LEFT OUTER JOIN
     dbo.USStates AS BAUS WITH (NOLOCK) ON BA.aState = BAUS.usCode
         LEFT OUTER JOIN
     dbo.Countries AS BAC WITH (NOLOCK) ON BA.aCID = BAC.cID
WHERE (PB.pSource = 'QSS' OR
       CC.ccQSS = 1 OR
       PB.pID IN (293, 294, 295, 296, 297, 353) OR
       PC.pcID IN (14990, 15424, 15451))
  AND (PB.pFeedActive = 1 OR
       CC.ccQSS = 1 OR
       PB.pID IN (293, 294, 295, 296, 297, 353) OR
       PC.pcID IN (14990, 15424, 15451))
  AND (LEFT(PB.pProfitCentre, 3) <> 'MEM' OR
       PB.pProfitCentre IS NULL OR
       LEFT(PB.pProfitCentre, 3) = 'MEM' AND O.oPaymentType IN (1, 2))
  AND (U.uEmailAddress NOT LIKE '%euromoneyplc.com%')
  AND (U.uEmailAddress NOT LIKE '%euromoneyasia.com%')
  AND (U.uEmailAddress NOT LIKE '%euromoney.com%')
  AND (U.uEmailAddress NOT LIKE 'alexdavidson007@%')
  AND (SD.sdSubLengthType = 'months' AND SD.sdSubLength >= 12 AND SD.sdSubLength <= 36 OR
       SD.sdSubLengthType = 'days' AND SD.sdSubLength >= 30 OR
       LEFT(PB.pProfitCentre, 3) = 'MDI' AND SD.sdSubLengthType = 'days' AND SD.sdSubLength = 14)
GO


