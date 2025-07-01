if "霖溺-3008" == LinniHubScript then
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera


local ESP_COLOR = Color3.new(1, 0, 0)
local ESP_TRANSPARENCY = 0.7
local TEXT_COLOR = Color3.new(1, 1, 1)
local TEXT_SIZE = 20
local MAX_TEXT_SIZE = 50
local MIN_TEXT_SIZE = 10
local TEXT_OUTLINE = true


local espItems = {}


local function createESP(model)
    if not model or not model:IsA("Model") or espItems[model] then return end
    
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESPBox"
    box.Adornee = model
    box.AlwaysOnTop = true
    box.ZIndex = 1
    box.Size = model:GetExtentsSize()
    box.Color3 = ESP_COLOR
    box.Transparency = ESP_TRANSPARENCY
    box.Parent = model
    
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPTag"
    billboard.Adornee = model.PrimaryPart or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ESPLabel"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = model.Name
    textLabel.TextColor3 = TEXT_COLOR
    textLabel.TextSize = TEXT_SIZE
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = TEXT_OUTLINE and 0.5 or 1
    textLabel.Parent = billboard
    
    billboard.Parent = model
    
    
    espItems[model] = {
        Box = box,
        Billboard = billboard,
        TextLabel = textLabel
    }
end


local function updateESP()
    for model, esp in pairs(espItems) do
        if model.Parent then
            
            local character = LocalPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            if humanoidRootPart then
                local modelPosition = model:GetModelCFrame().Position
                local distance = (humanoidRootPart.Position - modelPosition).Magnitude
                
                
                local scaleFactor = math.clamp(1 / (distance / 50), 0.1, 2)
                local textSize = math.clamp(TEXT_SIZE * scaleFactor, MIN_TEXT_SIZE, MAX_TEXT_SIZE)
                
                esp.TextLabel.TextSize = textSize
                
                
                esp.Box.Size = model:GetExtentsSize()
            end
        else
            
            esp.Box:Destroy()
            esp.Billboard:Destroy()
            espItems[model] = nil
        end
    end
end


local function initESP()
    
    local itemsFolder = workspace:FindFirstChild("GameObjects")
    if itemsFolder then
        itemsFolder = itemsFolder:FindFirstChild("Physical")
        if itemsFolder then
            itemsFolder = itemsFolder:FindFirstChild("Items")
        end
    end
    
    if itemsFolder then
        for _, model in ipairs(itemsFolder:GetChildren()) do
            if model:IsA("Model") then
                createESP(model)
            end
        end
        
        
        itemsFolder.ChildAdded:Connect(function(child)
            if child:IsA("Model") then
                createESP(child)
            end
        end)
    else
        warn("找不到Workspace.GameObjects.Physical.Items文件夹")
    end
    
    
    RunService.Heartbeat:Connect(updateESP)
end


if LocalPlayer.Character then
    initESP()
else
    LocalPlayer.CharacterAdded:Connect(initESP)
end

wait(0.1)
else
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
game.Players.LocalPlayer:Kick("你没复制全，中文也是的❌")
end
