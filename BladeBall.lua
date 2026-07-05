--[[
╔══════════════════════════════════════════════╗
║   DARKAI BLADE BALL - REDZ UI EDITION      ║
║   Simple Clean UI + Smooth Animation       ║
║   Auto Parry • Pro Movement • ESP          ║
║   Made by Esa (DARK AI)                    ║
╚══════════════════════════════════════════════╝
]]--

-- ============ BYPASS ============
local function deepBypass()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "Ban" then return nil end
        return oldNamecall(self, ...)
    end)
end
deepBypass()

-- ============ SERVICES ============
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- ============ VARIABLES ============
local autoParry = false
local autoSkill = false
local autoSpam = false
local proMovement = false
local espEnabled = false
local killAura = false
local autoDodge = false
local uiVisible = true

-- ============ INTRO ANIMATION ============
local function playIntro()
    local introGui = Instance.new("ScreenGui")
    introGui.Parent = CoreGui
    introGui.Name = "Intro"
    
    -- Background hitam
    local bg = Instance.new("Frame")
    bg.Parent = introGui
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BorderSizePixel = 0
    
    -- Logo text
    local logo = Instance.new("TextLabel")
    logo.Parent = bg
    logo.Size = UDim2.new(1, 0, 0, 50)
    logo.Position = UDim2.new(0, 0, 0.4, 0)
    logo.BackgroundTransparency = 1
    logo.Text = "DARK AI"
    logo.TextColor3 = Color3.fromRGB(255, 0, 100)
    logo.Font = Enum.Font.GothamBlack
    logo.TextSize = 40
    logo.TextTransparency = 1
    
    local sub = Instance.new("TextLabel")
    sub.Parent = bg
    sub.Size = UDim2.new(1, 0, 0, 30)
    sub.Position = UDim2.new(0, 0, 0.5, 0)
    sub.BackgroundTransparency = 1
    sub.Text = "Blade Ball Pro Edition"
    sub.TextColor3 = Color3.fromRGB(255, 255, 255)
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 18
    sub.TextTransparency = 1
    
    local credit = Instance.new("TextLabel")
    credit.Parent = bg
    credit.Size = UDim2.new(1, 0, 0, 20)
    credit.Position = UDim2.new(0, 0, 0.85, 0)
    credit.BackgroundTransparency = 1
    credit.Text = "Made by Esa"
    credit.TextColor3 = Color3.fromRGB(150, 150, 150)
    credit.Font = Enum.Font.Gotham
    credit.TextSize = 14
    credit.TextTransparency = 1
    
    -- Loading bar
    local loadBar = Instance.new("Frame")
    loadBar.Parent = bg
    loadBar.Size = UDim2.new(0, 0, 0, 4)
    loadBar.Position = UDim2.new(0.25, 0, 0.6, 0)
    loadBar.BackgroundColor3 = Color3.fromRGB(255, 0, 100)
    loadBar.BorderSizePixel = 0
    
    local loadBg = Instance.new("Frame")
    loadBg.Parent = bg
    loadBg.Size = UDim2.new(0.5, 0, 0, 4)
    loadBg.Position = UDim2.new(0.25, 0, 0.6, 0)
    loadBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    loadBg.BorderSizePixel = 0
    
    -- Animations
    TweenService:Create(logo, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    TweenService:Create(sub, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    TweenService:Create(credit, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.5}):Play()
    TweenService:Create(loadBar, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(0.5, 0, 0, 4)}):Play()
    
    -- Remove intro after 2.5s
    task.wait(2.5)
    TweenService:Create(bg, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
    task.wait(0.5)
    introGui:Destroy()
end

-- ============ MAIN UI (REDZ STYLE) ============
local function createMainUI()
    -- Main container
    local mainGui = Instance.new("ScreenGui")
    mainGui.Parent = CoreGui
    mainGui.Name = "DarkAI_Main"
    
    -- Main Frame (Redz Style - Simple & Clean)
    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = mainGui
    mainFrame.Size = UDim2.new(0, 280, 0, 35)
    mainFrame.Position = UDim2.new(1, -290, 0.05, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BorderSizePixel = 0
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.Parent = mainFrame
    mainCorner.CornerRadius = UDim.new(0, 6)
    
    -- Title Bar (Collapse/Expand)
    local titleBar = Instance.new("TextButton")
    titleBar.Parent = mainFrame
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    titleBar.Text = "  ⚔️  DARKAI BLADE BALL"
    titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleBar.Font = Enum.Font.GothamBold
    titleBar.TextSize = 14
    titleBar.TextXAlignment = Enum.TextXAlignment.Left
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.Parent = titleBar
    titleCorner.CornerRadius = UDim.new(0, 6)
    
    -- Status indicator
    local statusDot = Instance.new("Frame")
    statusDot.Parent = titleBar
    statusDot.Size = UDim2.new(0, 8, 0, 8)
    statusDot.Position = UDim2.new(1, -20, 0.5, -4)
    statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    statusDot.BorderSizePixel = 0
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.Parent = statusDot
    dotCorner.CornerRadius = UDim.new(1, 0)
    
    -- Content Frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Parent = mainFrame
    contentFrame.Size = UDim2.new(1, 0, 0, 0)
    contentFrame.Position = UDim2.new(0, 0, 0, 35)
    contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    contentFrame.BorderSizePixel = 0
    contentFrame.ClipsDescendants = true
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.Parent = contentFrame
    contentCorner.CornerRadius = UDim.new(0, 6)
    
    -- Scrolling Frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Parent = contentFrame
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollBarThickness = 3
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 100)
    
    local yOffset = 10
    local expanded = false
    
    -- Toggle function (Redz Style)
    local function createToggle(name, icon, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Parent = scrollFrame
        toggleFrame.Size = UDim2.new(1, -16, 0, 32)
        toggleFrame.Position = UDim2.new(0, 8, 0, yOffset)
        toggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        toggleFrame.BorderSizePixel = 0
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.Parent = toggleFrame
        toggleCorner.CornerRadius = UDim.new(0, 5)
        
        local label = Instance.new("TextLabel")
        label.Parent = toggleFrame
        label.Size = UDim2.new(0.65, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.Text = icon .. "  " .. name
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        
        local toggle = Instance.new("Frame")
        toggle.Parent = toggleFrame
        toggle.Size = UDim2.new(0, 40, 0, 18)
        toggle.Position = UDim2.new(1, -55, 0.5, -9)
        toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        toggle.BorderSizePixel = 0
        
        local toggleCorner2 = Instance.new("UICorner")
        toggleCorner2.Parent = toggle
        toggleCorner2.CornerRadius = UDim.new(1, 0)
        
        local dot = Instance.new("Frame")
        dot.Parent = toggle
        dot.Size = UDim2.new(0, 14, 0, 14)
        dot.Position = UDim2.new(0, 2, 0.5, -7)
        dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        dot.BorderSizePixel = 0
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.Parent = dot
        dotCorner.CornerRadius = UDim.new(1, 0)
        
        local enabled = false
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Parent = toggleFrame
        toggleBtn.Size = UDim2.new(1, 0, 1, 0)
        toggleBtn.BackgroundTransparency = 1
        toggleBtn.Text = ""
        
        toggleBtn.MouseButton1Click:Connect(function()
            enabled = not enabled
            if enabled then
                TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(255, 0, 100)}):Play()
                TweenService:Create(dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -16, 0.5, -7)}):Play()
            else
                TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
                TweenService:Create(dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 2, 0.5, -7)}):Play()
            end
            callback(enabled)
        end)
        
        yOffset = yOffset + 38
        return toggleFrame
    end
    
    -- Create toggle buttons
    createToggle("Auto Parry", "⚡", function(v) autoParry = v end)
    createToggle("Auto Skill", "🔥", function(v) autoSkill = v end)
    createToggle("Auto Spam", "💥", function(v) autoSpam = v end)
    createToggle("Pro Movement", "🏃", function(v) proMovement = v end)
    createToggle("Player ESP", "👁️", function(v) espEnabled = v end)
    createToggle("Kill Aura", "☠️", function(v) killAura = v end)
    createToggle("Auto Dodge", "🛡️", function(v) autoDodge = v end)
    
    -- Skin section
    local skinLabel = Instance.new("TextLabel")
    skinLabel.Parent = scrollFrame
    skinLabel.Size = UDim2.new(1, -16, 0, 25)
    skinLabel.Position = UDim2.new(0, 8, 0, yOffset + 5)
    skinLabel.Text = "🎨  SKIN CHANGER"
    skinLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    skinLabel.Font = Enum.Font.GothamBold
    skinLabel.TextSize = 13
    skinLabel.TextXAlignment = Enum.TextXAlignment.Left
    skinLabel.BackgroundTransparency = 1
    
    yOffset = yOffset + 30
    
    local skins = {
        {"Default", ""},
        {"Dark Blade", "rbxassetid://11556438996"},
        {"Neon Blade", "rbxassetid://11556439110"},
        {"Galaxy Sword", "rbxassetid://11556439224"},
        {"Inferno Blade", "rbxassetid://11556439338"},
        {"Frost Sword", "rbxassetid://11556439452"},
        {"Thunder Edge", "rbxassetid://11556439566"},
        {"Dragon Slayer", "rbxassetid://11556439680"},
    }
    
    local skinDropdown = Instance.new("Frame")
    skinDropdown.Parent = scrollFrame
    skinDropdown.Size = UDim2.new(1, -16, 0, 28)
    skinDropdown.Position = UDim2.new(0, 8, 0, yOffset)
    skinDropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    skinDropdown.Visible = false
    
    yOffset = yOffset + 35
    
    local selectedSkin = Instance.new("TextButton")
    selectedSkin.Parent = scrollFrame
    selectedSkin.Size = UDim2.new(1, -16, 0, 30)
    selectedSkin.Position = UDim2.new(0, 8, 0, yOffset - 35)
    selectedSkin.Text = "Pilih Skin ▼"
    selectedSkin.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    selectedSkin.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectedSkin.Font = Enum.Font.Gotham
    selectedSkin.TextSize = 12
    
    local skinCorner = Instance.new("UICorner")
    skinCorner.Parent = selectedSkin
    skinCorner.CornerRadius = UDim.new(0, 5)
    
    selectedSkin.MouseButton1Click:Connect(function()
        skinDropdown.Visible = not skinDropdown.Visible
    end)
    
    for i, skin in ipairs(skins) do
        local skinBtn = Instance.new("TextButton")
        skinBtn.Parent = skinDropdown
        skinBtn.Size = UDim2.new(1, 0, 0, 25)
        skinBtn.Position = UDim2.new(0, 0, 0, (i-1) * 25)
        skinBtn.Text = skin[1]
        skinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        skinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        skinBtn.Font = Enum.Font.Gotham
        skinBtn.TextSize = 11
        
        skinBtn.MouseButton1Click:Connect(function()
            applySkin(skin[2])
            selectedSkin.Text = skin[1]
            skinDropdown.Visible = false
        end)
    end
    
    skinDropdown.Size = UDim2.new(1, -16, 0, #skins * 25)
    
    -- Update canvas size
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 20)
    
    -- Expand/Collapse animation
    local function toggleExpand()
        expanded = not expanded
        if expanded then
            TweenService:Create(contentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, 350)}):Play()
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 280, 0, 385)}):Play()
        else
            TweenService:Create(contentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 280, 0, 35)}):Play()
        end
    end
    
    titleBar.MouseButton1Click:Connect(toggleExpand)
    
    -- Auto expand on first load
    task.wait(0.5)
    toggleExpand()
end

-- ============ SKIN APPLIER ============
function applySkin(skinId)
    local Character = LocalPlayer.Character
    if not Character then return end
    
    for _, item in pairs(Character:GetDescendants()) do
        if item:IsA("Tool") or item:IsA("Accessory") then
            local handle = item:FindFirstChild("Handle")
            if handle then
                if skinId ~= "" then
                    local tex = handle:FindFirstChild("Texture")
                    if not tex then
                        tex = Instance.new("Texture")
                        tex.Parent = handle
                    end
                    tex.TextureId = skinId
                else
                    local tex = handle:FindFirstChild("Texture")
                    if tex then tex:Destroy() end
                end
            end
        end
    end
end

-- ============ FIND BALL ============
function findNearestBall()
    local Character = LocalPlayer.Character
    if not Character then return nil, nil end
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return nil, nil end
    
    local nearest = nil
    local nearestDist = math.huge
    
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("ball") or v.Name:lower():find("blade")) then
            local dist = (v.Position - RootPart.Position).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = v
            end
        end
    end
    return nearest, nearestDist
end

-- ============ ESP ============
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

-- ============ AUTO PARRY ============
RunService.RenderStepped:Connect(function()
    if not autoParry then return end
    local ball, dist = findNearestBall()
    if ball and dist and dist < 65 then
        VIM:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
        task.wait(0.01)
        VIM:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
    end
end)

-- ============ PRO MOVEMENT ============
RunService.RenderStepped:Connect(function()
    if not proMovement then return end
    local Character = LocalPlayer.Character
    if not Character then return end
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not RootPart or not Humanoid then return end
    
    local ball, _ = findNearestBall()
    if ball then
        local dir = (RootPart.Position - ball.Position).Unit
        local strafe = Vector3.new(dir.X + math.random(-100,100)/100, 0, dir.Z + math.random(-100,100)/100).Unit
        RootPart.Velocity = strafe * Humanoid.WalkSpeed + Vector3.new(0, RootPart.Velocity.Y, 0)
        if math.random(1,30) == 1 then Humanoid.Jump = true end
    end
end)

-- ============ AUTO DODGE ============
RunService.RenderStepped:Connect(function()
    if not autoDodge then return end
    local Character = LocalPlayer.Character
    if not Character then return end
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return end
    
    local ball, dist = findNearestBall()
    if ball and dist and dist < 25 then
        local awayDir = (RootPart.Position - ball.Position).Unit
        RootPart.Velocity = awayDir * 150 + Vector3.new(0, 50, 0)
    end
end)

-- ============ KILL AURA ============
RunService.RenderStepped:Connect(function()
    if not killAura then return end
    local Character = LocalPlayer.Character
    if not Character then return end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (hrp.Position - Character:GetPivot().Position).Magnitude
                if dist < 100 then
                    local old = Character:GetPivot()
                    Character:PivotTo(hrp.CFrame * CFrame.new(0,0,3))
                    for _, tool in pairs(Character:GetChildren()) do
                        if tool:IsA("Tool") then tool:Activate() end
                    end
                    task.wait(0.05)
                    Character:PivotTo(old)
                end
            end
        end
    end
end)

-- ============ AUTO SKILL ============
RunService.RenderStepped:Connect(function()
    if not autoSkill then return end
    local Character = LocalPlayer.Character
    if not Character then return end
    local ball, dist = findNearestBall()
    if ball and dist and dist < 50 then
        for _, tool in pairs(Character:GetChildren()) do
            if tool:IsA("Tool") then
                tool:Activate()
                task.wait(0.3)
            end
        end
    end
end)

-- ============ AUTO SPAM ============
RunService.RenderStepped:Connect(function()
    if not autoSpam then return end
    local Character = LocalPlayer.Character
    if not Character then return end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (hrp.Position - Character:GetPivot().Position).Magnitude
                if dist < 30 then
                    for _, tool in pairs(Character:GetChildren()) do
                        if tool:IsA("Tool") then tool:Activate() end
                    end
                end
            end
        end
    end
end)

-- ============ KEYBIND TOGGLE UI ============
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        uiVisible = not uiVisible
        local main = CoreGui:FindFirstChild("DarkAI_Main")
        if main then
            main.Enabled = uiVisible
        end
    end
end)

-- ============ INITIALIZATION ============
playIntro()
task.wait(3)
createMainUI()
createESP()

game.StarterGui:SetCore("SendNotification", {
    Title = "⚔️ DARKAI REDZ EDITION",
    Text = "Loaded! Right Shift to Toggle UI",
    Duration = 8
})

print("╔══════════════════════════════════╗")
print("║  DARKAI REDZ UI EDITION LOADED  ║")
print("║  Press RIGHT SHIFT to Toggle    ║")
print("╚══════════════════════════════════╝")