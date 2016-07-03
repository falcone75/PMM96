*** basis.cfm


**************** basisformular fr eingaben zum bericht *******************

CLASS BERICHTSEINGABE OF FORM Custom
   this.OnOpen = CLASS::FORMULAR_ONOPEN
   this.Width = 80
   this.MDI = .F.
   this.Text = ""
   this.Left = 11.666
   this.Top = 4.3
   this.Height = 18.1172

   this.OnOpen = class::FORMULAR_OnOpen

   DEFINE PUSHBUTTON SCHALTER_FILTER OF THIS;
       PROPERTY; 
         Width 16,;
         Text "Filter",;
         UpBitmap "RESOURCE #858",;
         Left 7.332,;
         OnClick CLASS::SCHALTER_FILTER_ONCLICK,;
         Group .T.,;
         Top 14.5,;
         Height 1.7

   DEFINE PUSHBUTTON SCHALTER_ABBRUCH OF THIS;
       PROPERTY; 
         Width 16,;
         OnOpen {; this.setfocus()},;
         Text "Abbruch",;
         UpBitmap "RESOURCE #28",;
         Left 56.333,;
         OnClick CLASS::SCHALTER_ABBRUCH_ONCLICK,;
         Group .T.,;
         Top 14.5,;
         Height 1.7

   DEFINE PUSHBUTTON SCHALTER_BERICHT OF THIS;
       PROPERTY; 
         Width 23.333,;
         Text "Bericht erstellen",;
         UpBitmap "RESOURCE #308",;
         Left 28,;
         Group .T.,;
         Top 13.5,;
         Height 3.9111



  Procedure FORMULAR_OnOpen
  
   if glTipsUndTricks .and. .not. empty(pcTextTipsUndTricks)
    msgbox(pcTextTipsUndTricks,"Tips & Tricks",64)
   endif

   this.Formularnummer = pcZahl
 
   private poRefFilter

   public Filter&pcZahl

   Filter&pcZahl = new object() 

   poRefFilter = Filter&pcZahl

   poRefFilter.KeyString       = ""
   poRefFilter.FilterMakro     = ".t."
   poRefFilter.SuchMakro       = ".t."
   poRefFilter.ErweiterteSuche = .f.
   poRefFilter.Zeile1          = ""
   



 Procedure SCHALTER_FILTER_OnClick
 
  do databas
  do filter.wfm with form.formularnummer
  

  
 Procedure SCHALTER_ABBRUCH_OnClick 
  
  privat pcFormularnummer
  pcFormularnummer = form.formularnummer
   
  rele Filter&pcFormularnummer, Formular&pcFormularnummer
  
  form.close()
  


ENDCLASS



**************** basisformular fr ausgabe des berichtes ****************

CLASS BERICHTSAUSGABE OF KARTE Custom
   this.Formularnummer = Formularnummer  && -> filt_anz.wfm, ...
   this.Berichtsdatei  = funique("$????.txt")  && endung "txt" notwendig, da sonst bericht nicht angezeigt wird
   
   this.schalter_filteranzeige.enabled      = .t.
   this.schalter_font.enabled               = .t.
   this.schalter_drucker_einrichten.enabled = .t.
   this.schalter_ausgabe.enabled            = .t.
   this.schalter_fensterinfo.enabled        = .t.
   this.schalter_schlieszen.enabled         = .t.

   this.schalter_ausgabe.onclick    = {; do ausgabe.wfm with form.Berichtsdatei}
   this.schalter_schlieszen.onclick = class::SCHALTER_SCHLIESZEN_OnClick


   DEFINE EDITOR AUSGABE OF THIS;
       PROPERTY; 
         Width 97,;
         Value "",;
         CUATab .T.,;
         FontName "Courier New",;
         FontSize 8,;
         Left 3.333,;
         Top 3,;
         Wrap .f.,;
         Height 18


  Procedure SCHALTER_SCHLIESZEN_OnClick
  
   form.ausgabe.datalink = ""
   dele file (form.Berichtsdatei)
   
   privat pcFormularnummer
   pcFormularnummer = form.formularnummer
   
   rele Formular&pcFormularnummer, Filter&pcFormularnummer
   
   form.close()
  


ENDCLASS



*********** basisformular fr pmk_edi.wfm und pmk_neu.wfm *********************

CLASS KARTE_EDI_NEU OF KARTE Custom
   this.text = ""
   
   this.formularnummer = pcZahl
   this.AufrufendeSuchformularNummer = pcAufrufendeSuchformularNummer
   
   this.schalter_filteranzeige.enabled = .f.
   this.schalter_abbruch.enabled = .t.
      
   this.schalter_ole.onclick     = class::schalter_ole_onclick
   this.schalter_ausgabe.onclick = {;form.print()}

   
   DEFINE TABBOX REGISTER1 OF THIS;
       PROPERTY; 
         Width 103.8311,;
         ColorHighLight "BtnText/BtnFace",;
         ColorNormal "BtnFace",;
         ID 121,;
         Top 21.2939,;
         Height 1

   DEFINE RECTANGLE RECHTECK2 OF THIS;
       PROPERTY; 
         Width 103.0674,;
         FontSize 10,;
         ColorNormal "0x400080/W",;
         Text "  Prfmittel  ",;
         Left 0.2656,;
         Top 2.0195,;
         PageNo 0,;
         FontItalic .T.,;
         Height 3.2793

   DEFINE RECTANGLE RECHTECK3 OF THIS;
       PROPERTY; 
         Width 100.666,;
         FontSize 10,;
         ColorNormal "G/BtnFace",;
         Text "  Stammdaten  ",;
         Left 1.5,;
         Top 5.7051,;
         FontItalic .T.,;
         Height 14.9414

   DEFINE RECTANGLE RECHTECK4 OF THIS;
       PROPERTY; 
         Width 96.6689,;
         ColorNormal "GB/BtnFace",;
         Text "  Prfmittelbewegung  ",;
         Left 3.3311,;
         Top 15.1758,;
         FontItalic .T.,;
         Height 4.8242

   DEFINE RECTANGLE RECHTECK_NOTIZEN OF THIS;
       PROPERTY; 
         Width 95.5,;
         FontSize 10,;
         ColorNormal "RG+/BtnFace",;
         Text "",;
         Left 4,;
         Top 5.8799,;
         PageNo 3,;
         FontItalic .T.,;
         Height 14.5293

   DEFINE RECTANGLE RECHTECK_PROTOKOLL OF THIS;
       PROPERTY; 
         Width 95.5,;
         FontSize 10,;
         ColorNormal "B+/BtnFace",;
         Text "",;
         Left 4,;
         Top 5.8799,;
         PageNo 4,;
         Height 14.5293
         
   DEFINE RECTANGLE RECHTECK_PRUEFPLAN OF THIS;
       PROPERTY; 
         Width 95.5,;
         FontSize 10,;
         ColorNormal "0x408000/BtnFace",;
         Text "  Prfplan  ",;
         Left 4,;
         Top 5.8799,;
         PageNo 5,;
         FontItalic .T.,;
         Height 14.5293
         
   DEFINE RECTANGLE RECHTECK5 OF THIS;
       PROPERTY; 
         Width 90.333,;
         Left 6.5,;
         BorderStyle 1,;
         Top 8.8818,;
         PageNo 6,;
         Height 8.7061      
         
   DEFINE RECTANGLE RECHTECK_MESSAGE OF THIS;
       PROPERTY; 
         Width 76.5,;
         FontSize 10,;
         ColorNormal "R+/BtnFace",;
         Text "  Message  ",;
         Left 13.166,;
         Top 11,;
         PageNo 6,;
         FontItalic .T.,;
         Height 4.0586   
    
   DEFINE TEXT TEXT_BEN OF THIS;
       PROPERTY; 
         Width 11.001,;
         Visible .F.,;
         Text "Benennung",;
         Left 5.332,;
         Top 3.3498,;
         PageNo 0,;
         Height 0.8809

   DEFINE TEXT TEXT_CODEWORT OF THIS;
       PROPERTY; 
         Width 9.5332,;
         Visible .F.,;
         Text "Codewort",;
         Left 53.1328,;
         Top 3.3498,;
         PageNo 0,;
         Height 0.9395

   DEFINE TEXT TEXT_NUMMER OF THIS;
       PROPERTY; 
         Width 8.1338,;
         Visible .F.,;
         Text "Nummer",;
         Left 77.6992,;
         Top 3.3498,;
         PageNo 0,;
         Height 0.8809

   DEFINE TEXT TEXT_HST OF THIS;
       PROPERTY; 
         Width 9.5,;
         Text "Hersteller",;
         Left 3.166,;
         Top 7.4111,;
         Height 1

   DEFINE TEXT TEXT_KLASSI OF THIS;
       PROPERTY; 
         Width 13,;
         Text "Klassifikation",;
         Left 50,;
         Top 7.4111,;
         Height 0.8232

   DEFINE TEXT TEXT_P_ZEIT OF THIS;
       PROPERTY; 
         Width 8.5,;
         Text " Prfzeit ",;
         Left 83.666,;
         Top 7.4111,;
         Height 0.9414

   DEFINE TEXT TEXT_MERKMALE OF THIS;
       PROPERTY; 
         Width 10.167,;
         Text "Merkmale",;
         Left 3.666,;
         Top 9.3525,;
         Height 0.9414

   DEFINE TEXT TEXT_ABW OF THIS;
       PROPERTY; 
         Width 9.833,;
         Text "Zul. Abw.",;
         Left 61,;
         Top 9.3525,;
         Height 0.8232

   DEFINE TEXT TEXT_BES OF THIS;
       PROPERTY; 
         Width 11,;
         Visible .F.,;
         Text "Eigentmer",;
         Left 4.833,;
         Top 11.3525,;
         Height 0.9414

   DEFINE TEXT TEXT_GERAETE_NR OF THIS;
       PROPERTY; 
         Width 10.333,;
         Visible .F.,;
         Text "Ger„te-Nr.",;
         Left 43,;
         Top 11.3525,;
         Height 1.0586

   DEFINE TEXT TEXT_ERST_EINS OF THIS;
       PROPERTY; 
         Width 10.666,;
         Visible .F.,;
         Text "Ersteinsatz",;
         Left 75.5,;
         Top 11.3525,;
         Height 0.9414

   DEFINE TEXT TEXT_KFR OF THIS;
       PROPERTY; 
         Width 15,;
         Text "Prffrist [Tage]",;
         Left 3.466,;
         Top 13.3525,;
         Height 0.9414

   DEFINE TEXT TEXT_SONSTIGES OF THIS;
       PROPERTY; 
         Width 9.667,;
         Text "Sonstiges",;
         Left 30.633,;
         Top 13.3525,;
         Height 1.0586

   DEFINE TEXT TEXT_ART OF THIS;
       PROPERTY; 
         Width 3.166,;
         Text "Art",;
         Left 14.5,;
         Top 16.6465,;
         Height 0.9414

   DEFINE TEXT TEXT_PB_DATUM OF THIS;
       PROPERTY; 
         Width 6.666,;
         Text "Datum",;
         Left 41.5,;
         Top 16.6465,;
         Height 0.9414

   DEFINE TEXT TEXT_PB_KOST OF THIS;
       PROPERTY; 
         Width 12.166,;
         Text "Kosten [DM]",;
         Left 67.5,;
         Top 16.6465,;
         Height 1

   DEFINE TEXT TEXT_PB_ORT OF THIS;
       PROPERTY; 
         Width 8.5,;
         Text "Standort",;
         Left 5.333,;
         Top 18.4111,;
         Height 0.8828

   DEFINE TEXT TEXT_PB_BEM OF THIS;
       PROPERTY; 
         Width 11.166,;
         Text "Bemerkung",;
         Left 43.5,;
         Top 18.4111,;
         Height 1

   DEFINE COMBOBOX BEN OF THIS;
       PROPERTY; 
         OnOpen CLASS::BEN_ONOPEN,;
         Width 33.666,;
         Visible .F.,;
         DropDownHeight 8,;
         Left 17,;
         OnChange CLASS::BEN_ONCHANGE,;
         Style 1,;
         Top 3.1691,;
         FontName "Arial",;
         PageNo 0,;
         Height 1.2354

   DEFINE ENTRYFIELD NUMMER OF THIS;
       PROPERTY; 
         Width 7,;
         Visible .F.,;
         ValidRequired .T.,;
         Left 86,;
         Function "B",;
         Top 3.1691,;
         PageNo 0,;
         Height 1.2354

   DEFINE COMBOBOX HST OF THIS;
       PROPERTY; 
         OnOpen {; this.value = kartei->hst; this.visible=.t.},;
         Width 35.167,;
         Visible .F.,;
         Left 12.833,;
         OnChange CLASS::HST_ONCHANGE,;
         DropDownHeight 10,;
         Style 1,;
         DataSource "FIELD hst->hst",;
         Top 7.1758,;
         FontName "Arial",;
         Height 1.2354

   DEFINE COMBOBOX KLASSI OF THIS;
       PROPERTY; 
         OnOpen {; this.value = kartei->klassi; this.visible=.t.},;
         Width 19.167,;
         Visible .F.,;
         DropDownHeight 5,;
         Left 63.333,;
         OnChange CLASS::KLASSI_ONCHANGE,;
         Style 1,;
         DataSource "FIELD klassi->klassi",;
         Top 7.1758,;
         FontName "Arial",;
         Height 1.2354

   DEFINE SPINBOX P_ZEIT OF THIS;
       PROPERTY; 
         Width 8,;
         Step 5,;
         Rangemin 0,;
         Rangemax 999,;
         RangeRequired .T.,;
         Left 92.333,;
         Value kartei->p_zeit,;
         Picture "999",;
         Function "BZ",;
         Top 7.1758,;
         Height 1.2354

   DEFINE COMBOBOX MERKMALE OF THIS;
       PROPERTY; 
         OnOpen CLASS::MERKMALE_ONOPEN,;
         Width 46.834,;
         Visible .F.,;
         DropDownHeight 9,;
         Left 13.166,;
         OnChange CLASS::MERKMALE_ONCHANGE,;
         Style 1,;
         Top 9.1758,;
         FontName "Arial",;
         Height 1.2354

   DEFINE COMBOBOX ABW OF THIS;
       PROPERTY; 
         OnOpen CLASS::ABW_ONOPEN,;
         Width 29,;
         Visible .F.,;
         DropDownHeight 7,;
         Left 70.5,;
         OnChange CLASS::ABW_ONCHANGE,;
         Style 1,;
         Top 9.1758,;
         FontName "Arial",;
         Height 1.2354

   DEFINE COMBOBOX BES OF THIS;
       PROPERTY; 
         OnOpen {; this.value = kartei->bes; this.visible=.t.},;
         Width 23.834,;
         Visible .F.,;
         DropDownHeight 10,;
         Left 16.166,;
         OnChange CLASS::BES_ONCHANGE,;
         Style 1,;
         DataSource "FIELD bes->bes",;
         Top 11.1758,;
         FontName "Arial",;
         Height 1.2354

   DEFINE ENTRYFIELD GERAETE_NR OF THIS;
       PROPERTY; 
         Width 19.166,;
         Visible .F.,;
         Left 53.5,;
         Value kartei->geraete_nr,;
         MaxLength 15,;
         Top 11.1758,;
         Height 1.2354

   DEFINE COMBOBOX KFR OF THIS;
       PROPERTY; 
         OnOpen {; if kartei->kfr > 0; this.value = ltrim(str(kartei->kfr)); else; this.value=""; endif; this.visible=.t.},;
         Width 10.167,;
         Visible .F.,;
         Left 18.466,;
         OnChange CLASS::KFR_ONCHANGE,;
         Style 1,;
         DataSource "FIELD kfr->kfr",;
         Top 13.2344,;
         Height 1.1768

   DEFINE ENTRYFIELD SONSTIGES OF THIS;
       PROPERTY; 
         Width 59.834,;
         Left 40.466,;
         Value kartei->sonstiges,;
         MaxLength 50,;
         Top 13.2344,;
         FontName "Arial",;
         Height 1.2354

   DEFINE COMBOBOX PB_ART OF THIS;
       PROPERTY; 
         OnOpen {; this.value = kartei->pb_art; this.visible=.t.; do SetOrt with form,"OnOpen"},;
         Width 19.667,;
         Visible .F.,;
         Left 18.166,;
         OnChange {; do PbArtCH with form},;
         Style 1,;
         DataSource "FIELD pb_art->pb_art",;
         Top 16.4111,;
         FontName "Arial",;
         Height 1.2354

   DEFINE SPINBOX PB_DATUM OF THIS;
       PROPERTY; 
         Width 15,;
         Valid CLASS::PB_DATUM_VALID,;
         Rangemin 1,;
         ValidRequired .T.,;
         Rangemax 100,;
         Left 48.666,;
         Value kartei->pb_datum,;
         Top 16.4111,;
         Height 1.2354

   DEFINE SPINBOX PB_KOST OF THIS;
       PROPERTY; 
         Width 13.334,;
         Step 10,;
         Rangemin 0,;
         Rangemax 99999.99,;
         RangeRequired .T.,;
         Left 80.166,;
         Value kartei->pb_kost,;
         Picture "#####.##",;
         Function "BZ",;
         Top 16.4111,;
         Height 1.2354

   DEFINE COMBOBOX PB_ORT OF THIS;
       PROPERTY; 
         Width 27.167,;
         Left 14.333,;
         OnChange {; do PbOrtCH with form},;
         Style 1,;
         DropDownHeight 9,;
         Value "",;
         Top 18.2344,;
         FontName "Arial",;
         Height 1.2354

   DEFINE ENTRYFIELD PB_BEM OF THIS;
       PROPERTY; 
         Width 42.833,;
         Left 55,;
         Value kartei->pb_bem,;
         MaxLength 30,;
         Top 18.2344,;
         FontName "Arial",;
         Height 1.2354

   DEFINE EDITOR NOT_KONV OF THIS;
       PROPERTY; 
         OnOpen CLASS::NOTIZEN_ONOPEN,;
         Width 87.166,;
         Visible .F.,;
         Left 8,;
         Top 7.2998,;
         CUATab .T.,;
         PageNo 3,;
         Height 12

   DEFINE OLE NOT_OLE OF THIS;
       PROPERTY; 
         Width 87.166,;
         Visible .F.,;
         Left 8,;
         Top 7.2998,;
         PageNo 3,;
         Height 12

   DEFINE EDITOR PROT_KONV OF THIS;
       PROPERTY; 
         OnOpen CLASS::PROTOKOLL_ONOPEN,;
         Width 87.166,;
         Visible .F.,;
         Left 8,;
         Top 7.2998,;
         CUATab .T.,;
         PageNo 4,;
         Height 12

   DEFINE OLE PROT_OLE OF THIS;
       PROPERTY; 
         Width 87.166,;
         Visible .F.,;
         Left 8,;
         Top 7.2998,;
         PageNo 4,;
         Height 12

   DEFINE EDITOR PLAN_KONV OF THIS;
       PROPERTY; 
         Width 87.166,;
         Modify .F.,;
         Left 8,;
         Value "",;
         Top 7.2998,;
         CUATab .T.,;
         PageNo 5,;
         Height 12

   DEFINE OLE PLAN_OLE OF THIS;
       PROPERTY; 
         Width 87.166,;
         Visible .F.,;
         Left 8,;
         Top 7.2998,;
         PageNo 5,;
         Height 12

   DEFINE ENTRYFIELD MESSAGE OF THIS;
       PROPERTY; 
         Width 66.667,;
         Left 18.333,;
         Value kartei->message,;
         Top 12.5879,;
         PageNo 6,;
         Height 1.2354


**************************************************************************


  Procedure BEN_OnOpen
  
   if .not. empty(kartei->codewort)   && leer nur bei pmk_neu m”glich
    sele os
    set order to 1
    set key to kartei->codewort
    this.datasource = "field os->ben"
    set key to
   endif 
   
   this.value=kartei->ben
   this.visible=.t.
   
  
  
  Procedure BEN_OnChange

   do case
    case kartei->ben == this.value
     *
    case empty(this.value)
     msgbox("Fehler: Es besteht Eingabepflicht.","Achtung",48)
     this.value = "?"
     this.setfocus()    
    otherwise
     local lcCodewort
     lcCodewort = left(ltrim(form.codewort.value)+space(10),10)
     sele os
     set order to 1
     if seek(lcCodewort+ltrim(this.value))
      this.value = ben
     else 
      if msgbox("  Nicht im Katalog enthalten - Aufnehmen ?","Katalog - Ordnungssystem",292) = 6
       set order to 0
       append blank
       repl codewort with lcCodewort, ben with ltrim(this.value), log_pm_art with .f.
       if type("form.nummer.value") = "N"
        repl log_lfdnr with .t.
       else
        repl log_lfdnr with .f.
       endif
       set order to 1
       set key to lcCodewort
       this.datasource = "FIELD os->ben"
       set key to
      endif
     endif
   endcase



   Procedure HST_OnChange
   
    if .not. empty(this.value) .and. .not. kartei->hst == this.value
     sele hst
     set order to 1
     if seek(ltrim(this.value))
      this.value = hst
     else
      if msgbox("  Nicht im Katalog enthalten - Aufnehmen ?","Katalog - Hersteller",292) = 6
       append blank
       repl hst with ltrim(this.value)
       this.datasource = "FIELD hst->hst"
      endif
     endif
    endif
   

   
   Procedure KLASSI_OnChange

    if .not. empty(this.value) .and. .not. kartei->klassi == this.value
     sele klassi
     set order to 1
     if seek(ltrim(this.value))
      this.value = klassi     
     else
      if msgbox("  Nicht im Katalog enthalten - Aufnehmen ?","Katalog - Klassifikation",292) = 6
       append blank
       repl klassi with ltrim(this.value)
       this.datasource = "FIELD klassi->klassi"
      endif
     endif
    endif
  
   
   
   
   Procedure MERKMALE_OnOpen
  
    if .not. empty(kartei->codewort)   && leer nur bei pmk_neu m”glich
     sele merkmale
     set order to 1
     set key to kartei->codewort
     this.datasource = "field merkmale->merkmale"
     set key to
    endif 
    
    this.value=kartei->merkmale
    this.visible=.t.
   
   
   
   
   Procedure MERKMALE_OnChange

    if .not. empty(this.value) .and. .not. kartei->merkmale == this.value
     local lcCodewort
     lcCodewort = left(ltrim(form.codewort.value)+space(10),10)
     sele merkmale
     set order to 1
     if seek(lcCodewort + ltrim(this.value))
      this.value = merkmale      
     else
      if msgbox("  Nicht im Katalog enthalten - Aufnehmen ?","Katalog - Merkmale",292) = 6
       set order to 0
       append blank
       repl codewort with lcCodewort, merkmale with ltrim(this.value)
       set order to 1
       set key to lcCodewort
       this.datasource = "FIELD merkmale->merkmale"
       set key to
      endif
     endif
    endif
   
   

  Procedure ABW_OnOpen
  
   if .not. empty(kartei->codewort)   && leer nur bei pmk_neu m”glich
    sele abw
    set order to 1
    set key to kartei->codewort
    this.datasource = "field abw->abw"
    set key to 
   endif 
   
   this.value=kartei->abw
   this.visible=.t.
   
   
   
  Procedure ABW_OnChange

   if .not. empty(this.value) .and. .not. kartei->abw == this.value
    local lcCodewort
    lcCodewort = left(ltrim(form.codewort.value)+space(10),10)
    sele abw
    set order to 1
    if seek(lcCodewort + ltrim(this.value))
     this.value = abw
    else
     if msgbox("  Nicht im Katalog enthalten - Aufnehmen ?","Katalog - Zul„ssige Abweichungen",292) = 6
      set order to 0
      append blank
      repl codewort with lcCodewort, abw with ltrim(this.value)
      set order to 1
      set key to lcCodewort
      this.datasource = "FIELD abw->abw"
      set key to
     endif
    endif
   endif



   Procedure BES_OnChange

    if .not. empty(this.value) .and. .not. kartei->bes == this.value
     sele bes
     set order to 1
     if seek(nutzer.mand_nr + ltrim(this.value))
      this.value = bes
     else 
      if msgbox("  Nicht im Katalog enthalten - Aufnehmen ?","Katalog - Eigentmer",292) = 6
       append blank
       repl mand_nr with nutzer.mand_nr, bes with ltrim(this.value)
       this.datasource = "FIELD bes->bes"
      endif
     endif
    endif



   Procedure KFR_OnChange
   
    do case
     case empty(this.value)
      return
     case type(this.value) <> "N"
      msgbox("Fehler: Schreibfehler.","Achtung",48)
      this.setfocus()
      return
     otherwise
      sele kfr
      set order to 1
      if .not. seek(val(this.value))
       msgbox("Fehler: Die Eingabe ist nicht im Katalog enthalten.","Achtung",48)
       this.setfocus()
       return
      endif
    endcase
   
    if form.name = "PMK_EDI"
     if lower(ltrim(rtrim(form.pb_art.value))) $ "eichen kalibrieren"
      local ldDatum
      if substr(form.historie.value,len(form.historie.value)-77,12) = ltrim(form.pb_art.value)
       if msgbox("Das Datum der Bewegung wird auf Grundlage des Einsatzdatums des Prfmittels neu berechnet...","Datum neu berechnen...",273) = 1
        ldDatum = ctod(substr(form.historie.value,len(form.historie.value)-89,10)) + val(this.value)
       else
        this.value = ltrim(str(kartei->kfr))
        form.pb_datum.value = ctod(substr(form.historie.value,len(form.historie.value)-89,10)) + kartei->kfr
        this.setfocus()
        return
       endif 
      else
       ldDatum = date() + val(this.value)
      endif
     endif
    else
     if lower(ltrim(rtrim(form.pb_art.value))) $ "eichen kalibrieren"
      local ldDatum
      ldDatum = date() + val(this.value)
     endif
    endif
    
    if lower(ltrim(rtrim(form.pb_art.value))) $ "eichen kalibrieren"
     do case
      case cdow(ldDatum) = "Samstag" 
       ldDatum = ldDatum + 2
      case cdow(ldDatum) = "Sonntag"
       ldDatum = ldDatum + 1     
     endcase
     form.pb_datum.value = ldDatum
    endif
    



  Procedure PB_DATUM_Valid

    privat plValid
    plValid = .t.

    do PbDatVA with form
    
    return plValid



   
  Procedure NOTIZEN_OnOpen

    if empty(kartei->not_ole)
     form.rechteck_notizen.fontitalic = .t.
     form.rechteck_notizen.text = "  Notizen  "
     form.not_konv.datalink = "kartei->not_konv"
     form.not_konv.visible = .t.
    else
     form.not_ole.datalink = "kartei->not_ole"
     form.rechteck_notizen.fontitalic = .f.
     form.rechteck_notizen.text = "  Notizen [ " + form.not_ole.servername + " ]  "
     form.not_ole.visible = .t.
    endif    

   
   
   
  Procedure PROTOKOLL_OnOpen

    if empty(kartei->prot_ole)
     form.rechteck_protokoll.fontitalic = .t.
     form.rechteck_protokoll.text = "  Prfprotokoll  "
     form.prot_konv.datalink = "kartei->prot_konv"
     form.prot_konv.visible = .t.
    else
     form.prot_ole.datalink = "kartei->prot_ole"
     form.rechteck_protokoll.fontitalic = .f.
     form.rechteck_protokoll.text = "  Prfprotokoll [ " + form.prot_ole.servername + " ]  "
     form.prot_ole.visible = .t.
    endif   




  Procedure SCHALTER_OLE_OnClick 
  
   if msgbox("Es wird ein neues OLE-Objekt eingefgt. Dabei werden vorhandene Daten gegebenfalls berschrieben.","OLE-Objekt einbetten...",273) = 1
      
    sele kartei
    
    if form.pageno = 3
     repl ole not_ole from ?
     if empty(kartei->not_ole)  && rckg„ngigmachen einer ole-verbindung leider nicht m”glich ?!
      form.not_ole.visible  = .f.
      form.rechteck_notizen.text = "  Notizen  "
      form.rechteck_notizen.fontitalic = .t.
      form.not_konv.datalink = "kartei->not_konv"
      form.not_konv.visible = .t.
     else
      form.not_konv.visible = .f.
      repl not_konv with ""
      form.not_konv.datalink = ""
      form.not_ole.datalink = "kartei->not_ole"
      form.rechteck_notizen.text = "  Notizen [ " + form.not_ole.servername + " ]  "
      form.rechteck_notizen.fontitalic = .f.
      form.not_ole.visible = .t.
     endif
    else 
     repl ole prot_ole from ?
     if empty(kartei->prot_ole)
      * rckg„ngigmachen einer ole-verbindung leider nicht m”glich ?!
      form.prot_ole.visible  = .f.
      form.rechteck_protokoll.text = "  Prfprotokoll  "
      form.rechteck_protokoll.fontitalic = .t.
      form.prot_konv.datalink = "kartei->prot_konv"
      form.prot_konv.visible = .t.
     else
      form.prot_konv.visible = .f.
      repl prot_konv with ""
      form.prot_konv.datalink = ""
      form.prot_ole.datalink = "kartei->prot_ole"
      form.rechteck_protokoll.text = "  Prfprotokoll [ " + form.prot_ole.servername + " ]  "
      form.rechteck_protokoll.fontitalic = .f.
      form.prot_ole.visible = .t.
     endif
    endif
   
   endif   


          
ENDCLASS



*********** basiskarte mit men- und schalterleiste *********************


CLASS Karte OF FORM Custom
   this.Width = 103.833
   this.MenuFile = "KARTEI.MNU"
   this.EscExit = .F.
   this.Text = ""
   this.Left = 0.666
   this.Top = 0.2939
   this.Height = 22.2939

   DEFINE RECTANGLE RECHTECK1 OF THIS;
       PROPERTY; 
         Width 106.6641,;
         ColorNormal "BtnText/W",;
         Text "",;
         Top 0.0752,;
         PageNo 0,;
         BorderStyle 1,;
         Height 1.7061

   DEFINE PUSHBUTTON SCHALTER_FILTER OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #750",;
         Left 1,;
         OnClick {;do filter.wfm with form.formularnummer},;
         SpeedTip "Filter neu festlegen",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #751",;
         Height 1.3477

   DEFINE PUSHBUTTON SCHALTER_FILTERANZEIGE OF THIS;
       PROPERTY; 
         Width 3.666,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #32",;
         Left 4.5,;
         OnClick {;do filt_anz.wfm with form.formularnummer},;
         SpeedTip "Aktuellen Filter anzeigen",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #33",;
         Height 1.3477
         
   DEFINE PUSHBUTTON SCHALTER_SCHNELLSUCHE OF THIS;
       PROPERTY; 
         Width 3.666,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #858",;
         Enabled .F.,;
         Left 10.5,;
         SpeedTip "Schnellsuche",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #868",;
         Height 1.3535      

   DEFINE PUSHBUTTON SCHALTER_BROWSER OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #650",;
         Left 16.5,;
         OnClick {;do browser.wfm with form.formularnummer},;
         SpeedTip "Browser",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         Height 1.3535

   DEFINE PUSHBUTTON SCHALTER_PMK_NEU OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #2060",;
         Left 24,;
         OnClick {; do pmk_neu.wfm with form.formularnummer},;
         SpeedTip "Neue Karte anlegen",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #2061",;
         Height 1.3477

   DEFINE PUSHBUTTON SCHALTER_OLE OF THIS;
       PROPERTY; 
         Width 3.667,;
         Enabled .F.,;
         ColorNormal "RB/BtnFace",;
         OnClick CLASS::SCHALTER_OLE_ONCLICK,;
         Group .T.,;
         FontName "Small Fonts",;
         Text "OLE",;
         Left 31.333,;
         SpeedTip "OLE-Objekt einbetten",;
         FontSize 6,;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         Height 1.3477

   DEFINE PUSHBUTTON SCHALTER_FONT OF THIS;
       PROPERTY; 
         Width 3.667,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #621",;
         Left 38.333,;
         OnClick CLASS::SCHALTER_FONT_ONCLICK,;
         SpeedTip "Zeichensatz „ndern",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         Height 1.3477

   DEFINE PUSHBUTTON SCHALTER_DRUCKER_EINRICHTEN OF THIS;
       PROPERTY; 
         Width 3.667,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #2230",;
         Left 44.166,;
         OnClick {;chooseprinter()},;
         SpeedTip "Drucker einrichten",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         Height 1.3477

   DEFINE PUSHBUTTON SCHALTER_AUSGABE OF THIS;
       PROPERTY; 
         Width 3.667,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #857",;
         Left 47.666,;
         SpeedTip "Ausgabe Drucker/Datei",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #867",;
         Height 1.3477

   DEFINE PUSHBUTTON SCHALTER_FENSTERINFO OF THIS;
       PROPERTY; 
         Width 3.667,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #623",;
         Left 54.833,;
         OnClick CLASS::SCHALTER_FENSTERINFO_ONCLICK,;
         SpeedTip "Fenstername erweitern",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         Height 1.3477

   DEFINE PUSHBUTTON SCHALTER_ABBRUCH OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #28",;
         Left 62,;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #29",;
         Height 1.3535

   DEFINE PUSHBUTTON SCHALTER_OK OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #20",;
         Left 65.5,;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #21",;
         Height 1.3535

   DEFINE PUSHBUTTON SCHALTER_ERSTE_KARTE OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         ColorNormal "N/BtnFace",;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #851",;
         Left 73.5,;
         SpeedTip "Erste gefundene Karte",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #861",;
         Height 1.3516

   DEFINE PUSHBUTTON SCHALTER_RUECKWAERTSSUCHEN OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #852",;
         Left 77,;
         SpeedTip "Rckw„rts suchen",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #862",;
         Height 1.3516

   DEFINE PUSHBUTTON SCHALTER_KARTE_VORHER OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #853",;
         Left 80.5,;
         SpeedTip "Karte vorher",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #863",;
         Height 1.3516

   DEFINE PUSHBUTTON SCHALTER_KARTE_DANACH OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #854",;
         Left 84,;
         SpeedTip "Karte danach",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #864",;
         Height 1.3516

   DEFINE PUSHBUTTON SCHALTER_VORWAERTSSUCHEN OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #855",;
         Left 87.5,;
         SpeedTip "Vorw„rts suchen",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #865",;
         Height 1.3516

   DEFINE PUSHBUTTON SCHALTER_LETZTE_KARTE OF THIS;
       PROPERTY; 
         Width 3.666,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #856",;
         Left 91,;
         SpeedTip "Letzte gefundene Karte",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #866",;
         Height 1.3516

   DEFINE PUSHBUTTON SCHALTER_SCHLIESZEN OF THIS;
       PROPERTY; 
         Width 3.668,;
         Enabled .F.,;
         Group .T.,;
         Text "",;
         UpBitmap "RESOURCE #1005",;
         Left 99.165,;
         SpeedTip "Schlieáen",;
         Top 0.25,;
         PageNo 0,;
         SpeedBar .T.,;
         DisabledBitmap "RESOURCE #1006",;
         Height 1.3477

         
   Procedure SCHALTER_OLE_OnClick 
   
    * achtung vorzeitiges return
    
    sele kartei  && notwendig, da sonst bei anlegen einer neuen prfmittelkarte unerkl„rliche probleme ?!
      
    if form.not_ole.pageno = form.pageno
    
     do while .t.
     
      if empty(kartei->not_konv)
       if empty(kartei->not_ole)
        exit
       else
        if msgbox(" Soll das angezeigte OLE-Objekt gel”scht werden ?","OLE-Objekt l”schen ?",292) = 6
         blank field kartei->not_ole
         form.not_ole.visible  = .f.
         form.rechteck_notizen.text = "  Notizen  "
         form.rechteck_notizen.fontitalic = .t.
         form.not_ole.datalink = ""
         form.not_konv.datalink = "kartei->not_konv"
         form.not_konv.visible = .t.
         return
        endif
       endif
      endif
     
      if msgbox("Es wird ein neues OLE-Objekt eingefgt. Dadurch werden die vorhandenen Notizen berschrieben.","OLE-Objekt einbetten...",273) = 1
       exit
      else 
       return
      endif
     
     enddo
     
     repl ole kartei->not_ole from ?
     
     if empty(kartei->not_ole)
      form.not_ole.visible  = .f.
      form.rechteck_notizen.text = "  Notizen  "
      form.rechteck_notizen.fontitalic = .t.
      form.not_ole.datalink = ""
      form.not_konv.datalink = "kartei->not_konv"
      form.not_konv.visible = .t.
     else
      form.not_konv.visible = .f.
      blank field kartei->not_konv
      form.not_konv.datalink = ""
      form.not_ole.datalink = "kartei->not_ole"
      form.rechteck_notizen.text = "  Notizen [ " + form.not_ole.servername + " ]  "
      form.rechteck_notizen.fontitalic = .f.
      form.not_ole.visible = .t.
     endif
     
    else 
    
     do while .t.
     
      if empty(kartei->prot_konv)
       if empty(kartei->prot_ole)
        exit
       else
        if msgbox("Soll das angezeigte OLE-Objekt gel”scht werden ?","OLE-Objekt l”schen ?",292) = 6
         blank field kartei->prot_ole
         form.prot_ole.visible  = .f.
         form.rechteck_protokoll.text = "  Protokoll  "
         form.rechteck_protokoll.fontitalic = .t.
         form.prot_ole.datalink = ""
         form.prot_konv.datalink = "kartei->prot_konv"
         form.prot_konv.visible = .t.
         return
        endif
       endif
      endif
     
      if msgbox("Es wird ein neues OLE-Objekt eingefgt. Dadurch wird das vorhandene Prfpotokoll berschrieben.","OLE-Objekt einbetten...",273) = 1
       exit
      else 
       return
      endif
     
     enddo
    
     repl ole kartei->prot_ole from ?
    
     if empty(kartei->prot_ole)
      form.prot_ole.visible  = .f.
      form.rechteck_protokoll.text = "  Prfprotokoll  "
      form.rechteck_protokoll.fontitalic = .t.
      form.prot_ole.datalink = ""
      form.prot_konv.datalink = "kartei->prot_konv"
      form.prot_konv.visible = .t.
     else
      form.prot_konv.visible = .f.
      blank field kartei->prot_konv
      form.prot_konv.datalink = ""
      form.prot_ole.datalink = "kartei->prot_ole"
      form.rechteck_protokoll.text = "  Prfprotokoll [ " + form.prot_ole.servername + " ]  "
      form.rechteck_protokoll.fontitalic = .f.
      form.prot_ole.visible = .t.
     endif
     
    endif      
         


   Procedure SCHALTER_FONT_OnClick
   
    local lcFont
    
    lcFont = getfont("Zeichensatz fr die Ausgabe des Berichtes")
    
    if .not. empty(lcFont)
     local lcFontName, lcFontSize, lcFontExtras
     store "" to lcFontName, lcFontSize, lcFontExtras
     lcFontName = left(lcFont,at(",",lcFont,1)-1)
     lcFontSize = substr(lcFont,at(",",lcFont,1)+1,at(",",lcFont,2)-at(",",lcFont,1))
     if at(",",lcFont,3) > 0
      lcFontExtras = substr(lcFont,at(",",lcFont,2)+1,at(",",lcFont,3)-at(",",lcFont,2))
     endif   
     if .not. empty(lcFontName)
      form.ausgabe.fontname = lcFontName
      if .not. empty(lcFontSize)
       form.ausgabe.fontsize = val(lcFontSize)
      endif 
      if .not. empty(lcFontExtras)
       local lnPos
       lnPos = 1
       do while lnPos <= len(lcFontExtras)
        do case
         case upper(substr(lcFontExtras,lnPos,1)) = "B"
          form.ausgabe.fontbold = .t.
         case upper(substr(lcFontExtras,lnPos,1)) = "I"
          form.ausgabe.fontitalic = .t.
         case upper(substr(lcFontExtras,lnPos,1)) = "U"
          form.ausgabe.fontunderline = .t.
         case upper(substr(lcFontExtras,lnPos,1)) = "S"
          form.ausgabe.fontstrike = .t.
        endcase  
        lnPos = lnPos + 1
       enddo 
      endif
      form.ausgabe.datalink = "file " + form.Berichtsdatei
      form.ausgabe.setfocus()
     endif 
    endif
   
   
   
   Procedure SCHALTER_FENSTERINFO_OnClick
   
    local f
    f = new FEN_INFO(form)
    f.readmodal()
   
   
   
ENDCLASS


**************** basisformular zum editieren von katalogen ***********


CLASS KATALOGFORM OF FORM Custom
   this.Width = 70.833
   this.Text = ""
   this.MDI = .F.
   this.EscExit = .F.
   this.Left = 17
   this.Top = 5
   this.Height = 16.5293

   DEFINE PUSHBUTTON SCHALTER_LOESCHEN OF THIS;
       PROPERTY; 
         Width 18,;
         Text "L”schen",;
         UpBitmap "RESOURCE #24",;
         DisabledBitmap "RESOURCE #25",;
         Left 5.666,;
         Top 11.6,;
         Group .T.,;
         SpeedBar .T.,;
         Height 1.55

   DEFINE PUSHBUTTON SCHALTER_KORRIGIEREN OF THIS;
       PROPERTY; 
         Width 18,;
         Text "Korrigieren",;
         UpBitmap "RESOURCE #148",;
         DisabledBitmap "RESOURCE #149",;
         Left 26.666,;
         Top 11.6,;
         Group .T.,;
         SpeedBar .T.,;
         Height 1.55

   DEFINE PUSHBUTTON SCHALTER_HINZUFUEGEN OF THIS;
       PROPERTY; 
         Width 18,;
         Text "Hinzufgen",;
         UpBitmap "RESOURCE #855",;
         DisabledBitmap "RESOURCE #865",;
         Left 47.333,;
         Top 11.6,;
         Group .T.,;
         SpeedBar .T.,;
         Height 1.55

   DEFINE PUSHBUTTON SCHALTER_SCHLIESZEN OF THIS;
       PROPERTY; 
         Width 22.833,;
         Text "Schlieáen",;
         UpBitmap "RESOURCE #1005",;
         DisabledBitmap "RESOURCE #1006",;
         OnClick {; form.close()},;
         Left 24,;
         Top 14,;
         Group .T.,;
         SpeedBar .T.,;
         Height 1.8232
         

          
ENDCLASS