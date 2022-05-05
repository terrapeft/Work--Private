use backoffice



DECLARE @ucid INT;

Select @ucid = max(usercontactaddressid) 
from customer.UserContactaddress 
where addressid = 24509798 and userid = 5074101

--select addressid as aid1 
--from Interim.AddressUCAMap 
--where userid = 5074101
--where usercontactaddressid = @ucid;

select @ucid

Select *
from customer.UserContactaddress 
--where UserContactAddressId = @ucid
where addressid = 24509798 and userid = 5074101

select *
from Interim.AddressUCAMap 
where userid = 5074101


select *
from Logon.Users 
where userid = 5074101

