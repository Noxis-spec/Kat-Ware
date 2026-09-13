local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

getgenv().KATWare = getgenv().KATWare or {
    accent = Color3.fromRGB(255, 15, 231),
    accent2 = Color3.fromRGB(150, 60, 255),
    bg = Color3.fromRGB(16, 16, 18),
    panel = Color3.fromRGB(24, 24, 28),
    card = Color3.fromRGB(32, 32, 38),
    text = Color3.fromRGB(240, 240, 245),
    subtext = Color3.fromRGB(150, 150, 160),
}
local S = getgenv().KATWare

local BASE = "https://raw.githubusercontent.com/Noxis-spec/Kat-Ware/main/Misc/"
local FILES = {
    aim = BASE .. "KATSlient.lua",
    esp = BASE .. "ESP.lua",
    astuck = BASE .. "AStuck.lua",
    autofarm = BASE .. "AutoFarm.lua",
    chatspam = BASE .. "ChatSpam.lua",
    autoclicker = BASE .. "AutoClicker.lua",
    equipnoob = BASE .. "EquipNoob.lua",
    harry = BASE .. "Harry.lua",
    spengy = BASE .. "Spengy.lua",
    changer = BASE .. "Changer.lua",
    fps = BASE .. "FPSCounter.lua",
    playerinfo = BASE .. "PlayerInf.lua",
    mousepos = BASE .. "MousePosPrint.lua",
    visuals = BASE .. "Visuals.lua",
    visuals2 = BASE .. "Visuals2Tab.lua",
    skins = BASE .. "Skins.lua",
    bhop = BASE .. "BHop.lua",
    infjump = BASE .. "InfiniteJump.lua",
    speed = BASE .. "SpeedBoost.lua",
    norotate = BASE .. "NoRotate.lua",
    viewangles = BASE .. "ViewAngles.lua",
    freecam = BASE .. "Freecam.lua",
    barriers = BASE .. "RemoveBarriers.lua",
    mapvote = BASE .. "MapVoteSpam.lua",
    antiafk = BASE .. "AntiAfk.lua",
    btools = BASE .. "BTools.lua",
    forcequit = BASE .. "ForceQuit.lua",
    antimsg = BASE .. "AntiMessageUpLoader.lua",
    rejoin = BASE .. "ServerRejoin.lua",
    xray = BASE .. "XRay.lua",
    headless = BASE .. "Headless.lua",
    glow = BASE .. "Glow.lua",
    bettergfx = BASE .. "BetterGraphics.lua",
    noshadows = BASE .. "NoShadows.lua",
    antichat = BASE .. "AntiChatLogger.lua",
}

local loaded = {}

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function loadFile(key)
    if loaded[key] then return true end
    local ok, err = pcall(function()
        loadstring(game:HttpGet(FILES[key]))()
    end)
    if ok then
        loaded[key] = true
        return true
    end
    notify("Load error: " .. tostring(err))
    return false
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
Main.Position = UDim2.new(0.5, -340, 0.5, -240)
Main.Size = UDim2.new(0, 680, 0, 480)
Main.Active = true
Main.Draggable = true
Main.BorderSizePixel = 0
local mainCorner = Instance.new("UICorner", Main)
mainCorner.CornerRadius = UDim.new(0, 14)
local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Color = S.accent
mainStroke.Thickness = 1
mainStroke.Transparency = 0.6

local TitleBar = Instance.new("Frame")
TitleBar.Parent = Main
TitleBar.BackgroundColor3 = S.panel
TitleBar.Size = UDim2.new(1, 0, 0, 46)
TitleBar.BorderSizePixel = 0
local tbCorner = Instance.new("UICorner", TitleBar)
tbCorner.CornerRadius = UDim.new(0, 14)
local tbFix = Instance.new("Frame", TitleBar)
tbFix.BackgroundColor3 = S.panel
tbFix.Position = UDim2.new(0, 0, 0.6, 0)
tbFix.Size = UDim2.new(1, 0, 0.4, 0)
tbFix.BorderSizePixel = 0

local titleGlow = Instance.new("Frame", TitleBar)
titleGlow.BackgroundColor3 = S.accent
titleGlow.Position = UDim2.new(0, 16, 0, 12)
titleGlow.Size = UDim2.new(0, 4, 0, 22)
titleGlow.BorderSizePixel = 0
local tgc = Instance.new("UICorner", titleGlow)
tgc.CornerRadius = UDim.new(1, 0)

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 30, 0, 0)
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "KATWare Reborn"
Title.TextColor3 = S.text
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = TitleBar
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(1, -190, 0, 0)
SubTitle.Size = UDim2.new(0, 130, 1, 0)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "36 modules"
SubTitle.TextColor3 = S.subtext
SubTitle.TextSize = 12
SubTitle.TextXAlignment = Enum.TextXAlignment.Right

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 80)
CloseBtn.Position = UDim2.new(1, -38, 0, 11)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.BorderSizePixel = 0
local cbCorner = Instance.new("UICorner", CloseBtn)
cbCorner.CornerRadius = UDim.new(0, 7)

local tabs = {"Aimbot", "Visuals", "Movement", "Misc", "Skins", "Settings"}
local tabButtons = {}
local tabFrames = {}

local TabBar = Instance.new("Frame")
TabBar.Parent = Main
TabBar.BackgroundColor3 = S.panel
TabBar.Position = UDim2.new(0, 0, 0, 46)
TabBar.Size = UDim2.new(0, 120, 1, -46)
TabBar.BorderSizePixel = 0

local tabLayout = Instance.new("UIListLayout", TabBar)
tabLayout.Padding = UDim.new(0, 6)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local tabPad = Instance.new("UIPadding", TabBar)
tabPad.PaddingTop = UDim.new(0, 10)
tabPad.PaddingLeft = UDim.new(0, 10)
tabPad.PaddingRight = UDim.new(0, 10)

local Content = Instance.new("Frame")
Content.Parent = Main
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 120, 0, 46)
Content.Size = UDim2.new(1, -120, 1, -46)

local function makeTab(name)
    local btn = Instance.new("TextButton")
    btn.Parent = TabBar
    btn.BackgroundColor3 = S.card
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = name
    btn.TextColor3 = S.text
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 8)

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
    p.PaddingTop = UDim.new(0, 10)
    p.PaddingLeft = UDim.new(0, 12)
    p.PaddingRight = UDim.new(0, 12)

    tabButtons[name] = btn
    tabFrames[name] = frame

    btn.MouseButton1Click:Connect(function()
        for n, f in pairs(tabFrames) do
            f.Visible = false
            tabButtons[n].BackgroundColor3 = S.card
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
    b.BackgroundColor3 = S.card
    b.Size = UDim2.new(1, 0, 0, 34)
    b.Font = Enum.Font.GothamSemibold
    b.Text = text
    b.TextColor3 = S.text
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 8)
    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = S.card
    end)
    b.MouseButton1Click:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = S.accent}):Play()
        task.wait(0.1)
        TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = S.card}):Play()
        if callback then callback() end
    end)
    return b
end

local function makeToggle(parent, text, default, callback)
    local state = default or false
    local b = Instance.new("TextButton")
    b.Parent = parent
    b.BackgroundColor3 = state and S.accent or S.card
    b.Size = UDim2.new(1, 0, 0, 34)
    b.Font = Enum.Font.GothamSemibold
    b.Text = "  " .. text .. "  " .. (state and "ON" or "OFF")
    b.TextColor3 = state and Color3.fromRGB(0, 0, 0) or S.text
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = "  " .. text .. "  " .. (state and "ON" or "OFF")
        b.BackgroundColor3 = state and S.accent or S.card
        b.TextColor3 = state and Color3.fromRGB(0, 0, 0) or S.text
        if callback then callback(state) end
    end)
    return b
end

local function makeSlider(parent, text, min, max, default, callback)
    local value = default or min
    local holder = Instance.new("Frame")
    holder.Parent = parent
    holder.BackgroundColor3 = S.card
    holder.Size = UDim2.new(1, 0, 0, 48)
    holder.BorderSizePixel = 0
    local hc = Instance.new("UICorner", holder)
    hc.CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Parent = holder
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 12, 0, 4)
    label.Size = UDim2.new(1, -24, 0, 18)
    label.Font = Enum.Font.GothamSemibold
    label.Text = text .. ": " .. value
    label.TextColor3 = S.text
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("Frame")
    bar.Parent = holder
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
    bar.Position = UDim2.new(0, 12, 0, 30)
    bar.Size = UDim2.new(1, -24, 0, 8)
    bar.BorderSizePixel = 0
    local bc = Instance.new("UICorner", bar)
    bc.CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Parent = bar
    fill.BackgroundColor3 = S.accent
    fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
    fill.BorderSizePixel = 0
    local fc = Instance.new("UICorner", fill)
    fc.CornerRadius = UDim.new(1, 0)

    local function setFromX(x)
        local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        value = math.floor(min + (max - min) * rel)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        label.Text = text .. ": " .. value
        if callback then callback(value) end
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            setFromX(input.Position.X)
        end
    end)
    bar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            setFromX(input.Position.X)
        end
    end)

    return holder
end

local aimTab = tabFrames["Aimbot"]

makeToggle(aimTab, "Silent Aim", false, function(state)
    if state then loadFile("aim") end
    if getgenv().KATSlient then getgenv().KATSlient.enabled = state end
end)

makeSlider(aimTab, "Aim FOV", 30, 600, 200, function(v)
    if getgenv().KATSlient then getgenv().KATSlient.fov = v end
end)

makeButton(aimTab, "Extended Hitbox", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("CollisionParts") then
            for _, v in pairs(p.Character.CollisionParts:GetChildren()) do
                v.Transparency = 0.8
                v.Size = Vector3.new(2.82, 2.82, 1.41)
                v.Color = Color3.fromRGB(170, 255, 0)
                v.Material = Enum.Material.Neon
            end
        end
    end
    notify("Hitboxes extended")
end)

local visTab = tabFrames["Visuals"]

makeToggle(visTab, "ESP", false, function(state)
    if state then loadFile("esp") end
    if getgenv().KATESP then getgenv().KATESP.enabled = state end
end)

makeToggle(visTab, "Glow", false, function(state)
    if state then loadFile("glow") end
    if getgenv().KATGlowToggle then getgenv().KATGlowToggle(state) end
end)

makeToggle(visTab, "Chams", false, function(state)
    if state then loadFile("visuals") end
    if state then
        if getgenv().KATChams then getgenv().KATChams() end
    else
        if getgenv().KATChamsOff then getgenv().KATChamsOff() end
    end
end)

makeToggle(visTab, "XRay", false, function(state)
    if state then loadFile("xray") end
    if getgenv().KATXRayToggle then getgenv().KATXRayToggle(state) end
end)

makeToggle(visTab, "Headless", false, function(state)
    if state then loadFile("headless") end
    if getgenv().KATHeadlessToggle then getgenv().KATHeadlessToggle(state) end
end)

makeToggle(visTab, "Fullbright", false, function(state)
    if state then
        loadFile("visuals2")
        if getgenv().KATFullbright then getgenv().KATFullbright() end
    end
end)

makeToggle(visTab, "Night Mode", false, function(state)
    if state then
        loadFile("visuals")
        if getgenv().KATNightMode then getgenv().KATNightMode() end
    end
end)

makeToggle(visTab, "No Shadows", false, function(state)
    if state then loadFile("noshadows") end
    if getgenv().KATNoShadowsToggle then getgenv().KATNoShadowsToggle(state) end
end)

makeToggle(visTab, "Better Graphics", false, function(state)
    if state then loadFile("bettergfx") end
    if getgenv().KATBetterGraphicsToggle then getgenv().KATBetterGraphicsToggle(state) end
end)

makeToggle(visTab, "NoLag", false, function(state)
    if state then
        loadFile("visuals")
        if getgenv().KATNoLag then getgenv().KATNoLag() end
    end
end)

makeToggle(visTab, "Transparent Body", false, function(state)
    if state then
        loadFile("visuals")
        if getgenv().KATTransparentBody then getgenv().KATTransparentBody() end
    end
end)

makeButton(visTab, "FOV 100", function()
    loadFile("visuals")
    if getgenv().KATSetFOV then getgenv().KATSetFOV(100) end
end)

makeButton(visTab, "FOV 120", function()
    loadFile("visuals2")
    if getgenv().KATSetFOV120 then getgenv().KATSetFOV120() end
end)

makeButton(visTab, "Brick Material", function()
    loadFile("visuals2")
    if getgenv().KATBrickMaterial then getgenv().KATBrickMaterial() end
end)

makeButton(visTab, "ForceField Material", function()
    loadFile("visuals2")
    if getgenv().KATForceFieldMaterial then getgenv().KATForceFieldMaterial() end
end)

makeButton(visTab, "Purple Ambient", function()
    loadFile("visuals2")
    if getgenv().KATPurpleAmbient then getgenv().KATPurpleAmbient() end
end)

local moveTab = tabFrames["Movement"]

makeToggle(moveTab, "BHop", false, function(state)
    if state then loadFile("bhop") end
    if getgenv().KATBHopToggle then getgenv().KATBHopToggle(state) end
end)

makeToggle(moveTab, "Infinite Jump", false, function(state)
    if state then loadFile("infjump") end
    if getgenv().KATInfJumpToggle then getgenv().KATInfJumpToggle(state) end
end)

makeToggle(moveTab, "Speed Boost", false, function(state)
    if state then loadFile("speed") end
    if getgenv().KATSpeedBoostToggle then getgenv().KATSpeedBoostToggle(state) end
end)

makeSlider(moveTab, "Speed", 16, 200, 50, function(v)
    if getgenv().KATSpeedBoostSet then getgenv().KATSpeedBoostSet(v) end
end)

makeToggle(moveTab, "No Rotate", false, function(state)
    if state then loadFile("norotate") end
    if getgenv().KATNoRotateToggle then getgenv().KATNoRotateToggle(state) end
end)

makeToggle(moveTab, "View Angles", false, function(state)
    if state then loadFile("viewangles") end
    if getgenv().KATViewAnglesToggle then getgenv().KATViewAnglesToggle(state) end
end)

makeToggle(moveTab, "Freecam", false, function(state)
    if state then loadFile("freecam") end
    if getgenv().KATFreecamToggle then getgenv().KATFreecamToggle(state) end
end)

local miscTab = tabFrames["Misc"]

makeToggle(miscTab, "Airstuck", false, function(state)
    if state then loadFile("astuck") end
end)

makeToggle(miscTab, "Auto Farm", false, function(state)
    if state then loadFile("autofarm") end
    if getgenv().KATAutoFarmToggle then getgenv().KATAutoFarmToggle(state) end
end)

makeToggle(miscTab, "Chat Spam", false, function(state)
    if state then loadFile("chatspam") end
    if getgenv().KATChatSpamToggle then getgenv().KATChatSpamToggle(state) end
end)

makeToggle(miscTab, "Auto Clicker", false, function(state)
    if state then loadFile("autoclicker") end
    if getgenv().KATAutoClickerToggle then getgenv().KATAutoClickerToggle(state) end
end)

makeToggle(miscTab, "Auto Equip Loop", false, function(state)
    if state then loadFile("changer") end
    if getgenv().KATChangerToggle then getgenv().KATChangerToggle(state) end
end)

makeToggle(miscTab, "Map Vote Spam", false, function(state)
    if state then loadFile("mapvote") end
    if getgenv().KATMapVoteSpamToggle then getgenv().KATMapVoteSpamToggle(state) end
end)

makeToggle(miscTab, "Anti AFK", false, function(state)
    if state then loadFile("antiafk") end
    if getgenv().KATAntiAfkToggle then getgenv().KATAntiAfkToggle(state) end
end)

makeToggle(miscTab, "Anti Message Uploader", false, function(state)
    if state then loadFile("antimsg") end
    if getgenv().KATAntiMessageUploaderToggle then getgenv().KATAntiMessageUploaderToggle(state) end
end)

makeToggle(miscTab, "Anti Chat Logger", false, function(state)
    if state then loadFile("antichat") end
    if getgenv().KATAntiChatLoggerToggle then getgenv().KATAntiChatLoggerToggle(state) end
end)

makeToggle(miscTab, "FPS Counter", false, function(state)
    if state then loadFile("fps") end
    if getgenv().KATFPSToggle then getgenv().KATFPSToggle(state) end
end)

makeButton(miscTab, "Remove Barriers", function()
    loadFile("barriers")
    if getgenv().KATRemoveBarriersNow then getgenv().KATRemoveBarriersNow() end
end)

makeButton(miscTab, "BTools", function()
    loadFile("btools")
    if getgenv().KATBToolsGive then getgenv().KATBToolsGive() end
end)

makeButton(miscTab, "Player Info", function()
    loadFile("playerinfo")
    if getgenv().KATPlayerInfoShow then getgenv().KATPlayerInfoShow() end
end)

makeButton(miscTab, "Mouse Pos", function()
    loadFile("mousepos")
    if getgenv().KATMousePosToggle then getgenv().KATMousePosToggle(true) end
end)

makeButton(miscTab, "Anti Ban", function()
    pcall(function()
        game:GetService("ReplicatedStorage").GameEvents.Misk.BanReceived:Destroy()
    end)
    pcall(function()
        LocalPlayer.PlayerGui.GameUI.Menu.MainMenuUI.Banned:Destroy()
    end)
    notify("Anti Ban applied")
end)

makeButton(miscTab, "Server Rejoin", function()
    loadFile("rejoin")
    if getgenv().KATServerRejoin then getgenv().KATServerRejoin() end
end)

makeButton(miscTab, "Force Quit", function()
    loadFile("forcequit")
    if getgenv().KATForceQuit then getgenv().KATForceQuit() end
end)

local skinTab = tabFrames["Skins"]

makeButton(skinTab, "Noob Knife", function()
    loadFile("equipnoob")
    notify("Noob Knife")
end)

makeButton(skinTab, "Harry", function()
    loadFile("harry")
    notify("Harry")
end)

makeButton(skinTab, "Spengy", function()
    loadFile("spengy")
    notify("Spengy")
end)

makeButton(skinTab, "Slot 16", function()
    loadFile("skins")
    if getgenv().KATSkinSlot16 then getgenv().KATSkinSlot16() end
end)

local setTab = tabFrames["Settings