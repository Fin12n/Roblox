-- Fin12nLib v1.2 | Fixed UI Library for Roblox
-- Created by Fin12n | Mobile & Desktop Support with Lucide Icons

local Fin12nLib = {}

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

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

-- Lucide Icons Database
Fin12nLib.Icons = {
    -- Navigation & UI
    ["home"] = "🏠", ["menu"] = "☰", ["settings"] = "⚙️", ["search"] = "🔍",
    ["filter"] = "🔽", ["sort"] = "↕️", ["grid"] = "⊞", ["list"] = "☰",
    ["more-horizontal"] = "⋯", ["more-vertical"] = "⋮",
    
    -- Actions
    ["plus"] = "➕", ["minus"] = "➖", ["x"] = "✕", ["check"] = "✓",
    ["edit"] = "✏️", ["trash"] = "🗑️", ["save"] = "💾", ["download"] = "⬇️",
    ["upload"] = "⬆️", ["refresh"] = "🔄", ["copy"] = "📋", ["share"] = "🔗",
    
    -- Arrows
    ["arrow-up"] = "↑", ["arrow-down"] = "↓", ["arrow-left"] = "←", ["arrow-right"] = "→",
    ["chevron-up"] = "▲", ["chevron-down"] = "▼", ["chevron-left"] = "◀", ["chevron-right"] = "▶",
    
    -- Status
    ["info"] = "ℹ️", ["alert-circle"] = "⚠️", ["check-circle"] = "✅", ["x-circle"] = "❌",
    ["help-circle"] = "❓", ["bell"] = "🔔", ["bell-off"] = "🔕",
    
    -- Objects
    ["user"] = "👤", ["users"] = "👥", ["key"] = "🔑", ["lock"] = "🔒",
    ["unlock"] = "🔓", ["shield"] = "🛡️", ["sword"] = "⚔️", ["target"] = "🎯",
    ["gamepad"] = "🎮", ["trophy"] = "🏆", ["gift"] = "🎁", ["zap"] = "⚡",
    ["flame"] = "🔥", ["rocket"] = "🚀", ["star"] = "⭐", ["heart"] = "❤️",
    ["eye"] = "👁️", ["camera"] = "📷", ["image"] = "🖼️", ["file"] = "📄",
    ["folder"] = "📁", ["music"] = "🎵", ["video"] = "🎥",
    
    -- Default
    ["default"] = "•"
}

function Fin12nLib:GetIcon(iconName)
    return self.Icons[iconName] or self.Icons["default"]
end

-- Notification System
local NotificationFrame = nil
local NotificationQueue = {}
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
    icon.Name = "Icon"
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
    label.Name = "Label"
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
    progress.Name = "Progress"
    progress.BackgroundColor3 = currentTheme.Text
    progress.BorderSizePixel = 0
    progress.Position = UDim2.new(0, 15, 1, -8)
    progress.Size = UDim2.new(1, -30, 0, 3)
    progress.ZIndex = Fin12nLib.Config.ZIndex.Notification
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(1, 0)
    progressCorner.Parent = progress
end

function Fin12nLib:Notify(message, type, duration)
    if not NotificationFrame then return end
    
    type = type or "info"
    duration = duration or 3
    
    table.insert(NotificationQueue, {message = message, type = type, duration = duration})
    
    if not isNotificationShowing then
        spawn(function()
            while #NotificationQueue > 0 do
                local notification = table.remove(NotificationQueue, 1)
                isNotificationShowing = true
                
                local icons = {
                    success = "✓", warning = "⚠", error = "✗", info = "ℹ"
                }
                
                local colors = {
                    success = {currentTheme.Success, Color3.fromRGB(50, 180, 100)},
                    warning = {currentTheme.Warning, Color3.fromRGB(235, 160, 30)},
                    error = {currentTheme.Error, Color3.fromRGB(235, 60, 60)},
                    info = {currentTheme.Info, currentTheme.Secondary}
                }
                
                NotificationFrame.Icon.Text = icons[notification.type] or icons.info
                NotificationFrame.Label.Text = notification.message
                
                NotificationFrame:FindFirstChild("UIGradient").Color = ColorSequence.new{
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

-- Mobile Toggle System
local function CreateMobileToggle(parent, callback)
    if not isMobile and not isTablet then return end
    
    local toggle = Instance.new("TextButton")
    toggle.Parent = parent
    toggle.BackgroundColor3 = currentTheme.Primary
    toggle.BorderSizePixel = 0
    toggle.Position = UDim2.new(0.9, -30, 0.1, 0)
    toggle.Size = UDim2.new(0, 60, 0, 60)
    toggle.Text = "M"
    toggle.TextColor3 = currentTheme.Text
    toggle.TextSize = 24
    toggle.Font = Enum.Font.GothamBold
    toggle.ZIndex = Fin12nLib.Config.ZIndex.MobileToggle
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = toggle
    
    -- Mobile drag/tap logic
    local state = {isDragging = false, dragStart = nil, buttonStart = nil, hasMoved = false}
    local DRAG_THRESHOLD = 10
    local TAP_TIME_LIMIT = 0.3
    
    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            state.initialTime = tick()
            state.dragStart = input.Position
            state.buttonStart = toggle.Position
            state.hasMoved = false
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if state.dragStart and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local distance = (input.Position - state.dragStart).Magnitude
            if distance >= DRAG_THRESHOLD then
                state.hasMoved = true
                state.isDragging = true
                
                local delta = input.Position - state.dragStart
                local newPos = UDim2.new(
                    state.buttonStart.X.Scale, state.buttonStart.X.Offset + delta.X,
                    state.buttonStart.Y.Scale, state.buttonStart.Y.Offset + delta.Y
                )
                
                local screenSize = workspace.CurrentCamera.ViewportSize
                local clampedX = math.clamp(newPos.X.Offset, 10, screenSize.X - 70)
                local clampedY = math.clamp(newPos.Y.Offset, 10, screenSize.Y - 70)
                
                toggle.Position = UDim2.new(0, clampedX, 0, clampedY)
            end
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if state.initialTime and tick() - state.initialTime <= TAP_TIME_LIMIT and not state.hasMoved then
                callback()
            end
            state = {isDragging = false, dragStart = nil, buttonStart = nil, hasMoved = false}
        end
    end)
    
    return toggle
end

-- Main Window Creation
function Fin12nLib:CreateWindow(config)
    config = config or {}
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = config.Title or "Fin12nLib"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = Fin12nLib.Config.ZIndex.Base
    
    -- Initialize Notification System
    CreateNotificationSystem(ScreenGui)
    
    -- Main Container
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer"
    MainContainer.Parent = ScreenGui
    MainContainer.BackgroundColor3 = currentTheme.Background
    MainContainer.BorderSizePixel = 0
    MainContainer.Position = config.Position or UDim2.new(0.15, 0, 0.05, 0)
    MainContainer.Size = config.Size or UDim2.new(0, 750, 0, 550)
    MainContainer.Visible = false
    MainContainer.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 15)
    mainCorner.Parent = MainContainer
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainContainer
    TitleBar.BackgroundColor3 = currentTheme.Primary
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
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
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = TitleBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = config.Title or "Fin12nLib Window"
    titleLabel.TextColor3 = currentTheme.Text
    titleLabel.TextSize = 20
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Parent = TitleBar
    closeButton.BackgroundColor3 = currentTheme.Error
    closeButton.BorderSizePixel = 0
    closeButton.Position = UDim2.new(1, -40, 0, 10)
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Text = "×"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextColor3 = currentTheme.Text
    closeButton.TextSize = 18
    closeButton.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeButton
    
    -- Sidebar for Tabs
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainContainer
    Sidebar.BackgroundColor3 = currentTheme.Surface
    Sidebar.BorderSizePixel = 0
    Sidebar.Position = UDim2.new(0, 0, 0, 50)
    Sidebar.Size = UDim2.new(0, 200, 1, -50)
    Sidebar.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = Sidebar
    tabContainer.BackgroundTransparency = 1
    tabContainer.Position = UDim2.new(0, 10, 0, 10)
    tabContainer.Size = UDim2.new(1, -20, 1, -20)
    tabContainer.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabContainer
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 8)
    
    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = MainContainer
    ContentArea.BackgroundTransparency = 1
    ContentArea.Position = UDim2.new(0, 210, 0, 60)
    ContentArea.Size = UDim2.new(1, -220, 1, -70)
    ContentArea.ZIndex = Fin12nLib.Config.ZIndex.Base
    
    -- Window State
    local UIVisible = false
    local Tabs = {}
    local CurrentTab = nil
    
    -- Window Functions
    local function showWindow()
        UIVisible = true
        MainContainer.Visible = true
        MainContainer.Size = UDim2.new(0, 0, 0, 0)
        
        TweenService:Create(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = config.Size or UDim2.new(0, 750, 0, 550)
        }):Play()
    end
    
    local function hideWindow()
        UIVisible = false
        TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        spawn(function()
            wait(0.3)
            MainContainer.Visible = false
        end)
    end
    
    local function toggleWindow()
        if UIVisible then hideWindow() else showWindow() end
    end
    
    -- Create Mobile Toggle
    local mobileToggle = CreateMobileToggle(ScreenGui, toggleWindow)
    
    -- Close Button Function
    closeButton.MouseButton1Click:Connect(hideWindow)
    
    -- Dragging System
    local dragToggle = false
    local dragStart = nil
    local startPos = nil
    
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
        if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainContainer.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Window Object
    local Window = {}
    
    -- Window Methods
    function Window:Show()
        showWindow()
    end
    
    function Window:Hide()
        hideWindow()
    end
    
    function Window:Toggle()
        toggleWindow()
    end
    
    function Window:SetTitle(newTitle)
        titleLabel.Text = newTitle
    end
    
    function Window:Destroy()
        ScreenGui:Destroy()
    end
    
    -- Tab Management
    function Window:CreateTab(name, icon)
        icon = icon or "default"
        
        -- Create Tab Button
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name
        tabButton.Parent = tabContainer
        tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        tabButton.BorderSizePixel = 0
        tabButton.Size = UDim2.new(1, 0, 0, 45)
        tabButton.Text = ""
        tabButton.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 10)
        tabCorner.Parent = tabButton
        
        local tabIcon = Instance.new("TextLabel")
        tabIcon.Name = "Icon"
        tabIcon.Parent = tabButton
        tabIcon.BackgroundTransparency = 1
        tabIcon.Position = UDim2.new(0, 15, 0, 0)
        tabIcon.Size = UDim2.new(0, 30, 1, 0)
        tabIcon.Font = Enum.Font.Gotham
        tabIcon.Text = Fin12nLib:GetIcon(icon)
        tabIcon.TextColor3 = currentTheme.TextSecondary
        tabIcon.TextSize = 18
        tabIcon.TextXAlignment = Enum.TextXAlignment.Center
        tabIcon.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Name = "Label"
        tabLabel.Parent = tabButton
        tabLabel.BackgroundTransparency = 1
        tabLabel.Position = UDim2.new(0, 50, 0, 0)
        tabLabel.Size = UDim2.new(1, -60, 1, 0)
        tabLabel.Font = Enum.Font.GothamSemibold
        tabLabel.Text = name
        tabLabel.TextColor3 = currentTheme.TextSecondary
        tabLabel.TextSize = 14
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        tabLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        -- Create Tab Content
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = name .. "Content"
        tabContent.Parent = ContentArea
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.Visible = false
        tabContent.ScrollBarThickness = 6
        tabContent.ScrollBarImageColor3 = currentTheme.Primary
        tabContent.BorderSizePixel = 0
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.Parent = tabContent
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 15)
        
        contentLayout.Changed:Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab Object
        local tab = {
            Name = name,
            Icon = icon,
            Button = tabButton,
            Content = tabContent,
            Active = false
        }
        
        -- Tab Click Handler
        tabButton.MouseButton1Click:Connect(function()
            -- Deactivate current tab
            if CurrentTab then
                CurrentTab.Active = false
                CurrentTab.Content.Visible = false
                TweenService:Create(CurrentTab.Button, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                }):Play()
                CurrentTab.Button.Icon.TextColor3 = currentTheme.TextSecondary
                CurrentTab.Button.Label.TextColor3 = currentTheme.TextSecondary
            end
            
            -- Activate new tab
            tab.Active = true
            tab.Content.Visible = true
            CurrentTab = tab
            
            TweenService:Create(tabButton, TweenInfo.new(0.3), {
                BackgroundColor3 = currentTheme.Primary
            }):Play()
            tabIcon.TextColor3 = currentTheme.Text
            tabLabel.TextColor3 = currentTheme.Text
        end)
        
        -- Tab Hover Effects
        tabButton.MouseEnter:Connect(function()
            if not tab.Active then
                TweenService:Create(tabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                }):Play()
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if not tab.Active then
                TweenService:Create(tabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                }):Play()
            end
        end)
        
        Tabs[name] = tab
        return tab
    end
    
    function Window:SelectTab(tabName)
        if Tabs[tabName] then
            Tabs[tabName].Button.MouseButton1Click:Fire()
        end
    end
    
    -- UI Element Creation Functions
    function Window:CreateSection(text, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content)
        if not parent then return end
        
        icon = icon or "default"
        
        local section = Instance.new("Frame")
        section.Parent = parent
        section.BackgroundColor3 = currentTheme.Surface
        section.BorderSizePixel = 0
        section.Size = UDim2.new(1, 0, 0, 60)
        section.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = section
        
        local sectionIcon = Instance.new("TextLabel")
        sectionIcon.Parent = section
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
        sectionTitle.Parent = section
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
        
        return section
    end
    
    function Window:CreateButton(text, callback, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content)
        if not parent then return end
        
        icon = icon or "default"
        
        local button = Instance.new("TextButton")
        button.Parent = parent
        button.BackgroundColor3 = currentTheme.Primary
        button.BorderSizePixel = 0
        button.Size = UDim2.new(1, 0, 0, 45)
        button.Text = ""
        button.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = button
        
        local buttonIcon = Instance.new("TextLabel")
        buttonIcon.Parent = button
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
        buttonLabel.Parent = button
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
        
        button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(
                    math.min(255, currentTheme.Primary.R * 255 + 20),
                    math.min(255, currentTheme.Primary.G * 255 + 20),
                    math.min(255, currentTheme.Primary.B * 255 + 20)
                )
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = currentTheme.Primary
            }):Play()
        end)
        
        return button
    end
    
    function Window:CreateToggle(text, defaultValue, callback, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content)
        if not parent then return end
        
        defaultValue = defaultValue or false
        icon = icon or "check"
        
        local toggle = Instance.new("Frame")
        toggle.Parent = parent
        toggle.BackgroundColor3 = currentTheme.Surface
        toggle.BorderSizePixel = 0
        toggle.Size = UDim2.new(1, 0, 0, 50)
        toggle.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = toggle
        
        local toggleIcon = Instance.new("TextLabel")
        toggleIcon.Parent = toggle
        toggleIcon.BackgroundTransparency = 1
        toggleIcon.Position = UDim2.new(0, 15, 0, 0)
        toggleIcon.Size = UDim2.new(0, 30, 1, 0)
        toggleIcon.Font = Enum.Font.Gotham
        toggleIcon.Text = Fin12nLib:GetIcon(icon)
        toggleIcon.TextColor3 = defaultValue and currentTheme.Success or currentTheme.TextSecondary
        toggleIcon.TextSize = 16
        toggleIcon.TextXAlignment = Enum.TextXAlignment.Center
        toggleIcon.TextYAlignment = Enum.TextYAlignment.Center
        toggleIcon.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local toggleLabel = Instance.new("TextLabel")
        toggleLabel.Parent = toggle
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
        toggleButton.Parent = toggle
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
                TweenService:Create(toggleButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = currentTheme.Success
                }):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(0.3), {
                    Position = UDim2.new(0, 24, 0, 3)
                }):Play()
                TweenService:Create(toggleIcon, TweenInfo.new(0.3), {
                    TextColor3 = currentTheme.Success
                }):Play()
            else
                TweenService:Create(toggleButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                }):Play()
                TweenService:Create(toggleIndicator, TweenInfo.new(0.3), {
                    Position = UDim2.new(0, 3, 0, 3)
                }):Play()
                TweenService:Create(toggleIcon, TweenInfo.new(0.3), {
                    TextColor3 = currentTheme.TextSecondary
                }):Play()
            end
            
            if callback then callback(toggled) end
        end)
        
        return toggle, function() return toggled end
    end
    
    function Window:CreateSlider(text, min, max, defaultValue, callback, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content)
        if not parent then return end
        
        min = min or 0
        max = max or 100
        defaultValue = defaultValue or min
        icon = icon or "sliders"
        
        local slider = Instance.new("Frame")
        slider.Parent = parent
        slider.BackgroundColor3 = currentTheme.Surface
        slider.BorderSizePixel = 0
        slider.Size = UDim2.new(1, 0, 0, 75)
        slider.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = slider
        
        local sliderIcon = Instance.new("TextLabel")
        sliderIcon.Parent = slider
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
        sliderLabel.Parent = slider
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
        sliderValue.Parent = slider
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
        sliderTrack.Parent = slider
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
                currentValue = math.floor(currentValue)
                
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
        
        return slider, function() return currentValue end
    end
    
    function Window:CreateTextBox(text, placeholder, callback, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content)
        if not parent then return end
        
        placeholder = placeholder or "Enter text..."
        icon = icon or "edit"
        
        local textbox = Instance.new("Frame")
        textbox.Parent = parent
        textbox.BackgroundColor3 = currentTheme.Surface
        textbox.BorderSizePixel = 0
        textbox.Size = UDim2.new(1, 0, 0, 75)
        textbox.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = textbox
        
        local textboxIcon = Instance.new("TextLabel")
        textboxIcon.Parent = textbox
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
        textboxLabel.Parent = textbox
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
        textInput.Parent = textbox
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
        
        return textbox, textInput
    end
    
    function Window:CreateLabel(text, size, icon, parent)
        parent = parent or (CurrentTab and CurrentTab.Content)
        if not parent then return end
        
        size = size or 14
        icon = icon or "info"
        
        local label = Instance.new("Frame")
        label.Parent = parent
        label.BackgroundColor3 = currentTheme.Surface
        label.BorderSizePixel = 0
        label.Size = UDim2.new(1, 0, 0, 40)
        label.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = label
        
        local labelIcon = Instance.new("TextLabel")
        labelIcon.Parent = label
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
        labelText.Parent = label
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
        
        return label, labelText
    end
    
    function Window:CreateLine(parent)
        parent = parent or (CurrentTab and CurrentTab.Content)
        if not parent then return end
        
        local line = Instance.new("Frame")
        line.Parent = parent
        line.BackgroundColor3 = currentTheme.Primary
        line.BorderSizePixel = 0
        line.Size = UDim2.new(1, 0, 0, 2)
        line.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = line
        
        return line
    end
    
    function Window:CreateImageLabel(imageId, size, parent)
        parent = parent or (CurrentTab and CurrentTab.Content)
        if not parent then return end
        
        size = size or UDim2.new(1, 0, 0, 100)
        
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Parent = parent
        imageLabel.BackgroundColor3 = currentTheme.Surface
        imageLabel.BorderSizePixel = 0
        imageLabel.Size = size
        imageLabel.Image = "rbxassetid://" .. tostring(imageId)
        imageLabel.ScaleType = Enum.ScaleType.Fit
        imageLabel.ZIndex = Fin12nLib.Config.ZIndex.Base
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = imageLabel
        
        return imageLabel
    end
    
    -- Set default tab if specified
    if config.DefaultTab then
        spawn(function()
            wait(0.1)
            Window:SelectTab(config.DefaultTab)
        end)
    end
    
    return Window
end

-- Theme Presets
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
    }
}

-- Settings Saver Placeholder
function Fin12nLib:LoadSettingsSaver(url)
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

return Fin12nLib
