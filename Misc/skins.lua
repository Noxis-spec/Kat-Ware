local StarterGui = game:GetService("StarterGui")

getgenv().KATSkins = getgenv().KATSkins or {
    accent = Color3.fromRGB(255, 15, 231),
}
local S = getgenv().KATSkins

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function equip(slot)
    pcall(function()
        game:GetService("ReplicatedStorage").GameEvents.Misk.InventoryChange:FireServer("Equip", slot, 1)
    end)
end

getgenv().KATSkinNoob = function()
    equip("6")
    notify("Noob Knife equipped")
end

getgenv().KATSkinHarry = function()
    equip("85")
    notify("Harry equipped")
end

getgenv().KATSkinSpengy = function()
    equip("50")
    notify("Spengy equipped")
end

getgenv().KATSkinSlot16 = function()
    equip("16")
    notify("Slot 16 equipped")
end

getgenv().KATSkinCustom = function(slot)
    slot = tostring(slot)
    equip(slot)
    notify("Slot " .. slot .. " equipped")
end

return true