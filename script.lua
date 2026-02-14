local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Ruphas Hub | Multi-Feature",
   LoadingTitle = "Menyiapkan Script...",
   LoadingSubtitle = "oleh RuphasMafahl531",
   ConfigurationSaving = {
      Enabled = false
   }
})

local Tab = Window:CreateTab("Fitur Utama", 4483362458)

-- FITUR 1: UNLIMITED STAMINA
Tab:CreateToggle({
   Name = "Unlimited Stamina",
   CurrentValue = false,
   Flag = "StaminaToggle",
   Callback = function(Value)
       _G.UnlimitedStamina = Value
       while _G.UnlimitedStamina do
           task.wait(0.1)
           local p = game.Players.LocalPlayer
           local c = p.Character
           if c then
               -- Mencoba berbagai nama variabel stamina yang umum
               if c:FindFirstChild("Stamina") then c.Stamina.Value = 100 end
               if p:FindFirstChild("Stamina") then p.Stamina.Value = 100 end
               c:SetAttribute("Stamina", 100)
               c:SetAttribute("Energy", 100)
           end
       end
   end,
})

-- FITUR 2: SPEED
Tab:CreateSlider({
   Name = "Atur Kecepatan (Speed)",
   Range = {16, 250},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- FITUR 3: JUMP
Tab:CreateSlider({
   Name = "Atur Lompatan (Jump)",
   Range = {50, 300},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Flag = "JumpSlider", 
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

-- FITUR 4: RESET
Tab:CreateButton({
   Name = "Reset Karakter (Kill)",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.Health = 0
   end,
})

Rayfield:Notify({
   Title = "Script Berhasil!",
   Content = "Selamat menggunakan, Ruphas.",
   Duration = 5,
})
