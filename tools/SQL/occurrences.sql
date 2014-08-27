create table OCN_occ (NomScientifique text, Auteur text, Année integer,NomFR text,NomVer text,Localité text,Latitude real ,Longitude real ,date text,Observateur text);
drop table OCN_occ;
/* Query */
select count(*), date from OCN_occ group by date;
select count(*), date, observateur from OCN_occ group by date, observateur;
