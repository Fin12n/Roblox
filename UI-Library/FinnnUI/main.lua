-- RobloxUI Library v1.0
-- Tạo bởi: AI Assistant
-- Mục đích: Phi lợi nhuận

local RobloxUI = {}
RobloxUI.__index = RobloxUI

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Themes
local Themes = {
    Dark = {
        Background = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(30, 30, 35),
        Accent = Color3.fromRGB(100, 100, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        Border = Color3.fromRGB(50, 50, 55),
        Success = Color3.fromRGB(0, 200, 100),
        Warning = Color3.fromRGB(255, 165, 0),
        Error = Color3.fromRGB(255, 50, 50)
    },
    Light = {
        Background = Color3.fromRGB(245, 245, 250),
        Secondary = Color3.fromRGB(235, 235, 240),
        Accent = Color3.fromRGB(0, 122, 255),
        Text = Color3.fromRGB(20, 20, 25),
        TextSecondary = Color3.fromRGB(100, 100, 105),
        Border = Color3.fromRGB(200, 200, 205),
        Success = Color3.fromRGB(52, 199, 89),
        Warning = Color3.fromRGB(255, 149, 0),
        Error = Color3.fromRGB(255, 59, 48)
    }
}

-- Icon Library (Lucide Icons style)
local Icons = {
    ["home"] = "rbxassetid://10734884548",
    ["settings"] = "rbxassetid://10734886202",
    ["user"] = "rbxassetid://10734896144",
    ["search"] = "rbxassetid://10734885558",
    ["plus"] = "rbxassetid://10734884643",
    ["minus"] = "rbxassetid://10734884606",
    ["check"] = "rbxassetid://10734884234",
    ["x"] = "rbxassetid://10734886843",
    ["arrow-right"] = "rbxassetid://10734884542",
    ["arrow-left"] = "rbxassetid://10734884522",
    ["eye"] = "rbxassetid://10734885019",
    ["eye-off"] = "rbxassetid://10734884969",
    ["lock"] = "rbxassetid://10734885302",
    ["unlock"] = "rbxassetid://10734886441",
    ["moon"] = "rbxassetid://10734885486",
    ["sun"] = "rbxassetid://10734886149"
}

-- Utility Functions
local function CreateTween(object, info, properties)
    local tween = TweenService:Create(object, info, properties)
    tween:Play()
    return tween
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(50, 50, 55)
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

-- Loader System
function RobloxUI:CreateLoader(config)
    config = config or {}
    local title = config.Title or "Loading..."
    local subtitle = config.Subtitle or "Please wait"
    
    -- Create Loader GUI
    local LoaderGui = Instance.new("ScreenGui")
    LoaderGui.Name = "RobloxUI_Loader"
    LoaderGui.Parent = PlayerGui
    LoaderGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.3
    Background.BorderSizePixel = 0
    Background.Parent = LoaderGui
    
    local LoaderFrame = Instance.new("Frame")
    LoaderFrame.Name = "LoaderFrame"
    LoaderFrame.Size = UDim2.new(0, 300, 0, 200)
    LoaderFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    LoaderFrame.BackgroundColor3 = self.CurrentTheme.Background
    LoaderFrame.BorderSizePixel = 0
    LoaderFrame.Parent = Background
    
    CreateCorner(LoaderFrame, 16)
    CreateStroke(LoaderFrame, self.CurrentTheme.Border, 1)
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -40, 0, 30)
    TitleLabel.Position = UDim2.new(0, 20, 0, 30)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = self.CurrentTheme.Text
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    TitleLabel.Parent = LoaderFrame
    
    -- Subtitle
    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Name = "Subtitle"
    SubtitleLabel.Size = UDim2.new(1, -40, 0, 20)
    SubtitleLabel.Position = UDim2.new(0, 20, 0, 65)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = subtitle
    SubtitleLabel.TextColor3 = self.CurrentTheme.TextSecondary
    SubtitleLabel.TextSize = 14
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    SubtitleLabel.Parent = LoaderFrame
    
    -- Progress Bar
    local ProgressContainer = Instance.new("Frame")
    ProgressContainer.Name = "ProgressContainer"
    ProgressContainer.Size = UDim2.new(1, -60, 0, 6)
    ProgressContainer.Position = UDim2.new(0, 30, 0, 120)
    ProgressContainer.BackgroundColor3 = self.CurrentTheme.Secondary
    ProgressContainer.BorderSizePixel = 0
    ProgressContainer.Parent = LoaderFrame
    
    CreateCorner(ProgressContainer, 3)
    
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    ProgressBar.Position = UDim2.new(0, 0, 0, 0)
    ProgressBar.BackgroundColor3 = self.CurrentTheme.Accent
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Parent = ProgressContainer
    
    CreateCorner(ProgressBar, 3)
    
    -- Spinning Icon
    local SpinIcon = Instance.new("ImageLabel")
    SpinIcon.Name = "SpinIcon"
    SpinIcon.Size = UDim2.new(0, 24, 0, 24)
    SpinIcon.Position = UDim2.new(0.5, -12, 0, 150)
    SpinIcon.BackgroundTransparency = 1
    SpinIcon.Image = Icons["settings"] or ""
    SpinIcon.ImageColor3 = self.CurrentTheme.Accent
    SpinIcon.Parent = LoaderFrame
    
    -- Animate spinning icon
    local spinTween = TweenService:Create(SpinIcon, 
        TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
        {Rotation = 360}
    )
    spinTween:Play()
    
    -- Animation entrance
    LoaderFrame.Size = UDim2.new(0, 0, 0, 0)
    CreateTween(LoaderFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 300, 0, 200)}
    )
    
    return {
        Gui = LoaderGui,
        SetProgress = function(progress)
            CreateTween(ProgressBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {Size = UDim2.new(progress / 100, 0, 1, 0)}
            )
        end,
        UpdateText = function(newTitle, newSubtitle)
            TitleLabel.Text = newTitle or TitleLabel.Text
            SubtitleLabel.Text = newSubtitle or SubtitleLabel.Text
        end,
        Close = function()
            CreateTween(LoaderFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 0)}
            )
            wait(0.3)
            LoaderGui:Destroy()
        end
    }
end

-- Key System
function RobloxUI:CreateKeySystem(config)
    config = config or {}
    local validKeys = config.Keys or {"test123"}
    local title = config.Title or "Key System"
    local subtitle = config.Subtitle or "Enter your key to continue"
    local callback = config.Callback or function() end
    
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "RobloxUI_KeySystem"
    KeyGui.Parent = PlayerGui
    KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.3
    Background.BorderSizePixel = 0
    Background.Parent = KeyGui
    
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Size = UDim2.new(0, 400, 0, 250)
    KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    KeyFrame.BackgroundColor3 = self.CurrentTheme.Background
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Parent = Background
    
    CreateCorner(KeyFrame, 16)
    CreateStroke(KeyFrame, self.CurrentTheme.Border)
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -40, 0, 30)
    TitleLabel.Position = UDim2.new(0, 20, 0, 20)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = self.CurrentTheme.Text
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    TitleLabel.Parent = KeyFrame
    
    -- Subtitle
    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Name = "Subtitle"
    SubtitleLabel.Size = UDim2.new(1, -40, 0, 20)
    SubtitleLabel.Position = UDim2.new(0, 20, 0, 55)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = subtitle
    SubtitleLabel.TextColor3 = self.CurrentTheme.TextSecondary
    SubtitleLabel.TextSize = 14
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    SubtitleLabel.Parent = KeyFrame
    
    -- Key TextBox
    local KeyTextBox = Instance.new("TextBox")
    KeyTextBox.Name = "KeyTextBox"
    KeyTextBox.Size = UDim2.new(1, -60, 0, 40)
    KeyTextBox.Position = UDim2.new(0, 30, 0, 100)
    KeyTextBox.BackgroundColor3 = self.CurrentTheme.Secondary
    KeyTextBox.BorderSizePixel = 0
    KeyTextBox.Text = ""
    KeyTextBox.PlaceholderText = "Enter key here..."
    KeyTextBox.TextColor3 = self.CurrentTheme.Text
    KeyTextBox.PlaceholderColor3 = self.CurrentTheme.TextSecondary
    KeyTextBox.TextSize = 14
    KeyTextBox.Font = Enum.Font.Gotham
    KeyTextBox.TextXAlignment = Enum.TextXAlignment.Center
    KeyTextBox.Parent = KeyFrame
    
    CreateCorner(KeyTextBox, 8)
    
    -- Submit Button
    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Name = "SubmitButton"
    SubmitButton.Size = UDim2.new(0, 120, 0, 35)
    SubmitButton.Position = UDim2.new(0.5, -60, 0, 170)
    SubmitButton.BackgroundColor3 = self.CurrentTheme.Accent
    SubmitButton.BorderSizePixel = 0
    SubmitButton.Text = "Submit"
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.TextSize = 14
    SubmitButton.Font = Enum.Font.GothamBold
    SubmitButton.Parent = KeyFrame
    
    CreateCorner(SubmitButton, 8)
    
    -- Error Label
    local ErrorLabel = Instance.new("TextLabel")
    ErrorLabel.Name = "ErrorLabel"
    ErrorLabel.Size = UDim2.new(1, -40, 0, 20)
    ErrorLabel.Position = UDim2.new(0, 20, 0, 220)
    ErrorLabel.BackgroundTransparency = 1
    ErrorLabel.Text = ""
    ErrorLabel.TextColor3 = self.CurrentTheme.Error
    ErrorLabel.TextSize = 12
    ErrorLabel.Font = Enum.Font.Gotham
    ErrorLabel.TextXAlignment = Enum.TextXAlignment.Center
    ErrorLabel.Parent = KeyFrame
    
    -- Button functionality
    local function validateKey()
        local enteredKey = KeyTextBox.Text
        local isValid = false
        
        for _, key in ipairs(validKeys) do
            if enteredKey == key then
                isValid = true
                break
            end
        end
        
        if isValid then
            ErrorLabel.Text = "✓ Key accepted!"
            ErrorLabel.TextColor3 = self.CurrentTheme.Success
            wait(0.5)
            
            CreateTween(KeyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 0)}
            )
            wait(0.3)
            KeyGui:Destroy()
            callback(true)
        else
            ErrorLabel.Text = "✗ Invalid key. Please try again."
            ErrorLabel.TextColor3 = self.CurrentTheme.Error
            
            -- Shake animation
            local originalPos = KeyFrame.Position
            for i = 1, 3 do
                CreateTween(KeyFrame, TweenInfo.new(0.1), {Position = originalPos + UDim2.new(0, 10, 0, 0)})
                wait(0.1)
                CreateTween(KeyFrame, TweenInfo.new(0.1), {Position = originalPos + UDim2.new(0, -10, 0, 0)})
                wait(0.1)
            end
            CreateTween(KeyFrame, TweenInfo.new(0.1), {Position = originalPos})
        end
    end
    
    SubmitButton.MouseButton1Click:Connect(validateKey)
    KeyTextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            validateKey()
        end
    end)
    
    -- Entrance animation
    KeyFrame.Size = UDim2.new(0, 0, 0, 0)
    CreateTween(KeyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 400, 0, 250)}
    )
end

-- Main UI Window
function RobloxUI:CreateWindow(config)
    config = config or {}
    
    self.CurrentTheme = Themes[config.Theme] or Themes.Dark
    
    local WindowConfig = {
        Name = config.Name or "RobloxUI Window",
        Size = config.Size or UDim2.new(0, 600, 0, 400),
        Theme = config.Theme or "Dark"
    }
    
    -- Create Main GUI
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "RobloxUI_Main"
    MainGui.Parent = PlayerGui
    MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    MainGui.ResetOnSpawn = false
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = WindowConfig.Size
    MainFrame.Position = UDim2.new(0.5, -WindowConfig.Size.X.Offset/2, 0.5, -WindowConfig.Size.Y.Offset/2)
    MainFrame.BackgroundColor3 = self.CurrentTheme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = MainGui
    
    CreateCorner(MainFrame, 12)
    CreateStroke(MainFrame, self.CurrentTheme.Border)
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = self.CurrentTheme.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    CreateCorner(TitleBar, 12)
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = WindowConfig.Name
    Title.TextColor3 = self.CurrentTheme.Text
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar
    
    -- Theme Toggle Button
    local ThemeButton = Instance.new("ImageButton")
    ThemeButton.Name = "ThemeButton"
    ThemeButton.Size = UDim2.new(0, 30, 0, 30)
    ThemeButton.Position = UDim2.new(1, -65, 0, 5)
    ThemeButton.BackgroundColor3 = self.CurrentTheme.Background
    ThemeButton.BorderSizePixel = 0
    ThemeButton.Image = Icons[WindowConfig.Theme == "Dark" and "sun" or "moon"] or ""
    ThemeButton.ImageColor3 = self.CurrentTheme.Text
    ThemeButton.Parent = TitleBar
    
    CreateCorner(ThemeButton, 6)
    
    -- Close Button
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 95, 86)
    CloseButton.BorderSizePixel = 0
    CloseButton.Image = Icons["x"] or ""
    CloseButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Parent = TitleBar
    
    CreateCorner(CloseButton, 6)
    
    -- Content Area
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -20, 1, -60)
    ContentFrame.Position = UDim2.new(0, 10, 0, 50)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.ScrollBarImageColor3 = self.CurrentTheme.Accent
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentFrame.Parent = MainFrame
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Name = "ContentLayout"
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 10)
    ContentLayout.Parent = ContentFrame
    
    -- Auto-resize canvas
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        wait(0.3)
        MainGui:Destroy()
    end)
    
    -- Theme toggle functionality
    ThemeButton.MouseButton1Click:Connect(function()
        if WindowConfig.Theme == "Dark" then
            WindowConfig.Theme = "Light"
            self.CurrentTheme = Themes.Light
            ThemeButton.Image = Icons["moon"] or ""
        else
            WindowConfig.Theme = "Dark"
            self.CurrentTheme = Themes.Dark
            ThemeButton.Image = Icons["sun"] or ""
        end
        
        -- Update all colors
        MainFrame.BackgroundColor3 = self.CurrentTheme.Background
        TitleBar.BackgroundColor3 = self.CurrentTheme.Secondary
        Title.TextColor3 = self.CurrentTheme.Text
        ThemeButton.BackgroundColor3 = self.CurrentTheme.Background
        ThemeButton.ImageColor3 = self.CurrentTheme.Text
        ContentFrame.ScrollBarImageColor3 = self.CurrentTheme.Accent
        
        -- Update stroke colors
        for _, obj in pairs(MainFrame:GetDescendants()) do
            if obj:IsA("UIStroke") then
                obj.Color = self.CurrentTheme.Border
            end
        end
    end)
    
    -- Entrance animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = WindowConfig.Size}
    )
    
    local Window = {
        MainFrame = MainFrame,
        ContentFrame = ContentFrame,
        CurrentTheme = self.CurrentTheme
    }
    
    -- Add Button
    function Window:AddButton(config)
        config = config or {}
        local buttonName = config.Name or "Button"
        local buttonCallback = config.Callback or function() end
        local buttonIcon = config.Icon
        
        local Button = Instance.new("TextButton")
        Button.Name = buttonName
        Button.Size = UDim2.new(1, -20, 0, 40)
        Button.BackgroundColor3 = self.CurrentTheme.Secondary
        Button.BorderSizePixel = 0
        Button.Text = buttonIcon and "" or buttonName
        Button.TextColor3 = self.CurrentTheme.Text
        Button.TextSize = 14
        Button.Font = Enum.Font.Gotham
        Button.Parent = ContentFrame
        
        CreateCorner(Button, 8)
        
        -- Icon + Text layout
        if buttonIcon then
            local Icon = Instance.new("ImageLabel")
            Icon.Name = "Icon"
            Icon.Size = UDim2.new(0, 20, 0, 20)
            Icon.Position = UDim2.new(0, 15, 0.5, -10)
            Icon.BackgroundTransparency = 1
            Icon.Image = Icons[buttonIcon] or buttonIcon
            Icon.ImageColor3 = self.CurrentTheme.Text
            Icon.Parent = Button
            
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Size = UDim2.new(1, -50, 1, 0)
            Label.Position = UDim2.new(0, 45, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = buttonName
            Label.TextColor3 = self.CurrentTheme.Text
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Button
        end
        
        -- Button effects
        Button.MouseEnter:Connect(function()
            CreateTween(Button, TweenInfo.new(0.2), {BackgroundColor3 = self.CurrentTheme.Accent})
        end)
        
        Button.MouseLeave:Connect(function()
            CreateTween(Button, TweenInfo.new(0.2), {BackgroundColor3 = self.CurrentTheme.Secondary})
        end)
        
        Button.MouseButton1Click:Connect(buttonCallback)
        
        return Button
    end
    
    -- Add Toggle
    function Window:AddToggle(config)
        config = config or {}
        local toggleName = config.Name or "Toggle"
        local toggleDefault = config.Default or false
        local toggleCallback = config.Callback or function() end
        
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Name = toggleName
        ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
        ToggleFrame.BackgroundColor3 = self.CurrentTheme.Secondary
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.Parent = ContentFrame
        
        CreateCorner(ToggleFrame, 8)
        
        local ToggleLabel = Instance.new("TextLabel")
        ToggleLabel.Name = "Label"
        ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
        ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.Text = toggleName
        ToggleLabel.TextColor3 = self.CurrentTheme.Text
        ToggleLabel.TextSize = 14
        ToggleLabel.Font = Enum.Font.Gotham
        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        ToggleLabel.Parent = ToggleFrame
        
        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Name = "ToggleButton"
        ToggleButton.Size = UDim2.new(0, 40, 0, 20)
        ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
        ToggleButton.BackgroundColor3 = toggleDefault and self.CurrentTheme.Accent or self.CurrentTheme.Border
        ToggleButton.BorderSizePixel = 0
        ToggleButton.Text = ""
        ToggleButton.Parent = ToggleFrame
        
        CreateCorner(ToggleButton, 10)
        
        local ToggleCircle = Instance.new("Frame")
        ToggleCircle.Name = "Circle"
        ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
        ToggleCircle.Position = toggleDefault and UDim2.new(0, 22, 0, 2) or UDim2.new(0, 2, 0, 2)
        ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleCircle.BorderSizePixel = 0
        ToggleCircle.Parent = ToggleButton
        
        CreateCorner(ToggleCircle, 8)
        
        local isToggled = toggleDefault
        
        ToggleButton.MouseButton1Click:Connect(function()
            isToggled = not isToggled
            
            CreateTween(ToggleButton, TweenInfo.new(0.3), {
                BackgroundColor3 = isToggled and self.CurrentTheme.Accent or self.CurrentTheme.Border
            })
            
            CreateTween(ToggleCircle, TweenInfo.new(0.3), {
                Position = isToggled and UDim2.new(0, 22, 0, 2) or UDim2.new(0, 2, 0, 2)
            })
            
            toggleCallback(isToggled)
        end)
        
        return {
            Frame = ToggleFrame,
            SetValue = function(value)
                isToggled = value
                ToggleButton.BackgroundColor3 = isToggled and self.CurrentTheme.Accent or self.CurrentTheme.Border
                ToggleCircle.Position = isToggled and UDim2.new(0, 22, 0, 2) or UDim2.new(0, 2, 0, 2)
            end,
            GetValue = function()
                return isToggled
            end
        }
    end
    
    -- Add Slider
    function Window:AddSlider(config)
        config = config or {}
        local sliderName = config.Name or "Slider"
        local sliderMin = config.Min or 0
        local sliderMax = config.Max or 100
        local sliderDefault = config.Default or sliderMin
        local sliderCallback = config.Callback or function() end
        
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Name = sliderName
        SliderFrame.Size = UDim2.new(1, -20, 0, 60)
        SliderFrame.BackgroundColor3 = self.CurrentTheme.Secondary
        SliderFrame.BorderSizePixel = 0
        SliderFrame.Parent = ContentFrame
        
        CreateCorner(SliderFrame, 8)
        
        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Name = "Label"
        SliderLabel.Size = UDim2.new(1, -80, 0, 25)
        SliderLabel.Position = UDim2.new(0, 15, 0, 5)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Text = sliderName
        SliderLabel.TextColor3 = self.CurrentTheme.Text
        SliderLabel.TextSize = 14
        SliderLabel.Font = Enum.Font.Gotham
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        SliderLabel.Parent = SliderFrame
        
        local ValueLabel = Instance.new("TextLabel")
        ValueLabel.Name = "ValueLabel"
        ValueLabel.Size = UDim2.new(0, 60, 0, 25)
        ValueLabel.Position = UDim2.new(1, -70, 0, 5)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Text = tostring(sliderDefault)
        ValueLabel.TextColor3 = self.CurrentTheme.Accent
        ValueLabel.TextSize = 14
        ValueLabel.Font = Enum.Font.GothamBold
        ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
        ValueLabel.Parent = SliderFrame
        
        local SliderTrack = Instance.new("Frame")
        SliderTrack.Name = "Track"
        SliderTrack.Size = UDim2.new(1, -30, 0, 4)
        SliderTrack.Position = UDim2.new(0, 15, 0, 40)
        SliderTrack.BackgroundColor3 = self.CurrentTheme.Border
        SliderTrack.BorderSizePixel = 0
        SliderTrack.Parent = SliderFrame
        
        CreateCorner(SliderTrack, 2)
        
        local SliderFill = Instance.new("Frame")
        SliderFill.Name = "Fill"
        SliderFill.Size = UDim2.new((sliderDefault - sliderMin) / (sliderMax - sliderMin), 0, 1, 0)
        SliderFill.Position = UDim2.new(0, 0, 0, 0)
        SliderFill.BackgroundColor3 = self.CurrentTheme.Accent
        SliderFill.BorderSizePixel = 0
        SliderFill.Parent = SliderTrack
        
        CreateCorner(SliderFill, 2)
        
        local SliderKnob = Instance.new("Frame")
        SliderKnob.Name = "Knob"
        SliderKnob.Size = UDim2.new(0, 16, 0, 16)
        SliderKnob.Position = UDim2.new((sliderDefault - sliderMin) / (sliderMax - sliderMin), -8, 0, -6)
        SliderKnob.BackgroundColor3 = self.CurrentTheme.Accent
        SliderKnob.BorderSizePixel = 0
        SliderKnob.Parent = SliderTrack
        
        CreateCorner(SliderKnob, 8)
        
        local dragging = false
        local currentValue = sliderDefault
        
        SliderKnob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mouse = Players.LocalPlayer:GetMouse()
                local trackStart = SliderTrack.AbsolutePosition.X
                local trackEnd = trackStart + SliderTrack.AbsoluteSize.X
                local mousePos = math.clamp(mouse.X, trackStart, trackEnd)
                
                local percentage = (mousePos - trackStart) / SliderTrack.AbsoluteSize.X
                currentValue = math.floor(sliderMin + (sliderMax - sliderMin) * percentage)
                
                ValueLabel.Text = tostring(currentValue)
                SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                SliderKnob.Position = UDim2.new(percentage, -8, 0, -6)
                
                sliderCallback(currentValue)
            end
        end)
        
        return {
            Frame = SliderFrame,
            SetValue = function(value)
                currentValue = math.clamp(value, sliderMin, sliderMax)
                local percentage = (currentValue - sliderMin) / (sliderMax - sliderMin)
                ValueLabel.Text = tostring(currentValue)
                SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                SliderKnob.Position = UDim2.new(percentage, -8, 0, -6)
            end,
            GetValue = function()
                return currentValue
            end
        }
    end
    
    -- Add TextBox
    function Window:AddTextBox(config)
        config = config or {}
        local textboxName = config.Name or "TextBox"
        local textboxPlaceholder = config.Placeholder or "Enter text..."
        local textboxDefault = config.Default or ""
        local textboxCallback = config.Callback or function() end
        
        local TextBoxFrame = Instance.new("Frame")
        TextBoxFrame.Name = textboxName
        TextBoxFrame.Size = UDim2.new(1, -20, 0, 60)
        TextBoxFrame.BackgroundColor3 = self.CurrentTheme.Secondary
        TextBoxFrame.BorderSizePixel = 0
        TextBoxFrame.Parent = ContentFrame
        
        CreateCorner(TextBoxFrame, 8)
        
        local TextBoxLabel = Instance.new("TextLabel")
        TextBoxLabel.Name = "Label"
        TextBoxLabel.Size = UDim2.new(1, -20, 0, 25)
        TextBoxLabel.Position = UDim2.new(0, 15, 0, 5)
        TextBoxLabel.BackgroundTransparency = 1
        TextBoxLabel.Text = textboxName
        TextBoxLabel.TextColor3 = self.CurrentTheme.Text
        TextBoxLabel.TextSize = 14
        TextBoxLabel.Font = Enum.Font.Gotham
        TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextBoxLabel.Parent = TextBoxFrame
        
        local TextBox = Instance.new("TextBox")
        TextBox.Name = "TextBox"
        TextBox.Size = UDim2.new(1, -30, 0, 25)
        TextBox.Position = UDim2.new(0, 15, 0, 30)
        TextBox.BackgroundColor3 = self.CurrentTheme.Background
        TextBox.BorderSizePixel = 0
        TextBox.Text = textboxDefault
        TextBox.PlaceholderText = textboxPlaceholder
        TextBox.TextColor3 = self.CurrentTheme.Text
        TextBox.PlaceholderColor3 = self.CurrentTheme.TextSecondary
        TextBox.TextSize = 12
        TextBox.Font = Enum.Font.Gotham
        TextBox.TextXAlignment = Enum.TextXAlignment.Left
        TextBox.Parent = TextBoxFrame
        
        CreateCorner(TextBox, 6)
        CreateStroke(TextBox, self.CurrentTheme.Border)
        
        TextBox.FocusLost:Connect(function()
            textboxCallback(TextBox.Text)
        end)
        
        return {
            Frame = TextBoxFrame,
            SetText = function(text)
                TextBox.Text = text
            end,
            GetText = function()
                return TextBox.Text
            end
        }
    end
    
    -- Add Label
    function Window:AddLabel(config)
        config = config or {}
        local labelText = config.Text or "Label"
        local labelIcon = config.Icon
        
        local LabelFrame = Instance.new("Frame")
        LabelFrame.Name = "Label"
        LabelFrame.Size = UDim2.new(1, -20, 0, 30)
        LabelFrame.BackgroundTransparency = 1
        LabelFrame.BorderSizePixel = 0
        LabelFrame.Parent = ContentFrame
        
        if labelIcon then
            local Icon = Instance.new("ImageLabel")
            Icon.Name = "Icon"
            Icon.Size = UDim2.new(0, 20, 0, 20)
            Icon.Position = UDim2.new(0, 0, 0, 5)
            Icon.BackgroundTransparency = 1
            Icon.Image = Icons[labelIcon] or labelIcon
            Icon.ImageColor3 = self.CurrentTheme.Text
            Icon.Parent = LabelFrame
            
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Size = UDim2.new(1, -30, 1, 0)
            Label.Position = UDim2.new(0, 30, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = labelText
            Label.TextColor3 = self.CurrentTheme.Text
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = LabelFrame
        else
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.Position = UDim2.new(0, 0, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = labelText
            Label.TextColor3 = self.CurrentTheme.Text
            Label.TextSize = 14
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = LabelFrame
        end
        
        return {
            Frame = LabelFrame,
            SetText = function(text)
                LabelFrame.Label.Text = text
            end
        }
    end
    
    -- Add Dropdown
    function Window:AddDropdown(config)
        config = config or {}
        local dropdownName = config.Name or "Dropdown"
        local dropdownOptions = config.Options or {"Option 1", "Option 2", "Option 3"}
        local dropdownDefault = config.Default or dropdownOptions[1]
        local dropdownCallback = config.Callback or function() end
        
        local DropdownFrame = Instance.new("Frame")
        DropdownFrame.Name = dropdownName
        DropdownFrame.Size = UDim2.new(1, -20, 0, 40)
        DropdownFrame.BackgroundColor3 = self.CurrentTheme.Secondary
        DropdownFrame.BorderSizePixel = 0
        DropdownFrame.Parent = ContentFrame
        
        CreateCorner(DropdownFrame, 8)
        
        local DropdownButton = Instance.new("TextButton")
        DropdownButton.Name = "DropdownButton"
        DropdownButton.Size = UDim2.new(1, 0, 1, 0)
        DropdownButton.BackgroundTransparency = 1
        DropdownButton.Text = ""
        DropdownButton.Parent = DropdownFrame
        
        local DropdownLabel = Instance.new("TextLabel")
        DropdownLabel.Name = "Label"
        DropdownLabel.Size = UDim2.new(1, -50, 1, 0)
        DropdownLabel.Position = UDim2.new(0, 15, 0, 0)
        DropdownLabel.BackgroundTransparency = 1
        DropdownLabel.Text = dropdownName .. ": " .. dropdownDefault
        DropdownLabel.TextColor3 = self.CurrentTheme.Text
        DropdownLabel.TextSize = 14
        DropdownLabel.Font = Enum.Font.Gotham
        DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
        DropdownLabel.Parent = DropdownFrame
        
        local DropdownArrow = Instance.new("ImageLabel")
        DropdownArrow.Name = "Arrow"
        DropdownArrow.Size = UDim2.new(0, 20, 0, 20)
        DropdownArrow.Position = UDim2.new(1, -35, 0.5, -10)
        DropdownArrow.BackgroundTransparency = 1
        DropdownArrow.Image = Icons["arrow-right"] or ""
        DropdownArrow.ImageColor3 = self.CurrentTheme.Text
        DropdownArrow.Rotation = 90
        DropdownArrow.Parent = DropdownFrame
        
        local DropdownList = Instance.new("Frame")
        DropdownList.Name = "DropdownList"
        DropdownList.Size = UDim2.new(1, 0, 0, #dropdownOptions * 30)
        DropdownList.Position = UDim2.new(0, 0, 1, 5)
        DropdownList.BackgroundColor3 = self.CurrentTheme.Background
        DropdownList.BorderSizePixel = 0
        DropdownList.Visible = false
        DropdownList.ZIndex = 10
        DropdownList.Parent = DropdownFrame
        
        CreateCorner(DropdownList, 8)
        CreateStroke(DropdownList, self.CurrentTheme.Border)
        
        local ListLayout = Instance.new("UIListLayout")
        ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ListLayout.Parent = DropdownList
        
        local currentValue = dropdownDefault
        local isOpen = false
        
        for i, option in ipairs(dropdownOptions) do
            local OptionButton = Instance.new("TextButton")
            OptionButton.Name = "Option_" .. i
            OptionButton.Size = UDim2.new(1, 0, 0, 30)
            OptionButton.BackgroundColor3 = option == currentValue and self.CurrentTheme.Accent or Color3.fromRGB(0, 0, 0, 0)
            OptionButton.BackgroundTransparency = option == currentValue and 0 or 1
            OptionButton.BorderSizePixel = 0
            OptionButton.Text = option
            OptionButton.TextColor3 = self.CurrentTheme.Text
            OptionButton.TextSize = 12
            OptionButton.Font = Enum.Font.Gotham
            OptionButton.Parent = DropdownList
            
            OptionButton.MouseEnter:Connect(function()
                if option ~= currentValue then
                    CreateTween(OptionButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.8})
                end
            end)
            
            OptionButton.MouseLeave:Connect(function()
                if option ~= currentValue then
                    CreateTween(OptionButton, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                end
            end)
            
            OptionButton.MouseButton1Click:Connect(function()
                currentValue = option
                DropdownLabel.Text = dropdownName .. ": " .. option
                
                -- Update selected styling
                for _, child in pairs(DropdownList:GetChildren()) do
                    if child:IsA("TextButton") then
                        child.BackgroundColor3 = child.Text == option and self.CurrentTheme.Accent or Color3.fromRGB(0, 0, 0, 0)
                        child.BackgroundTransparency = child.Text == option and 0 or 1
                    end
                end
                
                -- Close dropdown
                isOpen = false
                DropdownList.Visible = false
                CreateTween(DropdownArrow, TweenInfo.new(0.2), {Rotation = 90})
                
                dropdownCallback(option)
            end)
        end
        
        DropdownButton.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            DropdownList.Visible = isOpen
            CreateTween(DropdownArrow, TweenInfo.new(0.2), {Rotation = isOpen and 270 or 90})
        end)
        
        return {
            Frame = DropdownFrame,
            SetValue = function(value)
                if table.find(dropdownOptions, value) then
                    currentValue = value
                    DropdownLabel.Text = dropdownName .. ": " .. value
                end
            end,
            GetValue = function()
                return currentValue
            end
        }
    end
    
    return Window
end

-- Initialize Library
function RobloxUI:Init(config)
    config = config or {}
    
    -- Show loader if enabled
    if config.ShowLoader ~= false then
        local loader = self:CreateLoader({
            Title = config.LoaderTitle or "RobloxUI",
            Subtitle = config.LoaderSubtitle or "Initializing..."
        })
        
        -- Simulate loading
        for i = 0, 100, 10 do
            loader.SetProgress(i)
            wait(0.1)
        end
        
        wait(0.5)
        loader.Close()
    end
    
    -- Show key system if keys provided
    if config.Keys then
        self:CreateKeySystem({
            Keys = config.Keys,
            Title = config.KeyTitle or "Authentication",
            Subtitle = config.KeySubtitle or "Enter your access key",
            Callback = config.KeyCallback or function(success)
                if success and config.MainCallback then
                    config.MainCallback()
                end
            end
        })
    elseif config.MainCallback then
        config.MainCallback()
    end
    
    return self
end

-- Export Library
return FinnnUI

--[[
USAGE EXAMPLE:

local FinnnUI = loadstring(game:HttpGet("your_script_url"))()

-- Initialize with loader and key system
FinnnUI:Init({
    ShowLoader = true,
    LoaderTitle = "My Script",
    LoaderSubtitle = "Loading components...",
    Keys = {"key1", "key2", "key3"},
    KeyTitle = "Access Control",
    KeySubtitle = "Enter your premium key",
    MainCallback = function()
        -- Create main window after authentication
        local Window = FinnnUI:CreateWindow({
            Name = "My Amazing Script",
            Size = UDim2.new(0, 600, 0, 400),
            Theme = "Dark"
        })
        
        -- Add components
        Window:AddLabel({Text = "Welcome to my script!", Icon = "home"})
        
        Window:AddButton({
            Name = "Test Button",
            Icon = "settings",
            Callback = function()
                print("Button clicked!")
            end
        })
        
        Window:AddToggle({
            Name = "Auto Farm",
            Default = false,
            Callback = function(value)
                print("Auto Farm:", value)
            end
        })
        
        Window:AddSlider({
            Name = "Speed",
            Min = 1,
            Max = 100,
            Default = 16,
            Callback = function(value)
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
        })
        
        Window:AddTextBox({
            Name = "Player Name",
            Placeholder = "Enter player name...",
            Callback = function(text)
                print("Player name:", text)
            end
        })
        
        Window:AddDropdown({
            Name = "Teleport Location",
            Options = {"Spawn", "Shop", "Boss Arena"},
            Default = "Spawn",
            Callback = function(option)
                print("Selected location:", option)
            end
        })
    end
})
--]]
