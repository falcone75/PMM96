*** be_wahl1.prg

if "MESSAGE" $ pcFeldListe  && hier zeitwert eintragen wegen evtl. sortierung
 if empty(kartei->erst_eins) .or. empty(kartei->neuwert)
  pcZeitwertDM = ""
 else
  local lnLebensdauer
  lnLebensdauer = (date() - kartei->erst_eins)/365
  if lnLebensdauer > kartei->nd
   pcZeitwertDM = 0
  else
   pcZeitwertDM = round((1-lnLebensdauer/kartei->nd)*kartei->neuwert,2)
  endif  
  pcZeitwertDM = str(pcZeitwertDM,10,2)  && formatierung wegen evtl. sortierung
 endif 
endif
  
if "PB_BEM" $ pcFeldListe  && hier zeitwert eintragen wegen evtl. sortierung  
 if empty(kartei->erst_eins) .or. empty(kartei->neuwert)
  pcZeitwertProzent = ""
 else 
  local lnLebensdauer
  lnLebensdauer = (date() - kartei->erst_eins)/365 
  if lnLebensdauer > kartei->nd
   pcZeitwertProzent = 0
  else 
   pcZeitwertProzent = round((1-lnLebensdauer/kartei->nd)*100,1)
  endif 
  pcZeitwertProzent = str(pcZeitwertProzent,5,1)  && formatierung wegen evtl. sortierung
 endif 
endif 

sele bericht
append blank

repl &pcReplaceMakro

sele kartei
