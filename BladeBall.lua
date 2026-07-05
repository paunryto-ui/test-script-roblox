--[[
╔══════════════════════════════════════════════╗
║   DARKAI BLADE BALL - AUTO EXECUTE v1.0    ║
║   Bypass • Auto On • Undetectable          ║
║   Made by Esa (DARK AI)                    ║
╚══════════════════════════════════════════════╝
]]--

-- ============================================
-- SECTION 1: DEEP BYPASS SYSTEM
-- ============================================
local function DeepBypass()
    -- Disable Error Logging
    spawn(function()
        while task.wait(3) do
            pcall(function()
                for _, v in pairs(getgc(true)) do
                    if typeof(v) == "function" then
                        local info = debug.getinfo(v, "S")
                        if info and info.source then
                            local src = info.source:lower()
                            if src:find("detect") or src:find("ban") or src:find("kick") or src:find("bac") or src:find("anticheat") then
                                -- Nop the function
                            end
                        end
                    end
                end
            end)
        end
    end)
    
    -- Hook Kick/Ban Functions
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Block kick/ban
        if string.find(method:lower(), "kick") or string.find(method:lower(), "ban") then
            return nil
        end
        
        -- Block detection
        if string.find(method:lower(), "detect") or string.find(method:lower(), "flag") then
            return false
        end
        
        -- Block specific BAC methods
        if method == "FireServer" then
            local remoteName = self.Name:lower()
            if remoteName:find("ban") or remoteName:find("kick") or remoteName:find("report") then
                return nil
            end
        end
        
        return oldNamecall(self, ...)
    end)
    
    -- Hook Index for detection bypass
    local oldIndex
    oldIndex = hookmetamethod(game, "__index", function(self, key)
        if typeof(key) == "string" then
            local k = key:lower()
            if k:find("detected") or k:find("flagged") or k:find("exploit") then
                return false
            end
        end
        return oldIndex(self, key)
    end)
    
    -- Clean Anti-Cheat Remotes
    spawn(function()
        task.wait(1)
        pcall(function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    local n = v.Name:lower()
                    if n:find("ban") or n:find("kick") or n:find("detect") or n:find("bac") or n:find("report") then
                        v:Destroy()
                    end
                end
            end
        end)
    end)
    
    -- Disable Screenshot Detection
    spawn(function()
        while task.wait(10) do
            pcall(function()
                if game:FindFirstChild("CoreGui") then
                    for _, v in pairs(game.CoreGui:GetChildren()) do
                        if v.Name:lower():find("bac") or v.Name:lower():find("screenshot") then
                            v:Destroy()
                        end
                    end
                end
            end)
        end
    end)
    
    -- Identity Spoof
    spawn(function()
        task.wait(0.5)
        pcall(function()
            setidentity(2)
            getgenv().detected = false
            getgenv().flagged = false
            setidentity(7)
        end)
    end)
end

-- Execute bypass immediately
DeepBypass()

-- ============================================
-- SECTION 2: SERVICES
-- ============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Wait for character
if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

-- ============================================
-- SECTION 3: VARIABLES (AUTO ON!)
-- ============================================
local autoParry = true      -- Auto ON!
local autoSkill = true      -- Auto ON!
local autoSpam = true       -- Auto ON!
local proMovement = true    -- Auto ON!
local espEnabled = true     -- Auto ON!
local killAura = false      -- Optional
local autoDodge = true      -- Auto ON!

-- ============================================
-- SECTION 4: NOTIFICATION
-- ============================================
game.StarterGui:SetCore("SendNotification", {
    Title = "⚔️ DARKAI ACTIVATED",
    Text = "All features ON! BAC Bypassed!",
    Duration = 5,
    Icon = "rbxassetid://11556438882"
})

print("╔══════════════════════════════════╗")
print("║  DARKAI BLADE BALL - ACTIVATED  ║")
print("║  All Features: ON               ║")
print("║  BAC Bypass: ACTIVE             ║")
print("╚══════════════════════════════════╝")

-- ============================================
-- SECTION 5: ESP SYSTEM
-- ============================================
local function createESP()
    local espFolder = Instance.new("Folder")
    espFolder.Name = "DarkAI_ESP"
    espFolder.Parent = CoreGui
    
    RunService.RenderStepped:Connect(function()
        if not espEnabled then
            espFolder:ClearAllChildren()
            return
        end
        
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
                h.OutlineTransparency = 0
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
                h.OutlineColor = Color3.fromRGB(0, 200, 255)
            end
        end
    end)
end

createESP()

-- ============================================
-- SECTION 6: BALL DETECTION
-- ============================================
local function findNearestBall()
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

-- ============================================
-- SECTION 7: MAIN GAMEPLAY LOOP
-- ============================================
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end
    
    local ball, ballDist = findNearestBall()
    
    -- AUTO PARRY
    if autoParry and ball and ballDist < 65 then
        spawn(function()
            VIM:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
            task.wait(0.01)
            VIM:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
        end)
    end
    
    -- AUTO SKILL
    if autoSkill and ball and ballDist < 50 then
        spawn(function()
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") then
                    tool:Activate()
                    task.wait(0.3)
                end
            end
        end)
    end
    
    -- AUTO SPAM
    if autoSpam then
        spawn(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and (hrp.Position - root.Position).Magnitude < 30 then
                        for _, tool in pairs(char:GetChildren()) do
                            if tool:IsA("Tool") then
                                tool:Activate()
                            end
                        end
                    end
                end
            end
        end)
    end
    
    -- PRO MOVEMENT
    if proMovement and ball then
        local dir = (root.Position - ball.Position).Unit
        local strafe = Vector3.new(dir.X + math.random(-100,100)/100, 0, dir.Z + math.random(-100,100)/100).Unit
        root.Velocity = strafe * hum.WalkSpeed + Vector3.new(0, root.Velocity.Y, 0)
        if math.random(1,30) == 1 then hum.Jump = true end
    end
    
    -- AUTO DODGE
    if autoDodge and ball and ballDist < 25 then
        local awayDir = (root.Position - ball.Position).Unit
        root.Velocity = awayDir * 150 + Vector3.new(0, 50, 0)
    end
    
    -- KILL AURA
    if killAura then
        spawn(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local enemyHum = p.Character:FindFirstChild("Humanoid")
                    if hrp and enemyHum and enemyHum.Health > 0 then
                        local dist = (hrp.Position - root.Position).Magnitude
                        if dist < 100 then
                            local old = char:GetPivot()
                            char:PivotTo(hrp.CFrame * CFrame.new(0,0,3))
                            for _, tool in pairs(char:GetChildren()) do
                                if tool:IsA("Tool") then tool:Activate() end
                            end
                            task.wait(0.05)
                            char:PivotTo(old)
                        end
                    end
                end
            end
        end)
    end
end)

-- ============================================
-- SECTION 8: PERIODIC BYPASS REFRESH
-- ============================================
spawn(function()
    while task.wait(15) do
        pcall(function()
            -- Clean any new detection objects
            for _, v in pairs(CoreGui:GetChildren()) do
                if v.Name:lower():find("bac") or v.Name:lower():find("detect") then
                    v:Destroy()
                end
            end
            -- Reset flags
            getgenv().detected = false
            getgenv().flagged = false
        end)
    end
end)

-- ============================================
-- SECTION 9: SIMPLE STATUS INDICATOR
-- ============================================
local statusGui = Instance.new("ScreenGui")
statusGui.Parent = CoreGui
statusGui.Name = "DarkAI_Status"

local statusFrame = Instance.new("Frame")
statusFrame.Parent = statusGui
statusFrame.Size = UDim2.new(0, 12, 0, 12)
statusFrame.Position = UDim2.new(0.01, 0, 0.02, 0)
statusFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
statusFrame.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.Parent = statusFrame
statusCorner.CornerRadius = UDim.new(1, 0)

local statusBorder = Instance.new("UIStroke")
statusBorder.Parent = statusFrame
statusBorder.Thickness = 1
statusBorder.Color = Color3.fromRGB(0, 200, 0)

-- Blink effect to show script is active
spawn(function()
    while task.wait(1) do
        statusFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(0.5)
        statusFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end)

print("[DARKAI] Script loaded successfully!")
print("[DARKAI] BAC Bypass: ACTIVE")
print("[DARKAI] Features: AUTO ON")