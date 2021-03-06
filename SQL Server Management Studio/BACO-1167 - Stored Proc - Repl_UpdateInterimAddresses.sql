USE [NewCentralUsers]
GO
/****** Object:  StoredProcedure [dbo].[Repl_UpdateInterimAddresses]    Script Date: 2021-01-29 11:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Repl_UpdateInterimAddresses] (
	@UserContactAddress int,
	@aID int  ,
	@pId int,
	@aUID int ,
	@UserName varchar(100) ,
	@ForeNames nvarchar(150) ,
	@Surname nvarchar(100) ,
	@utitle varchar(150),
	@aJobTitle nvarchar(100) ,
	@aCompany nvarchar(150) ,
	@aAddress1 nvarchar(250) ,
	@aAddress2 nvarchar(250) ,
	@aAddress3 nvarchar(250) ,
	@aCity nvarchar(150) ,
	@aCounty nvarchar(50) ,
	@aState nvarchar(50) ,
	@aPostCode nvarchar(50) ,
	@aCID int ,
	@aTel nvarchar(50) ,
	@aFax nvarchar(50) ,
	@aMobTel nvarchar(50) ,
	@EmailAddress varchar(150) ,
	@aCreationDate datetime  ,
	@aCreatedBy varchar(50) ,
	@aUpdatedDate datetime ,
	@aUpdatedBy varchar(50) ,
	@aActive bit  ,
	@aDefault bit  ,
	@aSessionID int ,
	@aUpdateReason nvarchar(100) 
)
AS



BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--------------------------------------------------------
--Logic to Get Original AddressId Corresponding to NCU
--------------------------------------------------------

--DECLARE @pId as int
/*
DECLARE @a1Id as int
While @pId IS NOT NULL
BEGIN
Select @pId = ParentUserContactAddressId, @a1Id = AddressId
 from customer.UserContactAddress where UserContactAddressId = @pId
END
*/
SET Context_Info 0x55555 
DECLARE @a1Id as int
SELECT @a1Id = addressid from [SQL-NBO-CMS].BackOffice.INTERIM.AddressUCAMap 
where userid = @auid AND usercontactaddressid = @UserContactAddress


--------------------------------------------------------------
--End of Logic to Get Original AddressId Corresponding to NCU
--------------------------------------------------------------



UPDATE dbo.Addresses 
SET 
        [aJobTitle] = @aJobTitle
      , [aCompany] = @aCompany
      , [aAddress1] = @aAddress1
      , [aAddress2] = @aAddress2
      , [aAddress3] = @aAddress3
      , [aCity] = @aCity
      , [aCounty] = @aCounty
      , [aState] = @aState
      , [aPostCode] = @aPostCode
      , [aCID] = @aCID
      , [aTel] = @aTel
      , [aFax] = @aFax
      , [aMobTel] = @aMobTel
      , [aCreationDate] = @aCreationDate
      , [aCreatedBy] = @aCreatedBy
      , [aUpdatedDate] = @aUpdatedDate
      , [aUpdatedBy] = @aUpdatedBy
      , [aActive] = @aActive
      , [aDefault] = @aDefault
      , [aSessionID] = @aSessionID
      , [aUpdateReason] = @aUpdateReason
--FROM dbo.Addresses IA 
--INNER remote  JOIN 
--dbo.VW_NBOAddresses V ON  V.aUId =  aUId
Where  aID = @a1Id and  aUID = @aUID 
--and V.aID = @aID

------------------------------------
--Logic to Insert OldUserName
------------------------------------
DECLARE @oldUserName varchar(100)
DECLARE @IUserName varchar(100)
SELECT @oldUserName = uusername, @IUserName = uUserName
FROM dbo.UserDetails WHERE uId = @aUId

If @IUserName = @UserName 
BEGIN
 SELECT @OldUserName = uOldUserName FROM dbo.UserDetails WHERE uId = @aUId
END

---------------------------------------
--End Of OldUserName Logic
---------------------------------------

UPDATE dbo.UserDetails
SET		
       [uUsername] = @UserName
      ,[uEmailAddress] = @EmailAddress
      ,[uForenames] = @ForeNames
	  ,[uTitle] = @utitle
      ,[uSurname] = @Surname
      ,[uCompany] = @aCompany
      ,[uJobTitle] = @aJobtitle
      ,[uUpdateDate] = @aUpdatedDate
      ,[uUpdatedBy] = @aUpdatedBy
      ,[userid] = @aUId
      ,[uOldusername] = @OldUserName
      ,[uUpdateComment] = 'Replication from NBO'
--FROM dbo.UserDetails IU 
--INNER remote JOIN
--dbo.VW_NBOAddresses V ON V.aUId = IU.UId
Where uid = @aUID


END
