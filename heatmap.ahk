#Persistent
SetWorkingDir %A_ScriptDir%
Menu, Tray, Icon, AHK-Mouse-Heatmap.ico

; Define variables
logFile := "ClickLog.txt"
leftClicks := 0
rightClicks := 0
middleClicks := 0

; Read existing log file to update click counts at script start
ReadLogFileAndUpdateCounters()

; Add GUI menu buttons
Menu, Tray, Add, Show GUI, ShowGui
Menu, Tray, Add, Run Heatmap, RunHeatmap
Menu, Tray, Add
Menu, Tray, Add, Exit, ExitScript

; Define GUI window with click counts and buttons
Gui, MyGui:Font, s12
Gui, MyGui:Add, Text, vLeftClicksText, Left Clicks: %leftClicks%
Gui, MyGui:Add, Text, vRightClicksText, Right Clicks: %rightClicks%
Gui, MyGui:Add, Text, vMiddleClicksText, Middle Clicks: %middleClicks%
Gui, MyGui:Add, Button, gRunHeatmap, Run Heatmap

; Show the GUI initially
Gui, MyGui:Show, , Click Tracker

; Function to update GUI with current click counts
UpdateGui:
    global leftClicks, rightClicks, middleClicks
    GuiControl, MyGui:, LeftClicksText, Left Clicks: %leftClicks%
    GuiControl, MyGui:, RightClicksText, Right Clicks: %rightClicks%
    GuiControl, MyGui:, MiddleClicksText, Middle Clicks: %middleClicks%
return

; Function to read existing log file and update click counts
ReadLogFileAndUpdateCounters() {
    global leftClicks, rightClicks, middleClicks
    global logFile

    ; If log file doesn't exist, return without doing anything
    if !FileExist(logFile)
        return

    ; Read file contents and parse into individual lines
    FileRead, logContents, %logFile%
    Loop, parse, logContents, `n, `r
    {
        line := A_LoopField
        if (line = "" || line = "date,time,click,x,y")
            continue
        ; Increment click count based on click type
        clickType := StrSplit(line, ",")[3]
        if (clickType = "Left")
            leftClicks++
        else if (clickType = "Right")
            rightClicks++
        else if (clickType = "Middle")
            middleClicks++
    }
    Gosub, UpdateGui
}

; Function to show GUI window when menu button is clicked
ShowGui:
    Gui, MyGui:Show
    Gosub, UpdateGui
return

; Functions to increment click counts and log clicks to the file
~LButton::IncrementAndLogClick("Left")
~RButton::IncrementAndLogClick("Right")
~MButton::IncrementAndLogClick("Middle")

IncrementAndLogClick(buttonType) {
    global logFile, leftClicks, rightClicks, middleClicks
    ; Get current mouse position and format current time
    MouseGetPos, posX, posY
    FormatTime, currentTime,, yyyy-MM-dd,HH:mm:ss
    ; Create log entry with timestamp, click type, and position
    logEntry := currentTime . "," . buttonType . "," . posX . "," . posY . "`n"
    ; Write log entry to file and increment click count based on click type
    FileAppend, %logEntry%, %logFile%
    if (buttonType = "Left")
        leftClicks++
    else if (buttonType = "Right")
        rightClicks++
    else if (buttonType = "Middle")
        middleClicks++  ; Ensure this line increments middleClicks
    Gosub, UpdateGui
}


; Function to run heatmap generation script when menu button is clicked
RunHeatmap:
    Run, python generate_heatmap.py
return

; Function to exit the script when menu button is clicked
ExitScript:
    ExitApp
return
