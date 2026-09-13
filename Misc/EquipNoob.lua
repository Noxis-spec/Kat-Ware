local StarterGui = game:GetService("StarterGui")

getgenv().KATEquipNoob = function()
    pcall(function()
        game:GetService("ReplicatedStorage").GameEvents.Misk.ItemPurchase:FireServer("NoobKnife")
    end)
    pcall(function()
        game:GetService("ReplicatedStorage").GameEvents.Misk.InventoryChange:FireServer("Equip", "6", 1)
    end)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = "Noob Knife equipped (need level 15+)",
            Duration = 4,
        })
    end)
end

getgenv().KATEquipNoob()

return true