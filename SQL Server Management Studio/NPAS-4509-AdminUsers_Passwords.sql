use NewCentralUsers

alter table Admin_Users add 
	auRememberMeTokenHash varchar(64)
commit