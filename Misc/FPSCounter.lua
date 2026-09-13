local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

getgenv().KATFPS = getgenv().KATFPS or {
    enabled = true,
    accent = Color3.fromRGB(255, 15, 231),
}
local S = getgenv().KATFPS

local gui = Instance.new("ScreenGui")
gui.Name = "KATFPS"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function() gui.Parent = gethui() end)

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 190, 0, 44)
frame.Position = UDim2.new(0, 14, 0, 14)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = S.enabled

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = S.accent
stroke.Thickness = 1
stroke.Transparency = 0.5

local glow = Instance.new("ImageLabel")
glow.Parent = frame
glow.BackgroundTransparency = 1
glow.Position = UDim2.new(0, -10, 0, -10)
glow.Size = UDim2.new(1, 20, 1, 20)
glow.Image = "rbxassetid://5028857084"
glow.ImageColor3 = S.accent
glow.ImageTransparency = 0.85
glow.ZIndex = 0

local title = Instance.new("TextLabel")
title.Parent = frame
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 12, 0, 4)
title.Size = UDim2.new(1, -50, 0, 14)
title.Font = Enum.Font.GothamBold
title.Text = "KATWare"
title.TextColor3 = S.accent
title.TextSize = 11
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Parent = frame
fpsLabel.BackgroundTransparency = 1
fpsLabel.Position = UDim2.new(0, 12, 0, 18)
fpsLabel.Size = UDim2.new(0.5, -6, 0, 20)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.Text = "FPS: --"
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.TextSize = 14
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.ZIndex = 2

local pingLabel = Instance.new("TextLabel")
pingLabel.Parent = frame
pingLabel.BackgroundTransparency = 1
pingLabel.Position = UDim2.new(0.5, 0, 0, 18)
pingLabel.Size = UDim2.new(0.5, -30, 0, 20)
pingLabel.Font = Enum.Font.GothamBold
pingLabel.Text = "Ping: --"
pingLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
pingLabel.TextSize = 14
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.ZIndex = 2

local close = Instance.new("TextButton")
close.Parent = frame
close.Position = UDim2.new(1, -24, 0, 8)
close.Size = UDim2.new(0, 16, 0, 16)
close.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 10
close.BorderSizePixel = 0
close.AutoButtonColor = false
close.ZIndex = 3
local cc = Instance.new("UICorner", close)
cc.CornerRadius = UDim.new(0, 4)

local fps = 0
RunService.RenderStepped:Connect(function()
    fps = fps + 1
end)

task.spawn(function()
    while true do
        task.wait(1)
        if S.enabled then
            local ping = 0
            pcall(function()
                ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            fpsLabel.Text = "FPS: " .. fps
            pingLabel.Text = "Ping: " .. ping
            if fps >= 50 then
                fpsLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
            elseif fps >= 25 then
                fpsLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
            else
                fpsLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            end
            fps = 0
        end
    end
end)

close.MouseButton1Click:Connect(function()
    frame.Visible = false
    S.enabled = false
end)

getgenv().KATFPSToggle = function(state)
    S.enabled = state
    frame.Visible = state
end

getgenv().KATFPShow = function()
    frame.Visible = true
    S.enabled = true
end

return true