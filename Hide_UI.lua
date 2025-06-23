local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
    -- Hide Micro Menu (Character, Spellbook, etc.)
    if MicroMenuContainer then
        MicroMenuContainer:Hide()
        MicroMenuContainer.Show = function()
        end -- Prevent re-showing
    end

    -- Hide Backpack and Bag Slots
    if MainMenuBarBackpackButton then
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

    -- Move the Queue Status Button
    if QueueStatusButton then
        QueueStatusButton:SetParent(UIParent)
        -- QueueStatusButton:ClearAllPoints()
        -- QueueStatusButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 40, -15)
    end
end)
