--
-- defaultunits
-- Brent Allen 2007
-- www.scmods.net
--
-- Hooks: AirUnit.OnKilled (non-destructive)
--
-- Captures Killed events and adds to each teams
-- army stats.
--

local UnitLua = import('/mods/GraduatedGame/hook/lua/sim/unit.lua')

local oldAirUnit = AirUnit

AirUnit = Class(AirUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldAirUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}
