if select(2, UnitClass("player")) == "ROGUE" then
	local netherbladeSet = {29044, 29045, 29046, 29047, 29048}
	local sliceAndDiceGlyph = 56810 -- http://www.wowhead.com/?spell=56810
	local sliceAndDiceDuration = function()
		local maxValue = 21
	
		-- Glyph
		if evl_SliceDice:hasGlyph(sliceAndDiceGlyph) then
			maxValue = maxValue + 3 
		end
	
		-- Netherblade
		local netherbladeCount = evl_SliceDice:getItemSetCount(netherbladeSet)
		if netherbladeCount > 1 then
			maxValue = maxValue + 3
		end
	
		-- Talent
		local rank = evl_SliceDice:getTalentRank(2, 4)
		maxValue = maxValue + (maxValue * (rank * 0.25))
	
		return maxValue
	end
	
	local ruptureGlyph = 56801 -- http://www.wowhead.com/?spell=56801
	local ruptureDuration = function()
		local maxValue = 16

		-- Glyph
		if evl_SliceDice:hasGlyph(ruptureGlyph) then 
			maxValue = maxValue + 4
		end

		-- Talent
		local rank = evl_SliceDice:getTalentRank(1, 5)
		maxValue = maxValue + (maxValue * (rank * 0.15))

		return maxValue
	end
	
	-- Slice and Dice
	local sliceAndDiceBar = evl_SliceDice:CreateBar("player", "Slice and Dice", sliceAndDiceDuration, 19)
	sliceAndDiceBar:SetStatusBarTexture("Interface\\AddOns\\evl_SliceDice\\media\\HalT")
	
	-- Rupture
	local ruptureBar = evl_SliceDice:CreateBar("target", "Rupture", ruptureDuration, 6)
	ruptureBar.isDebuff = true
	ruptureBar.colors = {{200/255, 0/255, 0/255}}
	ruptureBar.label:Hide()

	-- Hunger For Blood
	local hungerDuration = 60
	local hungerBar = evl_SliceDice:CreateBar("player", "Hunger For Blood", hungerDuration, 6)
	hungerBar.colors = {{200/255, 200/255, 0/255}}
	hungerBar.label:Hide()
end