USE [NewCentralUsers]
GO
/****** Object:  Trigger [dbo].[Insert_Repl_Users_Tr2]    Script Date: 05-Dec-18 14:59:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*************************************************************************************************
Deletes data from connected tables
*************************************************************************************************
Version n.m.e	Change by		Date Updated		Change Description
-------------	-------------	------------------	---------------------------------------------
1.0.0												Original
1.0.1			rszytula		17/07/2017			set random password in Logon.Users
*************************************************************************************************
*/

ALTER TRIGGER [dbo].[Insert_Repl_Users_Tr2] 
   ON  [dbo].[UserDetails]
   AFTER INSERT NOT FOR REPLICATION
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--IF OBJECT_ID('tempdb..##UserDetails') IS NOT NULL DROP TABLE ##UserDetails
	DECLARE @Cinfo VARBINARY(128)  
	SELECT @Cinfo = Context_Info()  
	IF @Cinfo != 0x55555 OR @Cinfo IS NULL
	BEGIN
		BEGIN TRY
			
			BEGIN TRANSACTION TranIUD

			INSERT INTO [dbo].[IdmPoll]
					([Id]
					,[Username]
					,[Password])
			SELECT [GUID]
					,[uUsername]
					,[uPassword]
			FROM INSERTED
	
			INSERT INTO dbo.[UserDetails_Stage]
			([uID],[uEclipseCustomerID] ,[uUsername],[uPassword],[uOldPassword]
				  ,[uEmailAddress],[uTitle],[uForenames],[uSurname],[uCompany],[uJobTitle]
				  ,[uCompanyType],[uIndustry],[uRegisteredVia],[uEuromoneyPhone]
				  ,[uEuromoneyFax],[uEuromoneyEmail],[uThirdParty],[uDPAConfirmed]
				  ,[uCreationDate],[uCreatedBy],[uUpdateDate],[uUpdatedBy]
				  ,[userid],[uComments] ,[GUID],[uAreasofInterest],[uHtmlEmail]
				  ,[uUpdateComment],[uQuestion],[uOldusername],[uFreeIssueID]
				  ,[uTestUser],[uHFIApproved],[uHFISubscriberID],[uDescription]
				  ,ActionCode,ProcessNum)
			 SELECT I.[uID]
				  ,I.[uEclipseCustomerID]
				  ,I.[uUsername]
				  ,RIGHT(NEWID(),10)
				  ,RIGHT(NEWID(),10)
				  ,I.[uEmailAddress]
				  ,I.[uTitle]
				  ,I.[uForenames]
				  ,I.[uSurname]
				  ,I.[uCompany]
				  ,I.[uJobTitle]
				  ,I.[uCompanyType]
				  ,I.[uIndustry]
				  ,I.[uRegisteredVia]
				  ,I.[uEuromoneyPhone]
				  ,I.[uEuromoneyFax]
				  ,I.[uEuromoneyEmail]
				  ,I.[uThirdParty]
				  ,I.[uDPAConfirmed]
				  ,I.[uCreationDate]
				  ,I.[uCreatedBy]
				  ,I.[uUpdateDate]
				  ,I.[uUpdatedBy]
				  ,I.[userid]
				  ,I.[uComments]
				  ,I.[GUID]
				  ,I.[uAreasofInterest]
				  ,I.[uHtmlEmail]
				  ,I.[uUpdateComment]
				  ,I.[uQuestion]
				  ,I.[uOldusername]
				  ,I.[uFreeIssueID]
				  ,I.[uTestUser]
				  ,I.[uHFIApproved]
				  ,I.[uHFISubscriberID]
				  ,I.[uDescription]
				  ,'I',0 FROM INSERTED I
			
			UPDATE U
			SET uPassword = RIGHT(NEWID(),10)
			FROM [dbo].[UserDetails] U
				JOIN INSERTED I ON I.uID = U.uID

			UPDATE U
			SET uOldPassword = RIGHT(NEWID(),10)
			FROM [dbo].[UserDetails] U
				JOIN INSERTED I ON I.uID = U.uID

			--EXEC MSDB.dbo.sp_start_job 'Repl_Insert_Users'

			--EXEC xp_cmdshell 'dtexec /f "C:\NBOSSIS\Finished Packages\UserDetails_AddressInsert.dtsx.dtsx"'

			COMMIT TRANSACTION TranIUD;
		END TRY
		BEGIN CATCH
			IF (@@TRANCOUNT > 0)
			BEGIN
				ROLLBACK TRANSACTION TranIUD
				PRINT 'Error detected, all changes reversed'
			END

			DECLARE @ErrorMessage NVARCHAR(4000);
			DECLARE @ErrorSeverity INT;
			DECLARE @ErrorState INT;

			SELECT
				@ErrorMessage = ERROR_MESSAGE(),
				@ErrorSeverity = ERROR_SEVERITY(),
				@ErrorState = ERROR_STATE();

			RAISERROR (@ErrorMessage, -- Message text.
						@ErrorSeverity, -- Severity.
						@ErrorState -- State.
						);
		END CATCH
	END
END
