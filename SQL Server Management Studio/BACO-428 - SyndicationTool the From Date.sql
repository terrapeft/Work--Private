use TheLibrary;

alter table Publication
drop column if exists FromYearsBack

alter table Publication
add FromYearsBack int

update Publication
set FromYearsBack = 2
where ShortName = 'IMAE'

