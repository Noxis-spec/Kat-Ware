local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATBHop = getgenv().KATBHop or {
    enabled = false,
}
local S = getgenv().KATBHop

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function isMoving()
    local c = LocalPlayer.Character
    if not c then return false end
    local h = c:FindFirstChildOfClass("Humanoid")
    if not h then return false end
    return h.MoveDirection.Magnitude > 0
end

local function jump()
    local c = LocalPlayer.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    if h then
        h.Jump = true
    end
end

task.spawn(function()
    while true do
        task.wait(0.05)
        if S.enabled and isMoving() then
            jump()
        end
    end
end)

getgenv().KATBHopToggle = function(state)
    S.enabled = state
    notify(state and "BHop ON" or "BHop OFF")
end

return true