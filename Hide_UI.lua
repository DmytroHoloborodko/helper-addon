function EnableMenuToggle(showMenu)
    local show = showMenu or HelperSavedVars.showMenu or false

    -- Toggle Micro Menu
    if MicroMenuContainer then
        if show then
            MicroMenuContainer.Show = nil -- Restore default Show method
            MicroMenuContainer:Show()
        else
            MicroMenuContainer:Hide()
            MicroMenuContainer.Show = function()
            end
        end
    end

    -- Toggle Bags
    if MainMenuBarBackpackButton then
        if show then
            BagBarExpandToggle:Show()
            CharacterReagentBag0Slot:Show()
            MainMenuBarBackpackButton.Show = nil
            MainMenuBarBackpackButton:Show()

            for i = 0, 3 do
                local bag = _G["CharacterBag" .. i .. "Slot"]
                if bag then
                    bag.Show = nil
                    bag:Show()
                end
            end
        else
            BagBarExpandToggle:Hide()
            CharacterReagentBag0Slot:Hide()
            MainMenuBarBackpackButton:Hide()
            MainMenuBarBackpackButton.Show = function()
            end

            for i = 0, 3 do
                local bag = _G["CharacterBag" .. i .. "Slot"]
                if bag then
                    bag:Hide()
                    bag.Show = function()
                    end
                end
            end
        end
    end

    hooksecurefunc(QueueStatusButton, "Show", function()
        QueueStatusButton:SetParent(UIParent)
        QueueStatusButton:ClearAllPoints()
        QueueStatusButton:SetPoint("CENTER", Minimap, "BOTTOMLEFT", 0, 0)
    end)

end
