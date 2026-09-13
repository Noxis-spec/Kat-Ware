local StarterGui = game:GetService("StarterGui")

getgenv().KATForceQuit = function()
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = "Force Quit in 3...",
            Duration = 3,
        })
    end)
    task.wait(3)
    game:Shutdown()
end

getgenv().KATForceQuitNow = function()
    pcall(function()
        game:Shutdown()
    end)
end

return true