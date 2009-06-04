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


local oldStructureUnit = StructureUnit
local oldMobileUnit = MobileUnit

StructureUnit = Class(StructureUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldStructureUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

MobileUnit = Class(MobileUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldMobileUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}


local oldAirUnit = AirUnit
local oldFactoryUnit = FactoryUnit
local oldAirFactoryUnit = AirFactoryUnit
local oldAirStagingPlatformUnit = AirStagingPlatformUnit
local oldConcreteStructureUnit = ConcreteStructureUnit
local oldEnergyCreationUnit = EnergyCreationUnit
local oldEnergyStorageUnit = EnergyStorageUnit
local oldLandFactoryUnit = LandFactoryUnit
local oldMassCollectionUnit = MassCollectionUnit
local oldMassFabricationUnit = MassFabricationUnit
local oldMassStorageUnit = MassStorageUnit
local oldRadarUnit = RadarUnit
local oldRadarJammerUnit = RadarJammerUnit
local oldSonarUnit = SonarUnit
local oldSeaFactoryUnit = SeaFactoryUnit
local oldShieldStructureUnit = ShieldStructureUnit
local oldTransportBeaconUnit = TransportBeaconUnit
local oldWallStructureUnit = WallStructureUnit
local oldQuantumGateUnit = QuantumGateUnit
local oldWalkingLandUnit = WalkingLandUnit
local oldSubUnit = SubUnit
local oldHoverLandUnit = HoverLandUnit
local oldLandUnit = LandUnit
local oldConstructionUnit = ConstructionUnit
local oldSeaUnit = SeaUnit
local oldShieldHoverLandUnit = ShieldHoverLandUnit
local oldShieldLandUnit = ShieldLandUnit
local oldShieldSeaUnit = ShieldSeaUnit

AirUnit = Class(AirUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldAirUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

FactoryUnit = Class(FactoryUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldFactoryUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

AirFactoryUnit = Class(AirFactoryUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldAirFactoryUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

AirStagingPlatformUnit = Class(AirStagingPlatformUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldAirStagingPlatformUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

ConcreteStructureUnit = Class(ConcreteStructureUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldConcreteStructureUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

EnergyCreationUnit = Class(EnergyCreationUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldEnergyCreationUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

EnergyStorageUnit = Class(EnergyStorageUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldEnergyStorageUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

LandFactoryUnit = Class(LandFactoryUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldLandFactoryUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

MassCollectionUnit = Class(MassCollectionUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldMassCollectionUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

MassFabricationUnit = Class(MassFabricationUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldMassFabricationUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

MassStorageUnit = Class(MassStorageUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldMassStorageUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

RadarUnit = Class(RadarUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldRadarUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

RadarJammerUnit = Class(RadarJammerUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldRadarJammerUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

SonarUnit = Class(SonarUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldSonarUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

SeaFactoryUnit = Class(SeaFactoryUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldSeaFactoryUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

ShieldStructureUnit = Class(ShieldStructureUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldShieldStructureUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

TransportBeaconUnit = Class(TransportBeaconUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldTransportBeaconUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

WallStructureUnit = Class(WallStructureUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldWallStructureUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

QuantumGateUnit = Class(QuantumGateUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldQuantumGateUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

WalkingLandUnit = Class(WalkingLandUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

SubUnit = Class(SubUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldSubUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

HoverLandUnit = Class(HoverLandUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldHoverLandUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

LandUnit = Class(LandUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldLandUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

ConstructionUnit = Class(ConstructionUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldConstructionUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

SeaUnit = Class(SeaUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldSeaUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

ShieldHoverLandUnit = Class(ShieldHoverLandUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldShieldHoverLandUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

ShieldLandUnit = Class(ShieldLandUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldShieldLandUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}

ShieldSeaUnit = Class(ShieldSeaUnit) {
    OnKilled = function(self, instigator, type, overkillRatio)
        oldShieldSeaUnit.OnKilled(self, instigator, type, overkillRatio)
        UnitLua.GraduatedCountDeath(self, instigator, type, overkillRatio)
    end,
}
