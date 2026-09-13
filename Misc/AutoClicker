local StarterGui = game:GetService("StarterGui")

getgenv().KATAutoClicker = getgenv().KATAutoClicker or {
    enabled = false,
    delay = 0.5,
    clicks_per_burst = 1,
}
local S = getgenv().KATAutoClicker

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function virtualClick()
    pcall(function() mouse1click() end)
    pcall(function()
        local vu = game:GetService("VirtualUser")
        vu:Button1Down(Vector2.new(0, 0))
        vu:Button1Up(Vector2.new(0, 0))
    end)
end

task.spawn(function()
    while true do
        task.wait(S.delay)
        if S.enabled then
            for _ = 1, S.clicks_per_burst do
                virtualClick()
                task.wait(0.05)
            end
        end
    end
end)

getgenv().KATAutoClickerToggle = function(state)
    S.enabled = state
    notify(state and "Auto Clicker ON" or "Auto Clicker OFF")
end

getgenv().KATAutoClickerSetDelay = function(v)
    S.delay = v
end

getgenv().KATAutoClickerSetBurst = function(v)
    S.clicks_per_burst = v
end

return true