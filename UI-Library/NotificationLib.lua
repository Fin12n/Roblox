local NotifyLib = {}
-- Gui to Lua
-- Version: 3.2

-- Game Services

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local playergui = lp:WaitForChild("PlayerGui")

-- Varibles



-- Instances:

local Notify = Instance.new("ScreenGui")
local BG = Instance.new("Frame")
local Line = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Content = Instance.new("TextLabel")

--Properties:

Notify.Name = "Notify"
Notify.Parent = playergui
Notify.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

BG.Name = "BG"
BG.Parent = Notify
BG.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
BG.BackgroundTransparency = 0.300
BG.BorderColor3 = Color3.fromRGB(0, 0, 0)
BG.BorderSizePixel = 0
BG.Position = UDim2.new(5,0,5,0)
BG.Size = UDim2.new(0, 250, 0, 100)

UICorner.Parent = BG

Title.Name = "Title"
Title.Parent = BG
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 0, -0.0799999982, 0)
Title.Size = UDim2.new(0, 250, 0, 50)
Title.Font = Enum.Font.Bangers
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20.000

Content.Name = "Content"
Content.Parent = BG
Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Content.BackgroundTransparency = 1.000
Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
Content.BorderSizePixel = 0
Content.Position = UDim2.new(0, 0, 0.25, 0)
Content.Size = UDim2.new(0, 264, 0, 75)
Content.Font = Enum.Font.LuckiestGuy
Content.TextColor3 = Color3.fromRGB(255, 255, 255)
Content.TextSize = 14.000

Line.Name = "Line"
Line.Parent = BG
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0, 0, 0.959999979, 0)
Line.Size = UDim2.new(0, 251, 0, 4)

-- Tween Service

local durationgoal = { Size = UDim2.new(0,0,0,4) }

local whennoptify = { Position = UDim2.new(0.862950981, 0, 0.852484345, 0) }

local notnotify = { Position = UDim2.new(5,0,5,0) }

local tweeninfo = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.InOut
)

local notifyTween = TweenService:Create(BG, tweeninfo, whennoptify)
local notnotifytween = TweenService:Create(BG, tweeninfo, notnotify)

-- Notify Function


function NotifyLib.notify(title, message, duration) -- Changed to NotifyLib.notify
	if duration == nil then
		duration = 3
	end
	local durationinfo = TweenInfo.new(
		duration,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.InOut
	)
	local durationtween = TweenService:Create(Line, durationinfo, durationgoal)
	Title.Text = title
	Content.Text = message
	notifyTween:Play()
	durationtween:Play()
	task.wait(duration)
	notnotifytween:Play()
	task.wait(duration)
	Notify:Destroy()
end

return NotifyLib
