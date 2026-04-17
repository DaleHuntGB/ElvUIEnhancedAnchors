local Private = select(2, ...)
Private.E = unpack(ElvUI)

function Private:SetMovers(isEnabled, moverName, moverLayout)
    EventUtil.ContinueOnAddOnLoaded("ElvUI", function()
        if isEnabled then
            Private.E.db.movers[moverName] = moverLayout
            Private.E:SaveMoverPosition(moverName)
        end
    end)
end