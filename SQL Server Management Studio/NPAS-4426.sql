
begin tran t1
  
  begin try
	  declare @userid int
	  declare @addrid int
	  declare @orderid int
	  declare @user varchar(50) = 'man3@man.local'

	  insert into userdetails (uusername, uEmailAddress, uForenames, usurname)
	  values (@user, @user, 'Manual', 'Manual')

	  set @userid = (select uid from userdetails where uUsername = @user)

	  insert into Addresses (auid, aAddress1)
	  values (@userid, 'Local place')

	  set @addrid = (select aid from Addresses where auid = @userid)
  
	  insert into orders (ouid, oOrderDate, oAddress, oDeliveryAddress, oBillAddress, oUpSaleEffort, oPaymentType, oPaymentCleared, oTest)
	  values (@userid, GETDATE(), @addrid, @addrid, @addrid, 0, 1, 0, 1)

	  set @orderid = (select oid from Orders where ouid = @userid and oAddress = @addrid)

	  insert into orderdetails (odOrderID, odProductCatalogueID, odSubDefinitionID, odOrderCodeID, odSourceCodeID, odQuantity, odPrice, odVatRateID, odNeworRenew)
	  values (@orderid, 8811, 18331, 8434, 10905,1,525,22,'new')

  	  insert into orderdetails (odOrderID, odProductCatalogueID, odSubDefinitionID, odOrderCodeID, odSourceCodeID, odQuantity, odPrice, odVatRateID, odNeworRenew)
	  values (@orderid, 2310, 2315, 2233, 2302,1,0,0,'new')

  	  insert into orderdetails (odOrderID, odProductCatalogueID, odSubDefinitionID, odOrderCodeID, odSourceCodeID, odQuantity, odPrice, odVatRateID, odNeworRenew)
	  values (@orderid, 11163, 25121, 10693, 14206,1,0,0,'new')

  	  insert into orderdetails (odOrderID, odProductCatalogueID, odSubDefinitionID, odOrderCodeID, odSourceCodeID, odQuantity, odPrice, odVatRateID, odNeworRenew)
	  values (@orderid, 11164, 25122, 10694, 14207,1,0,0,'new')

  	  insert into orderdetails (odOrderID, odProductCatalogueID, odSubDefinitionID, odOrderCodeID, odSourceCodeID, odQuantity, odPrice, odVatRateID, odNeworRenew)
	  values (@orderid, 11165, 25123, 10695, 14208,1,0,0,'new')

	  insert into subscriptions (suid, spid, sSubscriptionNumber, sMasterRecord, sAllowedSessions, sNumberOfLogons, sNumberOfGUIDs, sStatus, sCreatedBy)
	  values (@userid, 2, 1,1,1,1,1,2,'npas-4426')

  end try

  begin catch
	rollback tran t1
  end catch

commit tran t1

/*
  select * from subscriptions where suid = 3519251
  select uid from userdetails where uUsername = 'man2@man.local'
  select * from Orders where ouid = 3519251

  select *
  --oid, userid, oorderdate, opaymentcleared, opaymenttype, ocardtype, ud.uusername, s.sStartDate, s.sExpiryDate
  from orders o 
	join userdetails ud on o.ouid = ud.uID
	join Addresses a on ud.uid = a.aUID
	--join orderdetails od on o.oid = od.odorderid
	--join Subscriptions s on od.odsubscriptionid = s.sID
  where uid = 3519251


  update orders
  set opaymentcleared = 1
  where oid = 2896526


*/