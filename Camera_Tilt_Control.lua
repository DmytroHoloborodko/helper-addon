local cameraDynamicPitchEnabled = true
-- Controls the angle of the tilt. (0.01 - 0.99)
local cameraDynamicPitchBasePad = 0.4
-- Same, but only affects Dragonriding. (0.01 - 0.99)
local cameraDynamicPitchBasePadFlying = 0.7
-- This setting dynamically reduces the effect of your tilt setting as you move the camera towards a Top-Down view. 
-- If you want your character to be centered when you look from above - set this to 0 or something very low. (0 - 1)
local cameraDynamicPitchBasePadDownScale = 0

UIParent:UnregisterEvent("EXPERIMENTAL_CVAR_CONFIRMATION_NEEDED")

if cameraDynamicPitchEnabled then
    SetCVar("CameraKeepCharacterCentered", false)
end
SetCVar("test_cameraDynamicPitch", cameraDynamicPitchEnabled)
SetCVar("test_cameraDynamicPitchBaseFovPad", cameraDynamicPitchBasePad)
SetCVar("test_cameraDynamicPitchBaseFovPadFlying", cameraDynamicPitchBasePadFlying)
SetCVar("test_cameraDynamicPitchBaseFovPadDownScale", cameraDynamicPitchBasePadDownScale)
