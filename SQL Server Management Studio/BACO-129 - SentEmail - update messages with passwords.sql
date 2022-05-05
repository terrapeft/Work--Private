use BackOffice

drop table if exists #includes

-- Subjects where message doesn't include password
select *
into #excludes
from (values
	('Welcome to Managing Intellectual Property'),
	('Welcome to FO World'),
	('Subject : Welcome to Industrial Minerals'),
	('Subject : Have you used all the features from Industrial Minerals?'),
	('Subject : Welcome to Global Telecoms Business'),
	('Welcome to GlobalCapital'),
	('Subject : Welcome to Global Telecoms Business'),
	('Subject : Welcome to FOW')
) e (subj)


update SentEmail set 
[Message] = 'The original text has been replaced to remove passwords.'
from SentEmail
where not contains([Message], '"Password: &nbsp;"')
and SentEmailTypeId = 2


update SentEmail set 
[Message] = 'The original text has been replaced to remove passwords.'
from SentEmail
where 
	contains([Message], 'password')
	and not contains([Message], '"create a password"')
	and not contains([Message], '"password combination"')
	and not contains([Message], '"set your password"')
	and not contains([Message], '"Reset your password here"')
	and not contains([Message], '"/password/reset?"')
	and not contains([Message], '"/password/set?"')
	and not contains([Message], '"/passwordReminder"')
	and not contains([Message], '"/password-reminder"')
	and not contains([Message], '"Invalid Username or password"')
	and not contains([Message], '"</strong> N test"')
	and not contains([Message], '"Invalid Username and/or password "')
	and not contains([Message], '"your username and/or password are incorrect"')
	and not contains([Message], '"user.with.interesting.password.1@nbo.pl"')
	and not contains([Message], '"please enter the password"')
	and not contains([Message], '"Confirm Password."')
	and [Subject] not in (select subj from #excludes)
	and SentEmailTypeId <> 2



select count(*)
from SentEmail
where contains([Message], '"The original text has been replaced to remove passwords"')


select top 1000 *
from SentEmail
where contains([Message], '"password"')

