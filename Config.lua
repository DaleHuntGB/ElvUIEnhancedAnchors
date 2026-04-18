local Private = select(2, ...)
local ACH = Private.ACH
local ACR = Private.ACR

local function BuildFrameLayoutSection(FrameDB, MoverName, GroupName, TabOrder)
    local Section = ACH:Group(GroupName, nil, TabOrder, nil)
    local function IsDisabled() return not FrameDB.Enabled end

    local function UpdateLayout()
        Private:UpdateMover(FrameDB.Enabled, MoverName, table.concat(FrameDB.Layout, ","))
        if ACR then ACR:NotifyChange("ElvUI") end
    end

    Section.args.Enabled = ACH:Toggle("Enable |cFF8080FF" .. GroupName .. "|r Anchor", nil, 1, nil, nil, "full", function() return FrameDB.Enabled end, function(_, value) FrameDB.Enabled = value UpdateLayout() end)

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

    Private.Config.args.Description = ACH:Description(Private.ADDON_NAME .. " is not affiliated with |cff1784d1ElvUI|r.\n\n" .. Private.ADDON_NAME .. " will update the |cff1784d1ElvUI|r movers and save these to the same profile as your current |cff1784d1ElvUI|r Profile.\n\n", 0)

    Private.Config.args.Player = BuildFrameLayoutSection(Private.DB.global.Player, "ElvUF_PlayerMover", "Player Frame", 1)
    Private.Config.args.PlayerCastBar = BuildFrameLayoutSection(Private.DB.global.PlayerCastBar, "ElvUF_PlayerCastbarMover", "Player Cast Bar", 2)
    Private.Config.args.Target = BuildFrameLayoutSection(Private.DB.global.Target, "ElvUF_TargetMover", "Target Frame", 3)
    Private.Config.args.TargetCastBar = BuildFrameLayoutSection(Private.DB.global.TargetCastBar, "ElvUF_TargetCastbarMover", "Target Cast Bar", 4)
    Private.Config.args.TargetTarget = BuildFrameLayoutSection(Private.DB.global.TargetTarget, "ElvUF_TargetTargetMover", "Target of Target Frame", 5)
    Private.Config.args.Focus = BuildFrameLayoutSection(Private.DB.global.Focus, "ElvUF_FocusMover", "Focus Frame", 6)
    Private.Config.args.FocusCastBar = BuildFrameLayoutSection(Private.DB.global.FocusCastBar, "ElvUF_FocusCastbarMover", "Focus Cast Bar", 7)
    Private.Config.args.FocusTarget = BuildFrameLayoutSection(Private.DB.global.FocusTarget, "ElvUF_FocusTargetMover", "Focus Target", 8)
    Private.Config.args.Pet = BuildFrameLayoutSection(Private.DB.global.Pet, "ElvUF_PetMover", "Pet Frame", 9)

    if Private.E then
        Private.E.Options.args.ElvUIAnchors = Private.Config
    end
end
