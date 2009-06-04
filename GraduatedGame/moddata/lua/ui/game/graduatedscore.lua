--
-- graduatedscore
-- Brent Allen 2007
-- www.scmods.net
--
-- Hooks: none
-- 
-- Duplicates functionality of score board, displays Graduated Game
-- progress.
--
-- File based on score.lua by Chris Blackwell.
--

local UserSync = import('/lua/UserSync.lua')

local UIUtil = import('/lua/ui/uiutil.lua')
local LayoutHelpers = import('/lua/maui/layouthelpers.lua')
local GameMain = import('/lua/ui/game/gamemain.lua')
local Group = import('/lua/maui/group.lua').Group
local Bitmap = import('/lua/maui/bitmap.lua').Bitmap
local Text = import('/lua/maui/text.lua').Text
local Grid = import('/lua/maui/Grid.lua').Grid
local Prefs = import('/lua/user/prefs.lua')


local overlay = false
local needExpand = false

local overlay = {
    group = false,
    armyLines = {},
    title = false,
}

-- global variable for UserSync to put data in to
GraduatedData = {}

local function CreateArmyLine(parent)
    local group = Group(parent)

    group.faction = Bitmap(group)    
    group.teamcolor = Bitmap(group)    
    group.playername = UIUtil.CreateText(group, "", 14, UIUtil.bodyFont)    
    group.percent = UIUtil.CreateText(group, "", 14, UIUtil.bodyFont)    
    group.level = UIUtil.CreateText(group, "", 14, UIUtil.bodyFont)
    group.namebg = Bitmap(group)

    group.graduatedscore = 1

    group.middlebg = Bitmap(group, UIUtil.UIFile('/dialogs/score-overlay/score_brd_m.dds'))
    group.rightbg = Bitmap(group, UIUtil.UIFile('/dialogs/score-overlay/score_brd_vert_r.dds'))
    group.leftbg = Bitmap(group, UIUtil.UIFile('/dialogs/score-overlay/score_brd_vert_l.dds'))

    return group
end

local function LayoutLine(line)
    line.faction.Left:Set(line.Left)
    line.faction.Height:Set(15)
    line.faction.Width:Set(15)
    line.faction.Bottom:Set(function() return line.Bottom() - 3 end)

    line.playername.Left:Set(function() return line.faction.Right() + 11 end)
    line.percent.Left:Set(function() return line.playername.Right() + 10 end)
    line.level.Left:Set(function() return line.percent.Right() + 5 end)


    LayoutHelpers.FillParent(line.teamcolor, line.faction)
    line.teamcolor.Depth:Set(function() return line.faction.Depth() - 1 end)

    LayoutHelpers.AtVerticalCenterIn(line.percent, line)
    LayoutHelpers.AtVerticalCenterIn(line.level, line)
    LayoutHelpers.AtVerticalCenterIn(line.playername, line)

    line.namebg.Left:Set(function() return line.playername.Left() - 3 end)
    line.namebg.Right:Set(function() return line.level.Right() + 3 end)
    line.namebg.Bottom:Set(line.playername.Bottom)
    line.namebg.Height:Set(function () return line.playername.Height() + 1 end)
    line.namebg.Depth:Set(function() return line.playername.Depth() - 1 end)

    line.middlebg.Left:Set(line.playername.Left)
    line.middlebg.Right:Set(line.namebg.Right)
    line.middlebg.Bottom:Set(line.Bottom)
    line.middlebg.Depth:Set(function() return line.namebg.Depth() - 1 end)

    line.rightbg.Left:Set(function() return line.middlebg.Right() - 3 end)
    line.rightbg.Bottom:Set(line.middlebg.Bottom)
    line.rightbg.Depth:Set(line.middlebg.Depth)

    line.leftbg.Right:Set(line.middlebg.Left)
    line.leftbg.Bottom:Set(line.middlebg.Bottom)
    line.leftbg.Depth:Set(line.middlebg.Depth)
end

function CreateScoreOverlay()
    local worldView = import('/lua/ui/game/borders.lua').GetMapGroup()

    local armiesInfo = GetArmiesTable()

    overlay.group = Group(worldView, "GraduatedScoreOverlayGroup")
    overlay.group:SetRenderPass(UIUtil.UIRP_PostGlow)
    overlay.group.Top:Set(function() return worldView.Top() + 29 end)
    overlay.group.Left:Set(function() return worldView.Left() + 14 end )

    overlay.group.Right:Set(function() return worldView.Right() end)
    overlay.group.Bottom:Set(function() return worldView.Bottom() end)

    local counter = 1
    for i, v in armiesInfo.armiesTable do
        if v.showScore and not v.civilian then
            overlay.armyLines[counter] = CreateArmyLine(overlay.group)
            counter = counter + 1
        end
    end
    
    local index = 0
    for i, v in overlay.armyLines do
        index = i
        if index == 1 then
            v.Top:Set(overlay.group.Top)
        else
            v.Top:Set(overlay.armyLines[index-1].Bottom)
        end

        v.Left:Set(overlay.group.Left)
        v.Right:Set(v.level.Right)

        v.Height:Set(v.middlebg.Height)
        LayoutLine(v)
    end



    overlay.bottomRight = Bitmap(overlay.group, UIUtil.UIFile('/dialogs/score-overlay/score_brd_lr.dds'))
    overlay.bottomRight.Top:Set(overlay.armyLines[index].Bottom)
    overlay.bottomRight.Right:Set(function() return overlay.armyLines[index].rightbg.Right() + 1 end)

    overlay.bottomLeft = Bitmap(overlay.group, UIUtil.UIFile('/dialogs/score-overlay/score_brd_ll.dds'))
    overlay.bottomLeft.Top:Set(overlay.armyLines[index].Bottom)
    overlay.bottomLeft.Left:Set(function() return overlay.armyLines[index].leftbg.Left() - 1 end)

    overlay.bottomMiddle = Bitmap(overlay.group, UIUtil.UIFile('/dialogs/score-overlay/score_brd_lm.dds'))
    overlay.bottomMiddle.Top:Set(overlay.bottomRight.Top)
    overlay.bottomMiddle.Right:Set(overlay.bottomRight.Left)
    overlay.bottomMiddle.Left:Set(function() return overlay.bottomLeft.Right() - 1 end)

    overlay.topRight = Bitmap(overlay.group, UIUtil.UIFile('/dialogs/score-overlay/score_brd_ur.dds'))
    overlay.topRight.Bottom:Set(function() return overlay.armyLines[1].Top() end)
    overlay.topRight.Right:Set(function() return overlay.armyLines[index].rightbg.Right() end)

    overlay.topLeft = Bitmap(overlay.group, UIUtil.UIFile('/dialogs/score-overlay/score_brd_ul.dds'))
    overlay.topLeft.Bottom:Set(function() return overlay.topRight.Bottom() + 1 end)
    overlay.topLeft.Left:Set(function() return overlay.armyLines[index].leftbg.Left() end)

    overlay.topMiddle = Bitmap(overlay.group, UIUtil.UIFile('/dialogs/score-overlay/score_brd_horz_um.dds'))
    overlay.topMiddle.Bottom:Set(function() return overlay.armyLines[1].Top() end)
    overlay.topMiddle.Left:Set(overlay.topLeft.Right)
    overlay.topMiddle.Right:Set(overlay.topRight.Left)
    overlay.topMiddle.Height:Set(function() return overlay.topMiddle.BitmapHeight() end)


    overlay.title = UIUtil.CreateText(overlay.group, "", 14, UIUtil.bodyFont)
    overlay.title.Left:Set(overlay.topMiddle.Left)
    overlay.title.Bottom:Set(function() return overlay.armyLines[1].Top() - 3 end)
    overlay.title:SetDropShadow(true);
    overlay.title:SetColor('ffff9900')
    overlay.title:SetText("Graduated Scores")

    overlay.group:DisableHitTest(true)
    overlay.group:Hide()
    
    overlay.group:SetNeedsFrameUpdate(true)
    overlay.group.OnFrame = function(self, deltatime)
        if Prefs.GetFromCurrentProfile("scoreoverlay") != nil and Prefs.GetFromCurrentProfile("scoreoverlay") != false then
            overlay.group:Show()
        end
        overlay.group:SetNeedsFrameUpdate(false)
    end

    GameMain.AddBeatFunction(_BeatFunction)

    overlay.group.OnDestroy = function(self)
        GameMain.RemoveBeatFunction(_BeatFunction)
    end
end


function _BeatFunction()
    if overlay.group:IsHidden() then
        overlay.group:Hide()
    else
        local armiesInfo = GetArmiesTable()
        if armiesInfo then
            local focusArmy = armiesInfo.focusArmy
            local sortedTable = {}
            
            local index = 1

            -- Put the data from the sync in to a local table

            for i, v in armiesInfo.armiesTable do
                if v.showScore and not v.civilian then
                    sortedTable[index] = v
                    sortedTable[index].ID = i

                    if GraduatedData then
                        sortedTable[index].percent = GraduatedData[i].Percent or 0
                        sortedTable[index].level = GraduatedData[i].Level or 'none'
                        sortedTable[index].damage = GraduatedData[i].Damage or 0

                    else
                        sortedTable[index].percent = 0
                        sortedTable[index].level = 'none'
                        sortedTable[index].damage = 0
                    end

                    if focusArmy == index then
                        sortedTable[index].focus = true
                    else
                        sortedTable[index].focus = false
                    end

                    index = index + 1
                end
            end

            -- Sort the table by Battle Damage

            table.sort(sortedTable, function(table1, table2)
                if table1.damage <= table2.damage then
                    return false
                else
                    return true
                end
            end)

            -- Set the information in the table

            for i, v in sortedTable do
                local index = i
                overlay.armyLines[index].percent:SetText(string.format('%d%%',v.percent))
                overlay.armyLines[index].level:SetText('to ' .. v.level)
                if v.outOfGame and not overlay.armyLines[index].OOG then
                    overlay.armyLines[index].OOG = true
                    overlay.armyLines[index].faction:SetTexture(UIUtil.UIFile('/game/unit-over/icon-skull_bmp.dds'))
                    overlay.armyLines[index].teamcolor:Hide()
                    overlay.armyLines[index].playername:SetColor('ffa0a0a0')
                    overlay.armyLines[index].percent:SetColor("ffa0a0a0")
                    overlay.armyLines[index].playername:SetText(v.nickname)
                end
                if overlay.armyLines[index].ID != v.ID then
                    overlay.armyLines[index].ID = v.ID
                    if not v.outOfGame then
                        overlay.armyLines[index].OOG = false
                        SetBackgroundColor(overlay.armyLines[index], v.focus)
                        overlay.armyLines[index].playername:SetText(v.nickname)
                        overlay.armyLines[index].teamcolor:Show()
                        overlay.armyLines[index].teamcolor:SetSolidColor(v.color)
                        overlay.armyLines[index].faction:SetTexture(UIUtil.UIFile(UIUtil.GetFactionIcon(v.faction)))
                    end
                end
            end

            -- Find the player, percent, and level with the maximum width
            
            local maxPlayerWidth = 70
            local maxPlayerIndex = 1

            local maxPercentWidth = 10
            local maxPercentIndex = 1

            local maxLevelWidth = 10
            local maxLevelIndex = 1

            for i, v in overlay.armyLines do
                if v.playername.Width() > maxPlayerWidth then
                    maxPlayerWidth = v.playername.Width()
                    maxPlayerIndex = i
                end
                if v.percent.Width() > maxPercentWidth then
                    maxPercentWidth = v.percent.Width()
                    maxPercentIndex = i
                end
                if v.level.Width() > maxLevelWidth then
                    maxLevelWidth = v.level.Width()
                    maxLevelIndex = i
                end

            end

            -- Set Each column's left side to allign to the the largest element in the column to the left
            
            for i, v in overlay.armyLines do
                v.playername.Width:Set(function() return maxPlayerWidth end)

                v.percent.Left:Set(function() return overlay.armyLines[maxPlayerIndex].playername.Right() + 10 end)
                v.level.Left:Set(function() return overlay.armyLines[maxPercentIndex].percent.Right() + 5 end)

                v.namebg.Right:Set(function() return overlay.armyLines[maxLevelIndex].level.Right() + 3 end)
            end
        end
    end
end



local unitColor = 'red'

function SetBackgroundColor(control, focus)
    if focus then
        control.playername:SetColor("FFFFFFFF")
        control.percent:SetColor("FFFFFFFF")
        control.level:SetColor("FFFFFFFF")
        control.namebg:SetSolidColor("70FFFFFF")
    else
        control.playername:SetColor("FFFFFFFF")
        control.percent:SetColor("FFFFFFFF")
        control.level:SetColor("FFFFFFFF")
        control.namebg:SetSolidColor("70000000")
    end
end

function Expand()
    if needExpand then
        overlay.group:Show()
        needExpand = false
    end
end

function Contract()
  if not overlay.group:IsHidden() then
       overlay.group:Hide()
       needExpand = true
   else
       needExpand = false
   end
end

function ToggleScoreControl()

    # disable when in Screen Capture mode
    if import('/lua/ui/game/gamemain.lua').gameUIHidden then
        return
    end

    if overlay.group:IsHidden() then
        Prefs.SetToCurrentProfile("scoreoverlay", true)
        overlay.group:Show()
    else
        Prefs.SetToCurrentProfile("scoreoverlay", false)
        overlay.group:Hide()
    end
end

