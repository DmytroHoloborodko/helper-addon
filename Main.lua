local addonName, addon = ...

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
    CreateSettingsFrame()
    EnableReloadUIButton()
    EnableRightClickLock()
    EnablePetSummon()
    EnableMenuToggle()
    EnableInspectItemLevel(true)
    EnableSellItemsButton(true)

end)

if AddonCompartmentFrame then
    AddonCompartmentFrame:RegisterAddon({
        text = "Local Helper",
        icon = "Interface\\Icons\\INV_Misc_QuestionMark",
        notCheckable = true,
        func = function()
            Settings.OpenToCategory(addonName) -- todo: fix
        end
    })
end
