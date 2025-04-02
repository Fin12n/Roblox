local LoadingLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Fin12n/Roblox/refs/heads/main/UI-Library/Loading.lua"))()

if game.PlaceId == 12716055617 then
    LoadingLib:CreateLoading({
        Title = "FINN HUB",
        Image = "rbxassetid://137595879440980", -- Thay bằng ID hình ảnh hợp lệ
        ScriptName = "Emergency Emden Menu"
    })
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Fin12n/Roblox/refs/heads/main/Script/Emden.lua", true))()
game.StarterGui:SetCore("SendNotification", {
    Title = "Game Detected ❗";
    Text = "Emergency Emden"; -- what the text says (ofc)
    Duration = 10;
})
game.StarterGui:SetCore("SendNotification", {
    Title = "By Fjnnn From Finnn Hub";
    Text = "Have Fun!"; -- what the text says (ofc)
    Duration = 15;
})
end
