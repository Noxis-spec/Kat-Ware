local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

getgenv().KATMousePos = getgenv().KATMousePos or {
    enabled = false,
    accent = Color3.fromRGB(255, 15, 231),
}
local S = getgenv().KATMousePos

local gui = Instance.new("ScreenGui")
gui.Name = "KATMousePos"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function() gui.Parent = gethui() end)

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 170, 0, 34)
frame.Position = UDim2.new(0, 14, 0, 70)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = S.enabled

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = S.accent
stroke.Thickness = 1
stroke.Transparency = 0.5

local label = Instance.new("TextLabel")
label.Parent = frame
label.BackgroundTransparency = 1
label.Size = UDim2.new(1, 0, 1, 0)
label.Font = Enum.Font.GothamSemibold
label.Text = "Mouse: --, --"
label.TextColor3 = S.accent
label.TextSize = 13

local lastPos = Vector2.new(0, 0)
local isMouse = true

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        lastPos = Vector2.new(input.Position.X, input.Position.Y)
        isMouse = true
    elseif input.UserInputType == Enum.UserInputType.Touch then
        lastPos = Vector2.new(input.Position.X, input.Position.Y)
        isMouse = false
    end
end)

RunService.RenderStepped:Connect(function()
    if S.enabled then
        local prefix = isMouse and "Mouse: " or "Touch: "
        label.Text = prefix .. math.floor(lastPos.X) .. ", " .. math.floor(lastPos.Y)
    end
end)

getgenv().KATMousePosToggle = function(state)
    S.enabled = state
    frame.Visible = state
end

return true