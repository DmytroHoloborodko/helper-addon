function EnableRightClickLock()
    if HelperSavedVars.lockRightClick then
        -- First script to enable MouseLook with button press
        local f1 = CreateFrame("button", "mlook")
        f1:RegisterForClicks("AnyDown", "AnyUp")
        f1:SetScript("OnClick", function(s, b, d)
            if d then
                MouselookStart()
            else
                MouselookStop()
            end
        end)
        SecureStateDriverManager:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

        -- Second script to bind the right-click to MouseLook based on mouseover unit state
        local f2 = CreateFrame("frame", nil, nil, "SecureHandlerStateTemplate")
        RegisterStateDriver(f2, "mov", "[@mouseover,exists]1;0")
        f2:SetAttribute("_onstate-mov",
            "if newstate==1 then self:SetBindingClick(1,'BUTTON2','mlook') else self:ClearBindings() end")
    end
end
