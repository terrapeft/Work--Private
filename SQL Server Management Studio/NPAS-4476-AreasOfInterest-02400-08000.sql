--
-- Remove 02400, use 08000
--

-- drop table if exists #UserDetails_Rollback 

-- Create temp table with rollback data
select uid, uAreasOfInterest
into ##UserDetails_Rollback -- tempdb.UserDetails_Rollback
from [NewCentralUsers].[dbo].[UserDetails]
where uAreasofInterest like '%|08000|%' or uAreasofInterest like '%|02400|%'


-- Remove mapping
delete 
from EdenGroupCodes 
where egcId = 7428

if exists (select 1 from ##UserDetails_Rollback) -- tempdb.UserDetails_Rollback)
begin
	-- Find records with both codes in the uAreasofInterest: 08000 and 02400,
	-- remove 02400
	update userdetails
	set uAreasofInterest = replace(uAreasofInterest, '02400|', '')
	where uAreasofInterest like '%|08000|%' and uAreasofInterest like '%|02400|%'
	
	-- Find records with 02400 only and replace it with 08000
	update userdetails
	set uAreasofInterest = replace(uAreasofInterest, '02400|', '08000|')
	where uAreasofInterest like '%|02400|%'
end





--Rollback

-- EdenGroupCodes
set identity_insert EdenGroupCodes ON

insert into EdenGroupCodes (egcID, egcGroupID, egcCodeID) 
values (7428, 81, 7297)

set identity_insert EdenGroupCodes OFF

update u
set u.uAreasofInterest = rlbck.uAreasofInterest
from userdetails u join ##UserDetails_Rollback /* tempdb.UserDetails_Rollback */ rlbck on u.uID = rlbck.uID


/*

-- Find records with both codes in the uAreasofInterest: 08000 and 02400,
-- remove 02400
select *--replace(uAreasofInterest, '02400|', '*')
from [NewCentralUsers].[dbo].[UserDetails]
where uAreasofInterest like '%|08000|%' and uAreasofInterest like '%|02400|%'

-- Find records with 02400 only and replace it with 08000
select replace(uAreasofInterest, '02400|', '*08000|*')
from [NewCentralUsers].[dbo].[UserDetails]
where uAreasofInterest like '%|02400|%'

*/

/*

-- verify usage
-- areas for interest for publications (5 , 208)
SELECT TOP (1000) [aoiID]
      ,[aoiPID]
      ,[aoiTitle]
      ,[aoiEdenCode]
  FROM [NewCentralUsers].[dbo].[AreasOfInterest]
  where aoiedencode in ('02400', '08000' )

-- list publications
  SELECT *
  FROM [NewCentralUsers].[dbo].[Publications]
  where pid in (5, 208)

-- 
select *
  from EdenGroupCodes gc
    join EdenCode c on gc.egcCodeId = c.edcCodeID
    join EdenGroup g on g.edgGroupID = gc.egcGroupID
  where c.edcCodeID in (4141,4418,4641,5241,7297,7641)
  and edgGroupId = 81

*/