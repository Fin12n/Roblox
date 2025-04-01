-- NotifyLib by Claude
-- A complete notification library that can be executed in any Roblox game

local NotifyLib = {}

-- Constants
local GRADIENT_COLOR_1 = Color3.fromRGB(188, 202, 163) -- #bccaa3
local GRADIENT_COLOR_2 = Color3.fromRGB(107, 128, 180) -- #6b80b4
local DEFAULT_DURATION = 5
local ANIMATION_DURATION = 0.5

-- Initialize UI
local function InitializeUI()
    local player = game.Players.LocalPlayer
    if not player then
        repeat wait() player = game.Players.LocalPlayer until player
    end
    
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then
        repeat wait() playerGui = player:FindFirstChild("PlayerGui") until playerGui
    end
    
    -- Check if NotifySystem already exists
    local notifySystem = playerGui:FindFirstChild("NotifySystem")
    
    if not notifySystem then
        notifySystem = Instance.new("ScreenGui")
        notifySystem.Name = "NotifySystem"
        notifySystem.ResetOnSpawn = false
        notifySystem.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        notifySystem.Parent = playerGui
        
        -- Create notification container
        local notificationsFrame = Instance.new("Frame")
        notificationsFrame.Name = "NotificationsFrame"
        notificationsFrame.BackgroundTransparency = 1
        notificationsFrame.Size = UDim2.new(1, 0, 1, 0)
        notificationsFrame.Position = UDim2.new(0, 0, 0, 0)
        notificationsFrame.Parent = notifySystem
    end
    
    return playerGui:FindFirstChild("NotifySystem")
end

-- Get or create image from ID or URL
local function GetImageFromSource(imageSource)
    -- Default image if none provided
    if not imageSource or imageSource == "" then
        return "rbxassetid://4914902889" -- Default notification icon
    end
    
    -- Handle different image formats
    if tonumber(imageSource) then
        return "rbxassetid://" .. imageSource
    elseif string.find(imageSource, "rbxassetid://") then
        return imageSource
    else
        -- Assume it's a URL
        return imageSource
    end
end

-- Main notification function
function NotifyLib:Notification(options)
    options = options or {}
    
    -- Default values
    local title = options.Title or "Notification"
    local content = options.Content or ""
    local imageSource = GetImageFromSource(options.Image)
    local duration = options.Duration or DEFAULT_DURATION
    
    -- Initialize UI if not already done
    local notifySystem = InitializeUI()
    local notificationsFrame = notifySystem:FindFirstChild("NotificationsFrame")
    
    -- Create notification
    local notification = Instance.new("Frame")
    notification.Name = "Notification_" .. tostring(os.time())
    notification.Size = UDim2.new(0, 300, 0, 80)
    notification.Position = UDim2.new(1, 10, 0.75, 0) -- Start off-screen
    notification.BackgroundColor3 = GRADIENT_COLOR_1
    notification.BorderSizePixel = 0
    notification.AnchorPoint = Vector2.new(0, 0)
    notification.Parent = notificationsFrame
    
    -- Add corner radius
    local cornerRadius = Instance.new("UICorner")
    cornerRadius.CornerRadius = UDim.new(0, 8)
    cornerRadius.Parent = notification
    
    -- Add gradient
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, GRADIENT_COLOR_1),
        ColorSequenceKeypoint.new(1, GRADIENT_COLOR_2)
    })
    gradient.Rotation = 45
    gradient.Parent = notification
    
    -- Add shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.ZIndex = notification.ZIndex - 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = notification
    
    -- Create icon
    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 50, 0, 50)
    icon.Position = UDim2.new(0, 15, 0, 15)
    icon.BackgroundTransparency = 1
    icon.Image = imageSource
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Parent = notification
    
    -- Create title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -80, 0, 25)
    titleLabel.Position = UDim2.new(0, 75, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextWrapped = true
    titleLabel.Parent = notification
    
    -- Create content
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "Content"
    contentLabel.Size = UDim2.new(1, -80, 0, 40)
    contentLabel.Position = UDim2.new(0, 75, 0, 35)
    contentLabel.BackgroundTransparency = 1
    contentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    contentLabel.TextSize = 14
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.Text = content
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.TextWrapped = true
    contentLabel.Parent = notification
    
    -- Animate gradient
    spawn(function()
        while notification and notification.Parent do
            for i = 0, 360, 1 do
                if notification and notification.Parent then
                    gradient.Rotation = i
                    wait(0.03)
                else
                    break
                end
            end
        end
    end)
    
    -- Entrance animation
    local tweenService = game:GetService("TweenService")
    local entranceTweenInfo = TweenInfo.new(ANIMATION_DURATION, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    local entranceTween = tweenService:Create(notification, entranceTweenInfo, {
        Position = UDim2.new(0.98, -10, 0.75, 0),
        AnchorPoint = Vector2.new(1, 0)
    })
    
    entranceTween:Play()
    
    -- Exit animation after duration
    spawn(function()
        wait(duration)
        
        local exitTweenInfo = TweenInfo.new(ANIMATION_DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        
        local exitTween = tweenService:Create(notification, exitTweenInfo, {
            Position = UDim2.new(1.1, 0, 0.75, 0),
            BackgroundTransparency = 1
        })
        
        local titleExitTween = tweenService:Create(titleLabel, exitTweenInfo, {
            TextTransparency = 1
        })
        
        local contentExitTween = tweenService:Create(contentLabel, exitTweenInfo, {
            TextTransparency = 1
        })
        
        local iconExitTween = tweenService:Create(icon, exitTweenInfo, {
            ImageTransparency = 1
        })
        
        local shadowExitTween = tweenService:Create(shadow, exitTweenInfo, {
            ImageTransparency = 1
        })
        
        exitTween:Play()
        titleExitTween:Play()
        contentExitTween:Play()
        iconExitTween:Play()
        shadowExitTween:Play()
        
        exitTween.Completed:Connect(function()
            notification:Destroy()
        end)
    end)
    
    return notification
end

-- Alternative syntax support
function NotifyLib.Notification(options)
    return NotifyLib:Notification(options)
end

-- Simple initialization to make sure PlayerGui exists
spawn(function()
    InitializeUI()
end)

return NotifyLib
