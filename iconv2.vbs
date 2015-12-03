Option Explicit

Private Const adReadAll = -1
Private Const adSaveCreateOverWrite = 2
Private Const adTypeBinary = 1
Private Const adTypeText = 2
Private Const adWriteChar = 0

Private Sub UTF8toANSI(ByVal UTF8FName, ByVal ANSIFName)
    Dim strText

    With CreateObject("ADODB.Stream")
        .Open
        .Type = adTypeBinary
        .LoadFromFile UTF8FName
        .Type = adTypeText
        .Charset = "utf-8"
        strText = .ReadText(adReadAll)
        .Position = 0
        .SetEOS
        .Charset = "_autodetect" 'Use current ANSI codepage.
        .WriteText strText, adWriteChar
        .SaveToFile ANSIFName, adSaveCreateOverWrite
        .Close
    End With
End Sub

UTF8toANSI "server1\\menu.bat", "server1\\menu2.bat"
'UTF8toANSI "UTF8-noBOM.txt", "ANSI2.txt"
MsgBox "Complete!", vbOKOnly, WScript.ScriptName