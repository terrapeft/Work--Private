USE [NewCentralUsers]
GO
/****** Object:  StoredProcedure [dbo].[UserPermissionsUpsert]    Script Date: 2019-11-21 10:30:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[UserPermissionsUpsert] 
	@CreatedBy VARCHAR(200), 
	@PublicationId INT,
	@UserName VARCHAR(100),
	@Title VARCHAR(15),
	@Forenames VARCHAR(150),
	@Surname VARCHAR(100),
	@StartDate DATETIME,
	@EndDate DATETIME,
	@Permissions VARCHAR(2000)
AS
BEGIN

SET NOCOUNT ON

DECLARE @CheckPublicationId INT = NULL
DECLARE @itrPublicationId INT = 5023

SELECT @CheckPublicationId = [pID]
FROM [dbo].[Publications]
WHERE [pID] = @PublicationId

IF (@CheckPublicationId IS NULL)
BEGIN
	SELECT NULL AS userId, NULL AS publicationId, NULL As createdUser

	RETURN
END

DECLARE @BitMask INT = 0

DECLARE @IntLocation INT
WHILE (CHARINDEX(',', @Permissions, 0) > 0)
BEGIN
        SET @IntLocation = CHARINDEX(',', @Permissions, 0)      

        --LTRIM and RTRIM to ensure blank spaces are   removed
        SELECT @BitMask = @BitMask + [stMask] 
		FROM [dbo].[Statuses]
		WHERE [stName] = RTRIM(LTRIM(SUBSTRING(@Permissions, 0, @IntLocation)))
		AND [stPID] = @PublicationId
		
        SET @Permissions = STUFF(@Permissions, 1, @IntLocation, '') 
END

SELECT @BitMask = @BitMask + [stMask] 
FROM [dbo].[Statuses]
WHERE [stName] = RTRIM(LTRIM(@Permissions))
AND [stPID] = @PublicationId

BEGIN TRANSACTION;

BEGIN TRY

	DECLARE @userId INT = NULL
	DECLARE @CreatedUser BIT = 0

	SELECT @userId = [uID]
	FROM dbo.[UserDetails]
	WHERE uEmailAddress = @UserName

	IF (@userId IS NULL)
	BEGIN
		INSERT INTO [dbo].[UserDetails] (
			[uUsername],
			[uEmailAddress],
			[uPassword],
			[uTitle],
			[uForenames],
			[uSurname],
			[uCreatedBy])
		VALUES (
			@UserName,
			@UserName,
			RIGHT(NEWID(),10),
			@Title,
			@Forenames,
			@Surname,
			@CreatedBy)

		SELECT @userId = @@IDENTITY, @CreatedUser = 1
	END
	ELSE
	BEGIN
		DELETE G
		FROM [dbo].[GUIDValues] G
			JOIN [dbo].[Subscriptions] S ON G.[gSID] = S.[sID] 
				AND S.[sPID] = @publicationId 
				AND S.[sUID] = @userId

		DELETE C
		FROM [dbo].[ConcurrentSessions] C
			JOIN [dbo].[Subscriptions] S ON C.[SubscriptionID] = S.[sID] 
				AND S.[sPID] = @publicationId 
				AND S.[sUID] = @userId

		DELETE SC
		FROM [dbo].[SalesContactLink] SC
			JOIN [dbo].[Subscriptions] S ON SC.[sID] = S.[sID] 
				AND S.[sPID] = @publicationId 
				AND S.[sUID] = @userId

		DELETE C
		FROM [dbo].[CAPMasterDonor] C
			JOIN [dbo].[Subscriptions] S ON C.[cmdDonorSubID] = S.[sID] 
				AND S.[sPID] = @publicationId 
				AND S.[sUID] = @userId

		DELETE C
		FROM [dbo].[CAPMasterDonor] C
			JOIN [dbo].[Subscriptions] S ON C.[cmdMasterSubID] = S.[sID] 
				AND S.[sPID] = @publicationId 
				AND S.[sUID] = @userId

		DELETE C
		FROM [dbo].[CAPMaster] C
			JOIN [dbo].[Subscriptions] S ON C.[cmMasterSubID] = S.[sID] 
				AND S.[sPID] = @publicationId 
				AND S.[sUID] = @userId

		DELETE I
		FROM [dbo].[IPRanges] I
			JOIN [dbo].[Subscriptions] S ON I.[iprSubscriptionID] = S.[sID] 
				AND S.[sPID] = @publicationId 
				AND S.[sUID] = @userId

		DELETE S
		FROM [dbo].[Subscriptions] S 
		WHERE S.[sPID] = @publicationId
		AND S.[sUID] = @userId
	END

	INSERT INTO [dbo].[Subscriptions]
		([sUID]
		,[sPID]
		,[sStartDate]
		,[sExpiryDate]
		,[sCreatedBy]
		,[sStatus])
	SELECT @userId
		,@PublicationId
		,@StartDate
		,@EndDate
		,@CreatedBy
		,@BitMask
	FROM [dbo].Statuses S
	WHERE S.stPID = @PublicationId
	AND S.stName IN(@Permissions)
	GROUP BY S.stPID

	/* BACO-313, Subscribe ITR trial users for all enabled newsletters */
	IF @PublicationId = @itrPublicationId
	BEGIN
		INSERT INTO Newsletters (nPublication, nUID, nNewsletterID, nPlain, nHTML)
		SELECT nlnPubID, @userId, nlnNewsletterID, 0, 1
		FROM [NewCentralUsers].[dbo].[NewsletterNames]
		WHERE [nlnPubID] = @PublicationId
	END

	SELECT @userId AS userId, @PublicationId AS publicationId, @CreatedUser As createdUser

END TRY
BEGIN CATCH

	SELECT 
		ERROR_NUMBER() AS ErrorNumber
		,ERROR_SEVERITY() AS ErrorSeverity
		,ERROR_STATE() AS ErrorState
		,ERROR_PROCEDURE() AS ErrorProcedure
		,ERROR_LINE() AS ErrorLine
		,ERROR_MESSAGE() AS ErrorMessage;

	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;

END CATCH;

IF @@TRANCOUNT > 0
	COMMIT TRANSACTION;

END
