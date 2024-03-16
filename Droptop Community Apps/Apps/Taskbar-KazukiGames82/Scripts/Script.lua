function Initialize()
	TaskbarMaxProcess = 15
end

init = true
processTable = {'empty'}

-- ----------------------------------------------------------------
-- UPDATE FUNCTIONS
-- ----------------------------------------------------------------

function Update()
	NeedsUpdate = SKIN:GetVariable('NeedsUpdate')
	WindowSwitcher = SKIN:GetVariable('WindowSwitcher')

	if NeedsUpdate == '1' then
		UpdateApps()
		SKIN:Bang('[!SetVariable NeedsUpdate 0]')
	else
		if WindowSwitcher == '1' then
			UpdateSwitcher()
			SKIN:Bang('[!SetVariable WindowSwitcher 0]')
		end
	end
end

-- Function to update all apps when new process has been detected
function UpdateApps()
	SKIN:Bang('["#SKINSPATH#\\Droptop Community Apps\\Apps\\Taskbar-KazukiGames82\\Addons\\getIcons.exe"]')
	processCount = tonumber(SKIN:GetVariable('ProcessCount'))
	ProgramOptions()
	SetIcons()
	SKIN:Bang('!UpdateMeasure', 'Taskbar-KazukiGames82_ProgramOptions', 'Droptop\\DropdownBar')
	SKIN:Bang('!UpdateMeterGroup', 'Taskbar-KazukiGames82', 'Droptop\\DropdownBar')
	SKIN:Bang('!UpdateMeterGroup', 'CustomApp#Taskbar-KazukiGames82#Sys', 'Droptop\\DropdownBar')
	SKIN:Bang('!UpdateMeterGroup', 'SysTray', 'Droptop\\DropdownBar')
	SKIN:Bang('!UpdateMeterGroup', 'HL', 'Droptop\\DropdownBar')
	SKIN:Bang('!UpdateMeterGroup', 'NotificationBar', 'Droptop\\DropdownBar')
	SKIN:Bang('!UpdateMeterGroup', 'TopBar', 'Droptop\\DropdownBar')
	SKIN:Bang('!Redraw', 'Droptop\\DropdownBar')
end

-- Function to update when app was changed
function UpdateSwitcher()
	RedrawApps()
	SKIN:Bang('!Redraw', 'Droptop\\DropdownBar')
end

-- ----------------------------------------------------------------
-- FUNCTIONS
-- ----------------------------------------------------------------

function ProgramOptions()
	if init then 
		init = false
		for i = 0, processCount-1 do
			processTable[i+1] = {['name'] = SKIN:GetVariable('programname'..i), ['index'] = i}
		end
	else 
		for i = 0, processCount-1 do
			local name = SKIN:GetVariable('programname'..i)
			for j = 1,#processTable do
				if (name == processTable[j]['name']) then
					processTable[j]['index'] = i
					new = false
					break
				else
					new = true
				end
			end
			if new then 
				processTable[#processTable+1] = {['name'] = name, ['index'] = i} 
			end
		end

		for i = 1,#processTable do
			for j = 0, processCount-1 do
				local name = SKIN:GetVariable('programname'..j)
				if (name == processTable[i]['name']) then
					nomore = false
					break
				else
					nomore = true
				end
			end
			if nomore then 
				table.remove(processTable,i)
				break 
			end
		end
	end
	if processCount == 0 then 
		SKIN:Bang('!HideMeterGroup', 'Taskbar-KazukiGames82-Icons', 'Droptop\\DropdownBar')
		SKIN:Bang('!ShowMeter', 'Taskbar-KazukiGames82', 'Droptop\\DropdownBar')
		SKIN:Bang('Redraw', 'Droptop\\DropdownBar')
		init=true
		return
	else
		SKIN:Bang('!HideMeter', 'Taskbar-KazukiGames82', 'Droptop\\DropdownBar')
	end
end

function SetIcons()
	for i=0, TaskbarMaxProcess-1 do
		if processTable[i+1] then 
			local ProgramName = processTable[i+1]['name']
			local ProgramIndex = processTable[i+1]['index']
			local ActiveWindow = SKIN:GetVariable('ActiveWindowProcess'):lower()
			local metaTable = {TaskbarKazukiGames82Icon = {}}
			
			metaTable.TaskbarKazukiGames82Icon['ImageName'] = '#SKINSPATH#Droptop Community Apps\\Apps\\Taskbar-KazukiGames82\\Addons\\Icons\\'..ProgramName..'.png'

			metaTable.TaskbarKazukiGames82Icon['LeftMouseDownAction'] = concat {
				'[!CommandMeasure Taskbar-KazukiGames82_ProgramOptions ToFront|Main|',ProgramIndex, ']'
			}
			
			for mK,mV in pairs(metaTable) do
				for k,v in pairs(mV) do
					SKIN:Bang('!SetOption', mK..i, k, v, 'Droptop\\DropdownBar')
				end
			end
			
			ChangeIconData(i, ActiveWindow == ProgramName:lower())

			SKIN:Bang('!ShowMeterGroup', 'TaskbarKazukiGames82Icon'..i, 'Droptop\\DropdownBar')
			SKIN:Bang('!UpdateMeterGroup', 'TaskbarKazukiGames82Icon'..i, 'Droptop\\DropdownBar')
		else
			SKIN:Bang('!HideMeterGroup', 'TaskbarKazukiGames82Icon'..i, 'Droptop\\DropdownBar')
		end
	end
end

function RedrawApps()
	for i=0, TaskbarMaxProcess-1 do
		if processTable[i+1] then
			local ProgramName = processTable[i+1]['name']
			local ProgramIndex = processTable[i+1]['index']
			local ActiveWindow = SKIN:GetVariable('ActiveWindowProcess'):lower()
			ChangeIconData(i, ActiveWindow == ProgramName:lower())
			SKIN:Bang('!UpdateMeterGroup', 'TaskbarKazukiGames82Icon'..i, 'Droptop\\DropdownBar')
		end
	end
end

-- ----------------------------------------------------------------
-- EXTRA FUNCTIONS
-- ----------------------------------------------------------------

function ChangeIconData(CurrentDrawingIndex,CurrentActiveWindow)
	if CurrentActiveWindow then 
		IconColor = '255,255,255,255'
	else
		IconColor = '255,255,255,(255/3)'
	end	
	SKIN:Bang('!SetOption', 'TaskbarKazukiGames82Icon'..CurrentDrawingIndex, 'ImageTint', IconColor, 'Droptop\\DropdownBar')
end

function concat(t)
	return table.concat(t, "")
end
