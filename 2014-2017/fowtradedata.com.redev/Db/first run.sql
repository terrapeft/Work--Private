use UmbracoMembers;

-- update keys
exec UpdateDMKOnRestoreOnNewInstance 'DMK_UM2015'

-- change password
-- exec ChangeDMKPassword @oldPassword = 'DMK_UM2015', @newPassword = '#Your new password#'