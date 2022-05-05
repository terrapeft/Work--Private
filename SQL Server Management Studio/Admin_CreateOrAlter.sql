/*
*
*
*
*
**************************** Admin ******************************
*
*
*
*/


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE [Admin]
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