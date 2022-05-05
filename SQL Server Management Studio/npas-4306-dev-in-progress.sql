/*
SELECT pID, pName, pURL, pProfitCentre, *
FROM dbo.Publications
WHERE pSource = 'QSS'
AND pFeedActive = 1
AND pProfitCentre LIKE '%MBW%'
*/

/*

  SELECT TOP (1000) sid,suid,pid,pname,pprofitcentre,psource,sstatus,st.*
  FROM Subscriptions s join Publications p on s.sPID = p.pID join statuses st on p.pID = st.stPID
  where pid = 278--225
  --and sstatus = 2282
  --order by screationdate desc
  */


SELECT P.pName, P.pURL, P.pID, P.pProfitCentre, S.sStatus, COUNT(*)
FROM dbo.Subscriptions S
	JOIN dbo.Publications P ON S.sPID = P.pID
WHERE pID NOT IN(370, 173, 311, 501, 172) -- HFI Publications not longer part of EM
AND P.pSource = 'QSS'
AND P.pFeedActive = 1
and p.pprofitcentre in ('MAI', 'MBA', 'MBO', 'MBP', 'MBS', 'MBT', 'MBW', 'MCE', 'MCS', 'MCT', 'MCX', 'MDF', 'MDO', 'MDS', 'MEX', 'MFA', 'MFM', 'MGC', 'MIG', 'MII', 'MIJ', 
'MIN', 'MIO', 'MLC', 'MLE', 'MLI', 'MLM', 'MMF', 'MNA', 'MNY', 'MOA', 'MOG', 'MPA', 'MPF', 'MRA', 'MRD', 'MRF', 'MRN', 'MSD', 'MSH', 'MSI', 'MSS', 'MST', 'MSW', 'MVD', 'MVE', 'MVI', 'MVN',
 'MVO', 'MVP', 'MVY', 'MWS', 'MWT')
GROUP BY P.pID, P.pName, P.pURL, P.pProfitCentre, S.sStatus
ORDER BY P.pName

/*

select distinct pid, /*pname, */ p.pprofitcentre/*, sStatus*/
FROM dbo.Subscriptions S
	JOIN dbo.Publications P ON S.sPID = P.pID
WHERE pID NOT IN(370, 173, 311, 501, 172) -- HFI Publications not longer part of EM
AND P.pSource = 'QSS'
AND P.pFeedActive = 1
--and p.pprofitcentre = 'MBW'
and p.pprofitcentre in ('MAI', 'MBA', 'MBO', 'MBP', 'MBS', 'MBT', 'MBW', 'MCE', 'MCS', 'MCT', 'MCX', 'MDF', 'MDO', 'MDS', 'MEX', 'MFA', 'MFM', 'MGC', 'MIG', 'MII', 'MIJ', 
'MIN', 'MIO', 'MLC', 'MLE', 'MLI', 'MLM', 'MMF', 'MNA', 'MNY', 'MOA', 'MOG', 'MPA', 'MPF', 'MRA', 'MRD', 'MRF', 'MRN', 'MSD', 'MSH', 'MSI', 'MSS', 'MST', 'MSW', 'MVD', 'MVE', 'MVI', 'MVN',
 'MVO', 'MVP', 'MVY', 'MWS', 'MWT')
order by pprofitcentre, pid

19 out of 53

MBA
MBO
MBS
MBW
MCT
MFA
MGC
MIG
MII
MIJ
MIN
MNA
MPA
MSD
MSS
MST
MSW
MWS
MWT



*/

/*
SELECT top 1000 pid, stname, stmask, pname, pshortname, pProfitCentre, psource, pParentPublicationID, pIsActive, pFeedActive, n.*
FROM dbo.Statuses s 
join Publications p on s.stPID = p.pID
join Subscriptions n on n.sPID = p.pID
WHERE stPID in (/*370, 311, 501, 172*/ 47, 155, 57, 2, 68, 225, 262, 417, 264, 341, 334, 335, 336, 337, 339, 340, 365, 384, 404, 414, 223, 371, 372, 295, 296, 293, 294, 292, 297, 
330, 253, 116, 114, 105, 112, 107, 106, 139, 198, 12, 333, 42, 315, 345, 346, 59, 306, 323, 17, 317, 318, 397, 49, 357, 310, 242, 320, 277, 278, 168, 170, 179, 500, 171, 37, 347, 
348, 415, 266, 5022, 5010, 5011, 5012, 5013, 5014, 5018, 5019, 5020, 5021, 5015, 261, 71, 72, 73, 74, 76, 77, 79, 80, 81, 159, 292, 69, 208, 305, 7, 211, 216, 217, 219, 230, 231, 
234, 236, 235, 233, 319)

*/