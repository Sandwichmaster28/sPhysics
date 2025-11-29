-- sPhysics Installer Script (Single Script, UI + Deployment, Animated, Asset Import)
local game = game
local StarterGui = game:GetService("StarterGui")


if game:FindFirstChild("sPhysics_Verified") then
	print("sPhysics is already installed.")
	else
	print("Installing sPhysics V0.15...")
end

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
        return game:GetService("InsertService"):LoadAsset(AssetId)
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
    -- Parent the installer UI to StarterGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "sPhysicsInstallPrompt"
    gui.IgnoreGuiInset = true
    gui.Parent = StarterGui

    local blur = Instance.new("BlurEffect")
    blur.Name = "sPhysicsBlur"
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")

    -- Animate blur in
    game:GetService("TweenService"):Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 36}):Play()

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 260)
    frame.Position = UDim2.new(0.5, -200, 0.5, -130)
    frame.BackgroundColor3 = Color3.fromRGB(26, 33, 36)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 1
    frame.Parent = gui

    -- Animate frame fade-in
    game:GetService("TweenService"):Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()

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
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = bgColor}):Play()
        game:GetService("TweenService"):Create(bar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, barSize, 1, 0)}):Play()
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
        game:GetService("TweenService"):Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(blur, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0}):Play()
        task.wait(0.45)
        gui:Destroy()
        blur:Destroy()
        callback(UseStarterCharacter, UseStarterCharacterScripts)
    end)
end

-- Deployment logic (corrected for sPhysics folder structure)
local function Deploy(ImportedAsset, UseStarterCharacter, UseStarterCharacterScripts)
    print("Deploying sPhysics with options:")
    print("StarterCharacter:", UseStarterCharacter)
    print("StarterCharacterScripts:", UseStarterCharacterScripts)

    -- Find the main sPhysics folder inside the Model
    local modelContainer = ImportedAsset
    for i, obj in modelContainer:GetChildren() do
        if obj:IsA("Folder") and obj.Name == "sPhysics | V 0.1.5 | Thanks for choosing sPhys." then
            modelContainer = obj
            break
        end
    end

    if not modelContainer then
        warn("sPhysics folder not found in asset!")
        return
    end

    -- Move contents of sPhysics subfolders to their respective services
    for i, subfolder in modelContainer:GetChildren() do
        if subfolder:IsA("Folder") then
            if subfolder.Name == "StarterPlayer" then
                -- Move StarterCharacter model if present
                for j, child in subfolder:GetChildren() do
                    if child.Name == "StarterCharacter" and child:IsA("Model") then
                        if UseStarterCharacter then
                            child.Parent = game:GetService("StarterPlayer")
                        else
                            child:Destroy()
                        end
                    end
                end
            elseif subfolder.Name == "StarterCharacterScripts" then
                -- Move scripts to StarterCharacterScripts
                if UseStarterCharacterScripts then
                    for j, child in subfolder:GetChildren() do
                        child.Parent = game:GetService("StarterCharacterScripts")
                    end
                end
                subfolder:Destroy()
            elseif subfolder.Name == "StarterPlayerScripts" then
                -- Move scripts to StarterPlayerScripts
                for j, child in subfolder:GetChildren() do
                    child.Parent = game:GetService("StarterPlayerScripts")
                end
                subfolder:Destroy()
            else
                -- If folder matches another service, move its children
                local service = nil
                pcall(function()
                    service = game:GetService(subfolder.Name)
                end)
                if service then
                    for j, child in subfolder:GetChildren() do
                        child.Parent = service
                    end
                    subfolder:Destroy()
                end
            end
        end
    end

    -- Move DefaultRig to ReplicatedStorage
    for i, obj in modelContainer:GetChildren() do
        if obj:IsA("Model") and obj.Name == "DefaultRig" then
            obj.Parent = game:GetService("ReplicatedStorage")
            break
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

-- Always run installer UI via StarterGui
StartInstaller()

print("sPhysics Installer Script Finished.")
