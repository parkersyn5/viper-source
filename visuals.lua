------------------------------------------------

-- CHAMS SETTINGS START

getgenv().ChamsTeamColors = false
getgenv().ChamsEnabled = true
getgenv().ChamsDepthMode = Enum.HighlightDepthMode.Occluded -- Enum.HighlightDepthMode.Occluded to make it visible only
getgenv().ChamsFillColor = Color3.fromRGB(10, 10, 10)
getgenv().ChamsOutlineColor = Color3.fromRGB(85, 105, 230)
getgenv().ChamsFillTransparency = 0
getgenv().ChamsOutlineTransparency = 0

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function CreateHighlight(Player)
   if (not Player.Character:FindFirstChild("HighlightCham") and Player ~= Players.LocalPlayer) then
       local Highlight = Instance.new("Highlight", Player.Character)
       Highlight.Name = "HighlightCham"
   end
end

RunService.Stepped:Connect(function()
    for i,v in next, Players:GetPlayers() do
        CreateHighlight(v)
        if (v.Character:FindFirstChild("HighlightCham")) then
            local Highlight = v.Character.HighlightCham
            Highlight.Enabled = getgenv().ChamsEnabled
            Highlight.DepthMode = getgenv().ChamsDepthMode
            Highlight.FillColor = getgenv().ChamsFillColor
            Highlight.OutlineColor = getgenv().ChamsOutlineColor
            Highlight.FillTransparency = getgenv().ChamsFillTransparency
            Highlight.OutlineTransparency = getgenv().ChamsOutlineTransparency
            if getgenv().ChamsTeamColors == true then
                Highlight.FillColor = v.TeamColor.Color
            end
        end
    end
end)

-- CHAMS SETTINGS END

------------------------------------------------

-- ESP SETTINGS START

local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInput = game:GetService("UserInputService")

function AttachChams(parent, face)
	local SurfaceGui = Instance.new("SurfaceGui",parent) 
	SurfaceGui.Parent = parent
	SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	SurfaceGui.Face = Enum.NormalId[face]
	SurfaceGui.LightInfluence = 0
	SurfaceGui.ResetOnSpawn = false
	SurfaceGui.Name = "Body"
	SurfaceGui.AlwaysOnTop = true
	local Frame = Instance.new("Frame",SurfaceGui)
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.Size = UDim2.new(1,0,1,0)
end

getgenv().viperespsettings = {
    Box = false,
    Name = false,
    Tracers = false,
    Chams = false,
    Font = 3,
    Teammates = false,
    VisibleOnly = false,
    UnlockTracers = false,
    TextSize = 16
}

local function ViperESP(v)
    local BoxOutline = Drawing.new("Square")
    BoxOutline.Visible = false
    BoxOutline.Color = Color3.new(0,0,0)
    BoxOutline.Thickness = 3
    BoxOutline.Transparency = 1
    BoxOutline.Filled = false

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.new(1,1,1)
    Box.Thickness = 1
    Box.Transparency = 1
    Box.Filled = false

    local HealthBarOutline = Drawing.new("Square")
    HealthBarOutline.Thickness = 3
    HealthBarOutline.Filled = false
    HealthBarOutline.Color = Color3.new(0,0,0)
    HealthBarOutline.Transparency = 1
    HealthBarOutline.Visible = false

    local HealthBar = Drawing.new("Square")
    HealthBar.Thickness = 1
    HealthBar.Filled = false
    HealthBar.Transparency = 1
    HealthBar.Visible = false
    
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(1,1,1)
    Tracer.Thickness = 1
    Tracer.Transparency = 1
    
    local Name = Drawing.new("Text")
    Name.Transparency = 1
    Name.Visible = false
    Name.Color = Color3.new(1,1,1)
    Name.Size = 12
    Name.Center = true
    Name.Outline = true
    

    local Gun = Drawing.new("Text")
    Gun.Transparency = 1
    Gun.Visible = false
    Gun.Color = Color3.new(1,1,1)
    Gun.Size = 12
    Gun.Center = true
    Gun.Outline = true

    game:GetService("RunService").RenderStepped:Connect(function()
        if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
            local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local Distance = (CurrentCamera.CFrame.p - v.Character.HumanoidRootPart.Position).Magnitude
            local RootPart = v.Character.HumanoidRootPart
            local Head = v.Character.Head
            local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
            local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + Vector3.new(0,0.5,0))
            local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - Vector3.new(0,3,0))
                
            if viperespsettings.Chams and v.Character.Head:FindFirstChild("Body") == nil then
                for i,v in pairs(v.Character:GetChildren()) do
                    if v:IsA("MeshPart") or v.Name == "Head" then
                        AttachChams(v, "Back")
                        AttachChams(v, "Front")
                        AttachChams(v, "Top")
                        AttachChams(v, "Bottom")
                        AttachChams(v, "Right")
                        AttachChams(v, "Left")
                    end
                end
            end

            if onScreen then
                if viperespsettings.Box then
                    BoxOutline.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                    BoxOutline.Visible = true
    
                    Box.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                    Box.Visible = true
                        
                    HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
                    HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)
                    HealthBarOutline.Visible = true
    
                    HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (v.Character.Humanoid.MaxHealth / math.clamp(v.Character.Humanoid.Health, 0,v.Character.Humanoid.MaxHealth)))
                    HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1 / HealthBar.Size.Y))
                    HealthBar.Color = Color3.fromRGB(255 - 255 / (v.Character.Humanoid.MaxHealth / v.Character.Humanoid.Health), 255 / (v.Character.Humanoid.MaxHealth / v.Character.Humanoid.Health), 0)
                    HealthBar.Visible = true
                else
                    BoxOutline.Visible = false
                    Box.Visible = false
                    HealthBarOutline.Visible = false
                    HealthBar.Visible = false
                end
                if viperespsettings.Tracers then
                    if viperespsettings.UnlockTracers then
                        Tracer.From = Vector2.new(mouse.X, mouse.Y + 36)
                    else
                        Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    end
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)
                    Tracer.Visible = true
                else
                    Tracer.Visible = false
                end
                if viperespsettings.Name then
                    Name.Text = tostring(v.Name)
                    Name.Position = Vector2.new(workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).X, workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).Y - 30)
                    Name.Visible = true
                    Name.Size = viperespsettings.TextSize
                    if viperespsettings.Font == "UI" then
                        Name.Font = 0
                        Gun.Font = 0
                    elseif viperespsettings.Font == "System" then
                        Name.Font = 1
                        Gun.Font = 1
                    elseif viperespsettings.Font == "Plex" then
                        Name.Font = 2
                        Gun.Font = 2
                    elseif viperespsettings.Font == "Monospace" then
                        Name.Font = 3
                        Gun.Font = 3
                    end
                    Gun.Size = viperespsettings.TextSize
                    Gun.Text = tostring("")
                    Gun.Position = Vector2.new(LegPosition.X, LegPosition.Y + 10)
                    Gun.Visible = true
                else
                    Name.Visible = false
                    Gun.Visible = false
                end
            else
                BoxOutline.Visible = false
                Box.Visible = false
                HealthBarOutline.Visible = false
                HealthBar.Visible = false
                Tracer.Visible = false
                Name.Visible = false
                Gun.Visible = false
            end
        else
            BoxOutline.Visible = false
            Box.Visible = false
            HealthBarOutline.Visible = false
            HealthBar.Visible = false
            Tracer.Visible = false
            Name.Visible = false
            Gun.Visible = false
        end
    end)
end

for i,v in pairs(game.Players:GetChildren()) do
    ViperESP(v)
end

game.Players.PlayerAdded:Connect(function(v)
    ViperESP(v)
end)

-- ESP SETTINGS END

-------------------------------------------------

-- LOADER START

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/parkersyn5/viper-main/main/Library/Main.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/parkersyn5/viper-main/main/Library/addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/parkersyn5/viper-main/main/Library/addons/SaveManager.lua'))()

-- LOADER END

-------------------------------------------------

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
