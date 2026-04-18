local Private = select(2, ...)
local ACH = Private.ACH
local ACR = Private.ACR

local GroupNameToElvUIName = {
    ["Player Frame"] = "player",
    ["Player Cast Bar"] = "player",
    ["Target Frame"] = "target",
    ["Target Cast Bar"] = "target",
    ["Target of Target Frame"] = "targettarget",
    ["Focus Frame"] = "focus",
    ["Focus Cast Bar"] = "focus",
    ["Focus Target"] = "focustarget",
    ["Pet Frame"] = "pet"
}

local function ReturnElementState(GroupName, isCastBar)
    if Private:IsElementEnabled(GroupNameToElvUIName[GroupName], isCastBar) then
        return "|cFF40FF40" .. GroupName .. "|r"
    else
        return "|cFFCCCCCC" .. GroupName .. "|r"
    end
end

local function BuildFrameLayoutSection(FrameDB, MoverName, GroupName, TabOrder)
    local Section = ACH:Group(GroupName, nil, TabOrder, nil)
    local function IsDisabled() return not FrameDB.Enabled end

    local function UpdateLayout()
        Private:UpdateMover(FrameDB.Enabled, MoverName, table.concat(FrameDB.Layout, ","))
        if ACR then ACR:NotifyChange("ElvUI") end
    end

    Section.args.Enabled = ACH:Toggle("Enable |cFF8080FFEnhanced|r Anchors", nil, 1, nil, nil, "full", function() return FrameDB.Enabled end, function(_, value) FrameDB.Enabled = value UpdateLayout() end)

    Section.args.LayoutHeader = ACH:Header("Anchoring", 2)

    Section.args.AnchorFrom = ACH:Select("Anchor From", nil, 3, Private.ANCHOR_POINTS, nil, "full", function() return FrameDB.Layout[1] end, function(_, value) FrameDB.Layout[1] = value UpdateLayout() end, IsDisabled)
    Section.args.Anchors = ACH:Select("Anchors", nil, 4, Private.ANCHORS[MoverName], nil, "full", function() return FrameDB.Layout[2] end, function(_, value) FrameDB.Layout[2] = value if ACR then ACR:NotifyChange("ElvUI") end UpdateLayout() end, IsDisabled )
    Section.args.Anchors.sorting = function() return Private.ORDERED_ANCHORS[MoverName] end
    Section.args.AnchorParent = ACH:Input("Anchor Parent", nil, 5, nil, "full", function() return FrameDB.Layout[2] end, function(_, value) FrameDB.Layout[2] = value UpdateLayout() end, IsDisabled)
    Section.args.AnchorTo = ACH:Select("Anchor To", nil, 6, Private.ANCHOR_POINTS, nil, "full", function() return FrameDB.Layout[3] end, function(_, value) FrameDB.Layout[3] = value UpdateLayout() end, IsDisabled)
    Section.args.XOffset = ACH:Range("X Offset", nil, 7, { min = -3000, max = 3000, step = 0.1 }, "full", function() return FrameDB.Layout[4] end, function(_, value) FrameDB.Layout[4] = value UpdateLayout() end, IsDisabled)
    Section.args.YOffset = ACH:Range("Y Offset", nil, 8, { min = -3000, max = 3000, step = 0.1 }, "full", function() return FrameDB.Layout[5] end, function(_, value) FrameDB.Layout[5] = value UpdateLayout() end, IsDisabled)
    return Section
end

function Private:SetupConfig()
	Private.Config = ACH:Group(format("%s", Private.ADDON_NAME), nil, 20, "tree")

    Private.Config.args.Description = ACH:Description(Private.ADDON_NAME .. " is not affiliated with |cff1784d1ElvUI|r.\n\n" .. Private.ADDON_NAME .. " will update the |cff1784d1ElvUI|r movers and save these to the same profile as your current |cff1784d1ElvUI|r Profile.\n\n|cFF8080FFElements|r that are coloured |cFF40FF40GREEN|r are enabled in |cff1784d1ElvUI|r.\n\n", 0)

    Private.Config.args.Player = BuildFrameLayoutSection(Private.DB.global.Player, "ElvUF_PlayerMover", ReturnElementState("Player Frame", false), 1)
    Private.Config.args.PlayerCastBar = BuildFrameLayoutSection(Private.DB.global.PlayerCastBar, "ElvUF_PlayerCastbarMover", ReturnElementState("Player Cast Bar", true), 2)
    Private.Config.args.Target = BuildFrameLayoutSection(Private.DB.global.Target, "ElvUF_TargetMover", ReturnElementState("Target Frame", false), 3)
    Private.Config.args.TargetCastBar = BuildFrameLayoutSection(Private.DB.global.TargetCastBar, "ElvUF_TargetCastbarMover", ReturnElementState("Target Cast Bar", true), 4)
    Private.Config.args.TargetTarget = BuildFrameLayoutSection(Private.DB.global.TargetTarget, "ElvUF_TargetTargetMover", ReturnElementState("Target of Target Frame", false), 5)
    Private.Config.args.Focus = BuildFrameLayoutSection(Private.DB.global.Focus, "ElvUF_FocusMover", ReturnElementState("Focus Frame", false), 6)
    Private.Config.args.FocusCastBar = BuildFrameLayoutSection(Private.DB.global.FocusCastBar, "ElvUF_FocusCastbarMover", ReturnElementState("Focus Cast Bar", true), 7)
    Private.Config.args.FocusTarget = BuildFrameLayoutSection(Private.DB.global.FocusTarget, "ElvUF_FocusTargetMover", ReturnElementState("Focus Target", false), 8)
    Private.Config.args.Pet = BuildFrameLayoutSection(Private.DB.global.Pet, "ElvUF_PetMover", ReturnElementState("Pet Frame", false), 9)

    if Private.E then
        Private.E.Options.args.ElvUIAnchors = Private.Config
    end
end
