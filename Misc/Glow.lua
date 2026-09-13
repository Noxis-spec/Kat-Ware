local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATGlow = getgenv().KATGlow or {
    enabled = false,
    color = Color3.fromRGB(255, 15, 231),
}
local S = getgenv().KATGlow

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function destroyGlow(char)
    if not char then return end
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") then
            local g = v:FindFirstChild("KATGlow")
            if g then g:Destroy() end
        end
    end
end

local function addGlow(char)
    if not char then return end
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") and v.Transparency ~= 1 then
            if not v:FindFirstChild("KATGlow") then
                local box = Instance.new("BoxHandleAdornment", v)
                box.Name = "KATGlow"
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Adornee = v
                box.Color3 = S.color
                box.Transparency = 0.5
                box.Size = v.Size + Vector3.new(0.2, 0.2, 0.2)
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if S.enabled then
                addGlow(p.Character)
            else
                destroyGlow(p.Character)
            end
        end
    end
end)

getgenv().KATGlowToggle = function(state)
    S.enabled = state
    if not state then
        for _, p in pairs(Players:GetPlayers()) do
            destroyGlow(p.Character)
        end
    end
    notify(state and "Glow ON" or "Glow OFF")
end

getgenv().KATGlowSetColor = function(color)
    S.color = color
end

return true