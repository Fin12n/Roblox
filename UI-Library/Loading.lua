-- Script chính (trong Solara v3)

-- Nhúng mã LoadingLib trực tiếp
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

    -- Tạo ô hình ảnh (thu nhỏ lại)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(0, 80, 0, 80) -- Thu nhỏ hình ảnh
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

    -- Tạo tiêu đề (điều chỉnh vị trí và kích thước)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 400, 0, 40) -- Thu nhỏ để vừa Frame
    titleLabel.Position = UDim2.new(0, 100, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = frame

    -- Tạo tên script (subtitle, điều chỉnh vị trí và kích thước)
    local scriptLabel = Instance.new("TextLabel")
    scriptLabel.Size = UDim2.new(0, 400, 0, 60) -- Thu nhỏ để vừa Frame
    scriptLabel.Position = UDim2.new(0, 100, 0, 50)
    scriptLabel.BackgroundTransparency = 1
    scriptLabel.Text = "Loading Script\n[" .. scriptName .. "]" -- Bỏ [spin loading animation]
    scriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptLabel.TextScaled = true
    scriptLabel.TextWrapped = true
    scriptLabel.Font = Enum.Font.SourceSans
    scriptLabel.Parent = frame

    -- Tạo thanh tiến trình (thu nhỏ lại)
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 480, 0, 15) -- Thu nhỏ để vừa Frame (480 pixels chiều rộng)
    progressBar.Position = UDim2.new(0, 10, 0, 260) -- Đặt gần đáy Frame
    progressBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = frame

    -- Tạo thanh tiến trình bên trong
    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0) -- Ban đầu là 0%
    progressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressBar

    -- Tạo nhãn phần trăm (điều chỉnh vị trí)
    local progressLabel = Instance.new("TextLabel")
    progressLabel.Size = UDim2.new(0, 100, 0, 20)
    progressLabel.Position = UDim2.new(0, 10, 0, -25) -- Đặt phía trên thanh tiến trình, bên trái
    progressLabel.BackgroundTransparency = 1
    progressLabel.Text = "0%" -- Bỏ [spin loading animation]
    progressLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    progressLabel.TextScaled = true
    progressLabel.Parent = progressBar

    -- Tạo spinner (vòng tròn các chấm quay)
    local spinnerFrame = Instance.new("Frame")
    spinnerFrame.Size = UDim2.new(0, 40, 0, 40) -- Kích thước spinner
    spinnerFrame.Position = UDim2.new(1, -50, 0, -45) -- Đặt bên phải thanh tiến trình
    spinnerFrame.BackgroundTransparency = 1
    spinnerFrame.Parent = progressBar

    -- Tạo 8 chấm cho spinner
    local numDots = 8
    local dotSize = 8 -- Kích thước mỗi chấm
    local radius = 15 -- Bán kính vòng tròn spinner
    for i = 1, numDots do
        local angle = (i - 1) * (2 * math.pi / numDots) -- Góc của mỗi chấm
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, dotSize, 0, dotSize)
        dot.Position = UDim2.new(0.5, math.cos(angle) * radius - dotSize / 2, 0.5, math.sin(angle) * radius - dotSize / 2)
        dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        dot.BorderSizePixel = 0
        dot.BackgroundTransparency = 1 -- Ban đầu ẩn
        -- Làm tròn chấm
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = dot
        dot.Parent = spinnerFrame

        -- Tạo hiệu ứng sáng/tối cho chấm
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, (i - 1) * (1 / numDots))
        local tween = TweenService:Create(dot, tweenInfo, {BackgroundTransparency = 0})
        tween:Play()
    end

    -- Tạo hiệu ứng quay cho spinner
    local rotationTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local rotationTween = TweenService:Create(spinnerFrame, rotationTweenInfo, {Rotation = 360})
    rotationTween:Play()

    -- Tạo hiệu ứng tiến trình (giả lập loading)
    local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local tween = TweenService:Create(progressFill, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
    tween:Play()

    -- Cập nhật nhãn phần trăm
    local startTime = tick()
    while tick() - startTime < 3 do
        local elapsed = tick() - startTime
        local percent = math.clamp(elapsed / 3, 0, 1) * 100
        progressLabel.Text = math.floor(percent) .. "%"
        task.wait()
    end

    -- Sau khi hoàn tất, xóa màn hình Loading
    screenGui:Destroy()
end
