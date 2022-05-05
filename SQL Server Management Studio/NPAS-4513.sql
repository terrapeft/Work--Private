select top 100
    mpd.PackDetailsID,
	/* media pack status fields below */
	msd.ActionDefID,
	msd.ActionName,
	eua.UserID [ActionUserId], 
	eua.DisplayName [ActionUserDisplayName], 
	eua.Email [ActionUserEmail],
	ms.ActionDate,
	ms.ActionComments,
    /* media pack details fields below */
	mpd.PackID,
	mp.PackDescription,
	mpd.PackYear,
    mpd.PackStatusID,
    mpd.PackIsHistorical,
    mpd.PackName,
    mpd.PackDisplayName,
    mpd.PackUploadDate,
	eur.UserID [RequesterUserId], 
	eur.DisplayName [RequesterDisplayName], 
	eur.Email [RequesterEmail],
	euc.UserID [CirculationUserId], 
	euc.DisplayName [CirculationDisplayName], 
	euc.Email [CirculationEmail],
	eud.UserID [DirectorUserId], 
	eud.DisplayName [DirectorDisplayName], 
	eud.Email [DirectorEmail],
    mpd.PackFilePath,
    mpd.ReplacedPackDetailsID,
	/* business region fields */
	mb.BusinessName,
	mr.RegionName
from MediaPacksDetails mpd 
	join MediaPacks mp on mpd.PackID = mp.PackID
	join MediaBusinesses mb on mpd.PackBusinessID = mb.BusinessID
	join MediaRegions mr on mr.RegionID = mb.BusinessRegionID
	join MediaStatuses ms on mpd.PackDetailsID = ms.StatusPackDetailsID
	join MediaStatusesDefs msd on msd.ActionDefID = ms.StatusDefID
	join [Admin].[dbo].[ET_Users] eur on eur.UserID = mpd.PackRequesterUserID
	join [Admin].[dbo].[ET_Users] eua on eua.UserID = ms.ActionUserID
	join [Admin].[dbo].[ET_Users] euc on euc.UserID = mpd.PackCirculationUserID
	join [Admin].[dbo].[ET_Users] eud on eud.UserID = mpd.PackDirectorUserID
where 
    /* 
		1 = Waiting for approval by circulation, 
		2 = Waiting for approval by director, 
		5 = Approved 
	*/
	ActionDefID in (1, 2, 5) 