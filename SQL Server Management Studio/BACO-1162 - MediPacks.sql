

select 
	PackName, PackDisplayName, PackBusinessID, BusinessName, PackUploadDate, 
	PackCirculationUserID, circ.DisplayName as [CirculationUserName], circ.Email as [CirculationUserEmail],
	PackDirectorUserID, dir.DisplayName as [DirectorUserName], dir.Email as [DirectorEmail],
	PackRequesterUserID, req.DisplayName as [RequestorUserName], req.Email as [RequestorEmail],
	PackFilePath

from [MediaPacks].dbo.MediaPacksDetails d
join [Admin].[dbo].[ET_Users] circ on d.PackCirculationUserID = circ.UserID
join [Admin].[dbo].[ET_Users] dir on d.PackDirectorUserID = dir.UserID
join [Admin].[dbo].[ET_Users] req on d.PackRequesterUserID = req.UserID
join [MediaPacks].[dbo].[MediaBusinesses] b on d.PackBusinessID = b.BusinessID

where packuploaddate > '2018-12-31'