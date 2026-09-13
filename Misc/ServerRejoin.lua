local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

getgenv().KATServerRejoin = function()
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = "Rejoining server...",
            Duration = 3,
        })
    end)
    task.wait(1)
    local ok = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end)
    if not ok then
        pcall(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
    end
end

return true