-- KATSlient.lua — Silent Aim (mobile, LOS, full raycast hook)
-- Original by unknown (pastebin), KatWare by cOpEtriNe (CC0)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

getgenv().KATSlient = getgenv().KATSlient or {
    fov = 200,
    hitbox = "Head",
    visible_only = true,
    enabled = true,
}

local S = getgenv().KATSlient

local function GetAimPoint()
    local vp = CurrentCamera.ViewportSize
    return Vector2.new(vp.X / 2, vp.Y / 2)
end

local function GetClosest()
    local Target, Closest = nil, S.fov
    local aim = GetAimPoint()

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer
            and v.Character
            and v.Character:FindFirstChild(S.hitbox)
            and v.Character:FindFirstChild("HumanoidRootPart")
            and v.Character:FindFirstChildOfClass("Humanoid")
            and v.Character:FindFirstChildOfClass("Humanoid").Health > 0
        then
            local part = v.Character[S.hitbox]

            if S.visible_only then
                local rp = RaycastParams.new()
                rp.FilterType = Enum.RaycastFilterType.Exclude
                rp.FilterDescendantsInstances = {LocalPlayer.Character, CurrentCamera}
                local origin = CurrentCamera.CFrame.Position
                local dir = part.Position - origin
                local res = workspace:Raycast(origin, dir, rp)
                local visible = (res == nil) or (res.Instance and res.Instance:IsDescendantOf(v.Character))
                if not visible then continue end
            end

            local pos, onScreen = CurrentCamera:WorldToScreenPoint(part.Position)
            local dist = (Vector2.new(pos.X, pos.Y) - aim).Magnitude
            if onScreen and dist < Closest then
                Closest = dist
                Target = v
            end
        end
    end

    return Target
end

local Target
local Circle = Drawing.new("Circle")
Circle.Thickness = 2
Circle.Color = Color3.fromRGB(255, 15, 231)
Circle.Transparency = 1

RunService.RenderStepped:Connect(function()
    Circle.Radius = S.fov
    Circle.Position = GetAimPoint()
    Circle.Visible = S.enabled
    if S.enabled then
        Target = GetClosest()
    else
        Target = nil
    end
end)

local Old
Old = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local method = getnamecallmethod()

    if not checkcaller() and S.enabled and Target and Target.Character then
        local hp = Target.Character:FindFirstChild(S.hitbox)
        if hp then
            if method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRay" then
                if Args[1] and Args[1].Origin then
                    local o = Args[1].Origin
                    Args[1] = Ray.new(o, hp.Position - o)
                end
            elseif method == "Raycast" or method == "Spherecast" then
                if Args[1] and Args[2] then
                    local o = Args[1]
                    local d = hp.Position - o
                    Args[2] = d.Unit * d.Magnitude
                end
            end
        end
    end

    return Old(Self, unpack(Args))
end)