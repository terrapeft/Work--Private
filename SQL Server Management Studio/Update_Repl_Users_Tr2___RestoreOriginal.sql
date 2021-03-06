USE [NewCentralUsers]
GO
/****** Object:  Trigger [dbo].[Update_Repl_Users_Tr2]    Script Date: 05-Dec-18 15:03:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[Update_Repl_Users_Tr2] 
   ON   [dbo].[UserDetails] 
   AFTER UPDATE NOT FOR REPLICATION
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @Cinfo VARBINARY(128)  
SELECT @Cinfo = Context_Info()  
IF @Cinfo != 0x55555 OR @Cinfo IS NULL
 
BEGIN
--IF OBJECT_ID('tempdb..##UserDetails') IS NOT NULL DROP TABLE ##UserDetails

BEGIN TRANSACTION TranUUD

IF UPDATE([uEuromoneyPhone]) OR  UPDATE([uEuromoneyFax]) OR 
	 UPDATE([uEuromoneyEmail]) OR UPDATE([uThirdParty])
BEGIN

	
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
      ,I.[uDescription],'C', 0 FROM INSERTED I

--EXEC MSDB.dbo.sp_start_job 'Repl_Insert_Users'

--EXEC xp_cmdshell 'dtexec /f "C:\NBOSSIS\Finished Packages\UserDetails_AddressInsert.dtsx.dtsx"'
END

IF  UPDATE([uID]) OR UPDATE([uEclipseCustomerID] ) OR UPDATE([uUsername]) OR UPDATE([uPassword]) OR 
		UPDATE([uOldPassword]) OR UPDATE([uEmailAddress]) OR UPDATE([uTitle]) OR UPDATE([uForenames]) 
		OR UPDATE([uSurname]) OR UPDATE([uCompany]) OR UPDATE([uJobTitle]) OR UPDATE([uCompanyType]) 
		OR UPDATE([uIndustry]) OR UPDATE([uRegisteredVia]) OR 
		UPDATE([uDPAConfirmed]) OR UPDATE([uCreationDate]) OR UPDATE([uCreatedBy]) OR 
		UPDATE([uUpdateDate]) OR UPDATE([uUpdatedBy]) OR UPDATE([userid]) OR UPDATE([uComments]) OR 
		UPDATE([GUID]) OR UPDATE([uAreasofInterest]) OR UPDATE([uHtmlEmail]) OR 
		UPDATE([uUpdateComment]) OR UPDATE([uQuestion]) OR UPDATE([uOldusername]) OR 
		UPDATE([uFreeIssueID]) OR UPDATE([uTestUser]) OR UPDATE([uHFIApproved]) OR 
		UPDATE([uHFISubscriberID]) OR UPDATE([uDescription]) 
BEGIN

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
      ,I.[uDescription],'U', 0 FROM INSERTED I


END

	UPDATE U 
	SET uPassword = RIGHT(NEWID(),10)
	FROM [dbo].[UserDetails] U
		JOIN INSERTED I ON I.uID = U.uID

COMMIT TRANSACTION TranUUD;

END
END

