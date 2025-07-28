local SUNNY = "BattlePet-0-00000FFA91B7"

function EnablePetSummon()
    if HelperSavedVars.summonPet then
        local petListener = CreateFrame("Frame")
        petListener:RegisterEvent("PLAYER_ENTERING_WORLD")
        petListener:SetScript("OnEvent", function()
            C_Timer.After(1, function()
                if IsFlying() then
                    return
                end

                local summonedID = C_PetJournal.GetSummonedPetGUID()
                if summonedID ~= SUNNY then
                    C_PetJournal.SummonPetByGUID(SUNNY)
                end
            end)
        end)
    end
end
