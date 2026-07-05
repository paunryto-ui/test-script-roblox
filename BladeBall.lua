--[[
╔══════════════════════════════════════════════╗
║   BLADE BALL - ULTIMATE EDITION     ║
║   BAC Bypass • Sidebar UI • SVG Intro      ║
║   Auto Parry • Pro Movement • ESP          ║
║   Made by Pauntryy
]]--

-- ============ BAC BYPASS SYSTEM ============
local function bacBypass()
    -- BAC Detection Bypass
    local bacHooks = {}
    
    -- Bypass BAC scanning
    bacHooks[1] = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "Kick" or method == "kick" then
            return nil
        elseif string.find(method:lower(), "ban") then
            return nil
        elseif string.find(method:lower(), "detect") then
            return false
        elseif string.find(method:lower(), "flag") then
            return false
        end
        
        return bacHooks[1](self, ...)
    end)
    
    -- Bypass BAC environment check
    bacHooks[2] = hookfunction(getrenv().debug.traceback, function(...)
        return "Script"
    end)
    
    -- Bypass BAC remote detection
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            if v.Name:lower():find("ban") or v.Name:lower():find("kick") or v.Name:lower():find("detect") then
                v:Destroy()
            end
        end
    end
    
    -- Bypass Hyperion (Byfron)
    local oldFindFirstChild = game.FindFirstChild
    setreadonly(game, false)
    game.FindFirstChild = function(self, name, ...)
        if string.find(name:lower(), "byfron") or string.find(name:lower(), "hyperion") then
            return nil
        end
        return oldFindFirstChild(self, name, ...)
    end
    setreadonly(game, true)
    
    -- Memory protection bypass
    spawn(function()
        while task.wait(5) do
            for _, v in pairs(CoreGui:GetDescendants()) do
                if v.Name:lower():find("bac") or v.Name:lower():find("anticheat") then
                    v:Destroy()
                end
            end
        end
    end)
end

-- ============ AUTO REJOIN ============
local function autoRejoin()
    spawn(function()
        while task.wait(1) do
            if not game:IsLoaded() then
                task.wait(2)
                game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
            end
        end
    end)
end

bacBypass()
autoRejoin()

-- ============ SERVICES ============
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ============ SVG INTRO ============
local function playSVGIntro()
    local introGui = Instance.new("ScreenGui")
    introGui.Parent = CoreGui
    introGui.Name = "DarkAI_Intro"
    
    -- Background
    local bg = Instance.new("Frame")
    bg.Parent = introGui
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
    bg.BorderSizePixel = 0
    
    -- SVG Logo Circle
    local circle = Instance.new("Frame")
    circle.Parent = bg
    circle.Size = UDim2.new(0, 100, 0, 100)
    circle.Position = UDim2.new(0.5, -50, 0.35, -50)
    circle.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    circle.BorderSizePixel = 0
    circle.BackgroundTransparency = 1
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.Parent = circle
    circleCorner.CornerRadius = UDim.new(1, 0)
    
    local circleStroke = Instance.new("UIStroke")
    circleStroke.Parent = circle
    circleStroke.Thickness = 3
    circleStroke.Color = Color3.fromRGB(255, 0, 100)
    circleStroke.Transparency = 1
    
    -- Logo Text "DA"
    local logoText = Instance.new("TextLabel")
    logoText.Parent = circle
    logoText.Size = UDim2.new(1, 0, 1, 0)
    logoText.BackgroundTransparency = 1
    logoText.Text = "DA"
    logoText.TextColor3 = Color3.fromRGB(255, 0, 100)
    logoText.Font = Enum.Font.GothamBlack
    logoText.TextSize = 45
    logoText.TextTransparency = 1
    
    -- Subtitle
    local sub = Instance.new("TextLabel")
    sub.Parent = bg
    sub.Size = UDim2.new(1, 0, 0, 30)
    sub.Position = UDim2.new(0, 0, 0.52, 0)
    sub.BackgroundTransparency = 1
    sub.Text = "DARK AI BLADE BALL"
    sub.TextColor3 = Color3.fromRGB(255, 255, 255)
    sub.Font = Enum.Font.GothamBold
    sub.TextSize = 20
    sub.TextTransparency = 1
    
    -- Loading dots
    local dots = Instance.new("TextLabel")
    dots.Parent = bg
    dots.Size = UDim2.new(1, 0, 0, 20)
    dots.Position = UDim2.new(0, 0, 0.62, 0)
    dots.BackgroundTransparency = 1
    dots.Text = "LOADING"
    dots.TextColor3 = Color3.fromRGB(150, 150, 150)
    dots.Font = Enum.Font.Gotham
    dots.TextSize = 14
    dots.TextTransparency = 1
    
    -- Animate
    TweenService:Create(circle, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0,
        Rotation = 360
    }):Play()
    
    TweenService:Create(circleStroke, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Transparency = 0
    }):Play()
    
    TweenService:Create(logoText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    TweenService:Create(sub, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    TweenService:Create(dots, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0.5
    }):Play()
    
    -- Loading animation
    spawn(function()
        local dotCount = 0
        while introGui.Parent do
            dotCount = (dotCount % 3) + 1
            dots.Text = "LOADING" .. string.rep(".", dotCount)
            task.wait(0.4)
        end
    end)
    
    task.wait(3)
    
    -- Fade out
    TweenService:Create(bg, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play()
    
    task.wait(0.5)
    introGui:Destroy()
end

-- ============ MAIN UI - SIDEBAR STYLE ============
local function createSidebarUI()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Parent = CoreGui
    mainGui.Name = "DarkAI_Sidebar"
    
    -- Minimized Bar (Left side)
    local minimizedBar = Instance.new("Frame")
    minimizedBar.Parent = mainGui
    minimizedBar.Size = UDim2.new(0, 45, 0, 45)
    minimizedBar.Position = UDim2.new(0, 10, 0.05, 0)
    minimizedBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    minimizedBar.BorderSizePixel = 0
    
    local barCorner = Instance.new("UICorner")
    barCorner.Parent = minimizedBar
    barCorner.CornerRadius = UDim.new(0, 10)
    
    local barStroke = Instance.new("UIStroke")
    barStroke.Parent = minimizedBar
    barStroke.Thickness = 1.5
    barStroke.Color = Color3.fromRGB(255, 0, 100)
    
    local barIcon = Instance.new("TextLabel")
    barIcon.Parent = minimizedBar
    barIcon.Size = UDim2.new(1, 0, 1, 0)
    barIcon.BackgroundTransparency = 1
    barIcon.Text = "⚔️"
    barIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    barIcon.Font = Enum.Font.Gotham
    barIcon.TextSize = 20
    
    local barBtn = Instance.new("TextButton")
    barBtn.Parent = minimizedBar
    barBtn.Size = UDim2.new(1, 0, 1, 0)
    barBtn.BackgroundTransparency = 1
    barBtn.Text = ""
    
    -- Main Panel (Expandable)
    local mainPanel = Instance.new("Frame")
    mainPanel.Parent = mainGui
    mainPanel.Size = UDim2.new(0, 260, 0, 400)
    mainPanel.Position = UDim2.new(0, 10, 0.05, 55)
    mainPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
    mainPanel.BorderSizePixel = 0
    mainPanel.Visible = false
    
    local panelCorner = Instance.new("UICorner")
    panelCorner.Parent = mainPanel
    panelCorner.CornerRadius = UDim.new(0, 10)
    
    local panelStroke = Instance.new("UIStroke")
    panelStroke.Parent = mainPanel
    panelStroke.Thickness = 1.5
    panelStroke.Color = Color3.fromRGB(255, 0, 100)
    
    -- Panel Header (Drag handle)
    local header = Instance.new("Frame")
    header.Parent = mainPanel
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
    header.BorderSizePixel = 0
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.Parent = header
    headerCorner.CornerRadius = UDim.new(0, 10)
    
    -- Make header draggable
    local dragging = false
    local dragStart = Vector2.new()
    local panelStart = Vector2.new()
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            panelStart = mainPanel.Position
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainPanel.Position = UDim2.new(
                panelStart.X.Scale,
                panelStart.X.Offset + delta.X,
                panelStart.Y.Scale,
                panelStart.Y.Offset + delta.Y
            )
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Header title
    local headerTitle = Instance.new("TextLabel")
    headerTitle.Parent = header
    headerTitle.Size = UDim2.new(1, -40, 1, 0)
    headerTitle.Position = UDim2.new(0, 12, 0, 0)
    headerTitle.BackgroundTransparency = 1
    headerTitle.Text = "⚔️  DARKAI BLADE BALL"
    headerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    headerTitle.Font = Enum.Font.GothamBold
    headerTitle.TextSize = 13
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = header
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Position = UDim2.new(1, -34, 0.5, -14)
    closeBtn.Text = "✕"
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.Parent = closeBtn
    closeCorner.CornerRadius = UDim.new(0, 6)
    
    closeBtn.MouseButton1Click:Connect(function()
        mainPanel.Visible = false
        minimizedBar.Visible = true
    end)
    
    -- Content area
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Parent = mainPanel
    scrollFrame.Size = UDim2.new(1, -8, 1, -50)
    scrollFrame.Position = UDim2.new(0, 4, 0, 45)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.ScrollBarThickness = 3
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 100)
    
    local yOffset = 5
    
    -- Toggle function
    local function createToggle(name, icon, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Parent = scrollFrame
        toggleFrame.Size = UDim2.new(1, -10, 0, 35)
        toggleFrame.Position = UDim2.new(0, 5, 0, yOffset)
        toggleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
        toggleFrame.BorderSizePixel = 0
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.Parent = toggleFrame
        toggleCorner.CornerRadius = UDim.new(0, 8)
        
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
        toggle.Size = UDim2.new(0, 38, 0, 18)
        toggle.Position = UDim2.new(1, -50, 0.5, -9)
        toggle.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
        toggle.BorderSizePixel = 0
        
        local toggleCorner2 = Instance.new("UICorner")
        toggleCorner2.Parent = toggle
        toggleCorner2.CornerRadius = UDim.new(1, 0)
        
        local dot = Instance.new("Frame")
        dot.Parent = toggle
        dot.Size = UDim2.new(0, 13, 0, 13)
        dot.Position = UDim2.new(0, 3, 0.5, -6)
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
                TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(255, 0, 100)
                }):Play()
                TweenService:Create(dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Position = UDim2.new(1, -16, 0.5, -6)
                }):Play()
            else
                TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                }):Play()
                TweenService:Create(dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Position = UDim2.new(0, 3, 0.5, -6)
                }):Play()
            end
            callback(enabled)
        end)
        
        yOffset = yOffset + 40
        return toggleFrame
    end
    
    -- Features
    createToggle("Auto Parry", "⚡", function(v) autoParry = v end)
    createToggle("Auto Skill", "🔥", function(v) autoSkill = v end)
    createToggle("Auto Spam", "💥", function(v) autoSpam = v end)
    createToggle("Pro Movement", "🏃", function(v) proMovement = v end)
    createToggle("Player ESP", "👁️", function(v) espEnabled = v end)
    createToggle("Kill Aura", "☠️", function(v) killAura = v end)
    createToggle("Auto Dodge", "🛡️", function(v) autoDodge = v end)
    
    -- Skin section
    yOffset = yOffset + 5
    
    local skinLabel = Instance.new("TextLabel")
    skinLabel.Parent = scrollFrame
    skinLabel.Size = UDim2.new(1, -10, 0, 22)
    skinLabel.Position = UDim2.new(0, 5, 0, yOffset)
    skinLabel.Text = "🎨  SKIN CHANGER"
    skinLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    skinLabel.Font = Enum.Font.GothamBold
    skinLabel.TextSize = 12
    skinLabel.TextXAlignment = Enum.TextXAlignment.Left
    skinLabel.BackgroundTransparency = 1
    
    yOffset = yOffset + 25
    
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
    
    local selectedSkin = Instance.new("TextButton")
    selectedSkin.Parent = scrollFrame
    selectedSkin.Size = UDim2.new(1, -10, 0, 32)
    selectedSkin.Position = UDim2.new(0, 5, 0, yOffset)
    selectedSkin.Text = "Pilih Skin ▼"
    selectedSkin.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    selectedSkin.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectedSkin.Font = Enum.Font.Gotham
    selectedSkin.TextSize = 12
    
    local skinCorner = Instance.new("UICorner")
    skinCorner.Parent = selectedSkin
    skinCorner.CornerRadius = UDim.new(0, 6)
    
    local skinDropdown = Instance.new("Frame")
    skinDropdown.Parent = scrollFrame
    skinDropdown.Size = UDim2.new(1, -10, 0, #skins * 26)
    skinDropdown.Position = UDim2.new(0, 5, 0, yOffset + 34)
    skinDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    skinDropdown.BorderSizePixel = 0
    skinDropdown.Visible = false
    
    local ddCorner = Instance.new("UICorner")
    ddCorner.Parent = skinDropdown
    ddCorner.CornerRadius = UDim.new(0, 6)
    
    selectedSkin.MouseButton1Click:Connect(function()
        skinDropdown.Visible = not skinDropdown.Visible
    end)
    
    for i, skin in ipairs(skins) do
        local skinBtn = Instance.new("TextButton")
        skinBtn.Parent = skinDropdown
        skinBtn.Size = UDim2.new(1, 0, 0, 26)
        skinBtn.Position = UDim2.new(0, 0, 0, (i-1)*26)
        skinBtn.Text = skin[1]
        skinBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 50)
        skinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        skinBtn.Font = Enum.Font.Gotham
        skinBtn.TextSize = 11
        
        skinBtn.MouseButton1Click:Connect(function()
            applySkin(skin[2])
            selectedSkin.Text = skin[1]
            skinDropdown.Visible = false
        end)
    end
    
    yOffset = yOffset + 38
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 40)
    
    -- Toggle panel
    local panelVisible = false
    
    barBtn.MouseButton1Click:Connect(function()
        panelVisible = not panelVisible
        if panelVisible then
            mainPanel.Visible = true
            minimizedBar.Visible = false
            TweenService:Create(mainPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 260, 0, 400)
            }):Play()
        else
            minimizedBar.Visible = true
            mainPanel.Visible = false
        end
    end)
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
                    if not tex then tex = Instance.new("Texture"); tex.Parent = handle end
                    tex.TextureId = skinId
                else
                    local tex = handle:FindFirstChild("Texture")
                    if tex then tex:Destroy() end
                end
            end
        end
    end
end

-- ============ BALL DETECTION ============
function findNearestBall()
    local Character = LocalPlayer.Character
    if not Character then return nil, nil end
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return nil, nil end
    local nearest, nearestDist = nil, math.huge
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("ball") or v.Name:lower():find("blade")) then
            local dist = (v.Position - RootPart.Position).Magnitude
            if dist < nearestDist then nearestDist = dist; nearest = v end
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
        if not espEnabled then espFolder:ClearAllChildren(); return end
        espFolder:ClearAllChildren()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:lower():find("ball") then
                local h = Instance.new("Highlight"); h.Parent = espFolder; h.Adornee = v
                h.FillColor = Color3.fromRGB(255,0,0); h.FillTransparency = 0.5
                h.OutlineColor = Color3.fromRGB(255,255,0)
            end
        end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = Instance.new("Highlight"); h.Parent = espFolder; h.Adornee = p.Character
                h.FillColor = Color3.fromRGB(0,255,255); h.FillTransparency = 0.7
            end
        end
    end)
end

-- ============ GAMEPLAY SYSTEMS ============
RunService.RenderStepped:Connect(function()
    -- Auto Parry
    if autoParry then
        local ball, dist = findNearestBall()
        if ball and dist and dist < 65 then
            VIM:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
            task.wait(0.01)
            VIM:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
        end
    end
    
    -- Pro Movement
    if proMovement then
        local Character = LocalPlayer.Character
        if Character then
            local RootPart = Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character:FindFirstChild("Humanoid")
            if RootPart and Humanoid then
                local ball, _ = findNearestBall()
                if ball then
                    local dir = (RootPart.Position - ball.Position).Unit
                    local strafe = Vector3.new(dir.X + math.random(-100,100)/100, 0, dir.Z + math.random(-100,100)/100).Unit
                    RootPart.Velocity = strafe * Humanoid.WalkSpeed + Vector3.new(0, RootPart.Velocity.Y, 0)
                    if math.random(1,30) == 1 then Humanoid.Jump = true end
                end
            end
        end
    end
    
    -- Auto Dodge
    if autoDodge then
        local Character = LocalPlayer.Character
        if Character then
            local RootPart = Character:FindFirstChild("HumanoidRootPart")
            if RootPart then
                local ball, dist = findNearestBall()
                if ball and dist and dist < 25 then
                    local awayDir = (RootPart.Position - ball.Position).Unit
                    RootPart.Velocity = awayDir * 150 + Vector3.new(0, 50, 0)
                end
            end
        end
    end
    
    -- Kill Aura
    if killAura then
        local Character = LocalPlayer.Character
        if Character then
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
        end
    end
    
    -- Auto Skill
    if autoSkill then
        local Character = LocalPlayer.Character
        if Character then
            local ball, dist = findNearestBall()
            if ball and dist and dist < 50 then
                for _, tool in pairs(Character:GetChildren()) do
                    if tool:IsA("Tool") then tool:Activate(); task.wait(0.3) end
                end
            end
        end
    end
    
    -- Auto Spam
    if autoSpam then
        local Character = LocalPlayer.Character
        if Character then
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
        end
    end
end)

-- ============ INITIALIZATION ============
playSVGIntro()
task.wait(3.5)
createSidebarUI()
createESP()

game.StarterGui:SetCore("SendNotification", {
    Title = "⚔️ DARKAI ULTIMATE",
    Text = "BAC Bypassed! Sidebar Ready!",
    Duration = 6
})

print("╔══════════════════════════════════════╗")
print("║  DARKAI ULTIMATE EDITION LOADED     ║")
print("║  BAC Bypassed • Sidebar UI • SVG    ║")
print("╚══════════════════════════════════════╝")