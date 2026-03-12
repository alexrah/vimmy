' How to install (import Macro and attach to Open Document event to automatically load it):
' 1. Tools -> Macro -> Edit Macros...
' 2. (Sidebar) Object Catalog -> My Macros -> Standard -> Module1
' 3. (Toolbar) Import BASIC, select this file
' 4. Tools -> Macro -> Organize Macros -> Basic
' 5. Assign -> Events -> Save in: LibreOffice -> Open Document -> Assign: Macro -> Select the imported Basic Macro

Sub SetSheetDefaults()
    Dim oDoc As Object
    oDoc = ThisComponent

    If Not oDoc.supportsService("com.sun.star.sheet.SpreadsheetDocument") Then
        Exit Sub
    End If

    Dim oSheet As Object
    Dim oStyles As Object
    Dim oDefaultStyle As Object
    Dim oController As Object
    Dim oBorderLine As New com.sun.star.table.BorderLine2
    Dim oCursor As Object
    Dim i As Integer

    ' Set zoom to 100%
    oController = oDoc.getCurrentController()
    oController.ZoomType = 0
    oController.ZoomValue = 100

    ' Border line definition: Light Gray 3
    oBorderLine.LineStyle = com.sun.star.table.BorderLineStyle.SOLID
    oBorderLine.LineWidth = 26
    oBorderLine.Color = RGB(192, 192, 192)

    ' Apply to ALL sheets in the document
    For i = 0 To oDoc.Sheets.Count - 1
        oSheet = oDoc.Sheets.getByIndex(i)
        oSheet.Rows.OptimalHeight = False
        oSheet.Rows.Height = PtTo100mm(20)

        ' Apply font size directly to all used cells
        oCursor = oSheet.createCursor()
        oCursor.gotoStartOfUsedArea(False)
        oCursor.gotoEndOfUsedArea(True)
        oCursor.CharHeight = 10.5
		oCursor.TopBorder    = oBorderLine
        oCursor.BottomBorder = oBorderLine
        oCursor.LeftBorder   = oBorderLine
        oCursor.RightBorder  = oBorderLine
    Next i

    ' Font + padding + border via Default Cell Style
    oStyles = oDoc.StyleFamilies.getByName("CellStyles")
    oDefaultStyle = oStyles.getByName("Default")

    oDefaultStyle.CharHeight = 10.5

    oDefaultStyle.ParaLeftMargin       = PtTo100mm(5)
    oDefaultStyle.ParaRightMargin      = PtTo100mm(5)
	oDefaultStyle.ParaTopMargin    = PtTo100mm(5)
    oDefaultStyle.ParaBottomMargin = PtTo100mm(5)

    oDefaultStyle.TopBorder    = oBorderLine
    oDefaultStyle.BottomBorder = oBorderLine
    oDefaultStyle.LeftBorder   = oBorderLine
    oDefaultStyle.RightBorder  = oBorderLine
    
	MsgBox "Defaults applied! v1.2"

End Sub

Function PtTo100mm(pt As Double) As Long
    PtTo100mm = CLng(pt * 35.2778)
End Function
