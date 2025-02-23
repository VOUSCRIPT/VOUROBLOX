if "By LN" == LNScript and "鱼的训练" == Roblox and "FIX" == LNTeam then
--霖溺鱼的训练 开源 上传那些缝合赶紧抄
--[FIX]
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")

local success, library = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/KingScriptAE/No-sirve-nada./main/%E9%9C%96%E6%BA%BA%E8%84%9A%E6%9C%ACUI.lua"))()
    end)

    if not success then
        warn("UI库加载失败")
        return
    end
local window = library:new("霖溺┋鱼的训练")
    local lin = window:Tab("主页", '16060333448')
    local linni = lin:section("信息", true)
    linni:Label("挂机专属！")
    linni:Label("制作者霖溺")
    linni:Label("完全免费！")
linni:Button("点击复制群聊", function()
        setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
    end)
local lin = window:Tab("基础功能", '16060333448')
    local linni = lin:section("设置", true)
linni:Button("关闭彩蛋动画", function()
        if not _G.Hooked then
            local success, err = pcall(function()
                hookfunction(require(game:GetService("ReplicatedStorage").Modules.Client.Hatch).HatchResult, function(...)
                    return
                end)
            end)
            if not success then
                warn("关闭彩蛋动画失败: " .. err)
            else
                _G.Hooked = true
            end
        end
    end)
linni:Button("免费黄金保险丝", function()
        for _, pet in workspace.WorldMain.Pets:GetChildren() do
            if pet:GetAttribute("UserId") ~= game.Players.LocalPlayer.UserId then continue end
            local success, err = pcall(function()
                v1.Events.PetEvent:Fire(true, "Fuse", {
                    Data = { pet.Name, pet.Name, pet.Name, pet.Name, pet.Name, pet.Name },
                    Type = "Golden",
                })
            end)
            if not success then
                warn("黄金保险丝失败: " .. err)
            end
        end
    end)
linni:Button("免费彩虹保险丝", function()
        for _, pet in workspace.WorldMain.Pets:GetChildren() do
            if pet:GetAttribute("UserId") ~= game.Players.LocalPlayer.UserId then continue end
            local success, err = pcall(function()
                v1.Events.PetEvent:Fire(true, "Fuse", {
                    Data = { pet.Name, pet.Name, pet.Name, pet.Name, pet.Name, pet.Name },
                    Type = "Rainbow",
                })
            end)
            if not success then
                warn("彩虹保险丝失败: " .. err)
            end
        end
    end)
local lin = window:Tab("自动功能", '16060333448')
local linni = lin:section("设置", true)
 linni:Label("确保有足够的奖杯数量，再开自动打开宠物蛋")
 local v1 = require(game.ReplicatedStorage.Modules.Common)
    local l_UIHandle_0 = require(game:GetService("ReplicatedStorage").Modules.Client.Hatch.UIHandle)
    local path = game:GetService("Players").LocalPlayer.PlayerGui.HatchGuis
    local Hatch = require(game:GetService("ReplicatedStorage").Modules.Client.Hatch)  
local Cache = {
        Egg = "Draw001",--变量自定义
        Amount = "1",
        AutoEggOpen = false,
        AutoRace = false,
        Train = 1,
        AutoTrain = false,
    }
    
    local EggDropDown = {}
    for _, egg in game:GetService("ReplicatedStorage").Assets.Eggs:GetChildren() do
        table.insert(EggDropDown, egg.Name)
    end
    
    
linni:Dropdown("选择宠物蛋", "EggDropDown", EggDropDown, function(name)
        Cache.Egg = name
end)
linni:Dropdown("选择总额", "EggDropDown", {"1", "3"}, function(name)
        Cache.Amount = name
    end)
linni:Label("看背包")
    linni:Toggle("自动打开", "AutoEggOpen", false, function(bool)
        Cache.AutoEggOpen = bool
    end)
linni:Toggle("自动快速比赛", "AutoRace", false, function(bool)
        Cache.AutoRace = bool
    end)
local TrainDropDown = {}
    for _, train in workspace["\229\156\186\230\153\175\231\180\160\230\157\144"]["\232\174\173\231\187\131"]:GetChildren() do
        if not train:IsA("Model") then continue end
        table.insert(TrainDropDown, train.Name)
    end
linni:Label("确保你选择的是解锁了的")
linni:Label("萌新选择第一个就行了")
    local TrainDropDown = linni:Dropdown("选择培训", "TrainDropDown", TrainDropDown, function(name)
        Cache.Train = tonumber(name) or name
    end)
linni:Toggle("自动训练", "AutoTrain", false, function(bool)
        Cache.AutoTrain = bool
    end)

task.spawn(function()
        while task.wait() do
            if not Cache.AutoEggOpen then continue end
            local success, err = pcall(function()
                v1.Events.Hatch:Fire(true, "Hatch" .. Cache.Amount, Cache.Egg, l_UIHandle_0.GetDeletePets(game:GetService("Players").LocalPlayer.PlayerGui.HatchGuis[Cache.Egg]))
            end)
            if not success then
                warn("自动开蛋失败: " .. err)
            end
        end
    end)
task.spawn(function()
        while task.wait() do
            if not Cache.AutoRace then continue end
            for i = 1, 16 do
                local Number = i < 10 and "0" .. tostring(i) or tostring(i)
                local success, err = pcall(function()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Track["Stage" .. Number].Sign, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Track["Stage" .. Number].Sign, 1)
                end)
                if not success then
                    warn("自动比赛失败: " .. err)
                end
            end
        end
    end)

    task.spawn(function()
        while task.wait() do
            if not Cache.AutoTrain then continue end
            local success, err = pcall(function()
                for i = 1, 100 do
                    v1.Events.Train:Fire(true, "Power", Cache.Train)
                end
            end)
            if not success then
                warn("自动训练失败: " .. err)
            end
        end
    end)
    ------分割----------分割----
wait(1)
else
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
game.Players.LocalPlayer:Kick("煞笔你没进群吧❌")
end