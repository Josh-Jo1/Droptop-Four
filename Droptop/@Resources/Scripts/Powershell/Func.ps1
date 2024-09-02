$DesktopPath = [Environment]::GetFolderPath("Desktop")
$Startpath = $env:APPDATA

# ---------------------------------------------------------------------------- #
#                                    Actions                                   #
# ---------------------------------------------------------------------------- #

function MakeShortcut {
    $RainmeterExe = $RmAPI.VariableStr('PROGRAMPATH')
    $ResourceFolder = $RmAPI.VariableStr('@')
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut("$Startpath\Microsoft\Windows\Start Menu\Programs\Droptop Four.lnk")
    $Shortcut.TargetPath = $RainmeterExe + "Rainmeter.exe"
    $Shortcut.Arguments = '!ActivateConfig Droptop\Other\BackgroundProcesses BackgroundProcesses.ini'
    $shortcut.IconLocation = $ResourceFolder + "Images\4Logo.ico"
    $Shortcut.Save()
}