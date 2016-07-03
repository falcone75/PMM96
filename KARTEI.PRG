
clear memo

********************  Hauptprogramm der PrÅfmittelkartei  ********************

shell(.f.,.t.)

_app.FrameWin.text = "PrÅfmittel - Manager 96  [ Kein Nutzer ]"


if 1=2  && bei demoversion einstellen

 *** ascii-werte siehe handbuch: ms-dos, seite 237 bzw. handbuch: befehle und funktionen, seite 1207
  
 if date() <= ctod( ltrim(str(asc("d")-asc("E"),2)) + "." + ltrim(str(asc("x")-asc("u"),2)) + "." + ltrim(str(asc("2")+asc("/"),2)) )
  msgbox('Wenn Sie im Programm nicht weiter wissen, die F1-Taste nicht helfen kann, dann rufen Sie doch einfach mal an.',"Diese Demoversion ist bis zum 31.03.97 lauffÑhig ...",64)
 else
  msgbox("Die Einsatzdauer dieser Demoversion ist abgelaufen.","Alles hat ein Ende ...",64)
  quit
 endif

endif


if 1=2  && bei weitergabe der anwendung einschalten

 set safety off

 rele all like setup*
 restore from setup.mem additive
 
 * setup1 ... anzahl programmaufrufe
 * setup2 ... datum des letzten physischen lîschens
 * setup3 ... logische variable, ob anzeige der tips

 if setup1 >= 10 .and. date() - setup2 >= 30
  if .not. network()
   do kat_pack
   setup1 = 0
   setup2 = date()
  else
   if msgbox("Das physische Lîschen gelîschter Daten liegt minde- stens 30 Tage und 10 Programmaufrufe zurÅck. Stellen Sie bitte sicher, da· Sie z.Z. der einzige Nutzer des Programmes im Netzwerk sind.","Datenbank sÑubern...",273) = 1
    do kat_pack
    setup1 = 0
    setup2 = date()
   else
    setup1 = setup1 + 1
   endif
  endif 
 else
  setup1 = setup1 + 1
 endif

 public glTipsUndTricks
 glTipsUndTricks = setup3
 
 save to setup.mem like setup?
 
 rele setup1, setup2, setup3

else 

 public glTipsUndTricks
 glTipsUndTricks = .f.

endif


set procedure to archiv_p.pro  && archiv-proceduren
set procedure to archiv_c.pro additive  && archiv-classen

public gnFormularZaehler
gnFormularZaehler = 0


** END HEADER -- Diese Zeile nicht lîschen*
* Erstellt am 11.01.95
*

public HauptForm
HauptForm = new KARTEIFORM()
do SetLog with "00000000000000000"
HauptForm.Open()


CLASS KARTEIFORM OF FORM
  this.MenuFile = "KARTEI.MNU"
  this.mdi = .T.
  this.EscExit = .F.
  this.Text = ""
  this.top = 100  && au·erhalb des bildschirmbereiches
  this.left = 0
  this.height = 1
  this.width = 16
  this.ColorNormal = "w+"
  this.OnGotFocus = {; this.WindowState = 2}
  this.OnClose = class::HAUPTFORM_OnClose
  
  
  
   Procedure HAUPTFORM_OnClose

    privat pcZahl
    for i=1 to gnFormularZaehler
     pcZahl = ltrim(str(i))
     if type ("Formular&pcZahl") = "O"   &&  -> formular offen ( Variable wird sonst beim verlassen des formulars gelîscht )
      Formular&pcZahl..Close()
      if type ("Browser&pcZahl") = "O"   &&  -> browser offen ( Variable wird sonst beim verlassen des formulars gelîscht )
       Browser&pcZahl..Close()
      endif
     endif 
    next

    * public-variable
    rele glTipsUndTricks, gnFormularZaehler, Hauptform, Nutzer
    

ENDCLASS

