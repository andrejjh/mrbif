# Pre-Publication Data Cleaning

## IDs
For checklists species <uniqueID>= <CountryCode>_<InstCode>_<ResourceCode>_<localID>
For occurrence records <uniqueID>= <CountryCode>_<InstCode>_<ResourceCode>_<localID>

eg: 'urn:MRBIF:ENS:HNM:00000001' where:
	MRBIF= Mauritanie
	ENS= Ecole Normale Supérieure
	HNM= Herbier National de Mauritanie
	00000001= specimenID dans l'herbier

## Spreadsheet/CSV
* Copy/Paste data from PDF/Word/Excel into CSV

## SQLite
* Import data into SQLite database

## OpenRefine

## Gazetteer
* Coordinates into decimal lat/long
ruby ../../tools/coordinates.rb LREGazetteer.csv LREGazetteerout.csv
* QGIS using Mauritania Administrative Boundaries
add Mauritanian regions layer (MRT_adm1.shp)
add Reptiles localities layer (LREGazetteerout)
* Google Earth

## GBIF Webservices

### Name parser
http://api.gbif.org/v1/parser/name?name=Tursiops+truncatus

### Species match
[Tursiops Truncatus](http://api.gbif.org/v1/species/match?name=Tursiops%20truncatus)

ruby ../../tools/gbifWebServices.rb LRE.csv LREout.csv

## Similar taxon search sevices

### GlobalNameIndex
http://gni.globalnames.org/name_strings.json?search_term=tursiops%20truncatus

### PESI
http://www.eu-nomen.eu/portal/webservices.php

### CatalogOfLife
http://www.catalogueoflife.org/col/webservice?name=Tara+spinosa


## Tools
* [Atom](https://atom.io/faq)
* [QGIS](http://www.qgis.org/fr/site/)
* [OpenRefine](http://openrefine.org/)
* [libreOffice](https://fr.libreoffice.org/)
* [SQLite](http://www.sqlite.org/)
* [BiodiversityCatalogue](https://www.biodiversitycatalogue.org/)

## Languages
* [Java](https://www.java.com/fr/)
* [Python](https://www.python.org/)
* [Ruby](https://www.ruby-lang.org/fr/)
