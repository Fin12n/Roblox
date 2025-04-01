-- LoadingLib.lua
local LoadingLib = {}

-- Dịch vụ cần thiết
local TweenService = game:GetService("TweenService")

-- Hàm tạo màn hình Loading
function LoadingLib:CreateLoading(config)
    -- Kiểm tra config và gán giá trị mặc định
    config = config or {}
    local title = config.Title or "Default Title"
    local imageUrl = config.Image or "" -- URL hình ảnh
    local scriptName = config.ScriptName or "Default Script"

    -- Tạo ScreenGui (trong môi trường exploit, sử dụng PlayerGui của LocalPlayer)
    local player = game:GetService("Players").LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    -- Tạo ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoadingScreen"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- Tạo Frame chính (kích thước 500x300)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 500, 0, 300) -- Kích thước 500x300 pixels
    frame.Position = UDim2.new(0.5, -250, 0.5, -150) -- Đặt ở giữa màn hình
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Màu nền tối
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    -- Bo góc cho Frame chính (UI)
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 15) -- Bo góc 15 pixels
    frameCorner.Parent = frame

    -- Animation In: Phóng to từ 0% lên 100%
    frame.Size = UDim2.new(0, 0, 0, 0) -- Ban đầu thu nhỏ về 0
    local inTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local inTween = TweenService:Create(frame, inTweenInfo, {Size = UDim2.new(0, 500, 0, 300)})
    inTween:Play()

    -- Tạo ô hình ảnh (kích thước 80x80)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 80, 0, 80)
    imageLabel.Position = UDim2.new(0, 10, 0, 10)
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
    titleLabel.Size = UDim2.new(0, 400, 0, 40)
    titleLabel.Position = UDim2.new(0, 100, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = frame

    -- Tạo tên script (subtitle)
    local scriptLabel = Instance.new("TextLabel")
    scriptLabel.Size = UDim2.new(0, 400, 0, 60)
    scriptLabel.Position = UDim2.new(0, 100, 0, 50)
    scriptLabel.BackgroundTransparency = 1
    scriptLabel.Text = "Loading Script\n[" .. scriptName .. "]"
    scriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptLabel.TextScaled = true
    scriptLabel.TextWrapped = true
    scriptLabel.Font = Enum.Font.SourceSans
    scriptLabel.Parent = frame

    -- Tạo thanh tiến trình
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 480, 0, 15)
    progressBar.Position = UDim2.new(0, 10, 0, 260)
    progressBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = frame

    -- Bo góc cho thanh tiến trình
    local progressBarCorner = Instance.new("UICorner")
    progressBarCorner.CornerRadius = UDim.new(0, 5) -- Bo góc 5 pixels
    progressBarCorner.Parent = progressBar

    -- Tạo thanh tiến trình bên trong
    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0) -- Ban đầu là 0%
    progressFill.BackgroundColor3 = Color3.fromRGB(150, 150, 150) -- Màu xám ban đầu
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressBar

    -- Bo góc cho thanh tiến trình bên trong
    local progressFillCorner = Instance.new("UICorner")
    progressFillCorner.CornerRadius = UDim.new(0, 5)
    progressFillCorner.Parent = progressFill

    -- Tạo nhãn phần trăm
    local progressLabel = Instance.new("TextLabel")
    progressLabel.Size = UDim2.new(0, 100, 0, 20)
    progressLabel.Position = UDim2.new(0, 10, 0, -25)
    progressLabel.BackgroundTransparency = 1
    progressLabel.Text = "0%"
    progressLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    progressLabel.TextScaled = true
    progressLabel.Parent = progressBar

    -- Tạo spinner (vòng tròn các chấm quay)
    local spinnerFrame = Instance.new("Frame")
    spinnerFrame.Size = UDim2.new(0, 40, 0, 40)
    spinnerFrame.Position = UDim2.new(1, -50, 0, -45)
    spinnerFrame.BackgroundTransparency = 1
    spinnerFrame.Parent = progressBar

    -- Tạo 8 chấm cho spinner
    local numDots = 8
    local dotSize = 8
    local radius = 15
    for i = 1, numDots do
        local angle = (i - 1) * (2 * math.pi / numDots)
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, dotSize, 0, dotSize)
        dot.Position = UDim2.new(0.5, math.cos(angle) * radius - dotSize / 2, 0.5, math.sin(angle) * radius - dotSize / 2)
        dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        dot.BorderSizePixel = 0
        dot.BackgroundTransparency = 1
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = dot
        dot.Parent = spinnerFrame

        -- Tạo hiệu ứng sáng/tối
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, (i - 1) * (1 / numDots))
        local tween = TweenService:Create(dot, tweenInfo, {BackgroundTransparency = 0})
        tween:Play()
    end

    -- Tạo hiệu ứng quay cho spinner
    local rotationTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local rotationTween = TweenService:Create(spinnerFrame, rotationTweenInfo, {Rotation = 360})
    rotationTween:Play()

    -- Tạo hiệu ứng tiến trình (thanh loading process)
    local fillTweenInfo = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local fillTween = TweenService:Create(progressFill, fillTweenInfo, {
        Size = UDim2.new(1, 0, 1, 0), -- Tăng kích thước từ 0% đến 100%
        BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Chuyển màu từ xám sang trắng
    })
    fillTween:Play()

    -- Cập nhật nhãn phần trăm
    local startTime = tick()
    while tick() - startTime < 3 do
        local elapsed = tick() - startTime
        local percent = math.clamp(elapsed / 3, 0, 1) * 100
        progressLabel.Text = math.floor(percent) .. "%"
        task.wait()
    end

    -- Animation Out: Thu nhỏ trước khi xóa
    local outTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local outTween = TweenService:Create(frame, outTweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
    outTween:Play()
    outTween.Completed:Wait() -- Đợi animation hoàn tất

    -- Xóa màn hình Loading
    screenGui:Destroy()
end

-- Trả về thư viện
return LoadingLib
