USE [BackOffice]
GO
/****** Object:  Trigger [Customer].[Repl_Delete_AUCA_Tr2]    Script Date: 2020-12-03 12:59:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [Customer].[Repl_Delete_AUCA_Tr2]
   ON   [Customer].[ActiveUserContactAddress]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @Cinfo VARBINARY(128)  
SELECT @Cinfo = Context_Info()  
IF @Cinfo != 0x55555 OR @Cinfo IS NULL
 
BEGIN
    -- Insert statements for trigger here

INSERT INTO INTERIM.[ActiveUserContacAddress_Stage] ([ActiveUserContactAddressId]
      ,[UserContactAddressId]
      ,[ContactAddressTagId]
      ,[ActionCode]
      ,[ProcessNum])
Select D.*,'D',0 
from DELETED D 
join Customer.UserContactAddress uca on d.usercontactaddressid = uca.usercontactaddressid
join Logon.Users u on uca.userid = u.userid
where u.usertypeid <> 11




END
END
