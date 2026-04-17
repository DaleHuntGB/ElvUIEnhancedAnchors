local Private = select(2, ...)
Private.E = unpack(ElvUI)
Private.ACH = LibStub("LibAceConfigHelper")
Private.ADDON_NAME = C_AddOns.GetAddOnMetadata("ElvUIEnhancedAnchors", "Title")

local Defaults = {
    global = {
        Player = {
            Enabled = false,
            Layout = {"RIGHT", "EssentialCooldownViewer", "LEFT", -10, 0}
        },
        PlayerCastBar = {
            Enabled = false,
            Layout = {"CENTER", "ElvUIParent", "CENTER", 0, 0}
        },
        Target = {
            Enabled = false,
            Layout = {"LEFT", "EssentialCooldownViewer", "RIGHT", 10, 0}
        },
        TargetCastBar = {
            Enabled = false,
            Layout = {"TOP", "ElvUF_Target", "BOTTOM", 0, -1}
        },
        TargetTarget = {
            Enabled = false,
            Layout = {"CENTER", "ElvUIParent", "CENTER", 0, 0}
        },
        Focus = {
            Enabled = false,
            Layout = {"CENTER", "ElvUIParent", "CENTER", 0, 0}
        },
        FocusCastBar = {
            Enabled = false,
            Layout = {"CENTER", "ElvUIParent", "CENTER", 0, 0}
        },
        FocusTarget = {
            Enabled = false,
            Layout = {"CENTER", "ElvUIParent", "CENTER", 0, 0}
        },
        Pet = {
            Enabled = false,
            Layout = {"CENTER", "ElvUIParent", "CENTER", 0, 0}
        }
    }
}

function Private:GetDefaults()
    return Defaults
end

Private.ANCHOR_POINTS = {
    ["TOPLEFT"] = "TOPLEFT",
    ["TOP"] = "TOP",
    ["TOPRIGHT"] = "TOPRIGHT",
    ["LEFT"] = "LEFT",
    ["CENTER"] = "CENTER",
    ["RIGHT"] = "RIGHT",
    ["BOTTOMLEFT"] = "BOTTOMLEFT",
    ["BOTTOM"] = "BOTTOM",
    ["BOTTOMRIGHT"] = "BOTTOMRIGHT"
}

Private.MOVERS = {
    ["ElvUF_PlayerMover"] = "Player",
    ["ElvUF_PlayerCastbarMover"] = "PlayerCastBar",
    ["ElvUF_TargetMover"] = "Target",
    ["ElvUF_TargetCastbarMover"] = "TargetCastBar",
    ["ElvUF_TargetTargetMover"] = "TargetTarget",
    ["ElvUF_FocusMover"] = "Focus",
    ["ElvUF_FocusCastbarMover"] = "FocusCastBar",
    ["ElvUF_FocusTargetMover"] = "FocusTarget",
    ["ElvUF_PetMover"] = "Pet"
}

function Private:SetMovers(isEnabled, moverName, moverLayout)
    if isEnabled and moverName and moverLayout then
        Private.E.db.movers[moverName] = moverLayout
        Private.E:SetMoverPoints(moverName)
        Private.E:SaveMoverPosition(moverName)
    end
end

function Private:UpdateMovers(isEnabled, moverName, moverLayout)
    if isEnabled and moverName and moverLayout then
        Private.E.db.movers[moverName] = moverLayout
        Private.E:SetMoverPoints(moverName)
        Private.E:SaveMoverPosition(moverName)
    end
    Private.E:LoadMovers()
end

local function RestrictionsAreActive()
    return C_RestrictedActions.IsAddOnRestrictionActive(0) == true or C_RestrictedActions.IsAddOnRestrictionActive(1) == true or C_RestrictedActions.IsAddOnRestrictionActive(2) == true
end

function Private:SetAllMovers()
    if InCombatLockdown() or RestrictionsAreActive() then return end
    Private:SetMovers(Private.DB.global.Player.Enabled, "ElvUF_PlayerMover", table.concat(Private.DB.global.Player.Layout, ","))
    Private:SetMovers(Private.DB.global.PlayerCastBar.Enabled, "ElvUF_PlayerCastbarMover", table.concat(Private.DB.global.PlayerCastBar.Layout, ","))
    Private:SetMovers(Private.DB.global.Target.Enabled, "ElvUF_TargetMover", table.concat(Private.DB.global.Target.Layout, ","))
    Private:SetMovers(Private.DB.global.TargetCastBar.Enabled, "ElvUF_TargetCastbarMover", table.concat(Private.DB.global.TargetCastBar.Layout, ","))
    Private:SetMovers(Private.DB.global.TargetTarget.Enabled, "ElvUF_TargetTargetMover", table.concat(Private.DB.global.TargetTarget.Layout, ","))
    Private:SetMovers(Private.DB.global.Focus.Enabled, "ElvUF_FocusMover", table.concat(Private.DB.global.Focus.Layout, ","))
    Private:SetMovers(Private.DB.global.FocusCastBar.Enabled, "ElvUF_FocusCastbarMover", table.concat(Private.DB.global.FocusCastBar.Layout, ","))
    Private:SetMovers(Private.DB.global.FocusTarget.Enabled, "ElvUF_FocusTargetMover", table.concat(Private.DB.global.FocusTarget.Layout, ","))
    Private:SetMovers(Private.DB.global.Pet.Enabled, "ElvUF_PetMover", table.concat(Private.DB.global.Pet.Layout, ","))
    Private.E:LoadMovers()
end

function Private:PrettyPrint(MSG)
    print(Private.ADDON_NAME .. ": " .. MSG)
end