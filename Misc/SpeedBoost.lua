local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATSpeedBoost = getgenv().KATSpeedBoost or {
    enabled = false,
    speed = 50,
    default_walkspeed = 16,
}
local S = getgenv().KATSpeedBoost

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function applySpeed()
    local c = LocalPlayer.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    if not h then return end
    if S.enabled then
        h.WalkSpeed = S.speed
    else
        h.WalkSpeed = S.default_walkspeed
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applySpeed()
end)

RunService.Heartbeat:Connect(function()
    if S.enabled then
        applySpeed()
    end
end)

getgenv().KATSpeedBoostToggle = function(state)
    S.enabled = state
    applySpeed()
    notify(state and "Speed Boost ON" or "Speed Boost OFF")
end

getgenv().KATSpeedBoostSet = function(v)
    S.speed = v
    applySpeed()
end

return true