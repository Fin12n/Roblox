local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Fin12n/Roblox/refs/heads/main/UI-Library/NotificationLib.lua"))
local LoadingLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Fin12n/Roblox/refs/heads/main/UI-Library/Loading.lua"))()

if game.Placeid == "12716055617" then 
    LoadingLib:CreateLoading({
        Title = "FINN HUB",
        Image = "rbxassetid://137595879440980", -- Thay bằng ID hình ảnh hợp lệ
        ScriptName = "Emergency Emden Menu"
    })
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Fin12n/Roblox/refs/heads/main/Script/Emden.lua"))
    NotifyLib:Notification({
        Title = "Game Detected ❗",
        Content = "Emergency Emden",
        Image = "137595879440980",
        Duration = 5
    })
end
if game.Placeid == "286090429" then 
    LoadingLib:CreateLoading({
        Title = "FINN HUB",
        Image = "rbxassetid://137595879440980", -- Thay bằng ID hình ảnh hợp lệ
        ScriptName = "Arsenal Menu"
    })
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Fin12n/Roblox/refs/heads/main/Script/Arsenal.lua"))
    NotifyLib:Notification({
        Title = "Game Detected ❗",
        Content = "Arsenal",
        Image = "137595879440980",
        Duration = 5
    })
end
