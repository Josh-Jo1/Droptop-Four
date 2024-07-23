$DesktopPath = [Environment]::GetFolderPath("Desktop")
$Startpath = $env:APPDATA

# ---------------------------------------------------------------------------- #
#                                    Actions                                   #
# ---------------------------------------------------------------------------- #

function Desktop {
    $RainmeterExe = $RmAPI.VariableStr('PROGRAMPATH')
    $ResourceFolder = $RmAPI.VariableStr('@')
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($DesktopPath + "\JaxCore.lnk")
    $Shortcut.TargetPath = $RainmeterExe + "Rainmeter.exe"
    $Shortcut.Arguments = '!ActivateConfig #JaxCore\Main Home.ini'
    $shortcut.IconLocation = $ResourceFolder + "Images\4Logo.ico"
    $Shortcut.Save()
}

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

function WallpaperChanger {
    $time = Get-Date -Format HHmm
	$i = 1
	cd "C:\users\carib\documents\rainmeter\skins\Droptop Community Apps\Apps\Wallpaper_Changer-Cariboudjan\Wallpapers\Day"
	get-childitem | %{ Rename-Item -LiteralPath $_.FullName -NewName ("{0:D1}.$time.png" -f $i++) }
	# get-childitem | %{ Rename-Item -LiteralPath $_.FullName -NewName ("{0:D1}.png" -f $i++) }
	$i = 1
	cd "C:\users\carib\documents\rainmeter\skins\Droptop Community Apps\Apps\Wallpaper_Changer-Cariboudjan\Wallpapers\Night"
	get-childitem | %{ Rename-Item -LiteralPath $_.FullName -NewName ("{0:D1}.$time.png" -f $i++) }
	# get-childitem | %{ Rename-Item -LiteralPath $_.FullName -NewName ("{0:D1}.png" -f $i++) }
}