if "霖溺-在森林里偷99夜" == LinniHubScript then

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./refs/heads/main/main.lua"))()


function gradient(text, startColor, endColor)
    local result = ""
    local chars = {}
    
    for uchar in text:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        table.insert(chars, uchar)
    end
    
    local length = #chars
    
    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = startColor.R + (endColor.R - startColor.R) * t
        local g = startColor.G + (endColor.G - startColor.G) * t
        local b = startColor.B + (endColor.B - startColor.B) * t
        
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
            math.floor(r * 255), 
            math.floor(g * 255), 
            math.floor(b * 255), 
            chars[i])
    end
    
    return result
end

local Confirmed = false  

WindUI:Popup({
    Title = gradient("霖溺脚本中心", Color3.fromHex("#eb1010"), Color3.fromHex("#1023eb")),
    Icon = "info",
    Content = gradient("作者:霖溺", Color3.fromHex("#10eb3c"), Color3.fromHex("#67c97a")) .. gradient(" \n@霖溺团队制作", Color3.fromHex("#001e80"), Color3.fromHex("#16f2d9")),  
    Buttons = {  
        {
            Title = gradient("关闭脚本", Color3.fromHex("#e80909"), Color3.fromHex("#630404")),
            Callback = function() end,
            Variant = "Tertiary",
        },
        {
            Title = gradient("加载脚本", Color3.fromHex("#90f09e"), Color3.fromHex("#13ed34")),
            Callback = function() Confirmed = true end,
            Variant = "Secondary",
        }
    }
})

repeat task.wait() until Confirmed

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Humanoid = Char:WaitForChild("Humanoid")

local autoCollect, autoRebirth, infJump, noclip, lockToLegendary, laserToggle = false, false, false, false, false, false
local originalPos, storedLasers = nil, {}

local function refreshChar()
    Char = LP.Character or LP.CharacterAdded:Wait()
    Humanoid = Char:WaitForChild("Humanoid")
end

LP.CharacterAdded:Connect(function()
    task.wait(1)
    refreshChar()
end)

local Window = WindUI:CreateWindow({
    Title = gradient("在森林里偷99夜", Color3.fromHex("#001e80"), Color3.fromHex("#16f2d9")), 
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = gradient("@霖溺", Color3.fromHex("#1bf2b2"), Color3.fromHex("#1bcbf2")),
    Folder = "CloudHub",
    Size = UDim2.fromOffset(300, 270),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
     HideSearchBar = true,
    ScrollBarEnabled = true,
     Background = "rbxassetid://99599917888886",
})
 Window:SetBackgroundImage("rbxassetid://99599917888886")
 Window:SetBackgroundImageTransparency(0.9)
 
Window:EditOpenButton({
    Title = "打开霖溺脚本",
    Icon = "monitor",
    CornerRadius = UDim.new(2, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("1E213D"),
        Color3.fromHex("1F75FE")
    ),
    Draggable = true,
})
local Tabs = {
    MainTab = Window:Tab({ Title = gradient("主要功能", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "dollar-sign" }),
    MoveTab = Window:Tab({ Title = gradient("移动功能", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "move" }),
}

Tabs.MainTab:Section({Title = "自动化功能"})
Tabs.MainTab:Toggle({
    Title = "自动收集金钱(绿色)",
    Callback = function(state)
        autoCollect = state
    end
})
Tabs.MainTab:Toggle({
    Title = "自动转生",
    Callback = function(state)
        autoRebirth = state
    end
})
Tabs.MainTab:Toggle({
    Title = "传送到购买点",
    Callback = function(state)
        lockToLegendary = state
        if state then
            originalPos = LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character.HumanoidRootPart.Position
        else
            if originalPos then
                LP.Character:MoveTo(originalPos)
            end
        end
    end
})
Tabs.MainTab:Button({
    Title = "获取所有工具(不重复)",
    Callback = function()
        local tools = RS:FindFirstChild("Tools")
        if tools then
            for _, tool in pairs(tools:GetChildren()) do
                if tool:IsA("Tool") and not LP.Backpack:FindFirstChild(tool.Name) and not Char:FindFirstChild(tool.Name) then
                    tool:Clone().Parent = LP.Backpack
                end
            end
        end
    end
})
Tabs.MainTab:Toggle({
    Title = "自动移除激光(切换)",
    Callback = function(state)
        laserToggle = state
        local houses = workspace:FindFirstChild("GameFolder") and workspace.GameFolder:FindFirstChild("HouseFolder")
        if houses then
            for _, house in pairs(houses:GetChildren()) do
                for _, part in pairs(house:GetDescendants()) do
                    if part:IsA("BasePart") and part.Color == Color3.fromRGB(255, 0, 0) then
                        if state then
                            storedLasers[part] = part:Clone()
                            part:Destroy()
                        else
                            if storedLasers[part] then
                                storedLasers[part].Parent = house
                            end
                        end
                    end
                end
            end
        end
    end
})

Tabs.MoveTab:Section({Title = "速度与跳跃", Position = "left"})
local speedValue = 16
local jumpValue = 100
Tabs.MoveTab:Slider({
    Title = "速度",
    Value = {Min = 16, Max = 150, Default = 16},
    Callback = function(value)
        speedValue = value
        if Humanoid then Humanoid.WalkSpeed = value end
    end
})
Tabs.MoveTab:Slider({
    Title = "跳跃",
    Value = {Min = 50, Max = 300, Default = 100},
    Callback = function(value)
        jumpValue = value
        if Humanoid then Humanoid.JumpPower = value end
    end
})

Tabs.MoveTab:Section({Title = "其他功能", Position = "right"})
Tabs.MoveTab:Toggle({
    Title = "无限跳跃",
    Callback = function(state)
        infJump = state
    end
})
Tabs.MoveTab:Toggle({
    Title = "穿墙",
    Callback = function(state)
        noclip = state
    end
})

UIS.JumpRequest:Connect(function()
    if infJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Stepped:Connect(function()
    if noclip and Char then
        for _, v in pairs(Char:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.15)
        if not Char or not Humanoid then refreshChar() end

        if Humanoid then
            Humanoid.WalkSpeed = speedValue
            Humanoid.JumpPower = jumpValue
        end

        if autoCollect then
            local houses = workspace:FindFirstChild("GameFolder") and workspace.GameFolder:FindFirstChild("HouseFolder")
            if houses then
                for _, house in pairs(houses:GetChildren()) do
                    local display = house:FindFirstChild("Display")
                    if display then
                        for _, pad in pairs(display:GetChildren()) do
                            local part = pad:FindFirstChild("CollectPart")
                            local ui = part and part:FindFirstChild("UI")
                            local amountLabel = ui and ui:FindFirstChild("Frame") and ui.Frame:FindFirstChild("AmountText")
                            if part and amountLabel and part:IsA("BasePart") and part.Color == Color3.fromRGB(0, 255, 0) then
                                local text = amountLabel.Text
                                if text and text:match("%d") and not text:find("$0") then
                                    LP.Character:MoveTo(part.Position + Vector3.new(0, 3, 0))
                                    firetouchinterest(LP.Character.HumanoidRootPart, part, 0)
                                    firetouchinterest(LP.Character.HumanoidRootPart, part, 1)
                                    task.wait(0.15)
                                end
                            end
                        end
                    end
                end
            end
        end

        if autoRebirth and RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Rebirth") then
            RS.Remotes.Rebirth:FireServer()
        end

        if lockToLegendary then
            local charFolder = workspace:FindFirstChild("GameFolder") and workspace.GameFolder:FindFirstChild("CharacterFolder")
            if charFolder then
                for _, npc in pairs(charFolder:GetChildren()) do
                    if npc:FindFirstChild("Torso") then
                        LP.Character:MoveTo(npc.Torso.Position + Vector3.new(0, 3, 0))
                        break
                    end
                end
            end
        end
    end
end)

WindUI:Notify({
    Title = gradient("脚本加载成功", Color3.fromHex("#eb1010"), Color3.fromHex("#1023eb")),
    Content = "霖溺欢迎你使用,
    Icon = "check-circle",
    Duration = 3,
})

wait(0.1)
else
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
game.Players.LocalPlayer:Kick("你没复制全，中文也是的❌")
end