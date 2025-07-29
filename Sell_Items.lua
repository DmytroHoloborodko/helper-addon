local ITEM_QUALITY_THRESHOLD = 5 -- Legendary
local ALLOWED_ITEM_TYPES = {
    ["Armor"] = true,
    ["Weapon"] = true
}

-- Function to format gold, silver, and copper
local function FormatMoney(amount)
    local gold = math.floor(amount / 10000)
    local silver = math.floor((amount % 10000) / 100)
    local copper = amount % 100

    local goldText = gold > 0 and ("|cffffd700" .. gold .. "g|r ") or ""
    local silverText = silver > 0 and ("|cffc7c7cf" .. silver .. "s|r ") or ""
    local copperText = copper > 0 and ("|cffeda55f" .. copper .. "c|r") or ""

    return goldText .. silverText .. copperText
end

local function CreateSellItemsButton()
    local vendorButton = CreateFrame("Button", "SellItemsButton", MerchantFrame, "UIPanelButtonTemplate")

    vendorButton:SetSize(100, 30) -- Width, Height
    vendorButton:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 60, -27) -- Position relative to vendor frame
    vendorButton:SetText("Sell items")

    vendorButton:SetScript("OnClick", function(self, button)
        local maxItemLevel = HelperSavedVars.maxSellItemLevel or -1
        local totalSellPrice = 0

        print("|cffffff00Sell items below item level " .. maxItemLevel .. ":|r") -- Yellow text

        for bag = 0, 3 do
            for slot = 1, C_Container.GetContainerNumSlots(bag) do
                local itemLink = C_Container.GetContainerItemLink(bag, slot)
                if itemLink then
                    local itemQuality = select(3, GetItemInfo(itemLink)) or ITEM_QUALITY_THRESHOLD
                    local itemLevel = select(4, GetItemInfo(itemLink)) or maxItemLevel
                    local itemType = select(6, GetItemInfo(itemLink)) or ""
                    local itemPrice = select(11, GetItemInfo(itemLink)) or 0

                    if ALLOWED_ITEM_TYPES[itemType] 
                        and itemQuality < ITEM_QUALITY_THRESHOLD 
                        and itemLevel < maxItemLevel 
                        and itemPrice > 1 then
                            totalSellPrice = totalSellPrice + itemPrice
                            C_Container.UseContainerItem(bag, slot) -- Sell the item
                            print(itemLink .. " |cffaaaaaa(iLvl " .. itemLevel .. ")|r")
                    end
                end
            end
        end

        if totalSellPrice > 0 then
            print("|cffffff00Total sell price of eligible items: " .. FormatMoney(totalSellPrice) .. "|r")
        end
    end)
end

function EnableSellItemsButton(show)
    if show then
        -- Hook into the vendor frame when it's opened
        local eventFrame = CreateFrame("Frame")
        eventFrame:RegisterEvent("MERCHANT_SHOW")
        eventFrame:SetScript("OnEvent", function()
            -- Prevent duplicate buttons
            if not SellItemsButton then
                CreateSellItemsButton()
            end
        end)
    end
end
