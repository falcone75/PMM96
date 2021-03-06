*******************************************************************************
*  DATEI:        Password.cc
*
*  AUTOREN:      Borland Beispielgruppe
*
*  DATUM:        10.94
*
*  AKTUALISIERT: 6.95
*
*  REVISION:     $Revision:   1.3  $
*
*  VERSION:      Visual dBASE
*
*  BESCHREIBUNG: Diese Datei enth�lt ein Element PasswordEntry
*                zur Eingabe eines Pa�wortes.
*
*  PARAMETER:    Keine
*
*  AUFRUFE:      Keine
*
*  SYNTAX: W�hlen Sie beim Erstellen eines Formulars "Benutzerdefinierte
*          Steuerelemente" aus dem Men� "Datei". Danach w�hlen Sie den
*          Schalter "Hinzuf�gen" auf der Seite "Steuerelemente" des Dialogs
*          "Benutzerdefinierte Steuerelemente". W�hlen Sie diese Datei aus
*          der Dateiauswahlliste. Die Elemente dieser Datei stehen nun auf
*          der Seite "Individuell" des Objektfensters zur Verf�gung.
*
*          Sie m�ssen die Eigenschaft CorrectPassword f�r das richtige 
*          Pa�wort im Formular-Designer oder in Ihrem Code zuweisen.
*
********************************************************************************
#include <Messdlg.h>

#define BACKSPACE_KEY     8     && -- ASCII-Wert der R�cktaste
#define DELETE_KEY        127   && -- ASCII-Wert der Taste Entf
#define PASSWORD_CHAR     "*"   && -- Das Zeichen, das f�r jedes eingegebene
                                &&    Zeichen des Pa�worts angezeigt wird


*******************************************************************************
*******************************************************************************
class PasswordEntry(f,n) of Entryfield(f,n) custom

*  ELEMENT:      Pa�worteingabefeld
*
*  BESCHREIBUNG: Dieses Element erlaubt die Eingabe eines Pa�wortes
*                und besitzt Eigenschaften, die von anderen Elementen  
*                benutzt werden k�nnen,um das Pa�wort auf Richtigkeit 
*                zu �berpr�fen.
*******************************************************************************

   this.Border = .T.
   this.Left = 5
   this.PageNo = 1
   this.Value = ""

   this.MaxLength = 15
   this.Top = 3.0
   this.Height = 1
   this.Width = 15
   this.Key = CLASS::KEY


   ****************************************************************************
   Procedure OnOpen(nChar, nPosition)
   ****************************************************************************

   *** Selbstdefinierte Eigenschaften
   if type("this.enteredPassword") = "U"
      this.enteredPassword = ""
      this.correctPassword = "" && Diese Eigenschaft mu� manuell zugewiesen
                                && werden, wenn das Element installiert wird.
   endif

   *** Gesch�tzte Eigenschaften
 *  protect enteredPassword,correctPassword


   ****************************************************************************
   Procedure SetCorrectPassword(password)

   * Werte werden this.correctPassword zugeordnet
   ****************************************************************************
   private passwordLen

   passwordLen = len(password)
   this.width = passwordLen
   this.maxLength = passwordLen
   this.correctPassword = password
   this.enteredPassword = ""


   ****************************************************************************
   Function IsEnteredPasswordOk
   ****************************************************************************

   return (this.enteredPassword == this.correctPassword)


   ****************************************************************************
   Procedure Key(nChar, nPosition)

   * Behandelt Tasten im Pa�worteingabefeld
   ****************************************************************************
   private enteredChar, returnValue

   enteredChar = chr(nChar)
   returnValue = .T.                 && Ausgabezeichen bei Tastendruck
   do case                           && �berpr�fung auf Tasten, die den 
      case nChar = BACKSPACE_KEY     && Wert modifizieren
         this.enteredPassword = ;
            stuff(this.enteredPassword, nPosition - 1, 1, "")
      case nChar = DELETE_KEY
         this.enteredPassword = ;
            stuff(this.enteredPassword, nPosition, 1, "")
      otherwise
         if CLASS::IsValidChar(enteredChar)     && Alphanumerische Eingabe
            this.enteredPassword = ;
               stuff(this.enteredPassword, nPosition, 1, enteredChar)
            returnValue = asc(PASSWORD_CHAR)    && Tarnzeichen ausgeben
         endif
   endcase

   return returnValue


   ****************************************************************************
   Procedure IsValidChar(char)

   * Sicherstellen, da� die Taste alphanumerisch ist
   ****************************************************************************
   private returnValue

   do case
      case isalpha(char)                        && Buchstabe?
         returnValue = .T.
      case char >= "0" .and. char <= "9"        && Ziffer?
         returnValue = .T.
      otherwise                                 && Ung�ltig?
         returnValue = .F.
   endcase

   return returnValue

endclass


