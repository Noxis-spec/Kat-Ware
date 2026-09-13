local StarterGui = game:GetService("StarterGui")

getgenv().KATAntiMessageUploader = getgenv().KATAntiMessageUploader or {
    enabled = false,
}
local S = getgenv().KATAntiMessageUploader

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
    if getgenv().KATAntiMsgHooked then return end
    getgenv().KATAntiMsgHooked = true

    local old
    old = hookmetamethod(game, "__namecall", function(Self, ...)
        local method = getnamecallmethod()
        if S.enabled and method == "SendAsync" then
            return nil
        end
        return old(Self, ...)
    end)
end

getgenv().KATAntiMessageUploaderToggle = function(state)
    S.enabled = state
    if state then
        hook()
        notify("Anti Message Uploader ON")
    else
        notify("Anti Message Uploader OFF")
    end
end

return true