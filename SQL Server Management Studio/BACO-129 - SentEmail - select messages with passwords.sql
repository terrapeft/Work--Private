use BackOffice

drop table if exists #includes
drop table if exists #excludes

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


-- Subjects where message includes password
-- exclude for clarity, temporarily
select *
into #includes
from (values
	('Your password for the Sovereign Wealth Center'),
	('Your Login Details for Steel First'),
	('Your password for Industrial Minerals Data | Fluorspar'),
	('Confirm password for Trial at Industrial Minerals'),
	('Confirm password for Trial at Industrial Minerals'),
	('Your password for Industrial Minerals Data | Fluorspar'),
	('Your password for Sovereign Wealth Center'),
	('Your FOW Trial'),
	('Welcome to your FOW online account'),
	('Password reminder for Capacity Intelligence'),
	('Welcome to Asiamoney'),
	('Your corporate trial')
) e (subj)


select *
from (

	select *
	from SentEmail
	where not contains([Message], '"Password: &nbsp;"')
	and SentEmailTypeId = 2

	union all

	select *
	from SentEmail
	where 
		contains([Message], 'password')
		and not contains([Message], '"create a password"')
		and not contains([Message], '"password combination"')
		and not contains([Message], '"set your password"')
		and not contains([Message], '"Reset your password here"')
		and not contains([Message], '"Password reset link"')
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

	-- exclude with passwords for clarity, temporarily:

		---and not contains([Message], '"Thank you for your interest in TP Week"')
		---and not contains([Message], '"following details to log on"')
		--and not contains([Message], '"following details to logon"')
		--and not contains([Message], '"following details to login"')
		---and not contains([Message], '"A password reminder was requested for you"')
		---and not contains([Message], '"A password reminder has been requested for you"')
		--and not contains([Message], '"use this username and password"')
		---and not contains([Message], '"credentials are below"')
		---and not contains([Message], '"Your log-in details are below"')
		--and not contains([Message], '"You will now have access to"')
		---and not contains([Message], '"You log in details for the"')
		---and not contains([Message], '"use the details below to log on"')
		---and not contains([Message], '"below password to complete your trial"')
		--and not contains([Message], '"use the following details to continue "')
		--and not contains([Message], '"use the following details to process"')
		--and not contains([Message], '"use the password below"')
		--and not contains([Message], '"Your password for the Industrial Minerals online information service is"')
		--and not contains([Message], '"use this to log into"')
		---and not contains([Message], '"login using your email address and password"')
		---and not contains([Message], '"Your login details to EuromoneyFXNews"')
		---and not contains([Message], '"Login to the Airfinance Network now"')
		--and not contains([Message], '"use this password to complete"')
		--and not contains([Message], '"login and start networking today:"')
		---and not contains([Message], '"find your login details below"')
		--and not contains([Message], '"Your login details to"')
		--and not contains([Message], '"Login now by visiting"')
		--and not contains([Message], '"TEST TEST KA"')
		--and not contains([Message], '"Password: %%ins3%%"')
		--and not contains([Message], '"Your password for Industrial"')
		and [Subject] not in (select subj from #excludes)
		--and [Subject] not in (select subj from #includes)
		and SentEmailTypeId <> 2
		--and SentDate > '1 Apr 2019'
) t1

order by SentDate desc


