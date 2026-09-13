local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local LocalPlayer = game:GetService("Players").LocalPlayer

getgenv().KATXRay = getgenv().KATXRay or {
    enabled = false,
}
local S = getgenv().KATXRay

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function getCharParts()
    local parts = {}
    local c = LocalPlayer.Character
    if c then
        for _, v in pairs(c:GetDescendants()) do
            parts[v] = true
        end
    end
    return parts
end

local function apply(state)
    local ownParts = getCharParts()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and not ownParts[v] then
            if state then
                v.LocalTransparencyModifier = 0.5
            else
                v.LocalTransparencyModifier = 0
            end
        end
    end
end

getgenv().KATXRayToggle = function(state)
    S.enabled = state
    apply(state)
    notify(state and "XRay ON" or "XRay OFF")
end

getgenv().KATXRayApply = function()
    apply(S.enabled)
end

return true