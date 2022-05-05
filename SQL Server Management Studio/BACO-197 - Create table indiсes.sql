use backoffice

create index IX_UserContactPreferences
on Backoffice.Audit.UserContactPreferences(UserId)
go

create index IX_UserContactPreferences_2
on Backoffice.Audit.UserContactPreferences(CreatorUserId)
go
