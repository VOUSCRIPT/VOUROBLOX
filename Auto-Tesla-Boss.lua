local player = game.Players.LocalPlayer
local teleportEnabled = false

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "TeslaPromptGui"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.new(0, 0, 0)

local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0, 12)

local question = Instance.new("TextLabel", frame)
question.Text = "你想传送到特斯拉实验室吗？?"
question.Size = UDim2.new(1, 0, 0.5, 0)
question.BackgroundTransparency = 1
question.TextColor3 = Color3.new(1, 1, 1)
question.Font = Enum.Font.SourceSans
question.TextSize = 20

-- YES Button
local yesButton = Instance.new("TextButton", frame)
yesButton.Text = "Yes"
yesButton.Position = UDim2.new(0.1, 0, 0.6, 0)
yesButton.Size = UDim2.new(0.35, 0, 0.3, 0)
yesButton.BackgroundTransparency = 0.5
yesButton.BackgroundColor3 = Color3.new(0, 1, 0) 
yesButton.TextColor3 = Color3.new(0, 0, 0)
yesButton.Font = Enum.Font.SourceSansBold
yesButton.TextSize = 18

local yesCorner = Instance.new("UICorner", yesButton)
yesCorner.CornerRadius = UDim.new(0, 8)

local noButton = Instance.new("TextButton", frame)
noButton.Text = "No"
noButton.Position = UDim2.new(0.55, 0, 0.6, 0)
noButton.Size = UDim2.new(0.35, 0, 0.3, 0)
noButton.BackgroundTransparency = 0.5
noButton.BackgroundColor3 = Color3.new(1, 0, 0)
noButton.TextColor3 = Color3.new(0, 0, 0)
noButton.Font = Enum.Font.SourceSansBold
noButton.TextSize = 18

-- Bo góc cho nút No
local noCorner = Instance.new("UICorner", noButton)
noCorner.CornerRadius = UDim.new(0, 8)

-- Hàm gỡ GUI
local function removeGUI()
    screenGui:Destroy()
end

-- Xử lý nút Yes
yesButton.MouseButton1Click:Connect(function()
    teleportEnabled = true
    removeGUI()

    -- Teleport
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/bruh/refs/heads/main/teleport-to-tesla.lua"))()

    task.delay(math.random(5, 6), function()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local runService = game:GetService("RunService")

        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end

        local function enableNoClip()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end

        local function disableNoClip()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end

        local noclipConnection = runService.Stepped:Connect(enableNoClip)

        loadstring(game:HttpGet("https://raw.githubusercontent.com/VOUSCRIPT/VOUROBLOX/refs/heads/main/%E4%BC%A0%E9%80%81.lua"))()

        task.delay(60, function()
            noclipConnection:Disconnect()
            disableNoClip()
        end)
    end)
end)

-- Xử lý nút No
noButton.MouseButton1Click:Connect(function()
    removeGUI()

    task.delay(math.random(5, 6), function()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local runService = game:GetService("RunService")

        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end

        local function enableNoClip()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end

        local function disableNoClip()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end

        local noclipConnection = runService.Stepped:Connect(enableNoClip)

        loadstring(game:HttpGet("https://raw.githubusercontent.com/VOUSCRIPT/VOUROBLOX/refs/heads/main/Auto-collect-gun.lua"))()

        task.delay(60, function()
            noclipConnection:Disconnect()
            disableNoClip()
        end)
    end)
end)