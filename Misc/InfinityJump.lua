local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATInfJump = getgenv().KATInfJump or {
    enabled = false,
}
local S = getgenv().KATInfJump

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

UserInputService.JumpRequest:Connect(function()
    if S.enabled then
        local c = LocalPlayer.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then
                h:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

getgenv().KATInfJumpToggle = function(state)
    S.enabled = state
    notify(state and "Infinite Jump ON" or "Infinite Jump OFF")
end

return true