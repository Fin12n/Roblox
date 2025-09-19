-- Fin12nUI Library
-- Tạo bởi: Claude Sonnet 4.0 AI
-- UI được làm bởi Fin12n

-- Window Object
    local Window = {
        Visible = false,
        Container = MainContainer,
        ContentArea = ContentArea,
        Tabs = Tabs,
        CurrentTab = nil,
        CreateTab = CreateTab
    }
    
    -- Window Methods
    function Window:Show()
        showWindow()
        self.Visible = true
    end
    
    function Window:Hide()
        hideWindow()
        self.Visible = false
    end
    
    function Window:Toggle()
        toggleWindow()
        self.Visible = UIVisible
    end
    
    function Window:SetTitle(newTitle)
        TitleLabel.Text = newTitle
    end
    
    function Window:Destroy()
        ScreenGui:Destroy()
    end
    
    -- Tab Methods
    function Window:CreateTab(name, icon)
        return CreateTab(name, icon or "default")
    end
    
    function Window:SelectTab(tabName)
        local tab = self.Tabs[tabName]
        if tab and tab.Button then
            tab.Button.MouseButton1Click:Fire()
        end
    end
    
    function Window:GetCurrentTab()
        return CurrentTab
    end
    
    -- Set default tab if specified
    if defaultTab then
        spawn(function()
            wait(0.1) -- Small delay to ensure tab is created
            Window:SelectTab(defaultTab)
        end)
    end
    
    -- UI Elements Creation Functions (Updated with Icons)
    function Window:CreateSection(text, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content) or ContentArea
        icon = icon or "default"
        
        local Section = Instance.new("Frame")
        Section.Parent = parent
        Section.BackgroundColor3 = currentTheme.Surface
        Section.BorderSizePixel = 0
        Section.Size = UDim2.new(1, 0, 0, 60)
        Section.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 12)
        sectionCorner.Parent = Section
        
        local sectionIcon = Instance.new("TextLabel")
        sectionIcon.Parent = Section
        sectionIcon.BackgroundTransparency = 1
        sectionIcon.Position = UDim2.new(0, 15, 0, 0)
        sectionIcon.Size = UDim2.new(0, 30, 1, 0)
        sectionIcon.Font = Enum.Font.Gotham
        sectionIcon.Text = Fin12nLib:GetIcon(icon)
        sectionIcon.TextColor3 = currentTheme.Primary
        sectionIcon.TextSize = 18
        sectionIcon.TextXAlignment = Enum.TextXAlignment.Center
        sectionIcon.TextYAlignment = Enum.TextYAlignment.Center
        sectionIcon.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.Parent = Section
        sectionTitle.BackgroundTransparency = 1
        sectionTitle.Position = UDim2.new(0, 50, 0, 0)
        sectionTitle.Size = UDim2.new(1, -65, 1, 0)
        sectionTitle.Font = Enum.Font.GothamBold
        sectionTitle.Text = text
        sectionTitle.TextColor3 = currentTheme.Primary
        sectionTitle.TextSize = 16
        sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionTitle.TextYAlignment = Enum.TextYAlignment.Center
        sectionTitle.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        -- Accent line
        local accentLine = Instance.new("Frame")
        accentLine.Parent = Section
        accentLine.BackgroundColor3 = currentTheme.Primary
        accentLine.BorderSizePixel = 0
        accentLine.Position = UDim2.new(0, 50, 1, -3)
        accentLine.Size = UDim2.new(0, 60, 0, 2)
        accentLine.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local accentCorner = Instance.new("UICorner")
        accentCorner.CornerRadius = UDim.new(1, 0)
        accentCorner.Parent = accentLine
        
        return Section
    end
    
    function Window:CreateButton(text, callback, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content) or ContentArea
        icon = icon or "default"
        
        local Button = Instance.new("TextButton")
        Button.Parent = parent
        Button.BackgroundColor3 = currentTheme.Primary
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(1, 0, 0, 45)
        Button.Font = Enum.Font.GothamSemibold
        Button.Text = ""
        Button.TextColor3 = currentTheme.Text
        Button.TextSize = 14
        Button.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = Button
        
        local buttonIcon = Instance.new("TextLabel")
        buttonIcon.Parent = Button
        buttonIcon.BackgroundTransparency = 1
        buttonIcon.Position = UDim2.new(0, 15, 0, 0)
        buttonIcon.Size = UDim2.new(0, 30, 1, 0)
        buttonIcon.Font = Enum.Font.Gotham
        buttonIcon.Text = Fin12nLib:GetIcon(icon)
        buttonIcon.TextColor3 = currentTheme.Text
        buttonIcon.TextSize = 16
        buttonIcon.TextXAlignment = Enum.TextXAlignment.Center
        buttonIcon.TextYAlignment = Enum.TextYAlignment.Center
        buttonIcon.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local buttonLabel = Instance.new("TextLabel")
        buttonLabel.Parent = Button
        buttonLabel.BackgroundTransparency = 1
        buttonLabel.Position = UDim2.new(0, 50, 0, 0)
        buttonLabel.Size = UDim2.new(1, -65, 1, 0)
        buttonLabel.Font = Enum.Font.GothamSemibold
        buttonLabel.Text = text
        buttonLabel.TextColor3 = currentTheme.Text
        buttonLabel.TextSize = 14
        buttonLabel.TextXAlignment = Enum.TextXAlignment.Left
        buttonLabel.TextYAlignment = Enum.TextYAlignment.Center
        buttonLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        Button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        Button.MouseEnter:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(
                    math.min(255, currentTheme.Primary.R * 255 + 20),
                    math.min(255, currentTheme.Primary.G * 255 + 20),
                    math.min(255, currentTheme.Primary.B * 255 + 20)
                )
            }):Play()
        end)
        
        Button.MouseLeave:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = currentTheme.Primary
            }):Play()
        end)
        
        return Button
    end
    
    function Window:CreateToggle(text, defaultValue, callback, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content) or ContentArea
        defaultValue = defaultValue or false
        icon = icon or "check"
        
        local Toggle = Instance.new("Frame")
        Toggle.Parent = parent
        Toggle.BackgroundColor3 = currentTheme.Surface
        Toggle.BorderSizePixel = 0
        Toggle.Size = UDim2.new(1, 0, 0, 50)
        Toggle.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 12)
        toggleCorner.Parent = Toggle
        
        local toggleIcon = Instance.new("TextLabel")
        toggleIcon.Parent = Toggle
        toggleIcon.BackgroundTransparency = 1
        toggleIcon.Position = UDim2.new(0, 15, 0, 0)
        toggleIcon.Size = UDim2.new(0, 30, 1, 0)
        toggleIcon.Font = Enum.Font.Gotham
        toggleIcon.Text = Fin12nLib:GetIcon(icon)
        toggleIcon.TextColor3 = currentTheme.TextSecondary
        toggleIcon.TextSize = 16
        toggleIcon.TextXAlignment = Enum.TextXAlignment.Center
        toggleIcon.TextYAlignment = Enum.TextYAlignment.Center
        toggleIcon.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local toggleLabel = Instance.new("TextLabel")
        toggleLabel.Parent = Toggle
        toggleLabel.BackgroundTransparency = 1
        toggleLabel.Position = UDim2.new(0, 50, 0, 0)
        toggleLabel.Size = UDim2.new(1, -110, 1, 0)
        toggleLabel.Font = Enum.Font.GothamSemibold
        toggleLabel.Text = text
        toggleLabel.TextColor3 = currentTheme.Text
        toggleLabel.TextSize = 14
        toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        toggleLabel.TextYAlignment = Enum.TextYAlignment.Center
        toggleLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Parent = Toggle
        toggleButton.BackgroundColor3 = defaultValue and currentTheme.Success or Color3.fromRGB(60, 60, 70)
        toggleButton.Position = UDim2.new(1, -55, 0.5, -12)
        toggleButton.Size = UDim2.new(0, 45, 0, 24)
        toggleButton.Text = ""
        toggleButton.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local toggleButtonCorner = Instance.new("UICorner")
        toggleButtonCorner.CornerRadius = UDim.new(1, 0)
        toggleButtonCorner.Parent = toggleButton
        
        local toggleIndicator = Instance.new("Frame")
        toggleIndicator.Parent = toggleButton
        toggleIndicator.BackgroundColor3 = currentTheme.Text
        toggleIndicator.Position = defaultValue and UDim2.new(0, 24, 0, 3) or UDim2.new(0, 3, 0, 3)
        toggleIndicator.Size = UDim2.new(0, 18, 0, 18)
        toggleIndicator.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(1, 0)
        indicatorCorner.Parent = toggleIndicator
        
        local toggled = defaultValue
        
        toggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            
            if toggled then
                TweenService:Create(toggleButton, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    BackgroundColor3 = currentTheme.Success
                }):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    Position = UDim2.new(0, 24, 0, 3)
                }):Play()
                TweenService:Create(toggleIcon, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    TextColor3 = currentTheme.Success
                }):Play()
            else
                TweenService:Create(toggleButton, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                }):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    Position = UDim2.new(0, 3, 0, 3)
                }):Play()
                TweenService:Create(toggleIcon, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    TextColor3 = currentTheme.TextSecondary
                }):Play()
            end
            
            if callback then callback(toggled) end
        end)
        
        return Toggle, function() return toggled end
    end
    
    function Window:CreateSlider(text, min, max, defaultValue, callback, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content) or ContentArea
        min = min or 0
        max = max or 100
        defaultValue = defaultValue or min
        icon = icon or "sliders"
        
        local Slider = Instance.new("Frame")
        Slider.Parent = parent
        Slider.BackgroundColor3 = currentTheme.Surface
        Slider.BorderSizePixel = 0
        Slider.Size = UDim2.new(1, 0, 0, 75)
        Slider.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 12)
        sliderCorner.Parent = Slider
        
        local sliderIcon = Instance.new("TextLabel")
        sliderIcon.Parent = Slider
        sliderIcon.BackgroundTransparency = 1
        sliderIcon.Position = UDim2.new(0, 15, 0, 5)
        sliderIcon.Size = UDim2.new(0, 30, 0, 25)
        sliderIcon.Font = Enum.Font.Gotham
        sliderIcon.Text = Fin12nLib:GetIcon(icon)
        sliderIcon.TextColor3 = currentTheme.Primary
        sliderIcon.TextSize = 16
        sliderIcon.TextXAlignment = Enum.TextXAlignment.Center
        sliderIcon.TextYAlignment = Enum.TextYAlignment.Center
        sliderIcon.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sliderLabel = Instance.new("TextLabel")
        sliderLabel.Parent = Slider
        sliderLabel.BackgroundTransparency = 1
        sliderLabel.Position = UDim2.new(0, 50, 0, 5)
        sliderLabel.Size = UDim2.new(1, -115, 0, 25)
        sliderLabel.Font = Enum.Font.GothamSemibold
        sliderLabel.Text = text
        sliderLabel.TextColor3 = currentTheme.Text
        sliderLabel.TextSize = 14
        sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        sliderLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sliderValue = Instance.new("TextLabel")
        sliderValue.Parent = Slider
        sliderValue.BackgroundTransparency = 1
        sliderValue.Position = UDim2.new(1, -65, 0, 5)
        sliderValue.Size = UDim2.new(0, 50, 0, 25)
        sliderValue.Font = Enum.Font.GothamBold
        sliderValue.Text = tostring(defaultValue)
        sliderValue.TextColor3 = currentTheme.Primary
        sliderValue.TextSize = 14
        sliderValue.TextXAlignment = Enum.TextXAlignment.Right
        sliderValue.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sliderTrack = Instance.new("Frame")
        sliderTrack.Parent = Slider
        sliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        sliderTrack.Position = UDim2.new(0, 50, 0, 45)
        sliderTrack.Size = UDim2.new(1, -65, 0, 20)
        sliderTrack.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local trackCorner = Instance.new("UICorner")
        trackCorner.CornerRadius = UDim.new(1, 0)
        trackCorner.Parent = sliderTrack
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Parent = sliderTrack
        sliderFill.BackgroundColor3 = currentTheme.Primary
        sliderFill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
        sliderFill.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(1, 0)
        fillCorner.Parent = sliderFill
        
        local sliderHandle = Instance.new("Frame")
        sliderHandle.Parent = sliderTrack
        sliderHandle.BackgroundColor3 = currentTheme.Text
        sliderHandle.Position = UDim2.new((defaultValue - min) / (max - min), -8, 0, -2)
        sliderHandle.Size = UDim2.new(0, 16, 0, 24)
        sliderHandle.ZIndex = Fin12nLib.Config.ZIndex.Base + 1
        
        local handleCorner = Instance.new("UICorner")
        handleCorner.CornerRadius = UDim.new(0, 8)
        handleCorner.Parent = sliderHandle
        
        local dragging = false
        local currentValue = defaultValue
        
        sliderTrack.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local mousePos = UIS:GetMouseLocation()
                if input.UserInputType == Enum.UserInputType.Touch then
                    mousePos = input.Position
                end
                
                local sliderPos = sliderTrack.AbsolutePosition
                local sliderSize = sliderTrack.AbsoluteSize
                local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
                
                currentValue = min + (max - min) * relativeX
                if max - min <= 10 then
                    currentValue = math.floor(currentValue * 10) / 10
                else
                    currentValue = math.floor(currentValue)
                end
                
                sliderValue.Text = tostring(currentValue)
                
                TweenService:Create(sliderFill, TweenInfo.new(0.1), {
                    Size = UDim2.new(relativeX, 0, 1, 0)
                }):Play()
                TweenService:Create(sliderHandle, TweenInfo.new(0.1), {
                    Position = UDim2.new(relativeX, -8, 0, -2)
                }):Play()
                
                if callback then callback(currentValue) end
            end
        end)
        
        return Slider, function() return currentValue end
    end
    
    function Window:CreateTextBox(text, placeholder, callback, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content) or ContentArea
        placeholder = placeholder or "Enter text..."
        icon = icon or "edit"
        
        local TextBox = Instance.new("Frame")
        TextBox.Parent = parent
        TextBox.BackgroundColor3 = currentTheme.Surface
        TextBox.BorderSizePixel = 0
        TextBox.Size = UDim2.new(1, 0, 0, 75)
        TextBox.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local textboxCorner = Instance.new("UICorner")
        textboxCorner.CornerRadius = UDim.new(0, 12)
        textboxCorner.Parent = TextBox
        
        local textboxIcon = Instance.new("TextLabel")
        textboxIcon.Parent = TextBox
        textboxIcon.BackgroundTransparency = 1
        textboxIcon.Position = UDim2.new(0, 15, 0, 5)
        textboxIcon.Size = UDim2.new(0, 30, 0, 25)
        textboxIcon.Font = Enum.Font.Gotham
        textboxIcon.Text = Fin12nLib:GetIcon(icon)
        textboxIcon.TextColor3 = currentTheme.Primary
        textboxIcon.TextSize = 16
        textboxIcon.TextXAlignment = Enum.TextXAlignment.Center
        textboxIcon.TextYAlignment = Enum.TextYAlignment.Center
        textboxIcon.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local textboxLabel = Instance.new("TextLabel")
        textboxLabel.Parent = TextBox
        textboxLabel.BackgroundTransparency = 1
        textboxLabel.Position = UDim2.new(0, 50, 0, 5)
        textboxLabel.Size = UDim2.new(1, -65, 0, 25)
        textboxLabel.Font = Enum.Font.GothamSemibold
        textboxLabel.Text = text
        textboxLabel.TextColor3 = currentTheme.Text
        textboxLabel.TextSize = 14
        textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
        textboxLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local textInput = Instance.new("TextBox")
        textInput.Parent = TextBox
        textInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        textInput.BorderSizePixel = 0
        textInput.Position = UDim2.new(0, 50, 0, 40)
        textInput.Size = UDim2.new(1, -65, 0, 25)
        textInput.Font = Enum.Font.Gotham
        textInput.PlaceholderText = placeholder
        textInput.Text = ""
        textInput.TextColor3 = currentTheme.Text
        textInput.TextSize = 12
        textInput.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 6)
        inputCorner.Parent = textInput
        
        if callback then
            textInput.FocusLost:Connect(function(enterPressed)
                callback(textInput.Text, enterPressed)
            end)
        end
        
        return TextBox, textInput
    end
    
    function Window:CreateLabel(text, size, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content) or ContentArea
        size = size or 14
        icon = icon or "info"
        
        local Label = Instance.new("Frame")
        Label.Parent = parent
        Label.BackgroundColor3 = currentTheme.Surface
        Label.BorderSizePixel = 0
        Label.Size = UDim2.new(1, 0, 0, 40)
        Label.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local labelCorner = Instance.new("UICorner")
        labelCorner.CornerRadius = UDim.new(0, 10)
        labelCorner.Parent = Label
        
        local labelIcon = Instance.new("TextLabel")
        labelIcon.Parent = Label
        labelIcon.BackgroundTransparency = 1
        labelIcon.Position = UDim2.new(0, 15, 0, 0)
        labelIcon.Size = UDim2.new(0, 30, 1, 0)
        labelIcon.Font = Enum.Font.Gotham
        labelIcon.Text = Fin12nLib:GetIcon(icon)
        labelIcon.TextColor3 = currentTheme.TextSecondary
        labelIcon.TextSize = 16
        labelIcon.TextXAlignment = Enum.TextXAlignment.Center
        labelIcon.TextYAlignment = Enum.TextYAlignment.Center
        labelIcon.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local labelText = Instance.new("TextLabel")
        labelText.Parent = Label
        labelText.BackgroundTransparency = 1
        labelText.Position = UDim2.new(0, 50, 0, 0)
        labelText.Size = UDim2.new(1, -65, 1, 0)
        labelText.Font = Enum.Font.Gotham
        labelText.Text = text
        labelText.TextColor3 = currentTheme.TextSecondary
        labelText.TextSize = size
        labelText.TextWrapped = true
        labelText.TextXAlignment = Enum.TextXAlignment.Left
        labelText.TextYAlignment = Enum.TextYAlignment.Center
        labelText.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        return Label, labelText
    end
    
    function Window:CreateLine(parent)
        parent = parent or (CurrentTab and CurrentTab.Content) or ContentArea
        
        local Line = Instance.new("Frame")
        Line.Parent = parent
        Line.BackgroundColor3 = currentTheme.Primary
        Line.BorderSizePixel = 0
        Line.Size = UDim2.new(1, 0, 0, 2)
        Line.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local lineCorner = Instance.new("UICorner")
        lineCorner.CornerRadius = UDim.new(1, 0)
        lineCorner.Parent = Line
        
        return Line
    end
    
    function Window:CreateImageLabel(imageId, size, parent)
        parent = parent or (CurrentTab and CurrentTab.Content) or ContentArea
        size = size or UDim2.new(1, 0, 0, 100)
        
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Parent = parent
        ImageLabel.BackgroundColor3 = currentTheme.Surface
        ImageLabel.BorderSizePixel = 0
        ImageLabel.Size = size
        ImageLabel.Image = "rbxassetid://" .. tostring(imageId)
        ImageLabel.ScaleType = Enum.ScaleType.Fit
        ImageLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local imageCorner = Instance.new("UICorner")
        imageCorner.CornerRadius = UDim.new(0, 12)
        imageCorner.Parent = ImageLabel
        
        return ImageLabel
    end
    
    return Window

-- Settings Saver Integration (Placeholder for future implementation)
Fin12nLib.Settings = {
    SavedData = {},
    AutoSave = true,
    SaveInterval = 5 -- seconds
}

function Fin12nLib:LoadSettingsSaver(url)
    -- This will load external settings saver script
    if url and loadstring and game:HttpGet then
        local success, settingsSaver = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        
        if success and settingsSaver then
            self.SettingsSaver = settingsSaver
            return settingsSaver
        else
            warn("Failed to load Settings Saver from: " .. url)
        end
    end
    return nil
end

-- Example Usage with new features
--[[
local Fin12nLib = loadstring(game:HttpGet("your-script-url"))()

-- Set theme
Fin12nLib:SetTheme(Fin12nLib.Themes.Purple)

-- Create window with default tab
local Window = Fin12nLib:CreateWindow({
    Title = "Fin12nLib Demo",
    Size = UDim2.new(0, 500, 0, 400),
    DefaultTab = "Main", -- This tab will open by default
    KeySystem = {
        Title = "Key Required",
        KeyUrl = "https://example.com/getkey",
        OnSuccess = function(key)
            return key == "correct_key"
        end
    }
})

-- Create tabs with icons
local mainTab = Window:CreateTab("Main", "home")
local settingsTab = Window:CreateTab("Settings", "settings")

-- Add elements with icons to main tab
mainTab.Content.CreateSection = function(text, icon) return Window:CreateSection(text, icon, mainTab.Content) end
mainTab.Content:CreateSection("Player Features", "user")

local speedToggle = Window:CreateToggle("Speed Hack", false, function(value)
    print("Speed:", value)
end, "zap", mainTab.Content)

local fovSlider = Window:CreateSlider("FOV", 70, 120, 90, function(value)
    print("FOV:", value)
end, "target", mainTab.Content)

-- Show window
Window:Show()
--]]

return Fin12nLib-- Fin12nLib v1.1 | Advanced UI Library for Roblox
-- Created by Fin12n | Mobile & Desktop Support with Lucide Icons

local Fin12nLib = {}

-- Lucide Icons Database (Popular Icons)
Fin12nLib.Icons = {
    -- Navigation & UI
    ["home"] = "🏠",
    ["menu"] = "☰",
    ["settings"] = "⚙️",
    ["search"] = "🔍",
    ["filter"] = "🔽",
    ["sort"] = "↕️",
    ["grid"] = "⊞",
    ["list"] = "☰",
    ["more-horizontal"] = "⋯",
    ["more-vertical"] = "⋮",
    
    -- Actions
    ["plus"] = "➕",
    ["minus"] = "➖",
    ["x"] = "✕",
    ["check"] = "✓",
    ["edit"] = "✏️",
    ["trash"] = "🗑️",
    ["save"] = "💾",
    ["download"] = "⬇️",
    ["upload"] = "⬆️",
    ["refresh"] = "🔄",
    ["copy"] = "📋",
    ["share"] = "🔗",
    
    -- Arrows & Direction
    ["arrow-up"] = "↑",
    ["arrow-down"] = "↓",
    ["arrow-left"] = "←",
    ["arrow-right"] = "→",
    ["chevron-up"] = "▲",
    ["chevron-down"] = "▼",
    ["chevron-left"] = "◀",
    ["chevron-right"] = "▶",
    
    -- Status & Alerts
    ["info"] = "ℹ️",
    ["alert-circle"] = "⚠️",
    ["alert-triangle"] = "⚠️",
    ["check-circle"] = "✅",
    ["x-circle"] = "❌",
    ["help-circle"] = "❓",
    
    -- Communication
    ["mail"] = "📧",
    ["message-circle"] = "💬",
    ["phone"] = "📞",
    ["bell"] = "🔔",
    ["bell-off"] = "🔕",
    
    -- Media & Files
    ["image"] = "🖼️",
    ["file"] = "📄",
    ["folder"] = "📁",
    ["folder-open"] = "📂",
    ["camera"] = "📷",
    ["video"] = "🎥",
    ["music"] = "🎵",
    ["headphones"] = "🎧",
    
    -- Tools & Objects
    ["wrench"] = "🔧",
    ["hammer"] = "🔨",
    ["key"] = "🔑",
    ["lock"] = "🔒",
    ["unlock"] = "🔓",
    ["shield"] = "🛡️",
    ["sword"] = "⚔️",
    ["target"] = "🎯",
    
    -- Users & People
    ["user"] = "👤",
    ["users"] = "👥",
    ["user-plus"] = "👤+",
    ["user-minus"] = "👤-",
    ["crown"] = "👑",
    ["heart"] = "❤️",
    ["star"] = "⭐",
    
    -- Gaming & Entertainment
    ["gamepad"] = "🎮",
    ["trophy"] = "🏆",
    ["gift"] = "🎁",
    ["zap"] = "⚡",
    ["flame"] = "🔥",
    ["rocket"] = "🚀",
    
    -- Buildings & Places
    ["building"] = "🏢",
    ["house"] = "🏠",
    ["shop"] = "🏪",
    ["car"] = "🚗",
    ["plane"] = "✈️",
    ["ship"] = "🚢",
    
    -- Nature & Weather
    ["sun"] = "☀️",
    ["moon"] = "🌙",
    ["star"] = "⭐",
    ["cloud"] = "☁️",
    ["cloud-rain"] = "🌧️",
    ["snowflake"] = "❄️",
    ["tree"] = "🌳",
    
    -- Technology
    ["wifi"] = "📶",
    ["bluetooth"] = "📶",
    ["battery"] = "🔋",
    ["cpu"] = "💾",
    ["smartphone"] = "📱",
    ["monitor"] = "🖥️",
    ["printer"] = "🖨️",
    
    -- Time & Calendar
    ["clock"] = "🕐",
    ["calendar"] = "📅",
    ["timer"] = "⏱️",
    ["stopwatch"] = "⏱️",
    
    -- Shapes & Symbols
    ["circle"] = "○",
    ["square"] = "□",
    ["triangle"] = "△",
    ["diamond"] = "◇",
    ["hexagon"] = "⬡",
    
    -- Default fallback
    ["default"] = "•"
}

-- Function to get icon
function Fin12nLib:GetIcon(iconName)
    return self.Icons[iconName] or self.Icons["default"]
end

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Device Detection
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled
local isTablet = UIS.TouchEnabled and UIS.KeyboardEnabled

-- Configuration
Fin12nLib.Config = {
    DefaultTheme = {
        Primary = Color3.fromRGB(70, 130, 255),
        Secondary = Color3.fromRGB(50, 100, 220),
        Background = Color3.fromRGB(20, 20, 30),
        Surface = Color3.fromRGB(30, 30, 40),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(200, 200, 200),
        Success = Color3.fromRGB(70, 200, 120),
        Warning = Color3.fromRGB(255, 180, 50),
        Error = Color3.fromRGB(255, 80, 80),
        Info = Color3.fromRGB(70, 130, 255)
    },
    Animation = {
        Speed = 0.3,
        Style = Enum.EasingStyle.Quad
    },
    ZIndex = {
        Base = 999990,
        Notification = 999999,
        KeySystem = 999995,
        MobileToggle = 999999
    }
}

-- Theme System
local currentTheme = Fin12nLib.Config.DefaultTheme

function Fin12nLib:SetTheme(theme)
    for key, value in pairs(theme) do
        if currentTheme[key] then
            currentTheme[key] = value
        end
    end
end

function Fin12nLib:GetTheme()
    return currentTheme
end

-- Notification System
local NotificationQueue = {}
local NotificationFrame = nil
local isNotificationShowing = false

local function CreateNotificationSystem(parent)
    NotificationFrame = Instance.new("Frame")
    NotificationFrame.Parent = parent
    NotificationFrame.BackgroundColor3 = currentTheme.Surface
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.Position = UDim2.new(1, -320, 1, -80)
    NotificationFrame.Size = UDim2.new(0, 300, 0, 70)
    NotificationFrame.Visible = false
    NotificationFrame.ZIndex = Fin12nLib.Config.ZIndex.Notification
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = NotificationFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, currentTheme.Primary),
        ColorSequenceKeypoint.new(1, currentTheme.Secondary)
    }
    gradient.Rotation = 45
    gradient.Parent = NotificationFrame
    
    local icon = Instance.new("TextLabel")
    icon.Parent = NotificationFrame
    icon.BackgroundTransparency = 1
    icon.Position = UDim2.new(0, 15, 0, 10)
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Font = Enum.Font.GothamBold
    icon.Text = "✓"
    icon.TextColor3 = currentTheme.Text
    icon.TextSize = 20
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.TextYAlignment = Enum.TextYAlignment.Center
    icon.ZIndex = Fin12nLib.Config.ZIndex.Notification
    
    local label = Instance.new("TextLabel")
    label.Parent = NotificationFrame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 55, 0, 10)
    label.Size = UDim2.new(1, -70, 0, 30)
    label.Font = Enum.Font.GothamSemibold
    label.Text = ""
    label.TextColor3 = currentTheme.Text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.ZIndex = Fin12nLib.Config.ZIndex.Notification
    
    local progress = Instance.new("Frame")
    progress.Parent = NotificationFrame
    progress.BackgroundColor3 = currentTheme.Text
    progress.BorderSizePixel = 0
    progress.Position = UDim2.new(0, 15, 1, -8)
    progress.Size = UDim2.new(1, -30, 0, 3)
    progress.ZIndex = Fin12nLib.Config.ZIndex.Notification
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(1, 0)
    progressCorner.Parent = progress
    
    NotificationFrame.Icon = icon
    NotificationFrame.Label = label
    NotificationFrame.Progress = progress
    NotificationFrame.Gradient = gradient
end

function Fin12nLib:Notify(message, type, duration)
    if not NotificationFrame then return end
    
    type = type or "info"
    duration = duration or 3
    
    table.insert(NotificationQueue, {
        message = message,
        type = type,
        duration = duration
    })
    
    if not isNotificationShowing then
        spawn(function()
            while #NotificationQueue > 0 do
                local notification = table.remove(NotificationQueue, 1)
                isNotificationShowing = true
                
                local icons = {
                    success = "✓",
                    warning = "⚠",
                    error = "✗",
                    info = "ℹ"
                }
                
                local colors = {
                    success = {currentTheme.Success, Color3.fromRGB(50, 180, 100)},
                    warning = {currentTheme.Warning, Color3.fromRGB(235, 160, 30)},
                    error = {currentTheme.Error, Color3.fromRGB(235, 60, 60)},
                    info = {currentTheme.Info, currentTheme.Secondary}
                }
                
                NotificationFrame.Icon.Text = icons[notification.type] or icons.info
                NotificationFrame.Label.Text = notification.message
                
                NotificationFrame.Gradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, colors[notification.type][1]),
                    ColorSequenceKeypoint.new(1, colors[notification.type][2])
                }
                
                NotificationFrame.Visible = true
                NotificationFrame.Position = UDim2.new(1, 0, 1, -80)
                
                TweenService:Create(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Position = UDim2.new(1, -320, 1, -80)
                }):Play()
                
                NotificationFrame.Progress.Size = UDim2.new(1, -30, 0, 3)
                local progressTween = TweenService:Create(NotificationFrame.Progress, TweenInfo.new(notification.duration, Enum.EasingStyle.Linear), {
                    Size = UDim2.new(0, 0, 0, 3)
                })
                progressTween:Play()
                
                wait(notification.duration)
                
                TweenService:Create(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Position = UDim2.new(1, 0, 1, -80)
                }):Play()
                
                wait(0.3)
                NotificationFrame.Visible = false
                
                if #NotificationQueue == 0 then
                    isNotificationShowing = false
                end
            end
        end)
    end
end

-- Key System
local KeySystemActive = false
local KeySystemGui = nil

function Fin12nLib:CreateKeySystem(config)
    config = config or {}
    local keyUrl = config.KeyUrl or ""
    local title = config.Title or "Key System"
    local description = config.Description or "Please enter the key to continue"
    local keyPlaceholder = config.KeyPlaceholder or "Enter key here..."
    local onSuccess = config.OnSuccess or function() end
    local onFail = config.OnFail or function() end
    
    if KeySystemActive then return end
    KeySystemActive = true
    
    -- Create Key System GUI
    KeySystemGui = Instance.new("ScreenGui")
    KeySystemGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    KeySystemGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    KeySystemGui.ResetOnSpawn = false
    KeySystemGui.DisplayOrder = Fin12nLib.Config.ZIndex.KeySystem
    
    -- Background Blur
    local background = Instance.new("Frame")
    background.Parent = KeySystemGui
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.3
    background.BorderSizePixel = 0
    background.Size = UDim2.new(1, 0, 1, 0)
    background.ZIndex = Fin12nLib.Config.ZIndex.KeySystem
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = KeySystemGui
    mainFrame.BackgroundColor3 = currentTheme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.ZIndex = Fin12nLib.Config.ZIndex.KeySystem + 1
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 15)
    mainCorner.Parent = mainFrame
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Parent = mainFrame
    titleBar.BackgroundColor3 = currentTheme.Primary
    titleBar.BorderSizePixel = 0
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.ZIndex = Fin12nLib.Config.ZIndex.KeySystem + 1
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 15)
    titleCorner.Parent = titleBar
    
    local titleFix = Instance.new("Frame")
    titleFix.Parent = titleBar
    titleFix.BackgroundColor3 = currentTheme.Primary
    titleFix.BorderSizePixel = 0
    titleFix.Position = UDim2.new(0, 0, 0.5, 0)
    titleFix.Size = UDim2.new(1, 0, 0.5, 0)
    titleFix.ZIndex = Fin12nLib.Config.ZIndex.KeySystem + 1
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = titleBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.Size = UDim2.new(1, -40, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = currentTheme.Text
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = Fin12nLib.Config.ZIndex.KeySystem + 1
    
    -- Description
    local descLabel = Instance.new("TextLabel")
    descLabel.Parent = mainFrame
    descLabel.BackgroundTransparency = 1
    descLabel.Position = UDim2.new(0, 20, 0, 70)
    descLabel.Size = UDim2.new(1, -40, 0, 40)
    descLabel.Font = Enum.Font.Gotham
    descLabel.Text = description
    descLabel.TextColor3 = currentTheme.TextSecondary
    descLabel.TextSize = 14
    descLabel.TextWrapped = true
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.ZIndex = Fin12nLib.Config.ZIndex.KeySystem + 1
    
    -- Key Input
    local keyInput = Instance.new("TextBox")
    keyInput.Parent = mainFrame
    keyInput.BackgroundColor3 = currentTheme.Surface
    keyInput.BorderSizePixel = 0
    keyInput.Position = UDim2.new(0, 20, 0, 130)
    keyInput.Size = UDim2.new(1, -40, 0, 40)
    keyInput.Font = Enum.Font.Gotham
    keyInput.PlaceholderText = keyPlaceholder
    keyInput.Text = ""
    keyInput.TextColor3 = currentTheme.Text
    keyInput.TextSize = 14
    keyInput.ZIndex = Fin12nLib.Config.ZIndex.KeySystem + 1
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = keyInput
    
    -- Get Key Button
    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Parent = mainFrame
    getKeyBtn.BackgroundColor3 = currentTheme.Warning
    getKeyBtn.BorderSizePixel = 0
    getKeyBtn.Position = UDim2.new(0, 20, 0, 185)
    getKeyBtn.Size = UDim2.new(0.48, -10, 0, 35)
    getKeyBtn.Font = Enum.Font.GothamSemibold
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = currentTheme.Text
    getKeyBtn.TextSize = 14
    getKeyBtn.ZIndex = Fin12nLib.Config.ZIndex.KeySystem + 1
    
    local getKeyCorner = Instance.new("UICorner")
    getKeyCorner.CornerRadius = UDim.new(0, 8)
    getKeyCorner.Parent = getKeyBtn
    
    -- Submit Button
    local submitBtn = Instance.new("TextButton")
    submitBtn.Parent = mainFrame
    submitBtn.BackgroundColor3 = currentTheme.Success
    submitBtn.BorderSizePixel = 0
    submitBtn.Position = UDim2.new(0.52, 10, 0, 185)
    submitBtn.Size = UDim2.new(0.48, -10, 0, 35)
    submitBtn.Font = Enum.Font.GothamSemibold
    submitBtn.Text = "Submit"
    submitBtn.TextColor3 = currentTheme.Text
    submitBtn.TextSize = 14
    submitBtn.ZIndex = Fin12nLib.Config.ZIndex.KeySystem + 1
    
    local submitCorner = Instance.new("UICorner")
    submitCorner.CornerRadius = UDim.new(0, 8)
    submitCorner.Parent = submitBtn
    
    -- Status Label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Parent = mainFrame
    statusLabel.BackgroundTransparency = 1
    statusLabel.Position = UDim2.new(0, 20, 0, 240)
    statusLabel.Size = UDim2.new(1, -40, 0, 30)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Text = ""
    statusLabel.TextColor3 = currentTheme.Error
    statusLabel.TextSize = 12
    statusLabel.TextXAlignment = Enum.TextXAlignment.Center
    statusLabel.ZIndex = Fin12nLib.Config.ZIndex.KeySystem + 1
    
    -- Animation
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 400, 0, 300),
        Position = UDim2.new(0.5, -200, 0.5, -150)
    }):Play()
    
    -- Button Functions
    getKeyBtn.MouseButton1Click:Connect(function()
        if keyUrl ~= "" then
            if setclipboard then
                setclipboard(keyUrl)
                statusLabel.TextColor3 = currentTheme.Success
                statusLabel.Text = "Key link copied to clipboard!"
            else
                statusLabel.TextColor3 = currentTheme.Info
                statusLabel.Text = "Visit: " .. keyUrl
            end
        else
            statusLabel.TextColor3 = currentTheme.Error
            statusLabel.Text = "No key URL provided"
        end
    end)
    
    submitBtn.MouseButton1Click:Connect(function()
        local key = keyInput.Text
        if key == "" then
            statusLabel.TextColor3 = currentTheme.Error
            statusLabel.Text = "Please enter a key"
            return
        end
        
        statusLabel.TextColor3 = currentTheme.Info
        statusLabel.Text = "Validating key..."
        
        -- Simulate key validation (you can implement actual validation here)
        spawn(function()
            wait(1)
            local success = onSuccess(key) -- Let the user handle validation
            if success ~= false then
                statusLabel.TextColor3 = currentTheme.Success
                statusLabel.Text = "Key validated successfully!"
                wait(1)
                KeySystemGui:Destroy()
                KeySystemActive = false
            else
                statusLabel.TextColor3 = currentTheme.Error
                statusLabel.Text = "Invalid key. Please try again."
                onFail()
            end
        end)
    end)
    
    return {
        Close = function()
            KeySystemGui:Destroy()
            KeySystemActive = false
        end,
        SetStatus = function(text, color)
            statusLabel.Text = text
            statusLabel.TextColor3 = color or currentTheme.Info
        end
    }
end

-- Mobile Toggle System
local MobileToggleButton = nil

local function CreateMobileToggle(parent, toggleCallback)
    if not isMobile and not isTablet then return end
    
    MobileToggleButton = Instance.new("TextButton")
    MobileToggleButton.Parent = parent
    MobileToggleButton.BackgroundColor3 = currentTheme.Primary
    MobileToggleButton.BorderSizePixel = 0
    MobileToggleButton.Position = UDim2.new(0.9, -30, 0.1, 0)
    MobileToggleButton.Size = UDim2.new(0, 60, 0, 60)
    MobileToggleButton.Text = "M"
    MobileToggleButton.TextColor3 = currentTheme.Text
    MobileToggleButton.TextSize = 24
    MobileToggleButton.Font = Enum.Font.GothamBold
    MobileToggleButton.ZIndex = Fin12nLib.Config.ZIndex.MobileToggle
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = MobileToggleButton
    
    -- Fixed Mobile Button State Management
    local mobileButtonState = {
        isDragging = false,
        dragStartPos = nil,
        buttonStartPos = nil,
        initialTouchTime = 0,
        hasMoved = false,
        inputConnection = nil
    }
    
    local DRAG_THRESHOLD = 10
    local TAP_TIME_LIMIT = 0.3
    
    local function resetMobileButtonState()
        mobileButtonState.isDragging = false
        mobileButtonState.dragStartPos = nil
        mobileButtonState.buttonStartPos = nil
        mobileButtonState.hasMoved = false
        if mobileButtonState.inputConnection then
            mobileButtonState.inputConnection:Disconnect()
            mobileButtonState.inputConnection = nil
        end
    end
    
    MobileToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resetMobileButtonState()
            
            mobileButtonState.initialTouchTime = tick()
            mobileButtonState.dragStartPos = input.Position
            mobileButtonState.buttonStartPos = MobileToggleButton.Position
            mobileButtonState.hasMoved = false
            
            mobileButtonState.inputConnection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    local touchDuration = tick() - mobileButtonState.initialTouchTime
                    
                    if touchDuration <= TAP_TIME_LIMIT and not mobileButtonState.hasMoved then
                        toggleCallback()
                    end
                    
                    resetMobileButtonState()
                end
            end)
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if mobileButtonState.dragStartPos and 
           (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            
            local currentPos = input.Position
            local dragDistance = (currentPos - mobileButtonState.dragStartPos).Magnitude
            
            if dragDistance >= DRAG_THRESHOLD and not mobileButtonState.hasMoved then
                mobileButtonState.hasMoved = true
                mobileButtonState.isDragging = true
            end
            
            if mobileButtonState.isDragging and mobileButtonState.buttonStartPos then
                local delta = currentPos - mobileButtonState.dragStartPos
                local newPos = UDim2.new(
                    mobileButtonState.buttonStartPos.X.Scale,
                    mobileButtonState.buttonStartPos.X.Offset + delta.X,
                    mobileButtonState.buttonStartPos.Y.Scale,
                    mobileButtonState.buttonStartPos.Y.Offset + delta.Y
                )
                
                -- Clamp to screen bounds
                local screenSize = game.Workspace.CurrentCamera.ViewportSize
                local buttonSize = 60
                local margin = 10
                
                local clampedX = math.clamp(newPos.X.Offset, margin, screenSize.X - buttonSize - margin)
                local clampedY = math.clamp(newPos.Y.Offset, margin, screenSize.Y - buttonSize - margin)
                
                MobileToggleButton.Position = UDim2.new(0, clampedX, 0, clampedY)
            end
        end
    end)
    
    return MobileToggleButton
end

-- Main Library Functions
function Fin12nLib:CreateWindow(config)
    config = config or {}
    local title = config.Title or "Fin12nLib Window"
    local size = config.Size or UDim2.new(0, 750, 0, 550)
    local position = config.Position or UDim2.new(0.15, 0, 0.05, 0)
    local keySystem = config.KeySystem or nil
    local defaultTab = config.DefaultTab or nil -- New: Default tab to open
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = Fin12nLib.Config.ZIndex.Base
    
    -- Initialize Notification System
    CreateNotificationSystem(ScreenGui)
    
    -- Key System
    if keySystem then
        local keySystemWindow = self:CreateKeySystem({
            Title = keySystem.Title or "Key System",
            Description = keySystem.Description or "Please enter the key to continue",
            KeyUrl = keySystem.KeyUrl or "",
            KeyPlaceholder = keySystem.KeyPlaceholder or "Enter key here...",
            OnSuccess = keySystem.OnSuccess or function() return true end,
            OnFail = keySystem.OnFail or function() end
        })
    end
    
    -- Create Mobile Toggle
    local mobileToggle = nil
    
    -- Main Container
    local MainContainer = Instance.new("Frame")
    MainContainer.Parent = ScreenGui
    MainContainer.BackgroundColor3 = currentTheme.Background
    MainContainer.BorderSizePixel = 0
    MainContainer.Position = position
    MainContainer.Size = size
    MainContainer.Visible = false
    MainContainer.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 15)
    mainCorner.Parent = MainContainer
    
    -- Shadow
    local Shadow = Instance.new("Frame")
    Shadow.Parent = ScreenGui
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 0.7
    Shadow.Position = UDim2.new(position.X.Scale, position.X.Offset + 5, position.Y.Scale, position.Y.Offset + 5)
    Shadow.Size = size
    Shadow.ZIndex = Fin12nLib.Config.ZIndex.Base - 1
    Shadow.Visible = false
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 15)
    shadowCorner.Parent = Shadow
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Parent = MainContainer
    TitleBar.BackgroundColor3 = currentTheme.Primary
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 15)
    titleCorner.Parent = TitleBar
    
    local titleFix = Instance.new("Frame")
    titleFix.Parent = TitleBar
    titleFix.BackgroundColor3 = currentTheme.Primary
    titleFix.BorderSizePixel = 0
    titleFix.Position = UDim2.new(0, 0, 0.5, 0)
    titleFix.Size = UDim2.new(1, 0, 0.5, 0)
    titleFix.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    -- Title Label
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = currentTheme.Text
    TitleLabel.TextSize = 20
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundColor3 = currentTheme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -40, 0, 10)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Text = "×"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextColor3 = currentTheme.Text
    CloseButton.TextSize = 18
    CloseButton.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = CloseButton
    
    -- Tab System
    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = MainContainer
    Sidebar.BackgroundColor3 = currentTheme.Surface
    Sidebar.BorderSizePixel = 0
    Sidebar.Position = UDim2.new(0, 0, 0, 50)
    Sidebar.Size = UDim2.new(0, 200, 1, -50)
    Sidebar.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    local TabContainer = Instance.new("Frame")
    TabContainer.Parent = Sidebar
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 10, 0, 10)
    TabContainer.Size = UDim2.new(1, -20, 1, -20)
    TabContainer.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Parent = TabContainer
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 8)
    
    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Parent = MainContainer
    ContentArea.BackgroundTransparency = 1
    ContentArea.Position = UDim2.new(0, 210, 0, 60)
    ContentArea.Size = UDim2.new(1, -220, 1, -70)
    ContentArea.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    -- Tab Management
    local Tabs = {}
    local CurrentTab = nil
    
    local function CreateTab(name, icon)
        icon = icon or "default"
        
        local tab = {
            Name = name,
            Icon = icon,
            Content = nil,
            Button = nil,
            Active = false
        }
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 45)
        TabButton.AutoButtonColor = false
        TabButton.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 10)
        TabCorner.Parent = TabButton
        
        local TabIcon = Instance.new("TextLabel")
        TabIcon.Parent = TabButton
        TabIcon.BackgroundTransparency = 1
        TabIcon.Position = UDim2.new(0, 15, 0, 0)
        TabIcon.Size = UDim2.new(0, 30, 1, 0)
        TabIcon.Font = Enum.Font.Gotham
        TabIcon.Text = Fin12nLib:GetIcon(icon)
        TabIcon.TextColor3 = currentTheme.TextSecondary
        TabIcon.TextSize = 18
        TabIcon.TextXAlignment = Enum.TextXAlignment.Left
        TabIcon.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Parent = TabButton
        TabLabel.BackgroundTransparency = 1
        TabLabel.Position = UDim2.new(0, 50, 0, 0)
        TabLabel.Size = UDim2.new(1, -60, 1, 0)
        TabLabel.Font = Enum.Font.GothamSemibold
        TabLabel.Text = name
        TabLabel.TextColor3 = currentTheme.TextSecondary
        TabLabel.TextSize = 14
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Parent = ContentArea
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Position = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.ScrollBarThickness = 6
        TabContent.ScrollBarImageColor3 = currentTheme.Primary
        TabContent.BorderSizePixel = 0
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Parent = TabContent
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 15)
        
        ContentLayout.Changed:Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
        end)
        
        tab.Button = TabButton
        tab.Content = TabContent
        
        -- Tab switching logic
        TabButton.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Active = false
                CurrentTab.Content.Visible = false
                TweenService:Create(CurrentTab.Button, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                }):Play()
                -- Reset icon and label colors
                CurrentTab.Button:FindFirstChild("TextLabel").TextColor3 = currentTheme.TextSecondary
                for _, child in pairs(CurrentTab.Button:GetChildren()) do
                    if child:IsA("TextLabel") and child ~= CurrentTab.Button:FindFirstChild("TextLabel") then
                        child.TextColor3 = currentTheme.TextSecondary
                    end
                end
            end
            
            tab.Active = true
            tab.Content.Visible = true
            CurrentTab = tab
            
            TweenService:Create(TabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundColor3 = currentTheme.Primary
            }):Play()
            
            -- Update icon and label colors
            TabIcon.TextColor3 = currentTheme.Text
            TabLabel.TextColor3 = currentTheme.Text
        end)
        
        -- Enhanced hover effects
        TabButton.MouseEnter:Connect(function()
            if not tab.Active then
                TweenService:Create(TabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                }):Play()
                TweenService:Create(TabIcon, TweenInfo.new(0.2), {
                    TextColor3 = currentTheme.Text
                }):Play()
                TweenService:Create(TabLabel, TweenInfo.new(0.2), {
                    TextColor3 = currentTheme.Text
                }):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if not tab.Active then
                TweenService:Create(TabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                }):Play()
                TweenService:Create(TabIcon, TweenInfo.new(0.2), {
                    TextColor3 = currentTheme.TextSecondary
                }):Play()
                TweenService:Create(TabLabel, TweenInfo.new(0.2), {
                    TextColor3 = currentTheme.TextSecondary
                }):Play()
            end
        end)
        
        Tabs[name] = tab
        return tab
    end
    
    -- Visibility System
    local UIVisible = false
    
    local function showWindow()
        UIVisible = true
        MainContainer.Visible = true
        Shadow.Visible = true
        
        MainContainer.Size = UDim2.new(0, 0, 0, 0)
        MainContainer.Position = UDim2.new(position.X.Scale + position.X.Scale/2, position.X.Offset + size.X.Offset/2, 
                                         position.Y.Scale + position.Y.Scale/2, position.Y.Offset + size.Y.Offset/2)
        
        TweenService:Create(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = size,
            Position = position
        }):Play()
    end
    
    local function hideWindow()
        UIVisible = false
        
        TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(position.X.Scale + position.X.Scale/2, position.X.Offset + size.X.Offset/2, 
                               position.Y.Scale + position.Y.Scale/2, position.Y.Offset + size.Y.Offset/2)
        }):Play()
        
        wait(0.3)
        MainContainer.Visible = false
        Shadow.Visible = false
    end
    
    local function toggleWindow()
        if UIVisible then
            hideWindow()
        else
            showWindow()
        end
    end
    
    -- Create Mobile Toggle after defining toggle function
    mobileToggle = CreateMobileToggle(ScreenGui, toggleWindow)
    
    -- Close Button Function
    CloseButton.MouseButton1Click:Connect(function()
        hideWindow()
    end)
    
    -- Dragging System
    local dragToggle = false
    local dragStart = nil
    local startPos = nil
    
    local function updateDrag(input)
        if not dragToggle or not dragStart or not startPos then return end
        
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        
        MainContainer.Position = newPosition
        Shadow.Position = UDim2.new(newPosition.X.Scale, newPosition.X.Offset + 5, 
                                   newPosition.Y.Scale, newPosition.Y.Offset + 5)
    end
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            dragToggle = true
            dragStart = input.Position
            startPos = MainContainer.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragToggle then
                updateDrag(input)
            end
        end
    end)
    
    -- Window Object
    local Window = {
        Visible = false,
        Container = MainContainer,
        ContentArea = ContentArea
    }
    
    -- Window Methods
    function Window:Show()
        showWindow()
        self.Visible = true
    end
    
    function Window:Hide()
        hideWindow()
        self.Visible = false
    end
    
    function Window:Toggle()
        toggleWindow()
        self.Visible = UIVisible
    end
    
    function Window:SetTitle(newTitle)
        TitleLabel.Text = newTitle
    end
    
    function Window:Destroy()
        ScreenGui:Destroy()
    end
    
    -- UI Elements Creation Functions
    function Window:CreateSection(text)
        local Section = Instance.new("Frame")
        Section.Parent = ContentArea
        Section.BackgroundColor3 = currentTheme.Surface
        Section.BorderSizePixel = 0
        Section.Size = UDim2.new(1, 0, 0, 50)
        Section.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 12)
        sectionCorner.Parent = Section
        
        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.Parent = Section
        sectionTitle.BackgroundTransparency = 1
        sectionTitle.Position = UDim2.new(0, 15, 0, 0)
        sectionTitle.Size = UDim2.new(1, -30, 1, 0)
        sectionTitle.Font = Enum.Font.GothamBold
        sectionTitle.Text = text
        sectionTitle.TextColor3 = currentTheme.Primary
        sectionTitle.TextSize = 16
        sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionTitle.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        return Section
    end
    
    function Window:CreateButton(text, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = ContentArea
        Button.BackgroundColor3 = currentTheme.Primary
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(1, 0, 0, 40)
        Button.Font = Enum.Font.GothamSemibold
        Button.Text = text
        Button.TextColor3 = currentTheme.Text
        Button.TextSize = 14
        Button.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = Button
        
        Button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        Button.MouseEnter:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(
                    math.min(255, currentTheme.Primary.R * 255 + 20),
                    math.min(255, currentTheme.Primary.G * 255 + 20),
                    math.min(255, currentTheme.Primary.B * 255 + 20)
                )
            }):Play()
        end)
        
        Button.MouseLeave:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = currentTheme.Primary
            }):Play()
        end)
        
        return Button
    end
    
    function Window:CreateToggle(text, defaultValue, callback)
        defaultValue = defaultValue or false
        
        local Toggle = Instance.new("Frame")
        Toggle.Parent = ContentArea
        Toggle.BackgroundColor3 = currentTheme.Surface
        Toggle.BorderSizePixel = 0
        Toggle.Size = UDim2.new(1, 0, 0, 50)
        Toggle.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 12)
        toggleCorner.Parent = Toggle
        
        local toggleLabel = Instance.new("TextLabel")
        toggleLabel.Parent = Toggle
        toggleLabel.BackgroundTransparency = 1
        toggleLabel.Position = UDim2.new(0, 15, 0, 0)
        toggleLabel.Size = UDim2.new(1, -80, 1, 0)
        toggleLabel.Font = Enum.Font.GothamSemibold
        toggleLabel.Text = text
        toggleLabel.TextColor3 = currentTheme.Text
        toggleLabel.TextSize = 14
        toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        toggleLabel.TextYAlignment = Enum.TextYAlignment.Center
        toggleLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Parent = Toggle
        toggleButton.BackgroundColor3 = defaultValue and currentTheme.Success or Color3.fromRGB(60, 60, 70)
        toggleButton.Position = UDim2.new(1, -55, 0.5, -12)
        toggleButton.Size = UDim2.new(0, 45, 0, 24)
        toggleButton.Text = ""
        toggleButton.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local toggleButtonCorner = Instance.new("UICorner")
        toggleButtonCorner.CornerRadius = UDim.new(1, 0)
        toggleButtonCorner.Parent = toggleButton
        
        local toggleIndicator = Instance.new("Frame")
        toggleIndicator.Parent = toggleButton
        toggleIndicator.BackgroundColor3 = currentTheme.Text
        toggleIndicator.Position = defaultValue and UDim2.new(0, 24, 0, 3) or UDim2.new(0, 3, 0, 3)
        toggleIndicator.Size = UDim2.new(0, 18, 0, 18)
        toggleIndicator.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(1, 0)
        indicatorCorner.Parent = toggleIndicator
        
        local toggled = defaultValue
        
        toggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            
            if toggled then
                TweenService:Create(toggleButton, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    BackgroundColor3 = currentTheme.Success
                }):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    Position = UDim2.new(0, 24, 0, 3)
                }):Play()
            else
                TweenService:Create(toggleButton, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                }):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(Fin12nLib.Config.Animation.Speed), {
                    Position = UDim2.new(0, 3, 0, 3)
                }):Play()
            end
            
            if callback then callback(toggled) end
        end)
        
        return Toggle, function() return toggled end
    end
    
    function Window:CreateSlider(text, min, max, defaultValue, callback)
        min = min or 0
        max = max or 100
        defaultValue = defaultValue or min
        
        local Slider = Instance.new("Frame")
        Slider.Parent = ContentArea
        Slider.BackgroundColor3 = currentTheme.Surface
        Slider.BorderSizePixel = 0
        Slider.Size = UDim2.new(1, 0, 0, 70)
        Slider.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 12)
        sliderCorner.Parent = Slider
        
        local sliderLabel = Instance.new("TextLabel")
        sliderLabel.Parent = Slider
        sliderLabel.BackgroundTransparency = 1
        sliderLabel.Position = UDim2.new(0, 15, 0, 5)
        sliderLabel.Size = UDim2.new(1, -80, 0, 25)
        sliderLabel.Font = Enum.Font.GothamSemibold
        sliderLabel.Text = text
        sliderLabel.TextColor3 = currentTheme.Text
        sliderLabel.TextSize = 14
        sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        sliderLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sliderValue = Instance.new("TextLabel")
        sliderValue.Parent = Slider
        sliderValue.BackgroundTransparency = 1
        sliderValue.Position = UDim2.new(1, -65, 0, 5)
        sliderValue.Size = UDim2.new(0, 50, 0, 25)
        sliderValue.Font = Enum.Font.GothamBold
        sliderValue.Text = tostring(defaultValue)
        sliderValue.TextColor3 = currentTheme.Primary
        sliderValue.TextSize = 14
        sliderValue.TextXAlignment = Enum.TextXAlignment.Right
        sliderValue.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local sliderTrack = Instance.new("Frame")
        sliderTrack.Parent = Slider
        sliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        sliderTrack.Position = UDim2.new(0, 15, 0, 40)
        sliderTrack.Size = UDim2.new(1, -30, 0, 20)
        sliderTrack.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local trackCorner = Instance.new("UICorner")
        trackCorner.CornerRadius = UDim.new(1, 0)
        trackCorner.Parent = sliderTrack
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Parent = sliderTrack
        sliderFill.BackgroundColor3 = currentTheme.Primary
        sliderFill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
        sliderFill.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(1, 0)
        fillCorner.Parent = sliderFill
        
        local sliderHandle = Instance.new("Frame")
        sliderHandle.Parent = sliderTrack
        sliderHandle.BackgroundColor3 = currentTheme.Text
        sliderHandle.Position = UDim2.new((defaultValue - min) / (max - min), -8, 0, -2)
        sliderHandle.Size = UDim2.new(0, 16, 0, 24)
        sliderHandle.ZIndex = Fin12nLib.Config.ZIndex.Base + 1
        
        local handleCorner = Instance.new("UICorner")
        handleCorner.CornerRadius = UDim.new(0, 8)
        handleCorner.Parent = sliderHandle
        
        local dragging = false
        local currentValue = defaultValue
        
        sliderTrack.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local mousePos = UIS:GetMouseLocation()
                if input.UserInputType == Enum.UserInputType.Touch then
                    mousePos = input.Position
                end
                
                local sliderPos = sliderTrack.AbsolutePosition
                local sliderSize = sliderTrack.AbsoluteSize
                local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
                
                currentValue = min + (max - min) * relativeX
                if max - min <= 10 then
                    currentValue = math.floor(currentValue * 10) / 10
                else
                    currentValue = math.floor(currentValue)
                end
                
                sliderValue.Text = tostring(currentValue)
                
                TweenService:Create(sliderFill, TweenInfo.new(0.1), {
                    Size = UDim2.new(relativeX, 0, 1, 0)
                }):Play()
                TweenService:Create(sliderHandle, TweenInfo.new(0.1), {
                    Position = UDim2.new(relativeX, -8, 0, -2)
                }):Play()
                
                if callback then callback(currentValue) end
            end
        end)
        
        return Slider, function() return currentValue end
    end
    
    function Window:CreateTextBox(text, placeholder, callback)
        placeholder = placeholder or "Enter text..."
        
        local TextBox = Instance.new("Frame")
        TextBox.Parent = ContentArea
        TextBox.BackgroundColor3 = currentTheme.Surface
        TextBox.BorderSizePixel = 0
        TextBox.Size = UDim2.new(1, 0, 0, 70)
        TextBox.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local textboxCorner = Instance.new("UICorner")
        textboxCorner.CornerRadius = UDim.new(0, 12)
        textboxCorner.Parent = TextBox
        
        local textboxLabel = Instance.new("TextLabel")
        textboxLabel.Parent = TextBox
        textboxLabel.BackgroundTransparency = 1
        textboxLabel.Position = UDim2.new(0, 15, 0, 5)
        textboxLabel.Size = UDim2.new(1, -30, 0, 25)
        textboxLabel.Font = Enum.Font.GothamSemibold
        textboxLabel.Text = text
        textboxLabel.TextColor3 = currentTheme.Text
        textboxLabel.TextSize = 14
        textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
        textboxLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local textInput = Instance.new("TextBox")
        textInput.Parent = TextBox
        textInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        textInput.BorderSizePixel = 0
        textInput.Position = UDim2.new(0, 15, 0, 35)
        textInput.Size = UDim2.new(1, -30, 0, 25)
        textInput.Font = Enum.Font.Gotham
        textInput.PlaceholderText = placeholder
        textInput.Text = ""
        textInput.TextColor3 = currentTheme.Text
        textInput.TextSize = 12
        textInput.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 6)
        inputCorner.Parent = textInput
        
        if callback then
            textInput.FocusLost:Connect(function(enterPressed)
                callback(textInput.Text, enterPressed)
            end)
        end
        
        return TextBox, textInput
    end
    
    function Window:CreateLabel(text, size)
        size = size or 14
        
        local Label = Instance.new("TextLabel")
        Label.Parent = ContentArea
        Label.BackgroundColor3 = currentTheme.Surface
        Label.BorderSizePixel = 0
        Label.Size = UDim2.new(1, 0, 0, 35)
        Label.Font = Enum.Font.Gotham
        Label.Text = text
        Label.TextColor3 = currentTheme.TextSecondary
        Label.TextSize = size
        Label.TextWrapped = true
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.TextYAlignment = Enum.TextYAlignment.Center
        Label.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local labelCorner = Instance.new("UICorner")
        labelCorner.CornerRadius = UDim.new(0, 10)
        labelCorner.Parent = Label
        
        local labelPadding = Instance.new("UIPadding")
        labelPadding.PaddingLeft = UDim.new(0, 15)
        labelPadding.PaddingRight = UDim.new(0, 15)
        labelPadding.Parent = Label
        
        return Label
    end
    
    function Window:CreateLine()
        local Line = Instance.new("Frame")
        Line.Parent = ContentArea
        Line.BackgroundColor3 = currentTheme.Primary
        Line.BorderSizePixel = 0
        Line.Size = UDim2.new(1, 0, 0, 2)
        Line.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local lineCorner = Instance.new("UICorner")
        lineCorner.CornerRadius = UDim.new(1, 0)
        lineCorner.Parent = Line
        
        return Line
    end
    
    function Window:CreateImageLabel(imageId, size)
        size = size or UDim2.new(1, 0, 0, 100)
        
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Parent = ContentArea
        ImageLabel.BackgroundColor3 = currentTheme.Surface
        ImageLabel.BorderSizePixel = 0
        ImageLabel.Size = size
        ImageLabel.Image = "rbxassetid://" .. tostring(imageId)
        ImageLabel.ScaleType = Enum.ScaleType.Fit
        ImageLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local imageCorner = Instance.new("UICorner")
        imageCorner.CornerRadius = UDim.new(0, 12)
        imageCorner.Parent = ImageLabel
        
        return ImageLabel
    end
    
    return Window
end

-- Example Usage and Theme Presets
Fin12nLib.Themes = {
    Default = Fin12nLib.Config.DefaultTheme,
    
    Dark = {
        Primary = Color3.fromRGB(88, 101, 242),
        Secondary = Color3.fromRGB(70, 80, 200),
        Background = Color3.fromRGB(16, 16, 20),
        Surface = Color3.fromRGB(25, 25, 30),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(237, 66, 69),
        Info = Color3.fromRGB(88, 101, 242)
    },
    
    Purple = {
        Primary = Color3.fromRGB(138, 43, 226),
        Secondary = Color3.fromRGB(123, 31, 162),
        Background = Color3.fromRGB(18, 10, 25),
        Surface = Color3.fromRGB(30, 20, 40),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(200, 180, 220),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(245, 158, 11),
        Error = Color3.fromRGB(239, 68, 68),
        Info = Color3.fromRGB(138, 43, 226)
    },
    
    Green = {
        Primary = Color3.fromRGB(34, 197, 94),
        Secondary = Color3.fromRGB(22, 163, 74),
        Background = Color3.fromRGB(10, 20, 15),
        Surface = Color3.fromRGB(20, 35, 25),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 220, 190),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(245, 158, 11),
        Error = Color3.fromRGB(239, 68, 68),
        Info = Color3.fromRGB(59, 130, 246)
    },
    
    Orange = {
        Primary = Color3.fromRGB(249, 115, 22),
        Secondary = Color3.fromRGB(234, 88, 12),
        Background = Color3.fromRGB(25, 15, 10),
        Surface = Color3.fromRGB(40, 25, 15),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(220, 190, 180),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(249, 115, 22),
        Error = Color3.fromRGB(239, 68, 68),
        Info = Color3.fromRGB(59, 130, 246)
    }
}

return Fin12nLib
