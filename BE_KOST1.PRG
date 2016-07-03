*** be_kost1.prg

sele bericht

repl lfdnr with lfdnr + 1, spezinr with str(val(spezinr)+kartei->neuwert), geraete_nr with str(val(geraete_nr)+kartei->prf_kost), pb_art with str(val(pb_art)+kartei->rep_kost), codewort with str(val(codewort)+kartei->„nd_kost)


local lnZeitwert

if kartei->pb_art == "Schrott"   && falls suche nach schrott
 lnZeitwert = 0
else
 lnZeitwert = kartei->neuwert*(100-(date()-kartei->erst_eins)/365*100/kartei->nd)/100
 if lnZeitwert < 0 
  lnZeitwert = 0
 endif
endif

repl bes with str(val(bes)+lnZeitwert)


if kartei->neuwert > neuwert
 repl neuwert with kartei->neuwert
endif

if lnZeitwert > val(klassi)
 repl klassi with ltrim(str(lnZeitwert))
endif

if kartei->prf_kost > prf_kost
 repl prf_kost with kartei->prf_kost
endif

if kartei->rep_kost > rep_kost
 repl rep_kost with kartei->rep_kost
endif

if kartei->„nd_kost > „nd_kost
 repl „nd_kost with kartei->„nd_kost
endif


if lnZeitwert > 0
 lnZeitwert = round(100-(date()-kartei->erst_eins)/365*100/kartei->nd,1)
endif

do case
 case lnZeitwert > 80
  repl hst with str(val(hst)+1)
 case lnZeitwert > 60
  repl merkmale with str(val(merkmale)+1)
 case lnZeitwert > 40
  repl abw with str(val(abw)+1)
 case lnZeitwert > 20
  repl sonstiges with str(val(sonstiges)+1)
 case lnZeitwert > 0
  repl pb_ort with str(val(pb_ort)+1)
 otherwise
  repl pb_bem with str(val(pb_bem)+1)
endcase


sele kartei