local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

getgenv().KATVisuals2 = getgenv().KATVisuals2 or {
    accent = Color3.fromRGB(255, 15, 231),
}
local S = getgenv().KATVisuals2

getgenv().KATSetFOV120 = function()
    workspace.CurrentCamera.FieldOfView = 120
end

getgenv().KATPurpleAmbient = function()
    pcall(function()
        Lighting.OutdoorAmbient = Color3.fromRGB(75, 7, 37)
        Lighting.Ambient = Color3.fromRGB(90, 0, 0)
    end)
end

getgenv().KATBrickMaterial = function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local p = v.Parent
            if p and not p:FindFirstChildOfClass("Humanoid") and p.Parent and not p.Parent:FindFirstChildOfClass("Humanoid") then
                v.Material = Enum.Material.Brick
            end
        end
    end
end

getgenv().KATForceFieldMaterial = function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local p = v.Parent
            if p and not p:FindFirstChildOfClass("Humanoid") and p.Parent and not p.Parent:FindFirstChildOfClass("Humanoid") then
                v.Material = Enum.Material.ForceField
            end
        end
    end
end

getgenv().KATFullbright = function()
    pcall(function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end)
end

getgenv().KATCameraOffset = function(x, y, z)
    x = x or 2
    y = y or 0
    z = z or 0
    pcall(function()
        local c = LocalPlayer.Character
        if c and c:FindFirstChildOfClass("Humanoid") then
            c:FindFirstChildOfClass("Humanoid").CameraOffset = Vector3.new(x, y, z)
        end
    end)
end

getgenv().KATCameraOffsetReset = function()
    pcall(function()
        local c = LocalPlayer.Character
        if c and c:FindFirstChildOfClass("Humanoid") then
            c:FindFirstChildOfClass("Humanoid").CameraOffset = Vector3.new(0, 0, 0)
        end
    end)
end

local function makeRainbowBar()
    if getgenv().KATRainbowBar then return end
    local gui = Instance.new("ScreenGui")
    gui.Name = "KATRainbow"
    gui.ResetOnSpawn = false
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    pcall(function() gui.Parent = gethui() end)

    local bar = Instance.new("Frame")
    bar.Parent = gui
    bar.Size = UDim2.new(0, 6, 0.6, 0)
    bar.Position = UDim2.new(0, 0, 0.2, 0)
    bar.BorderSizePixel = 0
    local c = Instance.new("UICorner", bar)
    c.CornerRadius = UDim.new(0, 3)

    task.spawn(function()
        while bar.Parent do
            local hue = tick() % 5 / 5
            bar.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
            task.wait(0.05)
        end
    end)

    getgenv().KATRainbowBar = gui
end

getgenv().KATShowRainbowBar = function()
    makeRainbowBar()
end

getgenv().KATHideRainbowBar = function()
    if getgenv().KATRainbowBar then
        getgenv().KATRainbowBar:Destroy()
        getgenv().KATRainbowBar = nil
    end
end

return true