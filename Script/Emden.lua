--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.8) ~  Much Love, Ferib 

]]--

local v0 = loadstring;
local v1 = loadstring([[
	local Env, upvalues = ...
	local new = newproxy(true)
	local mt = getmetatable(new)
	mt.__metatable = new
	mt.__environment = new
	mt.__index = function(t,k) return Env[k] or upvalues[k] end
	mt.__newindex = function(t,k,v)
		--if rawget(upvalues,k) then return rawset(upvalues,k,v) end
		Env[k] = v
	end
return setmetatable({},mt)
]], "");
local v2 = {};
local v3 = {};
local v4 = Instance.new("ScreenGui");
v4.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local v6 = Instance.new("Frame");
v6.Size = UDim2.new(0, 300, 0, 200);
v6.Position = UDim2.new(0.5, -150, 0.5, -100);
v6.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
v6.Parent = v4;
local v11 = Instance.new("TextLabel");
v11.Size = UDim2.new(0, 200, 0, 30);
v11.Position = UDim2.new(0.5, -100, 0.05, 0);
v11.BackgroundTransparency = 1;
v11.TextColor3 = Color3.fromRGB(255, 255, 255);
v11.Text = "Private script | By Finnn";
v11.Font = Enum.Font.SourceSansBold;
v11.TextSize = 24;
v11.Parent = v6;
local v21 = Instance.new("TextBox");
v21.Size = UDim2.new(0, 200, 0, 30);
v21.Position = UDim2.new(0.5, -100, 0.3, 0);
v21.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
v21.TextColor3 = Color3.fromRGB(255, 255, 255);
v21.PlaceholderText = "Paste key here!";
v21.Parent = v6;
local v28 = Instance.new("TextButton");
v28.Size = UDim2.new(0, 100, 0, 40);
v28.Position = UDim2.new(0.5, -50, 0.6, 0);
v28.BackgroundColor3 = Color3.fromRGB(0, 120, 215);
v28.TextColor3 = Color3.fromRGB(255, 255, 255);
v28.Text = "Check keys";
v28.Parent = v6;
local v35 = Instance.new("TextLabel");
v35.Size = UDim2.new(0, 200, 0, 20);
v35.Position = UDim2.new(0.5, -100, 0.85, 0);
v35.BackgroundTransparency = 1;
v35.TextColor3 = Color3.fromRGB(255, 255, 255);
v35.Text = "";
v35.Parent = v6;
local v42 = "finnndzvcl";
local function v43()
	local v44 = game:GetService("Players");
	local v45 = game:GetService("UserInputService");
	local v46 = game:GetService("RunService");
	local v47 = game:GetService("StarterGui");
	local v48 = v44.LocalPlayer;
	local v49 = v48:GetMouse();
	local v50 = false;
	local v51 = 100;
	local v52 = Enum.KeyCode.X;
	local v53, v54;
	local v55 = false;
	local v56 = 150;
	local v57 = 0.1;
	local v58 = Enum.KeyCode.T;
	local v59 = false;
	local v60 = v48.Character or v48.CharacterAdded:Wait();
	local v61 = v60 and v60:FindFirstChild("HumanoidRootPart");
	local v62 = Enum.KeyCode.N;
	local v63 = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))();
	local v64 = v63.CreateLib("Emergency Emden Menu (BETA) | By Finnn", "Ocean");
	local v65 = v64:NewTab("Info");
	local v66 = v64:NewTab("Main");
	local v67 = v64:NewTab("Aimbot");
	local v68 = v64:NewTab("Teleport");
	local v69 = v64:NewTab("Other Script");
	local v70 = v64:NewTab("Settings");
	local v71 = v68:NewSection("Teleport Tab");
	local v72 = v65:NewSection("Information");
	local v73 = v66:NewSection("Main Tab");
	local v74 = v67:NewSection("Aimbot Tab");
	local v69 = v69:NewSection("Other Script");
	local v70 = v70:NewSection("Settings");
	local v75 = nil;
	local v76 = nil;
	local v77 = {};
	local v78 = {};
	local v79 = "";
	local v80 = nil;
	local function v81()
		v78 = {};
		if (v79 == "") then
			for v204, v205 in pairs(v77) do
				table.insert(v78, v205);
			end
		else
			for v206, v207 in pairs(v77) do
				if v207:lower():find(v79, 1, true) then
					table.insert(v78, v207);
				end
			end
		end
		if v80 then
			v80:Refresh(v78);
		end
	end
	function updatePlayerList()
		v77 = {};
		for v134, v135 in pairs(v44:GetPlayers()) do
			if (v135 ~= v48) then
				table.insert(v77, v135.Name);
			end
		end
		v81();
		print("Player list updated. Found " .. #v77 .. " players.");
	end
	v71:NewTextBox("Search Player", "Type to search for players", function(v103)
		v79 = v103:lower();
		v81();
	end);
	v80 = v71:NewDropdown("Select Player", "Choose a player to teleport to", {}, function(v104)
		v75 = v44:FindFirstChild(v104);
		if v75 then
			print("Selected: " .. v75.Name);
		end
	end);
	v71:NewButton("Refresh Players", "Update the player list", function()
		updatePlayerList();
		print("Player list refreshed! Players found: " .. #v78);
	end);
	v71:NewButton("Teleport to Player", "Teleports you to the selected player", function()
		if (v75 and v75.Character and v75.Character:FindFirstChild("HumanoidRootPart") and v61) then
			v2[985] = v75.Character.HumanoidRootPart;
			v61.CFrame = v2[985].CFrame + Vector3.new(0, 5, 0);
			print("Teleported to " .. v75.Name);
		else
			print("No player selected or player not found");
		end
	end);
	local v82 = v68:NewSection("Quick Teleport");
	v82:NewButton("Teleport to Nearest Player", "Quickly teleport to the closest player", function()
		v2[1045] = nil;
		v2[1048] = math.huge;
		if v61 then
			for v208, v209 in pairs(v44:GetPlayers()) do
				if ((v209 ~= v48) and v209.Character and v209.Character:FindFirstChild("HumanoidRootPart")) then
					v2[1088] = (v209.Character.HumanoidRootPart.Position - v61.Position).Magnitude;
					if (v2[1088] < v2[1048]) then
						v2[1048] = v2[1088];
						v2[1045] = v209;
					end
				end
			end
			if v2[1045] then
				v61.CFrame = v2[1045].Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0);
				print("Teleported to nearest player: " .. v2[1045].Name);
			else
				print("No players found nearby");
			end
		end
	end);
	local v83 = v68:NewSection("Coordinates");
	v76 = v71:NewLabel("Coords: X: 0, Y: 0, Z: 0");
	updatePlayerList();
	v44.PlayerAdded:Connect(function(v108)
		if (v108 ~= v48) then
			table.insert(v77, v108.Name);
			v81();
			print("Player added: " .. v108.Name);
		end
	end);
	v44.PlayerRemoving:Connect(function(v109)
		for v136, v137 in pairs(v77) do
			if (v137 == v109.Name) then
				table.remove(v77, v136);
				v81();
				print("Player removed: " .. v109.Name);
				break;
			end
		end
	end);
	local function v84()
		if v61 then
			v2[1272] = v61.Position;
			v76:UpdateLabel("Coords: X: " .. math.floor(v2[1272].X) .. ", Y: " .. math.floor(v2[1272].Y) .. ", Z: " .. math.floor(v2[1272].Z));
		end
	end
	v46.RenderStepped:Connect(function()
		v84();
	end);
	v48.CharacterAdded:Connect(function(v110)
		v60 = v110;
		v61 = v60:WaitForChild("HumanoidRootPart");
	end);
	print("Teleport script loaded with KavoUI! Press Y to toggle UI.");
	v72:NewLabel("Emden Script v1.2.0 (BETA)");
	v72:NewLabel("Script generated by Finnn (Private Script)");
	v72:NewLabel("[+] New Aimbot (BETA)");
	v72:NewLabel("[+] Fly (NEW)");
	v72:NewLabel("[+] Noclip (New) (BETA)");
	v72:NewLabel("[+] ESP/Glow (BETA)");
	v72:NewLabel("[+] Teleport (New) [BETA]");
	v72:NewLabel("[+] Inf Jump (New) [BETA]");
	v70:NewKeybind("Set UI Hide key", "KeybindInfo", Enum.KeyCode.V, function()
		v63:ToggleUI();
	end);
	v70:NewLabel("Change ur on/off UI (Default: V)");
	v73:NewButton("Fly (Press `X` to fly [BETA]", "Press `O` to fly", function()
		v73:NewSlider("Fly speed", "Change yout speed when u fly", 500, 0, function(v138)
			v51 = v138;
		end);
		v73:NewLabel("Dont fly in water and fly in wall\nU will ban");
		v48.CharacterAdded:Connect(function(v139)
			v60 = v139;
			v61 = v60:WaitForChild("HumanoidRootPart");
			if v50 then
				startFlying();
			end
		end);
		local function v111()
			if (v61 and not v53 and not v54) then
				v53 = Instance.new("BodyVelocity");
				v53.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
				v53.Velocity = Vector3.new(0, 0, 0);
				v53.Parent = v61;
				v54 = Instance.new("BodyGyro");
				v54.MaxTorque = Vector3.new(math.huge, math.huge, math.huge);
				v54.P = 20000;
				v54.D = 2000;
				v54.CFrame = CFrame.new(v61.Position) * CFrame.Angles(0, 0, 0);
				v54.Parent = v61;
			end
		end
		local function v112()
			if v53 then
				v53:Destroy();
			end
			if v54 then
				v54:Destroy();
			end
			v53 = nil;
			v54 = nil;
		end
		v46.RenderStepped:Connect(function()
			if (v50 and v60 and v61 and v53 and v54) then
				v2[1712] = v60:FindFirstChild("Humanoid");
				if v2[1712] then
					v2[1723] = v2[1712].MoveDirection;
					v2[1729] = 0;
					if v45:IsKeyDown(Enum.KeyCode.Space) then
						v2[1729] = v51;
					elseif v45:IsKeyDown(Enum.KeyCode.LeftControl) then
						v2[1729] = -v51;
					end
					v2[1770] = Vector3.new(v2[1723].X * v51, v2[1729], v2[1723].Z * v51);
					v53.Velocity = v2[1770];
					v2[1800] = CFrame.new(v61.Position) * CFrame.Angles(0, v61.Orientation.Y, 0);
					v54.CFrame = v2[1800];
				end
			end
		end);
		v45.InputBegan:Connect(function(v140, v141)
			if ((v140.KeyCode == v52) and not v141) then
				v50 = not v50;
				if v50 then
					v111();
				else
					v112();
				end
			end
		end);
	end);
	v73:NewButton("Noclip Press `N` to Noclip", "Press `N` to Noclip", function()
		local function v113()
			v59 = not v59;
			if v59 then
				for v225, v226 in pairs(v60:GetDescendants()) do
					if v226:IsA("BasePart") then
						v226.CanCollide = false;
					end
				end
			else
				for v227, v228 in pairs(v60:GetDescendants()) do
					if v228:IsA("BasePart") then
						v228.CanCollide = true;
					end
				end
			end
		end
		v45.InputBegan:Connect(function(v142, v143)
			if ((v142.KeyCode == v62) and not v143) then
				v113();
			end
		end);
		v48.CharacterAdded:Connect(function(v144)
			v60 = v144;
			if v59 then
				for v229, v230 in pairs(v60:GetDescendants()) do
					if v230:IsA("BasePart") then
						v230.CanCollide = false;
					end
				end
			end
		end);
	end);
	local v85 = false;
	local v86 = {};
	local function v87(v114)
		if v114.Character then
			v2[2045] = v114.Character;
			v2[2051] = v2[2045]:WaitForChild("Head", 5);
			if (v2[2051] and not v86[v114]) then
				v2[2068] = Instance.new("Highlight");
				v2[2068].Name = "ESPGlow";
				v2[2068].FillColor = Color3.fromRGB(255, 255, 255);
				v2[2068].OutlineColor = Color3.fromRGB(255, 255, 255);
				v2[2068].FillTransparency = 0.3;
				v2[2068].OutlineTransparency = 0;
				v2[2068].DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
				v2[2068].Parent = v2[2045];
				v2[2166] = Instance.new("BillboardGui");
				v2[2166].Name = "ESPName";
				v2[2166].Size = UDim2.new(0, 150, 0, 40);
				v2[2166].StudsOffset = Vector3.new(0, 3, 0);
				v2[2166].AlwaysOnTop = true;
				v2[2166].Parent = v2[2051];
				v2[2239] = Instance.new("TextLabel");
				v2[2239].Size = UDim2.new(1, 0, 0.5, 0);
				v2[2239].Position = UDim2.new(0, 0, 0, 0);
				v2[2239].BackgroundTransparency = 1;
				v2[2239].Text = v114.Name;
				v2[2239].TextColor3 = Color3.fromRGB(255, 255, 255);
				v2[2239].TextSize = 18;
				v2[2239].Font = Enum.Font.SourceSansBold;
				v2[2239].TextScaled = false;
				v2[2239].Parent = v2[2166];
				v2[2369] = Instance.new("TextLabel");
				v2[2369].Size = UDim2.new(1, 0, 0.5, 0);
				v2[2369].Position = UDim2.new(0, 0, 0.5, 0);
				v2[2369].BackgroundTransparency = 1;
				v2[2369].Text = "N/A";
				v2[2369].TextColor3 = Color3.fromRGB(255, 255, 255);
				v2[2369].TextSize = 14;
				v2[2369].Font = Enum.Font.SourceSans;
				v2[2369].TextScaled = false;
				v2[2369].Parent = v2[2166];
				v86[v114] = {Highlight=v2[2068],Billboard=v2[2166],DistanceLabel=v2[2369]};
			end
			v114.CharacterAdded:Connect(function(v219)
				v2[2524] = v219:WaitForChild("Head", 5);
				if (v2[2524] and v85) then
					if v86[v114] then
						if v86[v114].Highlight then
							v86[v114].Highlight:Destroy();
						end
						if v86[v114].Billboard then
							v86[v114].Billboard:Destroy();
						end
					end
					v2[2579] = Instance.new("Highlight");
					v2[2579].Name = "ESPGlow";
					v2[2579].FillColor = Color3.fromRGB(255, 255, 255);
					v2[2579].OutlineColor = Color3.fromRGB(255, 255, 255);
					v2[2579].FillTransparency = 0.3;
					v2[2579].OutlineTransparency = 0;
					v2[2579].DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
					v2[2579].Parent = v219;
					v2[2677] = Instance.new("BillboardGui");
					v2[2677].Name = "ESPName";
					v2[2677].Size = UDim2.new(0, 150, 0, 40);
					v2[2677].StudsOffset = Vector3.new(0, 3, 0);
					v2[2677].AlwaysOnTop = true;
					v2[2677].Parent = v2[2524];
					v2[2750] = Instance.new("TextLabel");
					v2[2750].Size = UDim2.new(1, 0, 0.5, 0);
					v2[2750].Position = UDim2.new(0, 0, 0, 0);
					v2[2750].BackgroundTransparency = 1;
					v2[2750].Text = v114.Name;
					v2[2750].TextColor3 = Color3.fromRGB(255, 255, 255);
					v2[2750].TextSize = 18;
					v2[2750].Font = Enum.Font.SourceSansBold;
					v2[2750].TextScaled = false;
					v2[2750].Parent = v2[2677];
					v2[2880] = Instance.new("TextLabel");
					v2[2880].Size = UDim2.new(1, 0, 0.5, 0);
					v2[2880].Position = UDim2.new(0, 0, 0.5, 0);
					v2[2880].BackgroundTransparency = 1;
					v2[2880].Text = "N/A";
					v2[2880].TextColor3 = Color3.fromRGB(255, 255, 255);
					v2[2880].TextSize = 14;
					v2[2880].Font = Enum.Font.SourceSans;
					v2[2880].TextScaled = false;
					v2[2880].Parent = v2[2677];
					v86[v114] = {Highlight=v2[2579],Billboard=v2[2677],DistanceLabel=v2[2880]};
				end
			end);
		end
	end
	local function v88()
		for v145, v146 in pairs(game.Players:GetPlayers()) do
			v87(v146);
		end
	end
	local function v89()
		for v147, v148 in pairs(v86) do
			if v148.Highlight then
				v148.Highlight:Destroy();
			end
			if v148.Billboard then
				v148.Billboard:Destroy();
			end
		end
		v86 = {};
	end
	v46.RenderStepped:Connect(function()
		if v85 then
			v2[3105] = game.Players.LocalPlayer;
			v2[3114] = v2[3105].Character;
			v2[3120] = v2[3114] and v2[3114]:FindFirstChild("HumanoidRootPart");
			if v2[3120] then
				v2[3133] = v2[3120].Position;
				for v324, v325 in pairs(v86) do
					v2[3146] = v324.Character;
					v2[3152] = v2[3146] and v2[3146]:FindFirstChild("HumanoidRootPart");
					if v2[3152] then
						v2[3165] = (v2[3133] - v2[3152].Position).Magnitude;
						v325.DistanceLabel.Text = math.floor(v2[3165]) .. " studs";
					else
						v325.DistanceLabel.Text = "N/A";
					end
				end
			end
		end
	end);
	game.Players.PlayerAdded:Connect(function(v115)
		if v85 then
			v87(v115);
		end
	end);
	game.Players.PlayerRemoving:Connect(function(v116)
		if v86[v116] then
			if v86[v116].Highlight then
				v86[v116].Highlight:Destroy();
			end
			if v86[v116].Billboard then
				v86[v116].Billboard:Destroy();
			end
			v86[v116] = nil;
		end
	end);
	v73:NewButton("ESP/Glow", "Enable ESP/Glow", function()
		v85 = not v85;
		if v85 then
			v88();
		else
			v89();
		end
	end);
	v74:NewToggle("Aimbot Press `T` to toggle", "Press `T` to Enable", function(v117)
		if v117 then
			v55 = true;
			v74:NewSlider("FOV", "Change your FOV", 500, 0, function(v221)
				v56 = v221;
			end);
		else
			v55 = false;
		end
	end);
	v74:NewLabel("Hold Right Mouse Button to aim\nPress `T` to Toggle");
	v74:NewLabel("Function in this BETA (So u may Banned) BEWARE!");
	local function v90()
		v2[3377] = nil;
		v2[3380] = math.huge;
		v2[3386] = Vector2.new(v49.X, v49.Y);
		for v149, v150 in pairs(v44:GetPlayers()) do
			if ((v150 ~= v48) and v150.Character) then
				v2[3422] = v150.Character:FindFirstChild("Humanoid");
				v2[3433] = v150.Character:FindFirstChild("Head");
				if (v2[3422] and v2[3433] and (v2[3422].Health > 0)) then
					v2[3456], v2[3457] = workspace.CurrentCamera:WorldToViewportPoint(v2[3433].Position);
					if v2[3457] then
						v2[3474] = Vector2.new(v2[3456].X, v2[3456].Y);
						v2[3489] = (v2[3386] - v2[3474]).Magnitude;
						if ((v2[3489] < v2[3380]) and (v2[3489] <= v56)) then
							v2[3380] = v2[3489];
							v2[3377] = v150;
						end
					end
				end
			end
		end
		return v2[3377];
	end
	local function v91(v122)
		v2[3523] = v48.Character;
		v2[3529] = v2[3523] and v2[3523]:FindFirstChild("HumanoidRootPart");
		v2[3539] = v122.Character and v122.Character:FindFirstChild("Head");
		if (v2[3529] and v2[3539]) then
			v2[3560] = workspace.CurrentCamera;
			v2[3560].CFrame = CFrame.new(v2[3560].CFrame.Position, v2[3539].Position);
		end
	end
	v45.InputBegan:Connect(function(v127, v128)
		if ((v127.KeyCode == v58) and not v128) then
			v55 = not v55;
			v64:Notify({Title="AiMbOt St4tus",Content=((v55 and "Aimbot Enable!") or "Aimbot Disable"),Duration=3});
		end
	end);
	local v92 = false;
	v45.InputBegan:Connect(function(v129, v130)
		if ((v129.UserInputType == Enum.UserInputType.MouseButton2) and not v130) then
			v92 = true;
		end
	end);
	v45.InputEnded:Connect(function(v131)
		if (v131.UserInputType == Enum.UserInputType.MouseButton2) then
			v92 = false;
		end
	end);
	v46.RenderStepped:Connect(function()
		if (v55 and v92) then
			v2[3718] = v90();
			if v2[3718] then
				v91(v2[3718]);
				task.wait(v57);
			end
		end
	end);
	local v93 = {"Basement","Bank (out)","Vehicle spawn","Bank (in)","Diamond Store (high)","Hospital"};
	v71:NewDropdown("Teleport Location", "", v93, function(v132)
		if (v132 == "Basement") then
			v2[3771] = game.Players.LocalPlayer;
			v2[3780] = v2[3771].Character or v2[3771].CharacterAdded:Wait();
			v2[3795] = v2[3780]:WaitForChild("HumanoidRootPart");
			v2[3795].CFrame = CFrame.new(-1948, 26, 987);
			v47:SetCore("SendNotification", {Title="Emden Teleport v0.1.1",Text="Successfully 🟢",Duration=3});
		end
		if (v132 == "Bank (out)") then
			v2[3842] = game.Players.LocalPlayer;
			v2[3851] = v2[3842].Character or v2[3842].CharacterAdded:Wait();
			v2[3866] = v2[3851]:WaitForChild("HumanoidRootPart");
			v2[3866].CFrame = CFrame.new(-418, 35, -1365);
			v47:SetCore("SendNotification", {Title="Emden Teleport v0.1.1",Text="Successfully 🟢",Duration=3});
		end
		if (v132 == "Vehicle spawn") then
			v2[3914] = game.Players.LocalPlayer;
			v2[3923] = v2[3914].Character or v2[3914].CharacterAdded:Wait();
			v2[3938] = v2[3923]:WaitForChild("HumanoidRootPart");
			v2[3938].CFrame = CFrame.new(-1004, 50, 100);
			v47:SetCore("SendNotification", {Title="Emden Teleport v0.1.1",Text="Successfully 🟢",Duration=3});
		end
		if (v132 == "Bank (in)") then
			v2[3985] = game.Players.LocalPlayer;
			v2[3994] = v2[3985].Character or v2[3985].CharacterAdded:Wait();
			v2[4009] = v2[3994]:WaitForChild("HumanoidRootPart");
			v2[4009].CFrame = CFrame.new(-453, 35, -1378);
			v47:SetCore("SendNotification", {Title="Emden Teleport v0.1.1",Text="Successfully 🟢",Duration=3});
		end
		if (v132 == "Diamond Store (high)") then
			v2[4057] = game.Players.LocalPlayer;
			v2[4066] = v2[4057].Character or v2[4057].CharacterAdded:Wait();
			v2[4081] = v2[4066]:WaitForChild("HumanoidRootPart");
			v2[4081].CFrame = CFrame.new(-487, 100, 346);
			v47:SetCore("SendNotification", {Title="Emden Teleport v0.1.1",Text="Successfully 🟢",Duration=3});
		end
		if (v132 == "Hospital") then
			v2[4128] = game.Players.LocalPlayer;
			v2[4137] = v2[4128].Character or v2[4128].CharacterAdded:Wait();
			v2[4152] = v2[4137]:WaitForChild("HumanoidRootPart");
			v2[4152].CFrame = CFrame.new(539, 50, -1761);
			v47:SetCore("SendNotification", {Title="Emden Teleport v0.1.1",Text="Successfully 🟢",Duration=3});
		end
		print(v132);
	end);
	local v94 = false;
	v73:NewToggle("Infinite Jump", "", function(v133)
		v94 = v133;
		if v133 then
			v47:SetCore("SendNotification", {Title="Emden Script v1.1.5",Text="Inf Jump Enabled!",Duration=3});
		else
			v47:SetCore("SendNotification", {Title="Emden Script v1.1.5",Text="Inf Jump Disabled!",Duration=3});
		end
	end);
	game:GetService("UserInputService").JumpRequest:Connect(function()
		if v94 then
			if v60 then
				v2[4271] = v60:FindFirstChild("Humanoid");
				if v2[4271] then
					v2[4271]:ChangeState("Jumping");
				end
			end
		end
	end);
	v4:Destroy();
	local v95 = Instance.new("Part");
	v95.Position = Vector3.new(0, 10, 0);
	v95.Size = Vector3.new(5, 5, 5);
	v95.BrickColor = BrickColor.new("Bright blue");
	v95.Parent = game.Workspace;
end
v28.MouseButton1Click:Connect(function()
	v2[4373] = v21.Text;
	if (v2[4373] == v42) then
		v35.Text = "Succesfully...";
		v35.TextColor3 = Color3.fromRGB(0, 255, 0);
		wait(1);
		v43();
	else
		v35.Text = "Sorry, your key is incorrect!.";
		v35.TextColor3 = Color3.fromRGB(255, 0, 0);
		v21.Text = "";
	end
end);

Other:NewButton("Infinity Yield Script", "", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
end)
Other:NewButton("AFK Script", "", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Fin12n/Roblox/refs/heads/main/Script/AFK-Script.lua"))()
end)
