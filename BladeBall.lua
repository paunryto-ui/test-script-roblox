--[[
╔══════════════════════════════════╗
║  DARKAI BLADE BALL - BYPASS ON  ║
║  Auto Parry • ESP • Dodge       ║
║  Made by Esa (DARK AI)          ║
╚══════════════════════════════════╝
]]--

-- ============ DEEP BYPASS (AUTO ON) ============
local function autoBypass()
    -- Hook namecall method (block kick/ban)
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" or method == "Ban" or method == "ban" then
            return nil
        end
        if string.find(method:lower(), "detect") or string.find(method:lower(), "flag") then
            return false
        end
        return oldNamecall(self, ...)
    end)
    
    -- Hook index method (spoof detection)
    local oldIndex
    oldIndex = hookmetamethod(game, "__index", function(self, key)
        if typeof(key) == "string" then
            local k = key:lower()
            if k == "detected" or k == "flagged" or k == "exploitdetected" then
                return false
            end
        end
        return oldIndex(self, key)
    end)
    
    -- Destroy anti-cheat remotes
    spawn(function()
        task.wait(2)
        pcall(function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    local n = v.Name:lower()
                    if n:find("ban") or n:find("kick") or n:find("detect") or n:find("bac") or n:find("report") or n:find("flag") then
                        v:Destroy()
                    end
                end
            end
        end)
    end)
    
    -- Periodic cleanup
    spawn(function()
        while task.wait(10) do
            pcall(function()
                for _, v in pairs(game.CoreGui:GetChildren()) do
                    local n = v.Name:lower()
                    if n:find("bac") or n:find("screenshot") or n:find("detect") then
                        v:Destroy()
                    end
                end
                getgenv().detected = false
                getgenv().flagged = false
            end)
        end
    end)
    
    -- Disable error reporting
    spawn(function()
        while task.wait(5) do
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if typeof(v) == "function" then
                        local info = debug.getinfo(v, "S")
                        if info and info.source then
                            local src = info.source:lower()
                            if src:find("anticheat") or src:find("bac") or src:find("detection") then
                                debug.setupvalue(v, 1, function() return end)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- AUTO EXECUTE BYPASS
autoBypass()
print("[DARKAI] Bypass Activated!")

-- ============ SERVICES ============
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- ============ WAIT FOR LOAD ============
if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end
task.wait(0.5)

-- ============ NOTIFICATION ============
game.StarterGui:SetCore("SendNotification", {
    Title = "⚔️ DARKAI ON",
    Text = "Bypass + All Features Active!",
    Duration = 5
})

-- ============ ESP (AUTO ON) ============
local espFolder = Instance.new("Folder")
espFolder.Name = "DarkAI_ESP"
espFolder.Parent = CoreGui

spawn(function()
    while task.wait(0.5) do
        pcall(function()
            espFolder:ClearAllChildren()
            
            -- Ball ESP
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("ball") then
                    local h = Instance.new("Highlight")
                    h.Parent = espFolder
                    h.Adornee = v
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                    h.FillTransparency = 0.5
                    h.OutlineColor = Color3.fromRGB(255, 255, 0)
                end
            end
            
            -- Player ESP
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local h = Instance.new("Highlight")
                    h.Parent = espFolder
                    h.Adornee = p.Character
                    h.FillColor = Color3.fromRGB(0, 255, 255)
                    h.FillTransparency = 0.7
                end
            end
        end)
    end
end)

-- ============ BALL DETECTION ============
local function getBall()
    local char = LocalPlayer.Character
    if not char then return nil, 999 end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil, 999 end
    
    local nearest, nearestDist = nil, math.huge
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("ball") or v.Name:lower():find("blade")) then
            local dist = (v.Position - root.Position).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = v
            end
        end
    end
    return nearest, nearestDist
end

-- ============ MAIN LOOP (ALL AUTO ON) ============
spawn(function()
    while task.wait() do
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            if not root or not hum then return end
            
            local ball, ballDist = getBall()
            
            -- AUTO PARRY
            if ball and ballDist < 65 then
                VIM:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
                task.wait(0.01)
                VIM:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
            end
            
            -- AUTO DODGE
            if ball and ballDist < 25 then
                local away = (root.Position - ball.Position).Unit
                root.Velocity = away * 150 + Vector3.new(0, 50, 0)
            end
            
            -- PRO MOVEMENT
            if ball then
                local dir = (root.Position - ball.Position).Unit
                local strafe = Vector3.new(dir.X + math.random(-100,100)/100, 0, dir.Z + math.random(-100,100)/100).Unit
                root.Velocity = strafe * hum.WalkSpeed + Vector3.new(0, root.Velocity.Y, 0)
                if math.random(1,25) == 1 then hum.Jump = true end
            end
            
            -- AUTO SKILL
            if ball and ballDist < 50 then
                for _, tool in pairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        tool:Activate()
                        task.wait(0.2)
                    end
                end
            end
            
            -- AUTO SPAM (nearby enemies)
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and (hrp.Position - root.Position).Magnitude < 30 then
                        for _, tool in pairs(char:GetChildren()) do
                            if tool:IsA("Tool") then tool:Activate() end
                        end
                    end
                end
            end
        end)
    end
end)

-- ============ STATUS DOT ============
local dot = Instance.new("Frame")
dot.Parent = CoreGui
dot.Size = UDim2.new(0, 10, 0, 10)
dot.Position = UDim2.new(0.01, 0, 0.02, 0)
dot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
dot.BorderSizePixel = 0

local dotCorner = Instance.new("UICorner")
dotCorner.Parent = dot
dotCorner.CornerRadius = UDim.new(1, 0)

-- Blink
spawn(function()
    while task.wait(0.8) do
        dot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(0.4)
        dot.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    end
end)

print("╔══════════════════════════════╗")
print("║  DARKAI - ALL SYSTEMS GO!   ║")
print("║  Bypass: ACTIVE             ║")
print("║  Parry: ON | Dodge: ON      ║")
print("║  ESP: ON | Skill: ON        ║")
print("╚══════════════════════════════╝")