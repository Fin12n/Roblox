-- NotifyLib Module Script
local NotifyLib = {}

-- Constants
local GRADIENT_COLOR_1 = Color3.fromRGB(188, 202, 163) -- #bccaa3
local GRADIENT_COLOR_2 = Color3.fromRGB(107, 128, 180) -- #6b80b4
local DEFAULT_DURATION = 5
local DEFAULT_TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local DEFAULT_TEXT_SIZE = 14
local DEFAULT_TITLE_SIZE = 16
local ANIMATION_DURATION = 0.5

-- Create base UI elements
local function createBaseUI()
    local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Check if the NotificationSystem already exists
    local existingSystem = PlayerGui:FindFirstChild("NotificationSystem")
    if existingSystem then
        return existingSystem
    end
    
    -- Create new notification system
    local NotificationSystem = Instance.new("ScreenGui")
    NotificationSystem.Name = "NotificationSystem"
    NotificationSystem.ResetOnSpawn = false
    NotificationSystem.Parent = PlayerGui
    
    return NotificationSystem
end

-- Load image from ID or URL
local function loadImage(imageSource)
    -- Default image if none provided
    if not imageSource or imageSource == "" then
        return "rbxassetid://4914902889" -- Default notification icon
    end
    
    -- If it's an ID (number or string starting with "rbxassetid://")
    if tonumber(imageSource) then
        return "rbxassetid://" .. imageSource
    elseif string.find(imageSource, "rbxassetid://") then
        return imageSource
    else
        -- Assume it's a URL (Note: Roblox might not allow external URLs)
        return imageSource
    end
end

function NotifyLib:Notification(options)
    -- Default parameters and validate options
    options = options or {}
    local title = options.Title or "Notification"
    local content = options.Content or ""
    local image = loadImage(options.Image)
    local duration = options.Duration or DEFAULT_DURATION
    
    -- Create base UI if it doesn't exist
    local notificationSystem = createBaseUI()
    
    -- Create notification container
    local notificationContainer = Instance.new("Frame")
    notificationContainer.Name = "NotificationContainer"
    notificationContainer.Size = UDim2.new(0, 300, 0, 80)
    notificationContainer.Position = UDim2.new(1, 10, 0.75, 0) -- Start off-screen to the right
    notificationContainer.BackgroundTransparency = 0
    notificationContainer.BorderSizePixel = 0
    notificationContainer.BackgroundColor3 = GRADIENT_COLOR_1
    notificationContainer.ZIndex = 10
    notificationContainer.Parent = notificationSystem
    
    -- Add corner radius
    local cornerRadius = Instance.new("UICorner")
    cornerRadius.CornerRadius = UDim.new(0, 8)
    cornerRadius.Parent = notificationContainer
    
    -- Create gradient
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, GRADIENT_COLOR_1),
        ColorSequenceKeypoint.new(1, GRADIENT_COLOR_2)
    })
    gradient.Rotation = 45
    gradient.Parent = notificationContainer
    
    -- Create icon image
    local iconImage = Instance.new("ImageLabel")
    iconImage.Name = "Icon"
    iconImage.Size = UDim2.new(0, 50, 0, 50)
    iconImage.Position = UDim2.new(0, 15, 0, 15)
    iconImage.BackgroundTransparency = 1
    iconImage.Image = image
    iconImage.ScaleType = Enum.ScaleType.Fit
    iconImage.ZIndex = 11
    iconImage.Parent = notificationContainer
    
    -- Create title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -80, 0, 25)
    titleLabel.Position = UDim2.new(0, 75, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = DEFAULT_TEXT_COLOR
    titleLabel.TextSize = DEFAULT_TITLE_SIZE
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextWrapped = true
    titleLabel.ZIndex = 11
    titleLabel.Parent = notificationContainer
    
    -- Create content label
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "Content"
    contentLabel.Size = UDim2.new(1, -80, 0, 40)
    contentLabel.Position = UDim2.new(0, 75, 0, 35)
    contentLabel.BackgroundTransparency = 1
    contentLabel.TextColor3 = DEFAULT_TEXT_COLOR
    contentLabel.TextSize = DEFAULT_TEXT_SIZE
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.Text = content
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.TextWrapped = true
    contentLabel.ZIndex = 11
    contentLabel.Parent = notificationContainer
    
    -- Create a shadow effect
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.ZIndex = 9
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = notificationContainer
    
    -- Gradient animation
    spawn(function()
        while notificationContainer.Parent do
            for i = 0, 360, 1 do
                if notificationContainer.Parent then
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
    
    local entranceTween = tweenService:Create(notificationContainer, entranceTweenInfo, {
        Position = UDim2.new(0.98, -10, 0.75, 0), -- Anchor point to right side of screen
        AnchorPoint = Vector2.new(1, 0) -- Right edge anchored
    })
    
    entranceTween:Play()
    
    -- Exit animation after duration
    spawn(function()
        wait(duration)
        
        local exitTweenInfo = TweenInfo.new(ANIMATION_DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        
        local exitTween = tweenService:Create(notificationContainer, exitTweenInfo, {
            Position = UDim2.new(1.1, 0, 0.75, 0), -- Move off screen to the right
            BackgroundTransparency = 1
        })
        
        local textExitTween = tweenService:Create(titleLabel, exitTweenInfo, {
            TextTransparency = 1
        })
        
        local contentExitTween = tweenService:Create(contentLabel, exitTweenInfo, {
            TextTransparency = 1
        })
        
        local iconExitTween = tweenService:Create(iconImage, exitTweenInfo, {
            ImageTransparency = 1
        })
        
        local shadowExitTween = tweenService:Create(shadow, exitTweenInfo, {
            ImageTransparency = 1
        })
        
        exitTween:Play()
        textExitTween:Play()
        contentExitTween:Play()
        iconExitTween:Play()
        shadowExitTween:Play()
        
        exitTween.Completed:Connect(function()
            notificationContainer:Destroy()
        end)
    end)
    
    return notificationContainer
end

-- Handle multiple notifications to stack them properly
local activeNotifications = {}

-- Override to match requested API style
function NotifyLib.Notification(options)
    return NotifyLib:Notification(options)
end

return NotifyLib
