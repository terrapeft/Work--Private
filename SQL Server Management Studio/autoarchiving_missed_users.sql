
/*
*
* Addresses of non-existent users in the queue, based on the query from somewhere out of the ssis package - NBO_NCU_UserAddress.dtsx
* but this query checks for users who have no NCU ID
*
*/
 
/*
SELECT U.addressid as aid ,[aUID] as [BO UID], ud.uid as [NCU UID], [aCompany],[aAddress1],[aCreationDate],[aCreatedBy] ,[aUpdatedDate],[aUpdatedBy],[aActive]
FROM [Interim].[Addresses_ReplTest] A
JOIN Interim.[UserContactAddress_Stage] U 
ON A.auid = U.UserId --and A.aid = U.AddressId
Join Customer.USerContactAddress USA ON USA.UserContactaddressId = U.ParentUserContactaddressId and USA.userid = U.UserID and USA.addressid = 0 
full outer join [newcentralusers].[dbo].[userdetails] ud on auid = ud.uid
where ud.uid is null and u.addressid != 0
*/


SELECT DISTINCT [aID],[aUID],[aAncestorID],[aParentID],[aEclipseCode],[aJobTitle],[aCompany],[aAddress1]
      ,[aAddress2],[aAddress3],[aCity],[aCounty],case WHEN LTRIM(RTRIM([aState])) = 'Not Applicable' THEN '' ELSE aState END as aState,[aPostCode],[aTel],[aFax]
      ,[aMobTel],[aCreationDate],[aCreatedBy] ,[aUpdatedDate],[aUpdatedBy],[aActive]
      ,[aDefault],[aSessionId],[aUpdateReason]
from Interim.Addresses_ReplTest a
join Interim.UserContactAddress_Stage u on a.auid = u.UserId and a.aid = u.AddressId
full outer join Interim.LogonUsers_Stage ut on a.auid = ut.userid
full outer join NewCentralUsers.dbo.UserDetails d on a.auid = d.uid
where ut.userid is null and d.uid is null
ORDER BY aCreationDate DESC
	

/*
select userid, username, right(newid(),10), islockedout, UserTypeId, 'I', 0 
from Interim.[LogonUsers_Stage]
where userid in (
1080455,
1237813,
1428196,
1471247,
1622198,
1704597,
2066089,
2263870,
2362120,
5057161,
536134
)
*/