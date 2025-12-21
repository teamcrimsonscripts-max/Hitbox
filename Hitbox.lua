local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local MIN_SIZE = 1
local MAX_SIZE = 100
local MIN_TRANS = 0
local MAX_TRANS = 1

local isEnabled = true
local currentSize = 10
local currentTrans = 0.5

local function applyHitbox(char)
    local root = char:WaitForChild("HumanoidRootPart", 5)
    if root then
        if isEnabled then
            root.Size = Vector3.new(currentSize, currentSize, currentSize)
            root.Transparency = currentTrans
            root.CanCollide = false
        else
            root.Size = Vector3.new(2, 2, 1)
            root.Transparency = 1
            root.CanCollide = false
        end
    end
end

local function setupPlayer(otherPlayer)
    if otherPlayer == player then return end
    if otherPlayer.Character then applyHitbox(otherPlayer.Character) end
    otherPlayer.CharacterAdded:Connect(applyHitbox)
end

for _, otherPlayer in ipairs(Players:GetPlayers()) do
    setupPlayer(otherPlayer)
end
Players.PlayerAdded:Connect(setupPlayer)

local function reapplyToAll()
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            applyHitbox(otherPlayer.Character)
        end
    end
end

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HitboxExpanderGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 220)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Hitbox Expander by Kirus" -- Updated Title
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16 -- Slightly smaller to fit "by Kirus"
title.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
toggleBtn.Position = UDim2.new(0.05, 0, 0, 45)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggleBtn.Text = "ON"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextSize = 16
toggleBtn.AutoButtonColor = false
toggleBtn.Parent = frame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleBtn

toggleBtn.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    toggleBtn.BackgroundColor3 = isEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    toggleBtn.Text = isEnabled and "ON" or "OFF"
    reapplyToAll()
end)

local sizeLabel = Instance.new("TextLabel")
sizeLabel.Size = UDim2.new(0.9, 0, 0, 25)
sizeLabel.Position = UDim2.new(0.05, 0, 0, 85)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Text = "Hitbox Size: 10 studs"
sizeLabel.TextColor3 = Color3.new(1, 1, 1)
sizeLabel.Font = Enum.Font.Gotham
sizeLabel.TextSize = 14
sizeLabel.Parent = frame

local sizeSliderBg = Instance.new("Frame")
sizeSliderBg.Size = UDim2.new(0.9, 0, 0, 12)
sizeSliderBg.Position = UDim2.new(0.05, 0, 0, 115)
sizeSliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
sizeSliderBg.BorderSizePixel = 0
sizeSliderBg.Parent = frame

local sCorner = Instance.new("UICorner")
sCorner.CornerRadius = UDim.new(0, 6)
sCorner.Parent = sizeSliderBg

local sizeSliderFill = Instance.new("Frame")
sizeSliderFill.Size = UDim2.new(0.09, 0, 1, 0)
sizeSliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
sizeSliderFill.BorderSizePixel = 0
sizeSliderFill.Parent = sizeSliderBg

local fCorner = Instance.new("UICorner")
fCorner.CornerRadius = UDim.new(0, 6)
fCorner.Parent = sizeSliderFill

local sizeKnob = Instance.new("Frame")
sizeKnob.Size = UDim2.new(0, 20, 0, 20)
sizeKnob.Position = UDim2.new(0.09, -10, 0, -4)
sizeKnob.BackgroundColor3 = Color3.new(1, 1, 1)
sizeKnob.BorderSizePixel = 0
sizeKnob.ZIndex = 5
sizeKnob.Parent = sizeSliderBg

local kCorner = Instance.new("UICorner")
kCorner.CornerRadius = UDim.new(1, 0)
kCorner.Parent = sizeKnob

local transLabel = Instance.new("TextLabel")
transLabel.Size = UDim2.new(0.9, 0, 0, 25)
transLabel.Position = UDim2.new(0.05, 0, 0, 140)
transLabel.BackgroundTransparency = 1
transLabel.Text = "Transparency: 0.5"
transLabel.TextColor3 = Color3.new(1, 1, 1)
transLabel.Font = Enum.Font.Gotham
transLabel.TextSize = 14
transLabel.Parent = frame

local transSliderBg = Instance.new("Frame")
transSliderBg.Size = UDim2.new(0.9, 0, 0, 12)
transSliderBg.Position = UDim2.new(0.05, 0, 0, 170)
transSliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
transSliderBg.BorderSizePixel = 0
transSliderBg.Parent = frame

local tsCorner = Instance.new("UICorner")
tsCorner.CornerRadius = UDim.new(0, 6)
tsCorner.Parent = transSliderBg

local transSliderFill = Instance.new("Frame")
transSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
transSliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
transSliderFill.BorderSizePixel = 0
transSliderFill.Parent = transSliderBg

local tfCorner = Instance.new("UICorner")
tfCorner.CornerRadius = UDim.new(0, 6)
tfCorner.Parent = transSliderFill

local transKnob = Instance.new("Frame")
transKnob.Size = UDim2.new(0, 20, 0, 20)
transKnob.Position = UDim2.new(0.5, -10, 0, -4)
transKnob.BackgroundColor3 = Color3.new(1, 1, 1)
transKnob.BorderSizePixel = 0
transKnob.ZIndex = 5
transKnob.Parent = transSliderBg

local tkCorner = Instance.new("UICorner")
tkCorner.CornerRadius = UDim.new(1, 0)
tkCorner.Parent = transKnob

-- Dragging Functionality
local draggingFrame = false
local dragStart, startPos

local function canDrag(input)
    local guiObjects = playerGui:GetGuiObjectsAtPosition(input.Position.X, input.Position.Y)
    for _, obj in ipairs(guiObjects) do
        if obj == sizeKnob or obj == sizeSliderBg or obj == transKnob or obj == transSliderBg then
            return false
        end
    end
    return true
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if canDrag(input) then
            draggingFrame = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end
end)

frame.InputChanged:Connect(function(input)
    if draggingFrame and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingFrame = false
    end
end)

-- Slider Logic
local function updateSizeSlider(val)
    local pct = (val - MIN_SIZE) / (MAX_SIZE - MIN_SIZE)
    sizeSliderFill.Size = UDim2.new(pct, 0, 1, 0)
    sizeKnob.Position = UDim2.new(pct, -10, 0, -4)
    currentSize = val
    sizeLabel.Text = "Hitbox Size: " .. math.floor(val) .. " studs"
    reapplyToAll()
end

local sizeSliderDragging = false
sizeKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sizeSliderDragging = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sizeSliderDragging = false
        transSliderDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if sizeSliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local x = sizeSliderBg.AbsolutePosition.X
        local w = sizeSliderBg.AbsoluteSize.X
        local pct = math.clamp((input.Position.X - x) / w, 0, 1)
        updateSizeSlider(math.floor(MIN_SIZE + pct * (MAX_SIZE - MIN_SIZE)))
    end
end)

local function updateTransSlider(val)
    local pct = (val - MIN_TRANS) / (MAX_TRANS - MIN_TRANS)
    transSliderFill.Size = UDim2.new(pct, 0, 1, 0)
    transKnob.Position = UDim2.new(pct, -10, 0, -4)
    currentTrans = val
    transLabel.Text = "Transparency: " .. string.format("%.2f", val)
    reapplyToAll()
end

local transSliderDragging = false
transKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        transSliderDragging = true
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if transSliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local x = transSliderBg.AbsolutePosition.X
        local w = transSliderBg.AbsoluteSize.X
        local pct = math.clamp((input.Position.X - x) / w, 0, 1)
        updateTransSlider(MIN_TRANS + pct * (MAX_TRANS - MIN_TRANS))
    end
end)

-- Initial Run
updateSizeSlider(currentSize)
updateTransSlider(currentTrans)
reapplyToAll()
