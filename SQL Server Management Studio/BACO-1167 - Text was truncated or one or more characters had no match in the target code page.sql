use BackOffice
/*

https://stackoverflow.com/questions/43148767/sql-server-remove-all-non-printable-ascii-characters
https://social.msdn.microsoft.com/Forums/sqlserver/en-US/8c9c1d45-82d5-43bf-961b-a8e22dab221b/ssis-error-text-was-truncated-or-one-or-more-characters-had-no-match-in-the-target-code-page?forum=sqlintegrationservices

*/

select distinct aCompany, replace('OE test - oe', char(140), 'x') as test
from ( 
SELECT distinct V.[uUserName], REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(V.[aCompany], 
CHAR(0), '[CHAR(0)]'), 
CHAR(1), '[CHAR(1)]'), 
CHAR(2), '[CHAR(2)]'), 
CHAR(3), '[CHAR(3)]'), 
CHAR(4), '[CHAR(4)]'), 
CHAR(5), '[CHAR(5)]'), 
CHAR(6), '[CHAR(6)]'), 
CHAR(7), '[CHAR(7)]'), 
CHAR(8), '[CHAR(8)]'), 
CHAR(9), '[CHAR(9)]'), 
CHAR(10), '[CHAR(10)]'), 
CHAR(11), '[CHAR(11)]'), 
CHAR(12), '[CHAR(12)]'), 
CHAR(13), '[CHAR(13)]'), 
CHAR(14), '[CHAR(14)]'), 
CHAR(15), '[CHAR(15)]'), 
CHAR(16), '[CHAR(16)]'), 
CHAR(17), '[CHAR(17)]'), 
CHAR(18), '[CHAR(18)]'), 
CHAR(19), '[CHAR(19)]'), 
CHAR(20), '[CHAR(20)]'), 
CHAR(21), '[CHAR(21)]'), 
CHAR(22), '[CHAR(22)]'), 
CHAR(23), '[CHAR(23)]'), 
CHAR(24), '[CHAR(24)]'), 
CHAR(25), '[CHAR(25)]'), 
CHAR(26), '[CHAR(26)]'), 
CHAR(27), '[CHAR(27)]'), 
CHAR(28), '[CHAR(28)]'), 
CHAR(29), '[CHAR(29)]'), 
CHAR(30), '[CHAR(30)]'), 
CHAR(31), '[CHAR(31)]'), 
CHAR(127), '[CHAR(127)]'), 
CHAR(128), '[CHAR(128)]'), 
CHAR(129), '[CHAR(129)]'), 
CHAR(130), '[CHAR(130)]'), 
CHAR(131), '[CHAR(131)]'), 
CHAR(132), '[CHAR(132)]'), 
CHAR(133), '[CHAR(133)]'), 
CHAR(134), '[CHAR(134)]'), 
CHAR(135), '[CHAR(135)]'), 
CHAR(136), '[CHAR(136)]'), 
CHAR(137), '[CHAR(137)]'), 
CHAR(138), '[CHAR(138)]'), 
CHAR(139), '[CHAR(139)]'), 
CHAR(140), '[CHAR(140)]'), 
CHAR(141), '[CHAR(141)]'), 
CHAR(142), '[CHAR(142)]'), 
CHAR(143), '[CHAR(143)]'), 
CHAR(144), '[CHAR(144)]'), 
CHAR(145), '[CHAR(145)]'), 
CHAR(146), '[CHAR(146)]'), 
CHAR(147), '[CHAR(147)]'), 
CHAR(148), '[CHAR(148)]'), 
CHAR(149), '[CHAR(149)]'), 
CHAR(150), '[CHAR(150)]'), 
CHAR(151), '[CHAR(151)]'), 
CHAR(152), '[CHAR(152)]'), 
CHAR(153), '[CHAR(153)]'), 
CHAR(154), '[CHAR(154)]'), 
CHAR(155), '[CHAR(155)]'), 
CHAR(156), '[CHAR(156)]'), 
CHAR(157), '[CHAR(157)]'), 
CHAR(158), '[CHAR(158)]'), 
CHAR(159), '[CHAR(159)]'), 
CHAR(160), '[CHAR(160)]') + ' - ORIG:[' + v.aCompany + ']' as aCompany
 FROM [dbo].[VW_NBOAddresses]  V
JOIN Interim.[UserContactAddress_Stage] UCS ON
UCS.UserId = V.auid AND UCS.AddressId = V.aId AND
UCS.ParentUserContactAddressId IS NOT NULL
) q
where aCompany like '%CHAR(%'




/*
SELECT distinct top 200 aCompany
 FROM [dbo].[VW_NBOAddresses]  V
JOIN Interim.[UserContactAddress_Stage] UCS ON
UCS.UserId = V.auid AND UCS.AddressId = V.aId AND
UCS.ParentUserContactAddressId IS NOT NULL
where aCompany like '%oe%'
*/