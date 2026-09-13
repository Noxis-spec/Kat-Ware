local StarterGui = game:GetService("StarterGui")

getgenv().KATAntiChatLogger = getgenv().KATAntiChatLogger or {
    enabled = false,
}
local S = getgenv().KATAntiChatLogger

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function hook()
    if getgenv().KATAntiChatHooked then return end
    getgenv().KATAntiChatHooked = true

    local old
    old = hookmetamethod(game, "__namecall", function(Self, ...)
        local method = getnamecallmethod()
        if S.enabled then
            if method == "SendAsync" or method == "SayMessageRequest" or method == "FireServer" then
                local args = {...}
                if type(args[1]) == "string" and (args[1]:lower():find("chat") or args[1]:lower():find("log")) then
                    return nil
                end
            end
        end
        return old(Self, ...)
    end)
end

getgenv().KATAntiChatLoggerToggle = function(state)
    S.enabled = state
    if state then
        hook()
        notify("Anti Chat Logger ON")
    else
        notify("Anti Chat Logger OFF")
    end
end

return true