-- Separate and loaded from a Loadstring for QOL.
print("This method WORKS. Continuing the script.")
-- sPhysics Installer Script (Single Script, UI + Deployment, Animated, Asset Import)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local StarterPlayer = game:GetService("StarterPlayer")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local InsertService = game:GetService("InsertService")

-- Utility for debugging asset contents
local function GetChildrenDebug(obj)
    print("Children of", obj:GetFullName())
    for i, v in obj:GetChildren() do
        print("  ", v.Name, v.ClassName)
    end
end

-- Function to request sPhysics asset by ID
local function RequestSPhysics()
    print("Requesting sPhysics object...")
    local AssetId = 79496498163804
    local success, Asset = pcall(function()
        return InsertService:LoadAsset(AssetId)
    end)
    if success and Asset then
        print("Downloaded: sPhysics V0.15")
        print("Double checking...")
        GetChildrenDebug(Asset)
        print("Prompting user for instruction...")
        -- Optionally parent the asset to Workspace for visibility
        Asset.Parent = game:GetService("Workspace")
        return Asset
    else
        warn("Failed to download sPhysics asset. Make sure API Services are enabled in Studio.")
        return nil
    end
end

-- UI Setup (Animated)
local function ShowInstallUI(callback)
    local player = Players.LocalPlayer or Players:GetPlayers()[1]
    local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")
    local gui = Instance.new("ScreenGui")
    gui.Name = "sPhysicsInstallPrompt"
    gui.IgnoreGuiInset = true
    gui.Parent = playerGui

    local blur = Instance.new("BlurEffect")
    blur.Name = "sPhysicsBlur"
    blur.Size = 0
    blur.Parent = Lighting

    -- Animate blur in
    TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 36}):Play()

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 260)
    frame.Position = UDim2.new(0.5, -200, 0.5, -130)
    frame.BackgroundColor3 = Color3.fromRGB(26, 33, 36)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 1
    frame.Parent = gui

    -- Animate frame fade-in
    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.RobotoCondensed
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Text = "sPhysics Installation"
    title.TextSize = 32
    title.Parent = frame

    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, -20, 0, 40)
    info.Position = UDim2.new(0, 10, 0, 55)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.Roboto
    info.TextColor3 = Color3.fromRGB(200,200,200)
    info.Text = "Choose which assets to install:"
    info.TextSize = 18
    info.Parent = frame

    -- Toggles
    local UseStarterCharacter = true
    local UseStarterCharacterScripts = true

    local function makeToggleButton(text, yPos)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 360, 0, 36)
        btn.Position = UDim2.new(0, 20, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(40, 50, 60)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.Roboto
        btn.TextSize = 20
        btn.Text = text
        btn.AutoButtonColor = false
        btn.BackgroundTransparency = 0
        btn.Parent = frame

        -- Add animated highlight bar
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(0, 0, 1, 0)
        bar.Position = UDim2.new(0, 0, 0, 0)
        bar.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
        bar.BorderSizePixel = 0
        bar.BackgroundTransparency = 0.5
        bar.Parent = btn

        return btn, bar
    end

    local charToggle, charBar = makeToggleButton("StarterCharacter: ON", 100)
    local scriptsToggle, scriptsBar = makeToggleButton("StarterCharacterScripts: ON", 145)

    local confirm = Instance.new("TextButton")
    confirm.Size = UDim2.new(0, 360, 0, 36)
    confirm.Position = UDim2.new(0, 20, 0, 190)
    confirm.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
    confirm.TextColor3 = Color3.fromRGB(255,255,255)
    confirm.Font = Enum.Font.Roboto
    confirm.TextSize = 22
    confirm.Text = "Install"
    confirm.AutoButtonColor = false
    confirm.BackgroundTransparency = 0
    confirm.Parent = frame

    -- Toggle logic with animation
    local function animateToggle(btn, bar, state)
        local colorOn = Color3.fromRGB(40, 50, 60)
        local colorOff = Color3.fromRGB(80, 80, 80)
        local barSize = state and 360 or 0
        local bgColor = state and colorOn or colorOff
        TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = bgColor}):Play()
        TweenService:Create(bar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, barSize, 1, 0)}):Play()
    end

    charToggle.MouseButton1Click:Connect(function()
        UseStarterCharacter = not UseStarterCharacter
        charToggle.Text = "StarterCharacter: " .. (UseStarterCharacter and "ON" or "OFF")
        animateToggle(charToggle, charBar, UseStarterCharacter)
        if not UseStarterCharacter then
            UseStarterCharacterScripts = false
            scriptsToggle.Text = "StarterCharacterScripts: OFF"
            animateToggle(scriptsToggle, scriptsBar, false)
        else
            animateToggle(scriptsToggle, scriptsBar, UseStarterCharacterScripts)
        end
    end)

    scriptsToggle.MouseButton1Click:Connect(function()
        if UseStarterCharacter then
            UseStarterCharacterScripts = not UseStarterCharacterScripts
            scriptsToggle.Text = "StarterCharacterScripts: " .. (UseStarterCharacterScripts and "ON" or "OFF")
            animateToggle(scriptsToggle, scriptsBar, UseStarterCharacterScripts)
        end
    end)

    -- Initial animation
    animateToggle(charToggle, charBar, true)
    animateToggle(scriptsToggle, scriptsBar, true)

    confirm.MouseButton1Click:Connect(function()
        -- Animate frame and blur out
        TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
        TweenService:Create(blur, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0}):Play()
        task.wait(0.45)
        gui:Destroy()
        blur:Destroy()
        callback(UseStarterCharacter, UseStarterCharacterScripts)
    end)
end

-- Deployment logic
local function Deploy(ExportFolder, UseStarterCharacter, UseStarterCharacterScripts)
    print("Deploying sPhysics with options:")
    print("StarterCharacter:", UseStarterCharacter)
    print("StarterCharacterScripts:", UseStarterCharacterScripts)

    local StarterPlayerFolder = ExportFolder:FindFirstChild("StarterPlayer")
    local StarterCharacterScripties = StarterPlayerFolder and StarterPlayerFolder:FindFirstChild("StarterCharacterScripts")
    local DefaultRig = StarterPlayerFolder and StarterPlayerFolder:FindFirstChild("StarterCharacter")
    local ReplicatedFolder = ExportFolder:FindFirstChild("ReplicatedStorage")
    local ServerFolder = ExportFolder:FindFirstChild("ServerScriptService")

    if StarterPlayerFolder then
        if UseStarterCharacter and UseStarterCharacterScripts then
            if DefaultRig then
                DefaultRig.Parent = StarterPlayer
            end
            if StarterCharacterScripties then
                StarterCharacterScripties.Parent = StarterPlayer:FindFirstChild("StarterCharacterScripts")
            end
            StarterPlayerFolder:Destroy()
        elseif not UseStarterCharacter and UseStarterCharacterScripts then
            -- This is an invalid state, just destroy the folder and continue
            StarterPlayerFolder:Destroy()
        elseif UseStarterCharacter and not UseStarterCharacterScripts then
            if DefaultRig then
                DefaultRig.Parent = StarterPlayer
            end
            StarterPlayerFolder:Destroy()
        elseif not UseStarterCharacter and not UseStarterCharacterScripts then
            StarterPlayerFolder:Destroy()
        end
    end

    if ReplicatedFolder then
        local remotes = ReplicatedFolder:FindFirstChild("sPhysics_Remotes")
        local coreStorage = ReplicatedFolder:FindFirstChild("sPhysics_CoreStorage")
        if remotes then
            remotes.Parent = ReplicatedStorage
        end
        if coreStorage then
            coreStorage.Parent = ReplicatedStorage
        end
        ReplicatedFolder:Destroy()
    end

    if ServerFolder then
        local coreScripts = ServerFolder:FindFirstChild("sPhysics_CoreScripts")
        if coreScripts then
            coreScripts.Parent = ServerScriptService
        end
        ServerFolder:Destroy()
    end

    print("Setup Complete | sPhysics")
    task.wait(1)
    if ExportFolder then
        ExportFolder:Destroy()
    end

    local VerifyObject = Instance.new("BoolValue")
    VerifyObject.Name = "sPhysics_Verified"
    VerifyObject.Value = true
    VerifyObject.Parent = game
end

-- Main execution
print("sPhysics Installer Script Running...")

local function StartInstaller()
    local ExportFolder = RequestSPhysics()
    if not ExportFolder then
        warn("sPhysics installer aborted: asset not found.")
        return
    end
    ShowInstallUI(function(UseStarterCharacter, UseStarterCharacterScripts)
        Deploy(ExportFolder, UseStarterCharacter, UseStarterCharacterScripts)
    end)
end

if Players.LocalPlayer or #Players:GetPlayers() > 0 then
    StartInstaller()
else
    print("No player found for UI. Running default install (both ON).")
    local ExportFolder = RequestSPhysics()
    if ExportFolder then
        Deploy(ExportFolder, true, true)
    else
        warn("sPhysics installer aborted: asset not found.")
    end
end

print("sPhysics Installer Script Finished.")


print("If you made it here, the sPhysics module deployed...")
task.wait(1)
print("SUCCESFULLY!!!")
