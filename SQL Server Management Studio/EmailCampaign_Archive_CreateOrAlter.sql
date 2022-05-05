/*
*
*
*
*
**************************** EmailCampaign_Archive ******************************
*
*
*
*/


USE [EmailCampaign_Archive]
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