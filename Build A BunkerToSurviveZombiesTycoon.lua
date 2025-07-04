if "霖溺-建造一个堡垒已生成僵尸大亨" == LinniHubScript then

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
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Humanoid = Char:WaitForChild("Humanoid")
local HRP = Char:WaitForChild("HumanoidRootPart")
local ZombiesFolder = Workspace:WaitForChild("Zombies")

local function rebind()
    Char = LP.Character or LP.CharacterAdded:Wait()
    Humanoid = Char:WaitForChild("Humanoid")
    HRP = Char:WaitForChild("HumanoidRootPart")
end

LP.CharacterAdded:Connect(function()
    task.wait(1)
    rebind()
end)

local function getGun()
    return (Char:FindFirstChild("1911") or Char:FindFirstChildWhichIsA("Tool"))
end

local State = {
    AutoKill = false,
    OneHit = true,
    ESP = false,
    God = false,
    Noclip = false,
    InfJump = false,
    WalkOnAir = false,
    InfZombies = false,
    FreezeZombies = false,
    TPZombiesFront = false,
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteAmmo = false,
    SpawnMoreZombies = false,
    Money = 0,
    Kills = 0,
    AimBot = false,
    ESPDrops = false
}

local Window = WindUI:CreateWindow({
    Title = gradient("僵尸生存辅助", Color3.fromHex("#001e80"), Color3.fromHex("#16f2d9")), 
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
    CombatTab = Window:Tab({ Title = gradient("战斗功能", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "sword" }),
    PlayerTab = Window:Tab({ Title = gradient("玩家功能", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "user" }),
    MoneyTab = Window:Tab({ Title = gradient("金钱功能", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "dollar-sign" }),
    KillsTab = Window:Tab({ Title = gradient("击杀功能", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "kill-sign" }),
}

Tabs.CombatTab:Section({Title = "主要战斗设置", Position = "left"})
Tabs.CombatTab:Toggle({
    Title = "自动击杀",
    Callback = function(state) State.AutoKill = state end
})
Tabs.CombatTab:Toggle({
    Title = "一击必杀",
    Callback = function(state) State.OneHit = state end
})
Tabs.CombatTab:Toggle({
    Title = "无限僵尸",
    Callback = function(state) State.InfZombies = state end
})
Tabs.CombatTab:Toggle({
    Title = "无限弹药",
    Callback = function(state) State.InfiniteAmmo = state end
})
Tabs.CombatTab:Toggle({
    Title = "生成更多僵尸",
    Callback = function(state) State.SpawnMoreZombies = state end
})

Tabs.CombatTab:Section({Title = "僵尸控制", Position = "right"})
Tabs.CombatTab:Toggle({
    Title = "冻结僵尸",
    Callback = function(state) State.FreezeZombies = state end
})
Tabs.CombatTab:Toggle({
    Title = "传送僵尸到面前",
    Callback = function(state) State.TPZombiesFront = state end
})
Tabs.CombatTab:Toggle({
    Title = "僵尸ESP",
    Callback = function(state) State.ESP = state end
})
Tabs.CombatTab:Toggle({
    Title = "头部自瞄",
    Callback = function(state) State.AimBot = state end
})
Tabs.CombatTab:Toggle({
    Title = "掉落物ESP(带距离)",
    Callback = function(state) State.ESPDrops = state end
})
Tabs.CombatTab:Button({
    Title = "传送到空投",
    Callback = function()
        local closest, dist = nil, math.huge
        for _, d in pairs(Workspace.AirdropSystem.Drops:GetChildren()) do
            if d:IsA("Model") and d:FindFirstChildWhichIsA("BasePart") then
                local part = d:FindFirstChildWhichIsA("BasePart")
                local d = (HRP.Position - part.Position).Magnitude
                if d < dist then
                    closest, dist = part, d
                end
            end
        end
        if closest and HRP then
            HRP.CFrame = CFrame.new(closest.Position + Vector3.new(0, 3, 0))
        end
    end
})

Tabs.PlayerTab:Section({Title = "移动设置", Position = "left"})
Tabs.PlayerTab:Slider({
    Title = "移动速度",
    Value = {Min = 16, Max = 150, Default = 16},
    Callback = function(value) State.WalkSpeed = value end
})
Tabs.PlayerTab:Slider({
    Title = "跳跃力量",
    Value = {Min = 50, Max = 200, Default = 50},
    Callback = function(value) State.JumpPower = value end
})

Tabs.PlayerTab:Section({Title = "特殊能力", Position = "right"})
Tabs.PlayerTab:Toggle({
    Title = "穿墙模式",
    Callback = function(state) State.Noclip = state end
})
Tabs.PlayerTab:Toggle({
    Title = "无限跳跃",
    Callback = function(state) State.InfJump = state end
})
Tabs.PlayerTab:Toggle({
    Title = "空中行走",
    Callback = function(state) State.WalkOnAir = state end
})
Tabs.PlayerTab:Toggle({
    Title = "上帝模式",
    Callback = function(state) State.God = state end
})

Tabs.MoneyTab:Section({Title = "金钱编辑"})
Tabs.MoneyTab:Slider({
    Title = "编辑金钱",
    Value = {Min = 0, Max = 999999999999999, Default = 0},
    Callback = function(value)
        State.Money = value
        local stat = LP:FindFirstChild("leaderstats") and LP.leaderstats:FindFirstChild("Money")
        if stat then stat.Value = value end
    end
})

Tabs.KillsTab:Section({Title = "击杀编辑"})
Tabs.KillsTab:Slider({
    Title = "编辑击杀数",
    Value = {Min = 0, Max = 999999999999999, Default = 0},
    Callback = function(value)
        State.Kills = value
        local stat = LP:FindFirstChild("leaderstats") and LP.leaderstats:FindFirstChild("Kills")
        if stat then stat.Value = value end
    end
})

RunService.RenderStepped:Connect(function()
    if Humanoid and HRP then
        if Humanoid.WalkSpeed ~= State.WalkSpeed then
            Humanoid.WalkSpeed = State.WalkSpeed
        end
        if Humanoid.JumpPower ~= State.JumpPower then
            Humanoid.JumpPower = State.JumpPower
        end
    end
    if State.Noclip then
        for _, p in pairs(Char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
    if State.ESP then
        for _, z in pairs(ZombiesFolder:GetChildren()) do
            if z:IsA("Model") then
                for _, v in pairs(z:GetDescendants()) do
                    if v:IsA("BasePart") and not v:FindFirstChild("ESPBox") then
                        local box = Instance.new("BoxHandleAdornment")
                        box.Name = "ESPBox"
                        box.Size = v.Size
                        box.Adornee = v
                        box.AlwaysOnTop = true
                        box.ZIndex = 10
                        box.Transparency = 0.3
                        box.Color3 = Color3.new(1, 0, 0)
                        box.Parent = v
                    end
                end
            end
        end
    end
    if State.ESPDrops then
        for _, d in pairs(Workspace.AirdropSystem.Drops:GetChildren()) do
            if d:IsA("Model") and d:FindFirstChildWhichIsA("BasePart") then
                local part = d:FindFirstChildWhichIsA("BasePart")
                if part:IsA("BasePart") and not part:FindFirstChild("ESPBox") then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "ESPBox"
                    box.Size = part.Size
                    box.Adornee = part
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Transparency = 0.3
                    box.Color3 = Color3.fromRGB(0, 255, 255)
                    box.Parent = part
                end
                local distance = math.floor((HRP.Position - part.Position).Magnitude)
                if not part:FindFirstChild("Distance") then
                    local b = Instance.new("BillboardGui", part)
                    b.Name = "Distance"
                    b.Size = UDim2.new(0, 100, 0, 40)
                    b.AlwaysOnTop = true
                    b.StudsOffset = Vector3.new(0, 2, 0)
                    local t = Instance.new("TextLabel", b)
                    t.Size = UDim2.new(1, 0, 1, 0)
                    t.BackgroundTransparency = 1
                    t.TextColor3 = Color3.new(1, 1, 1)
                    t.TextStrokeTransparency = 0
                    t.Text = distance .. " studs"
                else
                    part.Distance.TextLabel.Text = distance .. " studs"
                end
            end
        end
    end
    if State.AutoKill then
        for _, z in pairs(ZombiesFolder:GetChildren()) do
            if z:IsA("Model") then
                local part = z:FindFirstChild("Head") or z:FindFirstChildWhichIsA("BasePart")
                local gun = getGun()
                local fireEvent = gun and gun:FindFirstChild("Event")
                if part and fireEvent then
                    local dmg = State.OneHit and 9999 or 11
                    local cf = CFrame.lookAt(part.Position, part.Position + part.CFrame.LookVector)
                    fireEvent:FireServer(part, cf, dmg)
                end
            end
        end
    end
    if State.InfZombies then
        for _, z in pairs(ZombiesFolder:GetChildren()) do
            if z:IsA("Model") then
                local h = z:FindFirstChildWhichIsA("Humanoid")
                if h and h.Health <= 0 then h.Health = h.MaxHealth end
            end
        end
    end
    if State.FreezeZombies then
        for _, z in pairs(ZombiesFolder:GetChildren()) do
            if z:IsA("Model") then
                local root = z:FindFirstChild("HumanoidRootPart") or z:FindFirstChildWhichIsA("BasePart")
                if root then root.Anchored = true end
            end
        end
    end
    if State.TPZombiesFront then
        for _, z in pairs(ZombiesFolder:GetChildren()) do
            if z:IsA("Model") then
                local root = z:FindFirstChild("HumanoidRootPart") or z:FindFirstChildWhichIsA("BasePart")
                if root and HRP then
                    root.Anchored = true
                    root.CFrame = HRP.CFrame * CFrame.new(0, 0, -5)
                end
            end
        end
    end
    if State.InfiniteAmmo then
        local gun = getGun()
        if gun then
            local hud = gun:FindFirstChild("GunHud")
            if hud and hud:FindFirstChild("Ammo") then
                hud.Ammo.Mag.Text = "∞"
            end
        end
    end
    if State.SpawnMoreZombies then
        local baseZombies = {}
        for _, z in pairs(ZombiesFolder:GetChildren()) do
            if z:IsA("Model") then table.insert(baseZombies, z) end
        end
        for _, base in pairs(baseZombies) do
            if base:IsA("Model") and base.Parent == ZombiesFolder then
                for _ = 1, 3 do
                    local newZ = base:Clone()
                    newZ.Parent = ZombiesFolder
                    local root = newZ:FindFirstChild("HumanoidRootPart") or newZ:FindFirstChildWhichIsA("BasePart")
                    if root then
                        local offset = Vector3.new(math.random(-30,30), 0, math.random(-30,30))
                        root.CFrame = HRP.CFrame * CFrame.new(offset)
                        root.Anchored = false
                    end
                end
            end
        end
    end
    if State.AimBot then
        local closest, dist = nil, math.huge
        for _, z in pairs(ZombiesFolder:GetChildren()) do
            if z:IsA("Model") then
                local head = z:FindFirstChild("Head")
                if head then
                    local screenPos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(head.Position)
                    local mousePos = UserInputService:GetMouseLocation()
                    local d = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                    if d < dist and onScreen then
                        closest, dist = head, d
                    end
                end
            end
        end
        if closest then
            Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, closest.Position)
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.InfJump and HRP then
        HRP.Velocity = Vector3.new(0, 70, 0)
    end
end)

RunService.Stepped:Connect(function()
    if State.WalkOnAir and HRP then
        HRP.Velocity = Vector3.new(0, 5, 0)
    end
end)

Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
    if State.God and Humanoid.Health < Humanoid.MaxHealth then
        Humanoid.Health = Humanoid.MaxHealth
    end
end)

WindUI:Notify({
    Title = gradient("脚本加载成功", Color3.fromHex("#eb1010"), Color3.fromHex("#1023eb")),
    Content = "霖溺欢迎你使用",
    Icon = "check-circle",
    Duration = 3,
})

wait(0.1)
else
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
game.Players.LocalPlayer:Kick("你没复制全，中文也是的❌")
end