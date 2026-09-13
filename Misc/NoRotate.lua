local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATNoRotate = getgenv().KATNoRotate or {
    enabled = false,
}
local S = getgenv().KATNoRotate

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function apply()
    local c = LocalPlayer.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    if h then
        h.AutoRotate = not S.enabled
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    apply()
end)

getgenv().KATNoRotateToggle = function(state)
    S.enabled = state
    apply()
    notify(state and "No Rotate ON" or "No Rotate OFF")
end

return true