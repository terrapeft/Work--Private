/*

Analayzing...


*/

-- user groups by email
select count(*)
from [BackOffice].[Customer].[EmailAddress] ea
join Logon.UserGroupEmailAddress ue on ea.EmailAddressId = ue.EmailAddressId
join Logon.UserGroup g on ue.UserGroupId = g.UserGroupId
where EmailAddress = 'FeedProcessor@euromoneydigital.com'

-- user group email doesn't present in users
select count(distinct userid)
from [BackOffice].[Customer].[EmailAddress] ea
join Customer.UserContactAddress ca on ea.EmailAddressId = ca.EmailAddressId
where EmailAddress = 'FeedProcessor@euromoneydigital.com'

-- one email for many users
select EmailAddressId, count(distinct userid)
from Customer.UserContactAddress
group by EmailAddressId
having count(distinct userid) > 1

-- one user with many emails
select userid, count(distinct EmailAddressId)
from Customer.UserContactAddress
group by userid
having count(distinct EmailAddressId) > 1

select distinct *
from Customer.UserContactAddress ad
join Logon.UserSummary s on ad.UserId = s.UserId
join Customer.EmailAddress e on ad.EmailAddressId = e.EmailAddressId
where e.EmailAddressId = 9832687



-- 1 user - many subscriptions
-- 1 subscription - many users (8221315)
select SubscriptionId, count(userId)
from Logon.SubscriptionUser
group by SubscriptionId
having count(userid) > 1

