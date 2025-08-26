-- Touch Fling GUI (Fixed Version)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create GUI Elements
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local HeaderFrame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")

-- Properties
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.388539821, 0, 0.427821517, 0)
Frame.Size = UDim2.new(0, 158, 0, 110)
Frame.Active = true
Frame.Draggable = true

HeaderFrame.Parent = Frame
HeaderFrame.Name = "HeaderFrame"
HeaderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
HeaderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
HeaderFrame.BorderSizePixel = 0
HeaderFrame.Size = UDim2.new(0, 158, 0, 25)

TextLabel.Parent = HeaderFrame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.112792775, 0, -0.0151660154, 0)
TextLabel.Size = UDim2.new(0, 121, 0, 26)
TextLabel.Font = Enum.Font.Sarpanch
TextLabel.Text = "Touch Fling"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
TextLabel.TextSize = 25.000

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.113924049, 0, 0.418181807, 0)
TextButton.Size = UDim2.new(0, 121, 0, 37)
TextButton.Font = Enum.Font.SourceSansItalic
TextButton.Text = "OFF"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 20.000

-- Script Variables
local hiddenfling = false
local flingConnection

-- Detection system (optional - for anti-cheat detection)
if not ReplicatedStorage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
    local detection = Instance.new("Decal")
    detection.Name = "juisdfj0i32i0eidsuf0iok"
    detection.Parent = ReplicatedStorage
end

-- Fling function
local function startFling()
    local player = Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart then
        return
    end
    
    local originalVelocity = Vector3.new(0, 0, 0)
    local moveDirection = 0.1
    
    flingConnection = RunService.Heartbeat:Connect(function()
        if not hiddenfling then
            flingConnection:Disconnect()
            return
        end
        
        -- Update character reference in case of respawn
        character = player.Character
        humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if humanoidRootPart then
            originalVelocity = humanoidRootPart.Velocity
            
            -- Apply extreme velocity
            humanoidRootPart.Velocity = originalVelocity * 10000 + Vector3.new(0, 10000, 0)
            
            -- Wait a frame then reset
            RunService.RenderStepped:Wait()
            humanoidRootPart.Velocity = originalVelocity
            
            -- Small movement variation
            RunService.Stepped:Wait()
            humanoidRootPart.Velocity = originalVelocity + Vector3.new(0, moveDirection, 0)
            moveDirection = -moveDirection
        end
    end)
end

local function stopFling()
    hiddenfling = false
    if flingConnection then
        flingConnection:Disconnect()
        flingConnection = nil
    end
end

-- Button click handler
TextButton.MouseButton1Click:Connect(function()
    hiddenfling = not hiddenfling
    TextButton.Text = hiddenfling and "ON" or "OFF"
    TextButton.BackgroundColor3 = hiddenfling and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
    
    if hiddenfling then
        startFling()
    else
        stopFling()
    end
end)

-- Cleanup on player leaving
Players.PlayerRemoving:Connect(function(player)
    if player == Players.LocalPlayer then
        stopFling()
    end
end)
