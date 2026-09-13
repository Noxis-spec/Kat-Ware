local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

getgenv().KATPlayerInfo = getgenv().KATPlayerInfo or {
    accent = Color3.fromRGB(255, 15, 231),
    enabled = true,
}
local S = getgenv().KATPlayerInfo

local gui = Instance.new("ScreenGui")
gui.Name = "KATPlayerInfo"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function() gui.Parent = gethui() end)

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 300, 0, 100)
frame.Position = UDim2.new(0.5, -150, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = S.enabled

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = S.accent
stroke.Thickness = 1
stroke.Transparency = 0.5

local avatarHolder = Instance.new("Frame")
avatarHolder.Parent = frame
avatarHolder.Position = UDim2.new(0, 12, 0, 12)
avatarHolder.Size = UDim2.new(0, 76, 0, 76)
avatarHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
avatarHolder.BorderSizePixel = 0
local ahc = Instance.new("UICorner", avatarHolder)
ahc.CornerRadius = UDim.new(0, 10)

local avatar = Instance.new("ImageLabel")
avatar.Parent = avatarHolder
avatar.BackgroundTransparency = 1
avatar.Position = UDim2.new(0, 4, 0, 4)
avatar.Size = UDim2.new(1, -8, 1, -8)
avatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
local avc = Instance.new("UICorner", avatar)
avc.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel")
title.Parent = frame
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 98, 0, 14)
title.Size = UDim2.new(1, -110, 0, 16)
title.Font = Enum.Font.GothamBold
title.Text = "Local Player"
title.TextColor3 = S.accent
title.TextSize = 11
title.TextXAlignment = Enum.TextXAlignment.Left

local displayName = Instance.new("TextLabel")
displayName.Parent = frame
displayName.BackgroundTransparency = 1
displayName.Position = UDim2.new(0, 98, 0, 32)
displayName.Size = UDim2.new(1, -110, 0, 22)
displayName.Font = Enum.Font.GothamBold
displayName.Text = LocalPlayer.DisplayName
displayName.TextColor3 = Color3.fromRGB(255, 255, 255)
displayName.TextSize = 16
displayName.TextXAlignment = Enum.TextXAlignment.Left

local username = Instance.new("TextLabel")
username.Parent = frame
username.BackgroundTransparency = 1
username.Position = UDim2.new(0, 98, 0, 56)
username.Size = UDim2.new(1, -110, 0, 18)
username.Font = Enum.Font.Gotham
username.Text = "@" .. LocalPlayer.Name
username.TextColor3 = Color3.fromRGB(180, 180, 180)
username.TextSize = 13
username.TextXAlignment = Enum.TextXAlignment.Left

local userid = Instance.new("TextLabel")
userid.Parent = frame
userid.BackgroundTransparency = 1
userid.Position = UDim2.new(0, 98, 0, 74)
userid.Size = UDim2.new(1, -110, 0, 14)
userid.Font = Enum.Font.Gotham
userid.Text = "ID: " .. LocalPlayer.UserId
userid.TextColor3 = Color3.fromRGB(140, 140, 140)
userid.TextSize = 11
userid.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton")
close.Parent = frame
close.Position = UDim2.new(1, -26, 0, 8)
close.Size = UDim2.new(0, 18, 0, 18)
close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 11
close.BorderSizePixel = 0
close.AutoButtonColor = false
local cc = Instance.new("UICorner", close)
cc.CornerRadius = UDim.new(0, 6)

pcall(function()
    local thumb = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420)
    avatar.Image = thumb
end)

close.MouseButton1Click:Connect(function()
    frame.Visible = false
    S.enabled = false
end)

getgenv().KATPlayerInfoToggle = function(state)
    S.enabled = state
    frame.Visible = state
end

getgenv().KATPlayerInfoShow = function()
    frame.Visible = true
    S.enabled = true
end

return true