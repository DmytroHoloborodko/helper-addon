-- Create a table to store saved variables
HelperSavedVars = HelperSavedVars or {}

local function CreateSettingsFrame()
    -- Create the main settings frame
    local settingsFrame = CreateFrame("Frame", "HelperSettingsFrame", UIParent, "BasicFrameTemplateWithInset")
    settingsFrame:SetSize(300, 150) -- Adjusted size for just the input field
    settingsFrame:SetPoint("CENTER", UIParent, "CENTER") -- Center on the screen
    settingsFrame:Hide() -- Hide by default

    -- Make the frame movable
    settingsFrame:SetMovable(true)
    settingsFrame:EnableMouse(true)
    settingsFrame:RegisterForDrag("LeftButton") -- Listen for the left mouse button to drag

    -- Start dragging when the mouse is down
    settingsFrame:SetScript("OnMouseDown", function(self)
        self:StartMoving()
    end)

    -- Stop dragging when the mouse is released
    settingsFrame:SetScript("OnMouseUp", function(self)
        self:StopMovingOrSizing()
        -- Save the new position to SavedVariables
        -- local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
        -- MyAddonSavedVars.framePosition = {point, relativeTo, relativePoint, xOfs, yOfs}
    end)

    -- Frame title
    settingsFrame.title = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    settingsFrame.title:SetPoint("TOP", 0, -10)
    settingsFrame.title:SetText("Helper Settings")

    -- Add a label for the number input field
    local inputLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    inputLabel:SetPoint("TOPLEFT", 10, -30)
    inputLabel:SetText("Max Sell Item Level:")

    -- Create an input field (EditBox) for the user to enter a number
    local inputBox = CreateFrame("EditBox", "MyAddonInputBox", settingsFrame, "InputBoxTemplate")
    inputBox:SetPoint("RIGHT", inputLabel, "RIGHT", 60, 0)
    inputBox:SetSize(40, 30)
    inputBox:SetMaxLetters(5)
    inputBox:SetNumeric(true) -- Only numeric input
    inputBox:SetJustifyH("CENTER")
    inputBox:SetText(HelperSavedVars.maxSellItemLevel or "50") -- Default to 50 if not set
    inputBox:SetAutoFocus(false)

    inputBox:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText())
        if value then
            HelperSavedVars.maxSellItemLevel = value
            print("Max Sell Item Level set to: " .. value)
        end
        self:ClearFocus() -- Close the input box
    end)

    -- Label for checkbox
    local checkboxLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    checkboxLabel:SetPoint("BOTTOM", inputLabel, "BOTTOM", 0, -30)
    checkboxLabel:SetText("Show Reload Button")

    -- Add a checkbox to enable/disable reload button
    local reloadCheckbox = CreateFrame("CheckButton", "HelperReloadCheckbox", settingsFrame,
        "ChatConfigCheckButtonTemplate")
    reloadCheckbox:SetPoint("RIGHT", checkboxLabel, "RIGHT", 50, 0)
    reloadCheckbox:SetSize(24, 24)
    reloadCheckbox:SetChecked(HelperSavedVars.showReloadButton or false) -- Default to false if not set

    -- When the checkbox is clicked, save the state to SavedVariables
    reloadCheckbox:SetScript("OnClick", function(self)
        HelperSavedVars.showReloadButton = self:GetChecked() -- Save to SavedVariables
        if HelperSavedVars.showReloadButton then
            ReloadButton_Show() -- Show reload button (from another file)
        else
            ReloadButton_Hide() -- Hide reload button (from another file)
        end
    end)

    return settingsFrame
end

-- Toggle the settings frame when the Addon Compartment button is clicked
local function OpenSettingsFrame()
    if HelperSettingsFrame and HelperSettingsFrame:IsShown() then
        HelperSettingsFrame:Hide()
    else
        HelperSettingsFrame:Show()
    end
end

if AddonCompartmentFrame then
    AddonCompartmentFrame:RegisterAddon({
        text = "Local Helper",
        icon = "Interface\\Icons\\INV_Misc_QuestionMark",
        notCheckable = true,
        func = OpenSettingsFrame -- Function called when clicked
    })
end

-- Ensure that SavedVariables are loaded before setting the input box value
local function OnLogin()
    CreateSettingsFrame()
    CreateMovableReloadUIButton()
end

-- Register the PLAYER_LOGIN event to ensure SavedVariables are available
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", OnLogin)
