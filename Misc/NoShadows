local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

getgenv().KATNoShadows = getgenv().KATNoShadows or {
    enabled = false,
}
local S = getgenv().KATNoShadows

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local original = Lighting.GlobalShadows

getgenv().KATNoShadowsToggle = function(state)
    S.enabled = state
    if state then
        original = Lighting.GlobalShadows
        pcall(function()
            Lighting.GlobalShadows = false
        end)
        notify("No Shadows ON")
    else
        pcall(function()
            Lighting.GlobalShadows = original
        end)
        notify("No Shadows OFF")
    end
end

getgenv().KATNoShadowsNow = function()
    pcall(function()
        Lighting.GlobalShadows = false
    end)
    notify("Shadows removed")
end

return true