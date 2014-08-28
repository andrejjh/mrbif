create table OCN_occ (id integer primary key,NomScientifique text, Auteur text, Année integer,NomFR text,NomVer text,Localité text,Latitude real ,Longitude real ,date text,Observateur text);
drop table OCN_occ;
/* Query */
select count(*), date from OCN_occ group by date;
select count(*), date, observateur from OCN_occ group by date, observateur;

drop view OCN_DwC;
create view OCN_DwC as select
  'HumanObservation' as basisOfRecord,
  'urn:MRBIF:ENSN:OCN:' || printf('%05d',id) as occurrenceID,
  id as catalogNumber,
  NomScientifique || ', ' || Auteur || ' ' || Année as scientificName,
  'ICZN' as nomenclatureCode,
  'Crocodylidae' as family,
  case date when ('2000s') then '2000/2009' else date end as evenDate,
  printf('%3.3f',latitude) as decimalLatitude,
  printf('%3.3f',longitude) as decimalLongitude,
  'WGS84' as geodeticDatum,
  'MR' as countryCode,
  Localité as locality,
  Observateur as observer
   from OCN_occ;

select * from OCN_DwC;
