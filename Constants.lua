local Private = select(2, ...)
Private.E = unpack(ElvUI)
Private.ACH = LibStub("LibAceConfigHelper")
Private.ADDON_NAME = C_AddOns.GetAddOnMetadata("ElvUIAnchors", "Title")

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

function Private:CreatePopup(isExporting)
    StaticPopupDialogs["FRAGUI_PROFILE_TRANSFER"] = {
        text = isExporting and "Export Profile" or "Import Profile",
        button1 = isExporting and "Close" or "Import",
        button2 = "Cancel",
        hasEditBox = true,
        editBoxWidth = 350,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,

        OnShow = function(self)
            if isExporting then
                local exportString = Private:ExportProfile(Private.DB.global)
                self.EditBox:SetText(exportString)
                self.EditBox:HighlightText()
            else
                self.EditBox:SetText("")
                self.EditBox:SetFocus()
            end
        end,

        OnAccept = function(self)
            if not isExporting then
                local text = self.EditBox:GetText()
                if text and text ~= "" then
                    local importedData = Private:ImportProfile(text)
                    if importedData then
                        Private.DB.global = importedData
                        Private:UpdateAllMovers()
                    end
                end
            end
        end,
        EditBoxOnEnterPressed = function(self) self:GetParent().button1:Click() end,
    }

    StaticPopup_Show("FRAGUI_PROFILE_TRANSFER")
end