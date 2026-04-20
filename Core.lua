local Private = select(2, ...)
local AddOn = LibStub("AceAddon-3.0"):NewAddon("ElvUIEnhancedAnchors")

function AddOn:OnInitialize()
    Private.DB = LibStub("AceDB-3.0"):New("ElvUIEnhancedAnchorsDB", Private:GetDefaults(), true)
end

function AddOn:OnEnable()
    Private:SetupConfig()

    if C_AddOns.IsAddOnLoaded("ElvUI_Anchor") then
        Private.E:StaticPopup_Show("ANCHOR_CONFLICT")
        return
    end

    local EventFrame = CreateFrame("Frame")
    EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    EventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

    EventFrame:SetScript("OnEvent", function(_, event, ...) if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_SPECIALIZATION_CHANGED" then Private:SetAllMovers() end end)

    hooksecurefunc(Private.E, "ToggleMovers", function() Private:SetAllMovers() end)

end