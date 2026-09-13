local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

getgenv().KATBTools = getgenv().KATBTools or {
    enabled = false,
}
local S = getgenv().KATBTools

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "KATWare",
            Text = text,
            Duration = 3,
        })
    end)
end

local function giveTools()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    local tools = {
        {name = "BTools_Hammer", class = "Hammer"},
        {name = "BTools_Laser", class = "Laser"},
        {name = "BTools_Grab", class = "Grab"},
    }

    local hopperbin = Instance.new("HopperBin")
    hopperbin.Name = "BTools_Hammer"
    hopperbin.BinType = Enum.BinType.Hammer
    hopperbin.Parent = backpack

    local laser = Instance.new("HopperBin")
    laser.Name = "BTools_Laser"
    laser.BinType = Enum.BinType.Laser
    laser.Parent = backpack

    local grab = Instance.new("HopperBin")
    grab.Name = "BTools_Grab"
    grab.BinType = Enum.BinType.Grab
    grab.Parent = backpack
end

getgenv().KATBToolsGive = function()
    giveTools()
    notify("BTools given")
end

getgenv().KATBToolsToggle = function(state)
    S.enabled = state
    if state then
        giveTools()
        notify("BTools ON")
    else
        notify("BTools OFF")
    end
end

return true