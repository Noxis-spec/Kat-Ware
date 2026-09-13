local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

getgenv().KATHeadless = getgenv().KATHeadless or {
    enabled = false,
}
local S = getgenv().KATHeadless

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function apply(state)
    local c = LocalPlayer.Character
    if not c then return end
    local head = c:FindFirstChild("Head")
    if head then
        head.Transparency = state and 1 or 0
        head.LocalTransparencyModifier = state and 1 or 0
        local decal = head:FindFirstChildOfClass("Decal")
        if decal then
            decal.Transparency = state and 1 or 0
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    apply(S.enabled)
end)

getgenv().KATHeadlessToggle = function(state)
    S.enabled = state
    apply(state)
    notify(state and "Headless ON" or "Headless OFF")
end

return true