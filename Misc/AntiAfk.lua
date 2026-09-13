local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

getgenv().KATAntiAfk = getgenv().KATAntiAfk or {
    enabled = false,
    delay = 60,
}
local S = getgenv().KATAntiAfk

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

LocalPlayer.Idled:Connect(function()
    if S.enabled then
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(S.delay)
        if S.enabled then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end
end)

getgenv().KATAntiAfkToggle = function(state)
    S.enabled = state
    notify(state and "Anti AFK ON" or "Anti AFK OFF")
end

getgenv().KATAntiAfkSetDelay = function(v)
    S.delay = v
end

return true