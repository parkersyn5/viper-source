local ChamsVisuals = loadstring(game:HttpGet('https://raw.githubusercontent.com/parkersyn5/viper-main/main/Library/handlers/visuals/Chams.lua'))()
local CharacterVisuals = loadstring(game:HttpGet('https://raw.githubusercontent.com/parkersyn5/viper-main/main/Library/handlers/visuals/DrawingEsp.lua'))()
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/parkersyn5/viper-main/main/Library/Main.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/parkersyn5/viper-main/main/Library/addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/parkersyn5/viper-main/main/Library/addons/SaveManager.lua'))()
local LocalPlayerVisuals = loadstring(game:HttpGet('https://raw.githubusercontent.com/parkersyn5/viper-main/main/Library/handlers/visuals/Character.lua'))()
ChamsVisuals:ToggleChams()
getgenv().ChamsEnabled = false

------------------------------------------------

-- WINDOW START

local Window = Library:CreateWindow({
    Title = 'viper-main',
    Center = true, 
    AutoShow = true,
})

-- WINDOW END

------------------------------------------------

-- TABS START

local Tabs = {
    Visuals = Window:AddTab('Visuals'),
    
    Characters = Window:AddTab('Character'),
    
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- TABS END 

------------------------------------------------

-- VISUALS START

local VisualsGroupBox = Tabs.Visuals:AddLeftGroupbox('Esp')

local ChamsGroupBox = Tabs.Visuals:AddRightGroupbox('Chams')

local ColorsGroupBox = Tabs.Visuals:AddLeftGroupbox('Colors')

local ExtrasGroupBox = Tabs.Visuals:AddLeftGroupbox('Extras')

--

VisualsGroupBox:AddToggle('BoxToggle', {
    Text = 'Boxes',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles Boxes.', -- Information shown when you hover over the toggle
})

Toggles.BoxToggle:OnChanged(function()
    viperespsettings.Box = Toggles.BoxToggle.Value
end)

--

VisualsGroupBox:AddToggle('NameToggle', {
    Text = 'Names',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles Names.', -- Information shown when you hover over the toggle
})

Toggles.NameToggle:OnChanged(function()
    viperespsettings.Name = Toggles.NameToggle.Value
end)

--

VisualsGroupBox:AddToggle('TracerToggle', {
    Text = 'Tracers',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles Tracers.', -- Information shown when you hover over the toggle
})

Toggles.TracerToggle:OnChanged(function()
    viperespsettings.Tracers = Toggles.TracerToggle.Value
end)

--

VisualsGroupBox:AddDropdown('EspFont', {
    Values = { 'UI [must rest after save]', 'System [must rest after save]', 'Plex [must rest after save]', 'Monospace [must rest after save]' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Esp Font',
    Tooltip = 'Esp Font', -- Information shown when you hover over the textbox
})

Options.EspFont:OnChanged(function()
    if Options.EspFont.Value == 'UI' then
        viperespsettings.Name.Font = 0
    elseif Options.EspFont.Value == 'System' then
        viperespsettings.Name.Font = 1
    elseif Options.EspFont.Value == 'Plex' then
        viperespsettings.Name.Font = 2
    elseif Options.EspFont.Value == 'Monospace' then
        viperespsettings.Name.Font = 3
    end
end)

--

------------------------------------------------

-- CHAMS START

--

ChamsGroupBox:AddToggle('ChamsToggle', {
    Text = 'Enabled',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles Chams.', -- Information shown when you hover over the toggle
})

Toggles.ChamsToggle:OnChanged(function()
    getgenv().ChamsEnabled = Toggles.ChamsToggle.Value
end)

--

ChamsGroupBox:AddToggle('WallChamsToggle', {
    Text = 'Top priority [Through Walls]',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles Wall Chams.', -- Information shown when you hover over the toggle
})

Toggles.WallChamsToggle:OnChanged(function()
    if Toggles.WallChamsToggle.Value == true then
        getgenv().ChamsDepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    end
        if Toggles.WallChamsToggle.Value == false then
        getgenv().ChamsDepthMode = Enum.HighlightDepthMode.Occluded
    end
end)

--


ChamsGroupBox:AddToggle('TeamToggle', {
    Text = 'Team Colors',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles Team Cham Colors.', -- Information shown when you hover over the toggle
})

Toggles.TeamToggle:OnChanged(function()
    getgenv().ChamsTeamColors = Toggles.TeamToggle.Value
end)

--

ChamsGroupBox:AddSlider('FillTransparencySlider', {
    Text = 'Fill Transparency Slider',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = false,
})

local Number = Options.FillTransparencySlider.Value

Options.FillTransparencySlider:OnChanged(function()
    getgenv().ChamsFillTransparency = Options.FillTransparencySlider.Value
end)

--

ChamsGroupBox:AddSlider('OutlineTransparencySlider', {
    Text = 'Outline Transparency Slider',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = false,
})

local Number = Options.OutlineTransparencySlider.Value

Options.OutlineTransparencySlider:OnChanged(function()
    getgenv().ChamsOutlineTransparency = Options.OutlineTransparencySlider.Value
end)

--

-- CHAMS END

-------------------------------------------------

-- COLORS START

ColorsGroupBox:AddLabel('Chams Fill Color'):AddColorPicker('ChamsFillColor', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'Spice up your esp!', -- Optional. Allows you to have a custom color picker title (when you open it)
})

Options.ChamsFillColor:OnChanged(function()
    getgenv().ChamsFillColor = Options.ChamsFillColor.Value
end)

--

ColorsGroupBox:AddLabel('Chams Outline Color'):AddColorPicker('ChamsOutlineColor', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'Spice up your esp!', -- Optional. Allows you to have a custom color picker title (when you open it)
})

Options.ChamsOutlineColor:OnChanged(function()
    getgenv().ChamsOutlineColor = Options.ChamsOutlineColor.Value
end)

------------------------------------------------

-- PULSE FUNCTION START

local function outlinefilltransparency(valuething)
    getgenv().ChamsFillTransparency = tonumber(valuething)
    getgenv().ChamsOutlineTransparency = tonumber(valuething)
end

-- PULSE FUNCTION END

------------------------------------------------

-- RAINBOW TOGGLES START

ColorsGroupBox:AddDivider()

ColorsGroupBox:AddToggle('RainbowOutlineColor', {
    Text = 'Rainbow Chams Outline',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles Rainbow Outline Chams.', -- Information shown when you hover over the toggle
})

Toggles.RainbowOutlineColor:OnChanged(function()
    if Toggles.RainbowOutlineColor.Value == true then
        _G.outlinerainbowval = true
            spawn(function()
                while _G.outlinerainbowval == true do
                    for i = 0,1,0.001*1 do
                        Options.ChamsOutlineColor:SetValueRGB(Color3.fromHSV(i,1,1))
                    	getgenv().ChamsOutlineColor = (Color3.fromHSV(i,1,1))
                    	wait()
                    	if _G.outlinerainbowval == false then
            	            break
            	        end
                    end
                end
            end)
        end
    if Toggles.RainbowOutlineColor.Value == false then
        _G.outlinerainbowval = false
    end
end)

--

ColorsGroupBox:AddToggle('RainbowFillColor', {
    Text = 'Rainbow Chams Fill',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles Rainbow Fill Chams.', -- Information shown when you hover over the toggle
})

Toggles.RainbowFillColor:OnChanged(function()
    if Toggles.RainbowFillColor.Value == true then
        _G.fillrainbowval = true
        spawn(function()
            while _G.fillrainbowval == true do
                for i = 0,1,0.001*1 do
                    Options.ChamsFillColor:SetValueRGB(Color3.fromHSV(i,1,1))
                	getgenv().ChamsFillColor = (Color3.fromHSV(i,1,1))
                	wait()
                	if _G.fillrainbowval == false then
        	            break
        	        end
                end
            end
        end)
    end
    if Toggles.RainbowFillColor.Value == false then
        _G.fillrainbowval = false
    end
end)

--

ColorsGroupBox:AddToggle('SyncRainbowColors', {
    Text = 'Sync [Disable others first]',
    Default = true, -- Default value (true / false)
    Tooltip = 'Toggles Rainbow Fill Chams BUT SYNCS.', -- Information shown when you hover over the toggle
})

Toggles.SyncRainbowColors:OnChanged(function()
    if Toggles.SyncRainbowColors.Value == true then
        _G.syncrainbowval = true
        spawn(function()
            while _G.syncrainbowval == true do
                for i = 0,1,0.001*1 do
                    Options.ChamsOutlineColor:SetValueRGB(Color3.fromHSV(i,1,1))
                    Options.ChamsFillColor:SetValueRGB(Color3.fromHSV(i,1,1))
                	getgenv().ChamsFillColor = (Color3.fromHSV(i,1,1))
                	getgenv().ChamsOutlineColor = (Color3.fromHSV(i,1,1))
                	wait()
                	if _G.syncrainbowval == false then
        	            break
        	        end
                end
            end
        end)
    end
    if Toggles.SyncRainbowColors.Value == false then
        _G.syncrainbowval = false
    end
end)

-- RAINBOW TOGGLES END

-- COLORS END

------------------------------------------------

-- EXTRA CHAMS FEATURES

-- variables

_G.pulsewait = 1.5

-- variables end

ExtrasGroupBox:AddToggle('PulsingChams', {
    Text = 'Pulsing Chams',
    Default = true, -- Default value (true / false)
    Tooltip = 'The chams pulse.', -- Information shown when you hover over the toggle
})

Toggles.PulsingChams:OnChanged(function()
    if Toggles.PulsingChams.Value == true then
        _G.pulsingcham = true
            spawn(function()
                while _G.pulsingcham == true do
                    outlinefilltransparency(0)
                    wait(_G.pulsewait)
                    outlinefilltransparency(0.1)
                    wait(0.01)
                    outlinefilltransparency(0.2)
                    wait(0.01)
                    outlinefilltransparency(0.3)
                    wait(0.01)
                    outlinefilltransparency(0.4)
                    wait(0.01)
                    outlinefilltransparency(0.5)
                    wait(0.01)
                    outlinefilltransparency(0.6)
                    wait(0.01)
                    outlinefilltransparency(0.7)
                    wait(0.01)
                    outlinefilltransparency(0.8)
                    wait(0.01)
                    outlinefilltransparency(0.9)
                    wait(0.01)
                    outlinefilltransparency(1)
                    wait(0.01)
                    outlinefilltransparency(0.9)
                    wait(0.01)
                    outlinefilltransparency(0.8)
                    wait(0.01)
                    outlinefilltransparency(0.7)
                    wait(0.01)
                    outlinefilltransparency(0.6)
                    wait(0.01)
                    outlinefilltransparency(0.5)
                    wait(0.01)
                    outlinefilltransparency(0.4)
                    wait(0.01)
                    outlinefilltransparency(0.3)
                    wait(0.01)
                    outlinefilltransparency(0.2)
                    wait(0.01)
                    outlinefilltransparency(0.1)
                    if _G.pulsingcham == false then
                        break
                    end
                end
            end)
        end
    if Toggles.PulsingChams.Value == false then
        _G.pulsingcham = false
    end
end)

--

ExtrasGroupBox:AddSlider('Pulsewait', {
    Text = 'Pulse Wait',
    Default = 1.5,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = false,
})

local Number = Options.Pulsewait.Value

Options.Pulsewait:OnChanged(function()
    _G.pulsewait = Options.Pulsewait.Value
end)

-- EXTRA CHAMS FEATURES END

------------------------------------------------

-- CHARACTER START

local LVisualsGroupBox = Tabs.Characters:AddLeftGroupbox('Local Visuals')

LVisualsGroupBox:AddToggle('Breadcrumbs', {
    Text = 'Breadcrumbs',
    Default = false, -- Default value (true / false)
    Tooltip = 'Toggles a trail.', -- Information shown when you hover over the toggle
})

Toggles.Breadcrumbs:OnChanged(function()
    if Toggles.Breadcrumbs.Value == false then
        LocalPlayerVisuals:MovementTrail()
    end
    if Toggles.Breadcrumbs.Value == false then
        LocalPlayerVisuals:DisableMovementTrail()
    end
end)

--

LVisualsGroupBox:AddSlider('TraillifetimeVAR', {
    Text = 'Fill Transparency Slider',
    Default = 3,
    Min = 0,
    Max = 15,
    Rounding = 1,
    Compact = false,
})

local Number = Options.TraillifetimeVAR.Value

Options.TraillifetimeVAR:OnChanged(function()
    _G.traillifetime = Options.TraillifetimeVAR.Value
end)

-- CHARACTER END

------------------------------------------------

-- SET VALUES START

Toggles.BoxToggle:SetValue(false)
Toggles.NameToggle:SetValue(false)
Toggles.TracerToggle:SetValue(false)
Toggles.ChamsToggle:SetValue(false)
Toggles.WallChamsToggle:SetValue(false)
Options.ChamsFillColor:SetValueRGB(Color3.fromRGB(0, 255, 140))
Toggles.RainbowFillColor:SetValue(false)
Toggles.RainbowOutlineColor:SetValue(false)
Toggles.SyncRainbowColors:SetValue(false)
Toggles.PulsingChams:SetValue(false)
Toggles.TeamToggle:SetValue(false)
Toggles.Breadcrumbs:SetValue(false)

-- SET VALUES END

-- VISUALS END

------------------------------------------------

-- WATERMARK START

Library:SetWatermarkVisibility(true)

Library:SetWatermark('This is a really long watermark to text the resizing')

-- WATERMARK END

------------------------------------------------

-- ADDONS START

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings() 

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')


SaveManager:BuildConfigSection(Tabs['UI Settings']) 

ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- ADDONS END

------------------------------------------------
