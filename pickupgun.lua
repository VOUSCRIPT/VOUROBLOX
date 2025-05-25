
if _G.AutoGunLoaded then return end
_G.AutoGunLoaded = true

local pickUpRemote = game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool
local runtimeItems = workspace:WaitForChild("RuntimeItems")
local autoCollectEnabled = false
local gunConnection

local gunTypes = {
    ["Revolver"] = true, ["Shotgun"] = true, ["Rifle"] = true, 
    ["Navy Revolver"] = true, ["Mauser C96"] = true, ["Bolt Action Rifle"] = true, 
    ["Electrocutioner"] = true, ["Sawed-Off Shotgun"] = true
}

local function collectGun(gun)
    if gun and gun:IsA("Model") and gunTypes[gun.Name] then
        pcall(function()
            pickUpRemote:FireServer(gun)
        end)
    end
end

local function collectGuns()
    for _, item in ipairs(runtimeItems:GetChildren()) do
        collectGun(item)
    end
end

local function startAutoCollect()
    if gunConnection then gunConnection:Disconnect() end
    gunConnection = runtimeItems.ChildAdded:Connect(function(child)
        if autoCollectEnabled then
            task.wait(0.1)
            collectGun(child)
        end
    end)
end

runtimeItems.ChildRemoved:Connect(function()
    if autoCollectEnabled then
        collectGuns()
    end
end)

_G.ToggleAutoPickupGun = function()
    autoCollectEnabled = not autoCollectEnabled

    if autoCollectEnabled then
        collectGuns()
        startAutoCollect()
    elseif gunConnection then
        gunConnection:Disconnect()
        gunConnection = nil
    end

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Pickup Gun",
        Text = "自动拾取枪支 [" .. (autoCollectEnabled and "ON" or "OFF") .. "]",
        Duration = 3
    })
end