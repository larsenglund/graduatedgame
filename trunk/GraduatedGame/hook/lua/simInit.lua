--
-- simInit
-- Brent Allen 2007
-- www.scmods.net
--
-- Hooks: BeginSession (non-destructive)
--
-- Runs a Thread that updates tech levels every one second.
-- Data about current level is exported to the UI via Sync.
--

local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local SimSync = import('/lua/SimSync.lua')

local function InitializeGraduatedGame()
    for i, brain in ArmyBrains do
        ScenarioFramework.AddRestriction(i, categories.ALLUNITS)
        ScenarioFramework.RemoveRestriction(i, categories.TECH1)
        brain.GraduatedLevel = 1
    end
end

local GraduatedLevels = { {damage = 25000, restriction = categories.TECH2, name = 'Tech 2'},
    {damage = 250000, restriction = categories.TECH3, name = 'Tech 3'},
    {damage = 1000000, restriction = categories.EXPERIMENTAL, name = 'Experimental'}}

-- Testing Values for quicker advancement:
--[[

local GraduatedLevels = { {damage = 2000, restriction = categories.TECH2, name = 'Tech 2'},
    {damage = 4000, restriction = categories.TECH3, name = 'Tech 3'},
    {damage = 6000, restriction = categories.EXPERIMENTAL, name = 'Experimental'}} 

--]]

local function UpdateGraduatedGame()
    while true do

        local playerData = {}

        for i, brain in ArmyBrains do

            local myBattleDamage = brain:GetArmyStat("BATTLE_DAMAGE", 0.0).Value

            local nextLevelIndex = brain.GraduatedLevel or 1

            local nextLevel = GraduatedLevels[nextLevelIndex]

            playerData[i] = {}

            --If the player can advance further
            if nextLevel then

                if myBattleDamage >= nextLevel.damage then
                    ScenarioFramework.RemoveRestriction(i, nextLevel.restriction)
                    brain.GraduatedLevel = brain.GraduatedLevel + 1

                    local msg = brain.Nickname .. ' achieved ' .. nextLevel.name
                    print(msg)
                end

                local currentLevel = GraduatedLevels[nextLevelIndex - 1]
                local percent = 0

                if currentLevel then
                    percent = 100 * (myBattleDamage - currentLevel.damage ) / (nextLevel.damage - currentLevel.damage)
                else
                    percent = 100 * myBattleDamage / nextLevel.damage
                end
                if percent > 100 then
                    percent = 100
                end
                playerData[i].Percent = percent
                playerData[i].Level = nextLevel.name
            else
                playerData[i].Percent = 100
                playerData[i].Level = GraduatedLevels[nextLevelIndex - 1].name
            end

            playerData[i].Damage = myBattleDamage
        end
        Sync.GraduatedData = playerData

        WaitSeconds(1)
    end
end


local originalBeginSession = BeginSession

function BeginSession()
    originalBeginSession()

    InitializeGraduatedGame()

    ForkThread(UpdateGraduatedGame)
end



