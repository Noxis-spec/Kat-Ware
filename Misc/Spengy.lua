local StarterGui = game:GetService("StarterGui")

getgenv().KATEquipSpengy = function()
    pcall(function()
        game:GetService("ReplicatedStorage").GameEvents.Misk.InventoryChange:FireServer("Equip", "50", 1)
    end)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = "Spengy skin equipped",
            Duration = 3,
        })
    end)
end

getgenv().KATEquipSpengy()

return true