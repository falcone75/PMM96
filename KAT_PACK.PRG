*** kat_pack.prg

* achtung : alle indexdateien mit ”ffnen, damit nach pack automatisch
*           reindiziert wird

sele 1

use abw index abw excl
 pack
use pb_art index pb_art excl
 pack
use bes index bes excl
 pack
use hst index hst excl
 pack
use kfr index kfr excl
 pack
use klassi index klassi excl
 pack
use merkmale index merkmale excl
 pack
use pb_ort index pb_ort excl
 pack
use os index os.ix1, os.ix2 excl
 pack
use muster index muster excl 
 pack
use p_plan index p_plan excl
 pack
use paszwort index paszwort.ix1, paszwort.ix2 excl
 pack

use mandant

scan all
 sele 2
 use (rtrim(mandant->mandant)) index (rtrim(mandant->mandant)) excl
 set order to 0
 set dele off
 loca all for dele() .and. .not. pb_art == "Schrott"
 if found()
  recall all for pb_art == "Schrott"
  pack
  dele all for pb_art == "Schrott"
 endif
 set dele on
 sele mandant
endscan

close all
