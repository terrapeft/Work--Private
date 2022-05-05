use backoffice

drop table if exists #UsersToCheck2

select userid 
into #UsersToCheck2
from (values
(1130367)
--(487808),(505622),(624589),(695656),(720863),(781356),(783276),(785075),(807782),(811890),(824887),(886674),(984892),(991433),(1006296),(1060696),(1061740),(1065641),(1170150),(1194489),(1198273),(1235749),(1512641),(1517540),(1552067),(1554317),(1569738),(1602100),(1692899),(1720115),(1732037),(1776758),(1847956),(1890946),(1903092),(1912061),(1929676),(1929702),(1953792),(1956383),(2067641),(2069321),(2100534),(2117301),(2125803),(2127166),(2130108),(2147299),(2164483),(2173154),(2178607),(2179938),(2179957),(2191584),(2198173),(2199100),(2202740),(2205923),(2207813),(2210126),(2210195),(2233283),(2236296),(2254207),(2265096),(2265103),(2275888),(2278270),(2306407),(2310130),(2339683),(2340559),(2351226),(2388113),(2393407),(2408199),(2408873),(2410141),(2444686),(2448336),(2450132),(2453279),(2456129),(2456728),(2460411),(2462699),(2473766),(2474870),(2675095),(2688369),(2702780),(2705288),(2705384),(2705430),(2705565),(2705907),(2705990),(2706057),(2706058),(2706177),(2706293),(2706384),(2707356),(2707503),(2707552),(2707569),(2708330),(2708864),(2708937),(2708964),(2709143),(2709154),(2726403)
) v (userid)


select count(distinct u.userid)
from logon.users u
join logon.UserSummary us on u.UserId = us.UserId
join customer.usercontactaddress ca on u.UserId = ca.UserId
left join backoffice.logon.userdefaultcommunication udc on u.userid = udc.userid
left join backoffice.Customer.ActiveUserContactAddress ac on udc.ActiveUserContactAddressId = ac.ActiveUserContactAddressId
join #UsersToCheck2 u2 on u.userid = u2.userid

select *
from logon.users u
join logon.UserSummary us on u.UserId = us.UserId
join customer.usercontactaddress ca on u.UserId = ca.UserId
left join backoffice.logon.userdefaultcommunication udc on u.userid = udc.userid
left join backoffice.Customer.ActiveUserContactAddress ac on udc.ActiveUserContactAddressId = ac.ActiveUserContactAddressId
join #UsersToCheck2 u2 on u.userid = u2.userid