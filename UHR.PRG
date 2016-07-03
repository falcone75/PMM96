*******************************************************************************
*  PROGRAMM:     DBuhr.prg angepa·t !!!
*
*  AUTOREN:      Borland 'Beispielgruppe'
*
*  DATUM:        12/93
*
*  AKTUALISIERT: 3/96 by Graubner
*
*  REVISION:     $Revision:   1.7  $
*
*  VERSION:      Visual dBASE
*
*  BESCHREIBUNG: Dieses Programm zeigt eine Digitaluhr an, die Sie beliebig
*                verÑndern kînnen. Das Programm kann im Hintergrund ausge-
*                fÅhrt werden, wÑhrend andere Windows-Anwendungen aktiv sind.
*                Das Programm arbeitet mit dem VBX-Steuerungselement DBTimer,
*                um die Uhrzeit zu aktualisieren. Sie kînnen das Aussehen der
*                Uhr verÑndern, indem Sie im MenÅ Optionen das GewÅnschte
*                auswÑhlen. VerÑndern lassen sich die Schriftart, die Farbe
*                und Zeitdarstellung (12 oder 24 Std.). Die Grî·e der Ziffern
*                pa·t sich an die Grî·e des Formulars an. Die Ziffern sind
*                aber immer zentriert.
*
*                ACHTUNG: Falls ein Fehler auftritt, kînnte es sein, da· die
*                         Uhr weiterarbeitet und bei jedem Sekundenwechsel
*                         das Fenster ACHTUNG angezeigt wird. Sie kînnen dies
*                         mit GPF beenden.
*
*  PARAMETER:    Keine
*
*  AUFRUFE:      DBTimer.vbx (Zeit VBX Control)
*                Buttons.cc          (FÅr benutzerdefinierte Befehlsfelder)
*
*  SYNTAX:       Do DBUhr
*	       
*******************************************************************************

create session
set talk off
set ldCheck off

set procedure to program(1) additive
*set procedure to &_dbwinhome.beispiel\Buttons.cc additive
local f
f = new ClockForm()
f.open()

*******************************************************************************
*******************************************************************************
class ClockForm of Form
*******************************************************************************

   this.top = 1.5
   this.left = 90
   this.height = 2
   this.width = 12
   this.TopMost = .t. 
   this.mdi = .f.
   this.minimize = .f.
   this.maximize = .f.
   this.text = "Uhr"
   this.sizeable = .f.
   this.moveable = .t.
   this.sysMenu = .t.

   define text timeText of this;
      property;
         text time(),;
         alignment 4,;
         colornormal "rb/w",;
         height 5,;
         width 11.22,;
         fontName "MS Sans Serif",;
         fontsize 12,;
         fontBold .t.

   load dll dbtimer.vbx
   
   define dbtimer timer of this;
      property;
         Width          4.62,;
         Height         2.37,;
         Top          300.06,;
         Left         300.12,;
         OnTimer {;form.timeText.text = form.GetTime()}
         
   this.TimeProperty = CLASS::TimeProperty
*   this.DefineMenu()


   *******************************************************************************
   procedure OnOpen
   *******************************************************************************
   private optionsRef

   public formatMenuChecked, colorNormalMenuChecked, fontNameMenuChecked,;
      fontBoldMenuChecked, fontItalicMenuChecked


   this.menuReleased = .F.             && -- Festlegen, da· Formular kein MenÅ hat
   this.timeFormat = 0                 && -- Format der Uhrzeit
   this.GetTime = Get24Time            && -- Funktion zum Anzeigen der Uhrzeit
                                       && GetTime wird auf Get24Time oder Get12Time eingestellt
                                       && abhaÑngig davon, was im MenÅ Format 
                                       && eingestellt ist.
if 1=2
   optionsRef = this.MainMenu.Options  && Damit man nicht auf Verweis 
                                       && zugreifen mu·

   formatMenuChecked      = optionsRef.Formats.TwentyFourHrFormat
   colorNormalMenuChecked = optionsRef.Colors.CyanColor
   fontNameMenuChecked    = optionsRef.Fonts.SansSerifFont
   fontBoldMenuChecked    = optionsRef.Bold.BoldOff
   fontItalicMenuChecked  = optionsRef.Italic.ItalicOff
endif

   this.OnSize(.F.,this.width,this.height)  && Ausgangsgrî·e festlegen
   this.timer.enabled     = .T.


   *******************************************************************************
   procedure OnClose

   * Alle Public-Variablen freigeben.  Wird ÅberfÅssig, wenn sie
   * Eigenschaften werden.
   *******************************************************************************

   release formatMenuChecked,colorNormalMenuChecked,fontNameMenuChecked,;
      fontBoldMenuChecked,fontItalicMenuChecked
   close procedure program(1)


   *******************************************************************************
   procedure OnGotFocus
   *******************************************************************************



   *******************************************************************************
   procedure OnLostFocus
   *******************************************************************************



   *******************************************************************************
   procedure OnSize (nType, width, height)

   * Grî·e des Formulartextes Ñndern
   *******************************************************************************
   local timeText

   timeText = form.timeText
   timeText.width = width
   timeText.height = height
   timeText.fontSize = (height + width)/2


   *******************************************************************************
   procedure TwelveHour

   * Zeitanzeige im 1224-Std.-Format
   *******************************************************************************

   if this.timeFormat <> 12
      this.timeFormat = 12
      this.GetTime = Get12Time
   endif


   ********************************************************************************
   procedure TwentyFourHour

   * Zeitanzeige im 24-Std.-Forma
   ********************************************************************************

   if this.timeFormat <> 24
      this.timeFormat = 24
      this.GetTime = Get24Time
   endif


   ****************************************************************************
   procedure TimeProperty

   * Aktuelle MenÅoption markieren, Markierung von vorheriger Option in dieser
   * Gruppe nicht markieren. Setzt die entsprechende Eigenschft des Textelements.
   ****************************************************************************
   private propRef, propName, timeText, menuVar, proc

   propName = this.parent.value
   menuVar = propName + "MenuChecked"
   &menuVar..checked = .F.         && Die Markierung der Gruppe entfernen
   this.Checked = .T.
   &menuVar = this    && Das ist jetzt das markierte MenÅ.
   if propName <> "Format"         && Eigenschaft des Textelements Ñndern
      timeText = form.timeText
      propRef = "timeText." + propName
      &propRef = this.value
   else                            && Format des Texts Ñndern
      proc = "form." + this.procName
      &proc()
   endif


   *******************************************************************************
   procedure DefineMenu

   * MenÅ anlegen
   *******************************************************************************

   define menu MainMenu of this

   define menu Options of this.MainMenu;
      property;
         text "&Optionen"

   define menu ExitMenu of this.MainMenu.Options;
      property;
         text "B&eenden",;
         onclick {;form.Close()}
   define menu Separator1 of this.MainMenu.Options;
      property;
         separator .T.

   define menu Colors of this.MainMenu.Options ;
      property;
         text "&Farben";
      custom;
         value "ColorNormal"
   define menu CyanColor of this.MainMenu.Options.Colors;
      property;
         text "&Cyan",;
         onclick this.TimeProperty,;
         checked .T.;
      custom;
         value "bg+/n"
   define menu YellowColor of this.MainMenu.Options.Colors;
      property;
         text "&Gelb",;
         OnClick this.timeProperty;
      custom;
         value "gr+/n"
   define menu MagentaColor of this.MainMenu.Options.Colors;
      property;
         text "&Magenta",;
         OnClick this.timeProperty;
      custom;
         value "rb+/n"
   define menu RedColor of this.MainMenu.Options.Colors;
      property;
         text "&Rot",;
         onclick this.timeProperty;
      custom;
         value "r+/n"

   define menu Separator2 of this.MainMenu.Options;
      property;
         separator .T.
   define menu Formats of this.MainMenu.Options;
      property;
         text "F&ormate";
      custom;
         value "Format"
   define menu TwentyFourHrFormat of this.MainMenu.Options.Formats;
      property;
         text "24-Stunden",;
         onclick this.TimeProperty,;
         checked .T.;
      custom;
         procName "TwentyFourHour"
   define menu TwelveHrFormat of this.MainMenu.Options.Formats;
      property;
         text "12-Stunden",;
         onclick this.TimeProperty;
      custom;
         procName "TwelveHour"

   define menu Separator3 of this.MainMenu.Options;
      property;
         separator .T.
   define menu Fonts of this.MainMenu.Options;
      property;
         text "Fo&nt";
      custom;
         value "FontName"
   define menu ArialFont of this.MainMenu.Options.Fonts;
      property;
         text "&Arial",;
         onclick this.timeProperty;
      custom;
         value "Arial"
   define menu ScriptFont of this.MainMenu.Options.Fonts;
      property;
         text "&Script",;
         onclick this.timeProperty;
      custom;
         value "Script"
   define menu RomanFont of this.MainMenu.Options.Fonts;
      property;
         text "&Roman",;
         onclick this.timeProperty;
      custom;
         value "Roman"
   define menu SerifFont of this.MainMenu.Options.Fonts;
      property;
         text "S&erif",;
         onclick this.timeProperty;
      custom;
         value "Serif"
   define menu SansSerifFont of this.MainMenu.Options.Fonts;
      property;
         text "Sa&ns Serif",;
         onclick this.timeProperty,;
         checked .T.;
      custom;
         value "Sans Serif"
   define menu Bold of this.MainMenu.Options;
      property;
         text "Fe&tt";
      custom;
         value "FontBold"
   define menu BoldOff of this.MainMenu.Options.Bold;
      property;
         text "&Aus",;
         onclick this.timeProperty,;
         checked .T.;
      custom;
         value .F.
   define menu BoldOn of this.MainMenu.Options.Bold;
      property;
         text "&Ein",;
         onclick this.timeProperty;
      custom;
         value .T.
   define menu Italic of this.MainMenu.Options;
      property;
         text "&Kursiv";
      custom;
         value "FontItalic"
   define menu ItalicOff of this.MainMenu.Options.Italic;
      property;
         text "&Aus",;
         onclick this.timeProperty,;
         checked .T.;
      custom;
         value .F.
   define menu ItalicOn of this.MainMenu.Options.Italic;
      property;
         text "&Ein",;
         onclick this.timeProperty;
      custom;
         value .T.


endclass


*******************************************************************************
function Get12Time

* String der 12-Stunden-Anzeige erstellen
*******************************************************************************
local time, hours

time = time()
hours = val(time)
return ltrim(str(mod(hours-1,12)+1)) + ;
         substr(time,3) + ;
         iif(hours < 12," AM"," PM")


*******************************************************************************
function Get24Time

* String der 24-Stunden-Anzeige erstellen
*******************************************************************************

return time()       && Die Zeit wird in Visual dBASE im 24h-Format dargestellt
                    && bei create session am Anfang

