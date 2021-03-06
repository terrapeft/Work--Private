use BackOffice

DECLARE @UserId INT = 3412097

declare @ActiveUserContactAddressId int
declare @ContactId int
 
select
    @ActiveUserContactAddressId = null,
    @ContactId = null
 
select
    top 1
    @ActiveUserContactAddressId = auca.ActiveUserContactAddressId,
    @ContactId = uca.ContactId
from
    Customer.UserContactAddress uca
join
    Customer.ActiveUserContactAddress auca
        on auca.UserContactAddressId = uca.UserContactAddressId
where
    uca.UserId = @UserId
order by
    uca.UserContactAddressId asc
 
if @ActiveUserContactAddressId is null
begin
    declare @UserContactAddressId int
         
    select @UserContactAddressId = null
 
    select
        top 1
        @UserContactAddressId = uca.UserContactAddressId,
        @ContactId = uca.ContactId
    from
        Customer.UserContactAddress uca
    where
        uca.UserId = @UserId
    order by
        uca.UserContactAddressId desc
 
    if @UserContactAddressId is not null
    begin
        insert into [Customer].[ActiveUserContactAddress] (UserContactAddressId, ContactAddressTagId)
        values (@UserContactAddressId, null)
 
        select @ActiveUserContactAddressId = scope_identity()
    end
end
 
if @ActiveUserContactAddressId is not null
begin
    insert into [Logon].[UserDefaultCommunication] ([UserId], [ActiveUserContactAddressId], [ContactId])
    values (@UserId, @ActiveUserContactAddressId, @ContactId)
end
 
