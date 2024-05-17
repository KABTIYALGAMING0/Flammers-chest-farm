-- Create the ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlammersScriptsChestFarm"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

-- Create the Title Label with RGB effect
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Title.Text = "FLAMMER'S SCRIPTS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Frame

-- Function to animate RGB effect on title
local function animateRGB(textLabel)
    local counter = 0
    local colors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 127, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(75, 0, 130),
        Color3.fromRGB(148, 0, 211)
    }
    
    while true do
        counter = (counter % #colors) + 1
        textLabel.TextColor3 = colors[counter]
        wait(0.2)
    end
end

-- Start RGB animation
spawn(function()
    animateRGB(Title)
end)

-- Create the Toggle Button for chest farming
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 280, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -140, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "Toggle Chest Farm (ON)"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextScaled = true
ToggleButton.Parent = Frame

-- Create the Auto Server Hop Label
local ServerHopLabel = Instance.new("TextLabel")
ServerHopLabel.Size = UDim2.new(1, 0, 0, 20)
ServerHopLabel.Position = UDim2.new(0, 0, 0, 130)
ServerHopLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ServerHopLabel.Text = "Auto Server Hop"
ServerHopLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerHopLabel.Font = Enum.Font.SourceSans
ServerHopLabel.TextScaled = true
ServerHopLabel.Parent = Frame

-- Create the Mode Label
local ModeLabel = Instance.new("TextLabel")
ModeLabel.Size = UDim2.new(1, 0, 0, 20)
ModeLabel.Position = UDim2.new(0, 0, 0, 150)
ModeLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ModeLabel.Text = "Mode: Private & Fast"
ModeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ModeLabel.Font = Enum.Font.SourceSans
ModeLabel.TextScaled = true
ModeLabel.Parent = Frame

-- Variables to control the script
local isFarming = true
local player = game.Players.LocalPlayer
local chests = game.Workspace:WaitForChild("Chests")

-- Function to find the closest chest
local function findClosestChest()
    local closestChest = nil
    local shortestDistance = math.huge

    for _, chest in pairs(chests:GetChildren()) do
        if chest:IsA("Model") then
            local distance = (player.Character.HumanoidRootPart.Position - chest.PrimaryPart.Position).magnitude
            if distance < shortestDistance then
                closestChest = chest
                shortestDistance = distance
            end
        end
    end

    return closestChest
end

-- Function to move the player to the chest position
local function moveToPosition(position)
    player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    repeat wait() until (player.Character.HumanoidRootPart.Position - position).magnitude < 3
end

-- Function to collect the chest
local function collectChest(chest)
    if chest and chest.PrimaryPart then
        moveToPosition(chest.PrimaryPart.Position)
        fireproximityprompt(chest.PrimaryPart.ProximityPrompt)
    end
end

-- Function to start farming
local function startFarming()
    while isFarming do
        local closestChest = findClosestChest()
        if closestChest then
            collectChest(closestChest)
        end
        wait(1) -- Delay between each chest collection to avoid rapid triggering
    end
end

-- Function to automatically select private mode and fast mode
local function autoSelectMode()
    -- Assuming there are UI buttons for private mode and fast mode
    -- This section will need to be customized based on the actual game UI structure
    local privateModeButton = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild("PrivateModeButton")
    local fastModeButton = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild("FastModeButton")

    if privateModeButton then
        privateModeButton:Activate()
    end

    if fastModeButton then
        fastModeButton:Activate()
    end
end

-- Function to handle server hop (you will need to customize the server hopping logic)
local function serverHop()
    -- Placeholder for server hop logic
    -- This typically involves finding a new server and teleporting the player
    -- Here you would add your own server hop implementation
end

-- Toggle Button Logic
ToggleButton.MouseButton1Click:Connect(function()
    isFarming = not isFarming
    if isFarming then
        ToggleButton.Text = "Toggle Chest Farm (ON)"
        startFarming()
    else
        ToggleButton.Text = "Toggle Chest Farm (OFF)"
    end
end)

-- Automatically select private and fast mode on game start
autoSelectMode()

-- Auto server hop logic (example to be triggered as needed)
serverHop()
