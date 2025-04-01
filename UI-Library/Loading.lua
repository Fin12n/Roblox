-- LoadingLib (ModuleScript trong ServerScriptService)
local LoadingLib = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

function LoadingLib:CreateLoading(config)
    config = config or {}
    local title = config.Title or "Default Title"
    local imageUrl = config.Image or ""
    local scriptName = config.ScriptName or "Default Script"

    for _, player in pairs(Players:GetPlayers()) do
        local playerGui = player:WaitForChild("PlayerGui")

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "LoadingScreen"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.BorderSizePixel = 0
        frame.Parent = screenGui

        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Size = UDim2.new(0, 100, 0, 100)
        imageLabel.Position = UDim2.new(0, 20, 0, 20)
        imageLabel.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        imageLabel.Image = imageUrl
        imageLabel.Parent = frame

        if imageUrl == "" then
            local placeholderText = Instance.new("TextLabel")
            placeholderText.Size = UDim2.new(1, 0, 1, 0)
            placeholderText.BackgroundTransparency = 1
            placeholderText.Text = "IMAGE HERE"
            placeholderText.TextColor3 = Color3.fromRGB(0, 0, 0)
            placeholderText.TextScaled = true
            placeholderText.Parent = imageLabel
        end

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(0, 300, 0, 50)
        titleLabel.Position = UDim2.new(0, 140, 0, 20)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextScaled = true
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.Parent = frame

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

        local progressBar = Instance.new("Frame")
        progressBar.Size = UDim2.new(0.8, 0, 0, 20)
        progressBar.Position = UDim2.new(0.1, 0, 0.8, 0)
        progressBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        progressBar.BorderSizePixel = 0
        progressBar.Parent = frame

        local progressFill = Instance.new("Frame")
        progressFill.Size = UDim2.new(0, 0, 1, 0)
        progressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        progressFill.BorderSizePixel = 0
        progressFill.Parent = progressBar

        local progressLabel = Instance.new("TextLabel")
        progressLabel.Size = UDim2.new(0, 200, 0, 20)
        progressLabel.Position = UDim2.new(0.5, -100, 0, -30)
        progressLabel.BackgroundTransparency = 1
        progressLabel.Text = "0% [spin loading animation]"
        progressLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        progressLabel.TextScaled = true
        progressLabel.Parent = progressBar

        local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
        local tween = TweenService:Create(progressFill, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
        tween:Play()

        local startTime = tick()
        while tick() - startTime < 3 do
            local elapsed = tick() - startTime
            local percent = math.clamp(elapsed / 3, 0, 1) * 100
            progressLabel.Text = math.floor(percent) .. "% [spin loading animation]"
            task.wait()
        end

        screenGui:Destroy()
    end
end

return LoadingLib
