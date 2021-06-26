--> Tower Of Hell <--

if game.PlaceId ~= 1962086868 then return end

--> Setting Up The UI Libary <--

local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/RobloxAvatar/DiscordLib/main/UiLib"))()

local win = DiscordLib:Window("Tower Of Hell")

local serv = win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")

local btns = serv:Channel("Main")

local service = win:Server("Extra", "http://www.roblox.com/asset/?id=6031075938")

local servicebtns = service:Channel("Extra")

--> Bypassing The Anti Cheat <--

local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall

gmt.__namecall = newcclosure(function(self, ...)
    local Args = {...}
    local method = getnamecallmethod()
    if method == "Kick" then
        return
    end
    return oldNamecall(self, ...)
end)
setreadonly(gmt, true)
if game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("LocalScript2") then
    game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript2:Destroy()
end
if game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("LocalScript") then
    game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript:Destroy()
end

DiscordLib:Notification("Notification", "Bypassed the anti cheat!", "Okay!")

--> Scripting <--

btns:Button("Complete Tower", function()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108.503464, 297.198853, 0.303319454, 0.000167509439, 1.3760517e-07, 1, 1.54421476e-09, 1, -1.37605426e-07, -1, 1.56726498e-09, 0.000167509439)
    DiscordLib:Notification("Notification", "completed the tower!", "Okay!")
end)

btns:Button("Give All Tools", function()
    for i,v in pairs (game:GetService("ReplicatedStorage").Gear:GetChildren()) do
        if v:IsA("Tool") then
            tool = v:Clone()
            tool.Parent = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
        end
    end
    DiscordLib:Notification("Notification", "gived all of the tools!", "Okay!")
end)

btns:Button("Remove All Tools", function()
    for i,v in pairs (game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            v:Destroy()
        end
    end
    DiscordLib:Notification("Notification", "removed all of the tools!", "Okay!")
end)

local sldr1 = btns:Slider("Walkspeed", 16, 100, 16, function(t)
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = t
end)

local sldr2 = btns:Slider("JumpPower", 50, 175, 50, function(t)
    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = t
end)

getgenv().infinitejumpEnabled = false

btns:Toggle("Infinite Jump",getgenv().infinitejumpEnabled, function(bool)
    if getgenv().infinitejumpEnabled == false then
        getgenv().infinitejumpEnabled = true
        DiscordLib:Notification("Notification", "infinite jump enabled!", "Okay!")
        game:GetService("UserInputService").JumpRequest:Connect(function()
	        if getgenv().infinitejumpEnabled then
		        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	        end
        end)
    else
        if getgenv().infinitejumpEnabled == true then
            getgenv().infinitejumpEnabled = false
            DiscordLib:Notification("Notification", "infinite jump disabled!", "Okay!")
        end
    end
end)

local LocalPlayer = game:GetService("Players").LocalPlayer

local function Invincibility()
    if LocalPlayer.Character then
        for i, v in pairs(LocalPlayer.Character:GetChildren()) do
            if v.Name == "hitbox" then
                v:Destroy()
            end
        end
    end
end

getgenv().Invincibility = false

btns:Toggle("Invincibility",getgenv().Invincibility, function(bool)
    if getgenv().Invincibility == false then
        getgenv().Invincibility = true
        DiscordLib:Notification("Notification", "invincibility enabled!", "Okay!")
        while wait(0.5) do
            if getgenv().Invincibility == true then
                Invincibility(LocalPlayer)
            end
        end
    else
        if getgenv().Invincibility == true then
            getgenv().Invincibility = false
            oldpos = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
            game:GetService("Players").LocalPlayer.Character:BreakJoints()
            wait(2.5)
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
            DiscordLib:Notification("Notification", "invincibility disabled!", "Okay!")
        end
    end
end)

getgenv().audioId = nil
local SoundId = nil

servicebtns:Textbox("Audio Id", "Type here!", true, function(Id)
    getgenv().audioId = Id
	SoundId = getgenv().audioId
	local Asset = game:GetService("MarketplaceService"):GetProductInfo(SoundId)
    game:GetService("Players").LocalPlayer.PlayerGui.Music.Frame.title.Text = Asset.Name
	game:GetService("Players").LocalPlayer.PlayerGui.Music.Frame.music.SoundId = "rbxassetid://"..getgenv().audioId
    game:GetService("Players").LocalPlayer.PlayerGui.Music.Frame.music.TimePosition = 0
    DiscordLib:Notification("Notification", "music playing(" .. Asset.Name .. ")!", "Okay!")
end)

local sldr3 = servicebtns:Slider("Sound Volume", 0, 1, 0, function(s)
    game:GetService("Players").LocalPlayer.PlayerGui.Music.Frame.music.Volume = s
end)

getgenv().mute = false

servicebtns:Toggle("Mute/Unmute",getgenv().mute, function(bool)
    if getgenv().mute == false then
        getgenv().mute = true
        game:GetService("Players").LocalPlayer.PlayerGui.Music.Frame.music.Playing = false
        DiscordLib:Notification("Notification", "music muted!", "Okay!")
    else
        if getgenv().mute == true then
            getgenv().mute = false
            game:GetService("Players").LocalPlayer.PlayerGui.Music.Frame.music.Playing = true
            DiscordLib:Notification("Notification", "music unmuted!", "Okay!")
        end
    end
end)
