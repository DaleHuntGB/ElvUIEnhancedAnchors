local Private = select(2, ...)
local AddOn = LibStub("AceAddon-3.0"):NewAddon("ElvUIAnchors")

function AddOn:OnInitialize()
    Private.DB = LibStub("AceDB-3.0"):New("ElvUIAnchorsDB", {
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
    })
end

function AddOn:OnEnable()
    Private:SetupConfig()
    local EventFrame = CreateFrame("Frame")
    EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    EventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    EventFrame:SetScript("OnEvent", function(_, event, ...)
        if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_SPECIALIZATION_CHANGED" then
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
    end)
end