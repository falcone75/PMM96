*** be_kali1.prg

if .not. proper(rtrim(pb_art)) $ "Eichen Kalibrieren"   && zur sicherheit
 return
endif 

sele bericht
append blank

repl bes with kartei->bes, codewort with kartei->codewort, ben with kartei->ben, merkmale with kartei->merkmale, geraete_nr with kartei->geraete_nr, kfr with kartei->kfr, pb_art with kartei->pb_art, pb_datum with kartei->pb_datum, pb_ort with kartei->pb_ort

if kartei->lfdnr > 0
 repl lfdnr with kartei->lfdnr
else
 repl spezinr with kartei->spezinr
endif 

sele kartei