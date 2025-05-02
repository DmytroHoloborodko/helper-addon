-- Create and manage the reload button
local reloadButton

-- Function to create a movable UI reload button
function CreateMovableReloadUIButton()
    reloadButton = CreateFrame("Button", "MyReloadButton", UIParent, "UIPanelButtonTemplate")
	
	local show = HelperSavedVars.showReloadButton or false
	if not show then
        reloadButton:Hide()
    end

    -- Set button size and position
    reloadButton:SetSize(100, 30)
    reloadButton:SetPoint("CENTER", UIParent, "CENTER", 0, 200) -- Default position

    -- Set button text
    reloadButton:SetText("Reload UI")

    -- Enable dragging
    reloadButton:SetMovable(true)
    reloadButton:EnableMouse(true)
    reloadButton:RegisterForDrag("LeftButton")

    reloadButton:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)

    reloadButton:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)

    -- Add click functionality
    reloadButton:SetScript("OnClick", function()
        ReloadUI()
    end)
end

-- Function to show the reload button
function ReloadButton_Show()
    if not reloadButton then
        CreateMovableReloadUIButton()
    end
    reloadButton:Show()
end

-- Function to hide the reload button
function ReloadButton_Hide()
    if reloadButton then
        reloadButton:Hide()
    end
end
