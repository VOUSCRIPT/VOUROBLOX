if "霖溺-速度越狱" == LinniHubScript then
getgenv().linni = true

spawn(function()
    while getgenv().linni do
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Chechpoint_Texts.Start.CFrame
        wait(0.1)
        for i,v in pairs(workspace.Mainbuild.Levels.Finish.FinishBeams:GetChildren()) do
            if v:IsA("BasePart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                wait(0.05)
            end
        end
        wait(0.5)
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "霖溺脚本提示"; Text ="如果刷钱停止了请你重生,就可以正常使用了"; Duration = 2; })wait("999999999")
wait(0.1)
else
setclipboard("霖溺QQ新主群：http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=viOjjgj19-TUiZlamhpxb6uvWwVNGoB7&authKey=ACDi9sCtIis%2F4P%2BtirP046uWaJ54%2F149eBnUvaAsMu%2BWZwSFoEQrzZC9UDGFwmp%2F&noverify=0&group_code=744830231")
game.Players.LocalPlayer:Kick("你没复制全，中文也是的❌")
end