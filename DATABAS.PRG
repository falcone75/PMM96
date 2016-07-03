***  ”ffnen der kataloge

set path to \visualdb\kartei\kataloge

sele 20
 use os index os.ix1,os.ix2
 
sele 22
 use hst index hst
 
sele 24
 use klassi index klassi
 
sele 26
 use merkmale index merkmale
 
sele 28
 use abw index abw
 
sele 30
 use bes index bes
 set filter to mand_nr = nutzer.mand_nr
 
sele 32
 use kfr index kfr
 
sele 34
 use pb_art index pb_art
 set filter to pb_art <> "Im Einsatz"
 
sele 36
 use pb_ort index pb_ort
 set filter to mand_nr = nutzer.mand_nr
 
sele 38 
 use muster index muster
 
sele 1
