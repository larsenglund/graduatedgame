--
-- UserSync
-- Brent Allen 2007
-- www.scmods.net
--
-- Hooks: OnSync (non-destructive)
--
-- When new data is available, the data is trasnfered to the
-- GraduatedScore interface.
--

local GraduatedScore = import('/mods/GraduatedGame/moddata/lua/ui/game/graduatedscore.lua')
local origOnSync = OnSync

function OnSync()
    if Sync.GraduatedData then
        GraduatedScore.GraduatedData = Sync.GraduatedData
    end
    origOnSync()
end

