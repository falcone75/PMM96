*** be_best1.prg

sele bericht
set order to Index_1
set exact on

do case
 case lower(key(1)) == "codewort"
  if .not. seek(kartei->codewort)
   set order to 
   append blank
   repl codewort with kartei->codewort
  endif 
 case lower(key(1)) == "codewort+ben"
  if .not. seek(kartei->codewort+kartei->ben)
   set order to 
   append blank
   repl codewort with kartei->codewort, ben with kartei->ben
  endif 
 case lower(key(1)) == "codewort+merkmale"
  if .not. seek(kartei->codewort+kartei->merkmale)
   set order to 
   append blank
   repl codewort with kartei->codewort, merkmale with kartei->merkmale
  endif 
endcase

repl lfdnr with lfdnr + 1

set exact off

sele kartei