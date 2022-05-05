/*
*
*
*
*
**************************** EmailCampaign ******************************
*
*
*
*/

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	Get Top 500 Campaign details by Manager IDs for Campaigns.asp
-- =============================================
CREATE OR ALTER PROCEDURE dbo.C_BusinessAdminByManagerID
	@baManagerID	int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select * From C_Business 
	 INNER JOIN C_BusinessAdmin on bIndex = baBusinessID
	 WHERE baManagerID = @baManagerID
	 ORDER BY bName

END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	Logon for business users
-- =============================================
CREATE OR ALTER PROCEDURE dbo.C_BusinessBybIndex 
	@bIndexID		int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM [C_Business] 
	WHERE bIndex = @bIndexID 

END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	Logon for business users
-- =============================================
CREATE OR ALTER PROCEDURE dbo.C_BusinessLogon 
	@bIndex		int = NULL, 
	@bUsername	nvarchar(50) = NULL,
	@bPassword	nvarchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM [C_Business] 
	WHERE bIndex = @bIndex AND bUsername = @bUsername AND bPassword = @bPassword 
	Order by bName 
END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	from uploadForm.asp
-- =============================================
CREATE OR ALTER PROCEDURE dbo.C_CampaignDataSourcesBycIndex
	@cIndex	int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT C_DataSources.*,C_Campaigns.cDescription as cDesc 
	FROM [C_Campaigns] 
	INNER JOIN C_DataSources ON C_DataSources.cIndex = C_Campaigns.cDataSource 
	WHERE C_Campaigns.cIndex = @cIndex

END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	Get Top 500 Campaign details by Manager IDs for Campaigns.asp
-- =============================================
CREATE OR ALTER PROCEDURE dbo.C_CampaignDetailsByManagerIDSelective 
	@cManagerID		int = NULL,
	@baManagerID	int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TOP 500 * FROM [C_Campaigns] 
	INNER JOIN C_Managers ON cManagerID = mIndex 
	WHERE cManagerID = @cManagerID
	AND [cRecuring] = 0 
	AND cStatus = 0 
	ORDER BY cIndex Desc

END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	Get Campaigns by Manager ID
-- =============================================
CREATE OR ALTER PROCEDURE dbo.C_CampaignsByManagerID 
	@ManagerID		int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM [C_Campaigns] 
	WHERE cManagerID = @ManagerID AND 
		 [cRecuring] = 0 AND 
		  cStatus = 0 AND 
		  cEnddate >= getdate() 
		  AND cHide = 0 
	ORDER BY [cIndex] DESC

END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	Get Top 500 Campaign details by Manager IDs for Campaigns.asp
-- =============================================
CREATE OR ALTER PROCEDURE dbo.C_DataSourcesBycBusiness
	@cBusiness	int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT C_DataSources.* FROM C_DataSources WHERE cBusiness = @cBusiness

END
GO

USE [EmailCampaign]
GO

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================
-- Author:		Vitaly Chupaev
-- Create date: 21-SEP-2018
-- Description:	Check if emails have been sent to the address
-- ===========================================================
CREATE OR ALTER PROCEDURE dbo.C_Mailinglist_CheckEmailAddress 
	@emailAddress nvarchar(150),
	@lastTwoWeeks bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	IF @lastTwoWeeks = 1
		SELECT CC.cIndex, CM.mIndex, CC.cDescription, CC.cTimeStamp, CB.bName, CM.Timesent, CM.ReturnedMailReason, CM.Unsubscribed, CM.Undeliverable, CM.PreFailed 
		FROM dbo.C_Mailinglist CM WITH (NOLOCK) 
		INNER Join [SQL-EMS-LIVE].EMailCampaign.dbo.C_Campaigns CC ON CM.CampaignID = CC.cIndex 
		INNER Join [SQL-EMS-LIVE].EMailCampaign.dbo.C_Business CB ON CC.cBusinessID = CB.bIndex 
		WHERE CM.EmailAddress = @emailAddress 
		AND ( 
                (cTimeStamp >= DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), 0)-14 AND cTimeStamp IS NOT NULL) 
                OR (cTimeSent >= DATEADD(dd, DATEDIFF(dd, 0, GETDATE()), 0)-14 AND cTimeSent IS NOT NULL) 
            ) 
		ORDER BY CC.cIndex DESC
	ELSE
		SELECT TOP 100 CC.cIndex, CM.mIndex, CC.cDescription, CC.cTimeStamp, CB.bName, CM.Timesent, CM.ReturnedMailReason, CM.Unsubscribed, CM.Undeliverable, CM.PreFailed 
		FROM dbo.C_Mailinglist CM WITH (NOLOCK) 
		INNER Join [SQL-EMS-LIVE].EMailCampaign.dbo.C_Campaigns CC ON CM.CampaignID = CC.cIndex 
		INNER Join [SQL-EMS-LIVE].EMailCampaign.dbo.C_Business CB ON CC.cBusinessID = CB.bIndex 
		WHERE CM.EmailAddress = @emailAddress 
		ORDER BY CM.TimeSent DESC
END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	Get Manager by Location
-- =============================================
CREATE OR ALTER PROCEDURE dbo.C_ManagersByLocation 
	@mLocation		int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM C_Managers 
	WHERE mLocation = @mLocation
	ORDER BY mName

END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	Get Manager by Manager ID
-- =============================================
CREATE OR ALTER PROCEDURE dbo.C_ManagersByManagerID 
	@mIndex		int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * From C_Managers Where mIndex = @mIndex

END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Brian Beer
-- Create date: 3-SEP-2018
-- Description:	schedule.asp selects..
-- =============================================
CREATE OR ALTER PROCEDURE dbo.EMSSchedule
	@StepID			int = NULL,
	@CampaignID		int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 IF @StepID ='1'
		SELECT * FROM [C_MailingList] Where CampaignID = @CampaignID

	 IF @StepID ='2'
		SELECT TimeSent,Count(mIndex) AS count2 FROM [C_Mailinglist] 
			WHERE TimeSent Is Not Null AND CampaignID = @CampaignID
			GROUP BY TimeSent 
			ORDER BY TimeSent ASC 

	 IF @StepID ='3'
		SELECT SendTime,Count(mIndex) AS count1 
			FROM [C_Mailinglist] 
			WHERE SendTime Is Not Null	AND 
			TimeSent Is Null			AND
			CampaignID = @CampaignID 
			GROUP BY SendTime 
			ORDER BY SendTime ASC

END
GO

USE [EmailCampaign]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

GO
-- =============================================
-- Author:		Chupaev Vitaly
-- Create date: 3-OCT-2019
-- Description:	Logon for CULT users
-- =============================================
CREATE OR ALTER PROCEDURE dbo.ET_UsersLogon 
	@bUsername	nvarchar(50) = NULL,
	@bPassword	nvarchar(50) = NULL,
	@bSecret	nvarchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT GP.PermSetting, U.UserID, U.Username, U.Password, U.DisplayName
	FROM ET_Users U WITH (NOLOCK)
	INNER JOIN UL2_UserPermissions UP WITH (NOLOCK) ON U.Userid = UP.Userid
	INNER JOIN UL2_Granular_Permissions GP WITH (NOLOCK) ON UP.Userid = GP.Userid and UP.ToolId = GP.ToolId
	WHERE U.username = @bUsername
	AND dbo.CompareTwoHashes(PasswordHash, dbo.GenerateHash(PasswordSalt, @bPassword, @bSecret)) = 1
	AND UP.ToolId = 30
	AND GP.PermName = 'DefaultEMSAccountID'
END
GO