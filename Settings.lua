-- Create a table to store saved variables
HelperSavedVars = HelperSavedVars or {}

local addonName, addon = ...

function CreateSettingsFrame()
    local category = Settings.RegisterVerticalLayoutCategory(addonName)

    do
        local name = "Enable reload button"
        local variableKey = "showReloadButton"
        local variable = addonName .. "_" .. variableKey
        local variableTbl = HelperSavedVars
        local defaultValue = HelperSavedVars.showReloadButton or false

        local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue),
            name, defaultValue)

        setting:SetValueChangedCallback(function(setting, value)
            EnableReloadUIButton(value)
        end)

        local tooltip = ""
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local name = "Lock right click"
        local variableKey = "lockRightClick"
        local variable = addonName .. "_" .. variableKey
        local variableTbl = HelperSavedVars
        local defaultValue = HelperSavedVars.lockRightClick or true

        local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue),
            name, defaultValue)

        local tooltip = ""
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local name = "Summon pet"
        local variableKey = "summonPet"
        local variable = addonName .. "_" .. variableKey
        local variableTbl = HelperSavedVars
        local defaultValue = HelperSavedVars.summonPet or true

        local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue),
            name, defaultValue)

        local tooltip = ""
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local name = "Show menu"
        local variableKey = "showMenu"
        local variable = addonName .. "_" .. variableKey
        local variableTbl = HelperSavedVars
        local defaultValue = HelperSavedVars.showMenu or false

        local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, variableTbl, type(defaultValue),
            name, defaultValue)

        setting:SetValueChangedCallback(function(setting, value)
            EnableMenuToggle(value)
        end)

        local tooltip = ""
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local name = "Item Level Threshold"
        local variable = addonName .. "_ItemLevelThreshold"
        local defaultValue = 500
        local minValue = 500
        local maxValue = 700
        local step = 10

        local function GetValue()
            return HelperSavedVars.maxSellItemLevel or defaultValue
        end

        local function SetValue(value)
            HelperSavedVars.maxSellItemLevel = value
        end

        local setting = Settings.RegisterProxySetting(category, variable, type(defaultValue), name, defaultValue,
            GetValue, SetValue)
        local tooltip = "Items below this level will be sold"
        local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
        Settings.CreateSlider(category, setting, options, tooltip)
    end

    -- Add filled category to Interface Options
    Settings.RegisterAddOnCategory(category)

end
