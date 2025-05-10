local SUNNY = "BattlePet-0-00000FFA91B7"
local EXCLUDED_CLASSES = {
    DEMONHUNTER = true
}

local function IsExcludedClass()
    local _, class = UnitClass("player")
    return EXCLUDED_CLASSES[class] or false
end

local function summonPet(petGUID)
    local summonedID = C_PetJournal.GetSummonedPetGUID()
    if summonedID ~= SUNNY then
        C_PetJournal.SummonPetByGUID(petGUID)
    end
end

local PetListener = CreateFrame("Frame")

PetListener:RegisterEvent("PLAYER_ENTERING_WORLD")
PetListener:RegisterEvent("CHALLENGE_MODE_START")

PetListener:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        if not IsExcludedClass() and IsInInstance() then
            summonPet(SUNNY)
        end
    elseif event == "CHALLENGE_MODE_START" then
        C_Timer.After(1, function()
            summonPet(SUNNY)
        end)
    end
end)
