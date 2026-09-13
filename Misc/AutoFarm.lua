local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATAutoFarm = getgenv().KATAutoFarm or {
    enabled = false,
    delay = 0.5,
    safe_point = nil,
    attack = true,
}
local S = getgenv().KATAutoFarm

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function isAlive()
    local c = LocalPlayer.Character
    if not c then return false end
    local h = c:FindFirstChildOfClass("Humanoid")
    return c:FindFirstChild("HumanoidRootPart") ~= nil and h and h.Health > 0
end

local function click()
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
        if S.enabled and isAlive() then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and isAlive() then
                    local char = v.Character
                    local head = char and char:FindFirstChild("Head")
                    if head then
                        pcall(function()
                            LocalPlayer.Character.HumanoidRootPart.CFrame = head.CFrame * CFrame.new(0, 0, 0.4)
                        end)
                        if S.attack then
                            click()
                        end
                        if S.safe_point then
                            task.wait(0.1)
                            pcall(function()
                                LocalPlayer.Character.HumanoidRootPart.CFrame = S.safe_point
                            end)
                        end
                    end
                end
            end
        end
    end
end)

getgenv().KATAutoFarmToggle = function(state)
    S.enabled = state
    notify(state and "Auto Farm ON" or "Auto Farm OFF")
end

getgenv().KATAutoFarmSetDelay = function(v)
    S.delay = v
end

getgenv().KATAutoFarmSetSafePoint = function(cf)
    S.safe_point = cf
end

return true