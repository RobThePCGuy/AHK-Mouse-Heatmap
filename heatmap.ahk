#Persistent
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

appName := "AHK Mouse Heatmap"
appDir := A_ScriptDir
iconFile := appDir . "\AHK-Mouse-Heatmap.ico"
logFile := appDir . "\ClickLog.txt"
heatmapFile := appDir . "\heatmap.png"
errorFile := appDir . "\heatmap_error.txt"
heatmapExe := appDir . "\generate_heatmap.exe"
heatmapScript := appDir . "\generate_heatmap.py"

if FileExist(iconFile)
    Menu, Tray, Icon, %iconFile%

leftClicks := 0
rightClicks := 0
middleClicks := 0

; Create a CSV header on first run so the heatmap generator can parse the log reliably.
if !FileExist(logFile)
    FileAppend, date,time,click,x,y`n, %logFile%

; Read existing log file to update click counts at script start.
ReadLogFileAndUpdateCounters()

; Add tray menu buttons.
Menu, Tray, Tip, %appName%
Menu, Tray, Add, Show, ShowGui
Menu, Tray, Add, Generate Heatmap, RunHeatmap
Menu, Tray, Add
Menu, Tray, Add, Exit, ExitScript

; Define GUI window with click counts and buttons.
Gui, MyGui:New, , %appName%
Gui, MyGui:Font, s10
Gui, MyGui:Add, Text, w260, Local click tracker and heatmap generator
Gui, MyGui:Add, Text, vLeftClicksText w260, Left clicks: %leftClicks%
Gui, MyGui:Add, Text, vRightClicksText w260, Right clicks: %rightClicks%
Gui, MyGui:Add, Text, vMiddleClicksText w260, Middle clicks: %middleClicks%
Gui, MyGui:Add, Button, gRunHeatmap w140, Generate Heatmap
Gui, MyGui:Add, Text, vStatusText w360, Ready.

; Show the GUI initially.
Gui, MyGui:Show, , %appName%
return

; Function to update GUI with current click counts.
UpdateGui:
    global leftClicks, rightClicks, middleClicks
    GuiControl, MyGui:, LeftClicksText, Left clicks: %leftClicks%
    GuiControl, MyGui:, RightClicksText, Right clicks: %rightClicks%
    GuiControl, MyGui:, MiddleClicksText, Middle clicks: %middleClicks%
return

; Function to read existing log file and update click counts.
ReadLogFileAndUpdateCounters() {
    global leftClicks, rightClicks, middleClicks, logFile

    if !FileExist(logFile)
        return

    FileRead, logContents, %logFile%
    Loop, parse, logContents, `n, `r
    {
        line := A_LoopField
        if (line = "" || line = "date,time,click,x,y")
            continue

        fields := StrSplit(line, ",")
        if (fields.Length() < 5)
            continue

        clickType := fields[3]
        if (clickType = "Left")
            leftClicks++
        else if (clickType = "Right")
            rightClicks++
        else if (clickType = "Middle")
            middleClicks++
    }
    Gosub, UpdateGui
}

; Function to show GUI window when menu button is clicked.
ShowGui:
    global appName
    Gui, MyGui:Show, , %appName%
    Gosub, UpdateGui
return

; Functions to increment click counts and log clicks to the file.
~LButton::IncrementAndLogClick("Left")
~RButton::IncrementAndLogClick("Right")
~MButton::IncrementAndLogClick("Middle")

IncrementAndLogClick(buttonType) {
    global logFile, leftClicks, rightClicks, middleClicks

    MouseGetPos, posX, posY
    FormatTime, currentDate,, yyyy-MM-dd
    FormatTime, currentTime,, HH:mm:ss
    logEntry := currentDate . "," . currentTime . "," . buttonType . "," . posX . "," . posY . "`n"

    FileAppend, %logEntry%, %logFile%
    if (buttonType = "Left")
        leftClicks++
    else if (buttonType = "Right")
        rightClicks++
    else if (buttonType = "Middle")
        middleClicks++

    Gosub, UpdateGui
}

; Function to run heatmap generation script when menu button is clicked.
RunHeatmap:
    global appDir, heatmapExe, heatmapScript, heatmapFile, errorFile, logFile

    if !FileExist(logFile) {
        MsgBox, 48, AHK Mouse Heatmap, No clicks have been logged yet. Click a few times, then generate the heatmap again.
        return
    }

    if FileExist(heatmapFile)
        FileDelete, %heatmapFile%
    if FileExist(errorFile)
        FileDelete, %errorFile%

    GuiControl, MyGui:, StatusText, Generating heatmap...

    if FileExist(heatmapExe) {
        RunWait, "%heatmapExe%", %appDir%
        generatorExitCode := ErrorLevel
    } else if FileExist(heatmapScript) {
        RunWait, python "%heatmapScript%", %appDir%
        generatorExitCode := ErrorLevel
    } else {
        GuiControl, MyGui:, StatusText, Generator missing.
        MsgBox, 16, AHK Mouse Heatmap, Could not find the heatmap generator.
        return
    }

    if (generatorExitCode = "ERROR") {
        GuiControl, MyGui:, StatusText, Could not launch generator.
        MsgBox, 48, AHK Mouse Heatmap, Failed to launch the heatmap generator. If running from source, make sure Python is installed and available in PATH.
    } else if FileExist(heatmapFile) {
        GuiControl, MyGui:, StatusText, Heatmap generated.
        MsgBox, 64, AHK Mouse Heatmap, Heatmap generated successfully.
    } else if FileExist(errorFile) {
        FileRead, generatorError, %errorFile%
        GuiControl, MyGui:, StatusText, Heatmap generation failed.
        MsgBox, 48, AHK Mouse Heatmap, %generatorError%
    } else if (generatorExitCode != 0) {
        GuiControl, MyGui:, StatusText, Heatmap generation failed.
        MsgBox, 48, AHK Mouse Heatmap, The heatmap generator failed with exit code %generatorExitCode%.
    } else {
        GuiControl, MyGui:, StatusText, Heatmap not created.
        MsgBox, 48, AHK Mouse Heatmap, The heatmap generator finished, but no heatmap was created.
    }
return

; Function to exit the script when menu button is clicked.
ExitScript:
    ExitApp
return

MyGuiGuiClose:
    Gui, MyGui:Hide
return
