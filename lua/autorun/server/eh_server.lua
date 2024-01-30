util.AddNetworkString("EH_PlayHitsound")
util.AddNetworkString("EH_PlayKillsound")

// Play hit sound when attacking NPC or Player
hook.Add("EntityTakeDamage", "EH_DetectHit", function(target, dmg)
    // Make don't play hit sound when NPC attacks player or other NPCs
    if (not dmg:GetAttacker():IsPlayer()) then
        return
    end

    // Play hit sound when target is NPC or Player
    // This prevents attacking entities that can get damage plays hit sound (ex: Breakable wooden box)
    if (target:IsNPC() or target:IsPlayer()) then   
        if (target:GetMaterialType() == MAT_METAL) then // Don't play sound if target is metallic
            return
        end

        net.Start("EH_PlayHitsound")
        net.Send(dmg:GetAttacker())
    end
end)

// Play kill sound when killed NPC
hook.Add("OnNPCKilled", "EH_NPCKilled", function(npc, attacker, inflictor)
    // Make don't play kill sound when NPC kills other NPC
    if (not attacker:IsPlayer()) then
        return
    end

    // Play kill sound when attacker is Player
    if (attacker:IsPlayer()) then
        if (npc:GetMaterialType() == MAT_METAL) then // Don't play sound if target is metallic
            return
        end

        net.Start("EH_PlayKillsound")
        net.Send(attacker)
    end
end)

// Play kill sound when killed Player
hook.Add("PlayerDeath", "EH_PlayerKilled", function(victim, inflictor, attacker)
    if (not attacker:IsPlayer()) then
        return
    end

    // Don't play sound when player commited suicide
    if (victim == attacker) then
        return
    end

    // Play kill sound when attacker is Player
    if (attacker:IsPlayer()) then
        net.Start("EH_PlayKillsound")
        net.Send(attacker)
    end
end)