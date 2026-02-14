local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Uma Racing | ENGINE HIJACK V23",
   LoadingTitle = "Menembus Proteksi Engine...",
   LoadingSubtitle = "V23 - Metatable Overdrive",
   ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Main Settings", 4483362458)

_G.CustomSpeed = 100 -- Angka speed saat sprint
_G.InfStam = true

-- 1. HARD-LOCK STAMINA (Metode Baru: NewIndex Hook)
-- Metode ini akan memblokir SEMUA upaya game untuk menurunkan stamina
local mt = getrawmetatable(game)
local oldNewIndex = mt.__newindex
setreadonly(mt, false)

mt.__newindex = newcclosure(function(t, k, v)
    if _G.InfStam and (k == "Stamina" or k == "Energy") then
        return oldNewIndex(t, k, 100) -- Apapun yang terjadi, paksa tetap 100
    end
    return oldNewIndex(t, k, v)
end)
setreadonly(mt, true)

Tab:CreateToggle({
   Name = "Infinite Stamina (Anti-Reset)",
   CurrentValue = true,
   Flag = "StamToggle",
   Callback = function(Value)
       _G.InfStam = Value
   end,
})

-- 2. SPRINT-ONLY SPEED BOOST
Tab:CreateSlider({
   Name = "Kecepatan Saat Sprint",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 100,
   Flag = "SpeedSlider", 
   Callback = function(Value)
       _G.CustomSpeed = Value
   end,
})

-- LOGIKA: Memantau status sprint secara mendalam
game:GetService("RunService").RenderStepped:Connect(function()
    local p = game.Players.LocalPlayer
    local char = p.Character
    local hum = char and char:FindFirstChild("Humanoid")
    
    if hum then
        -- Cek apakah game sedang mengaktifkan mode lari (biasanya speed > 20)
        -- ATAU mengecek animasi lari
        local isGameSprinting = false
        for _, track in pairs(hum:GetPlayingAnimationTracks()) do
            if track.Name:lower():find("run") or track.Name:lower():find("sprint") then
                isGameSprinting = true
                break
            end
        end

        if isGameSprinting and hum.MoveDirection.Magnitude > 0 then
            -- PAKSA SPEED TINGGI HANYA SAAT SPRINT
            hum.WalkSpeed = _G.CustomSpeed
            -- PAKSA STAMINA LAGI VIA ATTRIBUTE (Double Lock)
            char:SetAttribute("Stamina", 100)
        else
            -- JALAN BIASA
            if hum.WalkSpeed > 50 then -- Jika speed kegedean gara-gara cheat, balikin ke normal
                hum.WalkSpeed = 16
            end
        end
    end
end)

-- 3. FITUR PELENGKAP (Sesuai Permintaan)
Tab:CreateToggle({
   Name = "Anti Hit Wall",
   CurrentValue = false,
   Callback = function(Value)
       _G.AntiHit = Value
       game:GetService("RunService").Stepped:Connect(function()
           if _G.AntiHit and game.Players.LocalPlayer.Character then
               for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                   if v:IsA("BasePart") then v.CanCollide = false end
               end
           end
       end)
   end,
})

Tab:CreateButton({
   Name = "ESP & Instant Camera",
   Callback = function()
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character then
               local h = Instance.new("Highlight", v.Character)
               h.FillColor = Color3.fromRGB(255, 0, 0)
           end
       end
       workspace.CurrentCamera.FieldOfView = 120
   end,
})

Rayfield:Notify({
   Title = "V23 Injected!",
   Content = "Stamina dikunci via Metatable. Speed hanya aktif saat sprint!",
   Duration = 5,
})
