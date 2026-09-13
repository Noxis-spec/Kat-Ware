local StarterGui = game:GetService("StarterGui")

getgenv().KATEquipHarry = function()
    pcall(function()
        game:GetService("ReplicatedStorage").GameEvents.Misk.InventoryChange:FireServer("Equip", "85", 1)
    end)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = "Harry skin equipped",
            Duration = 3,
        })
    end)
end

getgenv().KATEquipHarry()

return true