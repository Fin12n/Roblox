-- LoadingLib.lua (Đặt trong ServerScriptService hoặc một ModuleScript)
local LoadingLib = {}

-- Dịch vụ cần thiết trong Roblox
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Hàm tạo màn hình Loading
function LoadingLib:CreateLoading(config)
    -- Kiểm tra config và gán giá trị mặc định
    config = config or {}
    local title = config.Title or "Default Title"
    local imageUrl = config.Image or "" -- URL hình ảnh
    local scriptName = config.ScriptName or "Default Script"

    -- Tạo ScreenGui cho từng người chơi
    for _, player in pairs(Players:GetPlayers()) do
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo ScreenGui
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "LoadingScreen"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        -- Tạo Frame chính (nền tối)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Màu nền tối
        frame.BorderSizePixel = 0
        frame.Parent = screenGui

        -- Tạo ô hình ảnh
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Size = UDim2.new(0, 100, 0, 100)
        imageLabel.Position = UDim2.new(0, 20, 0, 20)
        imageLabel.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- Màu placeholder
        imageLabel.Image = imageUrl -- URL hình ảnh từ config
        imageLabel.Parent = frame

        -- Nếu không có hình ảnh, hiển thị placeholder text
        if imageUrl == "" then
            local placeholderText = Instance.new("TextLabel")
            placeholderText.Size = UDim2.new(1, 0, 1, 0)
            placeholderText.BackgroundTransparency = 1
            placeholderText.Text = "IMAGE HERE"
            placeholderText.TextColor3 = Color3.fromRGB(0, 0, 0)
            placeholderText.TextScaled = true
            placeholderText.Parent = imageLabel
        end

        -- Tạo tiêu đề
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(0, 300, 0, 50)
        titleLabel.Position = UDim2.new(0, 140, 0, 20)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextScaled = true
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.Parent = frame

        -- Tạo tên script (subtitle)
        local scriptLabel = Instance.new("TextLabel")
        scriptLabel.Size = UDim2.new(0, 300, 0, 50)
        scriptLabel.Position = UDim2.new(0, 140, 0, 70)
        scriptLabel.BackgroundTransparency = 1
        scriptLabel.Text = "Loading Script [spin loading animation]\n[" .. scriptName .. "]"
        scriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        scriptLabel.TextScaled = true
        scriptLabel.TextWrapped = true
        scriptLabel.Font = Enum.Font.SourceSans
        scriptLabel.Parent = frame

        -- Tạo thanh tiến trình
        local progressBar = Instance.new("Frame")
        progressBar.Size = UDim2.new(0.8, 0, 0, 20)
        progressBar.Position = UDim2.new(0.1, 0, 0.8, 0)
        progressBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        progressBar.BorderSizePixel = 0
        progressBar.Parent = frame

        -- Tạo thanh tiến trình bên trong
        local progressFill = Instance.new("Frame")
        progressFill.Size = UDim2.new(0, 0, 1, 0) -- Ban đầu là 0%
        progressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        progressFill.BorderSizePixel = 0
        progressFill.Parent = progressBar

        -- Tạo nhãn phần trăm
        local progressLabel = Instance.new("TextLabel")
        progressLabel.Size = UDim2.new(0, 200, 0, 20)
        progressLabel.Position = UDim2.new(0.5, -100, 0, -30)
        progressLabel.BackgroundTransparency = 1
        progressLabel.Text = "0% [spin loading animation]"
        progressLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        progressLabel.TextScaled = true
        progressLabel.Parent = progressBar

        -- Tạo hiệu ứng tiến trình (giả lập loading)
        local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
        local tween = TweenService:Create(progressFill, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
        tween:Play()

        -- Cập nhật nhãn phần trăm
        local startTime = tick()
        while tick() - startTime < 3 do
            local elapsed = tick() - startTime
            local percent = math.clamp(elapsed / 3, 0, 1) * 100
            progressLabel.Text = math.floor(percent) .. "% [spin loading animation]"
            task.wait()
        end

        -- Sau khi hoàn tất, xóa màn hình Loading
        screenGui:Destroy()
    end
end

-- Trả về thư viện
return LoadingLib
