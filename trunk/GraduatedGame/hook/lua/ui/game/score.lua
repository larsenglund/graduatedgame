--
-- score
-- Brent Allen 2007
-- www.scmods.net
--
-- Hooks: CreateScoreOverlay (non-destructive)
--        SetBackgroundColor (non-destructive)
--        Expand (non-destructive)
--        Contract (non-destructive)
--        ToggleScoreControl (non-destructive)
--
-- Duplicates events to the score board for a second
-- GraduatedScore board.
--



local GraduatedScore = import('/mods/GraduatedGame/moddata/lua/ui/game/graduatedscore.lua')

-- local origCreateScoreOverlay = CreateScoreOverlay
-- function CreateScoreOverlay()
--     GraduatedScore.CreateScoreOverlay()
--     origCreateScoreOverlay()
-- end

-- local origSetBackgroundColor = SetBackgroundColor
-- function SetBackgroundColor(control, focus)
--     if control.graduatedscore then
--         GraduatedScore.SetBackgroundColor(control, focus)
--     else
--         origSetBackgroundColor(control, focus)
--     end
-- end
-- 
-- local origExpand = Expand
-- function Expand()
--     GraduatedScore.Expand()
--     origExpand()
-- end
-- 
-- local origContract = Contract
-- function Contract()
--     GraduatedScore.Contract()
--     origContract()
-- end
-- 
-- local origToggleScoreControl = ToggleScoreControl
-- function ToggleScoreControl()
--     GraduatedScore.ToggleScoreControl()
--     origToggleScoreControl()
-- end

