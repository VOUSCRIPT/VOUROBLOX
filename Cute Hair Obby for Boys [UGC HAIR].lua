if "霖溺-男孩可爱发型奥此" == LinniHubScript then

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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LP = Players.LocalPlayer
local HRP, Humanoid

local function refreshCharacter()
    local char = LP.Character or LP.CharacterAdded:Wait()
    HRP = char:WaitForChild("HumanoidRootPart")
    Humanoid = char:WaitForChild("Humanoid")
end

refreshCharacter()
LP.CharacterAdded:Connect(refreshCharacter)

local detectGlass = false
local infJump = false
local selectedPlayer = nil
local autoLastTP = false

local Window = WindUI:CreateWindow({
    Title = gradient("可爱头发跑酷", Color3.fromHex("#001e80"), Color3.fromHex("#16f2d9")), 
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
    GlassTab = Window:Tab({ Title = gradient("玻璃检测", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "search" }),
    MoveTab = Window:Tab({ Title = gradient("移动功能", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "move" }),
    TPTab = Window:Tab({ Title = gradient("传送功能", Color3.fromHex("#ffffff"), Color3.fromHex("#636363")), Icon = "user" }),
}

Tabs.GlassTab:Section({Title = "玻璃检测设置"})
Tabs.GlassTab:Toggle({
    Title = "高亮安全/危险玻璃",
    Callback = function(state)
        detectGlass = state
    end
})

Tabs.MoveTab:Section({Title = "移动设置"})
Tabs.MoveTab:Slider({
    Title = "速度",
    Value = {Min = 16, Max = 200, Default = 16},
    Callback = function(value)
        if Humanoid then Humanoid.WalkSpeed = value end
    end
})
Tabs.MoveTab:Slider({
    Title = "跳跃",
    Value = {Min = 50, Max = 200, Default = 50},
    Callback = function(value)
        if Humanoid then Humanoid.JumpPower = value end
    end
})
Tabs.MoveTab:Toggle({
    Title = "无限跳跃",
    Callback = function(state)
        infJump = state
    end
})

Tabs.TPTab:Section({Title = "玩家传送"})
local playerList = {}
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP then table.insert(playerList, plr.Name) end
end
Tabs.TPTab:Dropdown({
    Title = "选择玩家",
    Values = playerList,
    Callback = function(selected)
        selectedPlayer = selected
    end
})
Tabs.TPTab:Button({
    Title = "传送到玩家",
    Callback = function()
        local target = Players:FindFirstChild(selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            HRP.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
})
Tabs.TPTab:Toggle({
    Title = "自动传送到最后位置",
    Callback = function(state)
        autoLastTP = state
    end
})

UIS.JumpRequest:Connect(function()
    if infJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if detectGlass then
            for _, model in ipairs(workspace:GetDescendants()) do
                if model:IsA("BasePart") and model.Name:lower():find("glass") then
                    local sb = model:FindFirstChildOfClass("SelectionBox")
                    if not sb then
                        sb = Instance.new("SelectionBox", model)
                        sb.Adornee = model
                        sb.Parent = model
                    end
                    sb.Color3 = model:FindFirstChild("TouchInterest") and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
                end
            end
        end

        if autoLastTP and workspace:FindFirstChild("Folder") and workspace.Folder:FindFirstChild("Part") then
            HRP.CFrame = workspace.Folder.Part.CFrame + Vector3.new(0, 3, 0)
        end
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