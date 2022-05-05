EXEC msdb..sp_send_dbmail @profile_name='UK-SQLCLUSTER-02',
@recipients='np-tsmith@Euromoneyplc.com;fmir@Euromoneyplc.com;pdawson@Euromoneyplc.com;Michael.Guy@euromoneyplc.com',
@subject='Missing Contact Data in NBO Report',
@body_format = 'HTML',
@body='Missing Contact Data in NBO  Report',

 


@query= 'SELECT U.uID,U.uusername as NCU_UserName, NBO.username as NBO_UserName, U.utitle as NCU_Title, NBO.Title as NBO_Title,
U.uCreationDate, U.uCreatedBy, U.uUpdateDate,NBO.DateTimeCreated as [NBO Update Date], 
U.uUpdatedBy,NBO.contactid,
CASE WHEN s.sUID IS NOT NULL THEN ''YES'' ELSE ''NO'' END as [Has sub], p.pName,S.sCreationDate,s.sUpdateDate,
CASE WHEN (C.cmMasterSubID IS NOT NULL OR I.iprSubscriptionID IS NOT NULL) OR 
           CD.cmdDonorSubID IS NOT NULL THEN ''YES'' ELSE ''NO'' END AS [KeyAccount],
CASE WHEN C.cmMasterSubID IS NOT NULL OR I.iprSubscriptionID IS NOT NULL THEN ''YES'' ELSE ''NO'' END AS [MasterKeyAccount/IPRange],
CASE WHEN CD.cmdDonorSubID IS NOT NULL THEN ''YES'' ELSE ''NO'' END AS [Donor]
FROM NewCentralUsers.dbo.UserDetails U 
JOIN 
(SELECT
            u.UserId
            ,u.UserName
            ,u.EncryptPassword
            ,u.IsLockedOut
            ,u.UserTypeId
            ,c.Forenames
            ,c.Surname
            ,c.Initials
            ,c.TitleId
            ,c.contactid
            ,t.Title
            ,e.EmailAddress
            ,uca.UserContactAddressId
            ,uca.DateTimeCreated
      FROM
            Backoffice.Logon.Users u
      LEFT JOIN
            Backoffice.Logon.UserDefaultCommunication udc
                  ON u.UserId = udc.UserId
      LEFT JOIN
            Backoffice.Customer.Contact c
                  ON udc.ContactId = c.ContactId
      LEFT JOIN
            Backoffice.Customer.Title t
                  On c.TitleId = t.TitleId
      LEFT JOIN
            Backoffice.Customer.ActiveUserContactAddress auca
                  ON udc.ActiveUserContactAddressId = auca.ActiveUserContactAddressId
      LEFT JOIN
            Backoffice.Customer.UserContactAddress uca
                  ON auca.UserContactAddressId = uca.UserContactAddressId
      LEFT JOIN
            Backoffice.Customer.EmailAddress e
                  ON uca.EmailAddressId = e.EmailAddressId) NBO 
                 ON NBO.UserId = U.uID
LEFT JOIN NewCentralUsers.dbo.subscriptions S ON S.sUID = U.uID
LEFT JOIN NewCentralUsers.dbo.Publications P on P.pID = S.sPID
LEFT JOIN NewCentralUsers.dbo.CAPMaster C ON C.cmMasterSubID = s.sID
LEFT JOIN NewCentralUsers.dbo.IPRanges I ON I.iprSubscriptionID = s.sID
LEFT JOIN NewCentralUsers.dbo.CAPMasterDonor CD ON CD.cmdDonorSubID = s.sID
WHERE U.uID in 
(SELECT UserId FROM Backoffice.Logon.UserS  WHERE UserTypeId not in (1, 11)

 

EXCEPT

 

SELECT Userid FROM Backoffice.Logon.UserDefaultCommunication
)
--ORDER BY NBO_UserName
'
,@attach_query_result_as_file = 1
,@query_result_no_padding = 1 
,@query_attachment_filename = 'MissingContactData.csv' 
,@query_result_width = 1000 -- set query result width
,@query_result_separator ='    ' --this is a tab in between the quotes not a space
,@append_query_error = 1