*** archiv_c.prg

** klassenarchiv



***********  klasse zur eingabe des fensternames  ****************************

CLASS FEN_INFO(ref) OF FORM

   public referenz
   referenz=ref

   this.Width = 62.166
   this.Text = "Fenstername erweitern"
   this.MDI = .f.
   this.Left = 20.5
   this.Top = 10.5293
   this.Height = 6.2939
   
   this.OnClose = {; rele referenz}

   DEFINE TEXT TEXT1 OF THIS;
       PROPERTY; 
         Width 12,;
         Text "Fenstername",;
         Left 3.5,;
         Top 1.6465,;
         Height 0.8818

   DEFINE ENTRYFIELD FENSTERINFO OF THIS;
       PROPERTY; 
         Width 41.667,;
         Left 16.666,;
         Value "",;
         MaxLength 35,;
         Top 1.5293,;
         Height 1.1172

   DEFINE PUSHBUTTON ABBRUCHFELD OF THIS;
       PROPERTY; 
         Width 16,;
         Text "Abbruch",;
         UpBitmap "RESOURCE #28",;
         Left 11.666,;
         OnClick {; form.close()},;
         Group .T.,;
         Top 4,;
         Height 1.3994

   DEFINE PUSHBUTTON OKFELD OF THIS;
       PROPERTY; 
         Width 16,;
         Text "OK",;
         UpBitmap "RESOURCE #20",;
         Left 34.5,;
         OnClick CLASS::OKFELD_ONCLICK,;
         Group .T.,;
         Top 4,;
         Default .T.,;
         Height 1.3994


   Procedure OKFELD_OnClick

    local lcNeuerFormulartext
    
    if "[" $ referenz.text
     lcNeuerFormulartext = left(referenz.text,at("[",referenz.text)-2)
    else
     lcNeuerFormulartext = referenz.text
    endif 
     
    if empty(form.fensterinfo.value)
     referenz.text = lcNeuerFormulartext
    else   
     referenz.text = lcNeuerFormulartext + " [ " + ltrim(rtrim(form.fensterinfo.value)) + " ] "
    endif
   
    form.close()
   
   
ENDCLASS


 
**** klasse zur anzeige des abbruchfensters bei zeitintensiven vorg„ngen 

CLASS WARTENFORM OF FORM
   this.Width = 45.666
   this.Text = "Bitte warten ..."
   this.Left = 29.5
   this.MousePointer = 11
   this.Top = 7.4111
   this.Height = 3.8818

   DEFINE TEXT TEXT1 OF THIS;
       PROPERTY; 
         Width 36.667,;
         ColorNormal "R/BtnFace",;
         Text "Abbruch durch beliebige Taste",;
         OldStyle .T.,;
         FontSize 10,;
         Left 5.166,;
         MousePointer 11,;
         Top 1.4111,;
         Height 1.2354


*** abbruch mit inkey-funktion erzwingen

ENDCLASS



**** klasse zur auswahl eines prfplanes

CLASS AUSWAHL_PLAN OF FORM
   this.Width = 60
   this.Text = "Prfplan ausw„hlen..."
   this.mdi = .f.
   this.Left = 22
   this.Top = 10.6
   this.Height = 6.2

   DEFINE LISTBOX LISTE OF THIS;
       PROPERTY; 
         Width 54.3359,;
         ColorHighLight "HighLightText/HighLight",;
         Left 2.8,;
         DataSource "FIELD P_PLAN->PP_NAME",;
         Top 0.9395,;
         OnLeftMouseDown {; seek listselected(form.liste); form.close()},;
         ID 100,;
         Height 4.4131
         

ENDCLASS