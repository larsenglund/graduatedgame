--
-- unit
-- Brent Allen 2007
-- www.scmods.net
--
-- Hooks: Unit.OnKilled (non-destructive)
--
-- Captures Killed events and adds to each teams
-- army stats.
--

local Unit = import('/lua/sim/Unit.lua').Unit

local oldUnit = Unit

Unit = Class(Unit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldUnit.OnKilled(self, instigator, type, overkillRatio)
        GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

function GraduatedCountDeath(self, instigator, type, overkillRatio)

    --Unit allready counted
    if (self.GraduatedCounted or 0) == 1 then
        return
    end

    self.GraduatedCounted = 1 --Mark unit as counted

    local myArmy = self:GetArmy()
    local hisArmy = -1
    
    local myEconomy = self:GetBlueprint().Economy

    --Determine value of killed unit
    local myTime = myEconomy.BuildTime

--    LOG('Unit ' .. self:GetBlueprint().Description .. ' killed for ' .. repr(myTime) .. ' points')
--    LOG('     Cost Energy: ' .. repr(myEconomy.BuildCostEnergy) .. ' Cost Mass: ' .. repr(myEconomy.BuildCostMass) .. ' Time: ' .. repr(myEconomy.BuildTime))

    if instigator then
        hisArmy = instigator:GetArmy()

        --Check for friendly fire
        if myArmy ~= hisArmy then
            local myBrain = ArmyBrains[myArmy]
            local hisBrain = ArmyBrains[hisArmy]
            myBrain:AddArmyStat('BATTLE_DAMAGE', myTime)
            hisBrain:AddArmyStat('BATTLE_DAMAGE', myTime)
--            LOG('Damage awarded ' .. repr(myTime) .. ' to ' .. myBrain.Nickname .. ' and ' .. hisBrain.Nickname)
        end

    end
end


