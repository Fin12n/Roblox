local NotifyLib = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Tạo GUI chính
local function createNotification()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "SummerNotify"
    ScreenGui.ResetOnSpawn = false
    
    return ScreenGui
end

function NotifyLib:Notification(config)
    local Title = config.Title or "Notification"
    local Content = config.Content or "Message here"
    local Image = config.Image or ""
    local Duration = config.Duration or 5
    
    -- Tạo container chính
    local ScreenGui = createNotification()
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 100)
    MainFrame.Position = UDim2.new(1, 320, 0, 50)
    MainFrame.BackgroundTransparency = 1
    MainFrame.Parent = ScreenGui
    
    -- Gradient Background
    local NotifyFrame = Instance.new("Frame")
    NotifyFrame.Size = UDim2.new(1, 0, 1, 0)
    NotifyFrame.BackgroundTransparency = 0.1
    NotifyFrame.Parent = MainFrame
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("#bccaa3")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("#6b80b4"))
    })
    Gradient.Rotation = 45
    Gradient.Parent = NotifyFrame
    
    -- Corner
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = NotifyFrame
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.9, 0, 0, 25)
    TitleLabel.Position = UDim2.new(0.05, 0, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Parent = NotifyFrame
    
    -- Content
    local ContentLabel = Instance.new("TextLabel")
    ContentLabel.Size = UDim2.new(0.9, 0, 0, 40)
    ContentLabel.Position = UDim2.new(0.05, 0, 0, 40)
    ContentLabel.BackgroundTransparency = 1
    ContentLabel.Text = Content
    ContentLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    ContentLabel.TextScaled = true
    ContentLabel.Font = Enum.Font.SourceSans
    ContentLabel.Parent = NotifyFrame
    
    -- Image (nếu có)
    if Image ~= "" then
        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0, 40, 0, 40)
        Icon.Position = UDim2.new(1, -50, 0, 10)
        Icon.BackgroundTransparency = 1
        Icon.Image = "rbxassetid://" .. Image
        Icon.Parent = NotifyFrame
    end
    
    -- Hiệu ứng mùa hạ: lá rơi
    local function createFallingLeaf()
        local Leaf = Instance.new("ImageLabel")
        Leaf.Size = UDim2.new(0, 15, 0, 15)
        Leaf.BackgroundTransparency = 1
        Leaf.Image = "rbxassetid://131153409" -- ID lá mùa hạ
        Leaf.Parent = NotifyFrame
        
        local startPos = UDim2.new(math.random(), 0, 0, -20)
        local endPos = UDim2.new(math.random(), 0, 1, 20)
        
        Leaf.Position = startPos
        
        local tween = TweenService:Create(Leaf, TweenInfo.new(2, Enum.EasingStyle.Quad), {
            Position = endPos,
            Rotation = math.random(-180, 180)
        })
        
        tween:Play()
        tween.Completed:Connect(function()
            Leaf:Destroy()
        end)
    end
    
    -- Animation xuất hiện
    local slideIn = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -320, 0, 50)
    })
    
    local slideOut = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 320, 0, 50)
    })
    
    -- Chạy animation
    slideIn:Play()
    
    -- Tạo hiệu ứng lá rơi
    for i = 1, 3 do
        spawn(function()
            while wait(0.5) do
                createFallingLeaf()
            end
        end)
    end
    
    -- Tự động xóa sau Duration
    wait(Duration)
    slideOut:Play()
    slideOut.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end

return NotifyLib
