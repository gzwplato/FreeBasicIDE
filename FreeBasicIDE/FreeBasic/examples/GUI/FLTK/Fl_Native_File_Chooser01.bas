#include once "fltk-c.bi"
' test of class Fl_Native_File_Chooser
' single file selection
var nfc = Fl_Native_File_ChooserNew(NFC_BROWSE_FILE)
Fl_Native_File_ChooserSetTitle      nfc,"Load a FreeBASIC file ..."
Fl_Native_File_ChooserSetFilter     nfc,"*.{bas,bi}"
Fl_Native_File_ChooserSetDirectory  nfc,ExePath()
Fl_Native_File_ChooserSetPresetFile nfc,"Fl_Native_File_Chooser01.bas"


if Fl_Native_File_ChooserShow(nfc)=0 then
  print "selected: " & *Fl_Native_File_ChooserFilename(nfc)
end if

Fl_Native_File_ChooserDelete nfc
print "..."
sleep
