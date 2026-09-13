local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

getgenv().KATESP = getgenv().KATESP or {
    enabled = true,
    name = true,
    distance = true,
    hp = true,
    box = true,
    tracer = true,
    max_dist = 1000,
    text_size = 14,
    color = Color3.fromRGB(255, 15, 231),
    text_color = Color3.fromRGB(255, 255, 255),
    outline_color = Color3.fromRGB(0, 0, 0),
}
local S = getgenv().KATESP

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KATESPDraw"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function() ScreenGui.Parent = gethui() end)

local function newDrawing(class, props)
    local ok, obj = pcall(function() return Drawing.new(class) end)
    if not ok or not obj then return nil end
    for k, v in pairs(props) do obj[k] = v end
    return obj
end

local espData = {}

local function createESP(player)
    if player == LocalPlayer then return end
    if espData[player] then return end
    espData[player] = {
        box = newDrawing("Square", {
            Thickness = 1,
            Filled = false,
            Color = S.color,
            Transparency = 1,
            Visible = false,
        }),
        boxOutline = newDrawing("Square", {
            Thickness = 3,
            Filled = false,
            Color = S.outline_color,
            Transparency = 0.6,
            Visible = false,
        }),
        name = newDrawing("Text", {
            Size = S.text_size,
            Center = true,
            Outline = true,
            Color = S.text_color,
            Transparency = 1,
            Visible = false,
        }),
        distance = newDrawing("Text", {
            Size = S.text_size - 2,
            Center = true,
            Outline = true,
            Color = S.text_color,
            Transparency = 1,
            Visible = false,
        }),
        hpBar = newDrawing("Square", {
            Thickness = 0,
            Filled = true,
            Color = Color3.fromRGB(0, 255, 0),
            Transparency = 1,
            Visible = false,
        }),
        hpBarBg = newDrawing("Square", {
            Thickness = 0,
            Filled = true,
            Color = Color3.fromRGB(0, 0, 0),
            Transparency = 0.5,
            Visible = false,
        }),
        tracer = newDrawing("Line", {
            Thickness = 1,
            Color = S.color,
            Transparency = 1,
            Visible = false,
        }),
    }
end

local function removeESP(player)
    if espData[player] then
        for _, obj in pairs(espData[player]) do
            if obj then pcall(function() obj:Remove() end) end
        end
        espData[player] = nil
    end
end

for _, p in pairs(Players:GetPlayers()) do
    createESP(p)
end

Players.PlayerAdded:Connect(createESP)
Players.PlayerRemoving:Connect(removeESP)

local function getBoundingBox(char)
    local ok, size = pcall(function()
        local model = char
        local cf, sz = model:GetBoundingBox()
        return cf, sz
    end)
    return ok, size
end

RunService.RenderStepped:Connect(function()
    if not S.enabled then
        for _, d in pairs(espData) do
            for _, o in pairs(d) do
                if o then o.Visible = false end
            end
        end
        return
    end

    for player, d in pairs(espData) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if not (char and hrp and hum and hum.Health > 0) then
            for _, o in pairs(d) do if o then o.Visible = false end end
            continue
        end

        local head = char:FindFirstChild("Head") or hrp
        local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
        local rootPos = Camera:WorldToViewportPoint(hrp.Position)
        local dist = (Camera.CFrame.Position - hrp.Position).Magnitude

        if dist > S.max_dist or not onScreen then
            for _, o in pairs(d) do if o then o.Visible = false end end
            continue
        end

        local _, size = char:GetBoundingBox()
        local height = size.Y
        local width = size.X

        local top = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, height / 2, 0))
        local bottom = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, height / 2, 0))

        local boxHeight = math.abs(top.Y - bottom.Y)
        local boxWidth = boxHeight * 0.6
        local boxX = headPos.X - boxWidth / 2
        local boxY = top.Y

        if d.box then
            d.box.Size = Vector2.new(boxWidth, boxHeight)
            d.box.Position = Vector2.new(boxX, boxY)
            d.box.Color = S.color
            d.box.Visible = true
        end
        if d.boxOutline then
            d.boxOutline.Size = Vector2.new(boxWidth, boxHeight)
            d.boxOutline.Position = Vector2.new(boxX, boxY)
            d.boxOutline.Visible = true
        end

        if d.name then
            d.name.Text = player.Name
            d.name.Position = Vector2.new(headPos.X, boxY - 16)
            d.name.Color = S.text_color
            d.name.Visible = true
        end

        if d.distance then
            d.distance.Text = string.format("[%d]", math.floor(dist))
            d.distance.Position = Vector2.new(headPos.X, boxY + boxHeight + 2)
            d.distance.Color = S.text_color
            d.distance.Visible = true
        end

        if d.hpBar then
            local hpPct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
            local barW = 3
            if d.hpBarBg then
                d.hpBarBg.Size = Vector2.new(barW, boxHeight)
                d.hpBarBg.Position = Vector2.new(boxX - barW - 3, boxY)
                d.hpBarBg.Visible = true
            end
            d.hpBar.Size = Vector2.new(barW, boxHeight * hpPct)
            d.hpBar.Position = Vector2.new(boxX - barW - 3, boxY + boxHeight - boxHeight * hpPct)
            local hue = hpPct * 0.33
            d.hpBar.Color = Color3.fromHSV(hue, 1, 1)
            d.hpBar.Visible = true
        end

        if d.tracer then
            d.tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            d.tracer.To = Vector2.new(headPos.X, boxY + boxHeight)
            d.tracer.Color = S.color
            d.tracer.Visible = true
        end
    end
end)

return true