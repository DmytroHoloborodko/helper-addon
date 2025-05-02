-- Show item level on Ispect Frame
EventUtil.ContinueOnAddOnLoaded("Blizzard_InspectUI", function()
    local f = InspectFrame:CreateFontString("InspectFrameIlvl", "OVERLAY", "GameTooltipText")
    f:SetPoint("TOPRIGHT", -20, -40)
    f:SetFont("Fonts\\FRIZQT__.TTF", 18)
    f:SetTextColor(1, 0.82, 0)
    
    InspectFrame:HookScript("OnShow", function()
        f:SetText(C_PaperDollInfo.GetInspectItemLevel(InspectFrame.unit))
    end)
end)
