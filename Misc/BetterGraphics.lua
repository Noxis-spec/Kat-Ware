local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

getgenv().KATBetterGraphics = getgenv().KATBetterGraphics or {
    enabled = false,
}
local S = getgenv().KATBetterGraphics

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local original = {}

local function save()
    original.Brightness = Lighting.Brightness
    original.ClockTime = Lighting.ClockTime
    original.FogEnd = Lighting.FogEnd
    original.GlobalShadows = Lighting.GlobalShadows
    original.EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale
    original.EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
end

local function apply()
    pcall(function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true
        Lighting.EnvironmentDiffuseScale = 0.5
        Lighting.EnvironmentSpecularScale = 0.5
    end)
end

local function restore()
    pcall(function()
        Lighting.Brightness = original.Brightness or 1
        Lighting.ClockTime = original.ClockTime or 14
        Lighting.FogEnd = original.FogEnd or 100000
        Lighting.GlobalShadows = original.GlobalShadows ~= false
        Lighting.EnvironmentDiffuseScale = original.EnvironmentDiffuseScale or 0
        Lighting.EnvironmentSpecularScale = original.EnvironmentSpecularScale or 0
    end)
end

getgenv().KATBetterGraphicsToggle = function(state)
    S.enabled = state
    if state then
        save()
        apply()
    else
        restore()
    end
    notify(state and "Better Graphics ON" or "Better Graphics OFF")
end

return true