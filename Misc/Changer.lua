local StarterGui = game:GetService("StarterGui")

getgenv().KATChanger = getgenv().KATChanger or {
    enabled = false,
    delay = 0.5,
    slots = {"72","71","68","85","73","77","82","80","78","6","70","69","77","50","75","84","83","79","76","74","81"},
}
local S = getgenv().KATChanger

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

task.spawn(function()
    while true do
        task.wait(S.delay)
        if S.enabled then
            for _, slot in ipairs(S.slots) do
                pcall(function()
                    game:GetService("ReplicatedStorage").GameEvents.Misk.InventoryChange:FireServer("Equip", slot, 1)
                end)
                task.wait(S.delay)
            end
        end
    end
end)

getgenv().KATChangerToggle = function(state)
    S.enabled = state
    notify(state and "Auto Equip Loop ON" or "Auto Equip Loop OFF")
end

getgenv().KATChangerSetDelay = function(v)
    S.delay = v
end

getgenv().KATChangerSetSlots = function(list)
    S.slots = list
end

return true