local reloadButton

function EnableReloadUIButton(showButton)
    local show = showButton or HelperSavedVars.showReloadButton or false
    if not reloadButton then
        reloadButton = CreateFrame("Button", "MyReloadButton", UIParent, "UIPanelButtonTemplate")
        reloadButton:SetSize(100, 30)
        reloadButton:SetPoint("CENTER", Minimap, "BOTTOM", 0, -30)
        reloadButton:SetText("Reload UI")
        reloadButton:SetScript("OnClick", function()
            ReloadUI()
        end)
    end

    if not show then
        reloadButton:Hide()
    end
end
