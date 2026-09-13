local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATAirstuck = getgenv().KATAirstuck or {
    enabled = false,
    stuck_key = Enum.KeyCode.E,
    unstuck_key = Enum.KeyCode.R,
}
local S = getgenv().KATAirstuck

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function isAlive()
    local c = LocalPlayer.Character
    if not c then return false end
    local h = c:FindFirstChildOfClass("Humanoid")
    return c:FindFirstChild("HumanoidRootPart") ~= nil and h and h.Health > 0
end

local function setAnchor(state)
    if not isAlive() then return end
    local c = LocalPlayer.Character
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local torso = c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
    if hrp then hrp.Anchored = state end
    if torso then torso.Anchored = state end
    S.enabled = state
    notify(state and "Airstuck ON" or "Airstuck OFF")
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == S.stuck_key then
        setAnchor(true)
    elseif input.KeyCode == S.unstuck_key then
        setAnchor(false)
    end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "KATAirstuck"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function() gui.Parent = gethui() end)

local function makeBtn(text, y, callback)
    local b = Instance.new("TextButton")
    b.Parent = gui
    b.Size = UDim2.new(0, 90, 0, 34)
    b.Position = UDim2.new(0, 10, 0.5, y)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.Text = text
    b.Font = Enum.Font.GothamSemibold
    b.TextColor3 = Color3.fromRGB(255, 15, 231)
    b.TextSize = 14
    b.BorderSizePixel = 0
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback)
    return b
end

makeBtn("Stuck (E)", -20, function() setAnchor(true) end)
makeBtn("Unstuck (R)", 20, function() setAnchor(false) end)

return true