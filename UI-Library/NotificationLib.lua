-- SimpleNotifyLib
-- Simplified notification library for Roblox

local SimpleNotifyLib = {}

-- Create notification system once
local function SetupNotifySystem()
    local player = game.Players.LocalPlayer
    if not player then return nil end
    
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then return nil end
    
    -- Check if already exists
    local existing = playerGui:FindFirstChild("SimpleNotifySystem")
    if existing then return existing end
    
    -- Create new
    local gui = Instance.new("ScreenGui")
    gui.Name = "SimpleNotifySystem"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = playerGui
    
    return gui
end

-- Main function
SimpleNotifyLib.Notification = function(options)
    if type(options) ~= "table" then options = {} end
    
    local title = options.Title or "Notification"
    local content = options.Content or ""
    local image = options.Image or "rbxassetid://4914902889"
    local duration = options.Duration or 5
    
    -- Try to get image ID format
    if tonumber(image) then
        image = "rbxassetid://" .. image
    end
    
    -- Create UI system if not exists
    local notifySystem = SetupNotifySystem()
    if not notifySystem then 
        warn("Failed to create notification system")
        return 
    end
    
    -- Create notification frame
    local notification = Instance.new("Frame")
    notification.Name = "Notify_" .. title:sub(1, 10)
    notification.Size = UDim2.new(0, 300, 0, 80)
    notification.Position = UDim2.new(1, 10, 0.75, 0)
    notification.BackgroundColor3 = Color3.fromRGB(188, 202, 163) -- #bccaa3
    notification.BorderSizePixel = 0
    notification.Parent = notifySystem
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification
    
    -- Add gradient
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(188, 202, 163)), -- #bccaa3
        ColorSequenceKeypoint.new(1, Color3.fromRGB(107, 128, 180)) -- #6b80b4
    })
    gradient.Rotation = 45
    gradient.Parent = notification
    
    -- Add icon
    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 50, 0, 50)
    icon.Position = UDim2.new(0, 15, 0, 15)
    icon.BackgroundTransparency = 1
    icon.Image = image
    icon.Parent = notification
    
    -- Add title
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
    
    -- Add content
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
    
    -- Simple animation without loops
    local TweenService = game:GetService("TweenService")
    
    -- Move in
    local tweenIn = TweenService:Create(notification, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.98, -10, 0.75, 0), AnchorPoint = Vector2.new(1, 0)}
    )
    tweenIn:Play()
    
    -- Gradient rotation (safe, no infinite loop)
    local rotationSpeed = 1 -- Lower = safer
    local currentRotation = 45
    
    local lastTime = tick()
    local connection
    
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        local currentTime = tick()
        local deltaTime = currentTime - lastTime
        lastTime = currentTime
        
        if notification and notification.Parent then
            currentRotation = (currentRotation + rotationSpeed * deltaTime * 60) % 360
            gradient.Rotation = currentRotation
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end)
    
    -- Remove after duration
    task.delay(duration, function()
        if notification and notification.Parent then
            -- End connection
            if connection then
                connection:Disconnect()
                connection = nil
            end
            
            -- Move out
            local tweenOut = TweenService:Create(notification, 
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Position = UDim2.new(1.1, 0, 0.75, 0), BackgroundTransparency = 1}
            )
            
            -- Fade text
            TweenService:Create(titleLabel, 
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {TextTransparency = 1}
            ):Play()
            
            TweenService:Create(contentLabel, 
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {TextTransparency = 1}
            ):Play()
            
            TweenService:Create(icon, 
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {ImageTransparency = 1}
            ):Play()
            
            tweenOut:Play()
            tweenOut.Completed:Connect(function()
                notification:Destroy()
            end)
        end
    end)
    
    return notification
end

-- To allow using both syntaxes
setmetatable(SimpleNotifyLib, {
    __call = function(_, ...)
        return SimpleNotifyLib.Notification(...)
    end
})

return SimpleNotifyLib
