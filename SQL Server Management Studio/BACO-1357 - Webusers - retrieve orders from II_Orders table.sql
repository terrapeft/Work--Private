USE [NewCentralUsers]
GO

ALTER PROCEDURE [dbo].[User_Pub_Orders] 
@uid int,
@pid int
AS

Select pid,pName, pcDescription, pcIsEclipse,pcAvailablefor,cName, Orders.*, OrderDetails.* 
From  Orders left  join Currencies on oCurrencyID = cid
Inner join (Orderdetails  
INNER Join (ProductCatalogue 
left outer Join Publications on pID = pcPID )  on odProductCatalogueID = pcID) 
 on odOrderID = Oid
Where ouid = @uid AND (pid = @pid or oOrderFrom = @pid) And odPrice <> 0

union all

Select pid,pName, pcDescription, pcIsEclipse,pcAvailablefor,cName, II_Orders.*, II_Orderdetails.* 
From  II_Orders left  join Currencies on oCurrencyID = cid
Inner join (II_Orderdetails  
INNER Join (ProductCatalogue 
left outer Join Publications on pID = pcPID )  on odProductCatalogueID = pcID) 
 on odOrderID = Oid
Where ouid = @uid AND (pid = @pid or oOrderFrom = @pid) And odPrice <> 0


GO


ALTER PROCEDURE [dbo].[All_Orders] 
@uid INT
AS
BEGIN
	SET NOCOUNT ON;
	
	select * from (
		SELECT DISTINCT pid,pName, pcDescription, pcIsEclipse, oOrderDate, oPaymentType, oOrderFrom, OrderDetails.* 
		FROM  dbo.Orders
		INNER JOIN (Orderdetails  WITH (NOLOCK)
		INNER JOIN (ProductCatalogue WITH (NOLOCK)
		LEFT OUTER JOIN Publications WITH (NOLOCK) on pID = pcpID )  on odProductCatalogueID = pcID) 
		ON odOrderID = Oid
		WHERE ouid = @uid AND odPrice <> 0

		union all

		SELECT DISTINCT pid,pName, pcDescription, pcIsEclipse, oOrderDate, oPaymentType, oOrderFrom, II_OrderDetails.* 
		FROM  dbo.II_Orders
		INNER JOIN (II_Orderdetails  WITH (NOLOCK)
		INNER JOIN (ProductCatalogue WITH (NOLOCK)
		LEFT OUTER JOIN Publications WITH (NOLOCK) on pID = pcpID )  on odProductCatalogueID = pcID) 
		ON odOrderID = Oid
		WHERE ouid = @uid AND odPrice <> 0
	) t1

	ORDER BY pid
END

GO


ALTER PROCEDURE [dbo].[main_orders_with_userstatus] (
 @SQL varchar(2000), 
 @Records int
 ) as

declare @total int
declare @MainSQL varchar(2000)
declare @II_MainSQL varchar(2000)
declare @FinalSQL varchar(2000)

	Set @MainSQL = 'select  distinct uid, uForenames, uSurname, uEmailAddress,uCompany, pcDescription, oOrderDate, 
					case 
						when Subscriptions.sTrialExpiryDate >= GETDATE() then ''trial''
						when Subscriptions.sExpiryDate >= GETDATE() then ''subscriber''
						else ''registrant''
					end as UserStatus 
			from ((userdetails ud 
			join (Orders 
			join publications on oOrderfrom = pid 
			join (OrderDetails join ProductCatalogue pc on odProductCatalogueID=pcID 
			left join dbo.ProductTypeDetails PD on Pc.pcid = PD.productID 
			left join FullfilmentTypes FT ON PC.pcFullfilmentType = FT.fIndex) on oID = odOrderID) on uid = oUID) 
			left join Subscriptions  on uid = suid and spid = pid) 
			left join DatacashOrderRef on [oID] = dcOrderID ' + @SQL + '  order by oOrderdate'


	Set @II_MainSQL = 'select  distinct uid, uForenames, uSurname, uEmailAddress,uCompany, pcDescription, oOrderDate, 
					case 
						when Subscriptions.sTrialExpiryDate >= GETDATE() then ''trial''
						when Subscriptions.sExpiryDate >= GETDATE() then ''subscriber''
						else ''registrant''
					end as UserStatus 
			from ((userdetails ud 
			join (II_Orders 
			join publications on oOrderfrom = pid 
			join (II_OrderDetails join ProductCatalogue pc on odProductCatalogueID=pcID 
			left join dbo.ProductTypeDetails PD on Pc.pcid = PD.productID 
			left join FullfilmentTypes FT ON PC.pcFullfilmentType = FT.fIndex) on oID = odOrderID) on uid = oUID) 
			left join Subscriptions  on uid = suid and spid = pid) 
			left join DatacashOrderRef on [oID] = dcOrderID ' + @SQL + '  order by oOrderdate'


	create table #results (uid int,
	uforenames varchar(164),
	uSurname varchar(164),
	uEmailAddress varchar(164),
	uCompany varchar(228),
 	pcDescription varchar(228),
	oOrderDate datetime,
	UserStatus varchar(15))
	 begin
		 insert into #results (uid, uForenames, uSurname, uEmailAddress,uCompany, pcDescription, oOrderdate, UserStatus) exec(@mainSQL)
		 insert into #results (uid, uForenames, uSurname, uEmailAddress,uCompany, pcDescription, oOrderdate, UserStatus) exec(@II_MainSQL)
	 end


set @total = (select count(0) from #results)
Set @FinalSQL = 'select top ' + Convert(varchar(10), @Records) + 'uid, uForenames, uSurname, uEmailAddress,uCompany,pcdescription,UserStatus, ' + convert(varchar(10), @total) + ' as total from #results '
--print @finalSQL
exec(@FinalSQL)

GO


ALTER  PROCEDURE [dbo].[main_orders_report] (
 @SQL varchar(2000), 
 @Records int
 ) as

declare @total int
declare @MainSQL varchar(2000)
declare @II_MainSQL varchar(2000)
declare @FinalSQL varchar(2000)

	Set @MainSQL = 'select  distinct uid, uForenames, uSurname, uEmailAddress,uCompany, pcDescription, oOrderDate 
			from ((userdetails ud 
			join (Orders 
			join publications on oOrderfrom = pid 
			join (OrderDetails join ProductCatalogue pc on odProductCatalogueID=pcID 
			left join dbo.ProductTypeDetails PD on Pc.pcid = PD.productID 
			left join  FullfilmentTypes FT ON PC.pcFullfilmentType = FT.fIndex) on oID = odOrderID) on uid = oUID) 
			left join Subscriptions  on uid = suid) 
			left join DatacashOrderRef on [oID] = dcOrderID ' + @SQL + '  order by oOrderdate'

	Set @II_MainSQL = 'select  distinct uid, uForenames, uSurname, uEmailAddress,uCompany, pcDescription, oOrderDate 
			from ((userdetails ud 
			join (II_Orders 
			join publications on oOrderfrom = pid 
			join (II_OrderDetails join ProductCatalogue pc on odProductCatalogueID=pcID 
			left join dbo.ProductTypeDetails PD on Pc.pcid = PD.productID 
			left join  FullfilmentTypes FT ON PC.pcFullfilmentType = FT.fIndex) on oID = odOrderID) on uid = oUID) 
			left join Subscriptions  on uid = suid) 
			left join DatacashOrderRef on [oID] = dcOrderID ' + @SQL + '  order by oOrderdate'

	create table #results (uid int,
	uforenames varchar(164),
	uSurname varchar(164),
	uEmailAddress varchar(164),
	uCompany varchar(228),
 	pcDescription varchar(228),
	oOrderDate datetime)
	 begin
		 insert into #results (uid, uForenames, uSurname, uEmailAddress,uCompany, pcDescription, oOrderdate) exec(@mainSQL)
		 insert into #results (uid, uForenames, uSurname, uEmailAddress,uCompany, pcDescription, oOrderdate) exec(@II_MainSQL)
	 end


set @total = (select count(0) from #results)
Set @FinalSQL = 'select top ' + Convert(varchar(10), @Records) + 'uid, uForenames, uSurname, uEmailAddress,uCompany,pcdescription, ' + convert(varchar(10), @total) + ' as total from #results '
--print @finalSQL
exec(@FinalSQL)


GO



ALTER PROCEDURE [dbo].[main_report_export]
@sql varchar(1000),
@selectSQL varchar(1000), @order int, @pub varchar(10)
AS
declare @mainSQL varchar(2000) 
declare @II_mainSQL varchar(2000) 
    
if @order = 0
 begin
 set @mainSQL = 'select * from (' + 
	@selectSQL +  '  uEuromoneyEmail, uEuromoneyPhone, uEuromoneyFax, uThirdParty, oLeadSource  As [External Source]   
	from Userdetails ud WITH (NOLOCK)
	Join Addresses WITH (NOLOCK) ON uid = aUID AND  aDefault = 1
	Left Outer Join Countries WITH (NOLOCK) ON aCID = cID
	Left Outer JOIN USStates WITH (NOLOCK) ON aState = usCode
	LEFT JOIN Publications AS Free WITH (NOLOCK) ON uFreeIssueID = Free.pID 
	LEFT join II_BPA i WITH (NOLOCK) on iUID = uid and i.publication = ' + @pub + ' and i.publication is not null 

	Join Subscriptions WITH (NOLOCK) on uid = suid
	LEFT JOIN UserVisits WITH (NOLOCK) ON sid = uvsid 
	JOIN Publications WITH (NOLOCK) ON sPID = Publications.pID

	LEFT JOIN OrderDetails WITH (NOLOCK) ON  sid = odSubscriptionID 
	LEFT JOIN Orders O WITH (NOLOCK) ON O.oUID = UD.UID AND odOrderID = oID
	' + @sql + ' 
	
	union all ' +
	
	@selectSQL +  '  uEuromoneyEmail, uEuromoneyPhone, uEuromoneyFax, uThirdParty, oLeadSource  As [External Source]   
	from Userdetails ud WITH (NOLOCK)
	Join Addresses WITH (NOLOCK) ON uid = aUID AND  aDefault = 1
	Left Outer Join Countries WITH (NOLOCK) ON aCID = cID
	Left Outer JOIN USStates WITH (NOLOCK) ON aState = usCode
	LEFT JOIN Publications AS Free WITH (NOLOCK) ON uFreeIssueID = Free.pID 
	LEFT join II_BPA i WITH (NOLOCK) on iUID = uid and i.publication = ' + @pub + ' and i.publication is not null 

	Join Subscriptions WITH (NOLOCK) on uid = suid
	LEFT JOIN UserVisits WITH (NOLOCK) ON sid = uvsid 
	JOIN Publications WITH (NOLOCK) ON sPID = Publications.pID

	LEFT JOIN II_OrderDetails WITH (NOLOCK) ON  sid = odSubscriptionID 
	LEFT JOIN II_Orders O WITH (NOLOCK) ON O.oUID = UD.UID AND odOrderID = oID
	' + @sql + ') t1 
	Order by uSurname'

 end
else
 begin
 set @mainSQL = @selectSQL +  '   uEuromoneyEmail, uEuromoneyPhone, uEuromoneyFax, uThirdParty 
	from Userdetails ud WITH (NOLOCK)
	Join Addresses WITH (NOLOCK) ON uid = aUID AND  aDefault = 1
	Left Outer Join Countries WITH (NOLOCK) ON aCID = cID
	Left Outer JOIN USStates WITH (NOLOCK) ON aState = usCode
	LEFT JOIN Publications AS Free WITH (NOLOCK) ON uFreeIssueID = Free.pID 
	LEFT join II_BPA i WITH (NOLOCK) on iUID = uid and i.publication = ' + @pub + '  and i.publication is not null 

	Join Subscriptions WITH (NOLOCK) on uid = suid
	LEFT JOIN UserVisits WITH (NOLOCK) ON sid = uvsid 
	JOIN Publications WITH (NOLOCK) ON sPID = Publications.pID

' + @sql + ' Order by uSurname '
 end

Exec(@mainSQL)
print @mainSQL


GO



CREATE OR ALTER view [dbo].[OrderReportViewGulfWithUserstatus]
 
as 

 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end +
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end +
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end +
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end +
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end +
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end +
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end +
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Address', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcProductCode as 'Product Code', 
	PC.pcEclipseID as 'FulfilmentProductCode',
 	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	OD.odItemDescription as 'Item Description',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice * OD.odQuantity +  OD.odVAT)  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	O.oExtraInfo as 'Extra Info', 
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.oCardholdername as 'Cardholder Name',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(DA.aAddress1) + ',' 
	end +
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(DA.aAddress2) + ',' 
	end +
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(DA.aAddress3) + ',' 
	end +
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(DA.aCity) + ',' 
	end +
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(DA.aCounty) + ',' 
	end +
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(DAUS.usName) + ',' 
	end +
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(DA.aPostcode) + ',' 
	end +
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(DAC.CName) 
	end as 'Delivery Address', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(BA.aAddress1) + ',' 
	end +
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(BA.aAddress2) + ',' 
	end +
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(BA.aAddress3) + ',' 
	end +
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(BA.aCity) + ',' 
	end +
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(BA.aCounty) + ',' 
	end +
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(BAUS.usName) + ',' 
	end +
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(BA.aPostcode) + ',' 
	end +
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(BAC.CName) 
	end as 'Billing Address', 
	SD.sdDescription as 'Subsciption Definition',
	SD.sdEventdate as 'Event Date',
	od.odSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	S.sTrialexpirydate as 'Trial Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 and a.aActive=1 left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.orders O WITH (NOLOCK) on PB.pid = O.oOrderFrom left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			 join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			 join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid where PB.pid in (56,58)



union all


 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end +
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end +
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end +
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end +
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end +
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end +
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end +
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Address', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcProductCode as 'Product Code', 
	PC.pcEclipseID as 'FulfilmentProductCode',
 	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	OD.odItemDescription as 'Item Description',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice * OD.odQuantity +  OD.odVAT)  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	O.oExtraInfo as 'Extra Info', 
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.oCardholdername as 'Cardholder Name',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(DA.aAddress1) + ',' 
	end +
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(DA.aAddress2) + ',' 
	end +
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(DA.aAddress3) + ',' 
	end +
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(DA.aCity) + ',' 
	end +
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(DA.aCounty) + ',' 
	end +
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(DAUS.usName) + ',' 
	end +
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(DA.aPostcode) + ',' 
	end +
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(DAC.CName) 
	end as 'Delivery Address', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(BA.aAddress1) + ',' 
	end +
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(BA.aAddress2) + ',' 
	end +
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(BA.aAddress3) + ',' 
	end +
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(BA.aCity) + ',' 
	end +
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(BA.aCounty) + ',' 
	end +
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(BAUS.usName) + ',' 
	end +
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(BA.aPostcode) + ',' 
	end +
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(BAC.CName) 
	end as 'Billing Address', 
	SD.sdDescription as 'Subsciption Definition',
	SD.sdEventdate as 'Event Date',
	od.odSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	S.sTrialexpirydate as 'Trial Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 and a.aActive=1 left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.ii_orders O WITH (NOLOCK) on PB.pid = O.oOrderFrom left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			 join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			 join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.ii_orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid where PB.pid in (56,58)

GO


CREATE OR ALTER view [dbo].[OrderViewFreeWithUserStatus]
 
as 

 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	U.uPassword as 'Password',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end as 'Address 1',
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end as 'Address 2',
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end as 'Address 3',
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end as 'City',
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end as 'County',
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end as 'State',
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end as 'Post Code',
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Country', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcProductCode as 'Product Code', 
	PC.pcEclipseID as 'FulfilmentProductCode',
	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
	OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
	OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	OD.odItemDescription as 'Item Description',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice +  OD.odVAT)* OD.odQuantity  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.oCardholdername as 'Cardholder name',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	O.oExtraInfo as 'Extra Info', 
	surveys.survey_id,
	surveys.Name as survey_name,
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(DA.aAddress1) + ',' 
	end +
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(DA.aAddress2) + ',' 
	end +
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(DA.aAddress3) + ',' 
	end +
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(DA.aCity) + ',' 
	end +
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(DA.aCounty) + ',' 
	end +
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(DAUS.usName) + ',' 
	end +
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(DA.aPostcode) + ',' 
	end +
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(DAC.CName) 
	end as 'Delivery Address', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(BA.aAddress1) + ',' 
	end +
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(BA.aAddress2) + ',' 
	end +
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(BA.aAddress3) + ',' 
	end +
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(BA.aCity) + ',' 
	end +
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(BA.aCounty) + ',' 
	end +
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(BAUS.usName) + ',' 
	end +
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(BA.aPostcode) + ',' 
	end +
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(BAC.CName) 
	end as 'Billing Address', 
	SD.sdDescription as 'Subsciption Definition',
SD.sdEventdate as 'Event Date',
	S.sSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	S.sTrialexpirydate as 'Trial Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1
-- and a.aActive=1  TAKEN OUT UNTIL WE SORT OUT THE ACTIVE ADDRESSES IN ECOMMERCE
left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.orders O WITH (NOLOCK) on PB.pid = O.oOrderFrom left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			left join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS on DA.aState = DAUS.usCode left join dbo.Countries DAC on DA.aCid = DAC.cid)
			left join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid
	left join oscar.dbo.session_tbl sessions on sessions.session_id = O.oSessionId
	left join oscar.dbo.survey_tbl surveys on surveys.survey_id = sessions.survey_id


union all



 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	U.uPassword as 'Password',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end as 'Address 1',
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end as 'Address 2',
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end as 'Address 3',
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end as 'City',
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end as 'County',
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end as 'State',
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end as 'Post Code',
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Country', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcProductCode as 'Product Code', 
	PC.pcEclipseID as 'FulfilmentProductCode',
	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
	OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
	OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	OD.odItemDescription as 'Item Description',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice +  OD.odVAT)* OD.odQuantity  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.oCardholdername as 'Cardholder name',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	O.oExtraInfo as 'Extra Info', 
	surveys.survey_id,
	surveys.Name as survey_name,
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(DA.aAddress1) + ',' 
	end +
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(DA.aAddress2) + ',' 
	end +
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(DA.aAddress3) + ',' 
	end +
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(DA.aCity) + ',' 
	end +
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(DA.aCounty) + ',' 
	end +
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(DAUS.usName) + ',' 
	end +
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(DA.aPostcode) + ',' 
	end +
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(DAC.CName) 
	end as 'Delivery Address', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(BA.aAddress1) + ',' 
	end +
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(BA.aAddress2) + ',' 
	end +
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(BA.aAddress3) + ',' 
	end +
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(BA.aCity) + ',' 
	end +
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(BA.aCounty) + ',' 
	end +
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(BAUS.usName) + ',' 
	end +
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(BA.aPostcode) + ',' 
	end +
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(BAC.CName) 
	end as 'Billing Address', 
	SD.sdDescription as 'Subsciption Definition',
SD.sdEventdate as 'Event Date',
	S.sSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	S.sTrialexpirydate as 'Trial Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1
-- and a.aActive=1  TAKEN OUT UNTIL WE SORT OUT THE ACTIVE ADDRESSES IN ECOMMERCE
left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.ii_orders O WITH (NOLOCK) on PB.pid = O.oOrderFrom left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			left join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS on DA.aState = DAUS.usCode left join dbo.Countries DAC on DA.aCid = DAC.cid)
			left join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.ii_orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid
	left join oscar.dbo.session_tbl sessions on sessions.session_id = O.oSessionId
	left join oscar.dbo.survey_tbl surveys on surveys.survey_id = sessions.survey_id




GO


CREATE OR ALTER view [dbo].[OrdersViewWithUserstatus]
 
as 

 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	U.uPassword as 'Password',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end +
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end +
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end +
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end +
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end +
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end +
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end +
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Address', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcAccountNumber as 'AccountCode',
	PC.pcProfitCentre + PC.pcProductCode as 'ProductCode',
	PC.pcProductCode as 'Product Code',
	PC.pcEclipseID as 'FulfilmentProductCode',
	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
	OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
	OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	OD.odItemDescription as 'Item Description',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice +  OD.odVAT)* OD.odQuantity  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	case when O.oPaymentType = 1 then 'Invoice'
	 when O.oPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.oCardholdername as 'Cardholder Name',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	O.oExtraInfo as 'Extra Info', 
	surveys.survey_id,
	surveys.Name as survey_name,
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(DA.aAddress1) + ',' 
	end +
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(DA.aAddress2) + ',' 
	end +
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(DA.aAddress3) + ',' 
	end +
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(DA.aCity) + ',' 
	end +
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(DA.aCounty) + ',' 
	end +
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(DAUS.usName) + ',' 
	end +
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(DA.aPostcode) + ',' 
	end +
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(DAC.CName) 
	end as 'Delivery Address', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(BA.aAddress1) + ',' 
	end +
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(BA.aAddress2) + ',' 
	end +
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(BA.aAddress3) + ',' 
	end +
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(BA.aCity) + ',' 
	end +
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(BA.aCounty) + ',' 
	end +
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(BAUS.usName) + ',' 
	end +
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(BA.aPostcode) + ',' 
	end +
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(BAC.CName) 
	end as 'Billing Address', 
	SD.sdDescription as 'Subsciption Definition',
	SD.sdEventdate as 'Event Date',
	S.sSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	S.sTrialexpirydate as 'Trial Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	, oSessioniD, dbo.UserEdenCodes(oOrderFrom, U.uID, 0) AS EdenCode
from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 
		left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.orders O on PB.pid = O.oOrderFrom 
			left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			left join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid 
			left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode 
			left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			left join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid 
			left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode 
			left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID 
		left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID 
		left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex 
		left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		left join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid
	left join [EUR05637-SQL4].oscar.dbo.session_tbl sessions on sessions.session_id = O.oSessionId
	left join [EUR05637-SQL4].oscar.dbo.survey_tbl surveys on surveys.survey_id = sessions.survey_id


union all



 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	U.uPassword as 'Password',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end +
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end +
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end +
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end +
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end +
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end +
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end +
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Address', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcAccountNumber as 'AccountCode',
	PC.pcProfitCentre + PC.pcProductCode as 'ProductCode',
	PC.pcProductCode as 'Product Code',
	PC.pcEclipseID as 'FulfilmentProductCode',
	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
	OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
	OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	OD.odItemDescription as 'Item Description',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice +  OD.odVAT)* OD.odQuantity  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	case when O.oPaymentType = 1 then 'Invoice'
	 when O.oPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.oCardholdername as 'Cardholder Name',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	O.oExtraInfo as 'Extra Info', 
	surveys.survey_id,
	surveys.Name as survey_name,
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(DA.aAddress1) + ',' 
	end +
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(DA.aAddress2) + ',' 
	end +
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(DA.aAddress3) + ',' 
	end +
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(DA.aCity) + ',' 
	end +
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(DA.aCounty) + ',' 
	end +
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(DAUS.usName) + ',' 
	end +
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(DA.aPostcode) + ',' 
	end +
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(DAC.CName) 
	end as 'Delivery Address', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(BA.aAddress1) + ',' 
	end +
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(BA.aAddress2) + ',' 
	end +
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(BA.aAddress3) + ',' 
	end +
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(BA.aCity) + ',' 
	end +
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(BA.aCounty) + ',' 
	end +
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(BAUS.usName) + ',' 
	end +
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(BA.aPostcode) + ',' 
	end +
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(BAC.CName) 
	end as 'Billing Address', 
	SD.sdDescription as 'Subsciption Definition',
	SD.sdEventdate as 'Event Date',
	S.sSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	S.sTrialexpirydate as 'Trial Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	, oSessioniD, dbo.UserEdenCodes(oOrderFrom, U.uID, 0) AS EdenCode
from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 
		left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.ii_orders O on PB.pid = O.oOrderFrom 
			left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			left join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid 
			left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode 
			left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			left join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid 
			left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode 
			left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.ii_orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID 
		left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID 
		left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex 
		left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		left join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid
	left join [EUR05637-SQL4].oscar.dbo.session_tbl sessions on sessions.session_id = O.oSessionId
	left join [EUR05637-SQL4].oscar.dbo.survey_tbl surveys on surveys.survey_id = sessions.survey_id


GO


CREATE OR ALTER view [dbo].[OrderReportViewGulf]
 
as 

 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end +
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end +
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end +
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end +
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end +
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end +
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end +
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Address', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcProductCode as 'Product Code', 
	PC.pcEclipseID as 'FulfilmentProductCode',
 	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	OD.odItemDescription as 'Item Description',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice * OD.odQuantity +  OD.odVAT)  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	O.oExtraInfo as 'Extra Info', 
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.oCardholdername as 'Cardholder Name',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(DA.aAddress1) + ',' 
	end +
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(DA.aAddress2) + ',' 
	end +
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(DA.aAddress3) + ',' 
	end +
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(DA.aCity) + ',' 
	end +
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(DA.aCounty) + ',' 
	end +
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(DAUS.usName) + ',' 
	end +
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(DA.aPostcode) + ',' 
	end +
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(DAC.CName) 
	end as 'Delivery Address', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(BA.aAddress1) + ',' 
	end +
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(BA.aAddress2) + ',' 
	end +
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(BA.aAddress3) + ',' 
	end +
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(BA.aCity) + ',' 
	end +
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(BA.aCounty) + ',' 
	end +
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(BAUS.usName) + ',' 
	end +
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(BA.aPostcode) + ',' 
	end +
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(BAC.CName) 
	end as 'Billing Address', 
	SD.sdDescription as 'Subsciption Definition',
	SD.sdEventdate as 'Event Date',
	od.odSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 and a.aActive=1 left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.orders O WITH (NOLOCK) on PB.pid = O.oOrderFrom left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			 join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			 join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid where PB.pid in (56,58)



union all



 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end +
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end +
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end +
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end +
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end +
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end +
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end +
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Address', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcProductCode as 'Product Code', 
	PC.pcEclipseID as 'FulfilmentProductCode',
 	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	OD.odItemDescription as 'Item Description',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice * OD.odQuantity +  OD.odVAT)  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	O.oExtraInfo as 'Extra Info', 
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.oCardholdername as 'Cardholder Name',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(DA.aAddress1) + ',' 
	end +
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(DA.aAddress2) + ',' 
	end +
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(DA.aAddress3) + ',' 
	end +
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(DA.aCity) + ',' 
	end +
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(DA.aCounty) + ',' 
	end +
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(DAUS.usName) + ',' 
	end +
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(DA.aPostcode) + ',' 
	end +
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(DAC.CName) 
	end as 'Delivery Address', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(BA.aAddress1) + ',' 
	end +
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(BA.aAddress2) + ',' 
	end +
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(BA.aAddress3) + ',' 
	end +
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(BA.aCity) + ',' 
	end +
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(BA.aCounty) + ',' 
	end +
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(BAUS.usName) + ',' 
	end +
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(BA.aPostcode) + ',' 
	end +
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(BAC.CName) 
	end as 'Billing Address', 
	SD.sdDescription as 'Subsciption Definition',
	SD.sdEventdate as 'Event Date',
	od.odSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 and a.aActive=1 left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.ii_orders O WITH (NOLOCK) on PB.pid = O.oOrderFrom left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			 join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			 join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.ii_orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid where PB.pid in (56,58)


GO



CREATE OR ALTER view [dbo].[OrderViewFree_cleo]
 
as 

 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end as 'Address 1',
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end as 'Address 2',
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end as 'Address 3',
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end as 'City',
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end as 'County',
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end as 'State',
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end as 'Post Code',
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Country', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcEclipseID as 'FulfilmentProductCode',
	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
	OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
	OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice +  OD.odVAT)* OD.odQuantity  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	O.oExtraInfo as 'Extra Info',
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(left(DA.aAddress1,30)) 
	end as 'Delivery Address 1',
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(left(DA.aAddress2,30)) 
	end  as 'Delivery Address 2',
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(left(DA.aAddress3,30)) 
	end as 'Delivery Address 3',
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(left(DA.aCity,20))
	end as 'Delivery City',
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(left(DA.aCounty,20)) 
	end as 'Delivery County',
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(left(DAUS.usName,20)) 
	end as 'Delivery State',
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(left(DA.aPostcode,18)) 
	end as 'Delivery Post Code',
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(left(DAC.CName,20)) 
	end  as 'Delivery Country', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(left(BA.aAddress1,30)) 
	end as 'Billing Address 1',
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(left(BA.aAddress2,30)) 
	end  as 'Billing Address 2',
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(left(BA.aAddress3,30)) 
	end as 'Billing Address 3',
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(left(BA.aCity,20))
	end as 'Billing City',
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(left(BA.aCounty,20)) 
	end as 'Billing County',
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(left(BAUS.usName,20)) 
	end as 'Billing State',
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(left(BA.aPostcode,18)) 
	end as 'Billing Post Code',
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(left(BAC.CName,20)) 
	end  as 'Billing Country', 

	SD.sdDescription as 'Subsciption Definition',
	S.sSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 and a.aActive=1 left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.orders O on PB.pid = O.oOrderFrom left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			left join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			left join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex left join dbo.Vat_rates VR on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S on od.odsubscriptionId = S.sid



union all



 select 
	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	od.odAreasofInterest as 'Areas of Interest',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end as 'Address 1',
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end as 'Address 2',
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end as 'Address 3',
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end as 'City',
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end as 'County',
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end as 'State',
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end as 'Post Code',
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Country', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcEclipseID as 'FulfilmentProductCode',
	PC.pcSTID as pcSTID,
	OD.odneworrenew as 'New or Renew',
	OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
	OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice +  OD.odVAT)* OD.odQuantity  as decimal(10,2)) 
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	O.oExtraInfo as 'Extra Info',
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(left(DA.aAddress1,30)) 
	end as 'Delivery Address 1',
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(left(DA.aAddress2,30)) 
	end  as 'Delivery Address 2',
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(left(DA.aAddress3,30)) 
	end as 'Delivery Address 3',
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(left(DA.aCity,20))
	end as 'Delivery City',
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(left(DA.aCounty,20)) 
	end as 'Delivery County',
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(left(DAUS.usName,20)) 
	end as 'Delivery State',
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(left(DA.aPostcode,18)) 
	end as 'Delivery Post Code',
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(left(DAC.CName,20)) 
	end  as 'Delivery Country', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(left(BA.aAddress1,30)) 
	end as 'Billing Address 1',
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(left(BA.aAddress2,30)) 
	end  as 'Billing Address 2',
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(left(BA.aAddress3,30)) 
	end as 'Billing Address 3',
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(left(BA.aCity,20))
	end as 'Billing City',
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(left(BA.aCounty,20)) 
	end as 'Billing County',
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(left(BAUS.usName,20)) 
	end as 'Billing State',
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(left(BA.aPostcode,18)) 
	end as 'Billing Post Code',
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(left(BAC.CName,20)) 
	end  as 'Billing Country', 

	SD.sdDescription as 'Subsciption Definition',
	S.sSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scSourceCode as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 and a.aActive=1 left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.ii_orders O on PB.pid = O.oOrderFrom left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			left join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			left join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		(((dbo.ii_orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex left join dbo.Vat_rates VR on OD.odVATrateID = VR.VatID)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)

		on O.oid = OD.odorderID 
	left join 
		dbo.subscriptions S on od.odsubscriptionId = S.sid






GO


CREATE OR ALTER VIEW [dbo].[ordersview_cleo]


 
as 

 select 

	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	od.odAreasofInterest as 'Areas of Interest',
	U.uQuestion as 'Question',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end +
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end +
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end +
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end +
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end +
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end +
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end +
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Address', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	II.ijobtitle  as 'BPA Jobtitle',
	II.icompanytype  as 'BPA Companytype',
	II.iindustry  as 'BPA Industry',
	II.sindustryOther as 'BPA IndustryOther',
	II.iresponsibility  as 'BPA Responsibility',
	II.iasset  as 'BPA Asset',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcProfitCentre + PC.pcProductCode as 'ProductCode',
	PC.pcEclipseID as 'FulfilmentProductCode',
	OD.odneworrenew as 'New or Renew',
	OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
	OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice * OD.odQuantity + OD.odVAT)  as decimal(10,2))
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	O.oExtraInfo as 'Extra Info', 
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(left(DA.aAddress1,30)) 
	end as 'Delivery Address 1',
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(left(DA.aAddress2,30)) 
	end  as 'Delivery Address 2',
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(left(DA.aAddress3,30)) 
	end as 'Delivery Address 3',
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(left(DA.aCity,20))
	end as 'Delivery City',
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(left(DA.aCounty,20)) 
	end as 'Delivery County',
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(left(DAUS.usName,20)) 
	end as 'Delivery State',
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(left(DA.aPostcode,18)) 
	end as 'Delivery Post Code',
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(left(DAC.CName,20)) 
	end  as 'Delivery Country', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(left(BA.aAddress1,30)) 
	end as 'Billing Address 1',
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(left(BA.aAddress2,30)) 
	end  as 'Billing Address 2',
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(left(BA.aAddress3,30)) 
	end as 'Billing Address 3',
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(left(BA.aCity,20))
	end as 'Billing City',
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(left(BA.aCounty,20)) 
	end as 'Billing County',
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(left(BAUS.usName,20)) 
	end as 'Billing State',
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(left(BA.aPostcode,18)) 
	end as 'Billing Post Code',
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(left(BAC.CName,20)) 
	end  as 'Billing Country', 
 
	SD.sdDescription as 'Subsciption Definition',
	S.sSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scDefinition as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 and a.aActive=1 left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.orders O WITH (NOLOCK) on PB.pid = O.oOrderFrom  left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			left join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			left join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		((((dbo.orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)
		 left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)

		on O.oid = OD.odorderID left join dbo.II_BPA II WITH (NOLOCK) on o.ouid = II.iUID and PC.pcPID = II.publication
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid 

where 
	od.odprice > 0


union all


 select 

	U.GUID,
	OD.odid ,
	U.Uid as 'User ID',
	PB.pName as 'Ordered From',
	U.utitle as 'Salutation',
	U.uForenames as 'Forenames',
	U.uSurname as 'Surname',
	U.uCompany as 'Company',
	U.uJobtitle as 'Job Title',
	U.uCompanyType as 'Company Type',
	U.uEmailAddress as 'Email',
	od.odAreasofInterest as 'Areas of Interest',
	U.uQuestion as 'Question',
	case 
	when A.aAddress1 = '' then  ''
	when A.aAddress1 is null then  ''
	else rtrim(A.aAddress1) + ',' 
	end +
	case 
	when A.aAddress2 = '' then  ''
	when A.aAddress2 is null then  ''
	else rtrim(A.aAddress2) + ',' 
	end +
	case 
	when A.aAddress3 = '' then  ''
	when A.aAddress3 is null then  ''
	else rtrim(A.aAddress3) + ',' 
	end +
	case 
	when A.aCity = '' then  ''
	when A.aCity is null then  ''
	else rtrim(A.aCity) + ',' 
	end +
	case 
	when A.aCounty = '' then  ''
	when A.aCounty is null then  ''
	else rtrim(A.aCounty) + ',' 
	end +
	case 
	when US.usName = '' then  ''
	when US.usName is null then  ''
	else rtrim(US.usName) + ',' 
	end +
	case 
	when A.aPostcode = '' then  ''
	when A.aPostcode is null then  ''
	else rtrim(A.aPostcode) + ',' 
	end +
	case 
	when C.CName = '' then  ''
	when C.CName is null then  ''
	else rtrim(C.CName) 
	end  as 'Address', 
	A.aTel as 'Telephone', 
	A.afax as 'Fax', 
	case 
	when U.uEuromoneyPhone = 1 then 'Opted In'
	when U.uEuromoneyPhone = 0 then 'Opted Out'
	end as 'DPA Phone', 
	case 
	when U.uEuromoneyFax = 1 then 'Opted In'
	when U.uEuromoneyFax = 0 then 'Opted Out'
	end as 'DPA Fax',
	case 
	when U.uEuromoneyEmail = 1 then 'Opted In'
	when U.uEuromoneyEmail = 0 then 'Opted Out'
	end as 'DPA Email',
	case 
	when U.uThirdParty = 1 then 'Opted In'
	when U.uThirdParty = 0 then 'Opted Out'
	end as 'DPA ThirdParty',
	II.ijobtitle  as 'BPA Jobtitle',
	II.icompanytype  as 'BPA Companytype',
	II.iindustry  as 'BPA Industry',
	II.sindustryOther as 'BPA IndustryOther',
	II.iresponsibility  as 'BPA Responsibility',
	II.iasset  as 'BPA Asset',
	PC.pcid as 'Product ID', 
	PC.pcDescription as 'Product Name', 
	PC.pcProfitCentre  as 'ProfitCentre',
	PC.pcProfitCentre + PC.pcProductCode as 'ProductCode',
	PC.pcEclipseID as 'FulfilmentProductCode',
	OD.odneworrenew as 'New or Renew',
	OD.odcomments as 'Comments',
	OD.odPrice as 'Unit Price', 
	OD.odVAT as 'VAT', 
	VR.VatCode as 'VAT Rate', 
	VR.description as 'VAT Description', 
	OD.odQuantity as Quantity,
	OD.odDiscountPercent as 'Discount % Applied',
	OD.odDiscountCodes as 'Discount Codes',
	OD.odPostage as 'Delivery Amount Applied',
	case
	when (OD.odVAT is Null or OD.odQuantity is Null) then OD.odPrice
	else  cast((OD.odPrice * OD.odQuantity + OD.odVAT)  as decimal(10,2))
	end as 'Total Price', 
	O.oid as 'Order ID',
	O.oOrderFrom as 'oOrderfrom',
	O.oTest as oTest,
	Ft.fType  as 'Fulfilment Type',
	Cu.cName as Currency,
	O.oOrderDate  as 'Date',
	case when OPaymentType = 1 then 'Invoice'
	     when OPaymentType = 2 then 'Credit card'
	end  as 'Payment Method',
	O.olastFourdigits as 'Last 4 Digits',
	O.oDatacashRef as 'Datacash Ref',
	O.oExtraInfo as 'Extra Info', 
	case 
	when DA.aAddress1 = '' then  ''
	when DA.aAddress1 is null then  ''
	else rtrim(left(DA.aAddress1,30)) 
	end as 'Delivery Address 1',
	case 
	when DA.aAddress2 = '' then  ''
	when DA.aAddress2 is null then  ''
	else rtrim(left(DA.aAddress2,30)) 
	end  as 'Delivery Address 2',
	case 
	when DA.aAddress3 = '' then  ''
	when DA.aAddress3 is null then  ''
	else rtrim(left(DA.aAddress3,30)) 
	end as 'Delivery Address 3',
	case 
	when DA.aCity = '' then  ''
	when DA.aCity is null then  ''
	else rtrim(left(DA.aCity,20))
	end as 'Delivery City',
	case 
	when DA.aCounty = '' then  ''
	when DA.aCounty is null then  ''
	else rtrim(left(DA.aCounty,20)) 
	end as 'Delivery County',
	case 
	when DAUS.usName = '' then  ''
	when DAUS.usName is null then  ''
	else rtrim(left(DAUS.usName,20)) 
	end as 'Delivery State',
	case 
	when DA.aPostcode = '' then  ''
	when DA.aPostcode is null then  ''
	else rtrim(left(DA.aPostcode,18)) 
	end as 'Delivery Post Code',
	case 
	when DAC.CName = '' then  ''
	when DAC.CName is null then  ''
	else rtrim(left(DAC.CName,20)) 
	end  as 'Delivery Country', 

	case 
	when BA.aAddress1 = '' then  ''
	when BA.aAddress1 is null then  ''
	else rtrim(left(BA.aAddress1,30)) 
	end as 'Billing Address 1',
	case 
	when BA.aAddress2 = '' then  ''
	when BA.aAddress2 is null then  ''
	else rtrim(left(BA.aAddress2,30)) 
	end  as 'Billing Address 2',
	case 
	when BA.aAddress3 = '' then  ''
	when BA.aAddress3 is null then  ''
	else rtrim(left(BA.aAddress3,30)) 
	end as 'Billing Address 3',
	case 
	when BA.aCity = '' then  ''
	when BA.aCity is null then  ''
	else rtrim(left(BA.aCity,20))
	end as 'Billing City',
	case 
	when BA.aCounty = '' then  ''
	when BA.aCounty is null then  ''
	else rtrim(left(BA.aCounty,20)) 
	end as 'Billing County',
	case 
	when BAUS.usName = '' then  ''
	when BAUS.usName is null then  ''
	else rtrim(left(BAUS.usName,20)) 
	end as 'Billing State',
	case 
	when BA.aPostcode = '' then  ''
	when BA.aPostcode is null then  ''
	else rtrim(left(BA.aPostcode,18)) 
	end as 'Billing Post Code',
	case 
	when BAC.CName = '' then  ''
	when BAC.CName is null then  ''
	else rtrim(left(BAC.CName,20)) 
	end  as 'Billing Country', 
 
	SD.sdDescription as 'Subsciption Definition',
	S.sSubscriptionNumber as 'Eclipse no.',
	S.sStartdate as 'Start Date',
	S.sExpirydate as 'Expiry Date',
	PD.ISBN as 'ISBN',
	SC.scDefinition as 'Campaign Code',
	O.oLeadSource as 'External Source',
	case
	when O.oPaymentCleared = 0 then 'Unpaid'
	when O.oPaymentCleared= 1 then 'Paid'
	end as 'Payment Status'
	

from
	(
		(dbo.userdetails U WITH (NOLOCK) join dbo.Addresses A WITH (NOLOCK) on u.uid = a.auid and a.aDefault = 1 and a.aActive=1 left join dbo.USStates US WITH (NOLOCK) on a.aState = us.usCode )
		left join dbo.Countries C WITH (NOLOCK) on A.aCid = C.cid
	)
	
	join
		(((dbo.publications PB WITH (NOLOCK) join dbo.ii_orders O WITH (NOLOCK) on PB.pid = O.oOrderFrom  left join dbo.Currencies Cu WITH (NOLOCK) on O.ocurrencyID = Cu.cID)
			left join dbo.Addresses DA WITH (NOLOCK) on O.oDeliveryAddress = DA.aid left join dbo.USStates DAUS WITH (NOLOCK) on DA.aState = DAUS.usCode left join dbo.Countries DAC WITH (NOLOCK) on DA.aCid = DAC.cid)
			left join dbo.Addresses BA WITH (NOLOCK) on O.oBillAddress = BA.aid left join dbo.USStates BAUS WITH (NOLOCK) on BA.aState = BAUS.usCode left join dbo.Countries BAC WITH (NOLOCK) on BA.aCid = BAC.cid)
		on U.uid = O.ouid	 	

	join 
		((((dbo.ii_orderdetails OD WITH (NOLOCK) join dbo.ProductCatalogue PC WITH (NOLOCK) on OD.odProductCatalogueID = PC.pcID left join dbo.ProductTypeDetails PD WITH (NOLOCK) on Pc.pcid = PD.productID left join  dbo.FullfilmentTypes FT WITH (NOLOCK) ON PC.pcFullfilmentType = FT.fIndex)
		join dbo.subdefinitions SD WITH (NOLOCK) on OD.odSubDefinitionID = SD.sdID)
		join dbo.sourcecodes SC WITH (NOLOCK) on OD.odSourcecodeID = SC.scID)
		 left join dbo.Vat_rates VR WITH (NOLOCK) on OD.odVATrateID = VR.VatID)

		on O.oid = OD.odorderID left join dbo.II_BPA II WITH (NOLOCK) on o.ouid = II.iUID and PC.pcPID = II.publication
	left join 
		dbo.subscriptions S WITH (NOLOCK) on od.odsubscriptionId = S.sid 

where 
	od.odprice > 0












GO



