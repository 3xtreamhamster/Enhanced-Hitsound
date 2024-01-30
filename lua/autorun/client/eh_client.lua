// Cvars
local hitSound_enabled = CreateClientConVar("EH_HitsoundEnable", "true", true, false, "Enhanced Hitsound - Enable", 0.0, 1.0)
local killSound_enabled = CreateClientConVar("EH_KillsoundEnable", "true", true, false, "Enhanced Killsound - Enable", 0.0, 1.0)
local hitSound_volume = CreateClientConVar("EH_HitsoundVolume", 0.5, true, false, "Enhanced Hitsound - Kill sound volume", 0.0, 1.0)
local killSound_volume = CreateClientConVar("EH_KillsoundVolume", 0.5, true, false, "Enhanced Hitsound - Hit sound volume", 0.0, 1.0)

// Functions

// Play hit sounds
net.Receive("EH_PlayHitsound", function(len, ply)
    local enabled = cvars.Bool("EH_HitsoundEnable")
    if (enabled) then
        local localPlayer = LocalPlayer();
        if (IsValid(localPlayer) and localPlayer:Alive()) then // Play hit sound when attacker is local player and is alive
            local hitSounds = 
            {
                "sof/killingeffectsounds/hitknifebody/hit_knife_body_1.wav",
                "sof/killingeffectsounds/hitknifebody/hit_knife_body_2.wav",
                "sof/killingeffectsounds/critical/criticaldamage.wav",
                "sof/killingeffectsounds/hitgunbody/hit_gun_body_2.wav",
                "sof/killingeffectsounds/hitgunbody/hit_gun_body_3.wav"
            }
            local randSound = hitSounds[math.random(#hitSounds)]
            local playVolume = cvars.Number("EH_HitsoundVolume")
            localPlayer:EmitSound(randSound, 75, 100, playVolume)
        end      
    end
end)

// Play kill sounds
net.Receive("EH_PlayKillsound", function(len, ply)
    local enabled = cvars.Bool("EH_KillsoundEnable")
    if (enabled) then
        local localPlayer = LocalPlayer();
        if (IsValid(localPlayer) and localPlayer:Alive()) then // Play kill sound when attacker is local player and is alive
            local killSounds = 
            {
                "sof/deathsound1.wav",
                "sof/deathsound2.wav",
                "sof/headshot1.wav"
            }
            local randSound = killSounds[math.random(#killSounds)]
            local playVolume = cvars.Number("EH_KillsoundVolume")
            localPlayer:EmitSound(randSound, 75, 100, playVolume)
        end      
    end
end)

// Spawnmenu Options
hook.Add("AddToolMenuCategories", "EH_CustomMenuCategory", function()
    spawnmenu.AddToolCategory("Options", "Enhanced Hitsound", "#Enhanced Hitsound")
end )

hook.Add("PopulateToolMenu", "EH_CustomMenuSettings", function()
    spawnmenu.AddToolMenuOption("Options",  "Enhanced Hitsound", "EH_Custom_Menu", "#Setting", "", "", function(panel)
        panel:ClearControls()
        panel:CheckBox("Enable Hit Sound", "EH_HitsoundEnable")
        panel:CheckBox("Enable Kill Sound", "EH_KillsoundEnable")
        panel:NumSlider("Hit Sound Volume", "EH_HitsoundVolume", 0.0, 1.0)
        panel:NumSlider("Kill Sound Volume", "EH_KillsoundVolume", 0.0, 1.0)
    end )
end)

cvars.AddChangeCallback("EH_HitsoundEnable", function(cvarName, oldValue, newValue)
    hitSound_enabled = tobool(newValue)
end, "EH_HitsoundEnableCallback")

cvars.AddChangeCallback("EH_KillsoundEnable", function(cvarName, oldValue, newValue)
    killSound_enabled = tobool(newValue)
end, "EH_KillsoundCallback")

cvars.AddChangeCallback("EH_HitsoundVolume", function(cvarName, oldValue, newValue)
    hitSound_volume = tonumber(newValue)
end, "EH_HitSoundVolumeCallback")

cvars.AddChangeCallback("EH_KillsoundVolume", function(cvarName, oldValue, newValue)
    killSound_volume = tonumber(newValue)
end, "EH_HitSoundVolumeCallback")