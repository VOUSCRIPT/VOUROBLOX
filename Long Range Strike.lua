local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local DamageRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CarbonEngine"):WaitForChild("Damage")

getgenv().Fausto = true

local ATTACK_COOLDOWN = 0.2

local function IsEnemy(player)
    return LocalPlayer.Team ~= player.Team
end

while task.wait(ATTACK_COOLDOWN) do
    if not getgenv().Fausto then break end
    
    local myCharacter = LocalPlayer.Character
    if not myCharacter then continue end
    
    local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
    if not myRoot then continue end

    for _, target in ipairs(Players:GetPlayers()) do
        if target == LocalPlayer then continue end
        
        if not IsEnemy(target) then continue end
        
        local targetChar = target.Character
        if not targetChar then continue end
        
        local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
        local targetHead = targetChar:FindFirstChild("Head")
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        
        if not targetHum or not targetHead or not targetRoot then continue end
        if targetHum.Health <= 0 then continue end

        local args = {
            [1] = targetHum,
            [2] = "Head",
            [3] = targetHead.Position + Vector3.new(0, 0.5, 0),
            [4] = (targetHead.Position - myRoot.Position).Unit,
            [5] = targetHead,
           
        }

        pcall(function()
            DamageRemote:FireServer(unpack(args))
        end)
    end
end
