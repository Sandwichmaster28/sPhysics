-- sPhysics Installer Script (Single Script, UI + Deployment, Animated, Asset Import)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local StarterPlayer = game:GetService("StarterPlayer")
local StarterPlayerScripts = StarterPlayer:FindFirstChild("StarterPlayerScripts")
local StarterCharacterScripts = StarterPlayer:FindFirstChild("StarterCharacterScripts")
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

-- Deployment logic (optimized)
local function Deploy(ImportedAsset, UseStarterCharacter, UseStarterCharacterScripts)
    print("Deploying sPhysics with options:")
    print("StarterCharacter:", UseStarterCharacter)
    print("StarterCharacterScripts:", UseStarterCharacterScripts)

    -- Helper to move children to service by folder name
    local function MoveFolderContents(folder, service)
        for i, obj in folder:GetChildren() do
            if obj.Name == "ThumbnailCamera" or obj.Name == "Thumbnail" then
                -- Ignore
            elseif obj.Name == "DefaultRig" and obj:IsA("Model") then
                obj.Parent = ReplicatedStorage
            elseif obj:IsA("Folder") and game:GetService(obj.Name) then
                -- Nested folder for a service, move its children to the service
                MoveFolderContents(obj, game:GetService(obj.Name))
                obj:Destroy()
            elseif obj.Name == "StarterCharacterScripts" and obj:IsA("Folder") then
                if UseStarterCharacterScripts and StarterCharacterScripts then
                    for j, child in obj:GetChildren() do
                        child.Parent = StarterCharacterScripts
                    end
                end
                obj:Destroy()
            elseif obj.Name == "StarterCharacter" and obj:IsA("Model") then
                if UseStarterCharacter then
                    obj.Parent = StarterPlayer
                else
                    obj:Destroy()
                end
            else
                obj.Parent = service
            end
        end
    end

    -- Main asset deployment
    for i, folder in ImportedAsset:GetChildren() do
        if folder:IsA("Folder") and game:GetService(folder.Name) then
            MoveFolderContents(folder, game:GetService(folder.Name))
            folder:Destroy()
        elseif folder.Name == "DefaultRig" and folder:IsA("Model") then
            folder.Parent = ReplicatedStorage
        elseif folder.Name == "ThumbnailCamera" or folder.Name == "Thumbnail" then
            -- Ignore
        else
            -- Any other objects not handled, delete
            folder:Destroy()
        end
    end

    print("Setup Complete | sPhysics")
    task.wait(1)
    if ImportedAsset then
        ImportedAsset:Destroy()
    end

    local VerifyObject = Instance.new("BoolValue")
    VerifyObject.Name = "sPhysics_Verified"
    VerifyObject.Value = true
    VerifyObject.Parent = game
end

-- Main execution
print("sPhysics Installer Script Running...")

local function StartInstaller()
    local ImportedAsset = RequestSPhysics()
    if not ImportedAsset then
        warn("sPhysics installer aborted: asset not found.")
        return
    end
    ShowInstallUI(function(UseStarterCharacter, UseStarterCharacterScripts)
        Deploy(ImportedAsset, UseStarterCharacter, UseStarterCharacterScripts)
    end)
end

if Players.LocalPlayer or #Players:GetPlayers() > 0 then
    StartInstaller()
else
    print("No player found for UI. Running default install (both ON).")
    local ImportedAsset = RequestSPhysics()
    if ImportedAsset then
        Deploy(ImportedAsset, true, true)
    else
        warn("sPhysics installer aborted: asset not found.")
    end
end

print("sPhysics Installer Script Finished.")

