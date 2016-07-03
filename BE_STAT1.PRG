*** be_stat1.prg

sele bericht
go 2

do case
 case kartei->pb_art == "Eichen" .or. kartei->pb_art == "Kalibrieren"
  repl lfdnr with lfdnr + 1
 case kartei->pb_art == "Lager"
  repl codewort with str(val(codewort)+1)
 case kartei->pb_art == "Zum Prfen"
  repl klassi with str(val(klassi)+1)
 case kartei->pb_art == "Reparatur"
  repl kfr with kfr + 1
 case kartei->pb_art == "ndern"
  repl anz_eins with anz_eins + 1
 case kartei->pb_art == "Schrott"
  repl spezinr with str(val(spezinr)+1)
 otherwise
  repl hst with str(val(hst)+1)
endcase

if anz_rep > 0
 repl bes with str(val(bes)+1), rep_kost with rep_kost + anz_rep, neuwert with neuwert + anz_rep^2
endif

if .not. empty(erst_eins)
 repl abw with str(val(abw)+1), „nd_kost with „nd_kost + (date()-erst_eins), prf_kost with prf_kost + (date()-erst_eins)^2
endif

sele kartei