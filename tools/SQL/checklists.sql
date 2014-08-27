/* Create Tables & Views */
create table LAM_Species (id integer primary key, origfamily text, origname text, scientificName text, rank text, family text, canonicalName text, confidence integer, matchType text);
/* Drop tables & Views */
drop table LAM_Species;
/* Populate table with data */
.mode csv
.header off
.separator ","
.import ../../data/LAM/LAMout.csv LAM_Species
/* Query */
select * from LAM_Species where origfamily != family;

/* Create Tables & Views */
create table LAV_Species (id integer primary key, origfamily text, origname text, namefr text, regions text, abundance text, scientificName text, rank text, family text, canonicalName text, confidence integer, matchType text);
/* Drop tables & Views */
drop table LAV_Species;
/* Populate table with data */
.mode csv
.header off
.separator ","
.import ../../data/LAV/LAVout.csv LAV_Species
/* Query */
select * from LAV_Species where origfamily != family;

/* Create Tables & Views */
create table LMA_Species (id integer primary key, origname text, origauthor text, origyear integer, nameFR text, scientificName text, rank text, family text, canonicalName text, confidence integer, matchType text);
CREATE VIEW LMA_exact AS select LMA.id AS id, LMA.scientificName AS scientificName, LMA.origauthor AS author, LMA.origyear AS year from LMA_Species LMA where matchType='EXACT';
CREATE VIEW LMA_others AS select LMA.id AS id, LMA.scientificName AS scientificName, LMA.origname AS name, LMA.origauthor AS author, LMA.origyear AS year, LMA.matchtype as matchtype from LMA_Species LMA where matchType!='EXACT';
/* Drop tables & Views */
drop table LMA_Species;
drop view LMA_exact;
drop view LMA_others;
/* Populate table with data */
.mode csv
.header off
.separator ","
.import ../../data/LMA/LMAout.csv LMA_Species
/* Query */
select * from LMA_Species where confidence != 100;
select * from LMA_Species where canonicalName != origName;
select * from LMA_Others;
/* Generate CSV file */
.mode list
.separator ';'
.output LMAothers.CSV
select * from LMA_Others;
.exit

/* Create Tables & Views */
create table LRE_Species (id integer primary key, origfamily text, origname text, scientificName text, rank text, family text, canonicalName text, confidence integer, matchType text);
create table LRE_References (id integer primary key, name text, reference text);
create table LRE_Localities (id integer primary key, region text, locality text, coordinates text);
create table LRE_Distributions (species_id integer not null references LRE_Species, locality_id integer not null references LRE_Localities, reference_id integer not null references LRE_References);
create view LRE_Dist as select spe.id, spe.scientificName, loc.region, loc.locality, ref.name as reference from ((( LRE_Distributions dis left join LRE_Species spe on ((spe.id = dis.species_id))) left join LRE_Localities loc on((loc.id = dis.locality_id))) left join LRE_References ref on((ref.id = dis.reference_id)));
/* Drop tables & Views */
drop table LRE_Species;
drop table LRE_References;
drop table LRE_Localities;
drop table LRE_Distributions;
drop view LRE_Dist;
/* Populate table with data */
.mode csv
.header off
.separator ","
.import ../../data/LRE/LREout.csv LRE_Species
.separator "\t"
.import ../../data/LRE/LREreferences.csv LRE_References
.separator ";"
.import ../../data/LRE/LREGazetteer.csv LRE_Localities
.import ../../data/LRE/LRE_Distributions.csv LRE_Distributions

/* Query */
select name from LRE_References;
select * from LRE_Dist;
select ¨from LRE_Localities where locality='Chlim';
select ¨from LRE_Localities where locality='Adel Bagrou';

create table TPH_Species (origName text, origAuthor text, origFamily text,origSynonyms text, origNameFR text , scientificName text, rank text, family text, canonicalName text, confidence integer, matchType text);
select * from TPH_Species where confidence != 100;

/* foreign keys check */
PRAGMA foreign_keys = 1;
PRAGMA foreign_keys = 0;
.quit
