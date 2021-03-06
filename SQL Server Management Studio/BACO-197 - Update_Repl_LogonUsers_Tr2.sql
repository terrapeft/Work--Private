USE [BackOffice]
GO
/****** Object:  Trigger [Logon].[Update_Repl_LogonUsers_Tr2]    Script Date: 2020-03-23 12:47:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [Logon].[Update_Repl_LogonUsers_Tr2]
   ON  [Logon].[Users]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @Cinfo VARBINARY(128)  
SELECT @Cinfo = Context_Info()  
IF @Cinfo != 0x55555 OR @Cinfo IS NULL
 
BEGIN

--IF OBJECT_ID('tempdb..##LogonUsers_Insert') IS NOT NULL DROP TABLE ##LogonUsers_Insert
/*
CREATE TABLE Interim.[LogonUsers_Stage](
		[UserId] [int] NOT NULL,
	[UserName] [varchar](254) NOT NULL,
	[EncryptPassword] [nvarchar](25) NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[UserTypeId] [tinyint] NOT NULL,
	[ActionCode] nvarchar(1),
	ProcessNum tinyint)*/
IF UPDATE([UserId]) OR UPDATE([UserName]) OR UPDATE([EncryptPassword])

BEGIN

BEGIN TRANSACTION LUITRAN	
INSERT INTO Interim.[LogonUsers_Stage] ([UserId],[UserName],[EncryptPassword],[IsLockedOut]
		,[UserTypeId],[ActionCode],[ProcessNum])
SELECT I.[UserId]
      ,I.[UserName]
      ,RIGHT(NEWID(),10)
      ,I.[IsLockedOut]
      ,I.[UserTypeId], 'U' as Inserted, 0 as ProcessNum  
FROM INSERTED I
WHERE I.[UserTypeId] <> 11

UPDATE U
SET EncryptPassword = dbo.Encrypt(RIGHT(NEWID(),10))
FROM Logon.Users U
	JOIN INSERTED I ON I.UserId = U.UserId

COMMIT TRANSACTION LUITRAN;

END

--EXEC MSDB.dbo.sp_start_job 'Repl_Insert_Addresses'
END
END
