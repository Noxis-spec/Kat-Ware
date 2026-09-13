local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATViewAngles = getgenv().KATViewAngles or {
    enabled = false,
    yaw = 0,
    pitch = 0,
}
local S = getgenv().KATViewAngles

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local lockedCFrame = nil

getgenv().KATViewAnglesToggle = function(state)
    S.enabled = state
    if state then
        lockedCFrame = nil
    end
    notify(state and "View Angles ON" or "View Angles OFF")
end

getgenv().KATViewAnglesSet = function(yaw, pitch)
    S.yaw = yaw or 0
    S.pitch = pitch or 0
end

RunService.RenderStepped:Connect(function()
    if not S.enabled then return end
    local cam = workspace.CurrentCamera
    if cam then
        local base = CFrame.new(cam.CFrame.Position)
        local rotation = CFrame.Angles(math.rad(S.pitch), math.rad(S.yaw), 0)
        cam.CFrame = base * rotation
    end
end)

return true