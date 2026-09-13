local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

getgenv().KATChatSpam = getgenv().KATChatSpam or {
    enabled = false,
    delay = 3,
    random = true,
    messages = {
        "KATWare on top!",
        "Free Kat GUI!",
        "KATWare best server destroying feature!",
        "After 9 years in development, we hope it was worth the wait!",
        "KATWare - better than King Scripts!",
    },
}
local S = getgenv().KATChatSpam

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function sendOld(msg)
    pcall(function()
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end)
end

local function sendNew(msg)
    pcall(function()
        local tcs = game:GetService("TextChatService")
        local channel = tcs.TextChannels:FindFirstChild("RBXGeneral")
        if channel then
            channel:SendAsync(msg)
        end
    end)
end

local function send(msg)
    sendOld(msg)
    sendNew(msg)
end

task.spawn(function()
    while true do
        task.wait(S.delay)
        if S.enabled and #S.messages > 0 then
            local msg
            if S.random then
                msg = S.messages[math.random(1, #S.messages)]
            else
                msg = S.messages[1]
                table.remove(S.messages, 1)
                table.insert(S.messages, msg)
            end
            send(msg)
        end
    end
end)

getgenv().KATChatSpamToggle = function(state)
    S.enabled = state
    notify(state and "Chat Spam ON" or "Chat Spam OFF")
end

getgenv().KATChatSpamSetDelay = function(v)
    S.delay = v
end

getgenv().KATChatSpamAddMessage = function(msg)
    table.insert(S.messages, msg)
end

getgenv().KATChatSpamClear = function()
    S.messages = {}
end

return true