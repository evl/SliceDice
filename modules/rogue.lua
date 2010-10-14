local addonName, addon = ...

if addon.playerClass == "ROGUE" then
	local netherbladeSet = {29044, 29045, 29046, 29047, 29048}
	local sliceAndDiceGlyph = 56810 -- http://www.wowhead.com/?spell=56810
	local sliceAndDiceDuration = function()
		local maxValue = 21
	
		-- Glyph
		if addon:HasGlyph(sliceAndDiceGlyph) then
			maxValue = maxValue + 3 
		end
	
		-- Netherblade
		local netherbladeCount = addon:GetItemSetCount(netherbladeSet)
		if netherbladeCount > 1 then
			maxValue = maxValue + 3
		end
	
		-- Talent
		local rank = addon:GetTalentRank(2, 4)
		maxValue = maxValue + (maxValue * (rank * 0.25))
	
		return maxValue
	end
	
	local ruptureGlyph = 56801 -- http://www.wowhead.com/?spell=56801
	local backstabGlyph = 56800 -- http://www.wowhead.com/?spell=56800
	local ruptureDuration = function()
		local maxValue = 16

		-- Glyph of Rupture
		if addon:HasGlyph(ruptureGlyph) then 
			maxValue = maxValue + 4
		end
		
		-- Glyph of Backstab
		if addon:HasGlyph(backstabGlyph) then 
			maxValue = maxValue + 6
		end
		
		-- Talent
		local rank = addon:GetTalentRank(1, 5)
		maxValue = maxValue + (maxValue * (rank * 0.15))

		return maxValue
	end
	
	-- Slice and Dice
	local sliceAndDiceBar = addon:CreateBar("player", 5171, sliceAndDiceDuration, 19)

	-- Rupture
	local ruptureBar = addon:CreateBar("target", 1943, ruptureDuration, 6)
	ruptureBar.colors = {{200/255, 0/255, 0/255}}
	ruptureBar.label:Hide()
	
	-- Hunger For Blood
	local hungerDuration = 60
	local hungerBar = addon:CreateBar("player", 51662, hungerDuration, 6)
	hungerBar.colors = {{100/255, 0/255, 0/255}}
	hungerBar.label:Hide()
end