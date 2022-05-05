use NewCentralUsers;
/*
	* There is no syncronization of login date-time between two databases.

	* Backoffice.Logon.Users has 3,377,799 unique emails (usernames) (all counts are for PRODUCTION).
	  Backoffice.Logon.UserSummary has 3,377,787 unique records.
	  There are 27,200 inactive users in NPAS - all the users in this database have the last logon date-time.

	* NewCentralUsers.UserDetails has 3,462,261 unique emails (usernames).
	  NewCentalUsers.UserLogin has 296,336,741 records.
	  There are 23,376 identifiable inactive users (just by logon date) - those users who have the corresponding entry in the UserLogin table.

	* There are 3,376,759 syncronized users in databases:

				select	count(distinct uusername)
				from	UserDetails ncu join
						Backoffice.logon.users npas on ncu.uusername COLLATE DATABASE_DEFAULT = npas.username COLLATE DATABASE_DEFAULT
	   
	* There are 321 production user identified as inactive in both databases (joined on username):

				declare @inThePast datetime = DATEADD(yy, -7, GETUTCDATE());

				with inactive_users (userid)
				as (
					/*
						Select users
					*/
					select usr.userid
					from [BackOffice].[Logon].[UserSummary] usr 
					join [BackOffice].[Logon].[SubscriptionUser] s on usr.UserId = s.UserId
					where usr.LastLogonDateTime < @inThePast

					except

					/* 
						Exclude users with recent subscriptions of any type
					*/
					select usr.userid
					from [BackOffice].[Logon].[UserSummary] usr
					join (
						select UserId, max(SubscriptionEndDateTime) as SubscriptionEndDateTime
						from [BackOffice].[Logon].[SubscriptionUser] su
						join [BackOffice].[Orders].[Subscription] s on su.SubscriptionId = s.SubscriptionId
						group by UserId
						having max(SubscriptionEndDateTime) >= @inThePast
					) subs on usr.UserId = subs.UserId
					where	usr.LastLogonDateTime < @inThePast

					except

					/* 
						Exclude users with recent orders
					*/
					select usr.userid
					from [BackOffice].[Logon].[UserSummary] usr
					join (
						select UserId, max(OrderDateTime) as MostRecentDateTime
						from [BackOffice].[Customer].[UserContactAddress] ca 
						join [BackOffice].[Orders].[Orders] o on o.BillingUserContactAddressId = ca.AddressId
						group by UserId
						having max(OrderDateTime) >= @inThePast
				) orders on orders.UserId = usr.UserId
				where usr.LastLogonDateTime < @inThePast)

				select	UserName
				into	#npas_inactive_users
				from	inactive_users i join
						BackOffice.Logon.Users u on i.userid = u.UserId;


				with lastLogon (userid, loginDatetime)
				as (
					select ulsid, max(uldatetime)
					from UserLogin 
					group by ulsid
				)
				select d.uUsername
				into #ncu_inactive_users
				from UserDetails d join lastLogon l on d.userid = l.userid
				where l.loginDatetime < @inthepast

				select count(*)
				from #npas_inactive_users npas join
					 #ncu_inactive_users ncu on npas.UserName COLLATE DATABASE_DEFAULT = ncu.uUsername COLLATE DATABASE_DEFAULT
	  
*/



declare @inThePast datetime = DATEADD(yy, -7, GETUTCDATE())
declare @gdprReplacement varchar(40) = N'Replaced in terms of the GDPR compliance. ';
declare @gdprReplacementShort varchar(4) = N'GDPR';

with lastLogon (userid, loginDatetime)
as (
	select ulsid, max(uldatetime)
	from UserLogin 
	group by ulsid
)
select d.UserId, d.uEmailAddress, uForenames, uSurname, l.loginDatetime
into #user_details_delete
from UserDetails d join lastLogon l on d.userid = l.userid
where l.loginDatetime < @inthepast





/* delete from the beginning */
delete 
from _DeletionAddressesTemp
where auid in (select userid from #user_details_delete)


delete 
from _DeletionEdenUserTemp


rollback