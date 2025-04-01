local LoadingLib = {}

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- Tạo ScreenGui chung
local ScreenGui
local function getScreenGui()
    if not ScreenGui then
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "LoadingGui"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    return ScreenGui
end

function LoadingLib:CreateLoading(config)
    local Title = config.Title or "Loading Script"
    local Content = config.Content or "Loading..."
    local Image = config.Image or "" -- URL của hình ảnh

    local ScreenGui = getScreenGui()
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 120)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -60) -- Giữa màn hình
    MainFrame.BackgroundTransparency = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Nền đen
    MainFrame.Parent = ScreenGui

    -- Corner
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = MainFrame

    -- Image (bên trái)
    local Icon
    if Image ~= "" then
        Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0, 40, 0, 40)
        Icon.Position = UDim2.new(0, 10, 0, 10)
        Icon.BackgroundTransparency = 1
        Icon.Image = Image -- Sử dụng URL hình ảnh
        Icon.Parent = MainFrame
    end

    -- Title (FINN HUB UI)
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 240, 0, 20)
    TitleLabel.Position = UDim2.new(0, Image ~= "" and 60 or 10, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "FINN HUB UI"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextScaled = true
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Parent = MainFrame

    -- Script Name
    local ScriptLabel = Instance.new("TextLabel")
    ScriptLabel.Size = UDim2.new(0, 240, 0, 20)
    ScriptLabel.Position = UDim2.new(0, Image ~= "" and 60 or 10, 0, 35)
    ScriptLabel.BackgroundTransparency = 1
    ScriptLabel.Text = "Loading Script [spin loading animation]"
    ScriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptLabel.TextScaled = true
    ScriptLabel.TextXAlignment = Enum.TextXAlignment.Left
    ScriptLabel.Font = Enum.Font.SourceSans
    ScriptLabel.Parent = MainFrame

    -- Content (Name Script)
    local ContentLabel = Instance.new("TextLabel")
    ContentLabel.Size = UDim2.new(0, 240, 0, 20)
    ContentLabel.Position = UDim2.new(0, Image ~= "" and 60 or 10, 0, 55)
    ContentLabel.BackgroundTransparency = 1
    ContentLabel.Text = "[" .. Title .. "]"
    ContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ContentLabel.TextScaled = true
    ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    ContentLabel.Font = Enum.Font.SourceSans
    ContentLabel.Parent = MainFrame

    -- Loading Bar Background
    local BarFrame = Instance.new("Frame")
    BarFrame.Size = UDim2.new(0, 280, 0, 10)
    BarFrame.Position = UDim2.new(0, 10, 1, -20)
    BarFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    BarFrame.Parent = MainFrame

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 5)
    BarCorner.Parent = BarFrame

    -- Loading Bar Fill
    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BarFill.Parent = BarFrame

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 5)
    FillCorner.Parent = BarFill

    -- Percentage Text
    local PercentLabel = Instance.new("TextLabel")
    PercentLabel.Size = UDim2.new(0, 280, 0, 20)
    PercentLabel.Position = UDim2.new(0, 10, 1, -40)
    PercentLabel.BackgroundTransparency = 1
    PercentLabel.Text = "0% [spin loading animation]"
    PercentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    PercentLabel.TextScaled = true
    PercentLabel.TextXAlignment = Enum.TextXAlignment.Center
    PercentLabel.Font = Enum.Font.SourceSans
    PercentLabel.Parent = MainFrame

    -- Spin Loading Animation (dùng ImageLabel xoay)
    local SpinIcon = Instance.new("ImageLabel")
    SpinIcon.Size = UDim2.new(0, 20, 0, 20)
    SpinIcon.Position = UDim2.new(0, 260, 1, -40)
    SpinIcon.BackgroundTransparency = 1
    SpinIcon.Image = "rbxassetid://6034833295" -- ID của một icon loading (bạn có thể thay đổi)
    SpinIcon.Parent = MainFrame

    -- Animation xoay cho SpinIcon
    local function spinAnimation()
        while MainFrame.Parent do
            local tween = TweenService:Create(SpinIcon, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Rotation = SpinIcon.Rotation + 360
            })
            tween:Play()
            tween.Completed:Wait()
        end
    end

    -- Animation xuất hiện
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
    MainFrame.BackgroundTransparency = 1
    local fadeIn = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
        BackgroundTransparency = 0
    })
    fadeIn:Play()

    -- Chạy animation loading từ 0% đến 100%
    spawn(function()
        spawn(spinAnimation) -- Bắt đầu animation xoay
        for i = 0, 100 do
            local percent = i / 100
            local barSize = UDim2.new(percent, 0, 1, 0)
            TweenService:Create(BarFill, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = barSize
            }):Play()
            PercentLabel.Text = tostring(i) .. "% [spin loading animation]"
            wait(0.05) -- Tốc độ loading (có thể điều chỉnh)
        end

        -- Animation biến mất
        local fadeOut = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
            BackgroundTransparency = 1
        })
        fadeOut:Play()
        fadeOut.Completed:Connect(function()
            MainFrame:Destroy()
        end)
    end)
end

return LoadingLib
