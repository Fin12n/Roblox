local NotifyLib = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Tạo ScreenGui chung
local ScreenGui
local function getScreenGui()
    if not ScreenGui then
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "SummerNotify"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    return ScreenGui
end

-- Danh sách để theo dõi các thông báo
local activeNotifications = {}
-- Bảng để theo dõi số lần inject của cùng một thông báo
local notificationInstances = {}

function NotifyLib:Notification(config)
    local Title = config.Title or "Notification"
    local Content = config.Content or "Message here"
    local Image = config.Image or ""
    local Duration = config.Duration or 5
    
    -- Tạo key duy nhất cho notification dựa trên nội dung
    local notifyKey = Title .. Content .. Image
    
    -- Đếm số lần inject của notification này
    notificationInstances[notifyKey] = (notificationInstances[notifyKey] or 0) + 1
    local instanceCount = notificationInstances[notifyKey]
    
    local ScreenGui = getScreenGui()
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 100)
    MainFrame.Position = UDim2.new(1, 320, 0, 50) -- Bắt đầu ngoài màn hình
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
    
    -- Image (bên trái như SendNotification)
    local Icon
    if Image ~= "" then
        Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0, 40, 0, 40)
        Icon.Position = UDim2.new(0, 10, 0, 10)
        Icon.BackgroundTransparency = 1
        Icon.Image = "rbxassetid://" .. Image
        Icon.Parent = NotifyFrame
    end
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 240, 0, 25)
    TitleLabel.Position = UDim2.new(0, Image ~= "" and 60 or 10, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextScaled = true
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Parent = NotifyFrame
    
    -- Content
    local ContentLabel = Instance.new("TextLabel")
    ContentLabel.Size = UDim2.new(0, 240, 0, 40)
    ContentLabel.Position = UDim2.new(0, Image ~= "" and 60 or 10, 0, 40)
    ContentLabel.BackgroundTransparency = 1
    ContentLabel.Text = Content
    ContentLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    ContentLabel.TextScaled = true
    ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    ContentLabel.Font = Enum.Font.SourceSans
    ContentLabel.Parent = NotifyFrame
    
    -- Hiệu ứng mùa hạ: lá rơi
    local function createFallingLeaf()
        local Leaf = Instance.new("ImageLabel")
        Leaf.Size = UDim2.new(0, 15, 0, 15)
        Leaf.BackgroundTransparency = 1
        Leaf.Image = "rbxassetid://131153409"
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
    
    -- Tính toán vị trí
    local function updatePositions()
        local offset = 50
        for i, notif in ipairs(activeNotifications) do
            local targetPos = UDim2.new(1, -intrepeatable -320, 0, offset + (i-1) * 110)
            TweenService:Create(notif.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                Position = targetPos
            }):Play()
        end
    end
    
    -- Animation
    local slideIn = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -320, 0, 50 + (instanceCount - 1) * 110)
    })
    
    local slideOut = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 320, 0, 50 + (instanceCount - 1) * 110)
    })
    
    -- Thêm vào danh sách thông báo
    table.insert(activeNotifications, {Frame = MainFrame, Key = notifyKey})
    
    -- Chạy animation và cập nhật vị trí
    slideIn:Play()
    updatePositions()
    
    -- Hiệu ứng lá rơi
    for i = 1, 3 do
        spawn(function()
            while wait(0.5) do
                if not MainFrame.Parent then break end
                createFallingLeaf()
            end
        end)
    end
    
    -- Xóa sau Duration
    spawn(function()
        wait(Duration)
        for i, notif in ipairs(activeNotifications) do
            if notif.Frame == MainFrame then
                table.remove(activeNotifications, i)
                if notificationInstances[notif.Key] then
                    notificationInstances[notif.Key] = notificationInstances[notif.Key] - 1
                    if notificationInstances[notif.Key] <= 0 then
                        notificationInstances[notif.Key] = nil
                    end
                end
                break
            end
        end
        
        slideOut:Play()
        slideOut.Completed:Connect(function()
            MainFrame:Destroy()
            updatePositions()
        end)
    end)
end

return NotifyLib
