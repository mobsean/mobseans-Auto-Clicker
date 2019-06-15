#include<Array.au3>
#include <Misc.au3>
#AutoIt3Wrapper_icon=@ScriptDir&\ico.ico
_Singleton ( "mobseans_autoclicker" )

TraySetIcon("ico.ico")
TraySetToolTip("mobseans Auto Clicker")

Global $pause = 0
Global $aMousePos[0]

HotKeySet ( "{F1}", "pause")
Func pause()
   ConsoleWrite("Pause...")
   Global $pause
   $pause = ($pause) ? False : True
EndFunc

HotKeySet ( "{F2}", "getPos")
Func getPos()
   Global $aMousePos
   $aPos = MouseGetPos()
   _ArrayAdd($aMousePos, $aPos)
   ConsoleWrite("getPos: x:" &$aPos[0]&" - y:"&$aPos[1] & @CRLF)
   Global $pause
   $pause = ($pause) ? False : True
EndFunc


HotKeySet ( "{F6}" , "stop" )
Func stop()
   Exit
EndFunc


Local $start = InputBox ( "mobseans Auto Clicker", "Hallo und willkommen!" & @CRLF & "Pause jederzeit mit F1." & @CRLF & "Stop mit F6." & @CRLF & "Zeit zwischen den Mausklicks angeben [ms]: " , "1000")
If $start = 0 Then Exit

Local $modus = MsgBox ( "3+512", "mobseans Auto Clicker", "Modus wählen:" & @CRLF & "JA = Nur eine Position für Clicks " & @CRLF & "Nein = mehrere Positionen für Clicks. " & @CRLF & "Aufzeichnung GLEICH mit F2" )
If $modus = 2 Then Exit

If $modus = 7 Then
   _ArrayDisplay($aMousePos, "JETZT MIT F2 die Maus Positionen nacheinander speichern...")
EndIf

If($start > 0 ) Then
   main($start, $modus)
EndIf


Func main($start, $modus)
   While 1<2
	  ConsoleWrite("Pause:"&$pause & " - Modus: " & $modus & "MousePos:" & UBound($aMousePos) )
	  If $modus = 6 Then
		 $aMousePos = MouseGetPos()
	  EndIf
	  While Not $pause
		 ConsoleWrite($pause)
		 For $i = 0 to UBound($aMousePos)-2 Step 2
			ConsoleWrite(@CRLF & $i)
			ConsoleWrite(@CRLF & $aMousePos[$i] &" - "& $aMousePos[$i+1])
			MouseClick("left", $aMousePos[$i], $aMousePos[$i+1], 1, 2)
			sleep($start)
		 Next
	  WEnd
	  sleep($start)
   WEnd
EndFunc
