local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SetupLoadingUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = StarterGUI

-- Create the main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Text = "sPhysics Installation"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 32
title.Parent = frame

-- Custom Characters Option
local customCharLabel = Instance.new("TextLabel")
customCharLabel.Text = "Enable Custom Characters?"
customCharLabel.Size = UDim2.new(1, -20, 0, 30)
customCharLabel.Position = UDim2.new(0, 10, 0, 60)
customCharLabel.BackgroundTransparency = 1
customCharLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
customCharLabel.Font = Enum.Font.SourceSans
customCharLabel.TextSize = 22
customCharLabel.Parent = frame

local customCharToggle = Instance.new("TextButton")
customCharToggle.Text = "No"
customCharToggle.Size = UDim2.new(0, 80, 0, 30)
customCharToggle.Position = UDim2.new(0, 10, 0, 100)
customCharToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
customCharToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
customCharToggle.Font = Enum.Font.SourceSans
customCharToggle.TextSize = 20
customCharToggle.Parent = frame

-- Custom Character Scripts Option
local customScriptLabel = Instance.new("TextLabel")
customScriptLabel.Text = "Enable Custom Character Scripts?"
customScriptLabel.Size = UDim2.new(1, -20, 0, 30)
customScriptLabel.Position = UDim2.new(0, 10, 0, 140)
customScriptLabel.BackgroundTransparency = 1
customScriptLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
customScriptLabel.Font = Enum.Font.SourceSans
customScriptLabel.TextSize = 22
customScriptLabel.Parent = frame

local customScriptToggle = Instance.new("TextButton")
customScriptToggle.Text = "No"
customScriptToggle.Size = UDim2.new(0, 80, 0, 30)
customScriptToggle.Position = UDim2.new(0, 10, 0, 180)
customScriptToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
customScriptToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
customScriptToggle.Font = Enum.Font.SourceSans
customScriptToggle.TextSize = 20
customScriptToggle.Parent = frame

-- Confirm Button
local confirmButton = Instance.new("TextButton")
confirmButton.Text = "Confirm"
confirmButton.Size = UDim2.new(0, 120, 0, 40)
confirmButton.Position = UDim2.new(0.5, -60, 1, -60)
confirmButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmButton.Font = Enum.Font.SourceSansBold
confirmButton.TextSize = 24
confirmButton.Parent = frame

-- State variables
local customCharacters = false
local customCharacterScripts = false

-- Toggle logic
customCharToggle.MouseButton1Click:Connect(function()
    customCharacters = not customCharacters
    customCharToggle.Text = customCharacters and "Yes" or "No"
    customCharToggle.BackgroundColor3 = customCharacters and Color3.fromRGB(57, 170, 55) or Color3.fromRGB(198, 26, 26)
end)

customScriptToggle.MouseButton1Click:Connect(function()
    customCharacterScripts = not customCharacterScripts
    customScriptToggle.Text = customCharacterScripts and "Yes" or "No"
	customScriptToggle.BackgroundColor3 = customCharacterScripts and Color3.fromRGB(57, 170, 55) or Color3.fromRGB(198, 32, 32)
end)

-- Confirm logic
confirmButton.MouseButton1Click:Connect(function()
    -- Hide options, show loading
    for _, child in frame:GetChildren() do
        child.Visible = false
    end

    local loadingLabel = Instance.new("TextLabel")
    loadingLabel.Text = "Setting up..."
    loadingLabel.Size = UDim2.new(1, 0, 1, 0)
    loadingLabel.Position = UDim2.new(0, 0, 0, 0)
    loadingLabel.BackgroundTransparency = 1
    loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingLabel.Font = Enum.Font.SourceSansBold
    loadingLabel.TextSize = 32
    loadingLabel.Parent = frame

    -- Simulate setup (replace with actual logic)
    task.wait(2)

    loadingLabel.Text = "Setup Complete!"

    -- Print/log the choices (replace with actual setup logic)
    print("Custom Characters:", customCharacters)
    print("Custom Character Scripts:", customCharacterScripts)

    -- Remove UI after a few seconds
    task.wait(2)
    screenGui:Destroy()
end)

-- Parent the UI to the player's PlayerGui
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

