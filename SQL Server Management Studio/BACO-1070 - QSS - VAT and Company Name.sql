select --*,
 	 o.oAddress
	,o.oDeliveryAddress
	,o.oBillAddress
	,uUserName
	,oOrderDate
	,uUpdatedBy
	,odVat
	,a1.aCompany as [Company in Address]
--	,a1.aID
--	,a1.aCreationDate
--	,a1.aUpdatedDate
--	,a2.aCompany as [Company in Delivery Address]
--	,a2.aID
--	,a2.aCreationDate
--	,a2.aUpdatedDate
--	,a3.aCompany as [Company in Bill Address]
--	,a3.aID
--	,a3.aCreationDate
--	,a3.aUpdatedDate

from NewCentralUsers..UserDetails ud
join NewCentralUsers..Orders o on ud.uID = o.oUID
join NewCentralUsers..OrderDetails od on o.oID = od.odOrderID
join NewCentralUsers..Addresses a1 on a1.aID = o.oAddress
join NewCentralUsers..Addresses a2 on a2.aID = o.oDeliveryAddress
join NewCentralUsers..Addresses a3 on a3.aID = o.oBillAddress
where ud.uUsername in ('dolphin201512@gmail.com', 'David.barenborg@gmail.com')