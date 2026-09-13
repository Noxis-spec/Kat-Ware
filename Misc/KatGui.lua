local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATWare = getgenv().KATWare or {
    accent = Color3.fromRGB(255, 15, 231),
    bg = Color3.fromRGB(20, 20, 20),
    panel = Color3.fromRGB(30, 30, 30),
    text = Color3.fromRGB(240, 240, 240),
}
local S = getgenv().KATWare

local BASE = "https://raw.githubusercontent.com/Noxis-spec/Kat-Ware/main/Misc/"
local FILES = {
    aim = BASE .. "KATSlient.lua",
    esp = BASE .. "ESP.lua",
    misc = BASE .. "Misc.lua",
    visuals = BASE .. "Visuals.lua",
    skins = BASE .. "Skins.lua",
}

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3
        })
    end)
end

local function loadFile(url)
    local ok, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if not ok then
        notify("Load error: " .. tostring(err))
    end
end

local parentGui = LocalPlayer:WaitForChild("PlayerGui")
pcall(function() parentGui = gethui() end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KATWareGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = parentGui

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.BackgroundColor3 = S.bg
Main.Position = UDim2.new(0.5, -320, 0.5, -220)
Main.Size = UDim2.new(0, 640, 0, 440)
Main.Active = true
Main.Draggable = true
Main.BorderSizePixel = 0
local mc = Instance.new("UICorner", Main)
mc.CornerRadius = UDim.new(0, 10)

local TitleBar = Instance.new("Frame")
TitleBar.Parent = Main
TitleBar.BackgroundColor3 = S.panel
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BorderSizePixel = 0
local tc = Instance.new("UICorner", TitleBar)
tc.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "KATWare Reborn"
Title.TextColor3 = S.accent
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -35, 0, 8)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.BorderSizePixel = 0
local cc = Instance.new("UICorner", CloseBtn)
cc.CornerRadius = UDim.new(0, 6)

local tabs = {"Aimbot", "Visuals", "Misc", "Skins", "Settings"}
local tabButtons = {}
local tabFrames = {}

local TabBar = Instance.new("Frame")
TabBar.Parent = Main
TabBar.BackgroundColor3 = S.panel
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.Size = UDim2.new(0, 110, 1, -40)
TabBar.BorderSizePixel = 0

local tl = Instance.new("UIListLayout", TabBar)
tl.Padding = UDim.new(0, 4)
tl.SortOrder = Enum.SortOrder.LayoutOrder

local tp = Instance.new("UIPadding", TabBar)
tp.PaddingTop = UDim.new(0, 8)
tp.PaddingLeft = UDim.new(0, 8)
tp.PaddingRight = UDim.new(0, 8)

local Content = Instance.new("Frame")
Content.Parent = Main
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 110, 0, 40)
Content.Size = UDim2.new(1, -110, 1, -40)

local function makeTab(name)
    local btn = Instance.new("TextButton")
    btn.Parent = TabBar
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = name
    btn.TextColor3 = S.text
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 6)

    local frame = Instance.new("ScrollingFrame")
    frame.Parent = Content
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 4
    frame.ScrollBarImageColor3 = S.accent
    frame.Visible = false
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local l = Instance.new("UIListLayout", frame)
    l.Padding = UDim.new(0, 6)
    l.SortOrder = Enum.SortOrder.LayoutOrder

    local p = Instance.new("UIPadding", frame)
    p.PaddingTop = UDim.new(0, 8)
    p.PaddingLeft = UDim.new(0, 10)
    p.PaddingRight = UDim.new(0, 10)

    tabButtons[name] = btn
    tabFrames[name] = frame

    btn.MouseButton1Click:Connect(function()
        for n, f in pairs(tabFrames) do
            f.Visible = false
            tabButtons[n].BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            tabButtons[n].TextColor3 = S.text
        end
        frame.Visible = true
        btn.BackgroundColor3 = S.accent
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    end)
end

for _, n in ipairs(tabs) do makeTab(n) end

local function makeButton(parent, text, callback)
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.Size = UDim2.new(1, 0, 0, 34)
    b.Font = Enum.Font.GothamSemibold
    b.Text = text
    b.TextColor3 = S.text
    b.TextSize = 14
    b.BorderSizePixel = 0
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback or function() end)
    return b
end

local aimTab = tabFrames["Aimbot"]

makeButton(aimTab, "Silent Aim ON", function()
    loadFile(FILES.aim)
    notify("KATSlient loaded")
end)

makeButton(aimTab, "Silent Aim OFF", function()
    if getgenv().KATSlient then
        getgenv().KATSlient.enabled = false
        notify("Silent Aim OFF")
    end
end)

makeButton(aimTab, "Extended Hitbox", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            if char and char:FindFirstChild("CollisionParts") then
                for _, v in pairs(char.CollisionParts:GetChildren()) do
                    v.Transparency = 0.8
                    v.Size = Vector3.new(2.82, 2.82, 1.41)
                    v.Color = Color3.fromRGB(170, 255, 0)
                    v.Material = Enum.Material.Neon
                end
            end
        end
    end
    notify("Hitboxes extended")
end)

local visTab = tabFrames["Visuals"]

makeButton(visTab, "ESP ON", function()
    loadFile(FILES.esp)
    notify("ESP loaded")
end)

makeButton(visTab, "ESP OFF", function()
    if getgenv().KATESP then
        getgenv().KATESP.enabled = false
        notify("ESP OFF")
    end
end)

makeButton(visTab, "Visuals", function()
    loadFile(FILES.visuals)
    notify("Visuals loaded")
end)

local miscTab = tabFrames["Misc"]

makeButton(miscTab, "Load Misc", function()
    loadFile(FILES.misc)
    notify("Misc loaded")
end)

local skinTab = tabFrames["Skins"]

makeButton(skinTab, "Load Skins", function()
    loadFile(FILES.skins)
    notify("Skins loaded")
end)

local setTab = tabFrames["Settings"]

makeButton(setTab, "Show / Hide GUI", function()
    Main.Visible = not Main.Visible
end)

makeButton(setTab, "Reset Settings", function()
    getgenv().KATWare = nil
    getgenv().KATSlient = nil
    getgenv().KATESP = nil
    notify("Settings reset")
end)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

local Open = Instance.new("TextButton")
Open.Parent = ScreenGui
Open.BackgroundColor3 = S.accent
Open.Position = UDim2.new(0, 10, 0.5, -20)
Open.Size = UDim2.new(0, 60, 0, 40)
Open.Font = Enum.Font.GothamBold
Open.Text = "KAT"
Open.TextColor3 = Color3.fromRGB(0, 0, 0)
Open.TextSize = 14
Open.BorderSizePixel = 0
local oc = Instance.new("UICorner", Open)
oc.CornerRadius = UDim.new(0, 8)
Open.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

tabButtons["Aimbot"].BackgroundColor3 = S.accent
tabButtons["Aimbot"].TextColor3 = Color3.fromRGB(0, 0, 0)
tabFrames["Aimbot"].Visible = true

notify("KatGui loaded")