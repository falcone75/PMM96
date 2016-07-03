*** archiv fÅr proceduren
 
*************** setzen von werten in der prÅfmittelkarte ****************

    Procedure pmk_set(ref)

       ref.plan_konv.value = ""   &&  <-> procedure REGISTER1_OnSelChange

       local lnLebensdauer
       lnLebensdauer = (date()-kartei->erst_eins)/365
          
       do case
        case kartei->nd = 0 .or. kartei->erst_eins == {}
         ref.zw_page2.text = "?"
        case kartei->erst_eins = date() 
         ref.zw_page2.text = "100"
        otherwise
         if lnLebensdauer >= kartei->nd
          ref.zw_page2.text = "  0"
         else
          ref.zw_page2.text = ltrim(str(round((1-lnLebensdauer/kartei->nd)*100,1),4,1))
         endif
       endcase
         
       * bezug fÅr die berechnung der rechtecke von zeitwert und reparatur ist die
       * summe von top (10) u. height (3.8) des rechteckes des neuwertes (= 13.8)
           
       ref.grafik_nw.height  = 0
       ref.grafik_zw.height  = 0
       ref.grafik_rep_kost.height = 0
       ref.grafik_prÅf_kost.height = 0
       ref.grafik_Ñnd_kost.height = 0
       
       local lnLebensdauer, lnHeight
       lnLebensdauer = (date()-kartei->erst_eins)/365
         
       if kartei->neuwert = 0
           
        ref.nw_proz.text = ""
        ref.grafik_nw.height = 0
        ref.zw_dm_page3.text = ""
        ref.zw_proz_page3.text = ""       
        ref.grafik_zw.height = 0
            
       else
           
        ref.nw_proz.text = "100 %"
        ref.nw_proz.top = 9
        ref.grafik_nw.height = 3.8
        ref.grafik_nw.top = 10
         
        do case
         case kartei->erst_eins == {}
          ref.zw_dm_page3.text = ""
          ref.zw_proz_page3.text = ""         
          ref.grafik_zw.height = 0
         case kartei->erst_eins = date() 
          ref.zw_dm_page3.text = ltrim(str(kartei->neuwert,10,2))
          ref.grafik_zw.top = 10
          ref.grafik_zw.height = 3.8
          ref.zw_proz_page3.top = 9
          ref.zw_proz_page3.text = "100 %"
         otherwise
          if lnLebensdauer >= kartei->nd
           ref.zw_dm_page3.text = "0"
           ref.grafik_zw.top    = 13.75
           ref.grafik_zw.height = 0.05
           ref.zw_proz_page3.top  = ref.grafik_zw.top - 1
           ref.zw_proz_page3.text = "0 %"
          else
           ref.zw_dm_page3.text = ltrim(str(round((1-lnLebensdauer/kartei->nd)*kartei->neuwert,2),10,2))
           lnHeight = 3.8 * val(ref.zw_dm_page3.text) / kartei->neuwert
           if lnHeight < 0.05
            lnHeight = 0.05
           endif
           ref.grafik_zw.top = 13.8 - lnHeight
           ref.grafik_zw.height = lnHeight
           ref.zw_proz_page3.top = ref.grafik_zw.top - 1
           ref.zw_proz_page3.text = ltrim(str(round(val(ref.zw_dm_page3.text)/kartei->neuwert*100,0))) + " %"
          endif
         endcase
            
        endif 
      
        do case
         case kartei->neuwert = 0
          ref.grafik_prÅf_kost.height = 0
          ref.prÅf_kost_proz.text=""
         case kartei->prÅf_kost = 0
          ref.grafik_prÅf_kost.top = 13.75
          ref.grafik_prÅf_kost.height = 0.05
          ref.prÅf_kost_proz.top  = ref.grafik_prÅf_kost.top - 1
          ref.prÅf_kost_proz.text = "0 %"
         otherwise
          lnHeight = 3.8 * kartei->prÅf_kost / kartei->neuwert
          do case
           case lnHeight < 0.05
            lnHeight = 0.05
           case lnHeight > 5
            lnHeight = 5
          endcase 
          ref.grafik_prÅf_kost.top = 13.8 - lnHeight
          ref.grafik_prÅf_kost.height = lnHeight
          ref.prÅf_kost_proz.top = ref.grafik_prÅf_kost.top - 1
          ref.prÅf_kost_proz.text = ltrim(str(round(kartei->prÅf_kost/kartei->neuwert*100,0))) + " %"
          if ref.grafik_prÅf_kost.height = 0.05 .or. ref.grafik_prÅf_kost.height = 5
           ref.prÅf_kost_proz.text = "(" + ref.prÅf_kost_proz.text + ")"    
          endif
        endcase
         
        do case
         case kartei->neuwert = 0
          ref.grafik_rep_kost.height = 0
          ref.rep_kost_proz.text=""
         case kartei->rep_kost = 0
          ref.grafik_rep_kost.top = 13.75
          ref.grafik_rep_kost.height = 0.05
          ref.rep_kost_proz.top  = ref.grafik_rep_kost.top - 1
          ref.rep_kost_proz.text = "0 %"
         otherwise
          lnHeight = 3.8 * kartei->rep_kost / kartei->neuwert
          do case
           case lnHeight < 0.05
            lnHeight = 0.05
           case lnHeight > 5
            lnHeight = 5
          endcase 
          ref.grafik_rep_kost.top = 13.8 - lnHeight
          ref.grafik_rep_kost.height = lnHeight
          ref.rep_kost_proz.top = ref.grafik_rep_kost.top - 1
          ref.rep_kost_proz.text = ltrim(str(round(kartei->rep_kost/kartei->neuwert*100,0))) + " %"
          if ref.grafik_rep_kost.height = 0.05 .or. ref.grafik_rep_kost.height = 5
           ref.rep_kost_proz.text = "(" + ref.rep_kost_proz.text + ")"    
          endif
        endcase
            
        do case
         case kartei->neuwert= 0
          ref.grafik_Ñnd_kost.height = 0
          ref.Ñnd_kost_proz.text=""
         case kartei->Ñnd_kost = 0
          ref.grafik_Ñnd_kost.top = 13.75
          ref.grafik_Ñnd_kost.height = 0.05
          ref.Ñnd_kost_proz.top  = ref.grafik_Ñnd_kost.top - 1
          ref.Ñnd_kost_proz.text = "0 %"
         otherwise
          lnHeight = 3.8 * kartei->Ñnd_kost / kartei->neuwert
          do case
           case lnHeight < 0.05
            lnHeight = 0.05
           case lnHeight > 5
            lnHeight = 5
          endcase 
          ref.grafik_Ñnd_kost.top = 13.8 - lnHeight
          ref.grafik_Ñnd_kost.height = lnHeight
          ref.Ñnd_kost_proz.top = ref.grafik_Ñnd_kost.top - 1
          ref.Ñnd_kost_proz.text = ltrim(str(round(kartei->Ñnd_kost/kartei->neuwert*100,0))) + " %"
          if ref.grafik_Ñnd_kost.height = 0.05 .or. ref.grafik_Ñnd_kost.height = 5
           ref.Ñnd_kost_proz.text = "(" + ref.Ñnd_kost_proz.text + ")"    
          endif
        endcase

        
    if kartei->lfdnr > 0
     ref.nummer.datalink = "kartei->lfdnr"
    else
     ref.nummer.datalink = "kartei->spezinr"
    endif
    
     
    ref.historie.lineno = len(kartei->historie)/90
     
     
    ** datalink-verbindung mu· bei ole-objekten nach datensatzÑnderung
    *  immer wieder neu aufgebaut werden ?!
    
    if empty(kartei->not_ole)
     ref.not_ole.visible  = .f.
     ref.not_konv.datalink = "kartei->not_konv"
     ref.rechteck_notizen.fontitalic = .t.
     ref.rechteck_notizen.text = "  Notizen  "
     ref.not_konv.visible = .t.
    else
     ref.not_konv.visible = .f.
     ref.not_ole.datalink = "kartei->not_ole"
     ref.rechteck_notizen.fontitalic = .f.
     ref.rechteck_notizen.text = "  Notizen [ " + ref.not_ole.servername + " ]  "
     ref.not_ole.visible  = .t.
    endif
   
    if empty(kartei->prot_ole)
     ref.prot_ole.visible  = .f.
     ref.prot_konv.datalink = "kartei->prot_konv"
     ref.rechteck_protokoll.fontitalic = .t.
     ref.rechteck_protokoll.text = "  PrÅfprotokoll  "
     ref.prot_konv.visible = .t.
    else
     ref.prot_konv.visible = .f.
     ref.prot_ole.datalink = "kartei->prot_ole"
     ref.rechteck_protokoll.fontitalic = .f.
     ref.rechteck_protokoll.text = "  PrÅfprotokoll [ " + ref.prot_ole.servername + " ]  "
     ref.prot_ole.visible  = .t.
    endif        


************** verschlÅsseln / entschlÅsseln des paszwortes **************

 Procedure ManiPW(String)
 
  local lcPaszwortNeu
  lcPaszwortNeu = ""
  
  for i=1 to len(String)
   lcPaszwortNeu = lcPaszwortNeu + chr(bitxor(asc(substr(String,i,1)),126))
  next i
  
  pcPaszwort = lcPaszwortNeu
  

**************** filtereinstellung in den bericht schreiben  *************

  Procedure AufnFilt(ref,zeile)
  
   privat poFormular
   poFormular = ref
   
   @ Zeile,5 say repl(chr(126),75)
   
   Zeile = Zeile + 1
   
   @ Zeile,5 say "Filter :"
   
   do case
    case empty(poFormular.zeile1)
     @ Zeile,14 say "ohne"
    case empty(left(poFormular.zeile1,10))
     @ Zeile,14 say right(poFormular.zeile1,len(poFormular.zeile1)-10)
    otherwise
     @ Zeile  ,15 say left(poFormular.zeile1,10)
     @ Zeile+1,14 say right(poFormular.zeile1,len(poFormular.zeile1)-10)
     Zeile = Zeile + 1
   endcase
   
   Zeile = Zeile + 1
   
   local lnIndex
   lnIndex = 2
   privat pcIndex, pcFilterzeile
   pcIndex = "2"
   
   do while type("poFormular.zeile&pcIndex") <> "U"
    pcFilterzeile = poFormular.zeile&pcIndex
    @ Zeile  ,15 say left(pcFilterzeile,10)
    @ Zeile+1,14 say right(pcFilterzeile,len(pcFilterzeile)-10)
    Zeile = Zeile + 2
    lnIndex = lnIndex + 1
    pcIndex = ltrim(str(lnIndex))
   enddo 


********* proceduren fÅr pmk_neu.wfm und pb_edi.wfm ***********

   Procedure PbArtCh(ref)

    if empty(ref.pb_art.value) .or. ref.pb_art.value == "?"
     msgbox("Fehler: Es besteht Eingabepflicht.","Achtung",48)
     ref.pb_art.value = "?"
     ref.pb_art.setfocus()
     return 
    endif

    if ref.name = "PB_EDI" .and. substr(kartei->historie,len(kartei->historie)-77,12) = ltrim(ref.pb_art.value)

     msgbox("Alle Angaben der Bewegung werden auf die Werte der Kartei zurÅckgesetzt.","Hinweis",64)
     local lcLetzteZeileHistorie
     lcLetzteZeileHistorie = right(kartei->historie,90)
     ref.pb_datum.value = ctod(left(lcLetzteZeileHistorie,10))
     if lower(ltrim(ref.pb_art.value)) $ "eichen kalibrieren"
      ref.pb_datum.value = ctod(left(lcLetzteZeileHistorie,10)) + kartei->kfr
     else 
      ref.pb_datum.value = ctod(left(lcLetzteZeileHistorie,10))
     endif
     ref.pb_kost.value = val(substr(lcLetzteZeileHistorie,78,8))
     ref.pb_bem.value  = substr(lcLetzteZeileHistorie,47,30)

    else
    
     sele pb_art
     if seek(ltrim(ref.pb_art.value))
      ref.pb_art.value = pb_art
      if ref.pb_art.value = "Schrott"
       if type("ref.nummer.value") = "N"
        msgbox("Die Nummer eines verschrotteten PrÅfmittels wird neu vergeben. Die Karte wird nur bei explizitem Aufruf im Filter angezeigt und kann auch nicht mehr bearbeitet werden.","Hinweis",64)
       else
        msgbox("Die Karte eines verschrotteten PrÅfmittels wird nur noch bei explizitem Aufruf im Filter angezeigt und kann auch nicht mehr bearbeitet werden.","Hinweis",64)
       endif 
      endif
     else 
      msgbox("Fehler: Die Eingabe ist nicht im Katalog enthalten.","Achtung",48)
      ref.pb_art.setfocus()
      return
     endif
    
     local ldDatum
     if proper(ltrim(rtrim(ref.pb_art.value))) $ "Eichen Kalibrieren"
      ldDatum = date() + val(ref.kfr.value)
      do case
       case cdow(ldDatum) = "Samstag" 
        ldDatum = ldDatum + 2
       case cdow(ldDatum) = "Sonntag"
        ldDatum = ldDatum + 1     
      endcase
     else
      ldDatum = date()
     endif 
     ref.pb_datum.value = ldDatum
     ref.pb_kost.value  = 0
     ref.pb_bem.value   = ""

    endif 
    
    if ref.name = "PB_EDI"

     if empty(kartei->erst_eins)
      if proper(ltrim(rtrim(ref.pb_art.value))) $ "Eichen Kalibrieren"
       repl kartei->erst_eins with date()
      else
       repl kartei->erst_eins with {}
      endif
     endif
     
    else
    
     if lower(ltrim(rtrim(ref.pb_art.value))) $ "eichen kalibrieren"
      if empty(ref.erst_eins.value)
       msgbox("Das Ersteinsatzdatum wird auf das aktuelle Datum gesetzt.","Hinweis",64)       
       ref.erst_eins.value = date()
      endif 
     else
      if ref.erst_eins.value = date()
       msgbox("  Das Ersteinsatzdatum wird gelîscht.","Hinweis",64)     
       ref.erst_eins.value = {}
      endif  
     endif
     if .not. ref.schalter_ok.enabled
      ref.schalter_ok.enabled = .t.
     endif
     
    endif 
  
    do SetOrt with ref,"OnChange"
     

     
   Procedure PbDatVa(ref)
   
   * procedure fÅr onchange-methode angepa·t

    if empty(ref.pb_datum.value)
     msgbox("Fehler: Es besteht Eingabepflicht.","Achtung",48)
*     ref.pb_datum.ValidErrorMsg = "Fehler: Es besteht Eingabepflicht."
     plValid = .f.
     return
    endif 
    
    if ref.name = "PB_EDI"
     local ldLetzterEintragHistorie
     ldLetzterEintragHistorie = ctod(substr(kartei->historie,len(kartei->historie)-89,10))
     if ref.pb_datum.value < ldLetzterEintragHistorie
      msgbox("Fehler: Das Datum liegt vor dem letzten Eintrag in der Historie.","Achtung",48)
*      ref.pb_datum.ValidErrorMsg = "Fehler: Das Datum liegt vor dem letzten Eintrag in der Historie."
      plValid = .f.
      return
     endif
    else
     if .not. empty(ref.erst_eins.value) .and. ref.erst_eins.value > ref.pb_datum.value
      msgbox("Fehler: Das Datum liegt vor dem Ersteinsatzdatum des PrÅfmittels.","Achtung",48)
*      ref.pb_datum.ValidErrorMsg = "Fehler: Das Datum liegt vor dem Ersteinsatzdatum des PrÅfmittels."
      plValid = .f.
      return
     endif
    endif
     
    if proper(ltrim(rtrim(ref.pb_art.value))) $ "Eichen Kalibrieren"
    
     local ldUntereGrenze
     if ref.name = "PB_EDI" .and. substr(kartei->historie,len(kartei->historie)-77,12) = ltrim(ref.pb_art.value)
      if ref.pb_datum.value < ldLetzterEintragHistorie
       msgbox("Fehler: Das Datum liegt vor dem Einsatzdatum des PrÅfmittels.","Achtung",48)
*       ref.pb_datum.ValidErrorMsg = "Fehler: Das Datum liegt vor dem Einsatzdatum des PrÅfmittels."
       plValid = .f.
       return
      else 
       ldUntereGrenze = ldLetzterEintragHistorie
      endif
     else
      if ref.pb_datum.value < date()
       msgbox("Fehler: Das Datum liegt vor dem aktuellen Datum.","Achtung",48)
*       ref.pb_datum.ValidErrorMsg = "Fehler: Das Datum liegt vor dem aktuellen Datum"
       plValid = .f.
       return
      else
       ldUntereGrenze = date()
      endif
     endif
     local ldObereGrenze
     ldObereGrenze = ldUntereGrenze + val(ref.kfr.value)
     do case
      case cdow(ldObereGrenze) = "Samstag" 
       ldObereGrenze = ldObereGrenze + 2
      case cdow(ldObereGrenze) = "Sonntag"
       ldObereGrenze = ldObereGrenze + 1     
     endcase
     if ref.pb_datum.value > ldObereGrenze
      if lower(ltrim(ref.pb_art.value)) = "eichen"
       msgbox("Fehler: Das Datum liegt nach dem mîglichen Eichdatum.","Achtung",48)
*       ref.pb_datum.ValidErrorMsg = "Fehler: Das Datum liegt nach dem mîglichen Eichdatum."
      else
       msgbox("Fehler: Das Datum liegt nach dem mîglichen Kalibrierdatum.","Achtung",48)
*       ref.pb_datum.ValidErrorMsg = "Fehler: Das Datum liegt nach dem mîglichen Kalibrierdatum."
      endif
      plValid = .f.
      return
     endif    

    else

     if ref.pb_datum.value > date()
      msgbox("Fehler: Das Datum liegt nach dem aktuellen Datum.","Achtung",48)
*      ref.pb_datum.ValidErrorMsg = "Fehler: Das Datum liegt nach dem aktuellen Datum."
      plValid = .f.
      return
     endif 
    
    endif

    if cdow(ref.pb_datum.value) = "Sonntag" 
     msgbox("     Das Datum ist ein Sonntag.","Hinweis",64)
    endif 
    
    plValid = .t.
    return
      


  Procedure SetOrt(ref,Aufruf)

   local lcEingabe
   lcEingabe = proper(ltrim(rtrim(ref.pb_art.value)))

   privat pcArtKurz
   
   do case      
    case lcEingabe $ "Eichen Kalibrieren"
     pcArtKurz = '"E"'
    case lcEingabe = "Lager"
     pcArtKurz = '"L"'
    case lcEingabe = "Zum PrÅfen"
     pcArtKurz = '"P"'
    case lcEingabe = "Reparatur"
     pcArtKurz = '"R"'
    otherwise
     pcArtKurz = '"S"'
   endcase

   sele pb_ort
   set order to 1
   set key to nutzer.mand_nr + &pcArtKurz
   ref.pb_ort.visible = .f.
   ref.pb_ort.DataSource = "FIELD pb_ort->pb_ort"
   * kein set key to
   if Aufruf = "OnOpen"
    ref.pb_ort.value = kartei->pb_ort
   else 
    ref.pb_ort.value = ""
    if ref.name = "PB_EDI"
     if substr(kartei->historie,len(kartei->historie)-77,12) = ltrim(ref.pb_art.value)
      ref.pb_ort.value = substr(kartei->historie,len(kartei->historie)-64,20)
     endif
    endif 
    ref.pb_ort.setfocus()
   endif
   ref.pb_ort.visible = .t.   


****************** setzen der pa·wortlogik *******************************

Procedure SetLog (PaszwortLogik)
if left(PaszwortLogik,1) = "0"
 HauptForm.root.prÅfmittelkarte.enabled = .f.
else
 HauptForm.root.prÅfmittelkarte.enabled = .t.
endif

if substr(PaszwortLogik,4,1) = "0"
 HauptForm.root.bericht.fÑlligkeitsliste.enabled  = .f.
 HauptForm.root.bericht.mahnliste.enabled         = .f.
 HauptForm.root.bericht.wahlfreie_liste.enabled   = .f.
 HauptForm.root.bericht.statistik.enabled         = .f.
 HauptForm.root.bericht.prÅfmittelbestand.enabled = .f.
 HauptForm.root.bericht.kostenrechnung.enabled    = .f.
 HauptForm.root.bericht.freie_nummern.enabled     = .f.
 HauptForm.root.bericht.zeitbedarf.enabled        = .f.
 HauptForm.root.bericht.prÅfauftrag.enabled       = .f.
else
 HauptForm.root.bericht.fÑlligkeitsliste.enabled  = .t.
 HauptForm.root.bericht.mahnliste.enabled         = .t.
 HauptForm.root.bericht.wahlfreie_liste.enabled   = .t.
 HauptForm.root.bericht.statistik.enabled         = .t.
 HauptForm.root.bericht.prÅfmittelbestand.enabled = .t.
 HauptForm.root.bericht.kostenrechnung.enabled    = .t.
 HauptForm.root.bericht.freie_nummern.enabled     = .t.
 HauptForm.root.bericht.zeitbedarf.enabled        = .t.
 HauptForm.root.bericht.prÅfauftrag.enabled       = .t.
endif

if substr(PaszwortLogik,5,1) = "0"
 HauptForm.root.boss.pa·wîrter.enabled = .f.
else
 HauptForm.root.boss.pa·wîrter.enabled = .t.
endif

if substr(PaszwortLogik,6,1) = "0"
 HauptForm.root.boss.kataloge.ordnungssystem.enabled = .f.
else
 HauptForm.root.boss.kataloge.ordnungssystem.enabled = .t.
endif

if substr(PaszwortLogik,7,1) = "0"
 HauptForm.root.boss.kataloge.hersteller.enabled = .f.
else
 HauptForm.root.boss.kataloge.hersteller.enabled = .t.
endif

if substr(PaszwortLogik,8,1) = "0"
 HauptForm.root.boss.kataloge.eigentÅmer.enabled = .f.
else
 HauptForm.root.boss.kataloge.eigentÅmer.enabled = .t.
endif

if substr(PaszwortLogik,9,1) = "0"
 HauptForm.root.boss.kataloge.merkmale.enabled = .f.
else
 HauptForm.root.boss.kataloge.merkmale.enabled = .t.
endif

if substr(PaszwortLogik,10,1) = "0"
 HauptForm.root.boss.kataloge.zul_abweichungen.enabled = .f.
else
 HauptForm.root.boss.kataloge.zul_abweichungen.enabled = .t.
endif

if substr(PaszwortLogik,11,1) = "0"
 HauptForm.root.boss.kataloge.prÅffristen.enabled = .f.
else
 HauptForm.root.boss.kataloge.prÅffristen.enabled = .t.
endif

if substr(PaszwortLogik,12,1) = "0"
 HauptForm.root.boss.kataloge.klassifikation.enabled = .f.
else
 HauptForm.root.boss.kataloge.klassifikation.enabled = .t.
endif

if substr(PaszwortLogik,13,1) = "0"
 HauptForm.root.boss.kataloge.art_der_bewegung.enabled = .f.
else
 HauptForm.root.boss.kataloge.art_der_bewegung.enabled = .t.
endif

if substr(PaszwortLogik,14,1) = "0"
 HauptForm.root.boss.kataloge.standorte.enabled   = .f.
else
 HauptForm.root.boss.kataloge.standorte.enabled   = .t.
endif

if substr(PaszwortLogik,15,1) = "0"
 HauptForm.root.boss.kataloge.musterprÅfprotokolle.enabled = .f.
else
 HauptForm.root.boss.kataloge.musterprÅfprotokolle.enabled = .t.
endif

if substr(PaszwortLogik,16,1) = "0"
 HauptForm.root.boss.kataloge.prÅfplÑne.enabled = .f.
else
 HauptForm.root.boss.kataloge.prÅfplÑne.enabled = .t.
endif

if substr(PaszwortLogik,17,1) = "0"
 HauptForm.root.boss.sonderfunktionen.mandanten.enabled            = .f.
 HauptForm.root.boss.sonderfunktionen.einsatzdauer_Ñndern.enabled  = .f.
 HauptForm.root.boss.sonderfunktionen.neuindizieren.enabled        = .f.
else
 HauptForm.root.boss.sonderfunktionen.mandanten.enabled            = .t.
 HauptForm.root.boss.sonderfunktionen.einsatzdauer_Ñndern.enabled  = .t.
 HauptForm.root.boss.sonderfunktionen.neuindizieren.enabled        = .t.
endif


*********** suchoperation bei prÅfmittelkarten und berichten ************

Procedure suchen(Referenz, AufrufendesFormular, Suche, SuchArray, Aktion)

 Referenz.MousePointer = 11

 privat pcNummerBezugsformular
 pcNummerBezugsformular = AufrufendesFormular
 
 if Suche = "Gesamtsuche" 
  privat pcAktion
  pcAktion = Aktion
 endif 
 
 local lnStartzeit, llZeiger
 llZeiger = .f.
 lnStartzeit = seconds()
  
 privat FilterObjekt
 FilterObjekt = Filter&pcNummerBezugsformular

 if FilterObjekt.ErweiterteSuche
     
  local llHistDatum, llHistArt, llHistKost, llHistOrt, llHistBem, llZwP, llZwDM
  store .f. to llHistArt, llHistDatum, llHistKost, llHistOrt, llHistBem, llZwP, llZwDM
     
  local lnIndex
  lnIndex = 1
  privat pcIndex, pcZeile
  pcIndex = "1"
 
  do while type("FilterObjekt.zeile&pcIndex") <> "U"
   pcZeile = FilterObjekt.zeile&pcIndex
   do case
    case "Historie (Datum)" $ pcZeile
     llHistDatum = .t.
     privat pcZeileHistDatum
     pcZeileHistDatum = pcZeile
    case "Historie (Art)" $ pcZeile
     llHistArt = .t.
     privat pcZeileHistArt
     pcZeileHistArt = pcZeile
    case "Historie (Kosten[DM])" $ pcZeile
     llHistKost = .t.
     privat pcZeileHistKost
     pcZeileHistKost = pcZeile
    case "Historie (Bemerkung)" $ pcZeile
     llHistBem = .t.
     privat pcZeileHistBem
     pcZeileHistBem = pcZeile
    case "Historie (Standort)" $ pcZeile
     llHistOrt = .t.
     privat pcZeileHistOrt
     pcZeileHistOrt = pcZeile
    case "Zeitwert[%]" $ pcZeile        
     llZwP = .t.        
     privat pcZeileZwP
     pcZeileZwP = pcZeile
    case "Zeitwert[DM]" $ pcZeile        
     llZwDM = .t.       
     privat pcZeileZwDM
     pcZeileZwDM = pcZeile
   endcase
   lnIndex = lnIndex + 1
   pcIndex = ltrim(str(lnIndex))
  enddo

 endif
 
 local llFound

 privat pcSuchMakro, pcZeichen
 pcSuchMakro = FilterObjekt.suchmakro
 
 if SuchArray = "SuchArrayJa"
  privat RefSuchenArray
  RefSuchenArray = Suchen&pcNummerBezugsformular
 endif 

 sele kartei

 if 'PB_ART=="Schrott"' $ FilterObjekt.suchmakro .or. ;
   Suche = "Gesamtsuche" .and. pcAktion = "be_stat1.prg"
  set dele off
 endif 
  
 scan rest for &pcSuchMakro 

  if .not. llZeiger .and. seconds() > lnStartzeit + 3
   llZeiger = .t.
   local f
   f = new wartenform()    &&  -> archiv_c.prg
   f.open()
  endif

  if FilterObjekt.ErweiterteSuche

   if llHistArt .or. llHistDatum .or. llHistKost .or. llHistBem .or. llHistOrt
   
    privat pcZeileHistorie

    for i=memlines(kartei->historie,90) to 1 step -1
    
     llFound = .t.
    
     pcZeileHistorie = mline(kartei->historie,i,90)        
     
     if llHistArt 
      if .not. substr(pcZeileHistorie,13,12) == substr(pcZeileHistArt,34,len(pcZeileHistArt)-34)
       llFound = .f.
      endif
     endif 
     
     if llHistDatum .and. llFound
      if "<=" $ pcZeileHistDatum
       if .not. ( ctod(substr(pcZeileHistDatum,11,10)) <= ctod(left(pcZeileHistorie,10)) .and. ctod(left(pcZeileHistorie,10)) <= ctod(right(pcZeileHistDatum,10)) )
        llFound = .f.
       endif  
      else
       do case
        case "=" $ pcZeileHistDatum
         pcZeichen = "="
        case "<" $ pcZeileHistDatum
         pcZeichen = "<"
        case ">" $ pcZeileHistDatum
         pcZeichen = ">"
       endcase  
       if .not. ctod(left(pcZeileHistorie,10)) &pcZeichen ctod(right(pcZeileHistDatum,10))
        llFound = .f.
       endif
      endif
     endif           
     
     if llHistKost .and. llFound
      if "<=" $ pcZeileHistKost
       if .not. ( val(substr(pcZeileHistKost,11,at("<=",pcZeileHistKost,1)-1)) <= val(substr(pcZeileHistorie,78,8)) .and. val(substr(pcZeileHistorie,78,8)) <= val(right(pcZeileHistKost,len(pcZeileHistKost)-at("<=",pcZeileHistKost,2)-2)) )
        llFound = .f.
       endif  
      else
       do case
        case "=" $ pcZeileHistKost
         pcZeichen = "="
        case "<" $ pcZeileHistKost
         pcZeichen = "<"
        case ">" $ pcZeileHistKost
         pcZeichen = ">"
       endcase  
       if .not. val(substr(pcZeileHistorie,78,8)) &pcZeichen val(right(pcZeileHistKost,len(pcZeileHistKost)-34))
        llFound = .f.
       endif
      endif
     endif           
     
     if llHistOrt .and. llFound
      do case
       case "Historie (Standort) gleich" $ pcZeileHistOrt
        if .not. substr(pcZeileHistorie,26,20) == substr(pcZeileHistOrt,39,len(pcZeileHistOrt)-39)
         llFound = .f.
        endif 
       case "Historie (Standort) beginnend mit" $ pcZeileHistOrt
        if .not. substr(pcZeileHistorie,26,20) = substr(pcZeileHistOrt,46,len(pcZeileHistOrt)-46)
         llFound = .f.
        endif  
       case "enthalten in Historie (Standort)" $ pcZeileHistOrt
        if .not. substr(pcZeileHistOrt,12,len(pcZeileHistOrt)-45) $ substr(pcZeileHistorie,26,20)
         llFound = .f.
        endif 
       case "Historie (Standort) Ñhnlich" $ pcZeileHistOrt
        if .not. diff(substr(pcZeileHistorie,26,20),substr(pcZeileHistOrt,40,len(pcZeileHistOrt)-40)) > 2
         llFound = .f.
        endif 
      endcase
     endif
     
     if llHistBem .and. llFound
      do case
       case "Historie (Bemerkung) gleich" $ pcZeileHistBem
        if .not. substr(pcZeileHistorie,47,30) == substr(pcZeileHistBem,40,len(pcZeileHistBem)-40)
         llFound = .f.
        endif 
       case "Historie (Bemerkung) beginnend mit" $ pcZeileHistBem
        if .not. substr(pcZeileHistorie,47,30) = substr(pcZeileHistBem,47,len(pcZeileHistBem)-47)
         llFound = .f.
        endif 
       case "enthalten in Historie (Bemerkung)" $ pcZeileHistBem
        if .not. substr(pcZeileHistBem,12,len(pcZeileHistBem)-46) $ substr(pcZeileHistorie,47,30)
         llFound = .f.
        endif 
       case "Historie (Bemerkung) Ñhnlich" $ pcZeileHistBem
        if .not. diff(substr(pcZeileHistorie,47,30),substr(pcZeileHistBem,41,len(pcZeileHistBem)-41)) > 2
         llFound = .f.
        endif 
      endcase
     endif
     
     if llFound
      exit
     endif
     
    next i
    
   else
   
    llFound = .t.
    
   endif
   
   if llZwP .and. llFound
    if kartei->erst_eins == {} .or. neuwert = 0
     llFound = .f.
    else 
     local lnLebensdauer
     lnLebensdauer = (date()-kartei->erst_eins)/365
     privat lnZeitwert
     if lnLebensdauer > nd
      lnZeitwert = 0
     else 
      lnZeitwert = round((1-lnLebensdauer/kartei->nd)*100,1)
     endif 
     if "<=" $ pcZeileZwP
      if .not. ( val(substr(pcZeileZwP,11,at("<=",pcZeileZwP,1)-12)) <= lnZeitwert .and. lnZeitwert <= val(right(pcZeileZwP,len(pcZeileZwP)-at("<=",pcZeileZwP,2)-2)) )
       llFound = .f.
      endif  
     else
      do case
       case "=" $ pcZeileZwP
        pcZeichen = "="
       case "<" $ pcZeileZwP
        pcZeichen = "<"
       case ">" $ pcZeileZwP
        pcZeichen = ">"
      endcase  
      if .not. lnZeitwert &pcZeichen val(right(pcZeileZwP,len(pcZeileZwP)-24))
       llFound = .f.
      endif
     endif
    endif           
   endif
   
   if llZwDM .and. llFound
    if kartei->erst_eins == {} .or. neuwert = 0
     llFound = .f.
    else 
     local lnLebensdauer
     lnLebensdauer = (date()-kartei->erst_eins)/365
     privat lnZeitwert
     if lnLebensdauer > nd
      lnZeitwert = 0
     else
      lnZeitwert = round((1-lnLebensdauer/kartei->nd)*kartei->neuwert,2)
     endif 
     if "<=" $ pcZeileZwDM
      if .not. ( val(substr(pcZeileZwDM,11,at("<=",pcZeileZwDM,1)-12)) <= lnZeitwert .and. lnZeitwert <= val(right(pcZeileZwDM,len(pcZeileZwDM)-at("<=",pcZeileZwDM,2)-2)) )
       llFound = .f.
      endif  
     else
      do case
       case "=" $ pcZeileZwDM
        pcZeichen = "="
       case "<" $ pcZeileZwDM
        pcZeichen = "<"
       case ">" $ pcZeileZwDM
        pcZeichen = ">"
      endcase  
      if .not. lnZeitwert &pcZeichen val(right(pcZeileZwDM,len(pcZeileZwDM)-25))
       llFound = .f.
      endif
     endif
    endif
   endif  
   
   if llFound 
    if SuchArray = "SuchArrayJa"
     RefSuchenArray.add(ltrim(str(recno())))        
    endif
    if Suche = "Einzelsuche"
     exit
    else
     if pcAktion <> "Keine Aktion"
      do &pcAktion
     endif 
    endif 
   endif

  else   && if FilterObjekt.ErweiterteSuche
  
   if SuchArray = "SuchArrayJa"
    RefSuchenArray.add(ltrim(str(recno())))        
   endif        
   if Suche = "Einzelsuche"
    exit
   else
    if pcAktion <> "Keine Aktion"
     do &pcAktion 
    endif 
   endif 
  
  endif

  if llZeiger .and. inkey() > 0
   exit
  endif
   
 endscan

 
 if llZeiger
  f.close()
 endif 
 
 if SuchArray = "SuchArrayJa" .and. RefSuchenArray.size > 0
  go val(RefSuchenArray[RefSuchenArray.size])
 endif

 set dele on
 
 Referenz.MousePointer = 0
 

**************  auswahl und anzeige des prÅfplanes  ********************

 Procedure WahlPlan(ref)
 
    privat pcAlias
    pcAlias = alias()
    
    ref.plan_ole.datalink = ""
    ref.plan_konv.value   = ""
  
    sele p_plan
  
    local lnAnzahl
    count all to lnAnzahl

    if lnAnzahl > 1
     local f
     f = new AUSWAHL_PLAN()  && -> archiv_c.prg
     f.readmodal()
    else
     go top
    endif

    if empty(p_plan->plan_ole)
     ref.plan_ole.visible  = .f.
     ref.plan_ole.datalink = ""
     ref.plan_konv.value   = p_plan->plan_konv
     ref.plan_konv.visible = .t.
    else
     ref.plan_konv.visible = .f.
     ref.plan_konv.value   = "0815"  && -> procedure REGISTER1_OnSelChange
     ref.plan_ole.datalink = "p_plan->plan_ole"
     ref.plan_ole.visible  = .t.
    endif

    sele &pcAlias
