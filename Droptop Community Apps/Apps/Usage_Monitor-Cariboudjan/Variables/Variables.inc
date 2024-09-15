[Variables]
; -------------------------------------------------------------------------------
; VariablesDefault.inc should be a copy of Variables.inc, but contain all of the 'default' settings when the app is first installed.
; Any settings changed by the user should be written to Variables.inc, not VariablesDefault.inc.
; VariablesDefault.inc and Variables.inc should contain all of the user-configurable options for your app.
; -------------------------------------------------------------------------------

; -------------------------------------------------------------------------------
; Below variables are required for the app's function. Do not remove or change.
; -------------------------------------------------------------------------------

MyAppID=Usage_Monitor-Cariboudjan
MyAppName=Usage Monitor
MyAppAuthor=Cariboudjan
MyAppGUID=0bdf33b5-6b67-499b-809b-0b90a0f56dc5
MyVariablesLoc=#SKINSPATH#Droptop Community Apps\Apps\Usage_Monitor-Cariboudjan\Variables\Variables.inc

; -------------------------------------------------------------------------------
; Add your variables below: 
; -------------------------------------------------------------------------------

UsageCPUInactive=0
UsageGPUInactive=0
UsageRAMInactive=0
UsageHDDInactive=0
UsageNETInactive=0

UsageMonitor.BoxColorNum=1

UsageMonitor.UseKilobytes=0