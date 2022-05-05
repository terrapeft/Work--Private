/*
	PRD-02
*/

use NewCentralUsers


-- run to verify

select '''' + uUsername + '''', '''' + replace(replace(uUsername, nchar(160), ''), ' ', '') + ''''
from newcentralusers.dbo.userdetails
where uusername like '% %'



-- replace space and non-breaking space

update NewCentralUsers.dbo.UserDetails set 
	uUsername = replace(replace(uUsername, nchar(160), ''), ' ', ''),
	uEmailAddress = replace(replace(uEmailAddress, nchar(160), ''), ' ', '')
where uusername like '% %'


/*
	PRD-04, run in a different session
*/

use PubWiz


-- run to verify

select '''' + emailaddress + '''', '''' + replace(replace(emailaddress, nchar(160), ''), ' ', '') + ''''
from [PubWiz].[dbo].[tbListItems]
where emailaddress like '% %'


-- replace space and non-breaking space

update [PubWiz].[dbo].[tbListItems] set 
	emailaddress = replace(replace(emailaddress, nchar(160), ''), ' ', '')
where emailaddress like '% %'


/*



	select [EmailAddress]
		  ,case
			when [EmailAddress] like '_%_@_%.__%'
			and not (
				[EmailAddress] like '%[^-A-Za-z0-9_@.]%'
				or [EmailAddress] like '%[.@][.@]%'
				or [EmailAddress] LIKE '%@%@%'
				)
				then 'Valid'
			else 'Wrong'
		   end as IsValid
	  from [EmailCampaign].[dbo].[C_MailingList]

	  where campaignid in ( 1630208)




*/



