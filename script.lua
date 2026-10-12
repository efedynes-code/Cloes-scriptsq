-- Cloes Menu | MM2 & Muscle Legends | v6.1
-- By Cloes

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "CLOES MENU",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "By Cloes",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Cloes",
      FileName = "CloesMenu"
   },
   KeySystem = false
})

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

-- ============ MM2 TAB ============
local MM2Tab = Window:CreateTab("MM2", 4483362458)

MM2Tab:CreateSection("General")

MM2Tab:CreateButton({
   Name = "Coin Farm",
   Callback = function()
       task.spawn(function()
           while true do
               task.wait(0.5)
               for _, v in pairs(workspace:GetChildren()) do
                   if v:IsA("BasePart") and (v.Name == "Coin" or v.Name == "Cash" or v.Name == "Money") then
                       root.CFrame = v.CFrame
                       task.wait(0.1)
                   end
               end
           end
       end)
   end,
})

MM2Tab:CreateButton({
   Name = "Kill All (Murder Only)",
   Callback = function()
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
               if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                   v.Character.Humanoid.Health = 0
               end
           end
       end
   end,
})

MM2Tab:CreateToggle({
   Name = "Auto Shout Murder (Sheriff Only)",
   CurrentValue = false,
   Flag = "AutoShout",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(2)
                   local isSheriff = false
                   if player.Character then
                       if player.Character:FindFirstChild("Gun") or player.Character:FindFirstChild("Revolver") then
                           isSheriff = true
                       end
                   end
                   if not isSheriff and player.Backpack then
                       if player.Backpack:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Revolver") then
                           isSheriff = true
                       end
                   end
                   if isSheriff then
                       local murderName = "None"
                       for _, v in pairs(game.Players:GetPlayers()) do
                           if v ~= player and v.Character then
                               local hasKnife = false
                               if v.Character:FindFirstChild("Knife") then
                                   hasKnife = true
                               end
                               if v.Backpack and v.Backpack:FindFirstChild("Knife") then
                                   hasKnife = true
                               end
                               if hasKnife then
                                   murderName = v.Name
                               end
                           end
                       end
                       local chatEvent = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
                       if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
                           chatEvent.SayMessageRequest:FireServer("Murder: " .. murderName, "All")
                       else
                           game:GetService("ReplicatedStorage").SayMessageRequest:FireServer("Murder: " .. murderName, "All")
                       end
                   end
               end
           end)
       end
   end,
})

MM2Tab:CreateButton({
   Name = "Auto Throw (Murder Only)",
   Callback = function()
       task.spawn(function()
           while true do
               task.wait(0.5)
               local isMurder = false
               for _, v in pairs(player.Backpack:GetChildren()) do
                   if v.Name == "Knife" then
                       isMurder = true
                   end
               end
               if isMurder then
                   for _, v in pairs(game.Players:GetPlayers()) do
                       if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                           local args = {v.Character.HumanoidRootPart}
                           game:GetService("ReplicatedStorage").ThrowKnife:FireServer(unpack(args))
                       end
                   end
               end
           end
       end)
   end,
})

MM2Tab:CreateToggle({
   Name = "Wall Shots (Sheriff Only)",
   CurrentValue = false,
   Flag = "WallShots",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(0.1)
                   for _, v in pairs(game.Players:GetPlayers()) do
                       if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                           local args = {v.Character.HumanoidRootPart}
                           game:GetService("ReplicatedStorage").ShootGun:FireServer(unpack(args))
                       end
                   end
               end
           end)
       end
   end,
})

MM2Tab:CreateSection("Teleport")

MM2Tab:CreateButton({
   Name = "Teleport to Current Map",
   Callback = function()
       for _, v in pairs(workspace:GetChildren()) do
           if v:FindFirstChild("TeleportPart") then
               root.CFrame = v.TeleportPart.CFrame
               break
           end
       end
   end,
})

MM2Tab:CreateButton({
   Name = "Teleport to Lobby",
   Callback = function()
       for _, v in pairs(workspace:GetChildren()) do
           if v.Name:lower():find("lobby") then
               root.CFrame = v.CFrame + Vector3.new(0, 10, 0)
               break
           end
       end
   end,
})

-- ============ ESP TAB ============
local ESPTab = Window:CreateTab("ESP", 4483362458)

ESPTab:CreateSection("Player ESP")

ESPTab:CreateToggle({
   Name = "ESP (Name + Role)",
   CurrentValue = false,
   Flag = "ESP",
   Callback = function(Value)
       if Value then
           for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= player and v.Character then
                   local h = Instance.new("Highlight")
                   h.Parent = v.Character
                   if v.Backpack:FindFirstChild("Knife") then
                       h.FillColor = Color3.fromRGB(255, 0, 0)
                   elseif v.Backpack:FindFirstChild("Gun") then
                       h.FillColor = Color3.fromRGB(0, 0, 255)
                   else
                       h.FillColor = Color3.fromRGB(0, 255, 0)
                   end
                   h.OutlineColor = Color3.fromRGB(255, 255, 255)
                   
                   local billboard = Instance.new("BillboardGui")
                   billboard.Parent = v.Character
                   billboard.Size = UDim2.new(0, 200, 0, 50)
                   billboard.StudsOffset = Vector3.new(0, 3, 0)
                   billboard.AlwaysOnTop = true
                   
                   local text = Instance.new("TextLabel")
                   text.Parent = billboard
                   text.Size = UDim2.new(1, 0, 1, 0)
                   text.BackgroundTransparency = 1
                   text.TextColor3 = Color3.fromRGB(255, 255, 255)
                   text.TextStrokeTransparency = 0
                   text.TextScaled = true
                   if v.Backpack:FindFirstChild("Knife") then
                       text.Text = "MURDER"
                   elseif v.Backpack:FindFirstChild("Gun") then
                       text.Text = "SHERIFF"
                   else
                       text.Text = "INNOCENT"
                   end
               end
           end
       else
           for _, v in pairs(game.Players:GetPlayers()) do
               if v.Character then
                   if v.Character:FindFirstChildOfClass("Highlight") then
                       v.Character:FindFirstChildOfClass("Highlight"):Destroy()
                   end
                   if v.Character:FindFirstChildOfClass("BillboardGui") then
                       v.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                   end
               end
           end
       end
   end,
})

-- ============ MUSCLE LEGENDS TAB ============
local MLTab = Window:CreateTab("Muscle Legends", 4483362458)

MLTab:CreateSection("Auto")

MLTab:CreateToggle({
   Name = "Auto Dumbbell",
   CurrentValue = false,
   Flag = "AutoDambil",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(1)
                   local args = {true}
                   game:GetService("ReplicatedStorage").Events.Dambil:FireServer(unpack(args))
               end
           end)
       end
   end,
})

MLTab:CreateToggle({
   Name = "Auto Pushup",
   CurrentValue = false,
   Flag = "AutoSinav",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(1)
                   local args = {true}
                   game:GetService("ReplicatedStorage").Events.Sinav:FireServer(unpack(args))
               end
           end)
       end
   end,
})

MLTab:CreateToggle({
   Name = "Auto Situp",
   CurrentValue = false,
   Flag = "AutoMekik",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(1)
                   local args = {true}
                   game:GetService("ReplicatedStorage").Events.Mekik:FireServer(unpack(args))
               end
           end)
       end
   end,
})

MLTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               while Value do
                   task.wait(2)
                   game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
               end
           end)
       end
   end,
})

MLTab:CreateButton({
   Name = "Teleport to Safe Zone",
   Callback = function()
       root.CFrame = CFrame.new(0, 100, 0)
   end,
})

MLTab:CreateSection("Teleport")

local islands = {"Island1", "Island2", "Island3", "Island4", "Island5"}

for _, island in pairs(islands) do
   MLTab:CreateButton({
       Name = island,
       Callback = function()
           for _, v in pairs(workspace:GetChildren()) do
               if v.Name == island then
                   root.CFrame = v.CFrame + Vector3.new(0, 10, 0)
               end
           end
       end,
   })
end

-- ============ ANTI-CHEAT BYPASS TAB ============
local ACBypassTab = Window:CreateTab("Anti-Cheat Bypass", 4483362458)

ACBypassTab:CreateSection("Bypass")

ACBypassTab:CreateToggle({
   Name = "Enable Anti-Cheat Bypass",
   CurrentValue = false,
   Flag = "AntiCheatBypass",
   Callback = function(Value)
       if Value then
           local mt = getrawmetatable(game)
           local oldNamecall = mt.__namecall
           setreadonly(mt, false)
           mt.__namecall = newcclosure(function(self, ...)
               local method = getnamecallmethod()
               if method == "Kick" then
                   return nil
               end
               return oldNamecall(self, ...)
           end)
           setreadonly(mt, true)
           
           for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
               if v:IsA("RemoteEvent") and (v.Name:lower():find("kick") or v.Name:lower():find("ban") or v.Name:lower():find("cheat")) then
                   v:Destroy()
               end
           end
           
           if char and char:FindFirstChild("Humanoid") then
               char.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                   if char.Humanoid.Health <= 0 then
                       char.Humanoid.Health = 100
                   end
               end)
           end
           
           Rayfield:Notify({
               Title = "Bypass",
               Content = "Anti-Cheat Bypass enabled! By Cloes",
               Duration = 3,
           })
       end
   end,
})

ACBypassTab:CreateButton({
   Name = "Remove Kick Events",
   Callback = function()
       for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
           if v:IsA("RemoteEvent") and (v.Name:lower():find("kick") or v.Name:lower():find("ban")) then
               v:Destroy()
           end
       end
   end,
})

ACBypassTab:CreateButton({
   Name = "Block Anti-Cheat",
   Callback = function()
       local mt = getrawmetatable(game)
       local oldNamecall = mt.__namecall
       setreadonly(mt, false)
       mt.__namecall = newcclosure(function(self, ...)
           local method = getnamecallmethod()
           if method == "Kick" or method == "Ban" then
               return nil
           end
           return oldNamecall(self, ...)
       end)
       setreadonly(mt, true)
   end,
})

-- ============ ABOUT TAB ============
Window:CreateTab("About", 4483362458):CreateParagraph({
   Title = "CLOES MENU",
   Content = "This script was made by Cloes. By Cloes. Have fun."
})

Rayfield:Notify({
   Title = "CLOES MENU",
   Content = "Menu loaded! By Cloes",
   Duration = 5,
   Image = 4483362458,
})

print("Cloes Menu loaded. By Cloes.")
