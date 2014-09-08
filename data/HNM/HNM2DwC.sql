select 
p.id_part as id,
'preservedSpecimen' as basisOfRecord,
'urn:mrbif:ens:hnm:' || p.id_part as occurrenceid,
 t.nomcomplet as scientificname, f.famille as family,
l.localite as locality, 'MR' as countrycode,
p.code_barre as barcode, 
e.station, e.jour_de_recolte as day, e.mois_de_recolte as month, e.annee_de_recolte as year, 
coalesce(e.dd_latitude, l.dd_latitude) as decimal_latitude, 
coalesce(e.dd_longitude, l.dd_longitude) as decimal_longitude
from LETOUZE_PART p
left join LETOUZE_Echantillon e on e.id_echantillon=p.id_echantillon
left join LETOUZE_Herbier h on h.id_herbier=p.id_herbier
left join LETOUZE_localite l on l.id_localite=e.id_localite
left join LETOUZE_determine_par d on d.id_part=p.id_part
left join LETOUZE_taxon_specimen t on t.id_taxon=d.id_taxon
left join LETOUZE_famille f on f.id_famille=t.id_famille
where h.id_herbier=96
order by p.id_part;