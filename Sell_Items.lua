local ITEM_QUALITY_THRESHOLD = 5 -- Legendary

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

local function CreateSellVendorButton()
    local vendorButton = CreateFrame("Button", "SellVendorButton", MerchantFrame, "UIPanelButtonTemplate")

    vendorButton:SetSize(100, 30)  -- Width, Height
    vendorButton:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 60, -27) -- Position relative to vendor frame
    vendorButton:SetText("Sell items")

    local function SellLowItemLevelItems()
		local maxItemLevel = HelperSavedVars.maxSellItemLevel or -1
		
        print("|cffffff00Sell items below item level " .. maxItemLevel .. ":|r") -- Yellow text
		local totalSellPrice = 0

        for bag = 0, 3 do
            for slot = 1, C_Container.GetContainerNumSlots(bag) do
                local itemLink = C_Container.GetContainerItemLink(bag, slot)
                if itemLink then					
					local itemQuality = select(3, GetItemInfo(itemLink))
					local itemLevel = select(4, GetItemInfo(itemLink))
					local itemPrice = select(11, GetItemInfo(itemLink))
					
                    if  itemQuality < ITEM_QUALITY_THRESHOLD and itemLevel < maxItemLevel and itemPrice > 1 then
						totalSellPrice = totalSellPrice + itemPrice
                        print(itemLink .. " |cffaaaaaa(iLvl " .. itemLevel .. ")|r")
						C_Container.UseContainerItem(bag, slot) -- Sell the item
                    end
                end
            end
        end
		
		if totalSellPrice > 0 then
			print("|cffffff00Total sell price of eligible items: " .. FormatMoney(totalSellPrice) .. "|r")
		end
    end

    -- Add click events for left and right mouse buttons
    vendorButton:SetScript("OnClick", function(self, button)
        SellLowItemLevelItems()
    end)
end

-- Hook into the vendor frame when it's opened
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("MERCHANT_SHOW")
eventFrame:SetScript("OnEvent", function()
    if not SellVendorButton then -- Prevent duplicate buttons
        CreateSellVendorButton()
    end
end)
