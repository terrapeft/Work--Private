SELECT top 1000 pid, stname, stmask, pname, pshortname, pProfitCentre, psource, pParentPublicationID, pIsActive, pFeedActive, n.*
FROM dbo.Statuses s 
join Publications p on s.stPID = p.pID
join Subscriptions n on n.sPID = p.pID

WHERE stPID in (47, 155, 57, 2, 68, 225, 262, 417, 264, 341, 334, 335, 336, 337, 339, 340, 365, 384, 404, 414, 223, 371, 372, 295, 296, 293, 294, 292, 297, 330, 253, 116, 114, 105, 112, 107, 106, 139, 198, 12, 333, 42, 315, 345, 346, 59, 306, 323, 17, 317, 318, 397, 49, 357, 310, 242, 320, 277, 311, 370, 278, 168, 170, 179, 501, 500, 171, 172, 37, 347, 348, 415, 266, 5022, 5010, 5011, 5012, 5013, 5014, 5018, 5019, 5020, 5021, 5015, 261, 71, 72, 73, 74, 76, 77, 79, 80, 81, 159, 292, 69, 208, 305, 7, 211, 216, 217, 219, 230, 231, 234, 236, 235, 233, 319)
--and pProfitCentre = 'mbp'
--where pProfitCentre = 'mbw' --or stpid = 5010
