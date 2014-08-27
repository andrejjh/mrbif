create unique index occgbifID on occurrences (gbifID);
create view occLite as select gbifID, family, scientificName, eventDate, day, month, year,locality, decimalLatitude, decimalLongitude, publishingCountry from occurrences order by scientificName;
drop view occLite;

create unique index vergbifID on verbatim (gbifID);
create view verLite as select gbifID, family, scientificName, verbatimEventDate, day, month, year, verbatimLocality, verbatimLatitude, verbatimLongitude from verbatim order by scientificName;
drop view verLite;

create view allLite as select v.gbifID, o.family as oFamily, v.family as vFamily, o.scientificName as oScientificName, v.scientificName as vScientificName, o.eventDate as oEventDate, v.eventDate as vEventDate from occurrences o left join verbatim v on v.gbifid=o.gbifid; 


select * from occLite where eventDate != '';
select * from occLite where scientifName != '';
select * from occLite where decimalLatitude != '';

select * from allLite;
