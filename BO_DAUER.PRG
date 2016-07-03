*** bo_dauer.prg

* aktion in suchen.prg 

sele kartei

if .not. pb_art == "Kalibrieren"  && zur sicherheit
 return
endif 

local lcNeueZeileHistorie

set century on

lcNeueZeileHistorie = left( dtoc(date()) + "  " + "No Move      " + "Einsatz: " + Einsatzdauer.anz_tage.value + " Tage"+space(46),46) + left(ltrim(Einsatzdauer.grund.value)+space(44),44)

local ldPbDatumNeu
ldPbDatumNeu = pb_datum + val(Einsatzdauer.anz_tage.value)

if cdow(ldPbDatumNeu) = "Sonntag"
 ldPbDatumNeu = ldPbDatumNeu + 1
endif 

if val(Einsatzdauer.anz_tage.value) < 0 .and. ldPbDatumNeu < ctod(substr(historie,len(historie)-89,10))
 ldPbDatumNeu = ctod(substr(historie,len(historie)-89,10))
endif 

repl pb_datum with ldPbDatumNeu, historie with lcNeueZeileHistorie additive

